for i=0,14,1 do
	local mult = 255 - ((14-i)*12)
	minetest.register_node("digistuff:light_"..i, {
		drop = "digistuff:light_0",
		description = "Digilines Dimmable Light"..(i > 0 and " (on state - you hacker you!)" or ""),
		tiles = {"digistuff_light.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
					{-0.25,0.4,-0.25,0.25,0.5,0.25},
				}
		},
		groups = i > 0 and {cracky = 1, not_in_creative_inventory = 1} or {cracky = 1},
		is_ground_content = false,
		light_source = i,
		color = {r = mult,g = mult,b = mult},
		sounds = default and default.node_sound_glass_defaults(),
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
			if fields.channel then meta:set_string("channel",fields.channel) end
		end,
		digiline = {
			receptor = {},
			wire = {
				rules = {
					{x = 1,y = 0,z = 0},
					{x = -1,y = 0,z = 0},
					{x = 0,y = 0,z = 1},
					{x = 0,y = 0,z = -1},
					{x = 0,y = 1,z = 0},
					{x = 0,y = -1,z = 0},
					{x = 2,y = 0,z = 0},
					{x = -2,y = 0,z = 0},
					{x = 0,y = 0,z = 2},
					{x = 0,y = 0,z = -2},
					{x = 0,y = 2,z = 0},
					{x = 0,y = -2,z = 0},
				}
			},
			effector = {
				action = function(pos,node,channel,msg)
						local meta = minetest.get_meta(pos)
						if meta:get_string("channel") ~= channel then return end
						local value = tonumber(msg)
						if (not value) or value > 14 or value < 0 then return end
						node.name = "digistuff:light_"..math.floor(value)
						minetest.swap_node(pos,node)
					end
			},
		},
	})
end

minetest.register_craft({
	output = "digistuff:light_0",
	recipe = {
		{"digilines:wire_std_00000000","mesecons_lamp:lamp_off",},
	}
})
