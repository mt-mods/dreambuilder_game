-- Warning light

minetest.register_node("infrastructure:warning_light", {
	description = "Warning light",
	tiles = {
		"infrastructure_warning_light_top.png",
		"infrastructure_warning_light_bottom.png",
		"infrastructure_warning_light_right.png",
		"infrastructure_warning_light_left.png",
		"infrastructure_warning_light_back.png",
		{name="infrastructure_warning_light_front_anim.png",animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=3}},
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 1},
	light_source = WARNING_LIGHT_LIGHT_RANGE,
	node_box = {
		type = "fixed",
			fixed = {
				{-5/16, -3/8, 0, 5/16, 0, 0},

				{-1/4, -5/16, 0, 0, -1/16, 1/8},

				{1/16, -1/2, -1/8, 5/16, -1/4, 1/8},

				{-1/16, -1/2, -1/16, 1/16, -3/8, 1/16}
			}
	},
	selection_box = {
		type = "fixed",
			fixed = {
				{-5/16, -3/8, 0, 5/16, 0, 0},

				{-1/4, -5/16, 0 + 0.01, 0, -1/16, 1/8},

				{1/16, -1/2, -1/8, 5/16, -1/4, 1/8},

				{-1/16, -1/2, -1/16, 1/16, -3/8, 1/16}
			}
	}
})



minetest.register_alias("infrastructure:warning_light_bright", "infrastructure:warning_light")
minetest.register_alias("infrastructure:warning_light_dark", "infrastructure:warning_light")
