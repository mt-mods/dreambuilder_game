if not minetest.get_modpath("ebony") then
    minetest.register_alias("ebony:sapling", "moretrees:apple_tree_sapling")
    minetest.register_alias("ebony:trunk","moretrees:apple_tree_trunk")
    minetest.register_alias("ebony:wood","moretrees:apple_tree_planks")
    minetest.register_alias("ebony:leaves","default:leaves")
    minetest.register_alias("ebony:creeper","moretrees:apple_tree_trunk")
    minetest.register_alias("ebony:creeper_leaves","default:leaves")
    minetest.register_alias("ebony:liana","air")
    minetest.register_alias("ebony:persimmon","air")
    minetest.register_alias("ebony:fence","default:fence_wood")
    minetest.register_alias("ebony:fence_rail","default:fence_rail_wood")

    stairsplus:register_alias_all("ebony", "wood", "moretrees", "apple_tree_planks")
end

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

if not minetest.get_modpath("cherrytree") then
    minetest.register_alias("cherrytree:cherries", "air")
    minetest.register_alias("cherrytree:blossom_leaves", "default:leaves")
end

if not minetest.get_modpath("pineapple") then
    minetest.register_alias("pineapple:pineapple", "air")
end

if not minetest.get_modpath("plumtree") then
    minetest.register_alias("plumtree:plum", "air")
end