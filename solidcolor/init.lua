minetest.register_node("solidcolor:block", {
	description = "Solid Color Block",
	tiles = {"solidcolor_white.png"},
	is_ground_content = false,
	groups = {dig_immediate=2,ud_param2_colorable=1},
	sounds = (default and default.node_sound_stone_defaults()),
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	after_dig_node = unifieddyes.after_dig_node,
})

minetest.register_craft( {
        output = "solidcolor:block",
        recipe = {
                { "dye:white", "dye:white"},
                { "dye:white", "dye:white"},
        },
})
