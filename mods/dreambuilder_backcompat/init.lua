if not minetest.get_modpath("hollytree") then
    minetest.register_alias("hollytree:sapling", "moretrees:apple_tree_sapling")
    minetest.register_alias("hollytree:trunk","moretrees:apple_tree_trunk")
    minetest.register_alias("hollytree:wood","moretrees:apple_tree_planks")
    minetest.register_alias("hollytree:leaves","default:leaves")
    --minetest.register_alias(,)

    stairsplus:register_stair_alias("hollytree", "wood", "moretrees", "apple_tree_planks")
end