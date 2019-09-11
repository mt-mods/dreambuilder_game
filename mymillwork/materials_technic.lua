local nici = 1

--[[ Technic Worldgen ]]--

local nodes = {

-- technic:granite
    ["granite"] = {
        description = ("Granite"),
        groups = {cracky = 1, stone = 1, not_in_creative_inventory = nici}
    },

-- technic:marble
    ["marble"] = {
        description = ("Marble"),
        groups = {cracky = 3, stone = 1, marble = 1,
        not_in_creative_inventory = nici}
    },
    

-- technic:marbel_bricks
    ["marble_bricks"] = {
        description = ("Marble Briks"),
        groups = {cracky = 3, stone = 1, marble = 1,
        not_in_creative_inventory = nici}
    },

-- technic:uranium_block
    ["uranium_block"] = {
        description = ("Uranium"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici}
    },

-- technic:chromium_block
    ["chromium_block"] = {
        description = ("Chromium"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici}
    },

-- technic:zinc_block
    ["zinc_block"] = {
        description = ("Zinc"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici}
    },

-- technic:lead_block
    ["lead_block"] = {
        description = ("Lead"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici}
    },

-- technic:cast_iron_block
    ["cast_iron_block"] = {
        description = ("Cast Iron"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici}
    },

-- technic:carbon_steel_block
    ["carbon_steel_block"] = {
        description = ("Carbon Steel"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici}
    },

-- technic:stainless_steel_block
    ["stainless_steel_block"] = {
        description = ("Stainles Steel"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici}
    },
}

-- technic:wrougt_iron_block
mymillwork.register("technic:wrougt_iron_block",
    "technic_wrougt_iron_block",
    "Wrougt Iron",
    "default_steel_block.png",
    {cracky = 1, level = 2, not_in_creative_inventory = nici}
)

-- [[ Technic Concrete ]] --

-- if minetest.get_modpath("concrete") then

-- technic:blast_resistant_concrete


-- end

for name, def in pairs(nodes) do

        mymillwork.register("technic:"..name,
            "technic_"..name,
            def.description,
            "technic_"..name..".png",
            def.groups
            )

end
