-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

castle_masonry.register_arrowslit = function(material)
	local composition_def, burn_time, tile, desc = castle_masonry.get_material_properties(material)
	local mod_name = minetest.get_current_modname()

	-- Node Definition
	minetest.register_node(mod_name..":arrowslit_"..material.name, {
		drawtype = "nodebox",
		description = S("@1 Arrowslit", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.375, 0.5, -0.0625, 0.375, 0.3125},
				{0.0625, -0.375, 0.5, 0.5, 0.375, 0.3125},
				{-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125}, 
				{-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125}, 
				{0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
				{-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
			},
		},
	})

	minetest.register_node(mod_name..":arrowslit_"..material.name.."_cross", {
		drawtype = "nodebox",
		description = S("@1 Arrowslit with Cross", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.125, 0.5, -0.0625, 0.375, 0.3125},
				{0.0625, -0.125, 0.5, 0.5, 0.375, 0.3125},
				{-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
				{-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
				{0.0625, -0.375, 0.5, 0.5, -0.25, 0.3125},
				{-0.5, -0.375, 0.5, -0.0625, -0.25, 0.3125},
				{-0.5, -0.25, 0.5, -0.1875, -0.125, 0.3125},
				{0.1875, -0.25, 0.5, 0.5, -0.125, 0.3125},
				{0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
				{-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
			},
		},
	})

	minetest.register_node(mod_name..":arrowslit_"..material.name.."_hole", {
		drawtype = "nodebox",
		description = S("@1 Arrowslit with Hole", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.375, 0.5, -0.125, 0.375, 0.3125},
				{0.125, -0.375, 0.5, 0.5, 0.375, 0.3125},
				{-0.5, -0.5, 0.5, 0.5, -0.375, 0.3125},
				{0.0625, -0.125, 0.5, 0.125, 0.375, 0.3125},
				{-0.125, -0.125, 0.5, -0.0625, 0.375, 0.3125},
				{-0.5, 0.375, 0.5, 0.5, 0.5, 0.3125},
				{0.25, -0.5, 0.3125, 0.5, 0.5, 0.125},
				{-0.5, -0.5, 0.3125, -0.25, 0.5, 0.125},
			},
		},
	})

	minetest.register_node(mod_name..":arrowslit_"..material.name.."_embrasure", {
		drawtype = "nodebox",
		description = S("@1 Embrasure", desc),
		tiles = tile,
		groups = composition_def.groups,
		sounds = composition_def.sounds,
		paramtype = "light",
		paramtype2 = "facedir",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.25, -0.5, 0.375, -0.125, 0.5, 0.5},
				{0.125, -0.5, 0.375, 0.25, 0.5, 0.5},
				{0.25, -0.5, 0.25, 0.5, 0.5, 0.5},
				{0.375, -0.5, 0.125, 0.5, 0.5, 0.25},
				{-0.5, -0.5, 0.25, -0.25, 0.5, 0.5},
				{-0.5, -0.5, 0.125, -0.375, 0.5, 0.25},
			},
		},
	})
	
	minetest.register_craft({
		output = mod_name..":arrowslit_"..material.name.." 6",
		recipe = {
		{material.craft_material,"", material.craft_material},
		{material.craft_material,"", material.craft_material},
		{material.craft_material,"", material.craft_material} },
	})

	minetest.register_craft({
		output = mod_name..":arrowslit_"..material.name.."_cross",
		recipe = {
		{mod_name..":arrowslit_"..material.name} },
	})
	minetest.register_craft({
		output = mod_name..":arrowslit_"..material.name.."_hole",
		recipe = {
		{mod_name..":arrowslit_"..material.name.."_cross"} },
	})
	minetest.register_craft({
		output = mod_name..":arrowslit_"..material.name.."_embrasure",
		recipe = {
		{mod_name..":arrowslit_"..material.name.."_hole"} },
	})
	minetest.register_craft({
		output = mod_name..":arrowslit_"..material.name,
		recipe = {
		{mod_name..":arrowslit_"..material.name.."_embrasure"} },
	})
	
	if burn_time > 0 then
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":arrowslit_"..material.name,
			burntime = burn_time,
		})	
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":arrowslit_"..material.name.."_cross",
			burntime = burn_time,
		})	
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":arrowslit_"..material.name.."_hole",
			burntime = burn_time,
		})	
		minetest.register_craft({
			type = "fuel",
			recipe = mod_name..":arrowslit_"..material.name.."_embrasure",
			burntime = burn_time,
		})	
	end
end


castle_masonry.register_arrowslit_alias = function(old_mod_name, old_material_name, new_mod_name, new_material_name)
	minetest.register_alias(old_mod_name..":arrowslit_"..old_material_name,					new_mod_name..":arrowslit_"..new_material_name)
	minetest.register_alias(old_mod_name..":arrowslit_"..old_material_name.."_cross",		new_mod_name..":arrowslit_"..new_material_name.."_cross")
	minetest.register_alias(old_mod_name..":arrowslit_"..old_material_name.."_hole",		new_mod_name..":arrowslit_"..new_material_name.."_hole")
	minetest.register_alias(old_mod_name..":arrowslit_"..old_material_name.."_embrasure",	new_mod_name..":arrowslit_"..new_material_name.."_embrasure")
end

castle_masonry.register_arrowslit_alias_force = function(old_mod_name, old_material_name, new_mod_name, new_material_name)
	minetest.register_alias_force(old_mod_name..":arrowslit_"..old_material_name,				new_mod_name..":arrowslit_"..new_material_name)
	minetest.register_alias_force(old_mod_name..":arrowslit_"..old_material_name.."_cross",		new_mod_name..":arrowslit_"..new_material_name.."_cross")
	minetest.register_alias_force(old_mod_name..":arrowslit_"..old_material_name.."_hole",		new_mod_name..":arrowslit_"..new_material_name.."_hole")
	minetest.register_alias_force(old_mod_name..":arrowslit_"..old_material_name.."_embrasure",	new_mod_name..":arrowslit_"..new_material_name.."_embrasure")
end
