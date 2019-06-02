minetest.register_node("digistuff:timer", {
	description = "Digilines Timer",
	groups = {cracky=3},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,
	tiles = {
		"digistuff_timer_top.png",
		"jeija_microcontroller_bottom.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png"
	},
	inventory_image = "digistuff_timer_top.png",
	drawtype = "nodebox",
	selection_box = {
		--From luacontroller
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
	},
	node_box = {
		--From Luacontroller
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, -7/16, 8/16}, -- Bottom slab
			{-5/16, -7/16, -5/16, 5/16, -6/16, 5/16}, -- Circuit board
			{-3/16, -6/16, -3/16, 3/16, -5/16, 3/16}, -- IC
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
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
		local channel = meta:get_string("channel")
		digiline:receptor_send(pos,digiline.rules.default,channel,"done")
		local loop = meta:get_int("loop") > 0
		return loop
	end,
	digiline = 
	{
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
					local meta = minetest.get_meta(pos)
					if meta:get_string("channel") ~= channel then return end
					if msg == "loop_on" then
						meta:set_int("loop",1)
					elseif msg == "loop_off" then
						meta:set_int("loop",0)
					else
						local time = tonumber(msg)
						if time and time >= 0.5 and time <= 3600 then
							local timer = minetest.get_node_timer(pos)
							timer:start(time)
						end
					end
				end
		},
	},
	
})
minetest.register_craft({
	output = "digistuff:timer 2",
	recipe = {
		{"","mesecons:wire_00000000_off","default:coal_lump"},
		{"digilines:wire_std_00000000","basic_materials:ic","mesecons:wire_00000000_off"},
		{"","mesecons:wire_00000000_off","default:paper"},
	}
})
