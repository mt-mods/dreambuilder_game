local modpath = minetest.get_modpath("dreambuilder_mymillwork")

if minetest.get_modpath("bakedclay") then
    dofile(modpath.."/materials_bakedclay.lua")
end

if minetest.get_modpath("ethereal") then
    print("[mymillwork] Ethereal detected")
    dofile(modpath.."/materials_ethereal.lua")
end

if minetest.get_modpath("moreblocks") then
    dofile(modpath.."/materials_moreblocks.lua")
end

if minetest.get_modpath("technic_worldgen") then
    dofile(modpath.."/materials_technic.lua")
end