minetest.register_node("digistuff:digimese", {
	description = "Digimese",
	tiles = {"digistuff_digimese.png"},
	paramtype = "light",
	light_source = 3,
	groups = {cracky = 3, level = 2},
	is_ground_content = false,
	sounds = default and default.node_sound_stone_defaults(),
	digiline = { wire = { rules = {
	{x = 1, y = 0, z = 0},
	{x =-1, y = 0, z = 0},
	{x = 0, y = 1, z = 0},
	{x = 0, y =-1, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z =-1}}}}
})

minetest.register_node("digistuff:junctionbox", {
	description = "Digilines Junction Box",
	tiles = {"digistuff_junctionbox.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3},
	is_ground_content = false,
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
					{-0.1,-0.15,0.35,0.1,0.15,0.5},
				}
		},
	sounds = default and default.node_sound_stone_defaults(),
	digiline = {
		receptor = {},
		wire = {
			rules = {
				{x = 1,y = 0,z = 0},
				{x = -1,y = 0,z = 0},
				{x = 0,y = 0,z = 1},
				{x = 0,y = 0,z = -1},
				{x = 0,y = 1,z = 0},
				{x = 0,y = -1,z = 0},
				{x = 0,y = -2,z = 0},
				{x = 0,y = 2,z = 0},
				{x = -2,y = 0,z = 0},
				{x = 2,y = 0,z = 0},
				{x = 0,y = 0,z = -2},
				{x = 0,y = 0,z = 2},
			}
		},
	},
})

minetest.register_craft({
	output = "digistuff:junctionbox",
	recipe = {
		{"homedecor:plastic_sheeting","digilines:wire_std_00000000","homedecor:plastic_sheeting",},
		{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000",},
		{"homedecor:plastic_sheeting","digilines:wire_std_00000000","homedecor:plastic_sheeting",},
	}
})
