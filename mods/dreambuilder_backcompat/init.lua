if not minetest.get_modpath("hollytree") then
    minetest.register_alias("hollytree:sapling", "default:sapling")
    minetest.register_alias("hollytree:trunk","default:tree")
    minetest.register_alias("hollytree:wood","default:wood")
    minetest.register_alias("hollytree:leaves","default:leaves")
    --minetest.register_alias(,)

    stairsplus:register_stair_alias("hollytree", "wood", "default", "wood")
end