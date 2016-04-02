minetest.register_node("usesdirt:dirt_brick", {
	tiles = {"usesdirt_dirt_brick.png"},
	description = "Dirt Brick",
	groups = {snappy=2,choppy=1,oddly_breakable_by_hand=2},
})
minetest.register_craft({
	output = '"usesdirt:dirt_brick" 6',
	recipe = {
		{'default:dirt', 'default:dirt', 'default:dirt'},
		{'default:dirt', 'default:dirt', 'default:dirt'},
		{'default:dirt', 'default:dirt', 'default:dirt'},
	}
})
--Ladder
minetest.register_node("usesdirt:dirt_ladder", {
	description = "Ladder",
	drawtype = "signlike",
	tiles ={"usesdirt_dirt_ladder.png"},
	inventory_image = "usesdirt_dirt_ladder.png",
	wield_image = "usesdirt_dirt_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3},
	legacy_wallmounted = true,
})
minetest.register_craft({
	output = 'usesdirt:dirt_ladder 3',
	recipe = {
		{'usesdirt:dirt_brick', '', 'usesdirt:dirt_brick'},
		{'usesdirt:dirt_brick', 'usesdirt:dirt_brick','usesdirt:dirt_brick'},
		{'usesdirt:dirt_brick','','usesdirt:dirt_brick'},
	}
})
--Fence
minetest.register_node("usesdirt:dirt_fence", {
	description = "Dirt Fence",
	drawtype = "fencelike",
	tiles ={"usesdirt_dirt_brick.png"},
	inventory_image = "usesdirt_dirt_fence.png",
	wield_image = "usesdirt_dirt_fence.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {snappy=2,choppy=1,oddly_breakable_by_hand=3},
})
minetest.register_craft({
	output = 'usesdirt:dirt_fence 2',
	recipe = {
		{'usesdirt:dirt_brick', 'usesdirt:dirt_brick', 'usesdirt:dirt_brick'},
		{'usesdirt:dirt_brick', 'usesdirt:dirt_brick', 'usesdirt:dirt_brick'},
	}
})
---------------------------------------------------------------------------------------------------
minetest.register_node("usesdirt:dirt_cobble_stone", {
	tiles = {"usesdirt_dirt_cobble_stone.png"},
	description = "Dirt Cobble Stone",
	is_ground_content = true,
	groups = {cracky=3, stone=2},
})
minetest.register_craft({
	output = '"usesdirt:dirt_cobble_stone" 3',
	recipe = {
		{'usesdirt:dirt_brick', 'usesdirt:dirt_brick', 'usesdirt:dirt_brick'},
		{'usesdirt:dirt_brick', 'usesdirt:dirt_brick', 'usesdirt:dirt_brick'},
		{'usesdirt:dirt_brick', 'usesdirt:dirt_brick', 'usesdirt:dirt_brick'},
	}
})
--Ladder
minetest.register_node("usesdirt:dirt_cobble_stone_ladder", {
	description = "Ladder",
	drawtype = "signlike",
	tiles ={"usesdirt_dirt_cobble_stone_ladder.png"},
	inventory_image = "usesdirt_dirt_cobble_stone_ladder.png",
	wield_image = "usesdirt_dirt_cobble_stone_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {cracky=3, stone=2},
	legacy_wallmounted = true,
})
minetest.register_craft({
	output = 'usesdirt:dirt_cobble_stone_ladder 3',
	recipe = {
		{'usesdirt:dirt_cobble_stone', '', 'usesdirt:dirt_cobble_stone'},
		{'usesdirt:dirt_cobble_stone', 'usesdirt:dirt_cobble_stone','usesdirt:dirt_cobble_stone'},
		{'usesdirt:dirt_cobble_stone','','usesdirt:dirt_cobble_stone'},
	}
})
--Fence
minetest.register_node("usesdirt:dirt_cobble_stone_fence", {
	description = "Dirt Cobble Stone Fence",
	drawtype = "fencelike",
	tiles ={"usesdirt_dirt_cobble_stone.png"},
	inventory_image = "usesdirt_dirt_cobble_stone_fence.png",
	wield_image = "usesdirt_dirt_cobble_stone_fence.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky=3, stone=2},
})
minetest.register_craft({
	output = 'usesdirt:dirt_cobble_stone_fence 2',
	recipe = {
		{'usesdirt:dirt_cobble_stone', 'usesdirt:dirt_cobble_stone', 'usesdirt:dirt_cobble_stone'},
		{'usesdirt:dirt_cobble_stone', 'usesdirt:dirt_cobble_stone', 'usesdirt:dirt_cobble_stone'},
	}
})
----------------------------------------------------------------------------------------------------
minetest.register_node("usesdirt:dirt_stone", {
	tiles = {"usesdirt_dirt_stone.png"},
	description = "Dirt Stone",
	is_ground_content = true,
	groups = {cracky=3, stone=2},
})
--Ladder
minetest.register_node("usesdirt:dirt_stone_ladder", {
	description = "Ladder",
	drawtype = "signlike",
	tiles ={"usesdirt_dirt_stone_ladder.png"},
	inventory_image = "usesdirt_dirt_stone_ladder.png",
	wield_image = "usesdirt_dirt_stone_ladder.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	is_ground_content = true,
	walkable = false,
	climbable = true,
	selection_box = {
		type = "wallmounted",
		--wall_top = = <default>
		--wall_bottom = = <default>
		--wall_side = = <default>
	},
	groups = {cracky=3, stone=2},
	legacy_wallmounted = true,
})
minetest.register_craft({
	output = 'usesdirt:dirt_stone_ladder 3',
	recipe = {
		{'usesdirt:dirt_stone', '', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone','usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone','','usesdirt:dirt_stone'},
	}
})
--Fence
minetest.register_node("usesdirt:dirt_stone_fence", {
	description = "Dirt Stone Fence",
	drawtype = "fencelike",
	tiles ={"usesdirt_dirt_stone.png"},
	inventory_image = "usesdirt_dirt_stone_fence.png",
	wield_image = "usesdirt_dirt_stone_fence.png",
	paramtype = "light",
	is_ground_content = true,
	selection_box = {
		type = "fixed",
		fixed = {-1/7, -1/2, -1/7, 1/7, 1/2, 1/7},
	},
	groups = {cracky=3, stone=2},
})
minetest.register_craft({
	output = 'usesdirt:dirt_stone_fence 2',
	recipe = {
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
	}
})
minetest.register_craft({
	type = "cooking",
	output = "usesdirt:dirt_stone",
	recipe = "usesdirt:dirt_cobble_stone",
})
--Furnace

local furnace_inactive_formspec =
	"size[8,9]"..
	"image[2,2;1,1;default_furnace_fire_bg.png]"..
	"list[current_name;fuel;2,3;1,1;]"..
	"list[current_name;src;2,1;1,1;]"..
	"list[current_name;dst;5,1;2,2;]"..
	"list[current_player;main;0,5;8,4;]"..
	"background[-0.5,-0.65;9,10.35;bg_furnace.jpg]"

minetest.register_node("usesdirt:dirt_furnace", {
	description = "Furnace",
	tiles = {"usesdirt_dirt_furnace_top.png", "usesdirt_dirt_furnace_bottom.png", "usesdirt_dirt_furnace_side.png",
		"usesdirt_dirt_furnace_side.png", "usesdirt_dirt_furnace_side.png", "usesdirt_dirt_furnace_front.png"},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", furnace_inactive_formspec)
		meta:set_string("infotext", "Furnace")
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

minetest.register_node("usesdirt:dirt_furnace_active", {
	description = "Furnace",
	tiles = {"usesdirt_dirt_furnace_top.png", "usesdirt_dirt_furnace_bottom.png", "usesdirt_dirt_furnace_side.png",
		"usesdirt_dirt_furnace_side.png", "usesdirt_dirt_furnace_side.png", "usesdirt_dirt_furnace_front_active.png"},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "usesdirt:dirt_furnace",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", furnace_inactive_formspec)
		meta:set_string("infotext", "Furnace");
		local inv = meta:get_inventory()
		inv:set_size("fuel", 1)
		inv:set_size("src", 1)
		inv:set_size("dst", 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("fuel") then
			return false
		elseif not inv:is_empty("dst") then
			return false
		elseif not inv:is_empty("src") then
			return false
		end
		return true
	end,
})

function hacky_swap_node(pos,name)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	local meta0 = meta:to_table()
	if node.name == name then
		return
	end
	node.name = name
	local meta0 = meta:to_table()
	minetest.set_node(pos,node)
	meta = minetest.get_meta(pos)
	meta:from_table(meta0)
end

minetest.register_abm({
	nodenames = {"usesdirt:dirt_furnace","usesdirt:dirt_furnace_active"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		for i, name in ipairs({
				"fuel_totaltime",
				"fuel_time",
				"src_totaltime",
				"src_time"
		}) do
			if meta:get_string(name) == "" then
				meta:set_float(name, 0.0)
			end
		end

		local inv = meta:get_inventory()

		local srclist = inv:get_list("src")
		local cooked = nil
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		
		local was_active = false
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			was_active = true
			meta:set_float("fuel_time", meta:get_float("fuel_time") + 1)
			meta:set_float("src_time", meta:get_float("src_time") + 1)
			if cooked and cooked.item and meta:get_float("src_time") >= cooked.time then
				-- check if there's room for output in "dst" list
				if inv:room_for_item("dst",cooked.item) then
					-- Put result in "dst" list
					inv:add_item("dst", cooked.item)
					-- take stuff from "src" list
					srcstack = inv:get_stack("src", 1)
					srcstack:take_item()
					inv:set_stack("src", 1, srcstack)
				else
					print("Could not insert '"..cooked.item:to_string().."'")
				end
				meta:set_string("src_time", 0)
			end
		end
		
		if meta:get_float("fuel_time") < meta:get_float("fuel_totaltime") then
			local percent = math.floor(meta:get_float("fuel_time") /
					meta:get_float("fuel_totaltime") * 100)
			meta:set_string("infotext","Furnace active: "..percent.."%")
			hacky_swap_node(pos,"usesdirt:dirt_furnace_active")
			meta:set_string("formspec",
				"size[8,9]"..
				"image[2,2;1,1;default_furnace_fire_bg.png^[lowpart:"..
						(100-percent)..":default_furnace_fire_fg.png]"..
				"list[current_name;fuel;2,3;1,1;]"..
				"list[current_name;src;2,1;1,1;]"..
				"list[current_name;dst;5,1;2,2;]"..
				"list[current_player;main;0,5;8,4;]")
			return
		end

		local fuel = nil
		local cooked = nil
		local fuellist = inv:get_list("fuel")
		local srclist = inv:get_list("src")
		
		if srclist then
			cooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		end
		if fuellist then
			fuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})
		end

		if fuel.time <= 0 then
			meta:set_string("infotext","Furnace out of fuel")
			hacky_swap_node(pos,"usesdirt:dirt_furnace")
			meta:set_string("formspec", furnace_inactive_formspec)
			return
		end

		if cooked.item:is_empty() then
			if was_active then
				meta:set_string("infotext","Furnace is empty")
				hacky_swap_node(pos,"usesdirt:dirt_furnace")
				meta:set_string("formspec", furnace_inactive_formspec)
			end
			return
		end

		meta:set_string("fuel_totaltime", fuel.time)
		meta:set_string("fuel_time", 0)
		
		local stack = inv:get_stack("fuel", 1)
		stack:take_item()
		inv:set_stack("fuel", 1, stack)
	end,
})
minetest.register_craft({
	output = 'usesdirt:dirt_furnace',
	recipe = {
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', 'default:dirt','usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone','usesdirt:dirt_stone','usesdirt:dirt_stone'},
	}
})
--Tools
--axe
minetest.register_tool("usesdirt:dirt_axe", {
	description = "Dirt Axe",
	inventory_image = "usesdirt_dirt_axe.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			choppy={times={[1]=3.00, [2]=1.00, [3]=0.60}, uses=20, maxlevel=1},
			fleshy={times={[2]=1.30, [3]=0.70}, uses=20, maxlevel=1}
		}
	},
})
minetest.register_craft({
	output = 'usesdirt:dirt_axe',
	recipe = {
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', 'default:stick'},
		{'', 'default:stick'},
	}
})
--Sword
minetest.register_tool("usesdirt:dirt_sword", {
	description = "Dirt Sword",
	inventory_image = "usesdirt_dirt_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			fleshy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
			snappy={times={[2]=0.80, [3]=0.40}, uses=20, maxlevel=1},
			choppy={times={[3]=0.90}, uses=20, maxlevel=0}
		}
	}
})
minetest.register_craft({
	output = 'usesdirt:dirt_sword',
	recipe = {
		{'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone'},
		{'default:stick'},
	}
})

--Shovel
minetest.register_tool("usesdirt:dirt_shovel", {
	description = "Dirt Shovel",
	inventory_image = "usesdirt_dirt_shovel.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			crumbly={times={[1]=1.50, [2]=0.50, [3]=0.30}, uses=20, maxlevel=1}
		}
	},
})
minetest.register_craft({
	output = 'usesdirt:dirt_shovel',
	recipe = {
		{'usesdirt:dirt_stone'},
		{'default:stick'},
		{'default:stick'},
	}
})
--Pickaxe
minetest.register_tool("usesdirt:dirt_pick", {
	description = "Dirt Pickaxe",
	inventory_image = "usesdirt_dirt_pick.png",
	tool_capabilities = {
		max_drop_level=0,
		groupcaps={
			cracky={times={[1]=3.00, [2]=1.20, [3]=0.80}, uses=20, maxlevel=1}
		}
	},
})
minetest.register_craft({
	output = 'usesdirt:dirt_pick',
	recipe = {
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})
--Chest
minetest.register_node("usesdirt:dirt_chest", {
	description = "Dirt Chest",
	tiles = {"usesdirt_dirt_chest.png"},
	paramtype2 = "facedir",
	groups = {cracky=3, stone=2},
	legacy_facedir_simple = true,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Chest")
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
				" moves stuff in chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from chest at "..minetest.pos_to_string(pos))
	end,
})

local function has_locked_chest_privilege(meta, player)
	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end
	return true
end

minetest.register_node("usesdirt:dirt_locked_chest", {
	description = "Dirt Locked Chest",
	tiles = {"usesdirt_dirt_locked_chest.png"},
	paramtype2 = "facedir",
	groups = {cracky=3, stone=2},
	legacy_facedir_simple = true,
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Chest (owned by "..
				meta:get_string("owner")..")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",
				"size[8,9]"..
				"list[current_name;main;0,0;8,4;]"..
				"list[current_player;main;0,5;8,4;]")
		meta:set_string("infotext", "Locked Chest")
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not has_locked_chest_privilege(meta, player) then
			minetest.log("action", player:get_player_name()..
					" tried to access a locked chest belonging to "..
					meta:get_string("owner").." at "..
					minetest.pos_to_string(pos))
			return 0
		end
		return stack:get_count()
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff in locked chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" moves stuff to locked chest at "..minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
				" takes stuff from locked chest at "..minetest.pos_to_string(pos))
	end,
})

minetest.register_craft({
	output = 'usesdirt:dirt_locked_chest',
	recipe = {
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', 'default:steel_ingot', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
	}
})
minetest.register_craft({
	output = 'usesdirt:dirt_chest',
	recipe = {
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', '', 'usesdirt:dirt_stone'},
		{'usesdirt:dirt_stone', 'usesdirt:dirt_stone', 'usesdirt:dirt_stone'},
	}
})
