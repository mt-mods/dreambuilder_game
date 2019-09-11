minetest.register_craft({
	output = "basic_signs:sign_wall_locked",
	type = "shapeless",
	recipe = {
		"default:sign_wall_wood",
		"basic_materials:padlock",
	},
})

-- craft recipes for the metal signs

minetest.register_craft( {
	output = "basic_signs:sign_wall_green",
	recipe = {
			{ "dye:dark_green", "dye:white", "dye:dark_green" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_green 2",
	recipe = {
			{ "dye:dark_green", "dye:white", "dye:dark_green" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_yellow",
	recipe = {
			{ "dye:yellow", "dye:black", "dye:yellow" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_yellow 2",
	recipe = {
			{ "dye:yellow", "dye:black", "dye:yellow" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_red",
	recipe = {
			{ "dye:red", "dye:white", "dye:red" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_red 2",
	recipe = {
			{ "dye:red", "dye:white", "dye:red" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_white_red",
	recipe = {
			{ "dye:white", "dye:red", "dye:white" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_white_red 2",
	recipe = {
			{ "dye:white", "dye:red", "dye:white" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_white_black",
	recipe = {
			{ "dye:white", "dye:black", "dye:white" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_white_black 2",
	recipe = {
			{ "dye:white", "dye:black", "dye:white" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_orange",
	recipe = {
			{ "dye:orange", "dye:black", "dye:orange" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_orange 2",
	recipe = {
			{ "dye:orange", "dye:black", "dye:orange" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_blue",
	recipe = {
			{ "dye:blue", "dye:white", "dye:blue" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_blue 2",
	recipe = {
			{ "dye:blue", "dye:white", "dye:blue" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_brown",
	recipe = {
			{ "dye:brown", "dye:white", "dye:brown" },
			{ "", "default:sign_wall_steel", "" }
	},
})

minetest.register_craft( {
	output = "basic_signs:sign_wall_brown 2",
	recipe = {
			{ "dye:brown", "dye:white", "dye:brown" },
			{ "steel:sheet_metal", "steel:sheet_metal", "steel:sheet_metal" }
	},
})
