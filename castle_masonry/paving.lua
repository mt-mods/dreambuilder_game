minetest.register_alias("castle:pavement",      	"castle_masonry:pavement_brick")
minetest.register_alias("castle:pavement_brick",	"castle_masonry:pavement_brick")
minetest.register_alias("castle:roofslate",			"castle_masonry:roofslate")


-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("castle_masonry:pavement_brick", {
	description = S("Paving Stone"),
	drawtype = "normal",
	tiles = {"castle_pavement_brick.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "castle_masonry:pavement_brick 4",
	recipe = {
		{"default:stone", "default:cobble"},
		{"default:cobble", "default:stone"},
	}
})


if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("castle", "pavement_brick", "castle_masonry:pavement_brick", {
		description = S("Pavement Brick"),
		tiles = {"castle_pavement_brick.png"},
		groups = {cracky=2, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
	})
elseif minetest.get_modpath("stairs") then
	stairs.register_stair_and_slab("pavement_brick", "castle_masonry:pavement_brick",
		{cracky=2},
		{"castle_pavement_brick.png"},
		S("Castle Pavement Stair"),
		S("Castle Pavement Slab"),
		default.node_sound_stone_defaults()
	)
end


minetest.register_node("castle_masonry:roofslate", {
	drawtype = "raillike",
	description = S("Roof Slates"),
	inventory_image = "castle_slate.png",
	paramtype = "light",
	walkable = false,
	tiles = {'castle_slate.png'},
	climbable = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2},
	},
	groups = {cracky=3,attached_node=1},
	sounds = default.node_sound_glass_defaults(),
})

local mod_building_blocks = minetest.get_modpath("building_blocks")
local mod_streets = minetest.get_modpath("streets") or minetest.get_modpath("asphalt")

if mod_building_blocks then
	minetest.register_craft({
		output = "castle_masonry:roofslate 4",
		recipe = {
			{ "building_blocks:Tar" , "default:gravel" },
			{ "default:gravel",       "building_blocks:Tar" }
		}
	})

	minetest.register_craft( {
		output = "castle_masonry:roofslate 4",
		recipe = {
			{ "default:gravel",       "building_blocks:Tar" },
			{ "building_blocks:Tar" , "default:gravel" }
		}
	})
end

if mod_streets then
	minetest.register_craft( {
		output = "castle_masonry:roofslate 4",
		recipe = {
			{ "streets:asphalt" , "default:gravel" },
			{ "default:gravel",   "streets:asphalt" }
		}
	})

	minetest.register_craft( {
		output = "castle_masonry:roofslate 4",
		recipe = {
			{ "default:gravel",   "streets:asphalt" },
			{ "streets:asphalt" , "default:gravel" }
		}
	})
end

if not (mod_building_blocks or mod_streets) then
	minetest.register_craft({
		type = "cooking",
		output = "castle_masonry:roofslate",
		recipe = "default:gravel",
	})

end