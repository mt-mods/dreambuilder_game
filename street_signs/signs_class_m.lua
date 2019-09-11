-- Class-M signs

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

	minetest.register_node("street_signs:sign_us_route"..onpole, {
		description = "M1-4: Generic \"US Route\" sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_36x36"..onpole..".obj",
		tiles = { "street_signs_us_route.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_us_route_inv.png",
		wield_image = "street_signs_us_route_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 3.5,
		vert_scaling = 1.4,
		line_spacing = 6,
		font_size = 31,
		x_offset = 8,
		y_offset = 11,
		chars_per_line = 3,
		entity_info = {
			mesh = "street_signs_generic_sign_36x36_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_us_route"
	})

	minetest.register_node("street_signs:sign_us_interstate"..onpole, {
		description = "M1-1: Generic US Interstate sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_interstate_shield"..onpole..".obj",
		tiles = { "street_signs_us_interstate.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_us_interstate_inv.png",
		wield_image = "street_signs_us_interstate_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "f",
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		on_rotate = signs_lib.wallmounted_rotate,
		number_of_lines = 1,
		horiz_scaling = 4.3,
		vert_scaling = 1.4,
		line_spacing = 6,
		font_size = 31,
		x_offset = 8,
		y_offset = 14,
		chars_per_line = 3,
		entity_info = {
			mesh = "street_signs_interstate_shield_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_us_interstate"
	})

	cbox = signs_lib.make_selection_boxes(48, 18, onpole)

	minetest.register_node("street_signs:sign_detour_right_m4_10"..onpole, {
		description = "M4-10: Detour sign (to right)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_48x18"..onpole..".obj",
		tiles = { "street_signs_detour_right_m4_10.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_detour_right_m4_10_inv.png",
		wield_image = "street_signs_detour_right_m4_10_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_detour_right_m4_10"
	})

	minetest.register_node("street_signs:sign_detour_left_m4_10"..onpole, {
		description = "M4-10: Detour sign (to left)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_48x18"..onpole..".obj",
		tiles = { "street_signs_detour_left_m4_10.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_detour_left_m4_10_inv.png",
		wield_image = "street_signs_detour_left_m4_10_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = signs_lib.after_place_node,
		on_rotate = signs_lib.wallmounted_rotate,
		drop = "street_signs:sign_detour_left_m4_10"
	})

	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_us_route"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_us_interstate"..onpole)
end
