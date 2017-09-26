local hues = {
	"red",
	"orange",
	"yellow",
	"lime",
	"green",
	"aqua",
	"cyan",
	"skyblue",
	"blue",
	"violet",
	"magenta",
	"redviolet",
	"grey"
}

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

minetest.register_alias("mesecons_insulated:insulated_off", "mesecons_insulated:insulated_grey_off")
minetest.register_alias("mesecons_extrawires:corner_off", "mesecons_extrawires:insulated_corner_grey_off")
minetest.register_alias("mesecons_extrawires:tjunction_off", "mesecons_extrawires:insulated_tjunction_grey_off")

for _,color in pairs(hues) do
	mesecon.register_node(":mesecons_insulated:insulated_"..color, {
		drawtype = "nodebox",
		description = "Insulated Mesecon",
		paramtype = "light",
		paramtype2 = "colorfacedir",
		walkable = false,
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		drop = "mesecons_insulated:insulated_grey_off",
		palette = "unifieddyes_palette_"..color.."s.png",
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
		groups = {dig_immediate = 3,ud_param2_colorable = 1,not_in_creative_inventory = (color~="grey" and 1 or nil)},
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
		groups = {dig_immediate = 3,not_in_creative_inventory = 1,ud_param2_colorable = 1},
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
	mesecon.register_node(":mesecons_extrawires:insulated_corner_"..color, {
		drawtype = "nodebox",
		description = "Insulated Mesecon Corner",
		paramtype = "light",
		paramtype2 = "colorfacedir",
		walkable = false,
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		drop = "mesecons_extrawires:insulated_corner_grey_off",
		palette = "unifieddyes_palette_"..color.."s.png",
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
		groups = {dig_immediate = 3,ud_param2_colorable = 1,not_in_creative_inventory = (color~="grey" and 1 or nil)},
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
		groups = {dig_immediate = 3,not_in_creative_inventory = 1,ud_param2_colorable = 1},
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
	mesecon.register_node(":mesecons_extrawires:insulated_tjunction_"..color, {
		drawtype = "nodebox",
		description = "Insulated Mesecon T-Junction",
		paramtype = "light",
		paramtype2 = "colorfacedir",
		walkable = false,
		sunlight_propagates = true,
		on_place = minetest.rotate_node,
		drop = "mesecons_extrawires:insulated_tjunction_grey_off",
		palette = "unifieddyes_palette_"..color.."s.png",
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
		groups = {dig_immediate = 3,ud_param2_colorable = 1,not_in_creative_inventory = (color~="grey" and 1 or nil)},
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
		groups = {dig_immediate = 3,not_in_creative_inventory = 1,ud_param2_colorable = 1},
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
	output = "mesecons_extrawires:insulated_corner_grey_off 3",
	recipe = {
		{"", "", ""},
		{"mesecons_insulated:insulated_grey_off", "mesecons_insulated:insulated_grey_off", ""},
		{"", "mesecons_insulated:insulated_grey_off", ""},
	}
})

minetest.register_craft({
	output = "mesecons_extrawires:insulated_tjunction_grey_off 3",
	recipe = {
		{"", "", ""},
		{"mesecons_insulated:insulated_grey_off", "mesecons_insulated:insulated_grey_off", "mesecons_insulated:insulated_grey_off"},
		{"", "mesecons_insulated:insulated_grey_off", ""},
	}
})

minetest.register_craft({
	output = "mesecons_insulated:insulated_grey_off 3",
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
		"mesecons_insulated:insulated_grey_off",
		"mesecons_insulated:insulated_grey_off",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "mesecons_insulated:insulated_grey_off 2",
	recipe = {
		"mesecons_extrawires:crossover_off",
	},
})

if minetest.get_modpath("digilines") then
	minetest.register_craft({
		output = 'digilines:wire_std_00000000 2',
		recipe = {
			{'mesecons_materials:fiber', 'mesecons_materials:fiber', 'mesecons_materials:fiber'},
			{'mesecons_insulated:insulated_grey_off', 'mesecons_insulated:insulated_grey_off', 'default:gold_ingot'},
			{'mesecons_materials:fiber', 'mesecons_materials:fiber', 'mesecons_materials:fiber'},
		}
	})
end
