-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

castle_masonry.register_pillar = function(material)
	local composition_def, burn_time, tile, desc = castle_masonry.get_material_properties(material)
	local crossbrace_connectable_groups = {}
	for group, val in pairs(composition_def.groups) do
		crossbrace_connectable_groups[group] = val
	end	
	crossbrace_connectable_groups.crossbrace_connectable = 1

	local mod_name = minetest.get_current_modname()
	
	-- Node Definition
	minetest.register_node(mod_name..":pillar_"..material.name.."_bottom", {
		drawtype = "nodebox",
		description = S("@1 Pillar Base", desc),
		tiles = tile,
		groups = crossbrace_connectable_groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.375,0.5},
				{-0.375,-0.375,-0.375,0.375,-0.125,0.375},
				{-0.25,-0.125,-0.25,0.25,0.5,0.25}, 
			},
		},
	})

	minetest.register_node(mod_name..":pillar_"..material.name.."_bottom_half", {
		drawtype = "nodebox",
		description = S("@1 Half Pillar Base", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, 0, 0.5, -0.375, 0.5},
				{-0.375, -0.375, 0.125, 0.375, -0.125, 0.5},
				{-0.25, -0.125, 0.25, 0.25, 0.5, 0.5},
			},
		},
	})
	
	minetest.register_node(mod_name..":pillar_"..material.name.."_top", {
		drawtype = "nodebox",
		description = S("@1 Pillar Top", desc),
		tiles = tile,
		groups = crossbrace_connectable_groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,0.3125,-0.5,0.5,0.5,0.5}, 
				{-0.375,0.0625,-0.375,0.375,0.3125,0.375}, 
				{-0.25,-0.5,-0.25,0.25,0.0625,0.25},
			},
		},
	})

	minetest.register_node(mod_name..":pillar_"..material.name.."_top_half", {
		drawtype = "nodebox",
		description = S("@1 Half Pillar Top", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, 0.3125, 0, 0.5, 0.5, 0.5},
				{-0.375, 0.0625, 0.125, 0.375, 0.3125, 0.5},
				{-0.25, -0.5, 0.25, 0.25, 0.0625, 0.5},
			},
		},
	})	

	minetest.register_node(mod_name..":pillar_"..material.name.."_middle", {
		drawtype = "nodebox",
		description = S("@1 Pillar Middle", desc),
		tiles = tile,
		groups = crossbrace_connectable_groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25,-0.5,-0.25,0.25,0.5,0.25},
			},
		},
	})

	minetest.register_node(mod_name..":pillar_"..material.name.."_middle_half", {
		drawtype = "nodebox",
		description = S("@1 Half Pillar Middle", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, 0.25, 0.25, 0.5, 0.5},
			},
		},
	})
	
	minetest.register_node(mod_name..":pillar_"..material.name.."_crossbrace",
	{
		drawtype = "nodebox",
		description = S("@1 Crossbrace", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "connected",
			fixed = {-0.25,0.25,-0.25,0.25,0.5,0.25},
			connect_front = {-0.25,0.25,-0.75,0.25,0.5,-0.25}, -- -Z
			connect_left = {-0.25,0.25,-0.25,-0.75,0.5,0.25}, -- -X
			connect_back = {-0.25,0.25,0.25,0.25,0.5,0.75}, -- +Z
			connect_right = {0.25,0.25,-0.25,0.75,0.5,0.25}, -- +X
		},
		connects_to = {
			mod_name..":pillar_"..material.name.."_crossbrace",
			mod_name..":pillar_"..material.name.."_extended_crossbrace",
			"group:crossbrace_connectable"},
		connect_sides = { "front", "left", "back", "right" },
	})
	
	minetest.register_node(mod_name..":pillar_"..material.name.."_extended_crossbrace",
	{
		drawtype = "nodebox",
		description = S("@1 Extended Crossbrace", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {-1.25,0.25,-0.25,1.25,0.5,0.25},
		},
	})
	
	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_bottom 4",
		recipe = {
			{"",material.craft_material,""},
			{"",material.craft_material,""},
			{material.craft_material,material.craft_material,material.craft_material} },
	})

	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_top 4",
		recipe = {
			{material.craft_material,material.craft_material,material.craft_material},
			{"",material.craft_material,""},
			{"",material.craft_material,""} },
	})

	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_middle 2",
		recipe = {
			{material.craft_material},
			{material.craft_material},
			{material.craft_material} },
	})
	
	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_crossbrace 10",
		recipe = {
			{material.craft_material,"",material.craft_material},
			{"",material.craft_material,""},
			{material.craft_material,"",material.craft_material} },
	})
	
	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_middle_half 2",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_middle"},
	})
	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_middle",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_middle_half", mod_name..":pillar_"..material.name.."_middle_half"},
	})

	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_top_half 2",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_top"},
	})
	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_top",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_top_half", mod_name..":pillar_"..material.name.."_top_half"},
	})

	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_bottom_half 2",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_bottom"},
	})
	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_bottom",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_bottom_half", mod_name..":pillar_"..material.name.."_bottom_half"},
	})
	
	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_extended_crossbrace",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_crossbrace"},
	})

	minetest.register_craft({
		output = mod_name..":pillar_"..material.name.."_crossbrace",
		type="shapeless",
		recipe = {mod_name..":pillar_"..material.name.."_extended_crossbrace"},
	})
	
	if burn_time > 0 then
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_top",
			burntime = burn_time*5/4,
		})	
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_top_half",
			burntime = burn_time*5/8,
		})
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_bottom",
			burntime = burn_time*5/4,
		})	
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_bottom_half",
			burntime = burn_time*5/8,
		})	
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_middle",
			burntime = burn_time*6/4,
		})
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_middle_half",
			burntime = burn_time*6/8,
		})
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_crossbrace",
			burntime = burn_time*5/10,
		})
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":pillar_"..material.name.."_extended_crossbrace",
			burntime = burn_time*5/10,
		})
	end
	
end

-- The original castle mod had "pillars_", plural, which didn't match the arrowslit and murderhole standard.
castle_masonry.register_pillar_alias = function(old_mod_name, old_material_name, new_mod_name, new_material_name)
	minetest.register_alias(old_mod_name..":pillars_"..old_material_name.."_bottom",		new_mod_name..":pillar_"..new_material_name.."_bottom")
	minetest.register_alias(old_mod_name..":pillars_"..old_material_name.."_bottom_half",	new_mod_name..":pillar_"..new_material_name.."_bottom_half")
	minetest.register_alias(old_mod_name..":pillars_"..old_material_name.."_crossbrace",	new_mod_name..":pillar_"..new_material_name.."_crossbrace")
	minetest.register_alias(old_mod_name..":pillars_"..old_material_name.."_middle",		new_mod_name..":pillar_"..new_material_name.."_middle")
	minetest.register_alias(old_mod_name..":pillars_"..old_material_name.."_middle_half",	new_mod_name..":pillar_"..new_material_name.."_middle_half")
	minetest.register_alias(old_mod_name..":pillars_"..old_material_name.."_top",			new_mod_name..":pillar_"..new_material_name.."_top")
	minetest.register_alias(old_mod_name..":pillars_"..old_material_name.."_top_half",		new_mod_name..":pillar_"..new_material_name.."_top_half")
	minetest.register_alias(old_mod_name..":pillar_"..old_material_name.."_bottom",			new_mod_name..":pillar_"..new_material_name.."_bottom")
	minetest.register_alias(old_mod_name..":pillar_"..old_material_name.."_bottom_half",	new_mod_name..":pillar_"..new_material_name.."_bottom_half")
	minetest.register_alias(old_mod_name..":pillar_"..old_material_name.."_crossbrace",		new_mod_name..":pillar_"..new_material_name.."_crossbrace")
	minetest.register_alias(old_mod_name..":pillar_"..old_material_name.."_middle",			new_mod_name..":pillar_"..new_material_name.."_middle")
	minetest.register_alias(old_mod_name..":pillar_"..old_material_name.."_middle_half",	new_mod_name..":pillar_"..new_material_name.."_middle_half")
	minetest.register_alias(old_mod_name..":pillar_"..old_material_name.."_top",			new_mod_name..":pillar_"..new_material_name.."_top")
	minetest.register_alias(old_mod_name..":pillar_"..old_material_name.."_top_half",		new_mod_name..":pillar_"..new_material_name.."_top_half")
end

castle_masonry.register_arrowslit_alias_force = function(old_mod_name, old_material_name, new_mod_name, new_material_name)
	minetest.register_alias_force(old_mod_name..":pillars_"..old_material_name.."_bottom",		new_mod_name..":pillar_"..new_material_name.."_bottom")
	minetest.register_alias_force(old_mod_name..":pillars_"..old_material_name.."_bottom_half",	new_mod_name..":pillar_"..new_material_name.."_bottom_half")
	minetest.register_alias_force(old_mod_name..":pillars_"..old_material_name.."_crossbrace",	new_mod_name..":pillar_"..new_material_name.."_crossbrace")
	minetest.register_alias_force(old_mod_name..":pillars_"..old_material_name.."_middle",		new_mod_name..":pillar_"..new_material_name.."_middle")
	minetest.register_alias_force(old_mod_name..":pillars_"..old_material_name.."_middle_half",	new_mod_name..":pillar_"..new_material_name.."_middle_half")
	minetest.register_alias_force(old_mod_name..":pillars_"..old_material_name.."_top",			new_mod_name..":pillar_"..new_material_name.."_top")
	minetest.register_alias_force(old_mod_name..":pillars_"..old_material_name.."_top_half",	new_mod_name..":pillar_"..new_material_name.."_top_half")
	minetest.register_alias_force(old_mod_name..":pillar_"..old_material_name.."_bottom",		new_mod_name..":pillar_"..new_material_name.."_bottom")
	minetest.register_alias_force(old_mod_name..":pillar_"..old_material_name.."_bottom_half",	new_mod_name..":pillar_"..new_material_name.."_bottom_half")
	minetest.register_alias_force(old_mod_name..":pillar_"..old_material_name.."_crossbrace",	new_mod_name..":pillar_"..new_material_name.."_crossbrace")
	minetest.register_alias_force(old_mod_name..":pillar_"..old_material_name.."_middle",		new_mod_name..":pillar_"..new_material_name.."_middle")
	minetest.register_alias_force(old_mod_name..":pillar_"..old_material_name.."_middle_half",	new_mod_name..":pillar_"..new_material_name.."_middle_half")
	minetest.register_alias_force(old_mod_name..":pillar_"..old_material_name.."_top",			new_mod_name..":pillar_"..new_material_name.."_top")
	minetest.register_alias_force(old_mod_name..":pillar_"..old_material_name.."_top_half",		new_mod_name..":pillar_"..new_material_name.."_top_half")
end