-- Curve chevron
	minetest.register_node("infrastructure:curve_chevron_dark", {
		description = "Flashing curve chevron",
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_curve_chevron_left_dark.png",
			"infrastructure_curve_chevron_right_dark.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 3},
		node_box = {
			type = "fixed",
				fixed = {
					{-1/2, -1/2, -1/8, 1/2, 1/2, -1/16},
					{-1/2, -1/2, 1/16, 1/2, 1/2, 1/8},
					{-3/8, 1/4, -1/16, -1/4, 3/8, 1/16},
					{1/4, 1/4, -1/16, 3/8, 3/8, 1/16},
					{-3/8, -3/8, -1/16, -1/4, -1/4, 1/16},
					{1/4, -3/8, -1/16, 3/8, -1/4, 1/16}
				}
		},
		selection_box = {
			type = "fixed",
				fixed = {-1/2, -1/2, -1/8, 1/2, 1/2, 1/8}
		},

		on_punch = function(pos, node)
			minetest.swap_node(pos, {name = "infrastructure:curve_chevron_bright", param2 = node.param2})
		end,

		mesecons = {effector = {
			action_on = function (pos, node)
				minetest.swap_node(pos, {name = "infrastructure:curve_chevron_bright", param2 = node.param2})
			end,
		}}
	})

	minetest.register_node("infrastructure:curve_chevron_bright", {
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_curve_chevron_left_bright.png",
			"infrastructure_curve_chevron_right_bright.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 3, not_in_creative_inventory = 1},
		light_source = CURVE_CHEVRON_LIGHT_RANGE,
		drop = "infrastructure:curve_chevron_dark",
		node_box = {
			type = "fixed",
				fixed = {
					{-1/2, -1/2, -1/8, 1/2, 1/2, -1/16},
					{-1/2, -1/2, 1/16, 1/2, 1/2, 1/8},
					{-3/8, 1/4, -1/16, -1/4, 3/8, 1/16},
					{1/4, 1/4, -1/16, 3/8, 3/8, 1/16},
					{-3/8, -3/8, -1/16, -1/4, -1/4, 1/16},
					{1/4, -3/8, -1/16, 3/8, -1/4, 1/16}
				}
		},
		selection_box = {
			type = "fixed",
				fixed = {-1/2, -1/2, -1/8, 1/2, 1/2, 1/8}
		},

		on_punch = function(pos, node)
			minetest.swap_node(pos, {name = "infrastructure:curve_chevron_dark", param2 = node.param2})
		end,

		mesecons = {effector = {
			action_off = function (pos, node)
				minetest.swap_node(pos, {name = "infrastructure:curve_chevron_dark", param2 = node.param2})
			end
		}}
	})

	minetest.register_alias("infrastructure:curve_chevron", "infrastructure:curve_chevron_dark")
