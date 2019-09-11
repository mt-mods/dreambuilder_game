-- Misc./Generic signs

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
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
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
			yaw = signs_lib.wallmounted_yaw
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
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
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
			yaw = signs_lib.wallmounted_yaw
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
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
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
			yaw = signs_lib.wallmounted_yaw
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
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = signs_lib.after_place_node,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
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
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "street_signs:sign_warning_orange_4_line"
	})

	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_warning_3_line"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_warning_4_line"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_warning_orange_3_line"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_warning_orange_4_line"..onpole)
end

for _, s in ipairs(street_signs.big_sign_sizes) do
	local size =   s[1]
	local nlines = s[2]
	local nchars = s[3]
	local hscale = s[4]
	local vscale = s[5]
	local xoffs =  s[6]
	local yoffs =  s[7]
	local cbox = {
		type = "wallmounted",
		wall_side = s[8]
	}

	for _, c in ipairs(street_signs.big_sign_colors) do

		local color = c[1]
		local defc = c[2]

		minetest.register_node("street_signs:sign_highway_"..size.."_"..color, {
			description = "Generic highway sign ("..nlines.."-line, "..size..", "..color..")",
			inventory_image = "street_signs_generic_highway_"..size.."_"..color.."_inv.png",
			wield_image = "street_signs_generic_highway_"..size.."_"..color.."_inv.png",
			paramtype = "light",
			sunlight_propagates = true,
			paramtype2 = "wallmounted",
			drawtype = "mesh",
			node_box = cbox,
			selection_box = cbox,
			mesh = "street_signs_generic_highway_"..size..".obj",
			tiles = {
				"street_signs_generic_highway_front_"..size.."_"..color..".png",
				"street_signs_generic_highway_back_"..size..".png",
				"street_signs_generic_highway_edges.png"
			},
			default_color = defc,
			groups = {choppy=2, dig_immediate=2},
			on_construct = signs_lib.construct_sign,
			on_destruct = signs_lib.destruct_sign,
			on_receive_fields = signs_lib.receive_fields,
			on_punch = signs_lib.update_sign,
			on_rotate = signs_lib.wallmounted_rotate,
			number_of_lines = nlines,
			chars_per_line = nchars,
			horiz_scaling = hscale,
			vert_scaling = vscale,
			line_spacing = 2,
			font_size = 31,
			x_offset = xoffs,
			y_offset = yoffs,
			entity_info = {
				mesh = "street_signs_generic_highway_"..size.."_entity.obj",
				yaw = signs_lib.wallmounted_yaw
			}
		})

		minetest.register_node("street_signs:sign_highway_widefont_"..size.."_"..color, {
			description = "Generic highway sign (Wide font, "..nlines.."-line, "..size..", "..color..")",
			inventory_image = "street_signs_generic_highway_"..size.."_"..color.."_inv.png",
			wield_image = "street_signs_generic_highway_"..size.."_"..color.."_inv.png",
			paramtype = "light",
			sunlight_propagates = true,
			paramtype2 = "wallmounted",
			drawtype = "mesh",
			node_box = cbox,
			selection_box = cbox,
			mesh = "street_signs_generic_highway_"..size..".obj",
			tiles = {
				"street_signs_generic_highway_front_"..size.."_"..color..".png",
				"street_signs_generic_highway_back_"..size..".png",
				"street_signs_generic_highway_edges.png"
			},
			default_color = defc,
			groups = {choppy=2, dig_immediate=2},
			on_construct = signs_lib.construct_sign,
			on_destruct = signs_lib.destruct_sign,
			on_receive_fields = signs_lib.receive_fields,
			on_punch = signs_lib.update_sign,
			on_rotate = signs_lib.wallmounted_rotate,
			number_of_lines = nlines,
			chars_per_line = math.ceil(nchars/1.4),
			horiz_scaling = hscale/1.4,
			vert_scaling = vscale,
			line_spacing = 2,
			font_size = 31,
			x_offset = xoffs,
			y_offset = yoffs,
			entity_info = {
				mesh = "street_signs_generic_highway_"..size.."_entity.obj",
				yaw = signs_lib.wallmounted_yaw
			}
		})

		table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_highway_"..size.."_"..color)
		table.insert(signs_lib.lbm_restore_nodes, "street_signs:sign_highway_widefont_"..size.."_"..color)

	end
end

