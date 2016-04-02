-- Aircraft warning light
minetest.register_node("infrastructure:aircraft_warning_light", {
	description = "Aircraft warning light",
	tiles = {
		{name="infrastructure_aircraft_warning_light_top_anim.png",animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=4}},
		"infrastructure_traffic_lights_side.png",
		{name="infrastructure_aircraft_warning_light_side_anim.png",animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=4}},
		{name="infrastructure_aircraft_warning_light_side_anim.png",animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=4}},
		{name="infrastructure_aircraft_warning_light_side_anim.png",animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=4}},
		{name="infrastructure_aircraft_warning_light_side_anim.png",animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=4}}
	},
	drawtype = "nodebox",
	paramtype = "light",
	groups = {cracky = 1},
	light_source = AIRCRAFT_WARNING_LIGHT_LIGHT_RANGE,
	node_box = {
		type = "fixed",
			fixed = {
				{-1/128, 1/4, -1/128, 1/128, 3/8, 1/128},

				{-1/4, -1/8, 0, 1/4, 1/4, 0},
				{0, -1/8, -1/4, 0, 1/4, 1/4},

				{-1/16, -1/8, -1/16, 1/16, 1/16, 1/16},

				{-1/4, -1/4, -1/8, 1/4, -1/8, 1/8},
				{-1/8, -1/4, -1/4, 1/8, -1/8, 1/4},

				{-1/8, -3/8, -1/8, 1/8, -1/4, 1/8},

				{-3/16, -1/2, -3/16, 3/16, -3/8, 3/16}
			}
	},
	selection_box = {
		type = "fixed",
			fixed = {
				{-1/128, 1/4, -1/128, 1/128, 3/8, 1/128},

				{-1/4, -1/8, 0, 1/4, 1/4, 0},
				{0, -1/8, -1/4, 0, 1/4, 1/4},

				{-1/16, -1/8, -1/16, 1/16, 1/16, 1/16},

				{-1/4, -1/4, -1/8, 1/4, -1/8, 1/8},
				{-1/8, -1/4, -1/4, 1/8, -1/8, 1/4},

				{-1/8, -3/8, -1/8, 1/8, -1/4, 1/8},

				{-3/16, -1/2, -3/16, 3/16, -3/8, 3/16}
			}
	}
})

minetest.register_alias("infrastructure:aircraft_warning_light_bright", "infrastructure:aircraft_warning_light")
minetest.register_alias("infrastructure:aircraft_warning_light_dark", "infrastructure:aircraft_warning_light")
