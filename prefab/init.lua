--This is a mod by DanDuncombe that adds pre-fabricated concrete stuff to Minetest
--It is CC-By-Sa for everything.
print("Prefab mod loading....")
dofile(minetest.get_modpath("prefab").."/crafting.lua")
print("Prefab Crafting loaded!")
dofile(minetest.get_modpath("prefab").."/other.lua")
print("Prefab Other loaded!")
print("Prefab Loaded!")

minetest.register_node("prefab:concrete", {
        drawtype = "normal",
	description = "Block of Prefab Concrete",
	paramtype = "light",
	tiles = {"prefab_concrete.png"},
	is_ground_content = false,
	drop = "prefab:concrete",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_with_grass", {
	description = "Prefab Concrete with Grass",
	paramtype = "light",
	tiles = {"default_grass.png",
	                "prefab_concrete.png",
			"prefab_concrete_grass.png",},
	is_ground_content = false,
	drop = "prefab:concrete",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_wall", {
        drawtype = "nodebox",
	description = "Prefab Concrete Wall Section",
	tiles = {"prefab_concrete.png",
	                "prefab_concrete.png",
			"prefab_concrete_wall.png",
			"prefab_concrete_wall.png",
			"prefab_concrete_wall.png",
			"prefab_concrete_wall.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.437500,0.500000,0.500000,0.437500}, 
			{-0.437500,-0.500000,-0.500000,0.437500,0.500000,0.500000},
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_wall",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_stair", {
        drawtype = "nodebox",
	description = "Prefab Concrete Stair",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.000000,0.500000}, 
			{-0.500000,-0.500000,0.000000,0.500000,0.500000,0.500000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_stair",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_slab", {
        drawtype = "nodebox",
	description = "Prefab Concrete Slab",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,0.000000,0.500000},  
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_slab",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_stair_inverted", {
        drawtype = "nodebox",
	description = "Prefab Concrete Stair (inverted)",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.000000,-0.500000,0.500000,0.500000,0.500000},
			{-0.500000,-0.500000,-0.062500,0.500000,0.500000,0.500000},
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_stair",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_slab_inverted", {
        drawtype = "nodebox",
	description = "Prefab Concrete Slab (inverted)",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.000000,-0.500000,0.500000,0.500000,0.500000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_slab",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_slit", {
        drawtype = "nodebox",
	description = "Prefab Horizontal Concrete Slit",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.000000,0.500000}, 
			{-0.500000,0.187500,-0.500000,0.500000,0.500000,0.500000},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,0.500000,0.500000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_slit",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_window", {
        drawtype = "nodebox",
	description = "Prefab Concrete Framed Window",
	tiles = {"prefab_concrete.png",
	                "prefab_concrete.png",
			"prefab_concrete.png",
			"prefab_concrete.png",
			"prefab_concrete_window.png",
			"prefab_concrete_window.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.250000,0.500000},
			{-0.500000,0.250000,-0.500000,0.500000,0.500000,0.500000}, 
			{0.250000,-0.500000,-0.500000,0.500000,0.500000,0.500000}, 
			{-0.500000,-0.500000,-0.500000,-0.250000,0.500000,0.500000}, 
			{-0.500000,-0.500000,-0.000000,0.500000,0.500000,0.000000},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,0.500000,0.500000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_window",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_ladder", {
	drawtype = "signlike",
	description = "Prefab Concrete Ladder",
	tiles = {"prefab_concrete_ladder.png"},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	climbable = true,
	is_ground_content = false,
	selection_box = {
		type = "wallmounted",
	},
	drop = "prefab:concrete_ladder",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_fence", {
	description = "Prefab Concrete Fence",
	drawtype = "fencelike",
	paramtype = "light",
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	tiles = {"prefab_concrete.png"},
	is_ground_content = false,
	drop = "prefab:concrete_fence",
	groups = {cracky=2},
})

doors.register_door("prefab:concrete_door", {
	description = "Prefab Concrete Door",
	inventory_image = "prefab_concrete_door.png",
	groups = {cracky=2,door=1},
	tiles_bottom = {"prefab_concrete_door_bottom.png", "prefab_concrete_grey.png"},
	tiles_top = {"prefab_concrete_door_top.png", "prefab_concrete_grey.png"},
	only_placer_can_open = true,
})

minetest.register_node("prefab:concrete_cylinder", {
        drawtype = "nodebox",
	description = "Prefab Concrete Cylinder",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{0.375000,-0.500000,-0.500000,0.500000,0.500000,0.500000}, 
			{-0.5,-0.500000,0.375000,0.500000,0.500000,0.500000}, 
			{-0.500000,-0.500000,-0.500000,-0.375000,0.500000,0.500000},
			{-0.500000,-0.500000,-0.500000,0.500000,0.500000,-0.375000},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,0.500000,0.500000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_cylinder",
	groups = {cracky=2,falling_node=1},
})

minetest.register_node("prefab:concrete_bollard", {
        drawtype = "nodebox",
	description = "Prefab Concrete Bollard",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.312500,-0.500000,-0.312500,0.312500,-0.312500,0.312500}, 
			{-0.250000,-0.500000,-0.250000,0.250000,-0.250000,0.250000}, 
			{-0.187500,-0.500000,-0.187500,0.187500,0.062500,0.187500},
			{-0.250000,0.062500,-0.250000,0.250000,0.125000,0.250000}, 
			{-0.312500,0.125000,-0.312500,0.312500,0.250000,0.312500},
			{-0.250000,0.250000,-0.250000,0.250000,0.312500,0.250000},
			{-0.187500,0.312500,-0.187500,0.187500,0.375000,0.187500},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.350000,-0.500000,-0.350000,0.350000,0.400000,0.350000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_bollard",
	groups = {cracky=2,falling_node=1},
})

minetest.register_node("prefab:concrete_bench", {
        drawtype = "nodebox",
	description = "Prefab Concrete Bench",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125000,-0.500000,-0.062500,0.125000,0.062500,0.062500}, 
			{-0.500000,0.062500,-0.312500,0.500000,0.187500,0.312500}, 
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.350000,0.500000,0.300000,0.350000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_bench",
	groups = {cracky=2,falling_node=1},
})

minetest.register_node("prefab:concrete_railing", {
        drawtype = "nodebox",
	description = "Prefab Concrete Railing",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{0.062500,-0.500000,0.062500,-0.062500,0.187500,-0.062500}, 
			{-0.500000,0.187500,-0.062500,0.500000,0.312500,0.062500}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_railing",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_railing_corner", {
        drawtype = "nodebox",
	description = "Prefab Concrete Railing Corner",
	tiles = {"prefab_concrete.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{0.062500,-0.500000,0.062500,-0.062500,0.187500,-0.062500},
			{-0.500000,0.187500,-0.062500,0.062500,0.312500,0.062500}, 
			{-0.062500,0.187500,-0.500000,0.062500,0.312500,0.062500}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:concrete_railing",
	groups = {cracky=2},
})

minetest.register_node("prefab:electric_fence", {
        drawtype = "nodebox",
	description = "Electric Fence",
	tiles = {"prefab_electric_fence.png"},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.062500,-0.062500,0.500000,0.187500,0.062500}, 
			{-0.500000,-0.250000,-0.062500,0.500000,-0.125000,0.062500},
		},
	},
	is_ground_content = false,
	drop = "prefab:electric_fence",
	groups = {cracky=2},
})

minetest.register_node("prefab:electric_fence_corner", {
        drawtype = "nodebox",
	description = "Electric Fence Corner",
	tiles = {"prefab_electric_fence_corner_top.png",
	                "prefab_electric_fence_corner_top.png",
			"prefab_electric_fence_corner_side1.png",
			"prefab_electric_fence_corner_side2.png",
			"prefab_electric_fence_corner_side1.png",
			"prefab_electric_fence_corner_side2.png"},
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.062500,-0.062500,0.062500,0.187500,0.062500}, 
			{-0.500000,-0.250000,-0.062500,0.062500,-0.125000,0.062500},
			{-0.062500,0.062500,-0.062500,0.062500,0.187500,0.500000},
			{-0.062500,-0.250000,-0.062500,0.062500,-0.125000,0.500000},
			{-0.125000,-0.500000,-0.125000,0.125000,0.500000,0.125000},
		},
	},
	is_ground_content = false,
	drop = "prefab:electric_fence_corner",
	groups = {cracky=2},
})

minetest.register_node("prefab:electric_fence_end", {
        drawtype = "nodebox",
	description = "Electric Fence End",
	tiles = {"prefab_electric_fence_end1.png",
	                "prefab_electric_fence_end1.png",
			"prefab_concrete.png",
			"prefab_concrete.png",
			"prefab_electric_fence_end2.png",
			"prefab_electric_fence_end1.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.062500,-0.062500,0.500000,0.187500,0.062500},
			{-0.500000,-0.250000,-0.062500,0.500000,-0.125000,0.062500},
			{-0.500000,-0.500000,-0.250000,-0.375000,0.500000,0.250000}, 
			{-0.375000,-0.437500,-0.250000,-0.250000,0.375000,0.250000},
			{0.250000,-0.312500,-0.125000,0.375000,0.250000,0.125000},
			{0.000000,-0.312500,-0.125000,0.125000,0.250000,0.125000}, 
		},
	},
	is_ground_content = false,
	drop = "prefab:electric_fence_end",
	groups = {cracky=2},
})

minetest.register_node("prefab:concrete_catwalk",{
	drawtype="nodebox",
	description= "Prefab Concrete Catwalk",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { 'prefab_concrete.png', },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.375000,0.500000}, 
			{-0.500000,-0.500000,-0.062500,-0.437500,0.500000,0.062500}, 
			{0.443299,-0.500000,-0.062500,0.500000,0.500000,0.062500}, 
			{0.443299,0.448454,-0.500000,0.500000,0.500000,0.500000},
			{-0.500000,0.448454,-0.500000,-0.437500,0.500000,0.500000},
		},
	},
	groups={cracky=2},
	drop = "prefab:concrete_catwalk",
})
