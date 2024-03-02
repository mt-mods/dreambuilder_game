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

if not minetest.get_modpath("maple") then
    minetest.register_alias("maple:sapling", "moretrees:apple_tree_sapling")
    minetest.register_alias("maple:trunk","moretrees:apple_tree_trunk")
    minetest.register_alias("maple:wood","moretrees:apple_tree_planks")
    minetest.register_alias("maple:leaves","default:leaves")
    minetest.register_alias("maple:fence","default:fence_wood")
    minetest.register_alias("maple:fence_rail","default:fence_rail_wood")

    stairsplus:register_alias_all("maple", "wood", "moretrees", "apple_tree_planks")
end