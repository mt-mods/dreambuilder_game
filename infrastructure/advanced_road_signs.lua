-- Road signs
	local signs = {"stop", "yield", "right_of_way"}

	for i, sign_name in ipairs(signs) do
		minetest.register_node("infrastructure:road_sign_"..sign_name, {
			description = "Road sign "..sign_name,
			tiles = {
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_road_sign_"..sign_name.."_back.png",
				"infrastructure_road_sign_"..sign_name.."_front.png"
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {cracky = 2},
			node_box = {
				type = "fixed",
				fixed = {
					{-1/2, -1/2, 7/16, 1/2, 1/2, 7/16},
					{-3/16, -1/8, 7/16, 3/16, 1/8, 1/2 - 0.001}
				}
			},
			selection_box = {
				type = "fixed",
				fixed = {
					{-1/2, -1/2, 7/16, 1/2, 1/2, 7/16},
					{-3/16, -1/8, 7/16 + 0.01, 3/16, 1/8, 1/2 - 0.01}
				}
			},

			after_place_node = function(pos, node)
				local node = minetest.env:get_node(pos)
				local param2 = node.param2
				local sign_pos = {x=pos.x, y=pos.y, z=pos.z}

				if param2 == 0 then
					pos.z = pos.z + 1
				elseif param2 == 1 then
					pos.x = pos.x + 1
				elseif param2 == 2 then
					pos.z = pos.z - 1
				elseif param2 == 3 then
					pos.x = pos.x - 1
				end

				local node = minetest.env:get_node(pos)

				if minetest.registered_nodes[node.name].drawtype == "fencelike" then
					minetest.set_node(sign_pos, {name="infrastructure:road_sign_"..sign_name.."_on_post", param2=param2})
				end
			end
		})

		minetest.register_node("infrastructure:road_sign_"..sign_name.."_on_post", {
			tiles = {
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_road_sign_"..sign_name.."_back.png",
				"infrastructure_road_sign_"..sign_name.."_front.png"
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {cracky = 2, not_in_creative_inventory = 1},
			drop = "infrastructure:road_sign_"..sign_name,
			node_box = {
				type = "fixed",
				fixed = {
					{-1/2, -1/2, 7/16 + 3/8, 1/2, 1/2, 7/16 + 3/8},
					{-3/16, 1/16, 7/16 + 3/8, 3/16, 1/8, 13/16 + 3/8 - 0.001},
					{-3/16, -1/8, 7/16 + 3/8, 3/16, -1/16, 13/16 + 3/8 - 0.001}
				}
			},
			selection_box = {
				type = "fixed",
				fixed = {
					{-1/2, -1/2, 7/16 + 3/8, 1/2, 1/2, 7/16 + 3/8},
					{-3/16, 1/16, 7/16 + 3/8 + 0.01, 3/16, 1/8, 13/16 + 3/8 - 0.01},
					{-3/16, -1/8, 7/16 + 3/8 + 0.01, 3/16, -1/16, 13/16 + 3/8 - 0.01}
				}
			}
		})
	end

-- Road sign crosswalk
	minetest.register_node("infrastructure:road_sign_crosswalk", {
		description = "Road sign crosswalk",
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_road_sign_crosswalk_back.png",
			"infrastructure_road_sign_crosswalk_front.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 2},
		node_box = {
			type = "fixed",
			fixed = {
				{-1/2, -1/2, 7/16, 1/2, 1/2, 7/16},
				{-3/16, -1/8, 7/16, 3/16, 1/8, 1/2 - 0.001}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-1/2, -1/2, 7/16, 1/2, 1/2, 7/16},
				{-3/16, -1/8, 7/16, 3/16, 1/8, 1/2 - 0.001}
			}
		},

		after_place_node = function(pos, node)
			local node = minetest.env:get_node(pos)
			local param2 = node.param2
			local sign_pos = {x=pos.x, y=pos.y, z=pos.z}

			if param2 == 0 then
				pos.z = pos.z + 1
			elseif param2 == 1 then
				pos.x = pos.x + 1
			elseif param2 == 2 then
				pos.z = pos.z - 1
			elseif param2 == 3 then
				pos.x = pos.x - 1
			end

			local node = minetest.env:get_node(pos)

			if param2 == 0 then
				pos.z = pos.z - 2
			elseif param2 == 1 then
				pos.x = pos.x - 2
			elseif param2 == 2 then
				pos.z = pos.z + 2
			elseif param2 == 3 then
				pos.x = pos.x + 2
			end

			if minetest.registered_nodes[node.name].drawtype == "fencelike" then
				minetest.set_node(sign_pos, {name="infrastructure:road_sign_crosswalk_on_post", param2=param2})
				minetest.env:add_node(pos, {name="infrastructure:road_sign_retroreflective_surface_on_post", param2=param2})
			else
				minetest.env:add_node(pos, {name="infrastructure:road_sign_retroreflective_surface", param2=param2})
			end
		end
	})

	minetest.register_node("infrastructure:road_sign_crosswalk_on_post", {
		description = "Road sign crosswalk",
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_road_sign_crosswalk_back.png",
			"infrastructure_road_sign_crosswalk_front.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 2, not_in_creative_inventory = 1},
		drop = "infrastructure:road_sign_crosswalk",
		node_box = {
			type = "fixed",
			fixed = {
				{-1/2, -1/2, 7/16 + 3/8, 1/2, 1/2, 7/16 + 3/8},
				{-3/16, 1/16, 7/16 + 3/8, 3/16, 1/8, 13/16 + 3/8 - 0.001},
				{-3/16, -1/8, 7/16 + 3/8, 3/16, -1/16, 13/16 + 3/8 - 0.001}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-1/2, -1/2, 7/16 + 3/8, 1/2, 1/2, 7/16 + 3/8},
				{-3/16, 1/16, 7/16 + 3/8 + 0.01, 3/16, 1/8, 13/16 + 3/8 - 0.01},
				{-3/16, -1/8, 7/16 + 3/8 + 0.01, 3/16, -1/16, 13/16 + 3/8 - 0.01}
			}
		}
	})

	minetest.register_node("infrastructure:road_sign_retroreflective_surface", {
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_road_sign_retroreflective_surface.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 2, not_in_creative_inventory = 1},
		light_source = RETROREFLECTIVE_SURFACE_LIGHT_RANGE,
		drop = "",
		node_box = {
			type = "fixed",
			fixed = {-3/4, -3/4, 7/16 + 1 + 0.01, 3/4, 3/4, 7/16 + 1 + 0.01}
		},
		selection_box = {
			type = "fixed",
			fixed = {-3/4, -3/4, 7/16 + 1 + 0.01, 3/4, 3/4, 7/16 + 1 + 0.01}
		}
	})

	minetest.register_node("infrastructure:road_sign_retroreflective_surface_on_post", {
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_road_sign_retroreflective_surface.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 2, not_in_creative_inventory = 1},
		light_source = RETROREFLECTIVE_SURFACE_LIGHT_RANGE,
		drop = "",
		node_box = {
			type = "fixed",
			fixed = {-3/4, -3/4, 7/16 + 3/8 + 1 + 0.01, 3/4, 3/4, 7/16 + 3/8 + 1 + 0.01}
		},
		selection_box = {
			type = "fixed",
			fixed = {-3/4, -3/4, 7/16 + 3/8 + 1 + 0.01, 3/4, 3/4, 7/16 + 3/8 + 1 + 0.01}
		}
	})
