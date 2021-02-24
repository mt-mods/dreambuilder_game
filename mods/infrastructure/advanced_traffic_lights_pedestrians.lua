-- Traffic lights for pedestrians
	beep_handler = {}

	function semaphores_pedestrians(pos, node)
		local p = minetest.hash_node_position(pos)
		if node.name == "infrastructure:traffic_lights_pedestrians_bottom_1" then
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_bottom_2", param2 = node.param2})
			pos.y = pos.y + 1
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_top_2", param2 = node.param2})
		elseif node.name == "infrastructure:traffic_lights_pedestrians_bottom_2" then
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_bottom_3", param2 = node.param2})
			pos.y = pos.y + 1
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_top_3", param2 = node.param2})
			beep_handler[p] = minetest.sound_play("infrastructure_traffic_lights_1", {
				loop = true,
				pos = pos,
				gain = TRAFFIC_LIGHTS_VOLUME,
				max_hear_distance = 50
			})
		elseif node.name == "infrastructure:traffic_lights_pedestrians_bottom_3" then
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_bottom_4", param2 = node.param2})
			if beep_handler[p] ~= nil then
				minetest.sound_stop(beep_handler[p])
				beep_handler[p] = nil
			end
			pos.y = pos.y + 1
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_top_4", param2 = node.param2})
			beep_handler[p] = minetest.sound_play("infrastructure_traffic_lights_2", {
				loop = true,
				pos = pos,
				gain = TRAFFIC_LIGHTS_VOLUME,
				max_hear_distance = 50
			})
		elseif node.name == "infrastructure:traffic_lights_pedestrians_bottom_4" then
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_bottom_1", param2 = node.param2})
			pos.y = pos.y + 1
			minetest.swap_node(pos, {name = "infrastructure:traffic_lights_pedestrians_top_1", param2 = node.param2})
			if beep_handler[p] ~= nil then
				minetest.sound_stop(beep_handler[p])
				beep_handler[p] = nil
			end
		end
	end

	function quiet(pos)
		local p = minetest.hash_node_position(pos)
		if beep_handler[p] ~= nil then
			minetest.sound_stop(beep_handler[p])
			beep_handler[p] = nil
		end
	end

	for i = 1, 4 do
		minetest.register_node("infrastructure:traffic_lights_pedestrians_top_"..tostring(i), {
			tiles = {
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_pedestrians_top_back.png",
				"infrastructure_traffic_lights_pedestrians_top_front_"..tostring(i)..".png"
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {cracky=3, not_in_creative_inventory = 1},
			light_source = TRAFFIC_LIGHTS_LIGHT_RANGE,
			node_box = {
				type = "fixed",
				fixed = {
					{-5/16, -1/2, -1/8, 5/16, 0, 1/8},
					{-1/2, -1/2, -1/8, 1/2, 1/2, -1/8},

					{-5/16, -1/8, -5/16, 5/16, -1/16, -1/8},
					{-5/16, -3/8, -1/4, -1/4, -1/8, -1/8},
					{1/4, -3/8, -1/4, 5/16, -1/8, -1/8},

					{-1/8, 1/16, -1/8, 1/8, 5/16, 0},
					{-1/16, 1/8, 0, 1/16, 1/4, 1/8},
					{-1/16, 0, -1/16, 1/16, 1/8, 1/16}
				}
			},
			selection_box = {
				type = "fixed",
				fixed = {0, 0, 0, 0, 0, 0}
			}
		})

		minetest.register_node("infrastructure:traffic_lights_pedestrians_bottom_"..tostring(i), {
			tiles = {
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_side.png",
				"infrastructure_traffic_lights_pedestrians_bottom_back.png",
				"infrastructure_traffic_lights_pedestrians_bottom_front_"..tostring(i)..".png"
			},
			drawtype = "nodebox",
			paramtype = "light",
			paramtype2 = "facedir",
			groups = {cracky = 3, not_in_creative_inventory = 1},
			light_source = TRAFFIC_LIGHTS_LIGHT_RANGE,
			drop = "infrastructure:traffic_lights_pedestrians_bottom_1",
			node_box = {
				type = "fixed",
				fixed = {
					{-5/16, -5/16, -1/8, 5/16, 1/2, 1/8},
					{-1/2, -1/2, -1/8, 1/2, 1/2, -1/8},

					{-5/16, 1/4, -5/16, 5/16, 5/16, -1/8},
					{-5/16, 0, -1/4, -1/4, 1/4, -1/8},
					{1/4, 0, -1/4, 5/16, 1/4, -1/8},

					{-1/16, -1/4, 1/8, 1/16, 1/4, 3/8},
					{-1/4, -1/16, 1/8, 1/4, 1/16, 3/8},
					{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.001}
				}
			},
			selection_box = {
				type = "fixed",
				fixed = {
				-- box
					{-5/16, -5/16, -1/8, 5/16, 1, 1/8},
				-- top
					{-5/16, -1/8 + 1, -5/16, 5/16, -1/16 + 1, -1/8},
					{-5/16, -3/8 + 1, -1/4, -1/4, -1/8 + 1, -1/8},
					{1/4, -3/8 + 1, -1/4, 5/16, -1/8 + 1, -1/8},

					{-1/8, 1/16 + 1, -1/8, 1/8, 5/16 + 1, 0},
					{-1/16, 1/8 + 1, 0, 1/16, 1/4 + 1, 1/8},
					{-1/16, 0 + 1, -1/16, 1/16, 1/4 + 1, 1/16},
				-- bottom
					{-5/16, 1/4, -5/16, 5/16, 5/16, -1/8},
					{-5/16, 0, -1/4, -1/4, 1/4, -1/8},
					{1/4, 0, -1/4, 5/16, 1/4, -1/8},

					{-1/16, -1/4, 1/8, 1/16, 1/4, 3/8},
					{-1/4, -1/16, 1/8, 1/4, 1/16, 3/8},
					{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.01}
				}
			},

			after_place_node = function(pos)
				local node = minetest.env:get_node(pos)
				pos.y = pos.y + 1
				node.name = "infrastructure:traffic_lights_pedestrians_top_"..tostring(i)
				minetest.env:add_node(pos, node)
			end,

			after_dig_node = function(pos)
				local node = minetest.env:get_node(pos)
				quiet(pos)
				pos.y = pos.y + 1
				node.name = "infrastructure:traffic_lights_pedestrians_top_"..tostring(i)
				minetest.env:remove_node(pos)
			end,

			on_punch = function(pos, node)
				semaphores_pedestrians(pos, node)
			end,

			mesecons = {effector = {
				action_on = function(pos, node)
					semaphores_pedestrians(pos, node)
				end
			}}
		})
	end

	minetest.register_node("infrastructure:traffic_lights_pedestrians_bottom_1", {
		description = "Traffic lights for pedestrians",
		inventory_image = "infrastructure_traffic_lights_pedestrians.png",
		wield_image = "infrastructure_traffic_lights_pedestrians.png",
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_pedestrians_bottom_back.png",
			"infrastructure_traffic_lights_pedestrians_bottom_front_1.png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {cracky = 3, not_in_creative_inventory = 0},
		light_source = TRAFFIC_LIGHTS_LIGHT_RANGE,
		node_box = {
			type = "fixed",
			fixed = {
				{-5/16, -5/16, -1/8, 5/16, 1/2, 1/8},
				{-1/2, -1/2, -1/8, 1/2, 1/2, -1/8},

				{-5/16, 1/4, -5/16, 5/16, 5/16, -1/8},
				{-5/16, 0, -1/4, -1/4, 1/4, -1/8},
				{1/4, 0, -1/4, 5/16, 1/4, -1/8},

				{-1/16, -1/4, 1/8, 1/16, 1/4, 3/8},
				{-1/4, -1/16, 1/8, 1/4, 1/16, 3/8},
				{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.001}
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {
			-- box
				{-5/16, -5/16, -1/8, 5/16, 1, 1/8},
			-- top
				{-5/16, -1/8 + 1, -5/16, 5/16, -1/16 + 1, -1/8},
				{-5/16, -3/8 + 1, -1/4, -1/4, -1/8 + 1, -1/8},
				{1/4, -3/8 + 1, -1/4, 5/16, -1/8 + 1, -1/8},

				{-1/8, 1/16 + 1, -1/8, 1/8, 5/16 + 1, 0},
				{-1/16, 1/8 + 1, 0, 1/16, 1/4 + 1, 1/8},
				{-1/16, 0 + 1, -1/16, 1/16, 1/8 + 1, 1/16},
			-- bottom
				{-5/16, 1/4, -5/16, 5/16, 5/16, -1/8},
				{-5/16, 0, -1/4, -1/4, 1/4, -1/8},
				{1/4, 0, -1/4, 5/16, 1/4, -1/8},

				{-1/16, -1/4, 1/8, 1/16, 1/4, 3/8},
				{-1/4, -1/16, 1/8, 1/4, 1/16, 3/8},
				{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.01}
			}
		},

		after_place_node = function(pos)
			local node = minetest.env:get_node(pos)
			pos.y = pos.y + 1
			node.name = "infrastructure:traffic_lights_pedestrians_top_1"
			minetest.env:add_node(pos, node)
		end,

		after_dig_node = function(pos)
			local node = minetest.env:get_node(pos)
			quiet(pos)
			pos.y = pos.y + 1
			node.name = "infrastructure:traffic_lights_pedestrians_top_1"
			minetest.env:remove_node(pos)
		end,

		on_punch = function(pos, node)
			semaphores_pedestrians(pos, node)
		end,

		mesecons = {effector = {
			action_on = function(pos, node)
				semaphores_pedestrians(pos, node)
			end
		}}
	})

	minetest.register_alias("infrastructure:traffic_lights_pedestrians", "infrastructure:traffic_lights_pedestrians_bottom_1")
