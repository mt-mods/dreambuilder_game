local digiline_rules = {
	{x =  1,y =  0,z =  0},
	{x = -1,y =  0,z =  0},
	{x =  0,y =  0,z =  1},
	{x =  0,y =  0,z = -1},
	{x =  0,y = -1,z =  0},
	{x =  1,y = -1,z =  0},
	{x = -1,y = -1,z =  0},
	{x =  0,y = -1,z =  1},
	{x =  0,y = -1,z = -1},
}

local players_on_controller = {}

local last_seen_inputs = {}

local function process_inputs(pos)
	local meta = minetest.get_meta(pos)
	local hash = minetest.hash_node_position(pos)
	if minetest.get_node(pos).name ~= "digistuff:controller_programmed" then
	local player = minetest.get_player_by_name(players_on_controller[hash])
		if player then
			player:set_physics_override({speed = 1,jump = 1,})
			player:set_pos(vector.add(pos,vector.new(0.25,0,0.25)))
			minetest.chat_send_player(players_on_controller[hash],"You are now free to move.")
		end
		last_seen_inputs[players_on_controller[hash]] = nil
		players_on_controller[hash] = nil
		return
	end
	local name = players_on_controller[hash]
	local player = minetest.get_player_by_name(name)
	if not player then
		digiline:receptor_send(pos,digiline_rules,meta:get_string("channel"),"player_left")
		minetest.get_meta(pos):set_string("infotext","Digilines Game Controller Ready\n(right-click to use)")
		players_on_controller[hash] = nil
		return
	end
	local distance = vector.distance(pos,player:get_pos())
	if distance > 1 then
		digiline:receptor_send(pos,digiline_rules,meta:get_string("channel"),"player_left")
		minetest.get_meta(pos):set_string("infotext","Digilines Game Controller Ready\n(right-click to use)")
		player:set_physics_override({speed = 1,jump = 1,})
		players_on_controller[hash] = nil
		return
	end
	local inputs = player:get_player_control()
	inputs.pitch = player:get_look_vertical()
	inputs.yaw = player:get_look_horizontal()
	local send_needed = false
	if not last_seen_inputs[name] then
		send_needed = true
	else
		for k,v in pairs(inputs) do
			if v ~= last_seen_inputs[name][k] then
				send_needed = true
				break
			end
		end
	end
	last_seen_inputs[name] = inputs
	if send_needed then
		local channel = meta:get_string("channel")
		local inputs = table.copy(inputs)
		inputs.look_vector = player:get_look_dir()
		inputs.name = name
		digiline:receptor_send(pos,digiline_rules,channel,inputs)
	end
end

local function release_player(pos)
	local hash = minetest.hash_node_position(pos)
	local player = minetest.get_player_by_name(players_on_controller[hash])
	if player then
		player:set_physics_override({speed = 1,jump = 1,})
		player:set_pos(vector.add(pos,vector.new(0.25,0,0.25)))
		minetest.chat_send_player(players_on_controller[hash],"You are now free to move.")
	end
	local meta = minetest.get_meta(pos)
	meta:set_string("infotext","Digilines Game Controller Ready\n(right-click to use)")
	last_seen_inputs[players_on_controller[hash]] = nil
	players_on_controller[hash] = nil
	digiline:receptor_send(pos,digiline_rules,meta:get_string("channel"),"player_left")
end

local function trap_player(pos,player)
	local hash = minetest.hash_node_position(pos)
	local oldname = players_on_controller[hash]
	local newname = player:get_player_name()
	if oldname and minetest.get_player_by_name(oldname) then
			minetest.chat_send_player(player:get_player_name(),"Controller is already occupied by "..oldname)
			return
	else
		players_on_controller[hash] = newname
		player:set_pos(vector.add(pos,vector.new(0,-0.4,0)))
		player:set_physics_override({speed = 0,jump = 0,})
		minetest.chat_send_player(newname,"You are now using a digilines game controller. Right-click the controller again to be released.")
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext","Digilines Game Controller\nIn use by: "..newname)
		process_inputs(pos)
	end
end

local function toggle_trap_player(pos,player)
	if players_on_controller[minetest.hash_node_position(pos)] then
		release_player(pos)
	else
		trap_player(pos,player)
	end
end

minetest.register_node("digistuff:controller", {
	description = "Digilines Game Controller",
	tiles = {
		"digistuff_controller_top.png",
		"digistuff_controller_sides.png",
	},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.45,0.5},
			}
	},
	_digistuff_channelcopier_fieldname = "channel",
	_digistuff_channelcopier_onset = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","")
		meta:set_string("infotext","Digilines Game Controller Ready\n(right-click to use)")
		minetest.swap_node(pos,{name = "digistuff:controller_programmed",})
	end,
	groups = {cracky = 1,},
	is_ground_content = false,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then
			meta:set_string("channel",fields.channel)
			meta:set_string("formspec","")
			meta:set_string("infotext","Digilines Game Controller Ready\n(right-click to use)")
			minetest.swap_node(pos,{name = "digistuff:controller_programmed",})
		end
	end,
	digiline = {
		receptor = {},
		wire = {
			rules = digiline_rules,
		},
	},
})

minetest.register_node("digistuff:controller_programmed", {
	description = "Digilines Game Controller (programmed state - you hacker you!)",
	drop = "digistuff:controller",
	tiles = {
		"digistuff_controller_top.png",
		"digistuff_controller_sides.png",
	},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.45,0.5},
			}
	},
	_digistuff_channelcopier_fieldname = "channel",
	groups = {cracky = 1,not_in_creative_inventory = 1,},
	is_ground_content = false,
	on_rightclick = function(pos,_,clicker)
		if clicker and clicker:get_player_name() then
			toggle_trap_player(pos,clicker)
		end
	end,
	_digistuff_channelcopier_fieldname = "channel",
	digiline = {
		receptor = {},
		wire = {
			rules = digiline_rules,
		},
		effector = {
			action = function(pos,node,channel,msg)
				local setchannel = minetest.get_meta(pos):get_string("channel")
				if channel ~= setchannel then return end
				if msg == "release" then
					local hash = minetest.hash_node_position(pos)
					if players_on_controller[hash] then
						release_player(pos)
					end
				end
			end,
		},
	},
})

local acc_dtime = 0

minetest.register_globalstep(function(dtime)
	acc_dtime = acc_dtime + dtime
	if acc_dtime < 0.2 then return end
	acc_dtime = 0
	for hash in pairs(players_on_controller) do
		local pos = minetest.get_position_from_hash(hash)
		process_inputs(pos)
	end
end)

minetest.register_lbm({
	name = "digistuff:reset_controllers",
	label = "Reset game controllers to idle",
	nodenames = {"digistuff:controller_programmed"},
	run_at_every_load = true,
	action = function(pos)
		if not players_on_controller[minetest.hash_node_position(pos)] then
			local meta = minetest.get_meta(pos)
			digiline:receptor_send(pos,digiline_rules,meta:get_string("channel"),"player_left")
			meta:set_string("infotext","Digilines Game Controller Ready\n(right-click to use)")
		end
	end,
})

minetest.register_craft({
	output = "digistuff:controller",
	recipe = {
		{"","digistuff:button","",},
		{"digistuff:button","group:wool","digistuff:button",},
		{"","digistuff:button","",},
	},
})
