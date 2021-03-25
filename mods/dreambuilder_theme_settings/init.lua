-- all this does is preload the global fallback color settings
--
-- Colors can be changed with your local minetest.conf, or you can skip that
-- and instead add a whole theme mod to override the colors and images
-- supplied by this component.
--
-- Theme mods need to depend on this mod to inherit the user's color
-- settings and selected theme from their minetest.conf.  This mod in turn
-- depends on `dreambuilder_theme_functions` for its global table.

-- This mod just supplies helpers to build slot backgrounds for mods that use formspec v1

dreambuilder_theme = {}

dreambuilder_theme.form_bgcolor =             minetest.settings:get("dreambuilder_theme_form_bgcolor")
dreambuilder_theme.btn_color =                minetest.settings:get("dreambuilder_theme_btn_color")
dreambuilder_theme.editor_text_color =        minetest.settings:get("dreambuilder_theme_editor_text_color")
dreambuilder_theme.editor_bg_color =          minetest.settings:get("dreambuilder_theme_editor_bg_color")
dreambuilder_theme.listcolor_slot_bg_normal = minetest.settings:get("dreambuilder_theme_listcolor_slot_bg_normal")
dreambuilder_theme.listcolor_slot_bg_hover =  minetest.settings:get("dreambuilder_theme_listcolor_slot_bg_hover")
dreambuilder_theme.listcolor_slot_border =    minetest.settings:get("dreambuilder_theme_listcolor_slot_border")
dreambuilder_theme.tooltip_bgcolor =          minetest.settings:get("dreambuilder_theme_tooltip_bgcolor")
dreambuilder_theme.tooltip_fontcolor =        minetest.settings:get("dreambuilder_theme_tooltip_fontcolor")

-- where these three are used, strings are needed, not actual bools.

dreambuilder_theme.window_darken =            minetest.settings:get_bool("dreambuilder_theme_window_darken") and "true" or "false"
dreambuilder_theme.editor_border =            minetest.settings:get_bool("dreambuilder_theme_editor_border") and "true" or "false"
dreambuilder_theme.image_button_borders =     minetest.settings:get_bool("dreambuilder_theme_image_button_borders") and "true" or "false"

dreambuilder_theme.name =                     minetest.settings:get("dreambuilder_theme_name")

if not dreambuilder_theme.name or dreambuilder_theme.name == "" then
	dreambuilder_theme.name = "dbtheme_light"
end

function dreambuilder_theme.single_slot_v1(xpos, ypos, bright)
	return string.format("background9[%f,%f;%f,%f;%s_ui_single_slot%s.png;false;16]",
	xpos, ypos, 1, 1.08, dreambuilder_theme.name, (bright and "_bright" or "") )
end

function dreambuilder_theme.make_inv_img_grid_v1(xpos, ypos, width, height, bright)
	local tiled = {}
	local n=1
	for y = 0, (height - 1) do
		for x = 0, (width -1) do
			tiled[n] = dreambuilder_theme.single_slot_v1(xpos + x, ypos + y, bright)
			n = n + 1
		end
	end
	return table.concat(tiled)
end

-- copied shamelessly from default ;-)

function dreambuilder_theme.get_default_gui_bg(theme)
	return "bgcolor["..theme.form_bgcolor..";"..theme.window_darken.."]"
end

function dreambuilder_theme.get_default_gui_survival_form(theme)
	return "size[8,8.5]"..
		dreambuilder_theme.get_default_gui_bg(theme)..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"list[current_player;craft;1.75,0.5;3,3;]"..
		"list[current_player;craftpreview;5.75,1.5;1,1;]"..
		"image[4.75,1.5;1,1;gui_furnace_arrow_bg.png^[transformR270]"..
		"listring[current_player;main]"..
		"listring[current_player;craft]"
end

function dreambuilder_theme.set_formspec_prepend(player, theme)
	-- Set formspec prepend
	local formspec =
		default.gui_bg..
		"listcolors["..theme.listcolor_slot_bg_normal..
			";"..theme.listcolor_slot_bg_hover..
			";"..theme.listcolor_slot_border..
			";"..theme.tooltip_bgcolor..
			";"..theme.tooltip_fontcolor.."]"..
		"style_type[button;bgcolor="..theme.btn_color.."]"..
		"style_type[button_exit;bgcolor="..theme.btn_color.."]"..
		"style_type[image_button;bgcolor="..theme.btn_color..
			";border="..theme.image_button_borders.."]"..
		"style_type[image_button_exit;bgcolor="..theme.btn_color..
			";border="..theme.image_button_borders.."]"..
		"style_type[item_image_button;bgcolor="..theme.btn_color..
			";border="..theme.image_button_borders.."]"
	local name = player:get_player_name()
	local info = minetest.get_player_information(name)
	if info.formspec_version > 1 then
		formspec = formspec .. "background9[5,5;1,1;"..theme.name.."_gui_formbg.png;true;10]"
	else
		formspec = formspec .. "background[5,5;1,1;"..theme.name.."_gui_formbg.png;true]"
	end
	player:set_formspec_prepend(formspec)

	-- Set hotbar textures
	player:hud_set_hotbar_image("gui_hotbar.png")
	player:hud_set_hotbar_selected_image("gui_hotbar_selected.png")
end
