minetest.register_alias("castle:shield", "castle_shields:shield_1")
minetest.register_alias("castle:shield_2", "castle_shields:shield_2")
minetest.register_alias("castle:shield_3", "castle_shields:shield_3")

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

--The following colors are permitted:
-- "black", "blue", "brown", "cyan", "dark_green", "dark_grey", "green", "grey", "magenta", "orange", "pink", "red", "violet", "white", "yellow"
--The following patterns are permitted:
-- "slash", "chevron", "cross"

-- method parameters are name, desc, background_color, foreground_color, pattern

castle_shields.register_shield("shield_1", S("Mounted Shield"), "red", "blue", "slash")
castle_shields.register_shield("shield_2", S("Mounted Shield"), "cyan", "yellow", "chevron")
castle_shields.register_shield("shield_3", S("Mounted Shield"), "grey", "green", "cross")