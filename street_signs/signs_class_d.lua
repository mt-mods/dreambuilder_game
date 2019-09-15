-- Class D signs
local S = signs_lib.gettext
local groups = table.copy(signs_lib.standard_steel_groups)

local cbox = {
	type = "fixed",
	fixed = {
		{ -1/32, 23/16, -1/32, 1/32, 24/16, 1/32 },
		{ -1/32, 18/16, -8/16, 1/32, 23/16, 8/16 },
		{ -1/32, 17/16, -1/32, 1/32, 18/16, 1/32 },
		{ -8/16, 12/16, -1/32, 8/16, 17/16, 1/32 },
		{ -1/16, -8/16, -1/16, 1/16, 12/16, 1/16 },
	}
}

signs_lib.register_sign("street_signs:sign_basic", {
	description = "D3-1a: Generic intersection street name sign",
	paramtype2 = "facedir",
	selection_box = cbox,
	mesh = "street_signs_basic.obj",
	tiles = { "street_signs_basic.png" },
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	default_color = "f",
	number_of_lines = 2,
	horiz_scaling = 0.8,
	vert_scaling = 1,
	line_spacing = 9,
	font_size = 31,
	x_offset = 7,
	y_offset = 4,
	chars_per_line = 40,
	entity_info = {
		mesh = "street_signs_basic_entity.obj",
		yaw = signs_lib.standard_yaw
	},
	allow_onpole = false
})

cbox = {
	type = "fixed",
	fixed = {
		{ -1/32,  7/16, -1/32, 1/32,  8/16, 1/32 },
		{ -1/32,  2/16, -8/16, 1/32,  7/16, 8/16 },
		{ -1/32,  1/16, -1/32, 1/32,  2/16, 1/32 },
		{ -8/16, -4/16, -1/32, 8/16,  1/16, 1/32 },
		{ -1/16, -8/16, -1/16, 1/16, -4/16, 1/16 },
	}
}

signs_lib.register_sign("street_signs:sign_basic_top_only", {
	description = "D3-1a: Generic intersection street name sign (top only)",
	paramtype2 = "facedir",
	selection_box = cbox,
	mesh = "street_signs_basic_top_only.obj",
	tiles = { "street_signs_basic.png" },
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	default_color = "f",
	number_of_lines = 2,
	horiz_scaling = 0.8,
	vert_scaling = 1,
	line_spacing = 9,
	font_size = 31,
	x_offset = 7,
	y_offset = 4,
	chars_per_line = 40,
	entity_info = {
		mesh = "street_signs_basic_top_only_entity.obj",
		yaw = signs_lib.standard_yaw
	},
	allow_onpole = false
})

cbox = signs_lib.make_selection_boxes(24, 24)

signs_lib.register_sign("street_signs:sign_service_hospital", {
	description = "D9-2: General service: hospital",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x24.obj",
	tiles = { "street_signs_service_hospital.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_service_hospital_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
})

signs_lib.register_sign("street_signs:sign_service_handicapped", {
	description = "D9-6: General service: handicapped",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x24.obj",
	tiles = { "street_signs_service_handicapped.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_service_handicapped_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
})

signs_lib.register_sign("street_signs:sign_service_fuel", {
	description = "D9-7: General service: fuel/gas",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x24.obj",
	tiles = { "street_signs_service_fuel.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_service_fuel_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
})

signs_lib.register_sign("street_signs:sign_service_food", {
	description = "D9-8: General service: food",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x24.obj",
	tiles = { "street_signs_service_food.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_service_food_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
})

signs_lib.register_sign("street_signs:sign_service_lodging", {
	description = "D9-9: General service: lodging",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x24.obj",
	tiles = { "street_signs_service_lodging.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_service_lodging_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
})

signs_lib.register_sign("street_signs:sign_service_ev_charging", {
	description = "D9-11b: General service: EV charging",
	selection_box = cbox,
	mesh = "street_signs_generic_sign_24x24.obj",
	tiles = { "street_signs_service_ev_charging.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_service_ev_charging_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
})
