-- Crosswalk warning light
function on_off_light(pos, node)
	if node.name == "infrastructure:crosswalk_warning_light_off" then
		minetest.swap_node(pos, {name = "infrastructure:crosswalk_warning_light_on", param2 = node.param2})
	elseif (node.name == "infrastructure:crosswalk_warning_light_on") then
		minetest.swap_node(pos, {name = "infrastructure:crosswalk_warning_light_off", param2 = node.param2})
	end
end

minetest.register_node("infrastructure:crosswalk_warning_light_off", {
	description = "Crosswalk warning light",
	inventory_image = "infrastructure_crosswalk_warning_light_front_bright.png",
	wield_image = "infrastructure_crosswalk_warning_light_front_bright.png",
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_crosswalk_warning_light_back.png",
		"infrastructure_crosswalk_warning_light_front_dark.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3, not_in_creative_inventory = 0},
	node_box = {
		type = "fixed",
		fixed = {
			{-5/16, -5/16, -1/8, 5/16, 3/8, 1/8},
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
			{-5/16, -5/16, -1/8, 5/16, 3/8, 1/8},

			{-5/16, 1/4, -5/16, 5/16, 5/16, -1/8},
			{-5/16, 0, -1/4, -1/4, 1/4, -1/8},
			{1/4, 0, -1/4, 5/16, 1/4, -1/8},

			{-1/16, -1/4, 1/8, 1/16, 1/4, 3/8},
			{-1/4, -1/16, 1/8, 1/4, 1/16, 3/8},
			{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.01}
		}
	},

	on_punch = function(pos, node)
		on_off_light(pos, node)
	end,

	mesecons = {effector = {
		action_on = function(pos, node)
			on_off_light(pos, node)
		end,
	}}
})

minetest.register_node("infrastructure:crosswalk_warning_light_on", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_crosswalk_warning_light_back.png",
		{name="infrastructure_crosswalk_warning_light_front_anim.png",animation={type="vertical_frames", aspect_w=32, aspect_h=32, length=1.5}}
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3, not_in_creative_inventory = 1},
	drop = "infrastructure:crosswalk_warning_light_off",
	node_box = {
		type = "fixed",
		fixed = {
			{-5/16, -5/16, -1/8, 5/16, 3/8, 1/8},
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
			{-5/16, -5/16, -1/8, 5/16, 3/8, 1/8},

			{-5/16, 1/4, -5/16, 5/16, 5/16, -1/8},
			{-5/16, 0, -1/4, -1/4, 1/4, -1/8},
			{1/4, 0, -1/4, 5/16, 1/4, -1/8},

			{-1/16, -1/4, 1/8, 1/16, 1/4, 3/8},
			{-1/4, -1/16, 1/8, 1/4, 1/16, 3/8},
			{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.01}
		}
	},

	on_punch = function(pos, node)
		on_off_light(pos, node)
	end,

	mesecons = {effector = {
		action_on = function(pos, node)
			on_off_light(pos, node)
		end,
	}}
})

minetest.register_alias("infrastructure:crosswalk_warning_light", "infrastructure:crosswalk_warning_light_off")
minetest.register_alias("infrastructure:crosswalk_warning_bright", "infrastructure:crosswalk_warning_light_on")
minetest.register_alias("infrastructure:crosswalk_warning_dark", "infrastructure:crosswalk_warning_light_on")
