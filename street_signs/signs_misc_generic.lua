-- Misc./Generic signs
local S = signs_lib.gettext
local cbox = signs_lib.make_selection_boxes(36, 36)

signs_lib.register_sign("street_signs:sign_warning_3_line", {
	description = "W3-4: Generic US diamond \"warning\" sign (3-line, yellow)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_warning.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_warning_3_line_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 3,
	horiz_scaling = 1.75,
	vert_scaling = 1.75,
	line_spacing = 1,
	font_size = 15,
	x_offset = 6,
	y_offset = 19,
	chars_per_line = 15,
	entity_info = {
		mesh = "street_signs_warning_36x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	drop = "street_signs:sign_warning_3_line",
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})


signs_lib.register_sign("street_signs:sign_warning_4_line", {
	description = "W23-2: Generic US diamond \"warning\" sign (4-line, yellow)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_warning.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_warning_4_line_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 4,
	horiz_scaling = 1.75,
	vert_scaling = 1.75,
	line_spacing = 1,
	font_size = 15,
	x_offset = 6,
	y_offset = 25,
	chars_per_line = 15,
	entity_info = {
		mesh = "street_signs_warning_36x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	drop = "street_signs:sign_warning_4_line",
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_warning_orange_3_line", {
	description = "W3-4: Generic US diamond \"warning\" sign (3-line, orange)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_warning_orange.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_warning_orange_3_line_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 3,
	horiz_scaling = 1.75,
	vert_scaling = 1.75,
	line_spacing = 1,
	font_size = 15,
	x_offset = 6,
	y_offset = 19,
	chars_per_line = 15,
	entity_info = {
		mesh = "street_signs_warning_36x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	drop = "street_signs:sign_warning_orange_3_line",
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

signs_lib.register_sign("street_signs:sign_warning_orange_4_line", {
	description = "W23-2: Generic US diamond \"warning\" sign (4-line, orange)",
	selection_box = cbox,
	mesh = "street_signs_warning_36x36_wall.obj",
	tiles = {
		"street_signs_warning_orange.png",
		"street_signs_sign_edge.png",
	},
	inventory_image = "street_signs_warning_orange_4_line_inv.png",
	groups = signs_lib.standard_steel_groups,
	sounds = signs_lib.standard_steel_sign_sounds,
	number_of_lines = 4,
	horiz_scaling = 1.75,
	vert_scaling = 1.75,
	line_spacing = 1,
	font_size = 15,
	x_offset = 6,
	y_offset = 25,
	chars_per_line = 15,
	entity_info = {
		mesh = "street_signs_warning_36x36_entity_wall.obj",
		yaw = signs_lib.wallmounted_yaw
	},
	drop = "street_signs:sign_warning_orange_4_line",
	allow_widefont = true,
	allow_onpole = true,
	allow_onpole_horizontal = true,
})

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
		wall_side = s[8],
		wall_top =    { -s[8][3], -s[8][1], s[8][2], -s[8][6], -s[8][4], s[8][5] },
		wall_bottom = {  s[8][3],  s[8][1], s[8][2],  s[8][6],  s[8][4], s[8][5] }
	}
	for _, c in ipairs(street_signs.big_sign_colors) do
		local color = c[1]
		local defc = c[2]
		
		signs_lib.register_sign("street_signs:sign_highway_"..size.."_"..color, {
			description = "Generic highway sign ("..nlines.."-line, "..size..", "..color..")",
			inventory_image = "street_signs_generic_highway_"..size.."_"..color.."_inv.png",
			selection_box = cbox,
			mesh = "street_signs_generic_highway_"..size.."_wall.obj",
			tiles = {
				"street_signs_generic_highway_"..size.."_"..color..".png",
				"street_signs_generic_highway_edges.png"
			},
			default_color = defc,
			groups = signs_lib.standard_steel_groups,
			sounds = signs_lib.standard_steel_sign_sounds,
			number_of_lines = nlines,
			chars_per_line = nchars,
			horiz_scaling = hscale,
			vert_scaling = vscale,
			line_spacing = 2,
			font_size = 31,
			x_offset = xoffs,
			y_offset = yoffs,
			entity_info = {
				mesh = "street_signs_generic_highway_"..size.."_entity_wall.obj",
				yaw = signs_lib.wallmounted_yaw
			},
			allow_widefont = true,
			allow_onpole = true
		})

		minetest.register_alias("street_signs:sign_highway_widefont_"..size.."_"..color,
			"street_signs:sign_highway_"..size.."_"..color.."_widefont")
	end
end
