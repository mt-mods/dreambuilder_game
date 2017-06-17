--[[
***********
Blox
by Sanchez

modified mapgen
by blert2112
***********
--]]

blox = {}

local version = "0.8"

local BloxColours = {
	"pink",
	"yellow",
	"white",
	"orange",
	"purple",
	"blue",
	"cyan",
	"red",
	"green",
	"black",
}

local NodeClass = {
	"diamond",
	"quarter",
	"cross",
	"checker",
	"corner",
	"loop",
}

local NodeMaterial = {
	"stone",
	"wood",
	"cobble",
}

local moreblocks = minetest.get_modpath("moreblocks")

-- Nodes

minetest.register_node("blox:glowstone", {
	description = "Glowstone",
	tiles = {"blox_glowstone.png"},
	--inventory_image = "blox_glowstone.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 14,
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blox:glowore", {
	description = "Glow Ore",
	tiles = {"default_stone.png^blox_glowore.png"},
	--inventory_image = {"default_stone.png^blox_glowore.png"},
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = false,
	light_source = 8,
		drop = {
		max_items = 1,
		items = {
			{
				items = {"blox:glowstone"},
				rarity = 15,
			},
			{
				items = {"blox:glowdust"},
			}
		}
	},
	is_ground_content = true,
	groups = {cracky=2},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("blox:glowdust", {
	description = "Glow Dust",
	drawtype = "plantlike",
	tiles = {"blox_glowdust.png"},
	inventory_image = "blox_glowdust.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 9,
	walkable = false,
	groups = {cracky=3, snappy=3},
	})

-- param2-colored nodes: standard patterns

blox.old_89_color_nodes = {}

for _, nodeclass in ipairs(NodeClass) do

	minetest.register_node("blox:stone_"..nodeclass, {
		description = "Blox stone "..nodeclass,
		tiles = {
			{ name = "default_stone.png", color = 0xffffffff },
		},
		overlay_tiles = {
			"blox_stone_"..nodeclass..".png"
		},
		palette = "unifieddyes_palette_extended.png",
		place_param2 = 240,
		paramtype = "light",
		paramtype2 = "color",
		is_ground_content = true,
		groups = {cracky=3, ud_param2_colorable = 1},
		sounds = default.node_sound_stone_defaults(),
		on_construct = unifieddyes.on_construct,
		after_place_node = unifieddyes.recolor_on_place,
		after_dig_node = unifieddyes.after_dig_node
	})

	minetest.register_node("blox:cobble_"..nodeclass, {
		description = "Blox cobble "..nodeclass,
		tiles = {
			{ name = "default_cobble.png", color = 0xffffffff },
		},
		overlay_tiles = {
			"blox_cobble_"..nodeclass..".png"
		},
		palette = "unifieddyes_palette_extended.png",
		place_param2 = 240,
		paramtype = "light",
		paramtype2 = "color",
		is_ground_content = true,
		groups = {cracky=3, ud_param2_colorable = 1},
		sounds = default.node_sound_stone_defaults(),
		on_construct = unifieddyes.on_construct,
		after_place_node = unifieddyes.recolor_on_place,
		after_dig_node = unifieddyes.after_dig_node
	})

	minetest.register_node("blox:wood_"..nodeclass, {
		description = "Blox wood "..nodeclass,
		tiles = {
			{ name = "default_wood.png", color = 0xffffffff },
		},
		overlay_tiles = {
			"blox_wood_"..nodeclass..".png"
		},
		palette = "unifieddyes_palette_extended.png",
		place_param2 = 240,
		paramtype = "light",
		paramtype2 = "color",
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, ud_param2_colorable = 1},
		sounds = default.node_sound_wood_defaults(),
		on_construct = unifieddyes.on_construct,
		after_place_node = unifieddyes.recolor_on_place,
		after_dig_node = unifieddyes.after_dig_node
	})

	table.insert(blox.old_89_color_nodes, "blox:stone_"..nodeclass)
	table.insert(blox.old_89_color_nodes, "blox:cobble_"..nodeclass)
	table.insert(blox.old_89_color_nodes, "blox:wood_"..nodeclass)
end

-- param2-colored nodes: tinted wood, cobble, stone, stone square

minetest.register_node("blox:wood_tinted", {
	description = "Blox tinted wood",
	tiles = { "blox_wood_tinted.png" },
	palette = "unifieddyes_palette_extended.png",
	place_param2 = 240,
	paramtype = "light",
	paramtype2 = "color",
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("blox:stone_square", {
	description = "Blox stone square",
	tiles = { "blox_stone_square.png" },
	palette = "unifieddyes_palette_extended.png",
	place_param2 = 240,
	paramtype = "light",
	paramtype2 = "color",
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_node("blox:cobble_tinted", {
	description = "Blox tinted cobble",
	tiles = { "blox_cobble_tinted.png" },
	palette = "unifieddyes_palette_extended.png",
	place_param2 = 240,
	paramtype = "light",
	paramtype2 = "color",
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory = 1, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = unifieddyes.after_dig_node,
	drop = "default:cobble"
})

minetest.register_node("blox:stone_tinted", {
	description = "Blox tinted stone",
	tiles = { "blox_stone_tinted.png" },
	palette = "unifieddyes_palette_extended.png",
	place_param2 = 240,
	paramtype = "light",
	paramtype2 = "color",
	is_ground_content = true,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory = 1, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
	after_dig_node = unifieddyes.after_dig_node,
	drop = "default:cobble"
})

table.insert(blox.old_89_color_nodes, "blox:wood_tinted")
table.insert(blox.old_89_color_nodes, "blox:stone_square")
table.insert(blox.old_89_color_nodes, "blox:cobble_tinted")
table.insert(blox.old_89_color_nodes, "blox:stone_tinted")

-- Override default stone and default cobble

minetest.override_item("default:stone", {
	palette = "unifieddyes_palette_extended.png",
	ud_replacement_node = "blox:stone_tinted",
	after_place_node = unifieddyes.recolor_on_place,
	groups = {cracky = 3, stone = 1, ud_param2_colorable = 1},
})

minetest.override_item("default:cobble", {
	palette = "unifieddyes_palette_extended.png",
	ud_replacement_node = "blox:cobble_tinted",
	after_place_node = unifieddyes.recolor_on_place,
	groups = {cracky = 3, stone = 2, ud_param2_colorable = 1},
})

local dye_color = "unifieddyes:white"

if moreblocks then
	minetest.override_item("moreblocks:stone_tile", {
		palette = "unifieddyes_palette_extended.png",
		ud_replacement_node = "blox:stone_square",
		after_place_node = unifieddyes.recolor_on_place,
		groups = {cracky = 3, ud_param2_colorable = 1},
	})

	minetest.override_item("blox:stone_square", {
		drop = "moreblocks:stone_tile",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory = 1, ud_param2_colorable = 1},
	})

	minetest.override_item("moreblocks:circle_stone_bricks", {
		palette = "unifieddyes_palette_extended.png",
		ud_replacement_node = "blox:stone_loop",
		after_place_node = unifieddyes.recolor_on_place,
		groups = {cracky = 3, ud_param2_colorable = 1},
	})
	minetest.override_item("blox:stone_loop", {
		drop = "moreblocks:circle_stone_bricks",
		groups = {cracky = 3, not_in_creative_inventory = 1, ud_param2_colorable = 1},
	})

	minetest.override_item("moreblocks:iron_checker", {
		palette = "unifieddyes_palette_extended.png",
		ud_replacement_node = "blox:stone_checker",
		after_place_node = unifieddyes.recolor_on_place,
		groups = {cracky = 3, ud_param2_colorable = 1},
	})
	minetest.override_item("blox:stone_checker", {
		drop = "moreblocks:iron_checker",
		groups = {cracky = 3, not_in_creative_inventory = 1, ud_param2_colorable = 1},
	})

	minetest.override_item("moreblocks:wood_tile", {
		palette = "unifieddyes_palette_extended.png",
		ud_replacement_node = "blox:wood_quarter",
		after_place_node = unifieddyes.recolor_on_place,
		groups = {wood = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, ud_param2_colorable = 1},
	})
	minetest.override_item("blox:wood_quarter", {
		drop = "moreblocks:wood_tile",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory = 1, ud_param2_colorable = 1},
	})

	minetest.override_item("moreblocks:wood_tile_flipped", {
		palette = "unifieddyes_palette_extended.png",
		ud_replacement_node = "blox:wood_quarter",
		after_place_node = unifieddyes.recolor_on_place,
		groups = {wood = 1, snappy = 1, choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, ud_param2_colorable = 1},
	})
else
	minetest.register_craft({
		output = "blox:stone_square 6",
		recipe = {
			{ dye_color,       "default:stone", "default:stone" },
			{ "default:stone", dye_color,       "default:stone" },
			{ "default:stone", "default:stone", dye_color       },
		}
	})
end

if minetest.get_modpath("coloredwood") then
	minetest.register_craft({
		output = "blox:wood_tinted 6",
		recipe = {
			{ "",             "default:wood", ""             },
			{ "default:wood", dye_color,      "default:wood" },
			{ "",             "default:wood", ""             },
		}
	})
else
	minetest.override_item("default:wood", {
		ud_replacement_node = "blox:wood_tinted",
		groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ud_param2_colorable = 1},
	})
	minetest.override_item("blox:wood_tinted", {
		drop = "default:wood",
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory = 1, ud_param2_colorable = 1},
	})
end

-- Crafting

minetest.register_craft({
	output = 'blox:glowstone 2',
	recipe = {
		{"", 'blox:glowdust', ""},
		{'blox:glowdust', 'default:stone', 'blox:glowdust'},
		{"", 'blox:glowdust', ""},
	}
})

for _, material in ipairs(NodeMaterial) do

	local def_mat = "default:"..material

	minetest.register_craft({
		output = "blox:"..material.."_diamond 4",
		recipe = {
			{ def_mat,   dye_color, def_mat   },
			{ dye_color, "",        dye_color },
			{ def_mat,   dye_color, def_mat   },
		}
	})

	if not (moreblocks and material == "wood") then
		minetest.register_craft({
			output = "blox:"..material.."_quarter 4",
			recipe = {
				{ dye_color, def_mat   },
				{ def_mat,   dye_color },
			}
		})
	end

	minetest.register_craft({
		output = "blox:"..material.."_cross 4",
		recipe = {
			{ def_mat, "",        def_mat },
			{ "",      dye_color, ""      },
			{ def_mat, "",        def_mat },
		}
	})

	minetest.register_craft({
		output = "blox:"..material.."_corner 4",
		recipe = {
			{ dye_color, "",      dye_color },
			{ "",        def_mat, ""        },
			{ dye_color, "",      dye_color },
		}
	})

	if not (moreblocks and material == "stone") then

		minetest.register_craft({
			output = "blox:"..material.."_checker 6",
			recipe = {
				{ def_mat,   dye_color, def_mat   },
				{ dye_color, def_mat,   dye_color },
				{ def_mat,   dye_color, def_mat   },
			}
		})

		minetest.register_craft({
			output = "blox:"..material.."_checker 8",
			recipe = {
				{ dye_color, def_mat,   dye_color },
				{ def_mat,   dye_color, def_mat   },
				{ dye_color, def_mat,   dye_color },
			}
		})

		minetest.register_craft({
			output = "blox:"..material.."_loop 6",
			recipe = {
				{ def_mat, def_mat,   def_mat },
				{ def_mat, dye_color, def_mat },
				{ def_mat, def_mat,   def_mat },
			}
		})
	end
end

--Fuel

for _, nodeclass in ipairs(NodeClass) do
	minetest.register_craft({
		type = "fuel",
		recipe = "blox:wood_"..nodeclass,
		burntime = 7,
	})
end

minetest.register_craft({
	type = "fuel",
	recipe = "blox:wood_tinted",
	burntime = 7,
})

-- Tools

minetest.register_tool("blox:bloodbane", {
    description = "Blood Bane",
    inventory_image = "blox_bloodbane.png",
    tool_capabilities = {
        full_punch_interval = 0.2,
        max_drop_level=1,
        groupcaps={
            fleshy={times={[1]=0.001, [2]=0.001, [3]=0.001}, uses=0, maxlevel=3},
            snappy={times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=0, maxlevel=3},
			crumbly={times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=0, maxlevel=3},
            cracky={times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=0, maxlevel=3},
            choppy={times={[1]=0.01, [2]=0.01, [3]=0.01}, uses=0, maxlevel=3}
        },
		damage_groups = {fleshy=200},
    }
})

-- Ores

local sea_level = 1

minetest.register_on_mapgen_init(function(mapgen_params)
	sea_level = mapgen_params.water_level
end)

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "blox:glowore",
	wherein        = "default:stone",
	clust_scarcity = 36 * 36 * 36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = sea_level,
	y_max          = 31000,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "blox:glowore",
	wherein        = "default:stone",
	clust_scarcity = 14 * 14 * 14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min          = sea_level - 30,
	y_max          = sea_level + 20,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "blox:glowore",
	wherein        = "default:stone",
	clust_scarcity = 36 * 36 * 36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min          = -31000,
	y_max          = sea_level - 1,
})

-- Convert old static nodes to param2 color

blox.old_static_list = {}

for _, nodeclass in ipairs(NodeClass) do
	if nodeclass ~= "colored" then
		for _, color in ipairs(BloxColours) do
			table.insert(blox.old_static_list, "blox:"..color..nodeclass)
			table.insert(blox.old_static_list, "blox:"..color..nodeclass.."_cobble")
			table.insert(blox.old_static_list, "blox:"..color..nodeclass.."_wood")
		end
	end
end

for _, color in ipairs(BloxColours) do
	table.insert(blox.old_static_list, "blox:"..color.."square")
	table.insert(blox.old_static_list, "blox:"..color.."stone")
	table.insert(blox.old_static_list, "blox:"..color.."wood")
	table.insert(blox.old_static_list, "blox:"..color.."cobble")
end

minetest.register_lbm({
	name = "blox:convert",
	label = "Convert blox blocks to use param2 color",
	run_at_every_load = false,
	nodenames = blox.old_static_list,
	action = function(pos, node)
		local basename = string.sub(node.name, 6)
		local color = basename
		local material = "stone"
		local pattern = "tinted"

		if string.find(basename, "_cobble") then
			basename = string.sub(basename, 1, -8)
			material = "cobble"
		elseif string.find(basename, "cobble") then
			basename = string.sub(basename, 1, -7)
			material = "cobble"
		elseif string.find(basename, "_wood") then
			basename = string.sub(basename, 1, -6)
			material = "wood"
		elseif string.find(basename, "wood") then
			basename = string.sub(basename, 1, -5)
			material = "wood"
		elseif string.find(basename, "square") then
			basename = string.sub(basename, 1, -7)
			pattern = "square"
		elseif string.find(basename, "stone") then
			basename = string.sub(basename, 1, -6)
		end

		-- at this point, the material type has been deleted from `basename`.

		if string.find(basename, "quarter") then
			basename = string.sub(basename, 1, -8)
			pattern = "quarter"
		elseif string.find(basename, "cross") then
			basename = string.sub(basename, 1, -6)
			pattern = "cross"
		elseif string.find(basename, "corner") then
			basename = string.sub(basename, 1, -7)
			pattern = "corner"
		elseif string.find(basename, "diamond") then
			basename = string.sub(basename, 1, -8)
			pattern = "diamond"
		elseif string.find(basename, "loop") then
			basename = string.sub(basename, 1, -5)
			pattern = "loop"
		elseif string.find(basename, "checker") then
			basename = string.sub(basename, 1, -8)
			pattern = "checker"
		end

		-- all that's left in `basename` now is the color.

		color = basename
		if color == "purple" then
			color = "violet"
		elseif color == "blue" then
			color = "skyblue"
		elseif color == "pink" then
			color = "magenta"
		elseif color == "black" and
			( pattern == "square" or
			  pattern == "tinted" ) then 
			color = "dark_grey"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")
		minetest.set_node(pos, { name = "blox:"..material.."_"..pattern, param2 = paletteidx })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
		meta:set_string("palette", "ext")
	end
})

minetest.register_lbm({
	name = "blox:recolor_stuff",
	label = "Convert 89-color blocks to use UD extended palette",
	run_at_every_load = false,
	nodenames = blox.old_89_color_nodes,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		if meta:get_string("palette") ~= "ext" then
			minetest.swap_node(pos, { name = node.name, param2 = unifieddyes.convert_classic_palette[node.param2] })
			meta:set_string("palette", "ext")
		end
	end
})

print("Blox Mod [" ..version.. "] Loaded!")
