-- This mod provides your standard green street name signs
-- (that is, the two-up, 2m high ones identifying street intersections),
-- the larger kind found above or alongside highways,
-- and a selection of other kinds of signs like stop, pedestrian crossing,
-- yield, US Route, and so on (all from MUTCD 2009 R2)
--
-- forked from signs_lib by Diego Martinez et. al

street_signs = {}
street_signs.path = minetest.get_modpath(minetest.get_current_modname())
screwdriver = screwdriver or {}

-- Load support for intllib.
local S, NS = dofile(street_signs.path .. "/intllib.lua")
street_signs.gettext = S

dofile(street_signs.path .. "/encoding.lua") -- text encoding

street_signs.big_sign_colors = {
	{ "green",  "f", "dye:green",  "dye:white" },
	{ "blue",   "f", "dye:blue",   "dye:white" },
	{ "yellow", "0", "dye:yellow", "dye:black" },
	{ "orange", "0", "dye:orange", "dye:black" }
}

dofile(street_signs.path.."/api.lua")
dofile(street_signs.path.."/signs.lua")
dofile(street_signs.path.."/crafting.lua")
dofile(street_signs.path.."/compat_convert.lua")

if minetest.settings:get("log_mods") then
	minetest.log("action", S("[MOD] Street signs loaded"))
end
