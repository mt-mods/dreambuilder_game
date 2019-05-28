digistuff.button_turnoff = function (pos)
	local node = minetest.get_node(pos)
	minetest.swap_node(pos, {name = "digistuff:button_off", param2=node.param2})
	if minetest.get_modpath("mesecons") then minetest.sound_play("mesecons_button_pop", {pos=pos}) end
end

digistuff.button_get_rules = function(node)
	local rules = {
		{x =  1,y =  0,z =  0},
		{x = -1,y =  0,z =  0},
		{x =  0,y =  1,z =  0},
		{x =  0,y = -1,z =  0},
		{x =  0,y =  0,z =  1},
		{x =  0,y =  0,z = -1},
		{x =  0,y =  0,z =  2},
	}
	local dir = minetest.facedir_to_dir(node.param2)
	rules = digistuff.rotate_rules(rules,dir)
	return rules
end

minetest.register_node("digistuff:button", {
	drawtype = "nodebox",
	tiles = {
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_off.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_wallmounted = true,
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
	type = "fixed",
		fixed = { -6/16, -6/16, 5/16, 6/16, 6/16, 8/16 }
	},
	node_box = {
		type = "fixed",
		fixed = {
		{ -6/16, -6/16, 6/16, 6/16, 6/16, 8/16 },	-- the thin plate behind the button
		{ -4/16, -2/16, 4/16, 4/16, 2/16, 6/16 }	-- the button itself
	}
	},
	digiline = 
	{
		receptor = {},
		wire = {
			rules = digistuff.button_get_rules,
		},
	},
	groups = {dig_immediate = 2,digiline_receiver = 1,},
	description = "Digilines Button",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","size[8,4;]field[1,1;6,2;channel;Channel;${channel}]field[1,2;6,2;msg;Message;${msg}]button_exit[2.25,3;3,1;submit;Save]")
	end,
	after_place_node = digistuff.place_receiver,
	after_destruct = digistuff.remove_receiver,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		if fields.channel and fields.channel ~= "" then
			meta:set_string("channel",fields.channel)
			meta:set_string("msg",fields.msg)
			meta:set_string("formspec","")
			minetest.swap_node(pos, {name = "digistuff:button_off", param2=minetest.get_node(pos).param2})
		else
			minetest.chat_send_player(sender:get_player_name(),"Please set a channel!")
		end
	end,
	sounds = default and default.node_sound_stone_defaults(),
})

minetest.register_node("digistuff:button_off", {
	drawtype = "nodebox",
	tiles = {
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_off.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_wallmounted = true,
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
	type = "fixed",
		fixed = { -6/16, -6/16, 5/16, 6/16, 6/16, 8/16 }
	},
	node_box = {
		type = "fixed",
		fixed = {
		{ -6/16, -6/16, 6/16, 6/16, 6/16, 8/16 },	-- the thin plate behind the button
		{ -4/16, -2/16, 4/16, 4/16, 2/16, 6/16 }	-- the button itself
	}
	},
	digiline = 
	{
		receptor = {},
		wire = {
			rules = digistuff.button_get_rules,
		},
	},
	groups = {dig_immediate = 2,not_in_creative_inventory = 1,digiline_receiver = 1,},
	drop = "digistuff:button",
	after_destruct = digistuff.remove_receiver,
	description = "Digilines Button (off state - you hacker you!)",
	on_rightclick = function (pos, node, clicker)
		local meta = minetest.get_meta(pos)
		digiline:receptor_send(pos, digistuff.button_get_rules(node), meta:get_string("channel"), meta:get_string("msg"))
		minetest.swap_node(pos, {name = "digistuff:button_on", param2=node.param2})
		if minetest.get_modpath("mesecons") then minetest.sound_play("mesecons_button_push", {pos=pos}) end
		minetest.get_node_timer(pos):start(0.25)
	end,
	sounds = default and default.node_sound_stone_defaults(),
})

minetest.register_node("digistuff:button_on", {
	drawtype = "nodebox",
	tiles = {
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_on.png"
		},
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_wallmounted = true,
	walkable = false,
	light_source = 7,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = { -6/16, -6/16, 5/16, 6/16, 6/16, 8/16 }
	},
	node_box = {
	type = "fixed",
	fixed = {
		{ -6/16, -6/16,  6/16, 6/16, 6/16, 8/16 },
		{ -4/16, -2/16, 11/32, 4/16, 2/16, 6/16 }
	}
    	},
	digiline = 
	{
		receptor = {},
		wire = {
			rules = digistuff.button_get_rules,
		},
	},
	on_timer = digistuff.button_turnoff,
	groups = {dig_immediate = 2,not_in_creative_inventory = 1,digiline_receiver = 1,},
	drop = 'digistuff:button',
	after_destruct = digistuff.remove_receiver,
	on_rightclick = function (pos, node, clicker)
		local meta = minetest.get_meta(pos)
		digiline:receptor_send(pos, digistuff.button_get_rules(node), meta:get_string("channel"), meta:get_string("msg"))
		if minetest.get_modpath("mesecons") then minetest.sound_play("mesecons_button_push", {pos=pos}) end
		minetest.get_node_timer(pos):start(0.25)
	end,
	description = "Digilines Button (on state - you hacker you!)",
	sounds = default and default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "digistuff:button",
	recipe = {
		{"mesecons_button:button_off"},
		{"mesecons_luacontroller:luacontroller0000"},
		{"digilines:wire_std_00000000"}
	}
})
