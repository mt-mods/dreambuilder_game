local S = minetest.get_translator(minetest.get_current_modname())

minetest.register_alias("castle:hides",  "castle_farming:hides")

minetest.register_node("castle_farming:hides", {
	drawtype = "nodebox",
	description = S("Hides"),
	inventory_image = "castle_hide.png",
	paramtype = "light",
	walkable = false,
	tiles = {'castle_hide.png'},
	climbable = true,
	paramtype2 = "wallmounted",
	groups = {dig_immediate=2},
	node_box = {
		type = "wallmounted",
		wall_top    = {-0.5, 0.4375, -0.5, 0.5, 0.5, 0.5},
		wall_bottom = {-0.5, -0.5, -0.5, 0.5, -0.4375, 0.5},
		wall_side   = {-0.5, -0.5, -0.5, -0.4375, 0.5, 0.5},
	},
})

minetest.register_craft( {
	type = "shapeless",
	output = "castle_farming:hides 6",
	recipe = { "wool:white" , "bucket:bucket_water" },
	replacements = {
		{ 'bucket:bucket_water', 'bucket:bucket_empty' }
	}
})
