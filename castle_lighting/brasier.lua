if not minetest.get_modpath("fire") then return end

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local brasier_longdesc = S("A brasier for producing copious amounts of light and heat.")
local brasier_usagehelp = S("To ignite the brasier place a flammable fuel in its inventory slot. A lump of coal will burn for about half an hour.")

local brasier_nodebox = {
	type = "fixed",
	fixed = {
		{-0.25, 0, -0.25, 0.25, 0.125, 0.25}, -- base
		{-0.375, 0.125, -0.375, 0.375, 0.25, 0.375}, -- mid
		{-0.5, 0.25, -0.5, 0.5, 0.375, 0.5}, -- plat
		{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, -- edge
		{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375}, -- edge
		{0.375, 0.375, -0.375, 0.5, 0.5, 0.375}, -- edge
		{-0.5, 0.375, -0.375, -0.375, 0.5, 0.375}, -- edge
		{0.25, -0.5, -0.375, 0.375, 0.125, -0.25}, -- leg
		{-0.375, -0.5, 0.25, -0.25, 0.125, 0.375}, -- leg
		{0.25, -0.5, 0.25, 0.375, 0.125, 0.375}, -- leg
		{-0.375, -0.5, -0.375, -0.25, 0.125, -0.25}, -- leg
		{-0.125, -0.0625, -0.125, 0.125, 0, 0.125}, -- bottom_knob
	}
}
local brasier_selection_box = {
	type = "fixed",
	fixed = {
		{-0.375, -0.5, -0.375, 0.375, 0.25, 0.375}, -- mid
		{-0.5, 0.25, -0.5, 0.5, 0.5, 0.5}, -- plat
	}
}

local brasier_burn = function(pos)
	local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
	local node_above = minetest.get_node(pos_above)
	local timer = minetest.get_node_timer(pos)
	
	if timer:is_started() and node_above.name == "fire:permanent_flame" then return end -- already burning, don't burn a new thing.
	
	local inv = minetest.get_inventory({type="node", pos=pos})
	local item = inv:get_stack("fuel", 1)
	local fuel_burned = minetest.get_craft_result({method="fuel", width=1, items={item:peek_item(1)}}).time
	
	if fuel_burned > 0 and (node_above.name == "air" or node_above.name == "fire:permanent_flame") then
		item:set_count(item:get_count() - 1)
		inv:set_stack("fuel", 1, item)

		timer:start(fuel_burned * 60) -- one minute of flame per second of burn time, for balance.
		
		if node_above.name == "air" then
			minetest.set_node(pos_above, {name = "fire:permanent_flame"})
		end
	else
		if node_above.name == "fire:permanent_flame" then
			minetest.set_node(pos_above, {name = "air"})
		end
	end
end

local brasier_on_construct = function(pos)
	local inv = minetest.get_meta(pos):get_inventory()
	inv:set_size("fuel", 1)
	
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", 
		"size[8,5.3]" ..
		default.gui_bg ..
		default.gui_bg_img ..
		default.gui_slots ..
		"list[current_name;fuel;3.5,0;1,1;]" ..
		"list[current_player;main;0,1.15;8,1;]" ..
		"list[current_player;main;0,2.38;8,3;8]" ..
		"listring[current_name;main]" ..
		"listring[current_player;main]" ..
		default.get_hotbar_bg(0,1.15)
	)
end

local brasier_on_destruct = function(pos, oldnode)
	local pos_above = {x=pos.x, y=pos.y+1, z=pos.z}
	local node_above = minetest.get_node(pos_above)
	if node_above.name == "fire:permanent_flame" then
		minetest.set_node(pos_above, {name = "air"})
	end
end

local brasier_can_dig = function(pos, player)
	local inv = minetest.get_meta(pos):get_inventory()
	return inv:is_empty("fuel")
end

-- Only allow fuel items to be placed in fuel
local brasier_allow_metadata_inventory_put = function(pos, listname, index, stack, player)
	if listname == "fuel" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			return stack:get_count()
		else
			return 0
		end
	end
	return 0
end

minetest.register_node("castle_lighting:brasier_floor", {
	description = S("Floor Brasier"),
	_doc_items_longdesc = brasier_longdesc,
	_doc_items_usagehelp = brasier_usagehelp,
	tiles = {
		"castle_steel.png^(castle_coal_bed.png^[mask:castle_brasier_bed_mask.png)",
		"castle_steel.png",
		"castle_steel.png",
		"castle_steel.png",
		"castle_steel.png",
		"castle_steel.png",
		},
	drawtype = "nodebox",
	groups = {cracky=2},
	paramtype = "light",
	node_box = brasier_nodebox,
	selection_box = brasier_selection_box,
	
	on_construct = brasier_on_construct,
	on_destruct = brasier_on_destruct,
	can_dig = brasier_can_dig,
	allow_metadata_inventory_put = brasier_allow_metadata_inventory_put,
	on_metadata_inventory_put = brasier_burn,
	on_timer = brasier_burn,
})


minetest.register_craft({
	output = "castle_lighting:brasier_floor",
	recipe = {
		{"default:steel_ingot", "default:torch", "default:steel_ingot"},
		{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
	}
})

if minetest.get_modpath("hopper") and hopper ~= nil and hopper.add_container ~= nil then
	hopper:add_container({
		{"top", "castle_lighting:brasier_floor", "fuel"},
		{"bottom", "castle_lighting:brasier_floor", "fuel"},
		{"side", "castle_lighting:brasier_floor", "fuel"},
	})
end

------------------------------------------------------------------------------------------------------
-- Masonry brasiers

local materials
if minetest.get_modpath("castle_masonry") then
	materials = castle_masonry.materials
else
	materials = {{name="stonebrick", desc=S("Stonebrick"), tile="default_stone_brick.png", craft_material="default:stonebrick"}}
end

local get_material_properties = function(material)
	local composition_def
	local burn_time
	if material.composition_material ~= nil then
		composition_def = minetest.registered_nodes[material.composition_material]
		burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack(material.composition_material)}}).time
	else
		composition_def = minetest.registered_nodes[material.craft_material]
		burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack(material.craft_materia)}}).time
	end
	
	local tiles = material.tile
	if tiles == nil then
		tiles = composition_def.tile
	elseif type(tiles) == "string" then
		tiles = {tiles}
	end
	
	-- Apply bed of coals to the texture.
	if table.getn(tiles) == 1 then
		tiles = {tiles[1].."^(castle_coal_bed.png^[mask:castle_brasier_bed_mask.png)", tiles[1], tiles[1], tiles[1], tiles[1], tiles[1]}
	else
		tiles[1] = tiles[1].."^(castle_coal_bed.png^[mask:castle_brasier_bed_mask.png)"
	end

	local desc = material.desc
	if desc == nil then
		desc = composition_def.description
	end
	
	return composition_def, burn_time, tiles, desc
end

local pillar_brasier_nodebox = {
	type = "fixed",
	fixed = {
		{-0.375, 0.125, -0.375, 0.375, 0.25, 0.375}, -- mid
		{-0.5, 0.25, -0.5, 0.5, 0.375, 0.5}, -- plat
		{-0.5, 0.375, 0.375, 0.5, 0.5, 0.5}, -- edge
		{-0.5, 0.375, -0.5, 0.5, 0.5, -0.375}, -- edge
		{0.375, 0.375, -0.375, 0.5, 0.5, 0.375}, -- edge
		{-0.5, 0.375, -0.375, -0.375, 0.5, 0.375}, -- edge
		{-0.25,-0.5,-0.25,0.25,0.125,0.25}, -- support
	}
}

local pillar_brasier_selection_box = {
	type = "fixed",
	fixed = {
		{-0.375, 0.125, -0.375, 0.375, 0.25, 0.375}, -- mid
		{-0.5, 0.25, -0.5, 0.5, 0.5, 0.5}, -- plat
		{-0.25,-0.5,-0.25,0.25,0.125,0.25}, -- support
	}
}

castle_lighting.register_pillar_brasier = function(material)
	local composition_def, burn_time, tile, desc = get_material_properties(material)
	if burn_time > 0 or composition_def.groups.puts_out_fire then return end -- No wooden brasiers, snow brasiers, or ice brasiers, alas.
	
	local crossbrace_connectable_groups = {}
	for group, val in pairs(composition_def.groups) do
		crossbrace_connectable_groups[group] = val
	end	
	crossbrace_connectable_groups.crossbrace_connectable = 1
	
	local mod_name = minetest.get_current_modname()

	minetest.register_node(mod_name..":"..material.name.."_pillar_brasier", {
		drawtype = "nodebox",
		description = S("@1 Brasier", desc),
		_doc_items_longdesc = brasier_longdesc,
		_doc_items_usagehelp = brasier_usagehelp,
		tiles = tile,
		paramtype = "light",
		paramtype2 = "facedir",
		groups = crossbrace_connectable_groups,
		sounds = composition_def.sounds,
		
		node_box = pillar_brasier_nodebox,
		selection_box = pillar_brasier_selection_box,
		
		on_construct = brasier_on_construct,
		on_destruct = brasier_on_destruct,
		can_dig = brasier_can_dig,
		allow_metadata_inventory_put = brasier_allow_metadata_inventory_put,
		on_metadata_inventory_put = brasier_burn,
		on_timer = brasier_burn,
	})

	minetest.register_craft({
	output = mod_name..":"..material.name.."_pillar_brasier 5",
	recipe = {
		{material.craft_material,"default:torch",material.craft_material},
		{material.craft_material,material.craft_material,material.craft_material},
		},
	})
	
	if minetest.get_modpath("hopper") and hopper ~= nil and hopper.add_container ~= nil then
		hopper:add_container({
			{"top", mod_name..":"..material.name.."_pillar_brasier", "fuel"},
			{"bottom", mod_name..":"..material.name.."_pillar_brasier", "fuel"},
			{"side", mod_name..":"..material.name.."_pillar_brasier", "fuel"},
		})
	end
end

for _, material in pairs(materials) do
	castle_lighting.register_pillar_brasier(material)
end
