-- node definitions

local S = street_signs.gettext

street_signs.lbm_restore_nodes = {}

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

local stdyaw = {
	0,
	math.pi / -2,
	math.pi,
	math.pi / 2,
}

local wmyaw = {
	nil,
	nil,
	math.pi / -2,
	math.pi / 2,
	0,
	math.pi,
}

table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_basic")
table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_basic_top_only")

minetest.register_node("street_signs:sign_basic", {
	description = "D3-1a: Generic intersection street name sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_basic.obj",
	tiles = { "street_signs_basic.png" },
	groups = {choppy=2, dig_immediate=2},
	default_color = "f",
	on_construct = street_signs.construct_sign,
	on_destruct = street_signs.destruct_sign,
	on_receive_fields = street_signs.receive_fields,
	on_punch = street_signs.update_sign,
	on_rotate = street_signs.facedir_rotate,
	number_of_lines = 2,
	horiz_scaling = 1,
	vert_scaling = 1,
	line_spacing = 9,
	font_size = 31,
	x_offset = 1,
	y_offset = 4,
	chars_per_line = 30,
	entity_info = {
		mesh = "street_signs_basic_entity.obj",
		yaw = stdyaw
	}
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

minetest.register_node("street_signs:sign_basic_top_only", {
	description = "D3-1a: Generic intersection street name sign (top only)",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_basic_top_only.obj",
	tiles = { "street_signs_basic.png" },
	groups = {choppy=2, dig_immediate=2},
	default_color = "f",
	on_construct = street_signs.construct_sign,
	on_destruct = street_signs.destruct_sign,
	on_receive_fields = street_signs.receive_fields,
	on_punch = street_signs.update_sign,
	on_rotate = street_signs.facedir_rotate,
	number_of_lines = 2,
	horiz_scaling = 1,
	vert_scaling = 1,
	line_spacing = 9,
	font_size = 31,
	x_offset = 1,
	y_offset = 4,
	chars_per_line = 30,
	entity_info = {
		mesh = "street_signs_basic_top_only_entity.obj",
		yaw = stdyaw
	}
})

for _, c in ipairs(street_signs.big_sign_colors) do

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 0.4375, 1.4375 }
	}

	local color = c[1]
	local defc = c[2]

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_small_"..color)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_medium_"..color)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_highway_large_"..color)

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
			yaw = wmyaw
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
			yaw = wmyaw
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
			yaw = wmyaw
		}
	})
end

for _, onpole in ipairs({"", "_onpole"}) do

	local nci = nil
	local on_rotate = street_signs.wallmounted_rotate
	local pole_mount_tex = nil

	if onpole == "_onpole" then
		nci = 1
		on_rotate = nil
		pole_mount_tex = "street_signs_pole_mount.png"
	end

	cbox = street_signs.make_selection_boxes(24, 24, onpole)

	minetest.register_node("street_signs:sign_service_hospital"..onpole, {
		description = "D9-2: General service: hospital",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x24"..onpole..".obj",
		tiles = { "street_signs_service_hospital.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_service_hospital_inv.png",
		wield_image = "street_signs_service_hospital_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_service_hospital"
	})

	minetest.register_node("street_signs:sign_service_handicapped"..onpole, {
		description = "D9-6: General service: handicapped",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x24"..onpole..".obj",
		tiles = { "street_signs_service_handicapped.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_service_handicapped_inv.png",
		wield_image = "street_signs_service_handicapped_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_service_handicapped"
	})

	minetest.register_node("street_signs:sign_service_fuel"..onpole, {
		description = "D9-7: General service: fuel/gas",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x24"..onpole..".obj",
		tiles = { "street_signs_service_fuel.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_service_fuel_inv.png",
		wield_image = "street_signs_service_fuel_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_service_fuel"
	})

	minetest.register_node("street_signs:sign_service_food"..onpole, {
		description = "D9-8: General service: food",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x24"..onpole..".obj",
		tiles = { "street_signs_service_food.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_service_food_inv.png",
		wield_image = "street_signs_service_food_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_service_food"
	})

	minetest.register_node("street_signs:sign_service_lodging"..onpole, {
		description = "D9-9: General service: lodging",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x24"..onpole..".obj",
		tiles = { "street_signs_service_lodging.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_service_lodging_inv.png",
		wield_image = "street_signs_service_lodging_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_service_lodging"
	})

	minetest.register_node("street_signs:sign_service_ev_charging"..onpole, {
		description = "D9-11b: General service: EV charging",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_generic_sign_24x24"..onpole..".obj",
		tiles = { "street_signs_service_ev_charging.png",
			"street_signs_sign_edge.png",
			pole_mount_tex
		},
		inventory_image = "street_signs_service_ev_charging_inv.png",
		wield_image = "street_signs_service_ev_charging_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_service_ev_charging"
	})

	cbox = street_signs.make_selection_boxes(36, 36, onpole)

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_us_route"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_us_interstate"..onpole)

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
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
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
			yaw = wmyaw
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
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
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
			yaw = wmyaw
		},
		drop = "street_signs:sign_us_interstate"
	})

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_3_line"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_4_line"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_orange_3_line"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_warning_orange_4_line"..onpole)

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
			yaw = wmyaw
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
			yaw = wmyaw
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
			yaw = wmyaw
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
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_orange_4_line"
	})

	cbox = street_signs.make_selection_boxes(30, 36, onpole)

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_speed_limit"..onpole)

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
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
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
			yaw = wmyaw
		},
		drop = "street_signs:sign_speed_limit"
	})

-- below this point are image-only signs (i.e. no user-input)

	cbox = street_signs.make_selection_boxes(36, 36, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop"
	})

	cbox = street_signs.make_selection_boxes(36, 43.1, onpole, 0, -3.55, 0)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop_all_way"
	})

	cbox = street_signs.make_selection_boxes(48, 48, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_yield"
	})

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

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_low_clearance"..onpole)

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
			yaw = wmyaw
		},
		drop = "street_signs:sign_low_clearance"
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

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_hill_with_grade_ahead"..onpole)

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
			yaw = wmyaw
		},
		drop = "street_signs:sign_hill_with_grade_ahead"
	})

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

	cbox = street_signs.make_selection_boxes(24, 30, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_do_not_stop_on_tracks"
	})

	cbox = street_signs.make_selection_boxes(9, 15, onpole, 0, 0, -1.25)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3a_right"
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3e_left"
	})

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_ped_push_button_to_cross_r10_3i"..onpole)

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
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
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
			yaw = wmyaw
		},
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3i"
	})

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_ped_push_button_to_cross_r10_3i_left"..onpole)

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
		on_construct = street_signs.construct_sign,
		on_destruct = street_signs.destruct_sign,
		after_place_node = street_signs.after_place_node,
		on_receive_fields = street_signs.receive_fields,
		on_punch = street_signs.update_sign,
		on_rotate = on_rotate,
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
			yaw = wmyaw
		},
		drop = "street_signs:sign_ped_push_button_to_cross_r10_3i_left"
	})

	cbox = street_signs.make_selection_boxes(9, 12, onpole, 0, 0, -1.25)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_ped_push_button_to_turn_on_warning_lights"
	})

	cbox = street_signs.make_selection_boxes(60, 24, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_roundabout_directional"
	})

	cbox = street_signs.make_selection_boxes(30, 36, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_left_on_green_arrow_only"
	})

	cbox = street_signs.make_selection_boxes(24, 36, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop_here_on_red"
	})

	cbox = street_signs.make_selection_boxes(30, 36, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_left_turn_yield_on_green_light"
	})

	cbox = street_signs.make_selection_boxes(24, 30, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_crosswalk_stop_on_red_light"
	})


	cbox = street_signs.make_selection_boxes(36, 48, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_keep_left"
	})

	cbox = street_signs.make_selection_boxes(36, 36, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_u_turn_here"
	})

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_straight_through_only"
	})

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_no_straight_through"
	})

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_do_not_enter"
	})

	cbox = street_signs.make_selection_boxes(42, 30, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_wrong_way"
	})

	cbox = street_signs.make_selection_boxes(54, 18, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_one_way_right"
	})

	cbox = street_signs.make_selection_boxes(30, 24, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_divided_highway_with_cross_road"
	})

	cbox = street_signs.make_selection_boxes(36, 42, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:use_lane_with_green_arrow"
	})

	cbox = street_signs.make_selection_boxes(36, 48, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:no_turn_on_red_light"
	})

	cbox = street_signs.make_selection_boxes(41, 41, onpole)

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
		after_place_node = street_signs.after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_rr_grade_crossbuck"
	})
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

for _, d in ipairs({"l", "c", "r"}) do

	cbox = street_signs.make_selection_boxes(12, 36, nil)

	minetest.register_node("street_signs:sign_object_marker_type3_"..d, {
		description = "OM3-"..string.upper(d)..": Type 3 object marker",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_object_marker_type_3.obj",
		tiles = { "street_signs_object_marker_type3_"..d..".png",
			"street_signs_sign_edge.png"
		},
		inventory_image = "street_signs_object_marker_type3_"..d.."_inv.png",
		groups = {choppy=2, dig_immediate=2},
	})
end

-- restore signs' text after /clearobjects and the like, the next time
-- a block is reloaded by the server.

minetest.register_lbm({
	nodenames = street_signs.lbm_restore_nodes,
	name = "street_signs:restore_sign_text",
	label = "Restore sign text",
	run_at_every_load = true,
	action = function(pos, node)
		street_signs.update_sign(pos)
	end
})
