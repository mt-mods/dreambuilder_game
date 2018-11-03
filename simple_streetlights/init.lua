-- simple streetlight spawner mod

local modpath = minetest.get_modpath("simple_streetlights")

dofile(modpath.."/simple.lua")
if minetest.get_modpath("homedecor") and minetest.get_modpath("streetspoles") then
	dofile(modpath.."/minedot.lua")
end
