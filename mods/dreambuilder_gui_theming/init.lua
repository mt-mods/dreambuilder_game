-- Dreambuilder theming mod
-- really all this does is preload the global config and supply some textures :P
-- colors can be changed with your local minetest.conf

dreambuilder = {}

dreambuilder.form_bgcolor =             minetest.settings:get("dreambuilder_form_bgcolor")

dreambuilder.btn_color =                minetest.settings:get("dreambuilder_btn_color")
dreambuilder.editor_text_color =        minetest.settings:get("dreambuilder_editor_text_color")
dreambuilder.editor_bg_color =          minetest.settings:get("dreambuilder_editor_bg_color")
dreambuilder.listcolor_slot_bg_normal = minetest.settings:get("dreambuilder_listcolor_slot_bg_normal")
dreambuilder.listcolor_slot_bg_hover =  minetest.settings:get("dreambuilder_listcolor_slot_bg_hover")
dreambuilder.listcolor_slot_border =    minetest.settings:get("dreambuilder_listcolor_slot_border")
dreambuilder.tooltip_bgcolor =          minetest.settings:get("dreambuilder_tooltip_bgcolor")
dreambuilder.tooltip_fontcolor =        minetest.settings:get("dreambuilder_tooltip_fontcolor")

-- where these three are used, strings are needed, not actual bools.

dreambuilder.window_darken =            minetest.settings:get_bool("dreambuilder_window_darken") and "true" or "false"
dreambuilder.editor_border =            minetest.settings:get_bool("dreambuilder_editor_border") and "true" or "false"
dreambuilder.image_button_borders =     minetest.settings:get_bool("dreambuilder_image_button_borders") and "true" or "false"
