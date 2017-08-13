--Config
instakill_sword = false
mode_debug = false

--Loads other files
dofile(minetest.get_modpath("peaceful_npc").."/npc/npc_def.lua")
dofile(minetest.get_modpath("peaceful_npc").."/npc/npc_fast.lua")
dofile(minetest.get_modpath("peaceful_npc").."/npc/npc_dwarf.lua")
dofile(minetest.get_modpath("peaceful_npc").."/commands.lua")
dofile(minetest.get_modpath("peaceful_npc").."/items.lua")
dofile(minetest.get_modpath("peaceful_npc").."/spawning.lua")
dofile(minetest.get_modpath("peaceful_npc").."/recipes.lua")

--NPC Privilege
minetest.register_privilege("peacefulnpc", { description = "allows to use spawn command", give_to_singleplayer = true})

--Aliases
minetest.register_alias("peaceful_npc:npc", "peaceful_npc:npc_def")


print("Peaceful NPC loaded! By jojoa1997!")
