--[[
	StreetsMod: Concrete, Concrete wall (flat), Concrete wall (full)
]]
	minetest.register_alias("streets:concrete","basic_materials:concrete_block")
	-- Use technic's concrete block for the seperating wall
	minetest.register_node(":streets:concrete_wall",{
		description = streets.S("Concrete wall"),
		tiles = {"basic_materials_concrete_block.png"},
		groups = {cracky=2},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.4, -0.5, -0.5, 0.4, -0.4, 0.5},
				{-0.1, -0.4, -0.5, 0.1, 0.5, 0.5}
			}
		}
	})
	minetest.register_craft({
		output = "streets:concrete_wall 3",
		recipe = {
			{"","basic_materials:concrete_block",""},
			{"","basic_materials:concrete_block",""},
			{"basic_materials:concrete_block","basic_materials:concrete_block","basic_materials:concrete_block"}
		}
	})
	minetest.register_node(":streets:concrete_wall_flat",{
		description = streets.S("Concrete wall"),
		tiles = {"basic_materials_concrete_block.png"},
		groups = {cracky=2},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.1, -0.5, -0.5, 0.1, 0.5, 0.5}
			}
		}
	})
	minetest.register_craft({
		output = "streets:concrete_wall_flat 3",
		recipe = {
			{"","basic_materials:concrete_block",""},
			{"","basic_materials:concrete_block",""},
			{"","",""}
		}
	})
