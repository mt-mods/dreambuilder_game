-- Misc./Generic signs

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

	cbox = street_signs.make_selection_boxes(36, 36, onpole)

	minetest.register_node("street_signs:sign_warning_3_line"..onpole, {
		description = "W3-4: Generic US diamond \"warning\" sign (3-line, yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_warning.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_3_line_inv.png",
		wield_image = "street_signs_warning_3_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
		number_of_lines = 3,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 19,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..onpole..".obj",
			yaw = street_signs.wallmounted_yaw
		},
		drop = "street_signs:sign_warning_3_line"
	})

	minetest.register_node("street_signs:sign_warning_4_line"..onpole, {
		description = "W23-2: Generic US diamond \"warning\" sign (4-line, yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_warning.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_4_line_inv.png",
		wield_image = "street_signs_warning_4_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
		number_of_lines = 4,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 25,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..onpole..".obj",
			yaw = street_signs.wallmounted_yaw
		},
		drop = "street_signs:sign_warning_4_line"
	})

	minetest.register_node("street_signs:sign_warning_orange_3_line"..onpole, {
		description = "W3-4: Generic US diamond \"warning\" sign (3-line, orange)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_warning_orange.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_orange_3_line_inv.png",
		wield_image = "street_signs_warning_orange_3_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
		number_of_lines = 3,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 19,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..onpole..".obj",
			yaw = street_signs.wallmounted_yaw
		},
		drop = "street_signs:sign_warning_orange_3_line"
	})

	minetest.register_node("street_signs:sign_warning_orange_4_line"..onpole, {
		description = "W23-2: Generic US diamond \"warning\" sign (4-line, orange)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning_36x36"..onpole..".obj",
		tiles = { "street_signs_warning_orange.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_warning_orange_4_line_inv.png",
		wield_image = "street_signs_warning_orange_4_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
		number_of_lines = 4,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 25,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_36x36_entity"..onpole..".obj",
			yaw = street_signs.wallmounted_yaw
		},
		drop = "street_signs:sign_warning_orange_4_line"
	})

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_3_line"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_4_line"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_orange_3_line"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_orange_4_line"..onpole)
end

for _, c in ipairs(street_signs.big_sign_colors) do

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 0.4375, 1.4375 }
	}

	local color = c[1]
	local defc = c[2]

	minetest.register_node("street_signs:sign_highway_small_"..color, {
		description = "Small generic highway sign (3-line, "..color..")",
		inventory_image = "street_signs_highway_small_"..color.."_inv.png",
		wield_image = "street_signs_highway_small_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_small.obj",
		tiles = { "street_signs_highway_small_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 3,
		horiz_scaling = 2,
		vert_scaling = 1.15,
		line_spacing = 2,
		font_size = 31,
		x_offset = 9,
		y_offset = 7,
		chars_per_line = 22,
		entity_info = {
			mesh = "street_signs_highway_small_entity.obj",
			yaw = street_signs.wallmounted_yaw
		}
	})
	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 1.4375, 1.4375 }
	}

	minetest.register_node("street_signs:sign_highway_medium_"..color, {
		description = "Medium generic highway sign (5-line, "..color..")",
		inventory_image = "street_signs_highway_medium_"..color.."_inv.png",
		wield_image = "street_signs_highway_medium_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_medium.obj",
		tiles = { "street_signs_highway_medium_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 6,
		horiz_scaling = 2,
		vert_scaling = 0.915,
		line_spacing = 2,
		font_size = 31,
		x_offset = 7,
		y_offset = 10,
		chars_per_line = 22,
		entity_info = {
			mesh = "street_signs_highway_medium_entity.obj",
			yaw = street_signs.wallmounted_yaw
		}
	})

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 1.4375, 2.4375 }
	}

	minetest.register_node("street_signs:sign_highway_large_"..color, {
		description = "Large generic highway sign (5-line, "..color..")",
		inventory_image = "street_signs_highway_large_"..color.."_inv.png",
		wield_image = "street_signs_highway_large_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_large.obj",
		tiles = { "street_signs_highway_large_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 6,
		horiz_scaling = 2,
		vert_scaling = 0.915,
		line_spacing = 2,
		font_size = 31,
		x_offset = 12,
		y_offset = 11,
		chars_per_line = 25,
		entity_info = {
			mesh = "street_signs_highway_large_entity.obj",
			yaw = street_signs.wallmounted_yaw
		}
	})

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_small_"..color)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_medium_"..color)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_large_"..color)
end

