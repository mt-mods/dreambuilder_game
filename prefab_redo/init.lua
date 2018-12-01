--Prefab Redo Mod
--Written by cheapie
--See LICENSE file for license information

minetest.register_alias("prefab:concrete","technic:concrete")
minetest.register_alias("prefab:concrete_wall","prefab_redo:concrete_wall")
minetest.register_alias("prefab:concrete_with_grass","prefab_redo:concrete_with_grass")
minetest.register_alias("prefab:concrete_ladder","prefab_redo:concrete_ladder")
minetest.register_alias("prefab:concrete_door_a","doors:door_concrete_a")
minetest.register_alias("prefab:concrete_door_b","doors:door_concrete_b")
minetest.register_alias("prefab:concrete_fence","prefab_redo:concrete_wall")
minetest.register_alias("prefab:concrete_bollard","prefab_redo:concrete_wall")
minetest.register_alias("prefab:concrete_railing","prefab_redo:concrete_railing")
minetest.register_alias("prefab:concrete_railing_corner","prefab_redo:concrete_railing")
minetest.register_alias("prefab:concrete_catwalk","prefab_redo:concrete_catwalk")
minetest.register_alias("prefab:concrete_bench","prefab_redo:concrete_bench")

minetest.register_node("prefab_redo:concrete_with_grass", {
	description = "Concrete with Grass",
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
	tiles = {
		"default_grass.png",
		"basic_materials_concrete_block.png",
		"basic_materials_concrete_block.png^default_grass_side.png"
	},
	groups = {cracky = 1},
})

minetest.register_node("prefab_redo:concrete_wall", {
	description = "Concrete Wall",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	drawtype = "nodebox",
	tiles = {"basic_materials_concrete_block.png"},
	sunlight_propagates = true,
	groups = {cracky = 1},
	node_box = {
		type = "connected",
		fixed          = {{-0.3, -0.5, -0.3, 0.3, -0.4, 0.3}, {-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}},
		connect_front  = {{-0.3, -0.5, -0.5, 0.3, -0.4, 0.3}, {-0.1, -0.5, -0.5, 0.1, 0.5, 0.1}},
		connect_back   = {{-0.3, -0.5, -0.3, 0.3, -0.4, 0.5}, {-0.1, -0.5, -0.1, 0.1, 0.5, 0.5}},
		connect_left   = {{-0.5, -0.5, -0.3, 0.3, -0.4, 0.3}, {-0.5, -0.5, -0.1, 0.1, 0.5, 0.1}},
		connect_right  = {{-0.3, -0.5, -0.3, 0.5, -0.4, 0.3}, {-0.1, -0.5, -0.1, 0.5, 0.5, 0.1}},
	},
	connects_to = {"prefab_redo:concrete_wall","prefab_redo:concrete_wall_upper"},
	on_construct = function(pos)
		local node = minetest.get_node(pos)
		local pos_above = {x = pos.x,y = pos.y + 1,z = pos.z}
		local node_above = minetest.get_node(pos_above)
		local pos_below = {x = pos.x,y = pos.y - 1,z = pos.z}
		local node_below = minetest.get_node(pos_below)
		if node_above.name == "prefab_redo:concrete_wall" then
			node_above.name = "prefab_redo:concrete_wall_upper"
			minetest.swap_node(pos_above,node_above)
		end
		if node_below.name == "prefab_redo:concrete_wall" or node_below.name == "prefab_redo:concrete_wall_upper" then
			node.name = "prefab_redo:concrete_wall_upper"
			minetest.swap_node(pos,node)
		end
	end,
	on_destruct = function(pos)
		local node = minetest.get_node(pos)
		local pos_above = {x = pos.x,y = pos.y + 1,z = pos.z}
		local node_above = minetest.get_node(pos_above)
		if node_above.name == "prefab_redo:concrete_wall_upper" then
			node_above.name = "prefab_redo:concrete_wall"
			minetest.swap_node(pos_above,node_above)
		end
	end,
})

minetest.register_node("prefab_redo:concrete_wall_upper", {
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	drawtype = "nodebox",
	tiles = {"basic_materials_concrete_block.png"},
	sunlight_propagates = true,
	groups = {cracky = 1,not_in_creative_inventory = 1},
	drop = "prefab_redo:concrete_wall",
	node_box = {
		type = "connected",
		fixed          = {{-0.1, -0.5, -0.1, 0.1, 0.5, 0.1}},
		connect_front  = {{-0.1, -0.5, -0.5, 0.1, 0.5, 0.1}},
		connect_back   = {{-0.1, -0.5, -0.1, 0.1, 0.5, 0.5}},
		connect_left   = {{-0.5, -0.5, -0.1, 0.1, 0.5, 0.1}},
		connect_right  = {{-0.1, -0.5, -0.1, 0.5, 0.5, 0.1}},
	},
	connects_to = {"prefab_redo:concrete_wall","prefab_redo:concrete_wall_upper"},
	on_destruct = function(pos)
		local node = minetest.get_node(pos)
		local pos_above = {x = pos.x,y = pos.y + 1,z = pos.z}
		local node_above = minetest.get_node(pos_above)
		if node_above.name == "prefab_redo:concrete_wall_upper" then
			node_above.name = "prefab_redo:concrete_wall"
			minetest.swap_node(pos_above,node_above)
		end
	end,
})

minetest.register_node("prefab_redo:concrete_ladder", {
	description = "Concrete Ladder",
	drawtype = "signlike",
	tiles = {"basic_materials_concrete_block.png^[mask:prefab_redo_ladder_mask.png^prefab_redo_ladder_overlay.png"},
	inventory_image = "basic_materials_concrete_block.png^[mask:prefab_redo_ladder_mask.png^prefab_redo_ladder_overlay.png",
	wield_image = "basic_materials_concrete_block.png^[mask:prefab_redo_ladder_mask.png^prefab_redo_ladder_overlay.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
	},
	groups = {cracky = 2},
	sounds = default.node_sound_stone_defaults(),
})

doors.register("door_concrete", {
		tiles = { "basic_materials_concrete_block.png^prefab_redo_door_resize.png^[mask:prefab_redo_door_mask.png^prefab_redo_door_overlay.png" },
		description = "Concrete Door",
		inventory_image = "basic_materials_concrete_block.png^prefab_redo_door_overlay_half.png^[mask:prefab_redo_door_mask_half.png",
		groups = { snappy=1, cracky=1, oddly_breakable_by_hand=3 },
		sounds = default.node_sound_stone_defaults(),
		recipe = {
			{"technic:concrete", "technic:concrete"},
			{"technic:concrete", "default:steel_ingot"},
			{"technic:concrete", "technic:concrete"},
		},
})

minetest.register_node("prefab_redo:concrete_railing", {
	description = "Concrete Railing",
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	drawtype = "nodebox",
	tiles = {"basic_materials_concrete_block.png"},
	sunlight_propagates = true,
	groups = {cracky = 1},
	node_box = {
		type = "connected",
		fixed          = {{0.0625,-0.5,0.0625,-0.0625,0.1875,-0.0625}},
		connect_front  = {{-0.0625,0.1875,-0.5,0.0625,0.3125,0.0625}},
		connect_back   = {{-0.0625,0.1875,-0.0625,0.0625,0.3125,0.5}},
		connect_left   = {{-0.5,0.1875,-0.0625,0.0625,0.3125,0.0625}},
		connect_right  = {{-0.0625,0.1875,-0.0625,0.5,0.3125,0.0625}}
	},
	selection_box = {
		type = "fixed",
		fixed = {{-0.5,-0.5,-0.5,0.5,0.3125,0.5}}
	},
	connects_to = {"prefab_redo:concrete_railing","prefab_redo:concrete_catwalk"}
})

minetest.register_node("prefab_redo:concrete_catwalk",{
	description= "Concrete Catwalk",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"basic_materials_concrete_block.png"},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,-0.375,0.5}, 
			{-0.5,-0.5,-0.0625,-0.4375,0.5,0.0625}, 
			{0.4433,-0.5,-0.0625,0.5,0.5,0.0625}, 
			{0.4433,0.4485,-0.5,0.5,0.5,0.5},
			{-0.5,0.4485,-0.5,-0.4375,0.5,0.5},
		},
	},
	groups = {cracky = 2},
})

minetest.register_node("prefab_redo:concrete_bench", {
	description = "Concrete Bench",
	tiles = {"basic_materials_concrete_block.png"},
	paramtype = "light",
	paramtype2 = "facedir",
        drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.125,-0.5,-0.125,0.125,0.0625,0.125}, 
			{-0.5,0.0625,-0.3125,0.5,0.1875,0.3125}, 
		},
	},
	groups = {cracky = 2},
})

minetest.register_craft({
	output = "prefab_redo:concrete_railing 6",
	recipe = {
			{"","",""},
			{"technic:concrete","technic:concrete","technic:concrete"},
			{"","technic:concrete",""}
		}
})

minetest.register_craft({
	output = "prefab_redo:concrete_catwalk 3",
	recipe = {
			{"","",""},
			{"prefab_redo:concrete_railing","","prefab_redo:concrete_railing"},
			{"technic:concrete","technic:concrete","technic:concrete"}
		}
})

minetest.register_craft({
	output = "prefab_redo:concrete_bench 2",
	recipe = {
			{"","",""},
			{"","technic:concrete",""},
			{"","prefab_redo:concrete_railing",""}
		}
})

minetest.register_craft({
	output = "prefab_redo:concrete_with_grass",
	type = "shapeless",
	recipe = {"technic:concrete","default:junglegrass"}
})

minetest.register_craft({
	output = "prefab_redo:concrete_with_grass",
	type = "shapeless",
	recipe = {"technic:concrete","default:grass_1"}
})

minetest.register_craft({
	output = "prefab_redo:concrete_wall 3",
	recipe = {
			{"","technic:concrete",""},
			{"","technic:concrete",""},
			{"","technic:concrete",""}
		}
})

minetest.register_craft({
	output = "prefab_redo:concrete_ladder 14",
	recipe = {
			{"technic:concrete","","technic:concrete"},
			{"technic:concrete","technic:concrete","technic:concrete"},
			{"technic:concrete","","technic:concrete"}
		}
})
