minetest.register_alias("darkage:box",         "castle_storage:crate")
minetest.register_alias("castle:crate",         "castle_storage:crate")

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("castle_storage:crate", {
	description = S("Crate"),
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
		meta:set_string("infotext", S("Crate"))
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("@1 moves stuff in crate at @2", player:get_player_name(), minetest.pos_to_string(pos)))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("@1 moves stuff to crate at @2", player:get_player_name(), minetest.pos_to_string(pos)))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("@1 takes stuff from locked chest at @2", player:get_player_name(), minetest.pos_to_string(pos)))
	end,
})

minetest.register_craft({
	output = "castle_storage:crate",
	recipe = {
		{"default:wood", "default:wood", "default:wood"},
		{"default:wood", "default:steel_ingot", "default:wood"},
	}
})

-- Hopper compatibility
if minetest.get_modpath("hopper") and hopper ~= nil and hopper.add_container ~= nil then
	hopper:add_container({
		{"top", "castle_storage:crate", "main"},
		{"side", "castle_storage:crate", "main"},
		{"bottom", "castle_storage:crate", "main"},
	})
end