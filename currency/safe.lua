-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

function default.get_safe_formspec(pos, page)
	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local ipos = 50*page
	local formspec =
		"size[8,11]"..
		default.gui_bg..
		default.gui_bg_img..
		default.gui_slots..
		"button[1,-0.1;2,1;page1;Page 1]"..
		"button[5,-0.1;2,1;page2;Page 2]"..
		"list[nodemeta:".. spos .. ";main;0,0.9;8,6;"..ipos.."]"..
		"list[current_player;main;0,7.2;8,4;]"..
		"listring[nodemeta:".. spos .. ";main]"..
		"listring[current_player;main]"
	return formspec
end

local function show_safe_form(clicker, pos, page)
	minetest.show_formspec(
		clicker:get_player_name(),
		"currency:safe",
		default.get_safe_formspec(pos, page)
	)
	minetest.register_on_receive_fields(function(player, form, pressed)
		print("[SAFE] page button pressed: "..dump(pressed))
		if form=="currency:safe" then
			if pressed.page1 then show_safe_form(clicker, pos, 0) end
			if pressed.page2 then show_safe_form(clicker, pos, 1) end
		end
	end)
end



local function has_safe_privilege(meta, player)
	local name = ""
	if player then
		if minetest.check_player_privs(player, "protection_bypass") then
			return true
		end
		name = player:get_player_name()
	end
	if name ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("currency:safe", {
	description = S("Safe"),
	inventory_image = "safe_front.png",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {"safe_side.png",
			"safe_side.png",
			"safe_side.png",
			"safe_side.png",
			"safe_side.png",
			"safe_front.png",},
	is_ground_content = false,
	groups = {cracky=1},
	on_rightclick = function(pos, node, clicker)
		local meta = minetest.get_meta(pos)
		if has_safe_privilege(meta, clicker) then
			show_safe_form(clicker, pos, 0)
		end
	end,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", S("Safe (owned by @1)", meta:get_string("owner")))
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Safe")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 12*8)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and has_safe_privilege(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_safe_privilege(meta, player) then
			minetest.log("action", S("@1 tried to access a safe belonging to @2 at @3",
				player:get_player_name(), meta:get_string("owner"),	minetest.pos_to_string(pos)))
			return 0
		end
		return count
	end,
	allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_safe_privilege(meta, player) then
			minetest.log("action", S("@1 tried to access a safe belonging to @2 at @3",
				player:get_player_name(), meta:get_string("owner"), minetest.pos_to_string(pos)))
			return 0
		end
		return stack:get_count()
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_safe_privilege(meta, player) then
			minetest.log("action", S("@1 tried to access a safe belonging to @2 at @3",
				player:get_player_name(), meta:get_string("owner"), minetest.pos_to_string(pos)))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", S("@1 moves stuff in safe at @2", player:get_player_name(), minetest.pos_to_string(pos)))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", S("@1 moves stuff to safe at @2", player:get_player_name(), minetest.pos_to_string(pos)))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", S("@1 takes stuff from safe at @2", player:get_player_name(), minetest.pos_to_string(pos)))
	end,
})
