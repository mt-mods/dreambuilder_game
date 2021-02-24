-- Class-M signs
local S = signs_lib.gettext
local cbox = signs_lib.make_selection_boxes(36, 36)

local sgroups = table.copy(signs_lib.standard_steel_groups)
sgroups.not_in_creative_inventory = 1

signs_lib.register_sign("street_signs:sign_us_route", {
	description = "M1-4: Generic \"US Route\" sign",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_36x36_wall.obj",
	tiles = {
		"street_signs_us_route.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_us_route_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 1,
	horiz_scaling = 3.5,
	vert_scaling = 1.4,
	line_spacing = 6,
	font_size = 31,
	x_offset = 8,
	y_offset = 11,
	chars_per_line = 3,
	entity_info = {
		mesh = "street_signs_generic_sign_36x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_us_interstate", {
	description = "M1-1: Generic US Interstate sign",
	selection_box = cbox,
	mesh = "street_signs_interstate_shield_wall.obj",
	tiles = {
		"street_signs_us_interstate.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_us_interstate_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	default_color = "f",
	number_of_lines = 1,
	horiz_scaling = 4.3,
	vert_scaling = 1.4,
	line_spacing = 6,
	font_size = 31,
	x_offset = 8,
	y_offset = 14,
	chars_per_line = 3,
	entity_info = {
		mesh = "street_signs_interstate_shield_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

cbox = signs_lib.make_selection_boxes(48, 18)

signs_lib.register_sign("street_signs:sign_detour_right_m4_10", {
	description = "M4-10: Detour sign (to right)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_48x18_wall.obj",
	tiles = {
		"street_signs_detour_right_m4_10.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_detour_right_m4_10_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_detour_left_m4_10", {
	description = "M4-10: Detour sign (to left)",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_48x18_wall.obj",
	tiles = {
		"street_signs_detour_left_m4_10.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_detour_left_m4_10_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})
