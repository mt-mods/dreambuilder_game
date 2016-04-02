-- Crosswalk safety sign
	minetest.register_node("infrastructure:crosswalk_safety_sign_top", {
		tiles = {
			"infrastructure_crosswalk_safety_sign_top.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_crosswalk_safety_sign_top_side.png",
			"infrastructure_crosswalk_safety_sign_top_side.png",
			"infrastructure_crosswalk_safety_sign_top_front_back.png",
			"infrastructure_crosswalk_safety_sign_top_front_back.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 1, not_in_creative_inventory = 1},
		light_source = CROSSWALK_SAFETY_SIGN_LIGHT_RANGE,
		node_box = {
			type = "fixed",
			fixed = {
				{-1/4, -1/2, -1/16, 1/4, 0, -1/16},
				{-1/4, -1/2, 1/16, 1/4, 0, 1/16},
				{-1/16, -1/2, -1/16, 1/16, -1/4, 1/16}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {0, 0, 0, 0, 0, 0}
		}
	})

	minetest.register_node("infrastructure:crosswalk_safety_sign_bottom", {
		description = "Crosswalk safety sign",
		inventory_image = "infrastructure_crosswalk_safety_sign.png",
		wield_image = "infrastructure_crosswalk_safety_sign.png",
		tiles = {
			"infrastructure_crosswalk_safety_sign_top.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_crosswalk_safety_sign_bottom_side.png",
			"infrastructure_crosswalk_safety_sign_bottom_side.png",
			"infrastructure_crosswalk_safety_sign_bottom_front_back.png",
			"infrastructure_crosswalk_safety_sign_bottom_front_back.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 1},
		light_source = CROSSWALK_SAFETY_SIGN_LIGHT_RANGE,
		node_box = {
			type = "fixed",
			fixed = {
				{-1/4, -7/32, -1/16, 1/4, 1/2, -1/16},
				{-1/4, -7/32, 1/16, 1/4, 1/2, 1/16},
				{-1/16, -5/16, -1/16, 1/16, 1/2, 1/16},
				{-1/8, -3/8, -1/8, 1/8, -5/16, 1/8},
				{-1/4, -1/2, -1/2, 1/4, -3/8, 1/2}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-1/4, -7/32, -1/16, 1/4, 1, -1/16},
				{-1/4, -7/32, 1/16, 1/4, 1, 1/16},

				{-1/16, -5/16, -1/16 + 0.01, 1/16, 3/4, 1/16 - 0.01},

				{-1/8, -3/8, -1/8, 1/8, -5/16, 1/8},
				{-1/4, -1/2, -1/2, 1/4, -3/8, 1/2}
			}
		},

		after_place_node = function(pos)
			local node = minetest.env:get_node(pos)
			node.name = "infrastructure:crosswalk_safety_sign_bottom"
			minetest.env:add_node(pos, node)
			pos.y = pos.y + 1
			node.name = "infrastructure:crosswalk_safety_sign_top"
			minetest.env:add_node(pos, node)
		end,

		after_dig_node = function(pos)
			pos.y = pos.y + 1
			minetest.env:remove_node(pos)
		end,
	})

	minetest.register_alias("infrastructure:crosswalk_safety_sign", "infrastructure:crosswalk_safety_sign_bottom")
