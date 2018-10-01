-- Class-M signs

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
			yaw = street_signs.wallmounted_yaw
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
			yaw = street_signs.wallmounted_yaw
		},
		drop = "street_signs:sign_us_interstate"
	})

	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_us_route"..onpole)
	table.insert(street_signs.lbm_restore_nodes, "street_signs:sign_us_interstate"..onpole)
end
