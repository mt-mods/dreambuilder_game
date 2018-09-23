
local hotbar_size = minetest.setting_get("hotbar_size") or 16

local function resize_hotbar(size)
	if size == 8 then return "gui_hb_bg.png" end
	if size == 23 then return "gui_hb_bg_23.png" end
	return "gui_hb_bg_16.png"
end

minetest.register_on_joinplayer(function(player)
	player:hud_set_hotbar_itemcount(hotbar_size)
	minetest.after(0.5,function()
		player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
		player:hud_set_hotbar_image(resize_hotbar(hotbar_size))
	end)
end)

minetest.register_chatcommand("hotbar", {
	params = "[size]",
	description = "Sets the size of your hotbar",
	func = function(name, slots)
		if slots ~= "8" and slots ~= "23" then slots = "16" end
		local player = minetest.get_player_by_name(name)
		player:hud_set_hotbar_itemcount(tonumber(slots))
		minetest.chat_send_player(name, "[_] Hotbar size set to " .. tonumber(slots) .. ".")
		player:hud_set_hotbar_image(resize_hotbar(tonumber(slots)))
	end,
})

