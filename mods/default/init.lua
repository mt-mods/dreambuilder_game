-- Minetest 0.4 mod: default
-- See README.txt for licensing and other information.

-- The API documentation in here was moved into game_api.txt

-- Load support for MT game translation.
local S = minetest.get_translator("default")

-- Definitions made by this mod that other mods can use too
default = {}

default.LIGHT_MAX = 14
default.get_translator = S

-- GUI related stuff
minetest.register_on_joinplayer(function(player)
	-- Set formspec prepend
		local formspec = 
		"listcolors["..dreambuilder_theme.listcolor_slot_bg_normal..
			";"..dreambuilder_theme.listcolor_slot_bg_hover..
			";"..dreambuilder_theme.listcolor_slot_border..
			";"..dreambuilder_theme.tooltip_bgcolor..
			";"..dreambuilder_theme.tooltip_fontcolor.."]"..
		"style_type[button;bgcolor="..dreambuilder_theme.btn_color.."]"..
		"style_type[button_exit;bgcolor="..dreambuilder_theme.btn_color.."]"..
		"style_type[image_button;bgcolor="..dreambuilder_theme.btn_color..
			";border="..dreambuilder_theme.image_button_borders.."]"..
		"style_type[image_button_exit;bgcolor="..dreambuilder_theme.btn_color..
			";border="..dreambuilder_theme.image_button_borders.."]"..
		"style_type[item_image_button;bgcolor="..dreambuilder_theme.btn_color..
			";border="..dreambuilder_theme.image_button_borders.."]"
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	if info.formspec_version > 1 then
		formspec = formspec .. "background9[5,5;1,1;"..dreambuilder_theme.name.."_gui_formbg.png;true;10]"
	else
		formspec = formspec .. "background[5,5;1,1;"..dreambuilder_theme.name.."_gui_formbg.png;true]"
	end
	player:set_formspec_prepend(formspec)

	-- Set hotbar textures
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end)

function default.get_hotbar_bg(x,y)
	local out = ""
	for i=0,7,1 do
		out = out .."image["..x+i..","..y..";1,1;gui_hb_bg.png]"
	end
	return out
end

default.gui_bg = "bgcolor["..dreambuilder_theme.form_bgcolor..";"..dreambuilder_theme.window_darken.."]"

default.gui_survival_form = "size[8,8.5]"..
			default.gui_bg..
			"list[current_player;main;0,4.25;8,1;]"..
			"list[current_player;main;0,5.5;8,3;8]"..
			"list[current_player;craft;1.75,0.5;3,3;]"..
			"list[current_player;craftpreview;5.75,1.5;1,1;]"..
			"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
			"listring[current_player;main]"..
			"listring[current_player;craft]"..
			default.get_hotbar_bg(0,4.25)

-- Load files
local default_path = minetest.get_modpath("default")

dofile(default_path.."/functions.lua")
dofile(default_path.."/trees.lua")
dofile(default_path.."/nodes.lua")
dofile(default_path.."/chests.lua")
dofile(default_path.."/furnace.lua")
dofile(default_path.."/torch.lua")
dofile(default_path.."/tools.lua")
dofile(default_path.."/item_entity.lua")
dofile(default_path.."/craftitems.lua")
dofile(default_path.."/crafting.lua")
dofile(default_path.."/mapgen.lua")
dofile(default_path.."/aliases.lua")
dofile(default_path.."/legacy.lua")
