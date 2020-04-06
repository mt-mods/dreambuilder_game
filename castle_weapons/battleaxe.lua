
-- Used for localization, choose either built-in or intllib.

local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_alias("castle:battleaxe", "castle_weapons:battleaxe")

minetest.register_tool("castle_weapons:battleaxe", {
	description = S("Battleaxe"),
	inventory_image = "castle_battleaxe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.10, [2]=0.90, [3]=0.50}, uses=20, maxlevel=3},
			snappy={times={[1]=1.90, [2]=0.90, [3]=0.30}, uses=20, maxlevel=3},
		},
		damage_groups = {fleshy=7},
	},
})

minetest.register_craft({
	output = "castle_weapons:battleaxe",
	recipe = {
		{"default:steel_ingot", "default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot", "default:stick","default:steel_ingot"},
		{"", "default:stick",""}
	}
})
