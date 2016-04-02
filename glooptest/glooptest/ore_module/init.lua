glooptest.ore_module = {}
glooptest.debug("MESSAGE","Loading Ore Module Now!")

local stone_sounds = default.node_sound_stone_defaults()

dofile(minetest.get_modpath("glooptest").."/ore_module/api.lua")

-- HUGE NOTE HERE:
-- I did not make the textures. celeron55/erlehmann made the textures which were licensed under CC-BY-SA, and then edited by me.
-- The textures for non-gem ores are thus CC-BY-SA, with respect to celeron55/erlehmann
-- Suck it, minetest community.

glooptest.ore_module.register_ore("glooptest", "kalite", "Kalite", {
	ore = {
		makes = true, 
		drop = {
			max_items = 4,
			items = {
				{
					items = {'glooptest:kalite_lump'},
					rarity = 5,
				},
				{
					items = {'glooptest:kalite_lump'},
					rarity = 2,
				},
				{
					items = {'glooptest:kalite_lump 2'},
				},
			}
		},
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_kalite.png",
		}, 
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 9*9*9,
			chunk_size = 6,
			max_blocks_per_chunk = 7,
			miny = -31000,
			maxy = 10
		},
	},
})

minetest.register_craftitem("glooptest:kalite_lump", {
	description = "Kalite Lump",
	inventory_image = "gloopores_kalite_lump.png",
	on_use = minetest.item_eat(1),
})

minetest.register_node("glooptest:kalite_torch", {
	description = "Kalite Torch",
	drawtype = "torchlike",
	tiles = {
		{name="gloopores_kalite_torch_on_floor_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="gloopores_kalite_torch_on_ceiling_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}},
		{name="gloopores_kalite_torch_animated.png", animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=3.0}}
	},
	inventory_image = "gloopores_kalite_torch_on_floor.png",
	wield_image = "gloopores_kalite_torch_on_floor.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	light_source = LIGHT_MAX-1,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.1, 0.5-0.6, -0.1, 0.1, 0.5, 0.1},
		wall_bottom = {-0.1, -0.5, -0.1, 0.1, -0.5+0.6, 0.1},
		wall_side = {-0.5, -0.3, -0.1, -0.5+0.3, 0.3, 0.1},
	},
	groups = {choppy=2,dig_immediate=3},
	legacy_wallmounted = true,
	sounds = default.node_sound_defaults(),
})

minetest.register_craft({
	output = "glooptest:kalite_torch 4",
	recipe = {
		{"glooptest:kalite_lump"},
		{"default:stick"},
	}
})

minetest.register_craft({
	type = "fuel",
	recipe = "glooptest:kalite_lump",
	burntime = 30,
})

glooptest.ore_module.register_ore("glooptest", "alatro", "Alatro", {
	ore = {
		makes = true,
		drop = "glooptest:alatro_lump",
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_alatro.png",
		},
		groups = {cracky=2},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 9*9*9,
			chunk_size = 2,
			max_blocks_per_chunk = 6,
			miny = 0,
			maxy = 256
		},
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_alatro_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_alatro_ingot.png",
		smeltrecipe = true
	},
	block = {
		makes = true,
		texture = "gloopores_alatro_block.png",
		groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
		sounds = stone_sounds,
		fromingots = true
	},
	tools = {
		make = {
			sword = true,
			axe = true,
			pick = true,
			shovel = true
		},
		texture = {
			sword = "gloopores_tool_alatrosword.png",
			axe = "gloopores_tool_alatroaxe.png",
			pick = "gloopores_tool_alatropick.png",
			shovel = "gloopores_tool_alatroshovel.png"
		},
		caps = {
			sword = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps={
					fleshy={times={[2]=0.80, [3]=0.60}, uses=40, maxlevel=1},
					snappy={times={[2]=0.80, [3]=0.60}, uses=40, maxlevel=1},
					choppy={times={[3]=0.80}, uses=40, maxlevel=0}
				},
				damage_groups = {fleshy=5},
			},
			axe = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					choppy = {times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1},
					fleshy = {times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1}
				},
				damage_groups = {fleshy=3},
			},
			pick = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					cracky = {times={[2]=0.65, [3]=0.40}, uses=40, maxlevel=1}
				},
				damage_groups = {fleshy=3},
			},
			shovel = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					crumbly = {times={[2]=0.60, [3]=0.35}, uses=40, maxlevel=1}
				},
				damage_groups = {fleshy=3},
			},
		}
	}
})

glooptest.ore_module.register_ore("glooptest", "talinite", "Talinite", {
	ore = {
		makes = true,
		drop = "glooptest:talinite_lump",
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_talinite.png"
		},
		groups = {cracky=1},
		sounds = stone_sounds,
		light = 6,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 12*12*12,
			chunk_size = 2,
			max_blocks_per_chunk = 4,
			miny = -31000,
			maxy = -250
		}
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_talinite_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_talinite_ingot.png",
		smeltrecipe = true
	},
	block = {
		makes = true,
		texture = "gloopores_talinite_block.png",
		groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
		sounds = stone_sounds,
		light = 14,
		fromingots = true
	}
})

glooptest.ore_module.register_ore("glooptest", "akalin", "Akalin", {
	ore = {
		makes = true,
		drop = "glooptest:akalin_lump",
		texture = {
			base = "default_desert_stone.png",
			overlay = "gloopores_mineral_akalin.png"
		},
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:desert_stone",
			chunks_per_mapblock = 7*7*7,
			chunk_size = 3,
			max_blocks_per_chunk = 9,
			miny = 0,
			maxy = 256
		}
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_akalin_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_akalin_ingot.png",
		smeltrecipe = true
	},
	block = {
		makes = true,
		texture = "gloopores_akalin_block.png",
		groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
		sounds = stone_sounds,
		fromingots = true
	}
})

glooptest.ore_module.register_ore("glooptest", "arol", "Arol", {
	ore = {
		makes = true,
		drop = "glooptest:arol_lump",
		texture = {
			base = "default_stone.png",
			overlay = "gloopores_mineral_arol.png"
		},
		groups = {cracky=1},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 10*10*10,
			chunk_size = 2,
			max_blocks_per_chunk = 2,
			miny = -31000,
			maxy = -20
		}
	},
	lump = {
		makes = true,
		name = "lump",
		desc = "Lump",
		texture = "gloopores_arol_lump.png"
	},
	ingot = {
		makes = true,
		texture = "gloopores_arol_ingot.png",
		smeltrecipe = true
	},
	tools = {
		make = {
			sword = true,
			axe = true,
			pick = true,
			shovel = true
		},
		texture = {
			sword = "gloopores_tool_arolsword.png",
			axe = "gloopores_tool_arolaxe.png",
			pick = "gloopores_tool_arolpick.png",
			shovel = "gloopores_tool_arolshovel.png"
		},
		caps = {
			sword = {
				full_punch_interval = 0.5,
				max_drop_level = 2,
				groupcaps = {
					fleshy = {times={[2]=1.30, [3]=1.10}, uses=300, maxlevel=2},
					snappy = {times={[2]=1.30, [3]=1.10}, uses=300, maxlevel=2},
					choppy = {times={[3]=1.60}, uses=300, maxlevel=1}
				},
				damage_groups = {fleshy=6},
			},
			axe = {
				full_punch_interval = 0.5,
				max_drop_level = 2,
				groupcaps = {
					choppy = {times={[1]=3.30, [2]=1.30, [3]=1.00}, uses=300, maxlevel=2},
					fleshy = {times={[2]=1.60, [3]=1.00}, uses=300, maxlevel=2}
				},
				damage_groups = {fleshy=3},
			},
			pick = {
				full_punch_interval = 0.5,
				max_drop_level = 2,
				groupcaps = {
					cracky = {times={[1]=3.60, [2]=1.90, [3]=1.40}, uses=300, maxlevel=2}
				},
				damage_groups = {fleshy=3},
			},
			shovel = {
				full_punch_interval = 0.5,
				max_drop_level = 2,
				groupcaps = {
					crumbly = {times={[1]=2.70, [2]=1.45, [3]=0.85}, uses=300, maxlevel=2}
				},
				damage_groups = {fleshy=3},
			}
		}
	}
})

glooptest.ore_module.register_ore("glooptest", "desert_iron", "Desert Iron", {
	ore = {
		makes = true, 
		drop = "default:iron_lump", 
		texture = {
			base = "default_desert_stone.png",
			overlay = "default_mineral_iron.png",
		}, 
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:desert_stone",
			chunks_per_mapblock = 7*7*7,
			chunk_size = 2,
			max_blocks_per_chunk = 3,
			miny = 0,
			maxy = 10
		},
	},
})

glooptest.ore_module.register_ore("glooptest", "desert_coal", "Desert Coal", {
	ore = {
		makes = true, 
		drop = "default:coal_lump", 
		texture = {
			base = "default_desert_stone.png",
			overlay = "default_mineral_coal.png",
		}, 
		groups = {cracky=3},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:desert_stone",
			chunks_per_mapblock = 6*6*6,
			chunk_size = 3,
			max_blocks_per_chunk = 8,
			miny = 0,
			maxy = 30
		},
	},
})

-- gems

glooptest.ore_module.register_ore("glooptest", "ruby", "Ruby", {
	ore = {
		makes = true, 
		drop = "glooptest:ruby_gem",
		texture = {
			base = "default_stone.png",
			overlay = "glooptest_mineral_ruby.png",
		}, 
		groups = {cracky=1},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 15*15*15,
			chunk_size = 5,
			max_blocks_per_chunk = 5,
			miny = -3000,
			maxy = -30
		},
	},
	block = {
		makes = true,
		texture = "glooptest_ruby_block.png",
		groups = {bendy=3,cracky=2,level=1},
		sounds = stone_sounds,
		fromingots = false
	}
})

minetest.register_craftitem("glooptest:ruby_gem", {
	description = "Ruby",
	inventory_image = "glooptest_gem_ruby.png",
	groups = {glooptest_gem=1},
})
minetest.register_craft({
	output = "glooptest:rubyblock",
	recipe = {
		{"glooptest:ruby_gem", "glooptest:ruby_gem", "glooptest:ruby_gem"},
		{"glooptest:ruby_gem", "glooptest:ruby_gem", "glooptest:ruby_gem"},
		{"glooptest:ruby_gem", "glooptest:ruby_gem", "glooptest:ruby_gem"}
	}
})
minetest.register_craft({
	output = "glooptest:ruby_gem 9",
	recipe = {
		{"glooptest:rubyblock"}
	}
})

glooptest.ore_module.register_ore("glooptest", "sapphire", "Sapphire", {
	ore = {
		makes = true, 
		drop = "glooptest:sapphire_gem",
		texture = {
			base = "default_stone.png",
			overlay = "glooptest_mineral_sapphire.png",
		}, 
		groups = {cracky=1},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 15*15*15,
			chunk_size = 5,
			max_blocks_per_chunk = 5,
			miny = -3000,
			maxy = -30
		},
	},
	block = {
		makes = true,
		texture = "glooptest_sapphire_block.png",
		groups = {bendy=3,cracky=2,level=1},
		sounds = stone_sounds,
		fromingots = false
	}
})

minetest.register_craftitem("glooptest:sapphire_gem", {
	description = "Sapphire",
	inventory_image = "glooptest_gem_sapphire.png",
	groups = {glooptest_gem=1},
})
minetest.register_craft({
	output = "glooptest:sapphireblock",
	recipe = {
		{"glooptest:sapphire_gem", "glooptest:sapphire_gem", "glooptest:sapphire_gem"},
		{"glooptest:sapphire_gem", "glooptest:sapphire_gem", "glooptest:sapphire_gem"},
		{"glooptest:sapphire_gem", "glooptest:sapphire_gem", "glooptest:sapphire_gem"}
	}
})
minetest.register_craft({
	output = "glooptest:sapphire_gem 9",
	recipe = {
		{"glooptest:sapphireblock"}
	}
})

glooptest.ore_module.register_ore("glooptest", "emerald", "Emerald", {
	ore = {
		makes = true, 
		drop = "glooptest:emerald_gem",
		texture = {
			base = "default_stone.png",
			overlay = "glooptest_mineral_emerald.png",
		}, 
		groups = {cracky=1},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 15*15*15,
			chunk_size = 4,
			max_blocks_per_chunk = 4,
			miny = -5000,
			maxy = -70
		},
	},
	block = {
		makes = true,
		texture = "glooptest_emerald_block.png",
		groups = {bendy=3,cracky=2,level=1},
		sounds = stone_sounds,
		fromingots = false
	}
})

minetest.register_craftitem("glooptest:emerald_gem", {
	description = "Emerald",
	inventory_image = "glooptest_gem_emerald.png",
	groups = {glooptest_gem=1},
})
minetest.register_craft({
	output = "glooptest:emeraldblock",
	recipe = {
		{"glooptest:emerald_gem", "glooptest:emerald_gem", "glooptest:emerald_gem"},
		{"glooptest:emerald_gem", "glooptest:emerald_gem", "glooptest:emerald_gem"},
		{"glooptest:emerald_gem", "glooptest:emerald_gem", "glooptest:emerald_gem"}
	}
})
minetest.register_craft({
	output = "glooptest:emerald_gem 9",
	recipe = {
		{"glooptest:emeraldblock"}
	}
})

glooptest.ore_module.register_ore("glooptest", "topaz", "Topaz", {
	ore = {
		makes = true, 
		drop = "glooptest:topaz_gem",
		texture = {
			base = "default_stone.png",
			overlay = "glooptest_mineral_topaz.png",
		}, 
		groups = {cracky=1},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 15*15*15,
			chunk_size = 4,
			max_blocks_per_chunk = 4,
			miny = -5000,
			maxy = -70
		},
	},
	block = {
		makes = true,
		texture = "glooptest_topaz_block.png",
		groups = {bendy=3,cracky=2,level=1},
		sounds = stone_sounds,
		fromingots = false
	}
})

minetest.register_craftitem("glooptest:topaz_gem", {
	description = "Topaz",
	inventory_image = "glooptest_gem_topaz.png",
	groups = {glooptest_gem=1},
})
minetest.register_craft({
	output = "glooptest:topazblock",
	recipe = {
		{"glooptest:topaz_gem", "glooptest:topaz_gem", "glooptest:topaz_gem"},
		{"glooptest:topaz_gem", "glooptest:topaz_gem", "glooptest:topaz_gem"},
		{"glooptest:topaz_gem", "glooptest:topaz_gem", "glooptest:topaz_gem"}
	}
})
minetest.register_craft({
	output = "glooptest:topaz_gem 9",
	recipe = {
		{"glooptest:topazblock"}
	}
})

glooptest.ore_module.register_ore("glooptest", "amethyst", "Amethyst", {
	ore = {
		makes = true, 
		drop = "glooptest:amethyst_gem",
		texture = {
			base = "default_stone.png",
			overlay = "glooptest_mineral_amethyst.png",
		}, 
		groups = {cracky=1},
		sounds = stone_sounds,
		generate = {
			generate_inside_of = "default:stone",
			chunks_per_mapblock = 15*15*15,
			chunk_size = 3,
			max_blocks_per_chunk = 3,
			miny = -31000,
			maxy = -128
		},
	},
	block = {
		makes = true,
		texture = "glooptest_amethyst_block.png",
		groups = {bendy=3,cracky=2,level=1},
		sounds = stone_sounds,
		fromingots = false
	}
})

minetest.register_craftitem("glooptest:amethyst_gem", {
	description = "Amethyst",
	inventory_image = "glooptest_gem_amethyst.png",
	groups = {glooptest_gem=1},
})
minetest.register_craft({
	output = "glooptest:amethystblock",
	recipe = {
		{"glooptest:amethyst_gem", "glooptest:amethyst_gem", "glooptest:amethyst_gem"},
		{"glooptest:amethyst_gem", "glooptest:amethyst_gem", "glooptest:amethyst_gem"},
		{"glooptest:amethyst_gem", "glooptest:amethyst_gem", "glooptest:amethyst_gem"}
	}
})
minetest.register_craft({
	output = "glooptest:amethyst_gem 9",
	recipe = {
		{"glooptest:amethystblock"}
	}
})
