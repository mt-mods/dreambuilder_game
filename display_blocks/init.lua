local PATH = minetest.get_modpath("display_blocks")

dofile(PATH.."/config.lua")
dofile(PATH.."/technic.lua")

if enable_display_uranium == true then
	dofile(minetest.get_modpath("display_blocks").."/uranium.lua")
end

local Scale = 0.9

function disp(base, name, light, rec, rp)
	minetest.register_node( "display_blocks:"..base.."_base", {
		description = name.."Display Base",
		tiles = { "display_blocks_"..base.."_block.png" },
		is_ground_content = true,
		groups = {cracky=3,},
		light_source = light,
		sunlight_propagates = true,
		paramtype = "light",
		drawtype = "glasslike",
	})

	minetest.register_node( "display_blocks:"..base.."_crystal", {
		drawtype = "plantlike",
		description = name.." Display Crystal",
		tiles = { "display_blocks_"..base.."_crystal.png" },
		is_ground_content = true,
		paramtype = "light",
		visual_scale = Scale,
		groups = {immortal=1, not_in_creative_inventory=1},
		selection_box = {
			type = "fixed",
			fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
		},
		walkable = false,
	})

	minetest.register_abm({
		nodenames = {"display_blocks:"..base.."_base"},
		interval = 2.0,
		chance = 1.0,
		action = function(pos, node, active_object_count, active_object_count_wider)
			pos.y = pos.y + 1
			local n = minetest.get_node(pos)
			if n and n.name == "air" then
				minetest.add_node(pos, {name="display_blocks:"..base.."_crystal"})
			end
		end
	})

	function remove_crystal(pos, node, active_object_count, active_object_count_wider)
		if node.name == "display_blocks:"..base.."_base" then
			pos.y = pos.y + 1
			local n = minetest.get_node(pos)
			if n and n.name == "display_blocks:"..base.."_crystal" then
				minetest.remove_node(pos)
			end
		end
	end
	minetest.register_on_dignode(remove_crystal)

	minetest.register_craft({
		output = 'display_blocks:'..base..'_base 5',
		recipe = {
			{'', 'default:mese_crystal_fragment', ''},
			{rec, 'display_blocks:empty_display', rec},
			{'', rec, ''},
		},
		replacements = {{rec, rp}, {rec, rp},{rec, rp}},
	})
end

-- disp(base, name, rec, rp)
disp("mese", "Mese", 0, "default:mese_block", "")
disp("glass", "Glass", 0, "default:sand", "")
disp("fire", "Fire", 12, "bucket:bucket_lava" ,"bucket:bucket_empty")
disp("air", "Air", 5, "bucket:bucket_empty", "bucket:bucket_empty")
disp("water", "Water", 0, "bucket:bucket_water", "bucket:bucket_empty")
disp("uranium", "Uranium", 10, "display_blocks:uranium_block", "")
disp("earth", "Earth", 0, "display_blocks:compressed_earth", "")
disp("metal", "Metal", 2, "default:steelblock", "")


if minetest.get_modpath("titanium") then
	disp("titanium", "Titanium", 0, "titanium:block", "")
end

--
-- Universia Display
--

minetest.register_node( "display_blocks:universia_base", {
	description = "Universia Display Base",
	tiles = {"display_blocks_universia_block.png"},
	is_ground_content = true,
	groups = {cracky=3,},
	light_source = 15,
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "glasslike",
})

minetest.register_node( "display_blocks:universia_crystal", {
	description = "Universia Display Crystal",
	drawtype = "plantlike",
	tiles = {"display_blocks_universia_crystal.png"},
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.2, 0.15 },
	},
	walkable = false,
	is_ground_content = true,
	paramtype = "light",
	visual_scale = Scale,
	groups = {immortal=1, not_in_creative_inventory=1},
})

minetest.register_abm({
	nodenames = {"display_blocks:universia_base"},
	interval = 1.0,
	chance = 1.0,
	action = function(pos, node, active_object_count, active_object_count_wider)
		pos.y = pos.y + 1
		minetest.add_node(pos, {name="display_blocks:universia_crystal"})
	end
})

function remove_crystal(pos, node, active_object_count, active_object_count_wider)
	if
	  node.name == "display_blocks:universia_base"
	then
	  pos.y = pos.y + 1
	  minetest.remove_node(pos, {name="display_blocks:universia_crystal"})
  end
end
minetest.register_on_dignode(remove_crystal)

minetest.register_craft({
	output = "display_blocks:universia_base",
	recipe = {
		{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
		{'display_blocks:natura_cube', 'default:mese_block', 'display_blocks:industria_cube'},
		{'default:obsidian', 'default:obsidian', 'default:obsidian'},
	},
})

--
-- Other Blocks
--

minetest.register_node("display_blocks:compressed_earth", {
	description = "Compressed Earth",
	tiles = {"display_blocks_compressed_earth.png"},
	groups = {crumbly=3,soil=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("display_blocks:empty_display", {
	description = "Empty Display",
	tiles = {"display_blocks_empty_display.png"},
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "glasslike",
	is_ground_content = true,
})

minetest.register_node("display_blocks:industria_cube", {
	description = "Industria Cube",
	tiles = {"display_blocks_industria_cube.png"},
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "glasslike",
	is_ground_content = true,
})

minetest.register_node("display_blocks:natura_cube", {
	description = "Natura Cube",
	tiles = {"display_blocks_natura_cube.png"},
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	sunlight_propagates = true,
	paramtype = "light",
	drawtype = "glasslike",
	is_ground_content = true,
})

minetest.register_craft({
	output= "display_blocks:compressed_earth",
	recipe = {
		{'default:gravel', 'default:dirt', 'default:gravel'},
		{'default:dirt', 'default:gravel', 'default:dirt'},
		{'default:gravel', 'default:dirt', 'default:gravel'},
	}
})

minetest.register_craft({
	output = "display_blocks:empty_display",
	recipe = {
		{'default:desert_sand', 'default:glass', 'default:sand'},
		{'default:glass', '', 'default:glass'},
		{'default:sand', 'default:glass', 'default:desert_sand'},
	},
})

minetest.register_craft({
	output = "display_blocks:natura_cube",
	recipe = {
		{'', 'display_blocks:air_base', ''},
		{'display_blocks:fire_base', '', 'display_blocks:water_base'},
		{'', 'display_blocks:earth_base', ''},
	},
})

minetest.register_craft({
	output = "display_blocks:industria_cube",
	recipe = {
		{'', 'display_blocks:mese_base', ''},
		{'display_blocks:metal_base', '', 'display_blocks:glass_base'},
		{'', 'display_blocks:uranium_base', ''},
	},
})

--
-- Compressed Earth Ore Gen
--

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "display_blocks:compressed_earth",
	wherein        = "default:dirt",
	clust_scarcity = 25*25*25,
	clust_num_ores = 20,
	clust_size     = 5,
	y_max     = -5,
	y_min     = -15,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "display_blocks:compressed_earth",
	wherein        = "default:dirt",
	clust_scarcity = 20*20*20,
	clust_num_ores = 50,
	clust_size     = 5,
	y_max     = -16,
	y_min     = -29,
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "display_blocks:compressed_earth",
	wherein        = "default:dirt",
	clust_scarcity = 15*15*15,
	clust_num_ores = 80,
	clust_size     = 5,
	y_max     = -30,
	y_min     = -100,
})

print("[Display Blocks] Loaded! by jojoa1997 :-)")
