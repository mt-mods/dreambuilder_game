local CONFIG_FILE_PREFIX = "caverealms."

caverealms.config = {}

-- This function based on kaeza/minetest-irc/config.lua and used under the
-- terms of BSD 2-clause license.
local function setting(stype, name, default)
	local value
	if stype == "bool" then
		value = minetest.settings:get_bool(CONFIG_FILE_PREFIX..name)
	elseif stype == "string" then
		value = minetest.settings:get(CONFIG_FILE_PREFIX..name)
	elseif stype == "number" then
		value = tonumber(minetest.settings:get(CONFIG_FILE_PREFIX..name))
	end
	if value == nil then
		value = default
	end
	caverealms.config[name] = value
end

--generation settings
setting("number", "ymin", -33000) --bottom realm limit
setting("number", "ymax", -1500) --top realm limit
setting("number", "tcave", 0.75) --cave threshold

--decoration chances
setting("number", "stagcha", 0.003) --chance of stalagmites
setting("number", "stalcha", 0.003) --chance of stalactites

setting("number", "h_lag", 8) --max height for stalagmites
setting("number", "h_lac", 8) --...stalactites
setting("number", "crystal", 0.0002) --chance of glow crystal formations
setting("number", "h_cry", 8) --max height of glow crystals
setting("number", "h_clac", 8) --max height of glow crystal stalactites

setting("number", "gemcha", 0.03) --chance of small glow gems
setting("number", "mushcha", 0.04) --chance of mushrooms
setting("number", "myccha", 0.03) --chance of mycena mushrooms
setting("number", "wormcha", 0.015) --chance of glow worms
setting("number", "giantcha", 0.001) --chance of giant mushrooms
setting("number", "icicha", 0.035) --chance of icicles
setting("number", "flacha", 0.04) --chance of constant flames

--realm limits for Dungeon Masters' Lair
setting("number", "dm_top", -14000) --upper limit
setting("number", "dm_bot", -16000) --lower limit

--should DMs spawn in DM Lair?
setting("bool", "dm_spawn", true) 

--Deep cave settings
setting("number", "deep_cave", -7000) -- upper limit
