glooptest.parts_module = {}
glooptest.debug("MESSAGE","Loading Parts Module Now!")

minetest.register_craftitem("glooptest:chainlink", {
	description = "Chainlink",
	inventory_image = "glooptest_chainlink.png"
})

minetest.register_craft({
	output = "glooptest:chainlink 8",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "", "default:steel_ingot"},
		{"", "default:steel_ingot", ""}
	}
})

minetest.register_node("glooptest:crystal_glass", {
	description = "Crystal Glass",
	drawtype = "allfaces",
	tiles = {"glooptest_crystal_glass.png"},
	inventory_image = minetest.inventorycube("glooptest_crystal_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "glooptest:crystal_glass 4",
	recipe = {
		{"default:glass", "default:desert_stone"},
		{"default:desert_stone", "default:glass"},
	}
})

minetest.register_craft({
	output = "glooptest:crystal_glass 4",
	recipe = {
		{"default:desert_stone", "default:glass"},
		{"default:glass", "default:desert_stone"},
	}
})

minetest.register_node("glooptest:reinforced_crystal_glass", {
	description = "Steel-Reinforced Crystal Glass",
	drawtype = "allfaces",
	tiles = {"glooptest_reinforced_crystal_glass.png"},
	inventory_image = minetest.inventorycube("glooptest_reinforced_crystal_glass.png"),
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craft({
	output = "glooptest:reinforced_crystal_glass 8",
	recipe = {
		{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"},
		{"glooptest:crystal_glass", "default:steel_ingot", "glooptest:crystal_glass"},
		{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"}
	}
})

if LOAD_ORE_MODULE == true then

	minetest.register_node("glooptest:akalin_crystal_glass", {
		description = "Akalin-Reinforced Crystal Glass",
		drawtype = "allfaces",
		tiles = {"glooptest_akalin_crystal_glass.png"},
		inventory_image = minetest.inventorycube("glooptest_akalin_crystal_glass.png"),
		paramtype = "light",
		sunlight_propagates = true,
		groups = {cracky=2},
		sounds = default.node_sound_glass_defaults(),
	})
	
	minetest.register_craft({
		output = "glooptest:akalin_crystal_glass 8",
		recipe = {
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:akalin_ingot", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"}
		}
	})
	
	minetest.register_node("glooptest:heavy_crystal_glass", {
		description = "Heavily Reinforced Crystal Glass",
		drawtype = "allfaces",
		tiles = {"glooptest_reinforced_akalin_crystal_glass.png"},
		inventory_image = minetest.inventorycube("glooptest_reinforced_akalin_crystal_glass.png"),
		paramtype = "light",
		sunlight_propagates = true,
		groups = {cracky=1},
		sounds = default.node_sound_glass_defaults(),
	})
	
	minetest.register_craft({
		output = "glooptest:heavy_crystal_glass 4",
		recipe = {
			{"glooptest:reinforced_crystal_glass", "glooptest:akalin_crystal_glass"},
			{"glooptest:akalin_crystal_glass", "glooptest:reinforced_crystal_glass"},
		}
	})
	
	minetest.register_craft({
		output = "glooptest:heavy_crystal_glass 4",
		recipe = {
			{"glooptest:akalin_crystal_glass", "glooptest:reinforced_crystal_glass"},
			{"glooptest:reinforced_crystal_glass", "glooptest:akalin_crystal_glass"},
		}
	})
	
	minetest.register_node("glooptest:alatro_crystal_glass", {
		description = "Alatro-Reinforced Crystal Glass",
		drawtype = "allfaces",
		tiles = {"glooptest_alatro_crystal_glass.png"},
		use_texture_alpha = true,
		inventory_image = minetest.inventorycube("glooptest_alatro_crystal_glass.png"),
		paramtype = "light",
		groups = {cracky=2},
		sounds = default.node_sound_glass_defaults(),
	})
	
	minetest.register_craft({
		output = "glooptest:alatro_crystal_glass 8",
		recipe = {
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:alatro_ingot", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"}
		}
	})

	minetest.register_node("glooptest:arol_crystal_glass", {
		description = "Arol-Reinforced Crystal Glass",
		drawtype = "allfaces",
		tiles = {"glooptest_arol_crystal_glass.png"},
		inventory_image = minetest.inventorycube("glooptest_arol_crystal_glass.png"),
		paramtype = "light",
		sunlight_propagates = true,
		groups = {cracky=1},
		sounds = default.node_sound_glass_defaults(),
	})
	
	minetest.register_craft({
		output = "glooptest:arol_crystal_glass 8",
		recipe = {
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:arol_ingot", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"}
		}
	})
	
	minetest.register_node("glooptest:talinite_crystal_glass", {
		description = "Talinite-Reinforced Crystal Glass",
		drawtype = "allfaces",
		tiles = {"glooptest_talinite_crystal_glass.png"},
		inventory_image = minetest.inventorycube("glooptest_talinite_crystal_glass.png"),
		paramtype = "light",
		sunlight_propagates = true,
		light_source = 14,
		groups = {cracky=2},
		sounds = default.node_sound_glass_defaults(),
	})
	
	minetest.register_craft({
		output = "glooptest:talinite_crystal_glass 8",
		recipe = {
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:talinite_ingot", "glooptest:crystal_glass"},
			{"glooptest:crystal_glass", "glooptest:crystal_glass", "glooptest:crystal_glass"}
		}
	})
end