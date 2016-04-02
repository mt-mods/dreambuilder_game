--[[
***********
Blox
by Sanchez

modified mapgen
by blert2112
***********
--]]

-- Remove Blox from creative inventory if colormachine mod is installed

local creative = 0

if (minetest.get_modpath("colormachine")) then
	creative = 1
end

-- Uncomment the line below to remove most nodes from creative inventory regardless of colormachine mod.

-- local creative = 1

-- Uncomment the line above and change value to 0 to keep nodes in creative inventory when colormachine is installed.

local version = "0.7.2112"

local DyeSub = ""

local Material = ""

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

local UNIFIED = {
	"magenta",
	"yellow",
	"white",
	"orange",
	"violet",
	"blue",
	"cyan",
	"red",
	"green",
	"black",
}

local BuiltInDyes = {
	"pink",
	"yellow",
	"white",
	"orange",
	"violet",
	"blue",
	"cyan",
	"red",
	"green",
	"black",
}

local FuelBlox = {
	"wood",
	"diamond_wood",
	"corner_wood",
	"checker_wood",
	"cross_wood",
	"quarter_wood",
	"loop_wood",
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
	"",
	"_wood",
	"_cobble",
}

-- Nodes

minetest.register_node("blox:glowstone", {
	description = "Glowstone",
	tiles = {"blox_glowstone.png"},
	--inventory_image = "blox_glowstone.png",
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 30	,
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
	light_source = 12	,
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
	light_source = 8	,
	walkable = false,
	groups = {cracky=3, snappy=3},
	})


for _, NClass in ipairs(NodeClass) do

	for _, colour in ipairs(BloxColours) do
	local cname = colour .. NClass

	minetest.register_node('blox:' .. cname, {
		description = colour .. " " .. NClass .. " stone block",
		tiles = { 'blox_' .. cname .. '.png' },
		--inventory_image = 'blox_' .. cname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=creative},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. NClass .. '_cobble'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " " .. NClass .. " cobble block",
		tiles = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=creative},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. NClass .. '_wood'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " " .. NClass .. " wooden block",
		tiles = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=creative},
		sounds = default.node_sound_wood_defaults(),
	})

	end
end

	for _, colour in ipairs(BloxColours) do
	local sname = colour .. 'square'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " stone square",
		tiles = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=creative},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'stone'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " stone",
		tiles = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=creative},
		sounds = default.node_sound_stone_defaults(),
	})

	local sname = colour .. 'wood'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " wood",
		tiles = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {snappy=2,choppy=2,oddly_breakable_by_hand=2,flammable=3, not_in_creative_inventory=creative},
		sounds = default.node_sound_wood_defaults(),
	})

	local sname = colour .. 'cobble'

	minetest.register_node('blox:' .. sname, {
		description = colour .. " cobble",
		tiles = { 'blox_' .. sname .. '.png' },
		--inventory_image = 'blox_' .. sname .. '.png',
		is_ground_content = true,
		groups = {cracky=3, not_in_creative_inventory=creative},
		sounds = default.node_sound_stone_defaults(),
	})


end

-- Crafting

minetest.register_craft({
	output = 'blox:glowstone 2',
	recipe = {
		{'', 'blox:glowdust', ''},
		{'blox:glowdust', 'default:stone', 'blox:glowdust'},
		{'', 'blox:glowdust', ''},
	}
})


for _, colour in ipairs(UNIFIED) do

if colour == "magenta" then
DyeSub = "pink" else if colour == "violet" then
DyeSub = "purple" else
DyeSub = colour
end
end

for _, NMaterial in ipairs(NodeMaterial) do

if NMaterial == "_cobble" then
Material = "default:cobble" else if NMaterial == "_wood" then
Material = "default:wood" else
Material = "default:stone"
end
end
--print(Material, 'unifieddyes:' .. colour)
--print('unifieddyes:' .. colour, Material)
minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter' .. NMaterial .. ' 4',
	recipe = {
		{Material, 'unifieddyes:' .. colour},
		{'unifieddyes:' .. colour, Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter' .. NMaterial .. ' 4',
	recipe = {
		{'unifieddyes:' .. colour, Material},
		{Material, 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cross' .. NMaterial .. ' 4',
	recipe = {
		{Material, '', Material},
		{'', 'unifieddyes:' .. colour, ''},
		{Material, '', Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker' .. NMaterial .. ' 6',
	recipe = {
		{Material, 'unifieddyes:' .. colour,Material},
		{'unifieddyes:' .. colour, Material, 'unifieddyes:' .. colour},
		{Material, 'unifieddyes:' .. colour,Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker' .. NMaterial .. ' 8',
	recipe = {
		{'unifieddyes:' .. colour, Material, 'unifieddyes:' .. colour},
		{Material, 'unifieddyes:' .. colour,Material},
		{'unifieddyes:' .. colour, Material, 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'loop' .. NMaterial .. ' 6',
	recipe = {
		{Material, Material, Material},
		{Material, 'unifieddyes:' .. colour, Material},
		{Material, Material, Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'corner' .. NMaterial .. ' 4',
	recipe = {
		{'unifieddyes:' .. colour, '', 'unifieddyes:' .. colour},
		{'', Material, ''},
		{'unifieddyes:' .. colour, '', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'diamond' .. NMaterial .. ' 6',
	recipe = {
		{Material, 'unifieddyes:' .. colour, Material},
		{'unifieddyes:' .. colour, '', 'unifieddyes:' .. colour},
		{Material, 'unifieddyes:' .. colour, Material},
	}
})

end
end

for _, colour in ipairs(UNIFIED) do

if colour == "magenta" then
DyeSub = "pink" else if colour == "violet" then
DyeSub = "purple" else
DyeSub = colour
end
end

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'square 6',
	recipe = {
		{'unifieddyes:' .. colour, 'default:stone', 'default:stone'},
		{'default:stone', 'unifieddyes:' .. colour, 'default:stone'},
		{'default:stone', 'default:stone', 'unifieddyes:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'stone 4',
	recipe = {
		{'', 'default:stone', ''},
		{'default:stone', 'unifieddyes:' .. colour, 'default:stone'},
		{'', 'default:stone', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'wood 4',
	recipe = {
		{'', 'default:wood', ''},
		{'default:wood', 'unifieddyes:' .. colour, 'default:wood'},
		{'', 'default:wood', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cobble 4',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', 'unifieddyes:' .. colour, 'default:cobble'},
		{'', 'default:cobble', ''},
	}
})
end


for _, colour in ipairs(BuiltInDyes) do

if colour == "violet" then
DyeSub = "purple" else
DyeSub = colour
end

for _, NMaterial in ipairs(NodeMaterial) do

if NMaterial == "_cobble" then
Material = "default:cobble" else if NMaterial == "_wood" then
Material = "default:wood" else
Material = "default:stone"
end
end

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter' .. NMaterial .. ' 4',
	recipe = {
		{Material, 'dye:' .. colour},
		{'dye:' .. colour, Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'quarter' .. NMaterial .. ' 4',
	recipe = {
		{'dye:' .. colour, Material},
		{Material, 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cross' .. NMaterial .. ' 4',
	recipe = {
		{Material, '', Material},
		{'', 'dye:' .. colour, ''},
		{Material, '', Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker' .. NMaterial .. ' 6',
	recipe = {
		{Material, 'dye:' .. colour,Material},
		{'dye:' .. colour, Material, 'dye:' .. colour},
		{Material, 'dye:' .. colour,Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'checker' .. NMaterial .. ' 8',
	recipe = {
		{'dye:' .. colour, Material, 'dye:' .. colour},
		{Material, 'dye:' .. colour,Material},
		{'dye:' .. colour, Material, 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'loop' .. NMaterial .. ' 6',
	recipe = {
		{Material, Material, Material},
		{Material, 'dye:' .. colour, Material},
		{Material, Material, Material},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'corner' .. NMaterial .. ' 4',
	recipe = {
		{'dye:' .. colour, '', 'dye:' .. colour},
		{'', Material, ''},
		{'dye:' .. colour, '', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'diamond' .. NMaterial .. ' 6',
	recipe = {
		{Material, 'dye:' .. colour, Material},
		{'dye:' .. colour, '', 'dye:' .. colour},
		{Material, 'dye:' .. colour, Material},
	}
})

end
end

for _, colour in ipairs(UNIFIED) do

if colour == "magenta" then
DyeSub = "pink" else if colour == "violet" then
DyeSub = "purple" else
DyeSub = colour
end
end

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'square 6',
	recipe = {
		{'dye:' .. colour, 'default:stone', 'default:stone'},
		{'default:stone', 'dye:' .. colour, 'default:stone'},
		{'default:stone', 'default:stone', 'dye:' .. colour},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'stone 4',
	recipe = {
		{'', 'default:stone', ''},
		{'default:stone', 'dye:' .. colour, 'default:stone'},
		{'', 'default:stone', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'wood 4',
	recipe = {
		{'', 'default:wood', ''},
		{'default:wood', 'dye:' .. colour, 'default:wood'},
		{'', 'default:wood', ''},
	}
})

minetest.register_craft({
	output = 'blox:' .. DyeSub ..'cobble 4',
	recipe = {
		{'', 'default:cobble', ''},
		{'default:cobble', 'dye:' .. colour, 'default:cobble'},
		{'', 'default:cobble', ''},
	}
})
end

--Fuel
	for _, colour in ipairs(BloxColours) do

	for _, blox in ipairs(FuelBlox) do

minetest.register_craft({
	type = "fuel",
	recipe = "blox:" .. colour .. blox,
	burntime = 7,
})

end
end

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

print("Blox Mod [" ..version.. "] Loaded!")
