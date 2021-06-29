for k,v in pairs({1, 2}) do
	-- why +6?  because table entries 1-6 are set in modern.lua :-)
	streetlights.schematics[k+6] = 
		minetest.register_schematic(string.format("schems%sstreetlight_minedot_"..v..".mts",DIR_DELIM))

	local s = (v == 1) and "" or "s"

	minetest.register_tool("simple_streetlights:spawner_minedot_"..v, {
		description = "Streetlight spawner (MineDOT-stylw, with "..v.." lamp"..s..")",
		inventory_image = "simple_streetlights_inv_minedot_"..v..".png",
		use_texture_alpha = true,
		tool_capabilities = { full_punch_interval=0.1 },
		on_place = function(itemstack, placer, pointed_thing)
			streetlights.check_and_place(itemstack, placer, pointed_thing, {
				schematic = streetlights.schematics[k+6],
				materials = {
					"streets:bigpole "..(v+5),
					"streets:bigpole_edge 2",
					"homedecor:glowlight_quarter "..v,
					(v == 2) and "streets:bigpole_tjunction 1"
				},
				protection_box = {
					omin = {x = (-2*v + 2), y = 0, z = 0},
					omax = {x = 2, y = 5, z = 0},
				}
			})
		end
	})
end

minetest.register_alias("minedot_streetlights:spawner_single", "simple_streetlights:spawner_minedot_1")
minetest.register_alias("minedot_streetlights:spawner_double", "simple_streetlights:spawner_minedot_2")
