-- Class-W signs
local S = signs_lib.gettext
local cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_road_turns_sharp_left", {
	description = "W1-1: Road turns, sharp left ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_sharp_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_sharp_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_sharp_right", {
	description = "W1-1: Road turns, sharp right ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_sharp_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_sharp_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_left", {
	description = "W1-2: Road turns left ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_right", {
	description = "W1-2: Road turns right ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_dog_leg_left", {
	description = "W1-3: Road turns, sharp dog-leg to the left ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_dog_leg_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_dog_leg_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_dog_leg_right", {
	description = "W1-3: Road turns, sharp dog-leg to the right ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_dog_leg_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_dog_leg_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_dog_leg_curve_left", {
	description = "W1-4: Road turns, dog-leg curve to the left ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_dog_leg_curve_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_dog_leg_curve_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_dog_leg_curve_right", {
	description = "W1-4: Road turns, dog-leg curve to the right ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_dog_leg_curve_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_dog_leg_curve_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_winding", {
	description = "W1-5: Winding road ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_winding.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_winding_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_hairpin_left", {
	description = "W1-11: Road turns, hairpin curve to the left ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_hairpin_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_hairpin_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_hairpin_right", {
	description = "W1-11: Road turns, hairpin curve to the right ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_hairpin_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_hairpin_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_270_left", {
	description = "W1-15: Road turns, 270 degree loop to the left ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_270_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_270_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_road_turns_270_right", {
	description = "W1-15: Road turns, 270 degree loop to the right ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_road_turns_270_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_road_turns_270_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(48, 24)

signs_lib.register_sign("street_signs:sign_large_arrow_left", {
	description = "W1-6: Large arrow pointing left",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_48x24_wall.obj",
	tiles = {
		"street_signs_large_arrow_left.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_large_arrow_left_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_large_arrow_right", {
	description = "W1-6: Large arrow pointing right",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_48x24_wall.obj",
	tiles = {
		"street_signs_large_arrow_right.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_large_arrow_right_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_two_direction_large_arrow", {
	description = "W1-7: Two direction large arrow",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_48x24_wall.obj",
	tiles = {
		"street_signs_two_direction_large_arrow.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_two_direction_large_arrow_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})
cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_cross_road_ahead", {
	description = "W2-1: Cross-road ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_cross_road_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_cross_road_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_side_road_right_ahead", {
	description = "W2-2: Side road ahead (right)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_side_road_right_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_side_road_right_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_side_road_left_ahead", {
	description = "W2-2: Side road ahead (left)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_side_road_left_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_side_road_left_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_t_junction_ahead", {
	description = "W2-4: \"T\" junction ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_t_junction_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_t_junction_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_circular_intersection_ahead", {
	description = "W2-6: Roundabout/traffic circle ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_circular_intersection_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_circular_intersection_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_offset_side_road_left_ahead", {
	description = "W2-7L: Offset side-roads ahead (left first)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_offset_side_road_left_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_offset_side_road_left_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_offset_side_road_right_ahead", {
	description = "W2-7R: Offset side-roads ahead (right first)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_offset_side_road_right_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_offset_side_road_right_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_stop_ahead", {
	description = "W3-1: Stop sign ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_stop_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_stop_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_yield_ahead", {
	description = "W3-2: Yield sign ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_yield_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_yield_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_signal_ahead", {
	description = "W3-3: Traffic signal ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_signal_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_signal_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_merging_traffic", {
	description = "W4-1: Traffic merging from right sign",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_merging_traffic.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_merging_traffic_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_left_lane_ends", {
	description = "W4-2: Left lane ends sign",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_left_lane_ends.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_left_lane_ends_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_right_lane_ends", {
	description = "W4-2: Right lane ends sign",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_right_lane_ends.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_right_lane_ends_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_divided_highway_begins", {
	description = "W6-1: Divided highway begins sign",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_divided_highway_begins.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_divided_highway_begins_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_divided_highway_ends", {
	description = "W6-2: Divided highway ends sign",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_divided_highway_ends.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_divided_highway_ends_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_two_way_traffic", {
	description = "W6-3: Two-way traffic sign",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_two_way_traffic.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_two_way_traffic_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_hill_with_grade_ahead", {
	description = "W7-1a: Hill with grade ahead",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_hill_with_grade_ahead.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_hill_with_grade_ahead_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 1.9,
	vert_scaling = 4.6,
	line_spacing = 1,
	font_size = 31,
	x_offset = 8,
	y_offset = 93,
	chars_per_line = 15,
	entity_info = {
		mesh = "street_signs_warning_36x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_onpole = true,
	allow_onpole_horizontal = true,
})
cbox = signs_lib.make_selection_boxes(24, 18, nil, 0, 9.75, 0)

signs_lib.register_sign("street_signs:sign_distance_2_lines", {
	description = "W7-3aP: Blank distance sign (like \"Next X Miles\", 2 lines, yellow)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x18_top_wall.obj",
	tiles = {
		"street_signs_distance_2_lines.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_distance_2_lines_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 2,
	horiz_scaling = 1.8,
	vert_scaling = 1.25,
	line_spacing = 1,
	font_size = 31,
	x_offset = 12,
	y_offset = 12,
	chars_per_line = 20,
	entity_info = {
		mesh = "street_signs_generic_sign_24x18_top_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
})

signs_lib.register_sign("street_signs:sign_distance_2_lines_orange", {
	description = "W7-3aP: Blank distance sign (like \"Next X Miles\", 2 lines, orange)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x18_top_wall.obj",
	tiles = {
		"street_signs_distance_2_lines_orange.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_distance_2_lines_orange_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 2,
	horiz_scaling = 1.8,
	vert_scaling = 1.25,
	line_spacing = 1,
	font_size = 31,
	x_offset = 12,
	y_offset = 12,
	chars_per_line = 20,
	entity_info = {
		mesh = "street_signs_generic_sign_24x18_top_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
})

cbox = signs_lib.make_selection_boxes(30, 30)

signs_lib.register_sign("street_signs:sign_rr_grade_crossing_advance", {
	description = "W10-1: Railroad grade crossing advance warning",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_30dia_wall.obj",
	tiles = {
		"street_signs_rr_grade_crossing_advance.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_rr_grade_crossing_advance_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(24, 12, nil, 0, 12, 0)

signs_lib.register_sign("street_signs:sign_rr_exempt_w10_1ap", {
	description = "W10-1aP: Railroad \"EXEMPT\" sign (yellow)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x12_top_wall.obj",
	tiles = {
		"street_signs_rr_exempt_w10_1ap.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_rr_exempt_w10_1ap_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
})

cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_pedestrian_crossing", {
	description = "W11-2: Pedestrian crossing sign",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_pedestrian_crossing.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_pedestrian_crossing_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_low_clearance", {
	description = "W12-2: Low clearance",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_low_clearance.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_low_clearance_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 1.3,
	vert_scaling = 3,
	line_spacing = 1,
	font_size = 31,
	x_offset = 8,
	y_offset = 36,
	chars_per_line = 15,
	entity_info = {
		mesh = "street_signs_warning_36x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(18, 18, nil, 0, 10, 0)

signs_lib.register_sign("street_signs:sign_advisory_speed_mph", {
	description = "W13-1P: Advisory speed (MPH)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_18x18_top_wall.obj",
	tiles = {
		"street_signs_advisory_speed_mph.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_advisory_speed_mph_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 1.25,
	vert_scaling = 1.5,
	line_spacing = 1,
	font_size = 31,
	x_offset = 8,
	y_offset = 5,
	chars_per_line = 8,
	entity_info = {
		mesh = "street_signs_generic_sign_18x18_top_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
})

signs_lib.register_sign("street_signs:sign_advisory_speed_kmh", {
	description = "W13-1P: Advisory speed (km/h)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_18x18_top_wall.obj",
	tiles = {
		"street_signs_advisory_speed_kmh.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_advisory_speed_kmh_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 1.25,
	vert_scaling = 1.5,
	line_spacing = 1,
	font_size = 31,
	x_offset = 8,
	y_offset = 5,
	chars_per_line = 8,
	entity_info = {
		mesh = "street_signs_generic_sign_18x18_top_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
})

signs_lib.register_sign("street_signs:sign_advisory_speed_ms", {
	description = "W13-1P: Advisory speed (m/s)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_18x18_top_wall.obj",
	tiles = {
		"street_signs_advisory_speed_ms.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_advisory_speed_ms_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 1.25,
	vert_scaling = 1.5,
	line_spacing = 1,
	font_size = 31,
	x_offset = 8,
	y_offset = 5,
	chars_per_line = 8,
	entity_info = {
		mesh = "street_signs_generic_sign_18x18_top_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
})
