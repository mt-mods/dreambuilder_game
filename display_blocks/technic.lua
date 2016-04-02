if enable_display_uranium == false then
	minetest.register_alias("display_blocks:uranium_dust", "technic:uranium_block")
	minetest.register_alias("display_blocks:uranium_block", "technic:uranium_block")
	minetest.register_alias("display_blocks:uranium_ore", "technic:mineral_uranium")
end

if technic_uranium_new_ore_gen == true then
	minetest.register_ore({
		ore_type = "scatter",
		ore = "technic:mineral_uranium",
		wherein = "default:stone",
		clust_scarcity = 20*20*20,
		clust_num_ores = 18,
		clust_size = 3,
		y_min = -3000,
		y_max = -2000,
	})

	minetest.register_ore({
		ore_type = "scatter",
		ore = "technic:mineral_uranium",
		wherein = "default:stone",
		clust_scarcity =30*30*30,
		clust_num_ores = 40,
		clust_size = 4,
		y_min = -7000,
		y_max = -5000,
	})
end

if enable_technic_recipe == true then
	minetest.register_craft({
		output = 'display_blocks:uranium_base 5',
		recipe = {
			{'', 'default:mese_crystal_fragment', ''},
			{'technic:uranium_block', 'display_blocks:empty_display', 'technic:uranium_block'},
			{'', 'technic:uranium_block', ''},
		}
	})
end
