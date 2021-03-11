if dreambuilder_theme.name ~= "dbtheme_light" then return end

print("[Dreambuilder] Activated \"light\" theme")

dreambuilder_theme.light = {
	["form_bgcolor"]             = "#F0F0F0FF",
	["btn_color"]                = "#B0B0B0FF",

	["editor_text_color"]        = "#000000FF",
	["editor_bg_color"]          = "#F0F0F0FF",

	["listcolor_slot_bg_normal"] = "#FFFFFF30",
	["listcolor_slot_bg_hover"]  = "#FFFFFF80",
	["listcolor_slot_border"]    = "#606060",

	["tooltip_bgcolor"]          = "#A0A0A0",
	["tooltip_fontcolor"]        = "#FFF",

	["window_darken"]            = "false",
	["editor_border"]            = "false",
	["image_button_borders"]     = "false"
}

for k,v in pairs(dreambuilder_theme.light) do
	dreambuilder_theme[k] = v
end

minetest.register_on_joinplayer(function(player)
	default.gui_bg = dreambuilder_theme.get_default_gui_bg(dreambuilder_theme)
	default.gui_survival_form = dreambuilder_theme.get_default_gui_survival_form(dreambuilder_theme)
	dreambuilder_theme.set_formspec_prepend(player, dreambuilder_theme)
end)
