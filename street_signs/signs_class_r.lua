-- Class-R signs

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

	minetest.register_node("street_signs:sign_stop"..onpole, {
		description = "R1-1: Stop sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_stop"..onpole..".obj",
		tiles = { "street_signs_stop.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_stop_inv.png",
		wield_image = "street_signs_stop_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_stop"
	})

	cbox = signs_lib.make_selection_boxes(36, 43.1, onpole, 0, -3.55, 0)

	minetest.register_node("street_signs:sign_stop_all_way"..onpole, {
		description = "R1-1 + R1-3P: Stop sign with \"all way\" plaque",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_stop_all_way"..onpole..".obj",
		tiles = { "street_signs_stop.png",
			"street_signs_sign_edge.png",
			"street_signs_stop_all_way_plaque.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_stop_all_way_inv.png",
		wield_image = "street_signs_stop_all_way_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_stop_all_way"
	})

	cbox = signs_lib.make_selection_boxes(48, 48, onpole)

	minetest.register_node("street_signs:sign_yield"..onpole, {
		description = "R1-2: Yield sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_yield"..onpole..".obj",
		tiles = { "street_signs_yield.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_yield_inv.png",
		wield_image = "street_signs_yield_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_yield"
	})

	cbox = signs_lib.make_selection_boxes(30, 36, onpole)

	minetest.register_node("street_signs:sign_speed_limit"..onpole, {
		description = "R2-1: Generic speed limit sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = { "street_signs_speed_limit.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_speed_limit_inv.png",
		wield_image = "street_signs_speed_limit_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 2.65,
		vert_scaling = 2.3,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 37,
		chars_per_line = 4,
		entity_info = {
			mesh = "street_signs_generic_sign_30x36_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_speed_limit"
	})

	cbox = signs_lib.make_selection_boxes(36, 36, onpole)

	minetest.register_node("street_signs:sign_no_right_turn"..onpole, {
		description = "R3-1: No right turn",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_no_right_turn.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_no_right_turn_inv.png",
		wield_image = "street_signs_no_right_turn_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_no_right_turn"
	})

	minetest.register_node("street_signs:sign_no_left_turn"..onpole, {
		description = "R3-2: No left turn",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_no_left_turn.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_no_left_turn_inv.png",
		wield_image = "street_signs_no_left_turn_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_no_left_turn"
	})

	minetest.register_node("street_signs:sign_no_u_turn"..onpole, {
		description = "R3-4: No U-turn",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_no_u_turn.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_no_u_turn_inv.png",
		wield_image = "street_signs_no_u_turn_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_no_u_turn"
	})

	minetest.register_node("street_signs:sign_u_turn_here"..onpole, {
		description = "U-turn here",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_u_turn_here.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_u_turn_here_inv.png",
		wield_image = "street_signs_u_turn_here_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_u_turn_here"
	})

	cbox = signs_lib.make_selection_boxes(30, 36, onpole)

	minetest.register_node("street_signs:sign_left_turn_only"..onpole, {
		description = "R3-5: Left turn only",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = {
			"street_signs_left_turn_only.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_turn_only_inv.png",
		wield_image = "street_signs_left_turn_only_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_left_turn_only"
	})

	minetest.register_node("street_signs:sign_right_turn_only"..onpole, {
		description = "R3-5: Right turn only",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = {
			"street_signs_right_turn_only.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_right_turn_only_inv.png",
		wield_image = "street_signs_right_turn_only_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_right_turn_only"
	})

	minetest.register_node("street_signs:sign_straight_through_only"..onpole, {
		description = "R3-5a: Straight through only",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = {
			"street_signs_straight_through_only.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_straight_through_only_inv.png",
		wield_image = "street_signs_straight_through_only_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_straight_through_only"
	})

	minetest.register_node("street_signs:sign_left_turn_or_straight"..onpole, {
		description = "R3-6: Left turn or straight through",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = {
			"street_signs_left_turn_or_straight.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_turn_or_straight_inv.png",
		wield_image = "street_signs_left_turn_or_straight_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_left_turn_or_straight"
	})

	minetest.register_node("street_signs:sign_right_turn_or_straight"..onpole, {
		description = "R3-6: Right turn or straight through",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = {
			"street_signs_right_turn_or_straight.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_right_turn_or_straight_inv.png",
		wield_image = "street_signs_right_turn_or_straight_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_right_turn_or_straight"
	})


	cbox = signs_lib.make_selection_boxes(36, 36, onpole)

	minetest.register_node("street_signs:sign_left_lane_must_turn_left"..onpole, {
		description = "R3-7: Left lane must turn left",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_left_lane_must_turn_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_lane_must_turn_left_inv.png",
		wield_image = "street_signs_left_lane_must_turn_left_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_left_lane_must_turn_left"
	})

	minetest.register_node("street_signs:sign_right_lane_must_turn_right"..onpole, {
		description = "R3-7: Right lane must turn right",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_right_lane_must_turn_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_right_lane_must_turn_right_inv.png",
		wield_image = "street_signs_right_lane_must_turn_right_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_right_lane_must_turn_right"
	})

	minetest.register_node("street_signs:sign_no_straight_through"..onpole, {
		description = "R3-27: No straight through",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_no_straight_through.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_no_straight_through_inv.png",
		wield_image = "street_signs_no_straight_through_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_no_straight_through"
	})

	cbox = signs_lib.make_selection_boxes(36, 48, onpole)

	minetest.register_node("street_signs:sign_keep_right"..onpole, {
		description = "R4-7: Keep right sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x48"..onpole..".obj",
		tiles = { "street_signs_keep_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_keep_right_inv.png",
		wield_image = "street_signs_keep_right_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_keep_right"
	})

	minetest.register_node("street_signs:sign_keep_left"..onpole, {
		description = "R4-8: Keep left sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x48"..onpole..".obj",
		tiles = { "street_signs_keep_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_keep_left_inv.png",
		wield_image = "street_signs_keep_left_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_keep_left"
	})

	cbox = signs_lib.make_selection_boxes(36, 36, onpole)

	minetest.register_node("street_signs:sign_do_not_enter"..onpole, {
		description = "R5-1: Do not enter sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = {
			"street_signs_do_not_enter.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_do_not_enter_inv.png",
		wield_image = "street_signs_do_not_enter_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_do_not_enter"
	})

	cbox = signs_lib.make_selection_boxes(42, 30, onpole)

	minetest.register_node("street_signs:sign_wrong_way"..onpole, {
		description = "R5-1a: Wrong way sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_42x30"..onpole..".obj",
		tiles = { "street_signs_wrong_way.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_wrong_way_inv.png",
		wield_image = "street_signs_wrong_way_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_wrong_way"
	})

	cbox = signs_lib.make_selection_boxes(54, 18, onpole)

	minetest.register_node("street_signs:sign_one_way_left"..onpole, {
		description = "R6-1: One way (left)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_54x18"..onpole..".obj",
		tiles = { "street_signs_one_way_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_one_way_left_inv.png",
		wield_image = "street_signs_one_way_left_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_one_way_left"
	})

	minetest.register_node("street_signs:sign_one_way_right"..onpole, {
		description = "R6-1: One way (right)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_54x18"..onpole..".obj",
		tiles = { "street_signs_one_way_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_one_way_right_inv.png",
		wield_image = "street_signs_one_way_right_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_one_way_right"
	})

	cbox = signs_lib.make_selection_boxes(30, 24, onpole)

	minetest.register_node("street_signs:sign_divided_highway_with_cross_road"..onpole, {
		description = "R6-3: divided highway with cross road",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x24"..onpole..".obj",
		tiles = { "street_signs_divided_highway_with_cross_road.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_divided_highway_with_cross_road_inv.png",
		wield_image = "street_signs_divided_highway_with_cross_road_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_divided_highway_with_cross_road"
	})

	cbox = signs_lib.make_selection_boxes(60, 24, onpole)

	minetest.register_node("street_signs:sign_roundabout_directional"..onpole, {
		description = "R6-4b: Roundabout direction (4 chevrons)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_60x24"..onpole..".obj",
		tiles = { "street_signs_roundabout_directional.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_roundabout_directional_inv.png",
		wield_image = "street_signs_roundabout_directional.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_roundabout_directional"
	})

	minetest.register_node("street_signs:sign_roundabout_directional_left"..onpole, {
		description = "R6-4b: Roundabout direction (4 chevrons, pointing left)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_60x24"..onpole..".obj",
		tiles = { "street_signs_roundabout_directional_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_roundabout_directional_left_inv.png",
		wield_image = "street_signs_roundabout_directional_left.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_roundabout_directional_left"
	})

	cbox = signs_lib.make_selection_boxes(30, 30, onpole)

	minetest.register_node("street_signs:sign_roundabout_counter_clockwise"..onpole, {
		description = "R6-5P: Roundabout plaque (to the left/counter-clockwise)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x30"..onpole..".obj",
		tiles = { "street_signs_roundabout_counter_clockwise.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_roundabout_counter_clockwise_inv.png",
		wield_image = "street_signs_roundabout_counter_clockwise.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_roundabout_counter_clockwise"
	})

	minetest.register_node("street_signs:sign_roundabout_clockwise"..onpole, {
		description = "R6-5P: Roundabout plaque (to the right/clockwise)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x30"..onpole..".obj",
		tiles = { "street_signs_roundabout_clockwise.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_roundabout_clockwise_inv.png",
		wield_image = "street_signs_roundabout_clockwise.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_roundabout_clockwise"
	})

	cbox = signs_lib.make_selection_boxes(24, 30, onpole)

	minetest.register_node("street_signs:sign_do_not_stop_on_tracks"..onpole, {
		description = "R8-8: Do not stop on tracks",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x30"..onpole..".obj",
		tiles = { "street_signs_do_not_stop_on_tracks.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_do_not_stop_on_tracks_inv.png",
		wield_image = "street_signs_do_not_stop_on_tracks.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_do_not_stop_on_tracks"
	})

	cbox = signs_lib.make_selection_boxes(9, 15, onpole, 0, 0, -1.25)

	minetest.register_node("street_signs:sign_ped_push_button_to_cross_r10_3a"..onpole, {
		description = "R10-3a: Pedestrians, push button to cross (pointing left)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x15"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_cross_r10_3a.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_cross_r10_3a_inv.png",
		wield_image = "street_signs_ped_push_button_to_cross_r10_3a_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3a"
	})

	minetest.register_node("street_signs:sign_ped_push_button_to_cross_r10_3a_right"..onpole, {
		description = "R10-3a: Pedestrians, push button to cross (pointing right)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x15"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_cross_r10_3a_right.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_cross_r10_3a_right_inv.png",
		wield_image = "street_signs_ped_push_button_to_cross_r10_3a_right_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3a_right"
	})

	minetest.register_node("street_signs:sign_ped_push_button_to_cross_r10_3a_both_ways"..onpole, {
		description = "R10-3a: Pedestrians, push button to cross (pointing both ways)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x15"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_cross_r10_3a_both_ways.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_cross_r10_3a_both_ways_inv.png",
		wield_image = "street_signs_ped_push_button_to_cross_r10_3a_both_ways_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3a_both_ways"
	})

	minetest.register_node("street_signs:sign_ped_push_button_to_cross_r10_3e"..onpole, {
		description = "R10-3e: Pedestrians, push button to cross (pointing right)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x15"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_cross_r10_3e.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_cross_r10_3e_inv.png",
		wield_image = "street_signs_ped_push_button_to_cross_r10_3e_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3e"
	})

	minetest.register_node("street_signs:sign_ped_push_button_to_cross_r10_3e_left"..onpole, {
		description = "R10-3e: Pedestrians, push button to cross (pointing left)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x15"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_cross_r10_3e_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_cross_r10_3e_left_inv.png",
		wield_image = "street_signs_ped_push_button_to_cross_r10_3e_left_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3e_left"
	})

	minetest.register_node("street_signs:sign_ped_push_button_to_cross_r10_3i"..onpole, {
		description = "R10-3i: Pedestrians, push button to cross (pointing right, with street name)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x15"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_cross_r10_3i.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_cross_r10_3i_inv.png",
		wield_image = "street_signs_ped_push_button_to_cross_r10_3i_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 3,
		vert_scaling = 12,
		line_spacing = 1,
		font_size = 31,
		x_offset = 15,
		y_offset = 333,
		chars_per_line = 25,
		entity_info = {
			mesh = "street_signs_generic_sign_9x15_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3i"
	})

	minetest.register_node("street_signs:sign_ped_push_button_to_cross_r10_3i_left"..onpole, {
		description = "R10-3i: Pedestrians, push button to cross (pointing left, with street name)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x15"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_cross_r10_3i_left.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_cross_r10_3i_left_inv.png",
		wield_image = "street_signs_ped_push_button_to_cross_r10_3i_left_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_rightclick = signs_lib.construct_sign,
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 3,
		vert_scaling = 12,
		line_spacing = 1,
		font_size = 31,
		x_offset = 15,
		y_offset = 333,
		chars_per_line = 25,
		entity_info = {
			mesh = "street_signs_generic_sign_9x15_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3i_left"
	})

	cbox = signs_lib.make_selection_boxes(30, 36, onpole)

	minetest.register_node("street_signs:sign_left_on_green_arrow_only"..onpole, {
		description = "R10-5: Left on green arrow only sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = { "street_signs_left_on_green_arrow_only.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_on_green_arrow_only_inv.png",
		wield_image = "street_signs_left_on_green_arrow_only_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_left_on_green_arrow_only"
	})

	cbox = signs_lib.make_selection_boxes(24, 36, onpole)

	minetest.register_node("street_signs:sign_stop_here_on_red"..onpole, {
		description = "R10-6: Stop here on red sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x36"..onpole..".obj",
		tiles = { "street_signs_stop_here_on_red.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_stop_here_on_red_inv.png",
		wield_image = "street_signs_stop_here_on_red_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_stop_here_on_red"
	})

	cbox = signs_lib.make_selection_boxes(36, 42, onpole)

	minetest.register_node("street_signs:sign_use_lane_with_green_arrow"..onpole, {
		description = "R10-8: Use lane with green arrow",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x42"..onpole..".obj",
		tiles = { "street_signs_use_lane_with_green_arrow.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_use_lane_with_green_arrow_inv.png",
		wield_image = "street_signs_use_lane_with_green_arrow_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:use_lane_with_green_arrow"
	})

	cbox = signs_lib.make_selection_boxes(36, 48, onpole)

	minetest.register_node("street_signs:sign_no_turn_on_red_light"..onpole, {
		description = "R10-11: No turn on red light",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x48"..onpole..".obj",
		tiles = { "street_signs_no_turn_on_red_light.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_no_turn_on_red_light_inv.png",
		wield_image = "street_signs_no_turn_on_red_light_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:no_turn_on_red_light"
	})

	cbox = signs_lib.make_selection_boxes(30, 36, onpole)

	minetest.register_node("street_signs:sign_left_turn_yield_on_green_light"..onpole, {
		description = "R10-12: Left turn yield on green light",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_30x36"..onpole..".obj",
		tiles = { "street_signs_left_turn_yield_on_green_light.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_left_turn_yield_on_green_light_inv.png",
		wield_image = "street_signs_left_turn_yield_on_green_light_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_left_turn_yield_on_green_light"
	})

	cbox = signs_lib.make_selection_boxes(24, 30, onpole)

	minetest.register_node("street_signs:sign_crosswalk_stop_on_red_light"..onpole, {
		description = "R10-23: Crosswalk: stop on red light",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x30"..onpole..".obj",
		tiles = { "street_signs_crosswalk_stop_on_red_light.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_crosswalk_stop_on_red_light_inv.png",
		wield_image = "street_signs_crosswalk_stop_on_red_light_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_crosswalk_stop_on_red_light"
	})

	cbox = signs_lib.make_selection_boxes(9, 12, onpole, 0, 0, -1.25)

	minetest.register_node("street_signs:sign_ped_push_button_to_turn_on_warning_lights"..onpole, {
		description = "R10-25: Pedestrians, push button to turn on warning lights",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_9x12"..onpole..".obj",
		tiles = { "street_signs_ped_push_button_to_turn_on_warning_lights.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_ped_push_button_to_turn_on_warning_lights_inv.png",
		wield_image = "street_signs_ped_push_button_to_turn_on_warning_lights_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_ped_push_button_to_turn_on_warning_lights"
	})

	cbox = signs_lib.make_selection_boxes(41, 41, onpole)

	minetest.register_node("street_signs:sign_rr_grade_crossbuck"..onpole, {
		description = "R15-1: Railroad grade crossing (crossbuck)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_rr_grade_crossbuck"..onpole..".obj",
		tiles = { "street_signs_rr_grade_crossbuck.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_rr_grade_crossbuck_inv.png",
		wield_image = "street_signs_rr_grade_crossbuck_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_rr_grade_crossbuck"
	})

	cbox = signs_lib.make_selection_boxes(24, 12, onpole, 0, 12, 0)

	minetest.register_node("street_signs:sign_rr_exempt_r15_3p"..onpole, {
		description = "R15-3P: Railroad \"EXEMPT\" sign (white)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x12_top"..onpole..".obj",
		tiles = { "street_signs_rr_exempt_r15_3p.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_rr_exempt_r15_3p_inv.png",
		wield_image = "street_signs_rr_exempt_r15_3p_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_rr_exempt_r15_3p"
	})


	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_ped_push_button_to_cross_r10_3i"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_ped_push_button_to_cross_r10_3i_left"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_speed_limit"..onpole)
end

cbox = {
	type = "fixed",
	fixed = { -0.1875, -0.5, -0.25, 0.1875, 0.6125, 0.25 }
}

minetest.register_node("street_signs:sign_stop_for_ped", {
	description = "R1-6a: Stop for pedestrian in crosswalk sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_stop_for_ped.obj",
	tiles = { "street_signs_stop_for_ped.png" },
	inventory_image = "street_signs_stop_for_ped_inv.png",
	groups = {choppy=2, dig_immediate=2},
})
