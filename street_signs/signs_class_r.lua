-- Class-R signs

local S = signs_lib.gettext
local cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_stop", {
	description = "R1-1: Stop sign",
	selection_box = cbox,
	mesh = "street_signs_stop_wall.obj",
	tiles = {
		"street_signs_stop.png",
		"street_signs_sign_edge.png"
	},
	inventory_image = "street_signs_stop_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(36, 43.1, nil, 0, -3.55, 0)

signs_lib.register_sign("street_signs:sign_stop_all_way", {
	description = "R1-1 + R1-3P: Stop sign with \"all way\" plaque",
	selection_box = cbox,
	mesh = "street_signs_stop_all_way_wall.obj",
	tiles = {
		"street_signs_stop.png",
		"street_signs_sign_edge.png"
	},
	inventory_image = "street_signs_stop_all_way_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(48, 48)

signs_lib.register_sign("street_signs:sign_yield", {
	description = "R1-2: Yield sign",
	selection_box = cbox,
	mesh = "street_signs_yield_wall.obj",
	tiles = {
		"street_signs_yield.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_yield_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(30, 36)

signs_lib.register_sign("street_signs:sign_speed_limit", {
	description = "R2-1: Generic speed limit sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_speed_limit.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_speed_limit_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 2.65,
	vert_scaling = 2.3,
	line_spacing = 1,
	font_size = 31,
	x_offset = 8,
	y_offset = 37,
	chars_per_line = 4,
	entity_info = {
		mesh = "street_signs_generic_sign_30x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_no_right_turn", {
	description = "R3-1: No right turn",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_no_right_turn.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_no_right_turn_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_no_left_turn", {
	description = "R3-2: No left turn",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_no_left_turn.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_no_left_turn_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_no_u_turn", {
	description = "R3-4: No U-turn",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_no_u_turn.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_no_u_turn_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_u_turn_here", {
	description = "U-turn here",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_u_turn_here.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_u_turn_here_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(30, 36)

signs_lib.register_sign("street_signs:sign_left_turn_only", {
	description = "R3-5: Left turn only",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_left_turn_only.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_left_turn_only_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_right_turn_only", {
	description = "R3-5: Right turn only",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_right_turn_only.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_right_turn_only_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_straight_through_only", {
	description = "R3-5a: Straight through only",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_straight_through_only.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_straight_through_only_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_left_turn_or_straight", {
	description = "R3-6: Left turn or straight through",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_left_turn_or_straight.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_left_turn_or_straight_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_right_turn_or_straight", {
	description = "R3-6: Right turn or straight through",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_right_turn_or_straight.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_right_turn_or_straight_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_left_lane_must_turn_left", {
	description = "R3-7: Left lane must turn left",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_left_lane_must_turn_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_left_lane_must_turn_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_right_lane_must_turn_right", {
	description = "R3-7: Right lane must turn right",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_right_lane_must_turn_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_right_lane_must_turn_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_no_straight_through", {
	description = "R3-27: No straight through",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_no_straight_through.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_no_straight_through_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(36, 48)

signs_lib.register_sign("street_signs:sign_keep_right", {
	description = "R4-7: Keep right sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x48_wall.obj",
	tiles = {
		"street_signs_keep_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_keep_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_keep_left", {
	description = "R4-8: Keep left sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x48_wall.obj",
	tiles = {
		"street_signs_keep_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_keep_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_do_not_enter", {
	description = "R5-1: Do not enter sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_do_not_enter.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_do_not_enter_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(42, 30)

signs_lib.register_sign("street_signs:sign_wrong_way", {
	description = "R5-1a: Wrong way sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_42x30_wall.obj",
	tiles = {
		"street_signs_wrong_way.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_wrong_way_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(54, 18)

signs_lib.register_sign("street_signs:sign_one_way_left", {
	description = "R6-1: One way (left)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_54x18_wall.obj",
	tiles = {
		"street_signs_one_way_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_one_way_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_one_way_right", {
	description = "R6-1: One way (right)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_54x18_wall.obj",
	tiles = {
		"street_signs_one_way_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_one_way_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(30, 24)

signs_lib.register_sign("street_signs:sign_divided_highway_with_cross_road", {
	description = "R6-3: divided highway with cross road",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x24_wall.obj",
	tiles = {
		"street_signs_divided_highway_with_cross_road.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_divided_highway_with_cross_road_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(60, 24)

signs_lib.register_sign("street_signs:sign_roundabout_directional", {
	description = "R6-4b: Roundabout direction (4 chevrons)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_60x24_wall.obj",
	tiles = {
		"street_signs_roundabout_directional.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_roundabout_directional_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_roundabout_directional_left", {
	description = "R6-4b: Roundabout direction (4 chevrons, pointing left)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_60x24_wall.obj",
	tiles = {
		"street_signs_roundabout_directional_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_roundabout_directional_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(30, 30)

signs_lib.register_sign("street_signs:sign_roundabout_counter_clockwise", {
	description = "R6-5P: Roundabout plaque (to the left/counter-clockwise)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x30_wall.obj",
	tiles = {
		"street_signs_roundabout_counter_clockwise.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_roundabout_counter_clockwise_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_roundabout_clockwise", {
	description = "R6-5P: Roundabout plaque (to the right/clockwise)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x30_wall.obj",
	tiles = {
		"street_signs_roundabout_clockwise.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_roundabout_clockwise_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(24, 30)

signs_lib.register_sign("street_signs:sign_do_not_stop_on_tracks", {
	description = "R8-8: Do not stop on tracks",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x30_wall.obj",
	tiles = {
		"street_signs_do_not_stop_on_tracks.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_do_not_stop_on_tracks_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(9, 15, nil, 0, 0, -1.25)

signs_lib.register_sign("street_signs:sign_ped_push_button_to_cross_r10_3a", {
	description = "R10-3a: Pedestrians, push button to cross (pointing left)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x15_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_cross_r10_3a.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_cross_r10_3a_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	uses_slim_pole_mount = true,
})

signs_lib.register_sign("street_signs:sign_ped_push_button_to_cross_r10_3a_right", {
	description = "R10-3a: Pedestrians, push button to cross (pointing right)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x15_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_cross_r10_3a_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_cross_r10_3a_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	uses_slim_pole_mount = true,
})

signs_lib.register_sign("street_signs:sign_ped_push_button_to_cross_r10_3a_both_ways", {
	description = "R10-3a: Pedestrians, push button to cross (pointing both ways)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x15_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_cross_r10_3a_both_ways.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_cross_r10_3a_both_ways_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	uses_slim_pole_mount = true,
})

signs_lib.register_sign("street_signs:sign_ped_push_button_to_cross_r10_3e", {
	description = "R10-3e: Pedestrians, push button to cross (pointing right)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x15_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_cross_r10_3e.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_cross_r10_3e_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	uses_slim_pole_mount = true,
})

signs_lib.register_sign("street_signs:sign_ped_push_button_to_cross_r10_3e_left", {
	description = "R10-3e: Pedestrians, push button to cross (pointing left)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x15_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_cross_r10_3e_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_cross_r10_3e_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	uses_slim_pole_mount = true,
})

signs_lib.register_sign("street_signs:sign_ped_push_button_to_cross_r10_3i", {
	description = "R10-3i: Pedestrians, push button to cross (pointing right, with street name)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x15_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_cross_r10_3i.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_cross_r10_3i_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 3,
	vert_scaling = 12,
	line_spacing = 1,
	font_size = 31,
	x_offset = 15,
	y_offset = 333,
	chars_per_line = 25,
	entity_info = {
		mesh = "street_signs_generic_sign_9x15_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_onpole = true,
	uses_slim_pole_mount = true,
	allow_widefont = true,
})

signs_lib.register_sign("street_signs:sign_ped_push_button_to_cross_r10_3i_left", {
	description = "R10-3i: Pedestrians, push button to cross (pointing left, with street name)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x15_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_cross_r10_3i_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_cross_r10_3i_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 3,
	vert_scaling = 12,
	line_spacing = 1,
	font_size = 31,
	x_offset = 15,
	y_offset = 333,
	chars_per_line = 25,
	entity_info = {
		mesh = "street_signs_generic_sign_9x15_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_onpole = true,
	uses_slim_pole_mount = true,
	allow_widefont = true,
})

cbox = signs_lib.make_selection_boxes(30, 36)

signs_lib.register_sign("street_signs:sign_left_on_green_arrow_only", {
	description = "R10-5: Left on green arrow only sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_left_on_green_arrow_only.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_left_on_green_arrow_only_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(24, 36)

signs_lib.register_sign("street_signs:sign_stop_here_on_red", {
	description = "R10-6: Stop here on red sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x36_wall.obj",
	tiles = {
		"street_signs_stop_here_on_red.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_stop_here_on_red_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(36, 42)

signs_lib.register_sign("street_signs:sign_use_lane_with_green_arrow", {
	description = "R10-8: Use lane with green arrow",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x42_wall.obj",
	tiles = {
		"street_signs_use_lane_with_green_arrow.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_use_lane_with_green_arrow_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(36, 48)

signs_lib.register_sign("street_signs:sign_no_turn_on_red_light", {
	description = "R10-11: No turn on red light",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x48_wall.obj",
	tiles = {
		"street_signs_no_turn_on_red_light.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_no_turn_on_red_light_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(30, 36)

signs_lib.register_sign("street_signs:sign_left_turn_yield_on_green_light", {
	description = "R10-12: Left turn yield on green light",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30x36_wall.obj",
	tiles = {
		"street_signs_left_turn_yield_on_green_light.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_left_turn_yield_on_green_light_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(24, 30)

signs_lib.register_sign("street_signs:sign_crosswalk_stop_on_red_light", {
	description = "R10-23: Crosswalk: stop on red light",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x30_wall.obj",
	tiles = {
		"street_signs_crosswalk_stop_on_red_light.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_crosswalk_stop_on_red_light_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(9, 12, nil, 0, 0, -1.25)

signs_lib.register_sign("street_signs:sign_ped_push_button_to_turn_on_warning_lights", {
	description = "R10-25: Pedestrians, push button to turn on warning lights",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_9x12_wall.obj",
	tiles = {
		"street_signs_ped_push_button_to_turn_on_warning_lights.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_ped_push_button_to_turn_on_warning_lights_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	uses_slim_pole_mount = true,
})

cbox = signs_lib.make_selection_boxes(41, 41)

signs_lib.register_sign("street_signs:sign_rr_grade_crossbuck", {
	description = "R15-1: Railroad grade crossing (crossbuck)",
	selection_box = cbox,
	mesh = "street_signs_rr_grade_crossbuck_wall.obj",
	tiles = {
		"street_signs_rr_grade_crossbuck.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_rr_grade_crossbuck_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(24, 12, nil, 0, 12, 0)

signs_lib.register_sign("street_signs:sign_rr_exempt_r15_3p", {
	description = "R15-3P: Railroad \"EXEMPT\" sign (white)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x12_top_wall.obj",
	tiles = {
		"street_signs_rr_exempt_r15_3p.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_rr_exempt_r15_3p_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
})

cbox = {
	type = "fixed",
	fixed = { -0.1875, -0.5, -0.25, 0.1875, 0.6125, 0.25 }
}

signs_lib.register_sign("street_signs:sign_stop_for_ped", {
	description = "R1-6a: Stop for pedestrian in crosswalk sign",
	paramtype2 = "facedir",
	selection_box = cbox,
	mesh = "street_signs_stop_for_ped.obj",
	tiles = {
		"street_signs_stop_for_ped.png",
		"street_signs_sign_edge.png"
	},
	inventory_image = "street_signs_stop_for_ped_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
})
