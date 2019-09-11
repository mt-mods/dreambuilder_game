mymillwork = {}

print("Loading mymillwork...")

dofile(minetest.get_modpath("mymillwork").."/machines.lua")
dofile(minetest.get_modpath("mymillwork").."/nodes.lua")
dofile(minetest.get_modpath("mymillwork").."/materials.lua")

if minetest.get_modpath("bakedclay") then
    print("[mymillwork] Bakedclay detected")
    dofile(minetest.get_modpath("mymillwork").."/materials_bakedclay.lua")
end

if minetest.get_modpath("ethereal") then
    print("[mymillwork] Ethereal detected")
    dofile(minetest.get_modpath("mymillwork").."/materials_ethereal.lua")
end

if minetest.get_modpath("moreblocks") then
    print("[mymillwork] Moreblocks detected")
    dofile(minetest.get_modpath("mymillwork").."/materials_moreblocks.lua")
end

if minetest.get_modpath("technic_worldgen") then
    print("[mymillwork] Technic Worldgen detected")
    dofile(minetest.get_modpath("mymillwork").."/materials_technic.lua")
end
