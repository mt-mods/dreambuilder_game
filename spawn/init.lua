--a Fusion of cheapies and Zeno's spawn mode with extra CWz flavored goodness
--Originally written by VanessaE (I think), rewritten by cheapie
--WTFPL


-- Some modified from: Minetest: builtin/static_spawn.lua LGPL

local function check_spawnpoint(config_setting)
	if not minetest.setting_get(config_setting) then
		minetest.log('error', "The \"" .. config_setting .. "\" setting is not set")
		return false
	end

	if not minetest.setting_get_pos(config_setting) then
		minetest.log('error', "The " .. config_setting .. " setting is invalid: \""..
				core.setting_get(config_setting).."\"")
		return false
	end
	return true
end


local function put_player_at_spawn(obj)

	local config_setting

	-- players with interact spawn at the location specified by
	-- "alt_spawnpoint" in the .conf file. Those *without* interact go to
	-- "static_spawnpoint".

	if not minetest.get_player_privs(obj:get_player_name()).interact then
		config_setting  = "static_spawnpoint"
	else
		config_setting  = "alt_spawnpoint"
	end

	if not check_spawnpoint(config_setting) then
		return false
	end

	local spawnpoint = minetest.setting_get_pos(config_setting)

	minetest.log('action', "Moving " .. obj:get_player_name() ..
			" to " .. config_setting .. " at "..
			minetest.pos_to_string(spawnpoint))

	obj:setpos(spawnpoint)

	return true
end


minetest.register_chatcommand("spawn", {
	description = "Teleport to the spawn location",
	privs = {},
	func = function(name, _)
		local ok = put_player_at_spawn(minetest.get_player_by_name(name))
		if ok then
			return true, "Teleporting to spawn..."
		end
		return false, "Teleport failed"
	end
})


minetest.register_on_newplayer(function(obj)
	return put_player_at_spawn(obj)
end)

minetest.register_on_respawnplayer(function(obj)
	return put_player_at_spawn(obj)
end)


minetest.register_chatcommand("setspawn", {
	params = "",
	description = "Sets the spawn point to your current position",
	privs = { server=true },
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end
		local pos = player:getpos()
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local pos_string = x..","..y..","..z
		local pos_string_2 = "Setting spawn point to ("..x..", "..y..", "..z..")"
		minetest.setting_set("static_spawnpoint",pos_string)
		spawn_spawnpos = pos
		minetest.setting_save()
		return true, pos_string_2
	end,
})
-- alt_spawnpoint
minetest.register_chatcommand("setaltspawn", {
	params = "",
	description = "Sets the alt spawn point to your current position",
	privs = { server=true },
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		if not player then
			return false, "Player not found"
		end
		local pos = player:getpos()
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local pos_string = x..","..y..","..z
		local pos_string_2 = "Setting alt spawn point to ("..x..", "..y..", "..z..")"
		minetest.setting_set("alt_spawnpoint",pos_string)
		spawn_spawnpos = pos
		minetest.setting_save()
		return true, pos_string_2
	end,
})
