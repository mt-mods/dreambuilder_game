-- This file just makes some tweaks to the various default plants and some
-- non-default ones that depend on biome_lib, to make them wave if the
-- appropriate shader is enabled.  This code is temporary and will be trimmed 
-- down as the mods supplying those objects are updated.

-- default stuff

for i = 1, 5 do 
	minetest.override_item("default:grass_"..i, { waving = 1 })
end

minetest.override_item("default:junglegrass", { waving = 1 })

-- farming, farming_plus 

for i = 1, 8 do
	minetest.override_item("farming:wheat_"..i, { waving = 1 })
	minetest.override_item("farming:cotton_"..i, { waving = 1 })
end

-- Undergrowth modpack

minetest.override_item("youngtrees:youngtree_top", { waving = 1 })

-- Ferns mod

for i = 1, 3 do
	minetest.override_item("ferns:fern_0"..i, { waving = 1 })
end

minetest.override_item("ferns:tree_fern_leaves", { waving = 1 })

-- Dryplants mod

minetest.override_item("dryplants:reedmace_height_2", { waving = 1 })
minetest.override_item("dryplants:reedmace_height_3", { waving = 1 })
minetest.override_item("dryplants:reedmace_height_3_spikes", { waving = 1 })
minetest.override_item("dryplants:juncus", { waving = 1 })
minetest.override_item("dryplants:juncus_02", { waving = 1 })

