if not minetest.get_modpath("hollytree") then
    minetest.register_alias("hollytree:sapling", "moretrees:apple_tree_sapling")
    minetest.register_alias("hollytree:trunk","moretrees:apple_tree_trunk")
    minetest.register_alias("hollytree:wood","moretrees:apple_tree_planks")
    minetest.register_alias("hollytree:leaves","default:leaves")
    --minetest.register_alias(,)

    stairsplus:register_alias_all("hollytree", "wood", "moretrees", "apple_tree_planks")
end

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
    
}

for _,modname in pairs(treemodnames) do
    if not minetest.get_modpath(modname) then
        minetest.register_alias(modname .. ":sapling", "moretrees:apple_tree_sapling")
        minetest.register_alias(modname .. ":trunk","moretrees:apple_tree_trunk")
        minetest.register_alias(modname .. ":wood","moretrees:apple_tree_planks")
        minetest.register_alias(modname .. ":leaves","default:leaves")
        minetest.register_alias(modname .. ":fence","default:fence_wood")
        minetest.register_alias(modname .. ":fence_rail","default:fence_rail_wood")

        stairsplus:register_alias_all(modname, "wood", "moretrees", "apple_tree_planks")
    end
end