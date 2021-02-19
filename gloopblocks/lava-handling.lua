-- Load support for intllib.
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

-- define lava-cooling-based nodes and hook into the default lavacooling
-- functions to generate basalt, pumice, and obsidian

if minetest.setting_getbool("gloopblocks_lavacooling") ~= false then

	minetest.register_node("gloopblocks:obsidian_cooled", {
		description = S("Obsidian"),
		tiles = {"default_obsidian.png"},
		is_ground_content = true,
		sounds = default.node_sound_stone_defaults(),
		groups = {cracky=1, level=2, not_in_creative_inventory=1},
		drop = "default:obsidian",
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			minetest.add_node(pos, {name = "default:obsidian"})
		end
	})

	minetest.register_node("gloopblocks:basalt_cooled", {
		description = S("Basalt"),
		tiles = {"gloopblocks_basalt.png"},
		groups = {cracky=2, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		drop = "gloopblocks:basalt",
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			minetest.add_node(pos, {name = "gloopblocks:basalt"})
		end
	})

	minetest.register_node("gloopblocks:pumice_cooled", {
		description = S("Pumice"),
		tiles = {"gloopblocks_pumice.png"},
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		drop = "gloopblocks:pumice",
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			minetest.add_node(pos, {name = "gloopblocks:pumice"})
		end
	})

	local gloopblocks_search_nearby_nodes = function(pos, node)
		if minetest.get_node({x=pos.x-1, y=pos.y, z=pos.z}).name == node then return true end
		if minetest.get_node({x=pos.x+1, y=pos.y, z=pos.z}).name == node then return true end
		if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == node then return true end
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == node then return true end
		if minetest.get_node({x=pos.x, y=pos.y, z=pos.z-1}).name == node then return true end
		if minetest.get_node({x=pos.x, y=pos.y, z=pos.z+1}).name == node then return true end
		return false
	end

	default.cool_lava = function(pos, node)
		if node.name == "default:lava_source" then
			if gloopblocks_search_nearby_nodes(pos,"default:water_source")
			or gloopblocks_search_nearby_nodes(pos,"default:water_flowing") then
				minetest.set_node(pos, {name="gloopblocks:obsidian_cooled"})
			end
		else -- Lava flowing
			if gloopblocks_search_nearby_nodes(pos,"default:water_source") then
				minetest.set_node(pos, {name="gloopblocks:basalt_cooled"})
			elseif gloopblocks_search_nearby_nodes(pos,"default:water_flowing") then
				minetest.set_node(pos, {name="gloopblocks:pumice_cooled"})
			end
		end
	end
end

-- Allows lava to "bake" neighboring nodes (or reduce them to ashes)
-- disabled by default.  You probably don't want this on a creative server :-P

if minetest.setting_getbool("gloopblocks_lava_damage") then
	minetest.register_node("gloopblocks:ash_block", {
		description = S("Block of ashes"),
		tiles = {"gloopblocks_ashes.png"},
		groups = {crumbly = 3},
		sounds = default.node_sound_dirt_defaults(),
	})

	local cbox = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, -0.125, 0.5}
	}

	minetest.register_node("gloopblocks:ash_pile", {
		description = S("Pile of ashes"),
		drawtype = "mesh",
		mesh = "gloopblocks_ash_pile.obj",
		tiles = {"gloopblocks_ashes.png"},
		selection_box = cbox,
		collision_box = cbox,
		groups = {crumbly = 3},
		sounds = default.node_sound_dirt_defaults(),
	})

	gloopblocks.lava_damage_nodes = {
		["default:cactus"]               = "gloopblocks:ash_block",
		["default:coalblock"]            = "gloopblocks:ash_block",
		["default:desert_cobble"]        = "default:desert_stone",
		["default:desert_sandstone"]     = "default:desert_sandstone_block",
		["default:gravel"]               = "default:cobble",
		["default:ice"]                  = "default:snowblock",
		["default:permafrost"]           = "default:dirt",
		["default:permafrost_with_moss"] = "default:dirt",
		["default:sandstone"]            = "default:sandstone_block",
		["default:silver_sandstone"]     = "default:silver_sandstone_block",
		["default:snowblock"]            = "default:water_source",

		["basic_materials:cement_block"] = "basic_materials:concrete_block",
		["bedrock:deepstone"]            = "default:stone",
		["building_blocks:hardwood"]     = "default:coalblock",
		["building_blocks:Tar"]          = "gloopblocks:pavement",
		["bushes:basket_empty"]          = "gloopblocks:ash_pile",
		["bushes:basket_blackberry"]     = "gloopblocks:ash_pile",
		["bushes:basket_blueberry"]      = "gloopblocks:ash_pile",
		["bushes:basket_gooseberry"]     = "gloopblocks:ash_pile",
		["bushes:basket_mixed_berry"]    = "gloopblocks:ash_pile",
		["bushes:basket_raspberry"]      = "gloopblocks:ash_pile",
		["bushes:basket_strawberry"]     = "gloopblocks:ash_pile",
		["caverealms:thin_ice"]          = "default:water_source",
		["castle_masonry:rubble"]        = "default:desert_stone",
		["usesdirt:dirt_stone"]          = "default:stone",
		["usesdirt:dirt_cobble_stone"]   = "default:stone",
		["wool:dark_grey"]               = "gloopblocks:ash_pile"
	}

	gloopblocks.lava_damage_groups = {
		["wood"]   = "default:coalblock",
		["tree"]   = "default:coalblock",
		["soil"]   = "gloopblocks:basalt",
		["leaves"] = "gloopblocks:ash_pile",
		["fence"]  = "gloopblocks:ash_pile",
		["stone"]  = "default:stone",
	}

	if minetest.get_modpath("cottages") then
		gloopblocks.lava_damage_nodes["cottages:hay"]                  = "cottages:reet"
		gloopblocks.lava_damage_nodes["cottages:hay_bale"]             = "cottages:reet"
		gloopblocks.lava_damage_nodes["cottages:hay_mat"]              = "cottages:straw_mat"
		gloopblocks.lava_damage_nodes["cottages:reet"]                 = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_black"]           = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_brown"]           = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_red"]             = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_reet"]            = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_straw"]           = "cottages:roof_reet"
		gloopblocks.lava_damage_nodes["cottages:roof_wood"]            = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_connector_black"] = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_connector_brown"] = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_connector_red"]   = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_connector_reet"]  = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_connector_straw"] = "cottages:roof_connector_reet"
		gloopblocks.lava_damage_nodes["cottages:roof_connector_wood"]  = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_flat_black"]      = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_flat_brown"]      = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_flat_red"]        = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_flat_reet"]       = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:roof_flat_straw"]      = "cottages:roof_flat_reet"
		gloopblocks.lava_damage_nodes["cottages:roof_flat_wood"]       = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["cottages:straw_ground"]         = "cottages:loam"
		gloopblocks.lava_damage_nodes["cottages:loam"]                 = "default:dirt"
		gloopblocks.lava_damage_nodes["cottages:feldweg"]              = "default:dirt"
		gloopblocks.lava_damage_nodes["cottages:feldweg_crossing"]     = "default:dirt"
		gloopblocks.lava_damage_nodes["cottages:feldweg_curve"]        = "default:dirt"
		gloopblocks.lava_damage_nodes["cottages:feldweg_end"]          = "default:dirt"
		gloopblocks.lava_damage_nodes["cottages:feldweg_slope"]        = "default:dirt"
		gloopblocks.lava_damage_nodes["cottages:feldweg_slope_long"]   = "default:dirt"
		gloopblocks.lava_damage_nodes["cottages:feldweg_t_junction"]   = "default:dirt"
	end

	if minetest.get_modpath("dryplants") then
		gloopblocks.lava_damage_nodes["dryplants:wetreed"]               = "dryplants:reed"
		gloopblocks.lava_damage_nodes["dryplants:wetreed_slab"]          = "dryplants:reed_slab"
		gloopblocks.lava_damage_nodes["dryplants:wetreed_roof"]          = "dryplants:reed_roof"
		gloopblocks.lava_damage_nodes["dryplants:wetreed_roof_corner"]   = "dryplants:reed_roof_corner"
		gloopblocks.lava_damage_nodes["dryplants:wetreed_roof_corner_2"] = "dryplants:reed_roof_corner_2"
		gloopblocks.lava_damage_nodes["dryplants:reed"]                  = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["dryplants:reed_slab"]             = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["dryplants:reed_roof"]             = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["dryplants:reed_roof_corner"]      = "gloopblocks:ash_pile"
		gloopblocks.lava_damage_nodes["dryplants:reed_roof_corner_2"]    = "gloopblocks:ash_pile"
	end

	if minetest.get_modpath("wool") then
		gloopblocks.lava_damage_groups["wool"] = "wool:dark_grey"
	end

	if minetest.get_modpath("bakedclay") then
		gloopblocks.lava_damage_nodes["default:clay"] = "bakedclay:dark_grey"
		gloopblocks.lava_damage_groups["bakedclay"]   = "bakedclay:dark_grey"
	else
		gloopblocks.lava_damage_nodes["default:clay"] = "gloopblocks:basalt"
	end

	if minetest.get_modpath("moreblocks") then
		gloopblocks.lava_damage_groups["sand"] = "moreblocks:coal_glass"
	else
		gloopblocks.lava_damage_groups["sand"] = "default:obsidian_glass"
	end

	if minetest.get_modpath("farming") then
		gloopblocks.lava_damage_nodes["farming:soil_wet"] = "farming:soil"
	end

	gloopblocks.lava_neighbors = {
		{ x=-1, y=-1, z=-1 },
		{ x=-1, y=-1, z= 0 },
		{ x=-1, y=-1, z= 1 },
		{ x=-1, y= 0, z=-1 },
		{ x=-1, y= 0, z= 0 },
		{ x=-1, y= 0, z= 1 },
		{ x=-1, y= 1, z=-1 },
		{ x=-1, y= 1, z= 0 },
		{ x=-1, y= 1, z= 1 },

		{ x= 0, y=-1, z=-1 },
		{ x= 0, y=-1, z= 0 },
		{ x= 0, y=-1, z= 1 },
		{ x= 0, y= 0, z=-1 },
--		{ x= 0, y= 0, z= 0 }, -- will always be the lava node, so ignore this space
		{ x= 0, y= 0, z= 1 },
		{ x= 0, y= 1, z=-1 },
		{ x= 0, y= 1, z= 0 },
		{ x= 0, y= 1, z= 1 },

		{ x= 1, y=-1, z=-1 },
		{ x= 1, y=-1, z= 0 },
		{ x= 1, y=-1, z= 1 },
		{ x= 1, y= 0, z=-1 },
		{ x= 1, y= 0, z= 0 },
		{ x= 1, y= 0, z= 1 },
		{ x= 1, y= 1, z=-1 },
		{ x= 1, y= 1, z= 0 },
		{ x= 1, y= 1, z= 1 },
	}

	minetest.register_abm({
		nodenames = {"default:lava_source", "default:lava_flowing"},
		interval = 5,
		chance = 2,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local r=gloopblocks.lava_neighbors[math.random(1, 26)]
			local pos2 = {
				x = pos.x + r.x,
				y = pos.y + r.y,
				z = pos.z + r.z
			}
			local newnode
			local chknode = minetest.get_node(pos2)
			local def = minetest.registered_items[chknode.name]

			if gloopblocks.lava_damage_nodes[chknode.name] then
				newnode = gloopblocks.lava_damage_nodes[chknode.name]
			elseif def and def.drawtype == "plantlike" then
				newnode = "air"
			else
				for group, new in pairs(gloopblocks.lava_damage_groups) do
					if minetest.get_item_group(chknode.name, group) > 0 then
						newnode = new
						break
					end
				end
			end

			if newnode then
				minetest.set_node(pos2, {name = newnode, param2 = chknode.param2})
			end
		end
	})
end

if minetest.get_modpath("worldedit") then
	function gloopblocks.liquid_ungrief(pos1, pos2, name)
		local count
		local p1to2 = minetest.pos_to_string(pos1).." and "..minetest.pos_to_string(pos2)
		local volume = worldedit.volume(pos1, pos2)
		minetest.chat_send_player(name, "Cleaning-up lava/water griefing between "..p1to2.."...")
		if volume > 1000000 then
			minetest.chat_send_player(name, "This operation could affect up to "..volume.." nodes.  It may take a while.")
		end
		minetest.log("action", name.." performs lava/water greifing cleanup between "..p1to2..".")
		count = worldedit.replace(pos1, pos2, "default:lava_source", "air")
		count = worldedit.replace(pos1, pos2, "default:lava_flowing", "air")
		count = worldedit.replace(pos1, pos2, "default:water_source", "air")
		count = worldedit.replace(pos1, pos2, "default:water_flowing", "air")
		count = worldedit.replace(pos1, pos2, "default:river_water_source", "air")
		count = worldedit.replace(pos1, pos2, "default:river_water_flowing", "air")
		count = worldedit.replace(pos1, pos2, "gloopblocks:pumice_cooled", "air")
		count = worldedit.replace(pos1, pos2, "gloopblocks:basalt_cooled", "air")
		count = worldedit.replace(pos1, pos2, "gloopblocks:obsidian_cooled", "air")
		count = worldedit.fixlight(pos1, pos2)
		minetest.chat_send_player(name, "Operation completed.")
	end

	minetest.register_chatcommand("/liquid_ungrief", {
		params = "[size]",
		privs = {worldedit = true},
		description = "Repairs greifing caused by spilling lava and water (and their \"cooling\" results)",
		func = function(name, params)
			local pos1 = worldedit.pos1[name]
			local pos2 = worldedit.pos2[name]
			if not pos1 or not pos2 then return end
			gloopblocks.liquid_ungrief(pos1, pos2, name)
		end
	})
end
