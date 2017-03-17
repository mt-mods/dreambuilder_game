-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_alias("castle:stonewall",         "castle_masonry:stonewall")
minetest.register_alias("castle:dungeon_stone",     "castle_masonry:dungeon_stone")
minetest.register_alias("castle:rubble",            "castle_masonry:rubble")
minetest.register_alias("castle:stonewall_corner",  "castle_masonry:stonewall_corner")

minetest.register_node("castle_masonry:stonewall", {
	description = S("Castle Wall"),
	drawtype = "normal",
	tiles = {"castle_stonewall.png"},
	paramtype = "light",
	drop = "castle_masonry:stonewall",
	groups = {cracky=3},
	sunlight_propagates = false,
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("castle_masonry:rubble", {
	description = S("Castle Rubble"),
	drawtype = "normal",
	tiles = {"castle_rubble.png"},
	paramtype = "light",
	groups = {crumbly=3,falling_node=1},
	sounds = default.node_sound_gravel_defaults(),
})

minetest.register_craft({
	output = "castle_masonry:stonewall",
	recipe = {
		{"default:cobble"},
		{"default:desert_stone"},
	}
})

minetest.register_craft({
	output = "castle_masonry:rubble",
	recipe = {
		{"castle_masonry:stonewall"},
	}
})

minetest.register_craft({
	output = "castle_masonry:rubble 2",
	recipe = {
		{"default:gravel"},
		{"default:desert_stone"},
	}
})

minetest.register_node("castle_masonry:stonewall_corner", {
	drawtype = "normal",
	paramtype = "light",
	paramtype2 = "facedir",
	description = S("Castle Corner"),
	tiles = {"castle_corner_stonewall_tb.png^[transformR90",
		 "castle_corner_stonewall_tb.png^[transformR180",
		 "castle_corner_stonewall1.png",
		 "castle_stonewall.png",
		 "castle_stonewall.png",	
		 "castle_corner_stonewall2.png"},
	groups = {cracky=3},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "castle_masonry:stonewall_corner",
	recipe = {
		{"", "castle_masonry:stonewall"},
		{"castle_masonry:stonewall", "default:sandstone"},
	}
})

if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("castle_masonry", "stonewall", "castle_masonry:stonewall", {
		description = S("Stone Wall"),
		tiles = {"castle_stonewall.png"},
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
	})

	stairsplus:register_all("castle_masonry", "rubble", "castle_masonry:rubble", {
		description = S("Rubble"),
		tiles = {"castle_rubble.png"},
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_gravel_defaults(),
		sunlight_propagates = true,
	})
	
	stairsplus:register_stair_alias("castle", "stonewall", "castle_masonry", "stonewall")
	stairsplus:register_stair_alias("castle", "rubble", "castle_masonry", "rubble")

elseif minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab("stonewall", "castle_masonry:stonewall",
		{cracky=3},
		{"castle_stonewall.png"},
		S("Castle Stonewall Stair"),
		S("Castle Stonewall Slab"),
		default.node_sound_stone_defaults()
	)

	stairs.register_stair_and_slab("rubble", "castle_masonry:rubble",
		{cracky=3},
		{"castle_rubble.png"},
		S("Castle Rubble Stair"),
		S("Castle Rubble Slab"),
		default.node_sound_stone_defaults()
	)
end

--------------------------------------------------------------------------------------------------------------

minetest.register_node("castle_masonry:dungeon_stone", {
	description = S("Dungeon Stone"),
	drawtype = "normal",
	tiles = {"castle_dungeon_stone.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "castle_masonry:dungeon_stone 2",
	recipe = {
		{"default:stonebrick", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "castle_masonry:dungeon_stone 2",
	recipe = {
		{"default:stonebrick"},
		{"default:obsidian"},
	}
})


if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("castle", "dungeon_stone", "castle_masonry:dungeon_stone", {
		description = S("Dungeon Stone"),
		tiles = {"castle_dungeon_stone.png"},
		groups = {cracky=2, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
	})

	stairsplus:register_stair_alias("castle", "dungeon_stone", "castle_masonry", "dungeon_stone")
	
elseif minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab("dungeon_stone", "castle_masonry:dungeon_stone",
		{cracky=2},
		{"castle_dungeon_stone.png"},
		S("Dungeon Stone Stair"),
		S("Dungeon Stone Slab"),
		default.node_sound_stone_defaults()
	)
end