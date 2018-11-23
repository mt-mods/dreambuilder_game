local hotbar_size_default = minetest.setting_get("hotbar_size") or 16

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

local function resize_hotbar(size)
	if size == 8 then return "gui_hb_bg.png" end
	if size == 23 then return "gui_hb_bg_23.png" end
	return "gui_hb_bg_16.png"
end

minetest.register_on_joinplayer(function(player)
	local hotbar_size = get_hotbar_setting(player:get_player_name())
	player:hud_set_hotbar_itemcount(hotbar_size)
	minetest.after(0.5,function(hotbar_size)
		player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
		player:hud_set_hotbar_image(resize_hotbar(hotbar_size))
	end,hotbar_size)
end)

minetest.register_chatcommand("hotbar", {
	params = "[size]",
	description = "Sets the size of your hotbar",
	func = function(name, slots)
		if slots ~= "8" and slots ~= "23" then slots = "16" end
		player_hotbar_settings[name] = slots
		local player = minetest.get_player_by_name(name)
		player:hud_set_hotbar_itemcount(tonumber(slots))
		minetest.chat_send_player(name, "[_] Hotbar size set to " .. tonumber(slots) .. ".")
		player:hud_set_hotbar_image(resize_hotbar(tonumber(slots)))
		save_hotbar_settings()
	end,
})
