-- GloopTest general initiation file.
-- To edit what modules will load, please edit module.cfg which can be found in the same folder as this file.
--
-- GloopTest random data:
--    Version                             : 0.0.4a
--    Current module amount               : 6
--    Current compatible minetest version : 0.4.7
--    License                             : CC-BY-SA
--    Totals: lol I don't know
-- End random data.

-- Open configuration files.
dofile(minetest.get_modpath("glooptest").."/general.cfg")
dofile(minetest.get_modpath("glooptest").."/module.cfg")

-- Set up some variables and crap.
local modules_loaded = 0
glooptest = {}

-- Set up some general functions for random crap.
function glooptest.debug(level,message)
	print("["..level.."][GloopTest v0.0.4a] "..message)
end

if LOAD_ORE_MODULE == true then
	dofile(minetest.get_modpath("glooptest").."/ore_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if LOAD_TOOLS_MODULE == true then
	dofile(minetest.get_modpath("glooptest").."/tools_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if LOAD_PARTS_MODULE == true then
	dofile(minetest.get_modpath("glooptest").."/parts_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if LOAD_TECH_MODULE == true then
	dofile(minetest.get_modpath("glooptest").."/tech_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if LOAD_OTHERGEN_MODULE == true then
	dofile(minetest.get_modpath("glooptest").."/othergen_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if LOAD_COMPAT_MODULE == true then
	dofile(minetest.get_modpath("glooptest").."/compat_module/init.lua")
	local modulecount = modules_loaded
	modules_loaded = modulecount+1
end

if modules_loaded == 0 then
	glooptest.debug("ERROR","It helps if you activate some of the modules.")
else
	glooptest.debug("MESSAGE",modules_loaded.." modules were successfully loaded!")
end
