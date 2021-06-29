-- streets:pole_* with morelights_modern:walllamp

minetest.register_tool("simple_streetlights:spawner_modern_walllamp", {
	description = "Streetlight spawner (streets thin pole with modern wall lamp)",
	inventory_image = "simple_streetlights_inv_pole_modern_walllamp.png",
	use_texture_alpha = true,
	tool_capabilities = { full_punch_interval=0.1 },
	on_place = function(itemstack, placer, pointed_thing)
		streetlights.check_and_place(itemstack, placer, pointed_thing, {
			base = "streets:pole_bottom",
			pole = "streets:pole_top",
			light = "morelights_modern:walllamp",
			topnodes = false,
			height = 4,
			copy_pole_fdir = true,
			node_rotation = math.pi/2, -- 90° CCW
			light_fdir = "auto",
			main_extends_base = true
		})
	end
})

local homedecor_modpath = minetest.get_modpath("homedecor_fences")

for k,v in pairs({1, 2, 4}) do
	streetlights.schematics[k] =
		minetest.register_schematic(string.format("schems%sstreetlight_parking_lot_"..v..".mts",DIR_DELIM))

	local s = (v == 1) and "" or "s"

	minetest.register_tool("simple_streetlights:spawner_modern_parking_lot_"..v, {
		description = "Streetlight spawner (parking lot light with "..v.." lamp"..s..")",
		inventory_image = "simple_streetlights_inv_parking_lot_"..v..".png",
		use_texture_alpha = true,
		tool_capabilities = { full_punch_interval=0.1 },
		on_place = function(itemstack, placer, pointed_thing)
			streetlights.check_and_place(itemstack, placer, pointed_thing, {
				schematic = streetlights.schematics[k],
				materials = {
					"morelights_modern:streetpost_d 4",
					"morelights_modern:barlight_c "..v
				},
				protection_box = {
					omin = {x =-1, y = 0, z =-1}, -- distances relative to the base node
					omax = {x = 1, y = 3, z = 1},
				}
			})
		end
	})

	streetlights.schematics[k+3] =
		minetest.register_schematic(string.format("schems%sstreetlight_parking_lot_hd_fence_"..v..".mts",DIR_DELIM))

	minetest.register_tool("simple_streetlights:spawner_modern_parking_lot_hd_fence_"..v, {
		description = "Streetlight spawner (parking lot light with thicker base and "..v.." lamp"..s..")",
		inventory_image = "simple_streetlights_inv_parking_lot_hd_fence_"..v..".png",
		use_texture_alpha = true,
		tool_capabilities = { full_punch_interval=0.1 },
		on_place = function(itemstack, placer, pointed_thing)
			streetlights.check_and_place(itemstack, placer, pointed_thing, {
				schematic = streetlights.schematics[k+3],
				materials = {
					"morelights_modern:streetpost_d 3",
					"homedecor:fence_wrought_iron",
					"morelights_modern:barlight_c "..v
				},
				protection_box = {
					omin = {x =-1, y = 0, z =-1},
					omax = {x = 1, y = 3, z = 1},
				}
			})
		end
	})


end
