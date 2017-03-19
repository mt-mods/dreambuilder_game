minetest.register_node("solidcolor:block", {
	description = "Solid Color Block",
	tiles = {"solidcolor_white.png"},
	is_ground_content = false,
	groups = {dig_immediate=2,ud_param2_colorable=1},
	sounds = (default and default.node_sound_stone_defaults()),
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	after_dig_node = unifieddyes.after_dig_node,
	place_param2 = 240,
	on_construct = unifieddyes.on_construct,
	after_place_node = unifieddyes.recolor_on_place,
})

minetest.register_craft( {
        output = "solidcolor:block",
        recipe = {
                { "dye:white", "dye:white"},
                { "dye:white", "dye:white"},
        },
})

minetest.register_lbm({
	name = "solidcolor:recolor",
	label = "Convert to new palette",
	nodenames = {"solidcolor:block"},
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		if meta:get_string("palette") ~= "ext" then
			if node.param2 == 0 then
				node.param2 = 240
			else
				node.param2 = unifieddyes.convert_classic_palette[node.param2]
			end
			minetest.swap_node(pos,node)
			meta:set_string("palette", "ext")
		end
	end
})
