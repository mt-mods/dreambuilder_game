local disptypes = {
	{
		name = "Mese",
		light_source = 0,
		craft_type = "normal",
		craft_item = "default:mese",
	},
	{
		name = "Glass",
		light_source = 0,
		craft_type = "normal",
		craft_item = "default:glass",
	},
	{
		name = "Fire",
		light_source = 12,
		craft_type = "normal",
		craft_item = "bucket:bucket_lava",
	},
	{
		name = "Air",
		light_source = 5,
		craft_type = "normal",
		craft_item = "bucket:bucket_empty",
	},
	{
		name = "Water",
		light_source = 0,
		craft_type = "normal",
		craft_item = "bucket:bucket_water",
	},
	{
		name = "Uranium",
		light_source = 10,
		craft_type = "normal",
		craft_item = "group:uranium_block",
	},
	{
		name = "Earth",
		light_source = 0,
		craft_type = "normal",
		craft_item = "default:dirt",
	},
	{
		name = "Metal",
		light_source = 2,
		craft_type = "normal",
		craft_item = "default:steelblock",
	},
	{
		name = "Empty",
		light_source = 0,
		suppress_crystal = true,
		craft_type = "special",
		craft_recipe = {
			{"default:desert_sand","default:glass","default:sand",},
			{"default:glass","","default:glass",},
			{"default:sand","default:glass","default:desert_sand",},
		},
	},
	{
		name = "Universia",
		light_source = 14,
		craft_type = "special",
		craft_recipe = {
			{"default:mese_crystal","default:mese_crystal","default:mese_crystal",},
			{"display_blocks_redo:natura_cube","default:mese","display_blocks_redo:industria_cube",},
			{"default:obsidian","default:obsidian","default:obsidian",},
		},
	},
}

if minetest.get_modpath("titanium") then
	table.insert(disptypes,{
		name = "Titanium",
		light_source = 0,
		craft_type = "normal",
		craft_item = "titanium:block",
	})
end

local function regcraft(def)
	local lname = string.lower(def.name)
	if def.craft_type == "normal" then
		local craft = {}
		craft.output = string.format("display_blocks_redo:%s_base",lname)
		craft.recipe = {
			{"","default:mese_crystal_fragment","",},
			{def.craft_item,"display_blocks_redo:empty_base",def.craft_item,},
			{"",def.craft_item,"",},
		}
		if string.sub(def.craft_item,1,7) == "bucket:" then
			craft.replacements = {}
			for i=1,3,1 do
				table.insert(craft.replacements,{def.craft_item,"bucket:bucket_empty",})
			end
		end
		minetest.register_craft(craft)
	elseif def.craft_type == "special" then
		local craft = {}
		craft.output = string.format("display_blocks_redo:%s_base",lname)
		craft.recipe = def.craft_recipe
		minetest.register_craft(craft)
	end
end

for _,def in ipairs(disptypes) do
	local lname = string.lower(def.name)
	if not def.suppress_crystal then
		minetest.register_node(string.format("display_blocks_redo:%s_crystal",lname),{
			description = string.format("%s Display Crystal (you hacker you!)",def.name),
			drawtype = "plantlike",
			drop = "",
			groups = {
				not_in_creative_inventory = 1,
			},
			paramtype = "light",
			tiles = {
				string.format("display_blocks_redo_%s_crystal.png",lname),
			},
			light_source = def.light_source,
			visual_scale = 0.9,
			selection_box = {
				type = "fixed",
				fixed = {-0.15,-0.5,-0.15,0.15,0.2,0.15},
			},
			walkable = false,
		})
		minetest.register_alias(string.format("display_blocks:%s_crystal",lname),string.format("display_blocks_redo:%s_crystal",lname))
	end
	minetest.register_node(string.format("display_blocks_redo:%s_base",lname),{
		description = string.format("%s Display Base",def.name),
		groups = {
			cracky = 3,
		},
		sounds = minetest.global_exists("default") and default.node_sound_glass_defaults(),
		paramtype = "light",
		light_source = def.light_source,
		tiles = {
			string.format("display_blocks_redo_%s_base.png",lname),
		},
		drawtype = "glasslike",
		after_place_node = function(pos,_,stack)
			if def.suppress_crystal then return end
			local crystalpos = vector.add(pos,vector.new(0,1,0))
			if minetest.get_node(crystalpos).name == "air" then
				local node = {}
				node.name = string.format("display_blocks_redo:%s_crystal",lname)
				minetest.set_node(crystalpos,node)
				stack:take_item(1)
				return stack
			else
				minetest.set_node(pos,{name = "air"})
				return stack
			end
		end,
		after_destruct = function(pos)
			if def.suppress_crystal then return end
			local crystalpos = vector.add(pos,vector.new(0,1,0))
			if minetest.get_node(crystalpos).name == string.format("display_blocks_redo:%s_crystal",lname) then
				minetest.set_node(crystalpos,{name = "air"})
			end
		end,
	})
	regcraft(def)
	minetest.register_alias(string.format("display_blocks:%s_base",lname),string.format("display_blocks_redo:%s_base",lname))
end

minetest.register_alias("display_blocks:empty_display","display_blocks_redo:empty_base")
minetest.register_alias("display_blocks:compressed_earth","default:dirt")

minetest.register_node("display_blocks_redo:natura_cube",{
	description = "Natura Cube",
	tiles = {
		"display_blocks_redo_natura_cube.png",
	},
	groups = {
		cracky = 3,
		oddly_breakable_by_hand = 3,
	},
	paramtype = "light",
	drawtype = "glasslike",
	sounds = minetest.global_exists("default") and default.node_sound_glass_defaults(),
})

minetest.register_alias("display_blocks:natura_cube","display_blocks_redo:natura_cube")

minetest.register_node("display_blocks_redo:industria_cube",{
	description = "Industria Cube",
	tiles = {
		"display_blocks_redo_industria_cube.png",
	},
	groups = {
		cracky = 3,
		oddly_breakable_by_hand = 3,
	},
	paramtype = "light",
	drawtype = "glasslike",
	sounds = minetest.global_exists("default") and default.node_sound_glass_defaults(),
})

minetest.register_alias("display_blocks:industria_cube","display_blocks_redo:industria_cube")

minetest.register_craft({
	output = "display_blocks_redo:natura_cube",
	recipe = {
		{"","display_blocks:air_base","",},
		{"display_blocks:fire_base","","display_blocks:water_base",},
		{"","display_blocks:earth_base","",},
	},
})

minetest.register_craft({
	output = "display_blocks_redo:industria_cube",
	recipe = {
		{"","display_blocks:mese_base","",},
		{"display_blocks:metal_base","","display_blocks:glass_base",},
		{"","display_blocks:uranium_base","",},
	},
})

if minetest.get_modpath("technic_worldgen") then
	minetest.register_alias("display_blocks:uranium_ore","technic:mineral_uranium")
	minetest.register_alias("display_blocks:uranium_dust","technic:uranium_dust")
	minetest.register_alias("display_blocks:uranium_block","technic:uranium_block")
	minetest.register_alias("display_blocks_redo:uranium_ore","technic:mineral_uranium")
	minetest.register_alias("display_blocks_redo:uranium_dust","technic:uranium_dust")
	minetest.register_alias("display_blocks_redo:uranium_block","technic:uranium_block")
else
	minetest.register_node("display_blocks_redo:uranium_ore",{
		description = "Uranium Ore",
		drop = "display_blocks_redo:uranium_dust 3",
		paramtype = "light",
		light_source = 2,
		groups = {
			cracky = 3,
		},
		tiles = {
			"default_stone.png^display_blocks_redo_uranium_ore.png",
		},
		is_ground_content = true,
	})
	
	minetest.register_node("display_blocks_redo:uranium_block",{
		description = "Uranium Block",
		paramtype = "light",
		light_source = 7,
		groups = {
			snappy = 1,
		},
		tiles = {
			"display_blocks_redo_uranium_block.png",
		},
	})
	
	minetest.register_craftitem("display_blocks_redo:uranium_dust",{
		description = "Uranium Dust",
		inventory_image = "display_blocks_redo_uranium_dust.png",
	})
	
	minetest.register_craft({
		type = "shapeless",
		output = "display_blocks_redo:uranium_block",
		recipe = {
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
			"display_blocks_redo:uranium_dust",
		},
	})
	
	minetest.register_ore({
		ore_type = "scatter",
		ore = "display_blocks_redo:uranium_ore",
		wherein = "default:stone",
		clust_scarcity = 10*10*10,
		clust_num_ores = 18,
		clust_size = 3,
		y_min = -3000,
		y_max = -2000,
	})
	
	minetest.register_ore({
		ore_type = "scatter",
		ore = "display_blocks_redo:uranium_ore",
		wherein = "default:stone",
		clust_scarcity = 20*20*20,
		clust_num_ores = 40,
		clust_size = 4,
		y_min = -31000,
		y_max = -5000,
	})
	
	minetest.register_alias("display_blocks:uranium_ore","display_blocks_redo:uranium_ore")
	minetest.register_alias("display_blocks:uranium_dust","display_blocks_redo:uranium_dust")
	minetest.register_alias("display_blocks:uranium_block","display_blocks_redo:uranium_block")
end
