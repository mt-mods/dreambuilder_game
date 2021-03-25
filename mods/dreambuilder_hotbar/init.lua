local themename = dreambuilder_theme and dreambuilder_theme.name.."_" or ""

local player_hotbar_settings = {}
local f = io.open(minetest.get_worldpath()..DIR_DELIM.."hotbar_settings","r")
if f then
	player_hotbar_settings = minetest.deserialize(f:read("*all"))
	f:close()
end

local function validate_size(s)
	local size = s and tonumber(s) or 16
	return math.floor(0.5 + math.max(1, math.min(size, 32)))
end

local hotbar_size_default = validate_size(minetest.settings:get("hotbar_size"))

local base_img = themename.."gui_hb_bg_1.png"
local imgref_len = string.len(base_img) + 8 -- accounts for the stuff in the string.format() below.

local img = {}
for i = 0, 31 do
	img[i+1] = string.format(":%04i,0=%s", i*64, base_img)
end
local hb_img = table.concat(img)

local function set_hotbar_size(player, s)
	local hotbar_size = validate_size(s)
	player:hud_set_hotbar_itemcount(hotbar_size)
	player:hud_set_hotbar_selected_image(themename.."gui_hotbar_selected.png")
	player:hud_set_hotbar_image("[combine:"..(hotbar_size*64).."x64"..string.sub(hb_img, 1, hotbar_size*imgref_len))
	return hotbar_size
end

minetest.register_on_joinplayer(function(player)
	minetest.after(0.5,function(hotbar_size)
		set_hotbar_size(player, tonumber(player_hotbar_settings[player:get_player_name()]) or hotbar_size_default)
	end, hotbar_size)
end)

minetest.register_chatcommand("hotbar", {
	params = "[size]",
	description = "Sets the size of your hotbar, from 1 to 32 slots, default 16",
	func = function(name, slots)
		local size = set_hotbar_size(minetest.get_player_by_name(name), slots)
		player_hotbar_settings[name] = size
		minetest.chat_send_player(name, "[_] Hotbar size set to " ..size.. ".")

		local f = io.open(minetest.get_worldpath()..DIR_DELIM.."hotbar_settings","w")
		if not f then
			minetest.log("error","Failed to save hotbar settings")
		else
			f:write(minetest.serialize(player_hotbar_settings))
			f:close()
		end
	end,
})
