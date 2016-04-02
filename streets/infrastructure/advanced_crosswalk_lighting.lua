-- Crosswalk lighting
	minetest.register_node("infrastructure:crosswalk_lighting_dark", {
		description = "Crosswalk lighting",
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_crosswalk_lighting_bottom.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_crosswalk_lighting_back.png",
			"infrastructure_crosswalk_lighting_front.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 3},
		node_box = {
			type = "fixed",
				fixed = {
					{-3/8, -1/2, -1/4, 3/8, 1/2, -3/16},
					{-3/8, -1/2, 3/16, 3/8, 1/2, 1/4},
					{-1/4, 1/4, -3/16, -1/8, 3/8, 3/16},
					{1/8, 1/4, -3/16, 1/4, 3/8, 3/16},
					{-1/8, -1/2, -3/16, 1/8, -1/4, 3/16},
					{-1/2, -1/2, -1/8, 1/2, -3/8, 1/8},
				}
		},
		selection_box = {
			type = "fixed",
				fixed = {-3/8, -1/2, -1/4, 3/8, 1/2, 1/4}
		},

		on_punch = function(pos, node)
			minetest.swap_node(pos, {name = "infrastructure:crosswalk_lighting_bright", param2 = node.param2})
		end,

		mesecons = {effector = {
			action_on = function (pos, node)
				minetest.swap_node(pos, {name = "infrastructure:crosswalk_lighting_bright", param2 = node.param2})
			end,
		}}
	})

	minetest.register_node("infrastructure:crosswalk_lighting_bright", {
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_crosswalk_lighting_bottom.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_crosswalk_lighting_back.png",
			"infrastructure_crosswalk_lighting_front.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 3, not_in_creative_inventory = 1},
		light_source = CROSSWALK_LIGHTING_LIGHT_RANGE,
		drop = "infrastructure:crosswalk_lighting_dark",
		node_box = {
			type = "fixed",
				fixed = {
					{-3/8, -1/2, -1/4, 3/8, 1/2, -3/16},
					{-3/8, -1/2, 3/16, 3/8, 1/2, 1/4},
					{-1/4, 1/4, -3/16, -1/8, 3/8, 3/16},
					{1/8, 1/4, -3/16, 1/4, 3/8, 3/16},
					{-1/8, -1/2, -3/16, 1/8, -1/4, 3/16},
					{-1/2, -1/2, -1/8, 1/2, -3/8, 1/8},
				}
		},
		selection_box = {
			type = "fixed",
				fixed = {-3/8, -1/2, -1/4, 3/8, 1/2, 1/4}
		},

		on_punch = function(pos, node)
			minetest.swap_node(pos, {name = "infrastructure:crosswalk_lighting_dark", param2 = node.param2})
		end,

		mesecons = {effector = {
			action_off = function (pos, node)
				minetest.swap_node(pos, {name = "infrastructure:crosswalk_lighting_dark", param2 = node.param2})
			end,
		}}
	})

	minetest.register_alias("infrastructure:crosswalk_lighting", "infrastructure:crosswalk_lighting_dark")
