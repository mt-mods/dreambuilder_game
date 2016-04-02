print(" Currency mod loading... ")
local modpath = minetest.get_modpath("currency")

dofile(modpath.."/craftitems.lua")
print("[Currency] Craft_items Loaded!")
dofile(modpath.."/shop.lua")
print("[Currency] Shop Loaded!")
dofile(modpath.."/barter.lua")
print("[Currency]  Barter Loaded!")
dofile(modpath.."/safe.lua")
print("[Currency] Safe Loaded!")
dofile(modpath.."/crafting.lua")
print("[Currency] Crafting Loaded!")

if minetest.setting_getbool("creative_mode") then
	print("[Currency] Creative mode in use, skipping basic income.")
else
	dofile(modpath.."/income.lua")
	print("[Currency] Income Loaded!")
end
