if not minetest.get_modpath("mesecons_mvps") then
	minetest.log("warning","mesecons_mvps is not installed - digilines movestone will not be available")
	return
end

local function abortmovement(pos)
	local meta = minetest.get_meta(pos)
	local state = meta:get_string("state")
	if state ~= "" then state = minetest.deserialize(state) else state = {} end
	state.targetx = pos.x
	state.targety = pos.y
	state.targetz = pos.z
	state.moveaxis = nil
	meta:set_string("state",minetest.serialize(state))
end

local function checkprotection(pos,player)
	if not player then player = "" end
	if type(player) ~= "string" then player = player:get_player_name() end
	if minetest.is_protected(pos,player) and not minetest.check_player_privs(player,{protection_bypass=true}) then
		minetest.record_protection_violation(pos,player)
		return false
	end
	return true
end

local function move(pos,dir,state)
	local newpos = vector.add(pos,dir)
	local stack = mesecon.mvps_get_stack(pos,dir,state.maxstack,state.sticky and state.allsticky)
	if not stack then
		abortmovement(pos)
		return false
	end
	for _,i in pairs(stack) do
		if not checkprotection(i.pos,state.player) then
			abortmovement(pos)
			return false
		end
	end
	local success,stack,oldstack = mesecon.mvps_push(pos,dir,state.maxstack)
	if not success then
		abortmovement(pos)
		return false
	end
	mesecon.mvps_process_stack(stack)
	mesecon.mvps_move_objects(pos,dir,oldstack)
	if state.sound == "mesecons" then
		minetest.sound_play("movestone",{pos = pos,max_hear_distance = 20,gain = 0.5,},true)
	end
	if not state.sticky then return true end
	local ppos = vector.add(pos,vector.multiply(dir,-1))
	local success,stack,oldstack
	if state.allsticky then
		success,stack,oldstack = mesecon.mvps_pull_all(ppos,dir,state.maxstack)
	else
		success,stack,oldstack = mesecon.mvps_pull_single(ppos,dir,state.maxstack)
	end
	if success then
		mesecon.mvps_move_objects(ppos,dir,oldstack,-1)
	else
		abortmovement(pos)
		return false
	end
	return true
end

local rules = {
	{x = 1, y = 0, z = 0},
	{x =-1, y = 0, z = 0},
	{x = 0, y = 1, z = 0},
	{x = 0, y =-1, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z =-1},
}

minetest.register_node("digistuff:movestone", {
	description = "Digilines Movestone",
	groups = {cracky = 3,},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
		local initialstate = {
			targetx = pos.x,
			targety = pos.y,
			targetz = pos.z,
			sound = "mesecons",
			maxstack = 0,
			allsticky = false,
		}
		meta:set_int("active",0)
		meta:set_string("state",minetest.serialize(initialstate))
	end,
	after_place_node = function(pos,player)
		if not player then return end
		local meta = minetest.get_meta(pos)
		meta:set_string("owner",player:get_player_name())
	end,
	tiles = {
		"jeija_movestone_side.png",
	},
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
	end,
	on_timer = function(pos)
		local meta = minetest.get_meta(pos)
		if meta:get_int("active") < 1 then return end
		local state = meta:get_string("state")
		local newpos = pos
		if state ~= "" then state = minetest.deserialize(state) else return end
		if state.moveaxis == "x" then
			local dir = vector.new(state.targetx > pos.x and 1 or -1,0,0)
			move(pos,dir,state)
			newpos = vector.add(pos,dir)
			if newpos.x == state.targetx then
				if newpos.y ~= state.targety then
					state.moveaxis = "y"
				elseif newpos.z ~= state.targetz then
					state.moveaxis = "z"
				else
					state.moveaxis = nil
				end
			end
		elseif state.moveaxis == "y" then
			local dir = vector.new(0,state.targety > pos.y and 1 or -1,0)
			move(pos,dir,state)
			newpos = vector.add(pos,dir)
			if newpos.y == state.targety then
				if newpos.z ~= state.targetz then
					state.moveaxis = "z"
				else
					state.moveaxis = nil
				end
			end
		elseif state.moveaxis == "z" then
			local dir = vector.new(0,0,state.targetz > pos.z and 1 or -1)
			move(pos,dir,state)
			newpos = vector.add(pos,dir)
			if newpos.z == state.targetz then
				state.moveaxis = nil
			end
		end
		local newmeta = minetest.get_meta(newpos)
		newmeta:set_int("active",state.moveaxis and 1 or 0)
		newmeta:set_string("state",minetest.serialize(state))
		if state.moveaxis then
			local timer = minetest.get_node_timer(newpos)
			timer:start(0.33)
		end
	end,
	_digistuff_channelcopier_fieldname = "channel",
	digiline = {
		wire = {
			rules = rules,
		},
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
					local meta = minetest.get_meta(pos)
					local setchan = meta:get_string("channel")
					if channel ~= setchan then return end
					if type(msg) ~= "table" or not msg.command then return end
					if msg.command == "getstate" then
						local ret = {}
						local meta = minetest.get_meta(pos)
						local state = meta:get_string("state")
						if state ~= "" then state = minetest.deserialize(state) else state = {} end
						if not state then
							minetest.log("error",string.format("Invalid state information for digilines movestone at %d,%d,%d: %s",pos.x,pos.y,pos.z,meta:get_string("state")))
							return
						end
						ret.pos = pos
						ret.targetpos = vector.new(state.targetx,state.targety,state.targetz)
						ret.moveaxis = state.moveaxis
						digiline:receptor_send(pos,rules,channel,ret)
					elseif msg.command == "absmove" then
						local ret = {}
						local meta = minetest.get_meta(pos)
						local state = meta:get_string("state")
						if state ~= "" then state = minetest.deserialize(state) else state = {} end
						if not state then
							minetest.log("error",string.format("Invalid state information for digilines movestone at %d,%d,%d: %s",pos.x,pos.y,pos.z,meta:get_string("state")))
							return
						end
						if type(msg.sound) == "string" then state.sound = msg.sound end
						if type(msg.x) ~= "number" then msg.x = pos.x end
						if type(msg.y) ~= "number" then msg.y = pos.y end
						if type(msg.z) ~= "number" then msg.z = pos.z end
						msg.x = math.max(pos.x-50,math.min(pos.x+50,math.floor(msg.x)))
						msg.y = math.max(pos.y-50,math.min(pos.y+50,math.floor(msg.y)))
						msg.z = math.max(pos.z-50,math.min(pos.z+50,math.floor(msg.z)))
						local firstaxis
						if msg.x ~= pos.x then firstaxis = "x"
						elseif msg.y ~= pos.y then firstaxis = "y"
						elseif msg.z ~= pos.z then firstaxis = "z" end
						if firstaxis then
							state.targetx = msg.x
							state.targety = msg.y
							state.targetz = msg.z
							state.moveaxis = firstaxis
							if msg.sticky then
								state.sticky = true
							elseif msg.sticky == false then
								state.sticky = false
							end
							if msg.allsticky then
								state.allsticky = true
							elseif msg.allsticky == false then
								state.allsticky = false
							end
							if type(msg.maxstack) == "number" and msg.maxstack >= 0 and msg.maxstack <= 50 then
								state.maxstack = math.floor(msg.maxstack)
							end
							meta:set_string("state",minetest.serialize(state))
							meta:set_int("active",1)
							minetest.get_node_timer(pos):start(0.1)
						end
					elseif msg.command == "relmove" then
						local ret = {}
						local meta = minetest.get_meta(pos)
						local state = meta:get_string("state")
						if state ~= "" then state = minetest.deserialize(state) else state = {} end
						if not state then
							minetest.log("error",string.format("Invalid state information for digilines movestone at %d,%d,%d: %s",pos.x,pos.y,pos.z,meta:get_string("state")))
							return
						end
						if type(msg.sound) == "string" then state.sound = msg.sound end
						if type(msg.x) ~= "number" then msg.x = 0 end
						if type(msg.y) ~= "number" then msg.y = 0 end
						if type(msg.z) ~= "number" then msg.z = 0 end
						msg.x = pos.x+math.max(0,math.min(50,math.floor(msg.x)))
						msg.y = pos.y+math.max(0,math.min(50,math.floor(msg.y)))
						msg.z = pos.z+math.max(0,math.min(50,math.floor(msg.z)))
						local firstaxis
						if msg.x ~= pos.x then firstaxis = "x"
						elseif msg.y ~= pos.y then firstaxis = "y"
						elseif msg.z ~= pos.z then firstaxis = "z" end
						if firstaxis then
							state.targetx = msg.x
							state.targety = msg.y
							state.targetz = msg.z
							state.moveaxis = firstaxis
							if msg.sticky then
								state.sticky = true
							elseif msg.sticky == false then
								state.sticky = false
							end
							if msg.allsticky then
								state.allsticky = true
							elseif msg.allsticky == false then
								state.allsticky = false
							end
							if type(msg.maxstack) == "number" and msg.maxstack >= 0 and msg.maxstack <= 50 then
								state.maxstack = math.floor(msg.maxstack)
							end
							meta:set_string("state",minetest.serialize(state))
							meta:set_int("active",1)
							minetest.get_node_timer(pos):start(0.1)
						end
					end
				end
		},
	},
})
