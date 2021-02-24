local function pivot(table)
	local ret = {}
	for k,v in pairs(table) do
		ret[v] = k
	end
	return ret
end

local textures = pivot(minetest.get_dir_list(minetest.get_modpath("player_textures")..DIR_DELIM.."textures"))
local mesh = minetest.get_modpath("3d_armor") and "3d_armor_character.b3d" or "character.b3d"

local function applyskin(player)
	local name = player:get_player_name()
	if textures[string.format("player_%s.png",name)] then
		if minetest.get_modpath("default") then
			default.player_set_textures(player,string.format("player_%s.png",name))
		end
		player:set_properties({textures={string.format("player_%s.png",name)}})
	end
	player:set_properties({visual="mesh",visual_size={x=1,y=1},mesh=mesh})
end

minetest.register_on_joinplayer(function(player)
	applyskin(player)
end)
