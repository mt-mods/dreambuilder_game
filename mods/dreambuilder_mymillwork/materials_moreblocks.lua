local nici = 1

local nodes = {

--moreblocks_cactus_brick
    ["cactus_brick"] = {
        description = ("Cactus Brick"),
        groups = {cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_circle_stone_bricks
    ["circle_stone_bricks"] = {
        description = ("Circle Stone Bricks"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_clean_glass
--moreblocks_clean_glass_detail
--moreblocks_coal_glass_stairsplus

--moreblocks_coal_stone
    ["coal_stone"] = {
        description = ("Coal Stone"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_coal_stone_bricks
    ["coal_stone_bricks"] = {
        description = ("Coal Stone Bricks"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_cobble_compressed
    ["cobble_compressed"] = {
        description = ("Cobble Compressed"),
        groups = {cracky = 1, not_in_creative_inventory = nici},
    },

--moreblocks_copperpatina
    ["copperpatina"] = {
        description = ("Copper Patina"),
        groups = {cracky = 1, level = 2, not_in_creative_inventory = nici},
    },

--moreblocks_dirt_compressed
    ["dirt_compressed"] = {
        description = ("Dirt Compressed"),
        groups = {crumbly = 2, not_in_creative_inventory = nici},
    },

--moreblocks_grey_bricks
    ["grey_bricks"] = {
        description = ("Grey Bricks"),
        groups = {cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_iron_stone
    ["iron_stone"] = {
        description = ("Iron Stone"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_iron_stone_bricks
    ["iron_stone_bricks"] = {
        description = ("Iron Stone Bricks"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_plankstone
    ["plankstone"] = {
        description = ("Plankstone"),
        groups = {cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_split_stone_tile
--moreblocks_split_stone_tile_top
    ["split_stone_tile_top"] = {
        description = ("Split Stone Tile"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_stone_tile
    ["stone_tile"] = {
        description = ("Stone Tile"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_checker_stone_tile
    ["checker_stone_tile"] = {
        description = ("Checker Stone Tile"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_tar
    ["tar"] = {
        description = ("Tar"),
        groups = {cracky = 2, tar_block = 1, not_in_creative_inventory = nici},
    },

}

local nodes_checker = {

--moreblocks_cactus_checker
    ["cactus_checker"] = {
        description = ("Cactus Checker"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_coal_checker
    ["coal_checker"] = {
        description = ("Coal Checker"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },

--moreblocks_iron_checker
    ["iron_checker"] = {
        description = ("Iron Checker"),
        groups = {stone = 1, cracky = 3, not_in_creative_inventory = nici},
    },
}

local nodes_all_faces = {

--moreblocks_all_faces_tree
    ["all_faces_tree"] = {
        description = "All-faces Tree",
        tiles = {"default_tree_top.png"},
    },

--moreblocks_all_faces_jungle_tree
    ["all_faces_jungle_tree"] = {
        description = "All-faces Jungle Tree",
        tiles = {"default_jungletree_top.png"},
    },

--moreblocks_all_faces_pine_tree
    ["all_faces_pine_tree"] = {
        description = "All-faces Pine Tree",
        tiles = {"default_pine_tree_top.png"},
    },

--moreblocks_all_faces_acacia_tree
    ["all_faces_acacia_tree"] = {
        description = "All-faces Acacia Tree",
        tiles = {"default_acacia_tree_top.png"},
    },

--moreblocks_all_faces_aspen_tree
    ["all_faces_aspen_tree"] = {
        description = "All-faces Aspen Tree",
        tiles = {"default_aspen_tree_top.png"},
    },

}


for name, def in pairs(nodes) do

    mymillwork.register("moreblocks:"..name,
        "morebloks_"..name,
        def.description,
        "moreblocks_"..name..".png",
        def.groups
        )

end

for name, def in pairs(nodes_checker) do

    mymillwork.register("moreblocks:"..name,
        "morebloks_"..name,
        def.description,
        "default_stone.png^moreblocks_"..name..".png",
        def.groups
        )

end

for name, def in pairs(nodes_all_faces) do

    mymillwork.register("moreblocks:"..name,
        "morebloks_"..name,
        def.description,
        def.tiles[1],
        {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2,
        not_in_creative_inventory = nici}
        )

end
