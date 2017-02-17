-- This mod contains a number of features specific to dreambuilder
-- such as mesh-based apples, 16-slot hotbar, some color settings, etc.
--
-- by Vanessa Ezekowitz

local hotbar_size = minetest.setting_get("hotbar_size") or 16

local function resize_hotbar(size)
	if size > 8 then return "gui_hb_bg_16.png" end
	return "gui_hb_bg.png"
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
		if slots ~= "8" then slots = "16" end
		local player = minetest.get_player_by_name(name)
		player:hud_set_hotbar_itemcount(tonumber(slots))
		minetest.chat_send_player(name, "[_] Hotbar size set to " .. tonumber(slots) .. ".")
		player:hud_set_hotbar_image(resize_hotbar(tonumber(slots)))
	end,
})

default.gui_bg = "bgcolor[#08080899;false]"

default.gui_survival_form = "size[8,8.5]"..
			default.gui_bg..
			default.gui_bg_img..
			default.gui_slots..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;1.75,0.5;3,3;]"..
			"list[current_player;craftpreview;5.75,1.5;1,1;]"..
			"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)

default.cool_lava = function (pos, node) end

minetest.register_abm({
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"group:water"},
	interval = 5,
	chance = 15,
	catch_up = false,
	action = function(...)
		default.cool_lava(...)
	end,
})

minetest.override_item("default:apple", {
	drawtype = "mesh",
	mesh = "default_apple.obj",
	tiles = {"default_apple_3d.png"}
})
