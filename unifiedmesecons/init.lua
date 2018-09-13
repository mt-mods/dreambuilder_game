local hues = table.copy(unifieddyes.HUES_WITH_GREY)
for _,i in ipairs({"pink","dark_green","brown","black","dark_grey","white"}) do
	table.insert(hues, i)
end

local explist = {}
for _,i in ipairs(hues) do
	explist[i] = true
end

local function insulated_wire_get_rules(node)
	local rules = 	{{x = 1,  y = 0,  z = 0},
			 {x =-1,  y = 0,  z = 0}}
	if node.param2%32 == 1 or node.param2%32 == 3 then
		return mesecon.rotate_rules_right(rules)
	end
	return rules
end

local tjunction_get_rules = function (node)
	local rules =
	{{x = 0,  y = 0,  z =  1},
	 {x = 1,  y = 0,  z =  0},
	 {x = 0,  y = 0,  z = -1}}

	for i = 0, node.param2%32 do
		rules = mesecon.rotate_rules_left(rules)
	end

	return rules
end

local corner_get_rules = function (node)
	local rules =
	{{x = 1,  y = 0,  z =  0},
	 {x = 0,  y = 0,  z = -1}}

	for i = 0, node.param2%32 do
		rules = mesecon.rotate_rules_left(rules)
	end

	return rules
end

minetest.unregister_item("mesecons_insulated:insulated_off")
minetest.unregister_item("mesecons_insulated:insulated_on")
minetest.unregister_item("mesecons_extrawires:corner_off")
minetest.unregister_item("mesecons_extrawires:corner_on")
minetest.unregister_item("mesecons_extrawires:tjunction_off")
minetest.unregister_item("mesecons_extrawires:tjunction_on")

minetest.register_alias("mesecons_insulated:insulated_off", "mesecons_insulated:insulated_white_off")
minetest.register_alias("mesecons_extrawires:corner_off", "mesecons_extrawires:insulated_corner_white_off")
minetest.register_alias("mesecons_extrawires:tjunction_off", "mesecons_extrawires:insulated_tjunction_white_off")

for _,color in pairs(hues) do
	local cstart = 30
	local cend = cstart + string.len(color) - 1

	local palettecolor = color
	if color == "black" or string.find(color, "grey") or color == "white" then
		palettecolor = "grey"
	elseif color == "pink" then
		palettecolor = "red"
	elseif color == "dark_green" then
		palettecolor = "green"
	elseif color == "brown" then
		palettecolor = "orange"
	end
	mesecon.register_node(":mesecons_insulated:insulated_"..color, {
		drawtype = "nodebox",
		description = "Insulated Mesecon",
		paramtype = "light",
		paramtype2 = "colorfacedir",
		walkable = false,
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		drop = "mesecons_insulated:insulated_white_off",
		palette = "unifieddyes_palette_"..palettecolor.."s.png",
		ud_color_start = cstart,
		ud_color_end = cend,
		explist = explist,
		selection_box = {
			type = "fixed",
			fixed = { -16/32-0.001, -18/32, -7/32, 16/32+0.001, -12/32, 7/32 }
		},
		node_box = {
			type = "fixed",
			fixed = { -16/32-0.001, -17/32, -3/32, 16/32+0.001, -13/32, 3/32 }
		},
	},
	{
		groups = {ud_param2_colorable = 1, dig_immediate = 3,not_in_creative_inventory = (color~="white" and 1 or nil)},
		mesecons = {conductor = {
			state = mesecon.state.off,
			onstate = "mesecons_insulated:insulated_"..color.."_on",
			rules = insulated_wire_get_rules
		}},
		tiles = {
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_end_off.png",
			"unifiedmesecons_wire_end_off.png",
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_off.png",
		},
	},
	{
		groups = {ud_param2_colorable = 1, dig_immediate = 3,not_in_creative_inventory = 1},
		mesecons = {conductor = {
			state = mesecon.state.on,
			offstate = "mesecons_insulated:insulated_"..color.."_off",
			rules = insulated_wire_get_rules
		}},
		tiles = {
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_end_on.png",
			"unifiedmesecons_wire_end_on.png",
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_on.png",
		},
	})

	cstart = 38
	cend = cstart + string.len(color) - 1

	mesecon.register_node(":mesecons_extrawires:insulated_corner_"..color, {
		drawtype = "nodebox",
		description = "Insulated Mesecon Corner",
		paramtype = "light",
		paramtype2 = "colorfacedir",
		walkable = false,
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		drop = "mesecons_extrawires:insulated_corner_white_off",
		palette = "unifieddyes_palette_"..palettecolor.."s.png",
		ud_color_start = cstart,
		ud_color_end = cend,
		explist = explist,
		selection_box = {
				type = "fixed",
				fixed = { -16/32-0.001, -18/32, -16/32, 5/32, -12/32, 5/32 },
		},
		node_box = {
			type = "fixed",
			fixed = {{ -16/32-0.001, -17/32, -3/32, 0, -13/32, 3/32 },
				   { -3/32, -17/32, -16/32+0.001, 3/32, -13/32, 3/32}},
		},
	},
	{
		groups = {ud_param2_colorable = 1, dig_immediate = 3,not_in_creative_inventory = (color~="white" and 1 or nil)},
		mesecons = {conductor = {
			state = mesecon.state.off,
			onstate = "mesecons_extrawires:insulated_corner_"..color.."_on",
			rules = corner_get_rules
		}},
		tiles = {
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_end_off.png",
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_end_off.png",
		},
	},
	{
		groups = {ud_param2_colorable = 1, dig_immediate = 3,not_in_creative_inventory = 1},
		mesecons = {conductor = {
			state = mesecon.state.on,
			offstate = "mesecons_extrawires:insulated_corner_"..color.."_off",
			rules = corner_get_rules
		}},
		tiles = {
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_end_on.png",
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_end_on.png",
		},
	})

	cstart = 41
	cend = cstart + string.len(color) - 1

	mesecon.register_node(":mesecons_extrawires:insulated_tjunction_"..color, {
		drawtype = "nodebox",
		description = "Insulated Mesecon T-Junction",
		paramtype = "light",
		paramtype2 = "colorfacedir",
		walkable = false,
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		drop = "mesecons_extrawires:insulated_tjunction_white_off",
		palette = "unifieddyes_palette_"..palettecolor.."s.png",
		ud_color_start = cstart,
		ud_color_end = cend,
		explist = explist,
		node_box = {
			type = "fixed",
			fixed = {{ -16/32-0.001, -17/32, -3/32, 16/32+0.001, -13/32, 3/32 },
				 { -3/32, -17/32, -16/32+0.001, 3/32, -13/32, -3/32},},
		},
		selection_box = {
				type = "fixed",
				fixed = { -16/32-0.001, -18/32, -16/32, 16/32+0.001, -12/32, 7/32 },
		},
	},
	{
		groups = {ud_param2_colorable = 1, dig_immediate = 3,not_in_creative_inventory = (color~="white" and 1 or nil)},
		mesecons = {conductor = {
			state = mesecon.state.off,
			onstate = "mesecons_extrawires:insulated_tjunction_"..color.."_on",
			rules = tjunction_get_rules
		}},
		tiles = {
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_end_off.png",
			"unifiedmesecons_wire_end_off.png",
			"unifiedmesecons_wire_off.png",
			"unifiedmesecons_wire_end_off.png",
		},
	},
	{
		groups = {ud_param2_colorable = 1, dig_immediate = 3,not_in_creative_inventory = 1},
		mesecons = {conductor = {
			state = mesecon.state.on,
			offstate = "mesecons_extrawires:insulated_tjunction_"..color.."_off",
			rules = tjunction_get_rules
		}},
		tiles = {
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_end_on.png",
			"unifiedmesecons_wire_end_on.png",
			"unifiedmesecons_wire_on.png",
			"unifiedmesecons_wire_end_on.png",
		},
	})
end

minetest.override_item("mesecons_extrawires:crossover_off",{
	tiles = {
		"unifiedmesecons_wire_end_off.png",
		"unifiedmesecons_wire_off.png",
		"unifiedmesecons_wire_off.png",
		"unifiedmesecons_wire_end_off.png",
	},
})

minetest.override_item("mesecons_extrawires:crossover_01",{
	tiles = {
		"unifiedmesecons_wire_end_on.png",
		"unifiedmesecons_wire_on.png",
		"unifiedmesecons_wire_off.png",
		"unifiedmesecons_wire_end_off.png",
	},
})

minetest.override_item("mesecons_extrawires:crossover_10",{
	tiles = {
		"unifiedmesecons_wire_end_off.png",
		"unifiedmesecons_wire_off.png",
		"unifiedmesecons_wire_on.png",
		"unifiedmesecons_wire_end_on.png",
	},
})

minetest.override_item("mesecons_extrawires:crossover_on",{
	tiles = {
		"unifiedmesecons_wire_end_on.png",
		"unifiedmesecons_wire_on.png",
		"unifiedmesecons_wire_on.png",
		"unifiedmesecons_wire_end_on.png",
	},
})

minetest.register_lbm({
	name = "unifiedmesecons:convert",
	label = "Convert insulated mesecons to use param2 coloring",
	nodenames = {
		"mesecons_insulated:insulated_off",
		"mesecons_insulated:insulated_on",
		"mesecons_extrawires:corner_off",
		"mesecons_extrawires:corner_on",
		"mesecons_extrawires:tjunction_off",
		"mesecons_extrawires:tjunction_on",
	},
	action = function(pos,node)
		local name = node.name
		if string.find(name,"insulated") then
			name = "mesecons_insulated:insulated_blue_"
		elseif string.find(name,"corner") then
			name = "mesecons_extrawires:insulated_corner_blue_"
		elseif string.find(name,"tjunction") then
			name = "mesecons_extrawires:insulated_tjunction_blue_"
		end
		if string.sub(node.name,-3,-1) == "_on" then
			node.name = name.."on"
		else
			node.name = name.."off"
		end
		node.param2 = (node.param2 % 32) + 128
		minetest.swap_node(pos,node)
	end,
})

minetest.register_craft({
	output = "mesecons_extrawires:insulated_corner_white_off 3",
	recipe = {
		{"", "", ""},
		{"mesecons_insulated:insulated_white_off", "mesecons_insulated:insulated_white_off", ""},
		{"", "mesecons_insulated:insulated_white_off", ""},
	}
})

minetest.register_craft({
	output = "mesecons_extrawires:insulated_tjunction_white_off 3",
	recipe = {
		{"", "", ""},
		{"mesecons_insulated:insulated_white_off", "mesecons_insulated:insulated_white_off", "mesecons_insulated:insulated_white_off"},
		{"", "mesecons_insulated:insulated_white_off", ""},
	}
})

minetest.register_craft({
	output = "mesecons_insulated:insulated_white_off 3",
	recipe = {
		{"mesecons_materials:fiber", "mesecons_materials:fiber", "mesecons_materials:fiber"},
		{"mesecons:wire_00000000_off", "mesecons:wire_00000000_off", "mesecons:wire_00000000_off"},
		{"mesecons_materials:fiber", "mesecons_materials:fiber", "mesecons_materials:fiber"},
	}
})

minetest.register_craft({
	type = "shapeless",
	output = "mesecons_extrawires:crossover_off",
	recipe = {
		"mesecons_insulated:insulated_white_off",
		"mesecons_insulated:insulated_white_off",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "mesecons_insulated:insulated_white_off 2",
	recipe = {
		"mesecons_extrawires:crossover_off",
	},
})

if minetest.get_modpath("digilines") then
	minetest.register_craft({
		output = 'digilines:wire_std_00000000 2',
		recipe = {
			{'mesecons_materials:fiber', 'mesecons_materials:fiber', 'mesecons_materials:fiber'},
			{'mesecons_insulated:insulated_white_off', 'mesecons_insulated:insulated_white_off', 'default:gold_ingot'},
			{'mesecons_materials:fiber', 'mesecons_materials:fiber', 'mesecons_materials:fiber'},
		}
	})
end

for _,color in pairs(hues) do
	if color ~= "white" then
		local dye = "dye:"..color
		minetest.register_craft({
			output = unifieddyes.make_colored_itemstack(
				"mesecons_extrawires:insulated_corner_"..color.."_off 3",
				"split",
				dye),
			recipe = {
				{"", dye, ""},
				{"mesecons_insulated:insulated_white_off", "mesecons_insulated:insulated_white_off", ""},
				{"", "mesecons_insulated:insulated_white_off", ""},
			}
		})

		minetest.register_craft({
			output = unifieddyes.make_colored_itemstack(
				"mesecons_extrawires:insulated_tjunction_"..color.."_off 3",
				"split",
				dye),
			recipe = {
				{"", dye, ""},
				{"mesecons_insulated:insulated_white_off", "mesecons_insulated:insulated_white_off", "mesecons_insulated:insulated_white_off"},
				{"", "mesecons_insulated:insulated_white_off", ""},
			}
		})

		minetest.register_craft({
			type = "shapeless",
			output = unifieddyes.make_colored_itemstack(
				"mesecons_insulated:insulated_"..color.."_off",
				"split",
				dye),
			recipe = {
				dye,
				"mesecons_insulated:insulated_white_off",
			},
		})

		minetest.register_craft({
			output = unifieddyes.make_colored_itemstack(
				"mesecons_extrawires:insulated_corner_"..color.."_off",
				"split",
				dye),
			type = "shapeless",
			recipe = {
				dye,
				"mesecons_extrawires:insulated_corner_white_off"
			}
		})

		minetest.register_craft({
			output = unifieddyes.make_colored_itemstack(
				"mesecons_extrawires:insulated_tjunction_"..color.."_off",
				"split",
				dye),
			type = "shapeless",
			recipe = {
				dye,
				"mesecons_extrawires:insulated_tjunction_white_off"
			}
		})
	end
end

for _,color in pairs(hues) do -- allow re-dying of grey wires since they're so lightly-shaded.
	if color ~= "grey" then
		local dye = "dye:"..color

		minetest.register_craft({
			type = "shapeless",
			output = unifieddyes.make_colored_itemstack(
				"mesecons_insulated:insulated_"..color.."_off",
				"split",
				dye),
			recipe = {
				dye,
				"mesecons_insulated:insulated_grey_off",
			},
		})

		minetest.register_craft({
			output = unifieddyes.make_colored_itemstack(
				"mesecons_extrawires:insulated_corner_"..color.."_off",
				"split",
				dye),
			type = "shapeless",
			recipe = {
				dye,
				"mesecons_extrawires:insulated_corner_grey_off"
			}
		})

		minetest.register_craft({
			output = unifieddyes.make_colored_itemstack(
				"mesecons_extrawires:insulated_tjunction_"..color.."_off",
				"split",
				dye),
			type = "shapeless",
			recipe = {
				dye,
				"mesecons_extrawires:insulated_tjunction_grey_off"
			}
		})
	end
end

for _,a in ipairs({{"skyblue","azure"}, {"redviolet","rose"}, {"aqua","spring"}}) do
	for _,s in ipairs({"_", "_corner_", "_tjunction_"}) do
		minetest.register_alias("mesecons_extrawires:insulated"..s..a[1].."_off",
								"mesecons_extrawires:insulated"..s..a[2].."_off")
		minetest.register_alias("mesecons_extrawires:insulated"..s..a[1].."_on",
								"mesecons_extrawires:insulated"..s..a[2].."_on")
	end
end
