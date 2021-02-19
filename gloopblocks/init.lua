--[[
GloopBlocks
Originally written by GloopMaster

Maintained by VanessaE.

--]]

gloopblocks = {}

-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

dofile(MP.."/main.lua")
dofile(MP.."/crafts.lua")
dofile(MP.."/lava-handling.lua")

print(S("Gloopblocks Loaded!"))
