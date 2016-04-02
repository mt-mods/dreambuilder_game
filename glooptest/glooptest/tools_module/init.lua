glooptest.tools_module = {}
glooptest.debug("MESSAGE","Loading Tools Module Now!")

dofile(minetest.get_modpath("glooptest").."/tools_module/api.lua")

glooptest.tools_module.register_tools("glooptest", "wood", "Wooden", "group:wood", {
	handsaw = {
		makes = true,
		texture = "glooptest_tool_woodhandsaw.png",
		caps = {
			full_punch_interval = 1.0,
			max_drop_level = 0,
			groupcaps = {
				snappy = {times={[2]=1.10, [3]=0.60}, uses=10, maxlevel=1},
				fleshy = {times={[3]=0.90}, uses=10, maxlevel=0}
			},
			damage_groups = {fleshy=2, snappy=3},
		},
	},
	hammer = {
		makes = true,
		texture = "glooptest_tool_woodhammer.png",
		caps = {
			full_punch_interval = 1.0,
			max_drop_level = 0,
			groupcaps = {
				bendy = {times={[2]=1.00, [3]=0.55}, uses=10, maxlevel=1},
				cracky = {times={[3]=1.10}, uses=10, maxlevel=0}
			},
			damage_groups = {fleshy=2, bendy=2, cracky=1},
		},
	},
})

glooptest.tools_module.register_tools("glooptest", "stone", "Stone", "group:stone", {
	handsaw = {
		makes = true,
		texture = "glooptest_tool_stonehandsaw.png",
		caps = {
			full_punch_interval = 1.1,
			max_drop_level = 0,
			groupcaps = {
				snappy = {times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
				fleshy = {times={[3]=0.70}, uses=20, maxlevel=0}
			},
			damage_groups = {fleshy=3, snappy=3},
		},
	},
	hammer = {
		makes = true,
		texture = "glooptest_tool_stonehammer.png",
		caps = {
			full_punch_interval = 1.1,
			max_drop_level = 0,
			groupcaps = {
				bendy = {times={[2]=0.90, [3]=0.60}, uses=20, maxlevel=1},
				cracky = {times={[3]=1.00}, uses=20, maxlevel=0}
			},
			damage_groups = {fleshy=2, bendy=2, cracky=1},
		},
	},
})

glooptest.tools_module.register_tools("glooptest", "steel", "Steel", "default:steel_ingot", {
	handsaw = {
		makes = true,
		texture = "glooptest_tool_steelhandsaw.png",
		caps = {
			full_punch_interval = 0.9,
			max_drop_level = 0,
			groupcaps = {
				snappy = {times={[1]=1.00, [2]=0.65, [3]=0.25}, uses=30, maxlevel=2},
				fleshy = {times={[2]=1.10, [3]=0.60}, uses=30, maxlevel=1}
			},
			damage_groups = {fleshy=4, snappy=5},
		},
	},
	hammer = {
		makes = true,
		texture = "glooptest_tool_steelhammer.png",
		caps = {
			full_punch_interval = 1.0,
			max_drop_level = 0,
			groupcaps = {
				bendy = {times={[1]=1.30, [2]=0.80, [3]=0.50}, uses=30, maxlevel=2},
				cracky = {times={[2]=1.80, [3]=0.90}, uses=30, maxlevel=0}
			},
			damage_groups = {fleshy=3, bendy=3, cracky=2},
		},
	},
})

glooptest.tools_module.register_tools("glooptest", "bronze", "Bronze", "default:bronze_ingot", {
	handsaw = {
		makes = true,
		texture = "glooptest_tool_bronzehandsaw.png",
		caps = {
			full_punch_interval = 0.9,
			max_drop_level = 0,
			groupcaps = {
				snappy = {times={[1]=1.00, [2]=0.65, [3]=0.25}, uses=40, maxlevel=2},
				fleshy = {times={[2]=1.10, [3]=0.60}, uses=40, maxlevel=1}
			},
			damage_groups = {fleshy=4, snappy=5},
		},
	},
	hammer = {
		makes = true,
		texture = "glooptest_tool_bronzehammer.png",
		caps = {
			full_punch_interval = 1.0,
			max_drop_level = 0,
			groupcaps = {
				bendy = {times={[1]=1.30, [2]=0.80, [3]=0.50}, uses=40, maxlevel=2},
				cracky = {times={[2]=1.80, [3]=0.90}, uses=40, maxlevel=0}
			},
			damage_groups = {fleshy=3, bendy=3, cracky=2},
		},
	},
})

glooptest.tools_module.register_tools("glooptest", "mese", "Mese", "default:mese_crystal", {
	handsaw = {
		makes = true,
		texture = "glooptest_tool_mesehandsaw.png",
		caps = {
			full_punch_interval = 0.9,
			max_drop_level = 0,
			groupcaps = {
				snappy = {times={[1]=0.70, [2]=0.40, [3]=0.20}, uses=30, maxlevel=3},
				fleshy = {times={[2]=1.00, [3]=0.55}, uses=30, maxlevel=1}
			},
			damage_groups = {fleshy=5, snappy=6},
		},
	},
	hammer = {
		makes = true,
		texture = "glooptest_tool_mesehammer.png",
		caps = {
			full_punch_interval = 1.0,
			max_drop_level = 0,
			groupcaps = {
				bendy = {times={[1]=1.00, [2]=0.60, [3]=0.40}, uses=30, maxlevel=3},
				cracky = {times={[2]=1.70, [3]=0.85}, uses=30, maxlevel=0}
			},
			damage_groups = {fleshy=4, bendy=4, cracky=2},
		},
	},
})

glooptest.tools_module.register_tools("glooptest", "diamond", "Diamond", "default:diamond", {
	handsaw = {
		makes = true,
		texture = "glooptest_tool_diamondhandsaw.png",
		caps = {
			full_punch_interval = 0.9,
			max_drop_level = 0,
			groupcaps = {
				snappy = {times={[1]=0.60, [2]=0.30, [3]=0.20}, uses=30, maxlevel=3},
				fleshy = {times={[2]=0.90, [3]=0.55}, uses=30, maxlevel=1}
			},
			damage_groups = {fleshy=5, snappy=7},
		},
	},
	hammer = {
		makes = true,
		texture = "glooptest_tool_diamondhammer.png",
		caps = {
			full_punch_interval = 1.0,
			max_drop_level = 0,
			groupcaps = {
				bendy = {times={[1]=0.90, [2]=0.50, [3]=0.40}, uses=30, maxlevel=3},
				cracky = {times={[2]=1.70, [3]=0.85}, uses=30, maxlevel=0}
			},
			damage_groups = {fleshy=4, bendy=5, cracky=2},
		},
	},
})

if LOAD_ORE_MODULE == true then
	glooptest.tools_module.register_tools("glooptest", "alatro", "Alatro", "glooptest:alatro_ingot", {
		handsaw = {
			makes = true,
			texture = "glooptest_tool_alatrohandsaw.png",
			caps = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					snappy = {times={[2]=0.70, [3]=0.30}, uses=40, maxlevel=1},
					fleshy = {times={[3]=0.65}, uses=40, maxlevel=0}
				},
				damage_groups = {fleshy=3, snappy=3},
			},
		},
		hammer = {
			makes = true,
			texture = "glooptest_tool_alatrohammer.png",
			caps = {
				full_punch_interval = 1.0,
				max_drop_level = 0,
				groupcaps = {
					bendy = {times={[2]=0.85, [3]=0.55}, uses=40, maxlevel=1},
					cracky = {times={[3]=0.95}, uses=40, maxlevel=0}
				},
				damage_groups = {fleshy=2, bendy=2, cracky=1},
			},
		},
	})
	glooptest.tools_module.register_tools("glooptest", "arol", "Arol", "glooptest:arol_ingot", {
		handsaw = {
			makes = true,
			texture = "glooptest_tool_arolhandsaw.png",
			caps = {
				full_punch_interval = 0.5,
				max_drop_level = 0,
				groupcaps = {
					snappy = {times={[2]=1.00, [3]=0.80}, uses=300, maxlevel=1},
					fleshy = {times={[3]=1.20}, uses=300, maxlevel=0}
				},
				damage_groups = {fleshy=3, snappy=3},
			},
		},
		hammer = {
			makes = true,
			texture = "glooptest_tool_arolhammer.png",
			caps = {
				full_punch_interval = 0.5,
				max_drop_level = 0,
				groupcaps = {
					bendy = {times={[2]=1.65, [3]=1.00}, uses=300, maxlevel=1},
					cracky = {times={[3]=1.65}, uses=300, maxlevel=0}
				},
				damage_groups = {fleshy=2, bendy=2, cracky=1},
			},
		},
	})
end