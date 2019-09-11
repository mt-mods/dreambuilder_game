minetest.register_node("solidcolor:block", {
	description = "Solid Color Block",
	tiles = {"solidcolor_white.png"},
	is_ground_content = false,
	groups = {dig_immediate=2,ud_param2_colorable=1},
	sounds = (default and default.node_sound_stone_defaults()),
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	on_construct = unifieddyes.on_construct,
	on_dig = unifieddyes.on_dig,
})

minetest.register_craft( {
        output = "solidcolor:block",
        recipe = {
                { "dye:white", "dye:white"},
                { "dye:white", "dye:white"},
        },
})

unifieddyes.register_color_craft({
	output = "solidcolor:block",
	palette = "extended",
	type = "shapeless",
	neutral_node = "solidcolor:block",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

