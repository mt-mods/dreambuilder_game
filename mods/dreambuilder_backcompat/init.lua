local treemodnames = {
    "maple",
    "baldcypress",
    "chestnuttree",
    "cherrytree",
    "lemontree",
    "larch",
    "cacaotree",
    "birch",
    "bamboo",
    "pomegranate",
    "clementinetree",
    "palm",
    "oak",
    "bamboo",
    "sequoia",
    "jacaranda",
    "plumtree",
    "willow",
    "mahogany",
    "chestnut",
    "clementine",
    "cherry",
    "hollytree",
    "ebony",
    "pineapple",
    "palm",
    "ebony",
}

for _,modname in pairs(treemodnames) do
    if not minetest.get_modpath(modname) then
        minetest.register_alias(modname .. ":sapling", "moretrees:apple_tree_sapling")
        minetest.register_alias(modname .. ":trunk","moretrees:apple_tree_trunk")
        minetest.register_alias(modname .. ":wood","moretrees:apple_tree_planks")
        minetest.register_alias(modname .. ":leaves","default:leaves")
        minetest.register_alias(modname .. ":fence","default:fence_wood")
        minetest.register_alias(modname .. ":fence_rail","default:fence_rail_wood")

        minetest.register_alias("doors:door_" .. modname .. "_wood_a", "doors:door_wood_a")
        minetest.register_alias("doors:door_" .. modname .. "_wood_b", "doors:door_wood_b")
        minetest.register_alias("doors:door_" .. modname .. "_wood_c", "doors:door_wood_c")
        minetest.register_alias("doors:door_" .. modname .. "_wood_d", "doors:door_wood_d")

        minetest.register_alias(modname .. ":gate_open", "default:gate_wood_open")
        minetest.register_alias(modname .. ":gate_closed", "default:gate_wood_closed")

        minetest.register_alias_force("stairs:stair_" .. modname .. "_trunk", "moretrees:stair_apple_tree_planks")
		minetest.register_alias_force("stairs:stair_outer_" .. modname .. "_trunk", "moretrees:stair_apple_tree_planks_outer")
		minetest.register_alias_force("stairs:stair_inner_" .. modname .. "_trunk", "moretrees:stair_apple_tree_planks_inner")
		minetest.register_alias_force("stairs:slab_"  .. modname .. "_trunk", "moretrees:slab_apple_tree_planks")

        stairsplus:register_alias_all(modname, "wood", "moretrees", "apple_tree_planks")
    end
end

local baditemstrings = {
    'mahogany:flower_creeper',
    'lemontree:lemon',
    'mahogany:creeper',
    'mahogany:hanging_creeper',
    'doors:door_palm_d',
    'palm:coconut',
    'baldcypress:liana',
    'larch:moss',
    'cacaotree:pod',
    'cacaotree:liana',
    'cacaotree:flower_creeper',
    'bamboo:sprout',
    'clementinetree:clementine',
    'oak:acorn',
    'pomegranate:pomegranate',
    'chestnuttree:bur',
    'baldcypress:dry_branches',
    'jacaranda:blossom_leaves',
    'palm:candle',
    "cherrytree:cherries",
    "cherrytree:blossom_leaves",
    "pineapple:pineapple",
    "plumtree:plum",
    "ebony:creeper",
    "ebony:creeper_leaves",
    "ebony:liana",
    "ebony:persimmon",
}

for _,itemstring in pairs(baditemstrings) do
    local itemstringsplit = itemstring:split(":")

    if not minetest.get_modpath(itemstringsplit[1]) then
        minetest.register_alias(itemstring, "air")
    end
end

if not minetest.get_modpath("palm") then
    minetest.register_alias("doors:door_palm_a", "doors:door_wood_a")
    minetest.register_alias("doors:door_palm_b", "doors:door_wood_b")
    minetest.register_alias("doors:door_palm_c", "doors:door_wood_c")
    minetest.register_alias("doors:door_palm_d", "doors:door_wood_d")
end