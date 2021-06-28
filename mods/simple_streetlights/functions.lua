local fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 }
}

local fdir_to_back = {
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 },
	{  1,  0 }
}
--digilines compatibility

local rules_alldir = {
	{x =  0, y =  0, z = -1},  -- borrowed from lightstones
	{x =  1, y =  0, z =  0},
	{x = -1, y =  0, z =  0},
	{x =  0, y =  0, z =  1},
	{x =  1, y =  1, z =  0},
	{x =  1, y = -1, z =  0},
	{x = -1, y =  1, z =  0},
	{x = -1, y = -1, z =  0},
	{x =  0, y =  1, z =  1},
	{x =  0, y = -1, z =  1},
	{x =  0, y =  1, z = -1},
	{x =  0, y = -1, z = -1},
	{x =  0, y = -1, z =  0},
}

function streetlights.rightclick_pointed_thing(pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node_or_nil(pos)
	if not node then return false end
	local def = minetest.registered_nodes[node.name]
	if not def or not def.on_rightclick then return false end
	return def.on_rightclick(pos, node, placer, itemstack, pointed_thing) or itemstack
end

function streetlights.check_and_place(itemstack, placer, pointed_thing, def)

	local pole                = def.pole
	local base                = def.base or def.pole
	local light               = def.light
	local height              = def.height or 5
	local needs_digiline_wire = def.needs_digiline_wire
	local distributor_node    = def.distributor_node
	local poletop             = (def.topnodes and (type(def.topnodes) == "table") and def.topnodes.poletop)  or pole
	local overhang            = (def.topnodes and (type(def.topnodes) == "table") and def.topnodes.overhang) or pole
	local copy_pole_fdir      = def.copy_pole_fdir
	local light_fdir          = def.light_fdir

	local controls = placer:get_player_control()
	if not placer then return end
	local player_name = placer:get_player_name()

	local placer_pos = placer:get_pos() -- this bit borrowed from builtin/game/item.lua
	local target_dir = vector.subtract(pointed_thing.above, placer_pos)
	local fdir = minetest.dir_to_facedir(target_dir)

	local pos1 = minetest.get_pointed_thing_position(pointed_thing)
	local node1 = minetest.get_node(pos1)
	if not node1 or node1.name == "ignore" then return end
	local def1 = minetest.registered_items[node1.name]

	if (def1 and def1.buildable_to) then
		pos1.y = pos1.y-1
	end

	local rc = streetlights.rightclick_pointed_thing(pos1, placer, itemstack, pointed_thing)
	if rc then return rc end

	if not minetest.check_player_privs(placer, "streetlight") then
		minetest.chat_send_player(player_name, "*** You don't have permission to use a streetlight spawner.")
		return
	end

	local node1 = minetest.get_node(pos1)

	local node2, node3, node4
	local def1 = minetest.registered_items[node1.name]
	local def2, def3, def4

	local pos2, pos3, pos4
	for i = 1, height do
		pos2 = { x=pos1.x, y = pos1.y+i, z=pos1.z }
		node2 = minetest.get_node(pos2)
		def2 = minetest.registered_items[node2.name]
		if minetest.is_protected(pos2, player_name) or not (def2 and def2.buildable_to) then return end
	end

	pos3 = { x = pos1.x+fdir_to_right[fdir+1][1], y = pos1.y+height, z = pos1.z+fdir_to_right[fdir+1][2] }
	node3 = minetest.get_node(pos3)
	def3 = minetest.registered_items[node3.name]
	if minetest.is_protected(pos3, player_name) or not (def3 and def3.buildable_to) then return end

	if def.topnodes ~= false then
		pos4 = { x = pos1.x+fdir_to_right[fdir+1][1], y = pos1.y+height-1, z = pos1.z+fdir_to_right[fdir+1][2] }
		node4 = minetest.get_node(pos4)
		def4 = minetest.registered_items[node4.name]
		if minetest.is_protected(pos4, player_name) or not (def4 and def4.buildable_to) then return end
	end

	local pos0 = { x = pos1.x, y = pos1.y-1, z = pos1.z }

	if controls.sneak and minetest.is_protected(pos1, player_name) then return end
	if distributor_node and minetest.is_protected(pos0, player_name) then return end

	if not creative.is_enabled_for(player_name) then
		local inv = placer:get_inventory()

		-- first, make sure the player has items in the inventory to build with

		-- if main_extends_base, then the base node is one of two pieces
		-- and the upper piece is not usually directly available to the player,
		-- as with streets:pole_[top|bottom] (the thin one)
		--
		-- if it's that sort of thing, there could be some waste here when the player digs a pole,
		-- if you use an odd number for the pole height along with main_extends_base

		local num_main = height + 1

		if poletop ~= pole and not def.main_extends_base then
			num_main = num_main - 1
			if not inv:contains_item("main", poletop) then
				minetest.chat_send_player(player_name, "*** You don't have any "..poletop.." in your inventory!")
				return
			end
		end

		if overhang ~= pole and not def.main_extends_base then
			num_main = num_main - 1
			if not inv:contains_item("main", overhang) then
				minetest.chat_send_player(player_name, "*** You don't have any "..overhang.." in your inventory!")
				return
			end
		end

		if base ~= pole then
			num_main = num_main - 1
			if def.main_extends_base then
				if not inv:contains_item("main", base.." "..math.floor(num_main/2)) then
					minetest.chat_send_player(player_name, "*** You don't have enough "..base.." in your inventory!")
					return
				end
			else
				if not inv:contains_item("main", base) then
					minetest.chat_send_player(player_name, "*** You don't have any "..base.." in your inventory!")
					return
				end

				if not inv:contains_item("main", pole.." "..num_main) then
					minetest.chat_send_player(player_name, "*** You don't have enough "..pole.." in your inventory!")
					return
				end
			end
		else
			if not inv:contains_item("main", pole.." "..num_main) then
				minetest.chat_send_player(player_name, "*** You don't have enough "..pole.." in your inventory!")
				return
			end
		end

		if not inv:contains_item("main", light) then
			minetest.chat_send_player(player_name, "*** You don't have any "..light.." in your inventory!")
			return
		end

		if needs_digiline_wire and not inv:contains_item("main", digiline_wire_node.." "..height + (has_top and 1 or 0)) then
			minetest.chat_send_player(player_name, "*** You don't have enough Digiline wires in your inventory!")
			return
		end

		if distributor_node and needs_digiline_wire then
			if not inv:contains_item("main", distributor_node) then
				minetest.chat_send_player(player_name, "*** You don't have any "..distributor_node.." in your inventory!")
				return
			else
				inv:remove_item("main", distributor_node)
			end
		end

		if controls.sneak then
			if not inv:contains_item("main", streetlights.concrete) then
				minetest.chat_send_player(player_name, "*** You don't have any concrete in your inventory!")
				return
			else
				inv:remove_item("main", streetlights.concrete)
			end
		end

		-- If we got this far, the player has everything, so now deduct items

		if poletop ~= pole and not def.main_extends_base then
			inv:remove_item("main", poletop)
		end

		if overhang ~= pole and not def.main_extends_base then
			inv:remove_item("main", overhang)
		end

		if base ~= pole then
			if def.main_extends_base then
				inv:remove_item("main", base.." "..math.floor(num_main/2))
			end
		else
			inv:remove_item("main", pole.." "..num_main)
		end

		inv:remove_item("main", light)

		if needs_digiline_wire then
			inv:remove_item("main", digiline_wire_node.." "..num_main)
		end

	end

	-- and place them in the world

	if controls.sneak then
		minetest.set_node(pos1, { name = streetlights.concrete })
	end

	local pole2 = pole

	if needs_digiline_wire then
		base = base.."_digilines"
		pole2 = pole.."_digilines"
		poletop = poletop.."_digilines"
		overhang = overhang.."_digilines"
	end

	local target_fdir

	if copy_pole_fdir == true then
		if def.node_rotation then
			target_fdir = minetest.dir_to_facedir(vector.rotate(target_dir, {x=0, y=def.node_rotation, z=0}))
		else
			target_fdir = fdir
		end

		if def.light_fdir == "auto" then -- the light should use the same fdir as the pole
			light_fdir = target_fdir
		end
	end

	local pos2b = {x=pos1.x, y = pos1.y+1, z=pos1.z}
	minetest.set_node(pos2b, {name = base, param2 = target_fdir })

	for i = 2, height-1 do
		pos2 = {x=pos1.x, y = pos1.y+i, z=pos1.z}
		minetest.set_node(pos2, {name = pole2, param2 = target_fdir })
	end

	local pos2t = {x=pos1.x, y = pos1.y+height, z=pos1.z}
	minetest.set_node(pos2t, {name = poletop, param2 = target_fdir  })

	if def.topnodes ~= false then
		minetest.set_node(pos3, { name = overhang })
		minetest.set_node(pos4, { name = light, param2 = light_fdir })
	else
		minetest.set_node(pos3, { name = light, param2 = light_fdir })
	end

	if needs_digiline_wire and ilights.player_channels[player_name] then
		minetest.get_meta(pos4):set_string("channel", ilights.player_channels[player_name])
	end

	if distributor_node and needs_digiline_wire then
		minetest.set_node(pos0, { name = distributor_node })
		digilines.update_autoconnect(pos0)
	end

end

minetest.register_privilege("streetlight", {
	description = "Allows using streetlight spawners",
	give_to_singleplayer = true
})
