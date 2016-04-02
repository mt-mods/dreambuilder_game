glooptest.extragen_module = {}
glooptest.extragen_module.treasure={}
glooptest.debug("MESSAGE","Loading Extragen Module Now!")

-- {item name, max stack size, item rarity}
glooptest.extragen_module.treasure[1] = {
	{"default:stick", 30, 1},
	{"default:wood", 10, 1},
	{"default:tree", 5, 2},
	{"default:jungletree", 3, 6},
	{"default:cobble", 10, 2},
	{"default:pick_wood", 1, 12},
	{"default:shovel_wood", 1, 12},
	{"default:sword_wood", 1, 12},
	{"default:axe_wood", 1, 12},
	{"default:pick_stone", 1, 24},
	{"default:shovel_stone", 1, 24},
	{"default:sword_stone", 1, 24},
	{"default:axe_stone", 1, 24},
	{"default:furnace", 1, 8},
}

glooptest.extragen_module.treasure[2] = {
	{"default:stick", 40, 1},
	{"default:cobble", 30, 1},
	{"default:glass", 20, 4},
	{"default:stone", 15, 2},
	{"default:desert_stone", 15, 5},
	{"default:coal_lump", 15, 6},
	{"default:steel_ingot", 2, 8},
	{"default:obsidian_shard", 1, 10},
	{"default:pick_stone", 1, 12},
	{"default:shovel_stone", 1, 12},
	{"default:sword_stone", 1, 12},
	{"default:axe_stone", 1, 12},
}

glooptest.extragen_module.treasure[3] = {
	{"default:cobble", 40, 1},
	{"default:stick", 20, 3},
	{"default:torch", 15, 3},
	{"default:coal_lump", 20, 4},
	{"default:iron_lump", 10, 7},
	{"default:copper_lump", 10, 7},
	{"default:obsidian_shard", 5, 24},
	{"default:mese_crystal_fragment", 3, 24},
	{"default:pick_bronze", 1, 12},
	{"default:shovel_bronze", 1, 12},
	{"default:sword_bronze", 1, 12},
	{"default:axe_bronze", 1, 12},
}

glooptest.extragen_module.treasure[4] = {
	{"default:torch", 50, 3},
	{"default:coal_lump", 30, 3},
	{"default:iron_lump", 20, 5},
	{"default:gold_lump", 5, 16},
	{"default:mese_crystal_fragment", 5, 10},
	{"default:mese_crystal", 1, 25},
	{"default:diamond", 1, 100},
	{"default:pick_mese", 1, 18},
	{"default:shovel_mese", 1, 18},
	{"default:sword_mese", 1, 18},
	{"default:axe_mese", 1, 18},
}

glooptest.extragen_module.treasure[5] = {
	{"default:torch", 70, 3},
	{"default:iron_lump", 30, 3},
	{"default:gold_lump", 8, 15},
	{"default:mese_crystal_fragment", 15, 10},
	{"default:mese_crystal", 1, 17},
	{"default:diamond", 1, 24},
	{"default:pick_mese", 1, 12},
	{"default:shovel_mese", 1, 12},
	{"default:sword_mese", 1, 12},
	{"default:axe_mese", 1, 12},
	{"default:pick_diamond", 1, 60},
	{"default:shovel_diamond", 1, 60},
	{"default:sword_diamond", 1, 60},
	{"default:axe_diamond", 1, 60},
}

local treasure_chest_formspec = 
	"size[8,9]"..
	"list[current_name;main;0,0;8,4;]"..
	"list[current_player;main;0,5;8,4;]"
	
local treasure_chest_nodebox = {
	{-7/16, -8/16, -7/16, 7/16, 6/16, 7/16},
	{-8/16, -8/16, -8/16, 8/16, -7/16, 8/16},
	{-8/16, 1/16, -8/16, 8/16, 3/16, 8/16},
}
	
local function treasure_chest_populate(rank, pos)
	for i = 1,32 do
		for _ = 1,math.random(1,2) do
			item = glooptest.extragen_module.treasure[rank][math.random(1, #glooptest.extragen_module.treasure[rank])]
			item_rarity = item[3]
			if math.random(1, item_rarity+math.random(1,3)) == 1 then
				item_name = item[1]
				item_stacksize = item[2]-math.random(0,item[2]-1)
				minetest.get_inventory({type="node",pos={x=pos.x,y=pos.y,z=pos.z}}):set_stack("main", i, ItemStack({name=item_name,count=item_stacksize}))
				break
			else
			end
		end
	end
end

function glooptest.extragen_module.register_chest_loot(rank, entry)
	if minetest.registered_items[entry[1]] ~= nil then
		table.insert(glooptest.extragen_module.treasure[rank], entry)
	end
end

glooptest.extragen_module.register_chest_loot(1, {"glooptest:handsaw_wood", 1, 12})
glooptest.extragen_module.register_chest_loot(1, {"glooptest:hammer_wood", 1, 12})
glooptest.extragen_module.register_chest_loot(1, {"glooptest:handsaw_stone", 1, 24})
glooptest.extragen_module.register_chest_loot(1, {"glooptest:hammer_stone", 1, 24})

glooptest.extragen_module.register_chest_loot(2, {"glooptest:handsaw_stone", 1, 12})
glooptest.extragen_module.register_chest_loot(2, {"glooptest:hammer_stone", 1, 12})

glooptest.extragen_module.register_chest_loot(3, {"glooptest:handsaw_bronze", 1, 12})
glooptest.extragen_module.register_chest_loot(3, {"glooptest:hammer_bronze", 1, 12})

glooptest.extragen_module.register_chest_loot(4, {"glooptest:handsaw_mese", 1, 18})
glooptest.extragen_module.register_chest_loot(4, {"glooptest:hammer_mese", 1, 18})

glooptest.extragen_module.register_chest_loot(5, {"glooptest:handsaw_mese", 1, 12})
glooptest.extragen_module.register_chest_loot(5, {"glooptest:hammer_mese", 1, 12})
glooptest.extragen_module.register_chest_loot(5, {"glooptest:handsaw_diamond", 1, 60})
glooptest.extragen_module.register_chest_loot(5, {"glooptest:hammer_diamond", 1, 60})

minetest.register_node("glooptest:treasure_chest_1", {
	description = "Treasure Chest Rank 1",
	drawtype = "nodebox",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = treasure_chest_nodebox,
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",treasure_chest_formspec)
		meta:set_string("infotext", "Treasure Chest Rank I")
		local inv = meta:get_inventory()
		inv:set_size("main", 32)
		treasure_chest_populate(1, pos)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." takes items from R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
})

minetest.register_node("glooptest:treasure_chest_2", {
	description = "Treasure Chest Rank 2",
	drawtype = "nodebox",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = treasure_chest_nodebox,
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",treasure_chest_formspec)
		meta:set_string("infotext", "Treasure Chest Rank II")
		local inv = meta:get_inventory()
		inv:set_size("main", 32)
		treasure_chest_populate(2, pos)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." takes items from R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
})

minetest.register_node("glooptest:treasure_chest_3", {
	description = "Treasure Chest Rank 3",
	drawtype = "nodebox",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = treasure_chest_nodebox,
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",treasure_chest_formspec)
		meta:set_string("infotext", "Treasure Chest Rank III")
		local inv = meta:get_inventory()
		inv:set_size("main", 32)
		treasure_chest_populate(3, pos)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." takes items from R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
})

minetest.register_node("glooptest:treasure_chest_4", {
	description = "Treasure Chest Rank 4",
	drawtype = "nodebox",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	node_box = {
		type = "fixed",
		fixed = treasure_chest_nodebox,
	},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",treasure_chest_formspec)
		meta:set_string("infotext", "Treasure Chest Rank IV")
		local inv = meta:get_inventory()
		inv:set_size("main", 32)
		treasure_chest_populate(4, pos)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." takes items from R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
})

minetest.register_node("glooptest:treasure_chest_5", {
	description = "Treasure Chest Rank 5",
	drawtype = "nodebox",
	tiles = {"default_chest_top.png", "default_chest_top.png", "default_chest_side.png",
		"default_chest_side.png", "default_chest_side.png", "default_chest_front.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drop = "",
	groups = {choppy=2,oddly_breakable_by_hand=2},
	legacy_facedir_simple = true,
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = treasure_chest_nodebox,
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",treasure_chest_formspec)
		meta:set_string("infotext", "Treasure Chest Rank V")
		local inv = meta:get_inventory()
		inv:set_size("main", 32)
		treasure_chest_populate(5, pos)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." moves items in R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		glooptest.debug("ACTION", player:get_player_name().." takes items from R1 treasure chest at "..minetest.pos_to_string(pos)..".")
	end,
})

minetest.register_on_generated(function(minp, maxp)
	coords = {}
	coords.x = {}
	coords.y = {}
	coords.z = {}
	for i = minp.x,maxp.x do
		table.insert(coords.x, i)
	end
	for i = minp.y,maxp.y do
		table.insert(coords.y, i)
	end
	for i = minp.z,maxp.z do
		table.insert(coords.z, i)
	end
	for x = 1,#coords.x do
	for y = 1,#coords.y do
	for z = 1,#coords.z do
		if minetest.get_node({x=coords.x[x],y=coords.y[y]+1,z=coords.z[z]}).name == "air" and minetest.get_node({x=coords.x[x],y=coords.y[y],z=coords.z[z]}).name ~= "air" and minetest.registered_nodes[minetest.get_node({x=coords.x[x],y=coords.y[y],z=coords.z[z]}).name].drawtype == "normal" then
			if coords.y[y] >=0 then
				if math.random(1,5000) == 1 then
					minetest.place_node({x=coords.x[x],y=coords.y[y]+1,z=coords.z[z]}, {name="glooptest:treasure_chest_1", param2=math.random(1,4)})
				elseif math.random(1,8000) == 1 then
					minetest.place_node({x=coords.x[x],y=coords.y[y]+1,z=coords.z[z]}, {name="glooptest:treasure_chest_2", param2=math.random(1,4)})
				end
			elseif coords.y[y] <=-30 then
				if math.random(1,1000) == 1 then
					minetest.place_node({x=coords.x[x],y=coords.y[y]+1,z=coords.z[z]}, {name="glooptest:treasure_chest_3", param2=math.random(1,4)})
				elseif coords.y[y] <=-1000 then
					if math.random(1,1300) == 1 then
						minetest.place_node({x=coords.x[x],y=coords.y[y]+1,z=coords.z[z]}, {name="glooptest:treasure_chest_4", param2=math.random(1,4)})
					elseif coords.y[y] <=-2500 then
						if math.random(1,2000) == 1 then
							minetest.place_node({x=coords.x[x],y=coords.y[y]+1,z=coords.z[z]}, {name="glooptest:treasure_chest_5", param2=math.random(1,4)})
						end
					end
				end
			end
		end
	end
	end
	end
end)

--minetest.register_on_generated(glooptest.extragen_module.spawn_chests(minp, maxp))