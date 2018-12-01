if not minetest.get_modpath("mesecons_mvps") then
	minetest.log("error","mesecons_mvps is not installed - digilines piston will not be available!")
	return
end

local function extend(pos,node,max)
	local meta = minetest.get_meta(pos):to_table()
	local facedir = minetest.facedir_to_dir(node.param2)
	local actiondir = vector.multiply(facedir,-1)
	local ppos = vector.add(pos,actiondir)
	local success,stack,oldstack = mesecon.mvps_push(ppos,actiondir,max)
	if not success then return end
	minetest.sound_play("digistuff_piston_extend",{pos = pos,max_hear_distance = 20,gain = 0.6})
	minetest.swap_node(pos,{name = "digistuff:piston_ext",param2 = node.param2})
	minetest.swap_node(ppos,{name = "digistuff:piston_pusher",param2 = node.param2})
	mesecon.mvps_process_stack(stack)
	mesecon.mvps_move_objects(ppos,actiondir,oldstack)
	minetest.get_meta(pos):from_table(meta)
end

local function retract(pos,node,max,allsticky)
	local facedir = minetest.facedir_to_dir(node.param2)
	local actiondir = vector.multiply(facedir,-1)
	local ppos = vector.add(pos,actiondir)
	minetest.swap_node(pos,{name = "digistuff:piston",param2 = node.param2})
	if minetest.get_node(ppos).name == "digistuff:piston_pusher" then
		minetest.remove_node(ppos)
	end
	minetest.sound_play("digistuff_piston_retract",{pos = pos,max_hear_distance = 20,gain = 0.6})
	minetest.check_for_falling(ppos)
	if type(max) ~= "number" or max <= 0 then return end
	local pullpos = vector.add(pos,vector.multiply(actiondir,2))
	local success,stack,oldstack
	if allsticky then
		success,stack,oldstack = mesecon.mvps_pull_all(pullpos,facedir,max)
	else
		success,stack,oldstack = mesecon.mvps_pull_single(pullpos,facedir,max)
	end
	if success then
		mesecon.mvps_move_objects(pullpos,actiondir,oldstack,-1)
	end
end

minetest.register_node("digistuff:piston", {
	description = "Digilines Piston",
	groups = {cracky=3},
	paramtype2 = "facedir",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,
	tiles = {
		"digistuff_piston_sides.png^[transformR180",
		"digistuff_piston_sides.png",
		"digistuff_piston_sides.png^[transformR90",
		"digistuff_piston_sides.png^[transformR270",
		"digistuff_camera_pole.png",
		"digistuff_camera_pole.png",
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
	digiline = {
		wire = {
			rules = {
				{x = 1, y = 0, z = 0},
				{x =-1, y = 0, z = 0},
				{x = 0, y = 1, z = 0},
				{x = 0, y =-1, z = 0},
				{x = 0, y = 0, z = 1},
				{x = 0, y = 0, z =-1},
			},
		},
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
					local meta = minetest.get_meta(pos)
					local setchan = meta:get_string("channel")
					if channel ~= setchan then return end
					if msg == "extend" then
						extend(pos,node,16)
					elseif type(msg) == "table" and msg.action == "extend" then
						local max = 16
						if type(msg.max) == "number" then
							max = math.max(0,math.min(16,math.floor(msg.max)))
						end
						extend(pos,node,max)
					end
				end
		},
	},
})

minetest.register_node("digistuff:piston_ext", {
	description = "Digilines Piston (extended state - you hacker you!)",
	groups = {cracky = 3,not_in_creative_inventory = 1},
	paramtype2 = "facedir",
	tiles = {
		"digistuff_piston_sides.png^[transformR180",
		"digistuff_piston_sides.png",
		"digistuff_piston_sides.png^[transformR90",
		"digistuff_piston_sides.png^[transformR270",
		"digistuff_camera_pole.png",
		"digistuff_camera_pole.png",
	},
	drop = "digistuff:piston",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.3,0.5,0.5,0.5},
				{-0.2,-0.2,-0.5,0.2,0.2,-0.3},
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-1.5,0.5,0.5,0.5},
			}
	},
	on_rotate = function() return false end,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
	end,
	after_dig_node = function(pos,node)
		local pdir = vector.multiply(minetest.facedir_to_dir(node.param2),-1)
		local ppos = vector.add(pos,pdir)
		if minetest.get_node(ppos).name == "digistuff:piston_pusher" then
			minetest.remove_node(ppos)
		end
	end,
	digiline = {
		wire = {
			rules = {
				{x = 1, y = 0, z = 0},
				{x =-1, y = 0, z = 0},
				{x = 0, y = 1, z = 0},
				{x = 0, y =-1, z = 0},
				{x = 0, y = 0, z = 1},
				{x = 0, y = 0, z =-1},
			},
		},
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
					local meta = minetest.get_meta(pos)
					local setchan = meta:get_string("channel")
					if channel ~= setchan then return end
					if msg == "retract" then
						retract(pos,node)
					elseif msg == "retract_sticky" then
						retract(pos,node,16)
					elseif type(msg) == "table" and msg.action == "retract" then
						local max = 16
						if type(msg.max) == "number" then
							max = math.max(0,math.min(16,math.floor(msg.max)))
						elseif msg.max == nil then
							max = 0
						end
						retract(pos,node,max,msg.allsticky)
					end
				end
		},
	},
})

minetest.register_node("digistuff:piston_pusher", {
	description = "Digilines Piston Pusher (you hacker you!)",
	groups = {not_in_creative_inventory=1},
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	tiles = {
		"digistuff_piston_sides.png^[transformR180",
		"digistuff_piston_sides.png",
		"digistuff_piston_sides.png^[transformR90",
		"digistuff_piston_sides.png^[transformR270",
		"digistuff_camera_pole.png",
		"digistuff_camera_pole.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.5,0.5,0.5,-0.3},
				{-0.2,-0.2,-0.3,0.2,0.2,0.5},
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{0,0,0,0,0,0},
			}
	},
	digiline = {
		wire = {
			rules = {
				{x = 1, y = 0, z = 0},
				{x =-1, y = 0, z = 0},
				{x = 0, y = 1, z = 0},
				{x = 0, y =-1, z = 0},
				{x = 0, y = 0, z = 1},
				{x = 0, y = 0, z =-1},
			},
		},
	},
})

mesecon.register_mvps_stopper("digistuff:piston_ext")
mesecon.register_mvps_stopper("digistuff:piston_pusher")
