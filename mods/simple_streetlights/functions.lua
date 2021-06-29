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

-- rotate around Y in order by fdir(+1)
-- x+xo, x+zo, z+xo, z+zo, CW degrees

local rot_y = {
	{  1,  0,  0,  1,   0 }, -- N
	{  0,  1, -1,  0,  90 }, -- E
	{ -1,  0,  0, -1, 180 }, -- S
	{  0, -1,  1,  0, 270 }, -- W
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

local function rotate_offset_around_y(origin, offs, fdir)
	local ox = offs.x
	local oz = offs.z
	local rx = rot_y[fdir+1][1] * ox + rot_y[fdir+1][2] * oz
	local rz = rot_y[fdir+1][3] * ox + rot_y[fdir+1][4] * oz
	return {x = origin.x + rx, y = origin.y, z = origin.z + rz}
end


local function can_build(target_pos, fdir, model_def, player_name, controls)

	if model_def.protection_box then

		local base_pos = {x=target_pos.x, y=target_pos.y+1, z=target_pos.z}

		local r1 = rotate_offset_around_y(base_pos, model_def.protection_box.omin, fdir)
		local r2 = rotate_offset_around_y(base_pos, model_def.protection_box.omax, fdir)

		local minp = {x=r1.x, y=r1.y + model_def.protection_box.omin.y, z=r1.z}
		local maxp = {x=r2.x, y=r2.y + model_def.protection_box.omax.y, z=r2.z}

		return not minetest.is_area_protected(minp, maxp, player_name, 1)
	else
		local main_node, node3, node4
		local main_def, def3, def4

		local main_pos, pos3, pos4
		for i = 1, model_def.height do
			main_pos = { x=target_pos.x, y = target_pos.y+i, z=target_pos.z }
			main_node = minetest.get_node(main_pos)
			main_def = minetest.registered_items[main_node.name]
			if minetest.is_protected(main_pos, player_name) or not (main_def and main_def.buildable_to) then return end
		end

		pos3 = {
			x = target_pos.x+fdir_to_right[fdir+1][1],
			y = target_pos.y+model_def.height,
			z = target_pos.z+fdir_to_right[fdir+1][2]
		}
		node3 = minetest.get_node(pos3)
		def3 = minetest.registered_items[node3.name]
		if minetest.is_protected(pos3, player_name) or not (def3 and def3.buildable_to) then return end

		if model_def.topnodes ~= false then
			pos4 = {
				x = target_pos.x+fdir_to_right[fdir+1][1],
				y = target_pos.y+model_def.height-1,
				z = target_pos.z+fdir_to_right[fdir+1][2]
			}
			node4 = minetest.get_node(pos4)
			def4 = minetest.registered_items[node4.name]
			if minetest.is_protected(pos4, player_name) or not (def4 and def4.buildable_to) then return end
		end

		local dist_pos = { x = target_pos.x, y = target_pos.y-1, z = target_pos.z }

		if controls.sneak and minetest.is_protected(target_pos, player_name) then return end
		if model_def.distributor_node and minetest.is_protected(dist_pos, player_name) then return end
		return true
	end
end

local function deduct_materials_schematic(model_def, inv, player_name, controls)
	for _,mat in ipairs(model_def.materials) do
		if not inv:contains_item("main", mat) then
			local matname = string.sub(mat, 1, string.find(mat, " "))
			minetest.chat_send_player(player_name, "*** You don't have enough "..matname.." in your inventory!")
			return
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

	for _,mat in ipairs(model_def.materials) do
		inv:remove_item("main", mat)
	end

end

local function deduct_materials_non_schematic(model_def, inv, player_name, controls)
	-- if main_extends_base, then the base node is one of two pieces
	-- and the upper piece is not usually directly available to the player,
	-- as with streets:pole_[top|bottom] (the thin one)
	--
	-- if it's that sort of thing, there could be some waste here when the player digs a pole,
	-- if you use an odd number for the pole height along with main_extends_base

	local num_main = model_def.height + 1

	if model_def.poletop ~= model_def.pole and not model_def.main_extends_base then
		num_main = num_main - 1
		if not inv:contains_item("main", model_def.poletop) then
			minetest.chat_send_player(player_name, "*** You don't have any "..model_def.poletop.." in your inventory!")
			return
		end
	end

	if model_def.overhang ~= model_def.pole and not model_def.main_extends_base then
		num_main = num_main - 1
		if not inv:contains_item("main", model_def.overhang) then
			minetest.chat_send_player(player_name, "*** You don't have any "..model_def.overhang.." in your inventory!")
			return
		end
	end

	if model_def.base ~= model_def.pole then
		num_main = num_main - 1
		if model_def.main_extends_base then
			if not inv:contains_item("main", model_def.base.." "..math.floor(num_main/2)) then
				minetest.chat_send_player(player_name, "*** You don't have enough "..model_def.base.." in your inventory!")
				return
			end
		else
			if not inv:contains_item("main", model_def.base) then
				minetest.chat_send_player(player_name, "*** You don't have any "..model_def.base.." in your inventory!")
				return
			end

			if not inv:contains_item("main", model_def.pole.." "..num_main) then
				minetest.chat_send_player(player_name, "*** You don't have enough "..model_def.pole.." in your inventory!")
				return
			end
		end
	else
		if not inv:contains_item("main", model_def.pole.." "..num_main) then
			minetest.chat_send_player(player_name, "*** You don't have enough "..model_def.pole.." in your inventory!")
			return
		end
	end

	if not inv:contains_item("main", model_def.light) then
		minetest.chat_send_player(player_name, "*** You don't have any "..model_def.light.." in your inventory!")
		return
	end

	if model_def.needs_digiline_wire and not inv:contains_item("main", model_def.digiline_wire_node.." "..model_def.height + (model_def.has_top and 1 or 0)) then
		minetest.chat_send_player(player_name, "*** You don't have enough Digiline wires in your inventory!")
		return
	end

	if model_def.distributor_node and model_def.needs_digiline_wire then
		if not inv:contains_item("main", model_def.distributor_node) then
			minetest.chat_send_player(player_name, "*** You don't have any "..model_def.distributor_node.." in your inventory!")
			return
		else
			inv:remove_item("main", model_def.distributor_node)
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

	-- if we made it this far, then the player has everything needed
	-- so deduct as appropriate

	if model_def.poletop ~= model_def.pole and not model_def.main_extends_base then
		inv:remove_item("main", model_def.poletop)
	end

	if model_def.overhang ~= pole and not model_def.main_extends_base then
		inv:remove_item("main", model_def.overhang)
	end

	if model_def.base ~= model_def.pole then
		if model_def.main_extends_base then
			inv:remove_item("main", model_def.base.." "..math.floor(num_main/2))
		end
	else
		inv:remove_item("main", model_def.pole.." "..num_main)
	end

	inv:remove_item("main", model_def.light)

	if model_def.needs_digiline_wire then
		inv:remove_item("main", model_def.digiline_wire_node.." "..num_main)
	end

	if model_def.distributor_node and model_def.needs_digiline_wire then
		inv:remove_item("main", model_def.distributor_node)
	end

	if controls.sneak then
		inv:remove_item("main", streetlights.concrete)
	end
end

local function build_streetlight(target_pos, target_node, target_dir, fdir, model_def, controls)

	if controls.sneak then
		minetest.set_node(target_pos, { name = streetlights.concrete })
	end

	if model_def.needs_digiline_wire then
		model_def.base = model_def.base.."_digilines"
		model_def.pole = model_def.pole.."_digilines"
		model_def.poletop = model_def.poletop.."_digilines"
		model_def.overhang = model_def.overhang.."_digilines"
	end

	local target_fdir

	if model_def.copy_pole_fdir == true then
		if model_def.node_rotation then
			target_fdir = minetest.dir_to_facedir(vector.rotate(target_dir, {x=0, y=model_def.node_rotation, z=0}))
		else
			target_fdir = fdir
		end

		if model_def.light_fdir == "auto" then -- the light should use the same fdir as the pole
			model_def.light_fdir = target_fdir
		end
	end

	local base_pos = {x=target_pos.x, y = target_pos.y+1, z=target_pos.z}
	minetest.set_node(base_pos, {name = model_def.base, param2 = target_fdir })

	for i = 2, model_def.height - 1 do
		local main_pos = {x=target_pos.x, y = target_pos.y+i, z=target_pos.z}
		minetest.set_node(main_pos, {name = model_def.pole, param2 = target_fdir })
	end

	local top_pos = {x=target_pos.x, y = target_pos.y+model_def.height, z=target_pos.z}
	minetest.set_node(top_pos, {name = model_def.poletop, param2 = target_fdir  })

	local pos2, pos3, pos4

	pos3 = {
		x = target_pos.x+fdir_to_right[fdir+1][1],
		y = target_pos.y+model_def.height,
		z = target_pos.z+fdir_to_right[fdir+1][2]
	}

	if model_def.topnodes ~= false then
		pos4 = {
			x = target_pos.x+fdir_to_right[fdir+1][1],
			y = target_pos.y+model_def.height-1,
			z = target_pos.z+fdir_to_right[fdir+1][2]
		}
		minetest.set_node(pos3, { name = model_def.overhang })
		minetest.set_node(pos4, { name = model_def.light, param2 = model_def.light_fdir })
	else
		minetest.set_node(pos3, { name = model_def.light, param2 = model_def.light_fdir })
	end

	if model_def.needs_digiline_wire and ilights.player_channels[player_name] then
		minetest.get_meta(pos4):set_string("channel", ilights.player_channels[player_name])
	end

	if model_def.distributor_node and model_def.needs_digiline_wire then
		local dist_pos = { x = target_pos.x, y = target_pos.y-1, z = target_pos.z }

		minetest.set_node(dist_pos, { name = model_def.distributor_node })
		digilines.update_autoconnect(dist_pos)
	end
end

function streetlights.check_and_place(itemstack, placer, pointed_thing, model_def)
	if not placer then return end

	model_def.base                = model_def.base or model_def.pole
	model_def.light               = model_def.light
	model_def.height              = model_def.height or 5
	model_def.needs_digiline_wire = model_def.needs_digiline_wire
	model_def.distributor_node    = model_def.distributor_node
	model_def.poletop             = (model_def.topnodes and (type(model_def.topnodes) == "table") and model_def.topnodes.poletop)  or model_def.pole
	model_def.overhang            = (model_def.topnodes and (type(model_def.topnodes) == "table") and model_def.topnodes.overhang) or model_def.pole
	model_def.copy_pole_fdir      = model_def.copy_pole_fdir
	model_def.light_fdir          = model_def.light_fdir

	local controls = placer:get_player_control()
	local player_name = placer:get_player_name()

	local placer_pos = placer:get_pos() -- this bit borrowed from builtin/game/item.lua
	local target_dir = vector.subtract(pointed_thing.above, placer_pos)
	local fdir = minetest.dir_to_facedir(target_dir)

	local target_pos = minetest.get_pointed_thing_position(pointed_thing)
	local target_node = minetest.get_node(target_pos)
	if not target_node or target_node.name == "ignore" then return end
	local target_def = minetest.registered_items[target_node.name]

	if (target_def and target_def.buildable_to) then
		target_pos.y = target_pos.y-1
	end

	local rc = streetlights.rightclick_pointed_thing(target_pos, placer, itemstack, pointed_thing)
	if rc then return rc end

	if not minetest.check_player_privs(placer, "streetlight") then
		minetest.chat_send_player(player_name, "*** You don't have permission to use a streetlight spawner.")
		return
	end

	if not can_build(target_pos, fdir, model_def, player_name, controls) then
		minetest.chat_send_player(player_name, "*** You can't build there, something's in the way or it's protected!")
		return
	end

	if not creative.is_enabled_for(player_name) then
		local inv = placer:get_inventory()

		if model_def.materials then
			deduct_materials_schematic(model_def, inv, player_name, controls)
		else
			deduct_materials_non_schematic(model_def, inv, player_name, controls)
		end
	end

	if model_def.schematic then

		local base_pos = {x=target_pos.x, y=target_pos.y+1, z=target_pos.z}

--		local offs = {
--			x = model_def.placement_offsets.x,
--			z = model_def.placement_offsets.z
--		}

--		local place_pos = rotate_offset_around_y(base_pos, offs, fdir)

		minetest.place_schematic(base_pos, model_def.schematic, rot_y[fdir+1][5], nil, false, {place_center_x=true, place_center_z=true})
	else
		build_streetlight(target_pos, target_node, target_dir, fdir, model_def, controls)
	end

end

minetest.register_privilege("streetlight", {
	description = "Allows using streetlight spawners",
	give_to_singleplayer = true
})
