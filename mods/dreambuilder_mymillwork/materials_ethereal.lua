local nici = 1

if not minetest.get_modpath("bakedclay") then

--baked_clay_gray
    mymillwork.register("bakedclay:grey",
        "baked_clay_grey",
        "Grey Baked Clay",
        "baked_clay_grey.png",
        {cracky = 3, not_in_creative_inventory = nici}
    )

--baked_clay_orange
    mymillwork.register("bakedclay:orange",
        "baked_clay_orange",
        "Orange Baked Clay",
        "baked_clay_orange.png",
        {cracky = 3, not_in_creative_inventory = nici}
    )

--baked_clay_red
    mymillwork.register("bakedclay:red",
        "baked_clay_red",
        "Red Baked Clay",
        "baked_clay_red.png",
        {cracky = 3, not_in_creative_inventory = nici}
    )

end

--[[
local nodes = {
--banana_trunk
--banana_trunk_top
--banana_wood

--crystal_block

--ethereal_frost_tree
--ethereal_frost_tree_top
--frost_wood

--glostone

--ethereal_sakura_trunk
--ethereal_sakura_trunk_top
--ethereal_sakura_trunk_wood

--moretrees_birch_trunk
--moretrees_birch_trunk_top
--moretrees_birch_wood

--moretrees_palm_trunk
--moretrees_palm_trunk_top
--moretrees_palm_wood

--mushroom_block
--mushroom_pore
--mushroom_trunk
--mushroom_trunk_top

--redwood_trunk
--redwood_trunk_top
--redwood_wood

--scorched_tree
--scorched_tree_top

--willow_trunk
--willow_trunk_top
--willow_wood

--yellow_tree
--yellow_tree_top
--yellow_wood
}

for name, def in pairs(nodes) do

    mymillwork.register("ethereal:"..name,
        name,
        def.description,
        name..".png",
        def.groups
        )

end
]]
