-- Basic wall/yard/metal signs
-- these were originally part of signs_lib

basic_signs = {}
basic_signs.path = minetest.get_modpath(minetest.get_current_modname())

dofile(basic_signs.path .. "/crafting.lua")

local S, NS = dofile(basic_signs.path .. "/intllib.lua")
basic_signs.gettext = S

local cbox

-- array : color, translated color, default text color
local sign_colors = {
	{"green",        S("green"),       "f"},
	{"yellow",       S("yellow"),      "0"},
	{"red",          S("red"),         "f"},
	{"white_red",    S("white_red"),   "4"},
	{"white_black",  S("white_black"), "0"},
	{"orange",       S("orange"),      "0"},
	{"blue",         S("blue"),        "f"},
	{"brown",        S("brown"),       "f"},
}

function basic_signs.determine_sign_type(pos, placer, itemstack, pointed_thing)
	local playername = placer:get_player_name()
	local pt_name = minetest.get_node(pointed_thing.under).name
	local node = minetest.get_node(pos)  -- since we're in after-place, this will be the wall sign itself

	if minetest.is_protected(pointed_thing.under, playername) then
		minetest.record_protection_violation(pointed_thing.under, playername)
		return itemstack
	end

	if minetest.registered_nodes[pt_name] and
	   minetest.registered_nodes[pt_name].on_rightclick and
	   not placer:get_player_control().sneak then
		return minetest.registered_nodes[pt_name].on_rightclick(pos, node, placer, itemstack, pointed_thing)
	elseif signs_lib.check_for_pole(pos, pointed_thing) then
		minetest.swap_node(pos, {name = "default:sign_wall_wood_onpole", param2 = node.param2})
	else
		local lookdir = placer:get_look_dir()
		print(dump(lookdir))
		local newparam2 = minetest.dir_to_facedir(lookdir)

		if node.param2 == 0 then
			minetest.swap_node(pos, {name = "basic_signs:hanging_sign",  param2 = newparam2})
		elseif node.param2 == 1 then
			minetest.swap_node(pos, {name = "basic_signs:yard_sign",     param2 = newparam2})
		end
		signs_lib.update_sign(pos)
	end
	if not creative.is_enabled_for(playername) then
		itemstack:take_item()
	end
	return itemstack
end

for _, onpole in ipairs({"", "_onpole"}) do

	local nci = nil
	local on_rotate = signs_lib.wallmounted_rotate
	local pole_mount_tex = nil

	if onpole == "_onpole" then
		nci = 1
		on_rotate = nil
		pole_mount_tex = "signs_lib_pole_mount.png" -- the metal straps on back, if needed
	end

	local wood_groups =  table.copy(signs_lib.standard_wood_groups)
	wood_groups.not_in_creative_inventory = nci
	local steel_groups =  table.copy(signs_lib.standard_steel_groups)
	steel_groups.not_in_creative_inventory = nci

	cbox = signs_lib.make_selection_boxes(35, 25, onpole)

	minetest.override_item("default:sign_wall_wood"..onpole, {
		after_place_node = basic_signs.determine_sign_type
	})

	minetest.register_node("basic_signs:sign_wall_locked"..onpole, {
		description = S("Locked Sign"),
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "signs_lib_standard_wall_sign"..onpole..".obj",
		tiles = {
			"basic_signs_sign_wall_locked.png",
			"signs_lib_sign_wall_steel_edges.png",
			pole_mount_tex
		},
		inventory_image = "basic_signs_sign_wall_locked_inv.png",
		wield_image = "basic_signs_sign_wall_locked_inv.png",
		groups = wood_groups,
		default_color = "0",
		on_construct = signs_lib.construct_sign,
		on_destruct = signs_lib.destruct_sign,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			signs_lib.after_place_node(pos, placer, itemstack, pointed_thing, true)
		end,
		on_receive_fields = signs_lib.receive_fields,
		on_punch = signs_lib.update_sign,
		can_dig = signs_lib.can_modify,
		on_rotate = on_rotate,
		number_of_lines = signs_lib.standard_lines,
		horiz_scaling = signs_lib.standard_hscale,
		vert_scaling = signs_lib.standard_vscale,
		line_spacing = signs_lib.standard_lspace,
		font_size = signs_lib.standard_fsize,
		x_offset = signs_lib.standard_xoffs,
		y_offset = signs_lib.standard_yoffs,
		chars_per_line = signs_lib.standard_cpl,
		entity_info = {
			mesh = "signs_lib_standard_wall_sign_entity"..onpole..".obj",
			yaw = signs_lib.wallmounted_yaw
		},
		drop = "basic_signs:sign_wall_locked"
	})
	table.insert(signs_lib.lbm_restore_nodes, "basic_signs:sign_wall_locked"..onpole)
	table.insert(signs_lib.lbm_restore_nodes, "locked_sign:sign_wall_locked"..onpole)

	minetest.register_alias("locked_sign:sign_wall_locked", "basic_signs:sign_wall_locked")

	cbox = signs_lib.make_selection_boxes(35, 25, onpole, 0, 0, 0, true)

	for i, color in ipairs(sign_colors) do
		minetest.register_node("basic_signs:sign_wall_steel_"..color[1]..onpole, {
			description = S("Sign (@1, steel)", color[2]),
			paramtype = "light",
			sunlight_propagates = true,
			paramtype2 = "facedir",
			drawtype = "mesh",
			node_box = cbox,
			selection_box = cbox,
			mesh = "signs_lib_standard_wall_sign_facedir"..onpole..".obj",
			tiles = {
				"basic_signs_steel_"..color[1]..".png",
				"signs_lib_sign_wall_steel_edges.png",
				pole_mount_tex
			},
			inventory_image = "basic_signs_steel_"..color[1].."_inv.png",
			wield_image = "basic_signs_steel_"..color[1].."_inv.png",
			groups = steel_groups,
			default_color = color[3],
			on_construct = signs_lib.construct_sign,
			on_destruct = signs_lib.destruct_sign,
			after_place_node = signs_lib.after_place_node,
			on_receive_fields = signs_lib.receive_fields,
			on_punch = signs_lib.update_sign,
			on_rotate = on_rotate,
			number_of_lines = signs_lib.standard_lines,
			horiz_scaling = signs_lib.standard_hscale,
			vert_scaling = signs_lib.standard_vscale,
			line_spacing = signs_lib.standard_lspace,
			font_size = signs_lib.standard_fsize,
			x_offset = signs_lib.standard_xoffs,
			y_offset = signs_lib.standard_yoffs,
			chars_per_line = signs_lib.standard_cpl,
			entity_info = {
				mesh = "signs_lib_standard_wall_sign_entity"..onpole..".obj",
				yaw = signs_lib.standard_yaw
			},
			drop = "signs:sign_wall_steel_"..color[1]
		})
		table.insert(signs_lib.lbm_restore_nodes, "basic_signs:sign_wall_steel_"..color[1]..onpole)
		table.insert(signs_lib.lbm_restore_nodes, "signs:sign_wall_"..color[1]..onpole)

		minetest.register_alias("signs:sign_wall_"..color[1], "basic_signs:sign_wall_steel_"..color[1])

	end
end

cbox = signs_lib.make_selection_boxes(35, 34.5, false, 0, -1.25, -19.69, true)

local nci_wood_groups = table.copy(signs_lib.standard_wood_groups)
nci_wood_groups.not_in_creative_inventory = 1

minetest.register_node("basic_signs:yard_sign", {
	description = "Wooden yard sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "basic_signs_yard_sign.obj",
	tiles = {
		"signs_lib_sign_wall_wooden.png",
		"signs_lib_sign_wall_wooden_edges.png",
		"default_wood.png"
	},
	inventory_image = "default_sign_wood.png",
	wield_image = "default_sign_wood.png",
	groups = nci_wood_groups,
	default_color = "0",
	on_construct = signs_lib.construct_sign,
	on_destruct = signs_lib.destruct_sign,
	after_place_node = signs_lib.after_place_node,
	on_receive_fields = signs_lib.receive_fields,
	on_punch = signs_lib.update_sign,
	on_rotate = on_rotate,
	number_of_lines = signs_lib.standard_lines,
	horiz_scaling = signs_lib.standard_hscale,
	vert_scaling = signs_lib.standard_vscale,
	line_spacing = signs_lib.standard_lspace,
	font_size = signs_lib.standard_fsize,
	x_offset = signs_lib.standard_xoffs,
	y_offset = signs_lib.standard_yoffs,
	chars_per_line = signs_lib.standard_cpl,
	entity_info = {
		mesh = "basic_signs_yard_sign_entity.obj",
		yaw = signs_lib.standard_yaw
	},
	drop = "default:sign_wall_wood"
})
table.insert(signs_lib.lbm_restore_nodes, "basic_signs:yard_sign")
table.insert(signs_lib.lbm_restore_nodes, "signs:sign_yard")
minetest.register_alias("signs:sign_yard", "basic_signs:yard_sign")

cbox = signs_lib.make_selection_boxes(35, 32, false, 0, 3, -18.5, true)

minetest.register_node("basic_signs:hanging_sign", {
	description = "Wooden sign, hanging",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "basic_signs_hanging_sign.obj",
	tiles = {
		"signs_lib_sign_wall_wooden.png",
		"signs_lib_sign_wall_wooden_edges.png",
		"basic_signs_ceiling_hangers.png"
	},
	inventory_image = "default_sign_wood.png",
	wield_image = "default_sign_wood.png",
	groups = nci_wood_groups,
	default_color = "0",
	on_construct = signs_lib.construct_sign,
	on_destruct = signs_lib.destruct_sign,
	after_place_node = signs_lib.after_place_node,
	on_receive_fields = signs_lib.receive_fields,
	on_punch = signs_lib.update_sign,
	on_rotate = on_rotate,
	number_of_lines = signs_lib.standard_lines,
	horiz_scaling = signs_lib.standard_hscale,
	vert_scaling = signs_lib.standard_vscale,
	line_spacing = signs_lib.standard_lspace,
	font_size = signs_lib.standard_fsize,
	x_offset = signs_lib.standard_xoffs,
	y_offset = signs_lib.standard_yoffs,
	chars_per_line = signs_lib.standard_cpl,
	entity_info = {
		mesh = "basic_signs_hanging_sign_entity.obj",
		yaw = signs_lib.standard_yaw
	},
	drop = "default:sign_wall_wood"
})
table.insert(signs_lib.lbm_restore_nodes, "basic_signs:hanging_sign")
table.insert(signs_lib.lbm_restore_nodes, "signs:sign_hanging")
minetest.register_alias("signs:sign_hanging", "basic_signs:hanging_sign")

-- insert the old wood sign-on-fencepost into signs_lib's conversion LBM

table.insert(signs_lib.old_fenceposts_with_signs, "signs:sign_post")
signs_lib.old_fenceposts["signs:sign_post"] = "default:fence_wood"
signs_lib.old_fenceposts_replacement_signs["signs:sign_post"] = "default:sign_wall_wood_onpole"
