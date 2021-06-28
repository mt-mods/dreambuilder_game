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
