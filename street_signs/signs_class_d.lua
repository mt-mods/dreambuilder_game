-- Class D signs

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
end

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
	horiz_scaling = 1.5,
	vert_scaling = 1,
	line_spacing = 9,
	font_size = 31,
	x_offset = 7,
	y_offset = 4,
	chars_per_line = 40,
	entity_info = {
		mesh = "street_signs_basic_entity.obj",
		yaw = street_signs.standard_yaw
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
	horiz_scaling = 1.5,
	vert_scaling = 1,
	line_spacing = 9,
	font_size = 31,
	x_offset = 7,
	y_offset = 4,
	chars_per_line = 40,
	entity_info = {
		mesh = "street_signs_basic_top_only_entity.obj",
		yaw = street_signs.standard_yaw
	}
})

table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_basic")
table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_basic_top_only")
