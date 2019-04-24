local mtver = minetest.get_version()
local maxslots = (string.sub(mtver.string, 1, 4) ~= "0.4.") and 32 or 23

local function validate_size(s)
	local size = s and tonumber(s) or 16
	if (size == 8 or size == 16 or size == 23 or size == 24 or size == 32)
	  and size <= maxslots then
		return size
	else
		return 16
	end
end

local hotbar_size_default = validate_size(minetest.setting_get("hotbar_size"))

local player_hotbar_settings = {}

local function load_hotbar_settings()
	local f = io.open(minetest.get_worldpath()..DIR_DELIM.."hotbar_settings","r")
	if not f then return end
	local d = f:read("*all")
	f:close()
	player_hotbar_settings = minetest.deserialize(d)
end

local function save_hotbar_settings()
	local f = io.open(minetest.get_worldpath()..DIR_DELIM.."hotbar_settings","w")
	if not f then
		minetest.log("error","Failed to save hotbar settings")
		return
	end
	local d = minetest.serialize(player_hotbar_settings)
	f:write(d)
	f:close()
end

local function get_hotbar_setting(name)
	return tonumber(player_hotbar_settings[name]) or hotbar_size_default
end

load_hotbar_settings()

minetest.register_on_joinplayer(function(player)
	local hotbar_size = validate_size(get_hotbar_setting(player:get_player_name()))
	player:hud_set_hotbar_itemcount(hotbar_size)
	minetest.after(0.5,function(hotbar_size)
		player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
		player:hud_set_hotbar_image("gui_hb_bg_"..hotbar_size..".png")
	end,hotbar_size)
end)

minetest.register_chatcommand("hotbar", {
	params = "[size]",
	description = "Sets the size of your hotbar",
	func = function(name, slots)
		local hotbar_size = validate_size(tonumber(slots))
		player_hotbar_settings[name] = hotbar_size
		local player = minetest.get_player_by_name(name)
		player:hud_set_hotbar_itemcount(hotbar_size)
		minetest.chat_send_player(name, "[_] Hotbar size set to " ..hotbar_size.. ".")
		player:hud_set_hotbar_image("gui_hb_bg_"..hotbar_size..".png")
		save_hotbar_settings()
	end,
})
