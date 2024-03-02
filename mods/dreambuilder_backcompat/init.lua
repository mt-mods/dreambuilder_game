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

    stairsplus:register_alias_all("ebony", "wood", "moretrees", "apple_tree_planks")
end