-- all this does is preload the global fallback color settings
--
-- Colors can be changed with your local minetest.conf, or you can skip that
-- and instead add a whole theme mod to override the colors and images
-- supplied by this component.
--
-- Theme mods should depend on this mod to inherit the user's color
-- settings from their minetest.conf.  This mod in turn depends on
-- `dreambuilder_theme_functions` for its global table.

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
