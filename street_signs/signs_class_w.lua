-- Class-W signs

local S = signs_lib.gettext
local cbox

for _, onpole in ipairs({"", "_onpole"}) do

	local nci = nil
	local on_rotate = signs_lib.wallmounted_rotate
	local pole_mount_tex = nil

	if onpole == "_onpole" then
		nci = 1
		on_rotate = nil
		pole_mount_tex = "signs_lib_pole_mount.png"
	end

	cbox = signs_lib.make_selection_boxes(36, 36, onpole)

	minetest.register_node("street_signs:sign_road_turns_sharp_left"..onpole, {
		description = "W1-1: Road turns, sharp left ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_sharp_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_sharp_left_inv.png",
		wield_image = "street_signs_road_turns_sharp_left_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_sharp_left"
	})

	minetest.register_node("street_signs:sign_road_turns_sharp_right"..onpole, {
		description = "W1-1: Road turns, sharp right ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_sharp_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_sharp_right_inv.png",
		wield_image = "street_signs_road_turns_sharp_right_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_sharp_right"
	})

	minetest.register_node("street_signs:sign_road_turns_left"..onpole, {
		description = "W1-2: Road turns left ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_left_inv.png",
		wield_image = "street_signs_road_turns_left_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_left"
	})

	minetest.register_node("street_signs:sign_road_turns_right"..onpole, {
		description = "W1-2: Road turns right ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_right_inv.png",
		wield_image = "street_signs_road_turns_right_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_right"
	})

	minetest.register_node("street_signs:sign_road_turns_dog_leg_left"..onpole, {
		description = "W1-3: Road turns, sharp dog-leg to the left ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_dog_leg_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_dog_leg_left_inv.png",
		wield_image = "street_signs_road_turns_dog_leg_left_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_dog_leg_left"
	})

	minetest.register_node("street_signs:sign_road_turns_dog_leg_right"..onpole, {
		description = "W1-3: Road turns, sharp dog-leg to the right ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_dog_leg_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_dog_leg_right_inv.png",
		wield_image = "street_signs_road_turns_dog_leg_right_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_dog_leg_right"
	})

	minetest.register_node("street_signs:sign_road_turns_dog_leg_curve_left"..onpole, {
		description = "W1-4: Road turns, dog-leg curve to the left ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_dog_leg_curve_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_dog_leg_curve_left_inv.png",
		wield_image = "street_signs_road_turns_dog_leg_curve_left_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_dog_leg_curve_left"
	})

	minetest.register_node("street_signs:sign_road_turns_dog_leg_curve_right"..onpole, {
		description = "W1-4: Road turns, dog-leg curve to the right ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_dog_leg_curve_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_dog_leg_curve_right_inv.png",
		wield_image = "street_signs_road_turns_dog_leg_curve_right_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_dog_leg_curve_right"
	})

	minetest.register_node("street_signs:sign_road_winding"..onpole, {
		description = "W1-5: Winding road ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_winding.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_winding_inv.png",
		wield_image = "street_signs_road_winding_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_winding"
	})

	minetest.register_node("street_signs:sign_road_turns_hairpin_left"..onpole, {
		description = "W1-11: Road turns, hairpin curve to the left ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_hairpin_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_hairpin_left_inv.png",
		wield_image = "street_signs_road_turns_hairpin_left_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_hairpin_left"
	})

	minetest.register_node("street_signs:sign_road_turns_hairpin_right"..onpole, {
		description = "W1-11: Road turns, hairpin curve to the right ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_hairpin_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_hairpin_right_inv.png",
		wield_image = "street_signs_road_turns_hairpin_right_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_hairpin_right"
	})

	minetest.register_node("street_signs:sign_road_turns_270_left"..onpole, {
		description = "W1-15: Road turns, 270 degree loop to the left ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_270_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_270_left_inv.png",
		wield_image = "street_signs_road_turns_270_left_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_270_left"
	})

	minetest.register_node("street_signs:sign_road_turns_270_right"..onpole, {
		description = "W1-15: Road turns, 270 degree loop to the right ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_road_turns_270_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_road_turns_270_right_inv.png",
		wield_image = "street_signs_road_turns_270_right_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_road_turns_270_right"
	})

	cbox = signs_lib.make_selection_boxes(48, 24, onpole)

	minetest.register_node("street_signs:sign_large_arrow_left"..onpole, {
		description = "W1-6: Large arrow pointing left",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_48x24"..onpole..".obj",
		tiles = { "street_signs_large_arrow_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_large_arrow_left_inv.png",
		wield_image = "street_signs_large_arrow_left_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_large_arrow_left"
	})

	minetest.register_node("street_signs:sign_large_arrow_right"..onpole, {
		description = "W1-6: Large arrow pointing right",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_48x24"..onpole..".obj",
		tiles = { "street_signs_large_arrow_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_large_arrow_right_inv.png",
		wield_image = "street_signs_large_arrow_right_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_large_arrow_right"
	})

	minetest.register_node("street_signs:sign_two_direction_large_arrow"..onpole, {
		description = "W1-7: Two direction large arrow",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_48x24"..onpole..".obj",
		tiles = { "street_signs_two_direction_large_arrow.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_two_direction_large_arrow_inv.png",
		wield_image = "street_signs_two_direction_large_arrow_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_two_direction_large_arrow"
	})

	cbox = signs_lib.make_selection_boxes(36, 36, onpole)

	minetest.register_node("street_signs:sign_cross_road_ahead"..onpole, {
		description = "W2-1: Cross-road ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_cross_road_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_cross_road_ahead_inv.png",
		wield_image = "street_signs_cross_road_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_cross_road_ahead"
	})

	minetest.register_node("street_signs:sign_side_road_right_ahead"..onpole, {
		description = "W2-2: Side road ahead (right)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_side_road_right_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_side_road_right_ahead_inv.png",
		wield_image = "street_signs_side_road_right_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_side_road_right_ahead"
	})

	minetest.register_node("street_signs:sign_side_road_left_ahead"..onpole, {
		description = "W2-2: Side road ahead (left)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_side_road_left_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_side_road_left_ahead_inv.png",
		wield_image = "street_signs_side_road_left_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_side_road_left_ahead"
	})

	minetest.register_node("street_signs:sign_t_junction_ahead"..onpole, {
		description = "W2-4: \"T\" junction ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_t_junction_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_t_junction_ahead_inv.png",
		wield_image = "street_signs_t_junction_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_t_junction_ahead"
	})

	minetest.register_node("street_signs:sign_circular_intersection_ahead"..onpole, {
		description = "W2-6: Roundabout/traffic circle ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_circular_intersection_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_circular_intersection_ahead_inv.png",
		wield_image = "street_signs_circular_intersection_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_circular_intersection_ahead"
	})

	minetest.register_node("street_signs:sign_offset_side_road_left_ahead"..onpole, {
		description = "W2-7L: Offset side-roads ahead (left first)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_offset_side_road_left_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_offset_side_road_left_ahead_inv.png",
		wield_image = "street_signs_offset_side_road_left_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_offset_side_road_left_ahead"
	})

	minetest.register_node("street_signs:sign_offset_side_road_right_ahead"..onpole, {
		description = "W2-7R: Offset side-roads ahead (right first)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_offset_side_road_right_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_offset_side_road_right_ahead_inv.png",
		wield_image = "street_signs_offset_side_road_right_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_offset_side_road_right_ahead"
	})

	minetest.register_node("street_signs:sign_stop_ahead"..onpole, {
		description = "W3-1: Stop sign ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_stop_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_stop_ahead_inv.png",
		wield_image = "street_signs_stop_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_stop_ahead"
	})

	minetest.register_node("street_signs:sign_yield_ahead"..onpole, {
		description = "W3-2: Yield sign ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_yield_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_yield_ahead_inv.png",
		wield_image = "street_signs_yield_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_yield_ahead"
	})

	minetest.register_node("street_signs:sign_signal_ahead"..onpole, {
		description = "W3-3: Traffic signal ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_signal_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_signal_ahead_inv.png",
		wield_image = "street_signs_signal_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_signal_ahead"
	})

	minetest.register_node("street_signs:sign_merging_traffic"..onpole, {
		description = "W4-1: Traffic merging from right sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_merging_traffic.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_merging_traffic_inv.png",
		wield_image = "street_signs_merging_traffic_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_merging_traffic"
	})

	minetest.register_node("street_signs:sign_left_lane_ends"..onpole, {
		description = "W4-2: Left lane ends sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_left_lane_ends.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_lane_ends_inv.png",
		wield_image = "street_signs_left_lane_ends_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_left_lane_ends"
	})

	minetest.register_node("street_signs:sign_right_lane_ends"..onpole, {
		description = "W4-2: Right lane ends sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_right_lane_ends.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_right_lane_ends_inv.png",
		wield_image = "street_signs_right_lane_ends_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_right_lane_ends"
	})

	minetest.register_node("street_signs:sign_divided_highway_begins"..onpole, {
		description = "W6-1: Divided highway begins sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_divided_highway_begins.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_divided_highway_begins_inv.png",
		wield_image = "street_signs_divided_highway_begins_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_divided_highway_begins"
	})

	minetest.register_node("street_signs:sign_divided_highway_ends"..onpole, {
		description = "W6-2: Divided highway ends sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_divided_highway_ends.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_divided_highway_ends_inv.png",
		wield_image = "street_signs_divided_highway_ends_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_divided_highway_ends"
	})

	minetest.register_node("street_signs:sign_two_way_traffic"..onpole, {
		description = "W6-3: Two-way traffic sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_two_way_traffic.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_two_way_traffic_inv.png",
		wield_image = "street_signs_two_way_traffic_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_two_way_traffic"
	})

	minetest.register_node("street_signs:sign_hill_with_grade_ahead"..onpole, {
		description = "W7-1a: Hill with grade ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_hill_with_grade_ahead.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_hill_with_grade_ahead_inv.png",
		wield_image = "street_signs_hill_with_grade_ahead_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 1.9,
		vert_scaling = 4.6,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 93,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_hill_with_grade_ahead"
	})

	cbox = signs_lib.make_selection_boxes(24, 18, onpole, 0, 9.75, 0)

	minetest.register_node("street_signs:sign_distance_2_lines"..onpole, {
		description = "W7-3aP: Blank distance sign (like \"Next X Miles\", 2 lines, yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x18_top"..onpole..".obj",
		tiles = { "street_signs_distance_2_lines.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_distance_2_lines_inv.png",
		wield_image = "street_signs_distance_2_lines_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 2,
		horiz_scaling = 1.8,
		vert_scaling = 1.25,
		line_spacing = 1,
		font_size = 31,
		x_offset = 12,
		y_offset = 12,
		chars_per_line = 20,
		entity_info = {
			mesh = "street_signs_generic_sign_24x18_top_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_distance_2_lines"
	})

	minetest.register_node("street_signs:sign_distance_2_lines_orange"..onpole, {
		description = "W7-3aP: Blank distance sign (like \"Next X Miles\", 2 lines, orange)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x18_top"..onpole..".obj",
		tiles = { "street_signs_distance_2_lines_orange.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_distance_2_lines_orange_inv.png",
		wield_image = "street_signs_distance_2_lines_orange_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 2,
		horiz_scaling = 1.8,
		vert_scaling = 1.25,
		line_spacing = 1,
		font_size = 31,
		x_offset = 12,
		y_offset = 12,
		chars_per_line = 20,
		entity_info = {
			mesh = "street_signs_generic_sign_24x18_top_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_distance_2_lines_orange"
	})


	cbox = signs_lib.make_selection_boxes(30, 30, onpole)

	minetest.register_node("street_signs:sign_rr_grade_crossing_advance"..onpole, {
		description = "W10-1: Railroad grade crossing advance warning",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30dia"..onpole..".obj",
		tiles = { "street_signs_rr_grade_crossing_advance.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_rr_grade_crossing_advance_inv.png",
		wield_image = "street_signs_rr_grade_crossing_advance_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_rr_grade_crossing_advance"
	})

	cbox = signs_lib.make_selection_boxes(24, 12, onpole, 0, 12, 0)

	minetest.register_node("street_signs:sign_rr_exempt_w10_1ap"..onpole, {
		description = "W10-1aP: Railroad \"EXEMPT\" sign (yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x12_top"..onpole..".obj",
		tiles = { "street_signs_rr_exempt_w10_1ap.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_rr_exempt_w10_1ap_inv.png",
		wield_image = "street_signs_rr_exempt_w10_1ap_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_rr_exempt_w10_1ap"
	})

	cbox = signs_lib.make_selection_boxes(36, 36, onpole)

	minetest.register_node("street_signs:sign_pedestrian_crossing"..onpole, {
		description = "W11-2: Pedestrian crossing sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_pedestrian_crossing.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_pedestrian_crossing_inv.png",
		wield_image = "street_signs_pedestrian_crossing_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_pedestrian_crossing"
	})

	minetest.register_node("street_signs:sign_low_clearance"..onpole, {
		description = "W12-2: Low clearance",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_low_clearance.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_low_clearance_inv.png",
		wield_image = "street_signs_low_clearance_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 1.3,
		vert_scaling = 3,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 36,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_low_clearance"
	})

	cbox = signs_lib.make_selection_boxes(18, 18, onpole, 0, 10, 0)

	minetest.register_node("street_signs:sign_advisory_speed_mph"..onpole, {
		description = "W13-1P: Advisory speed (MPH)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_18x18_top"..onpole..".obj",
		tiles = { "street_signs_advisory_speed_mph.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_advisory_speed_mph_inv.png",
		wield_image = "street_signs_advisory_speed_mph_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 1.25,
		vert_scaling = 1.5,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 5,
		chars_per_line = 8,
		entity_info = {
			mesh = "street_signs_generic_sign_18x18_top_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_advisory_speed_mph"
	})

	minetest.register_node("street_signs:sign_advisory_speed_kmh"..onpole, {
		description = "W13-1P: Advisory speed (km/h)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_18x18_top"..onpole..".obj",
		tiles = { "street_signs_advisory_speed_kmh.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_advisory_speed_kmh_inv.png",
		wield_image = "street_signs_advisory_speed_kmh_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 1.25,
		vert_scaling = 1.5,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 5,
		chars_per_line = 8,
		entity_info = {
			mesh = "street_signs_generic_sign_18x18_top_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_advisory_speed_kmh"
	})

	minetest.register_node("street_signs:sign_advisory_speed_ms"..onpole, {
		description = "W13-1P: Advisory speed (m/s)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_18x18_top"..onpole..".obj",
		tiles = { "street_signs_advisory_speed_ms.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_advisory_speed_ms_inv.png",
		wield_image = "street_signs_advisory_speed_ms_inv.png",
		groups = {sign = 1, choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 1.25,
		vert_scaling = 1.5,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 5,
		chars_per_line = 8,
		entity_info = {
			mesh = "street_signs_generic_sign_18x18_top_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_advisory_speed_ms"
	})

	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_hill_with_grade_ahead"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_low_clearance"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_distance_2_lines"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_advisory_speed_mph"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_advisory_speed_kmh"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_advisory_speed_ms"..onpole)
end
