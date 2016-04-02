minetest.register_node( "display_blocks:uranium_ore", {
	description = "Uranium Ore",
	tiles = { "default_stone.png^uranium_ore.png" },
	is_ground_content = true,
	groups = {cracky=3},
	drop = 'craft "display_blocks:uranium_dust" 3',
})

minetest.register_craftitem( "display_blocks:uranium_dust", {
	description = "Uranium Dust",
	inventory_image = "uranium_dust.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_node( "display_blocks:uranium_block", {
	description = "Uranium Block",
	tiles = { "uranium_block.png" },
	light_propagates = true,
	paramtype = "light",
	sunlight_propagates = true,
	light_source = 15,
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
})


minetest.register_craft( {
	output = 'node "display_blocks:uranium_block" 1',
	recipe = {
		{ 'display_blocks:uranium_dust', 'display_blocks:uranium_dust', 'display_blocks:uranium_dust' },
		{ 'display_blocks:uranium_dust', 'display_blocks:uranium_dust', 'display_blocks:uranium_dust' },
		{ 'display_blocks:uranium_dust', 'display_blocks:uranium_dust', 'display_blocks:uranium_dust' },
	}
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "display_blocks:uranium_ore",
	wherein = "default:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores =18,
	clust_size = 3,
	y_min = -3000,
	y_max = -2000,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "display_blocks:uranium_ore",
	wherein = "default:stone",
	clust_scarcity =20*20*20,
	clust_num_ores =40,
	clust_size = 4,
	y_min = -7000,
	y_max = -5000,
})
