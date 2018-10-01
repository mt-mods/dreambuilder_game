-- Class-W signs

local S = street_signs.gettext
local cbox

for _, onpole in ipairs({"", "_onpole"}) do

	local nci = nil
	local on_rotate = street_signs.wallmounted_rotate
	local pole_mount_tex = nil

	if onpole == "_onpole" then
		nci = 1
		on_rotate = nil
		pole_mount_tex = "street_signs_pole_mount.png"
	end

	cbox = street_signs.make_selection_boxes(48, 24, onpole)

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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_two_direction_large_arrow"
	})

	cbox = street_signs.make_selection_boxes(36, 36, onpole)

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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
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
			yaw = street_signs.wallmounted_yaw
		},
		drop = "street_signs:sign_hill_with_grade_ahead"
	})

	cbox = street_signs.make_selection_boxes(30, 30, onpole)

	minetest.register_node("street_signs:sign_rr_grade_crossing_advance"..onpole, {
		description = "W10-1: Railroad grade crossing advance warning",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_rr_grade_crossing_advance"..onpole..".obj",
		tiles = { "street_signs_rr_grade_crossing_advance.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_rr_grade_crossing_advance_inv.png",
		wield_image = "street_signs_rr_grade_crossing_advance_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_rr_grade_crossing_advance"
	})

	cbox = street_signs.make_selection_boxes(36, 36, onpole)

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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
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
			yaw = street_signs.wallmounted_yaw
		},
		drop = "street_signs:sign_low_clearance"
	})

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_hill_with_grade_ahead"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_low_clearance"..onpole)
end
