minetest.register_node("gardening:rosebush", {
	description = "Rosebush",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_rosebush.png",
	wield_image = "gardening_rosebush.png",
	tiles = {"gardening_rosebush.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
--	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'gardening:rosebush',
	recipe = {
		{'flowers:rose'},
		{'default:leaves'},
		{'default:tree'},
	},
})

-- geraniums

minetest.register_node("gardening:geranium_shrub", {
	description = "Geranium cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_geranium_shrub.png",
	wield_image = "gardening_geranium_shrub.png",
	tiles = {"gardening_geranium_shrub.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
--	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'gardening:geranium_shrub',
	recipe = {
		{'flowers:geranium'},
		{'default:leaves'},
		{'default:tree'},
	},
})

-- viola

minetest.register_node("gardening:violas", {
	description = "Violas cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_violas.png",
	wield_image = "gardening_violas.png",
	tiles = {"gardening_violas.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
--	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'gardening:violas',
	recipe = {
		{'flowers:viola'},
		{'default:leaves'},
		{'default:tree'},
	},
})

-- dandelions

minetest.register_node('gardening:dandelions', {
	description = "Dandelion cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_dandelions.png",
	wield_image = "gardening_dandelions.png",
	tiles = {"gardening_dandelions.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
--	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'gardening:dandelions',
	recipe = {
		{'', 'flowers:dandelion_yellow', 'flowers:dandelion_white'},
		{'', 'default:leaves', ''},
		{'', 'default:tree', ''},
	},
})

--tulips

minetest.register_node("gardening:tulip_shrub", {
	description = "Tulip cluster",
	drawtype = "plantlike",
	visual_scale = 1.1,
	inventory_image = "gardening_tulip_shrub.png",
	wield_image = "gardening_tulip_shrub.png",
	tiles = {"gardening_tulip_shrub.png"},
	paramtype = "light",
	walkable = false,
	buildable_to = true,
	is_ground_content = true,
	groups = {snappy=3,flammable=3,attached_node=1},
--	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -2.5/16, 0.5},
	},
})

minetest.register_craft({
	output = 'gardening:tulip_shrub',
	recipe = {
		{'flowers:tulip'},
		{'default:leaves'},
		{'default:tree'},
	},
})

--packed dirt

minetest.register_node("gardening:packed_dirt", {
	description = "Packed Dirt",
	tiles = {"gardening_packed_dirt.png"},
	is_ground_content = true,
	groups = {crumbly=3},
--	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_craft({
	output = 'gardening:packed_dirt 3',
	recipe = {
		{'default:stone'},
		{'default:sand'},
		{'default:dirt'},
	}
})


