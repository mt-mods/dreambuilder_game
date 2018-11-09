-- This mod contains a number of features specific to dreambuilder
-- such as mesh-based apples, some color settings, etc.
--
-- by Vanessa Dannenberg

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
