
minetest.register_alias("darkage:box",         "castle:crate")
minetest.register_alias("cottages:straw",      "farming:straw")
minetest.register_alias("castle:straw",        "farming:straw")
minetest.register_alias("darkage:straw",       "farming:straw")
minetest.register_alias("cottages:straw_bale", "castle:bound_straw")
minetest.register_alias("darkage:straw_bale",  "castle:bound_straw")
minetest.register_alias("darkage:lamp",        "castle:street_light")
minetest.register_alias("castle:pavement",      "castle:pavement_brick")

minetest.register_node("castle:anvil",{
	drawtype = "nodebox",
	description = "Anvil",
	tiles = {"castle_steel.png"},
	groups = {cracky=2,falling_node=1},
	sounds = default.node_sound_stone_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.250000,0.500000},
			{-0.187500,-0.500000,-0.375000,0.187500,0.312500,0.375000},
			{-0.375000,-0.500000,-0.437500,0.375000,-0.125000,0.437500},
			{-0.500000,0.312500,-0.500000,0.500000,0.500000,0.500000},
			{-0.375000,0.187500,-0.437500,0.375000,0.425000,0.437500},
		},
	},
})

minetest.register_craft({
	output = "castle:anvil",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"","default:steel_ingot", ""},
		{"default:steel_ingot", "default:steel_ingot","default:steel_ingot"},
	}
})

minetest.register_node("castle:workbench",{
	description = "Workbench",
	tiles = {"castle_workbench_top.png", "castle_workbench_bottom.png", "castle_workbench_side.png", "castle_workbench_side.png", "castle_workbench_back.png", "castle_workbench_front.png"},
	paramtype2 = "facedir",
	paramtype = "light",
	groups = {choppy=2,oddly_breakable_by_hand=2,flammable=2},
	sounds = default.node_sound_wood_defaults(),
	drawtype = "normal",
	on_construct = function ( pos )
		local meta = minetest.get_meta( pos )
			meta:set_string( 'formspec',
			'size[10,10;]' ..
			default.gui_bg ..
			default.gui_bg_img ..
			default.gui_slots ..
			'label[1,0;Source Material]' ..
			'list[context;src;1,1;2,4;]' ..
			'label[4,0;Recipe to Use]' ..
			'list[context;rec;4,1;3,3;]' ..
			'label[7.5,0;Craft Output]' ..
			'list[context;dst;8,1;1,4;]' ..
			'list[current_player;main;1,6;8,4;]' )
		meta:set_string( 'infotext', 'Workbench' )
		local inv = meta:get_inventory()
		inv:set_size( 'src', 2 * 4 )
		inv:set_size( 'rec', 3 * 3 )
		inv:set_size( 'dst', 1 * 4 )
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in workbench at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to workbench at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from workbench at "..minetest.pos_to_string(pos))
	end,
})
local get_recipe = function ( inv )
	local result, needed, input
	needed = inv:get_list( 'rec' )

	result, input = minetest.get_craft_result( {
		method = 'normal',
		width = 3,
		items = needed
	})

	local totalneed = {}

	if result.item:is_empty() then
		result = nil
	else
		result = result.item
		for _, item in ipairs( needed ) do
			if item ~= nil and not item:is_empty() and not inv:contains_item( 'src', item ) then
				result = nil
				break
			end
			if item ~= nil and not item:is_empty() then
				if totalneed[item:get_name()] == nil then
					totalneed[item:get_name()] = 1
				else
					totalneed[item:get_name()] = totalneed[item:get_name()] + 1
				end
			end
		end
		for name, number in pairs( totalneed ) do
			local totallist = inv:get_list( 'src' )
			for i, srcitem in pairs( totallist ) do
				if srcitem:get_name() == name then
					local taken = srcitem:take_item( number )
					number = number - taken:get_count()
					totallist[i] = srcitem
				end
				if number <= 0 then
					break
				end
			end
			if number > 0 then
				result = nil
				break
			end
		end
	end

	return needed, input, result
end

minetest.register_abm( {
	nodenames = { 'castle:workbench' },
	interval = 5,
	chance = 1,
	action = function ( pos, node )
		local meta = minetest.get_meta( pos )
		local inv = meta:get_inventory()
		local result, newinput, needed
		if not inv:is_empty( 'src' ) then
			-- Check for a valid recipe and sufficient resources to craft it
			needed, newinput, result = get_recipe( inv )
			if result ~= nil and inv:room_for_item( 'dst', result ) then
				inv:add_item( 'dst', result )
				for i, item in pairs( needed ) do
					if item ~= nil and item ~= '' then
						inv:remove_item( 'src', ItemStack( item ) )
					end
					if newinput[i] ~= nil and not newinput[i]:is_empty() then
						inv:add_item( 'src', newinput[i] )
					end
				end
			end
		end
	end
} )

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_craft({
	output = "castle:workbench",
	recipe = {
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:wood", "default:wood","default:steel_ingot"},
		{"default:tree", "default:tree","default:steel_ingot"},
	}
})

minetest.register_node("castle:dungeon_stone", {
	description = "Dungeon Stone",
	drawtype = "normal",
	tiles = {"castle_dungeon_stone.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "castle:dungeon_stone",
	recipe = {
		{"default:stonebrick", "default:obsidian"},
	}
})

minetest.register_craft({
	output = "castle:dungeon_stone",
	recipe = {
		{"default:stonebrick"},
		{"default:obsidian"},
	}
})

minetest.register_node("castle:crate", {
	description = "Crate",
	drawtype = "normal",
	tiles = {"castle_crate_top.png","castle_crate_top.png","castle_crate.png","castle_crate.png","castle_crate.png","castle_crate.png"},
	groups = {choppy=3},
	sounds = default.node_sound_wood_defaults(),
	paramtype = "light",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				 default.gui_bg ..
				 default.gui_bg_img ..
				 default.gui_slots ..
				"list[current_name;main;0,0;8,5;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Crate")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in crate at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to crate at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from crate at "..minetest.pos_to_string(pos))
	end,
})

minetest.register_craft({
	output = "castle:crate",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:steel_ingot", "default:wood"},
	}
})

minetest.register_node("castle:bound_straw", {
	description = "Bound Straw",
	drawtype = "normal",
	tiles = {"castle_straw_bale.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
})

minetest.register_craft({
	output = "castle:bound_straw",
	recipe = {
		{"castle:straw", "castle:ropes"},
	}
})

minetest.register_node("castle:pavement_brick", {
	description = "Paving Stone",
	drawtype = "normal",
	tiles = {"castle_pavement_brick.png"},
	groups = {cracky=2},
	paramtype = "light",
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "castle:pavement_brick 4",
	recipe = {
		{"default:stone", "default:cobble"},
		{"default:cobble", "default:stone"},
	}
})

minetest.register_node("castle:light",{
	drawtype = "glasslike",
	description = "Light Block",
	sunlight_propagates = true,
	light_source = 14,
	tiles = {"castle_street_light.png"},
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	paramtype = "light",
})

minetest.register_craft({
	output = "castle:light",
	recipe = {
		{"default:stick", "default:glass", "default:stick"},
		{"default:glass", "default:torch", "default:glass"},
		{"default:stick", "default:glass", "default:stick"},
	}
})

if minetest.get_modpath("moreblocks") then
	stairsplus:register_all("castle", "dungeon_stone", "castle:dungeon_stone", {
		description = "Dungeon Stone",
		tiles = {"castle_dungeon_stone.png"},
		groups = {cracky=2, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
	})

	stairsplus:register_all("castle", "pavement_brick", "castle:pavement_brick", {
		description = "Pavement Brick",
		tiles = {"castle_pavement_brick.png"},
		groups = {cracky=2, not_in_creative_inventory=1},
		sounds = default.node_sound_stone_defaults(),
		sunlight_propagates = true,
	})

else
	stairs.register_stair_and_slab("dungeon_stone", "castle:dungeon_stone",
		{cracky=2},
		{"castle_dungeon_stone.png"},
		"Dungeon Stone Stair",
		"Dungeon Stone Slab",
		default.node_sound_stone_defaults()
	)

	stairs.register_stair_and_slab("pavement_brick", "castle:pavement_brick",
		{cracky=2},
		{"castle_pavement_brick.png"},
		"Castle Pavement Stair",
		"Castle Pavement Slab",
		default.node_sound_stone_defaults()
	)
end

minetest.register_node( "castle:chandelier", {
	drawtype = "plantlike",
	description = "Chandelier",
	paramtype = "light",
	wield_image = "castle_chandelier_wield.png",
	inventory_image = "castle_chandelier_wield.png", 
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	sunlight_propagates = true,
	light_source = 14,
	tiles = {
			{
			name = "castle_chandelier.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1.0
			},
		},
	},
	selection_box = {
		type = "fixed",
			fixed = {
				{0.35,-0.375,0.35,-0.35,0.5,-0.35},

		},
	},
})

minetest.register_node( "castle:chandelier_chain", {
	drawtype = "plantlike",
	description = "Chandelier Chain",
	paramtype = "light",
	wield_image = "castle_chandelier_chain.png",
	inventory_image = "castle_chandelier_chain.png", 
	groups = {cracky=2},
	sounds = default.node_sound_glass_defaults(),
	sunlight_propagates = true,
	tiles = {"castle_chandelier_chain.png"},
	selection_box = {
		type = "fixed",
			fixed = {
				{0.1,-0.5,0.1,-0.1,0.5,-0.1},

		},
	},
})

