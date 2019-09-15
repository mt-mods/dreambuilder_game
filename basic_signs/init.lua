-- Basic wall/yard/metal signs
-- these were originally part of signs_lib

basic_signs = {}
basic_signs.path = minetest.get_modpath(minetest.get_current_modname())

dofile(basic_signs.path .. "/crafting.lua")

local S, NS = dofile(basic_signs.path .. "/intllib.lua")
basic_signs.gettext = S

function basic_signs.check_for_floor(pointed_thing)
	if pointed_thing.above.x == pointed_thing.under.x
		  and pointed_thing.above.z == pointed_thing.under.z
		  and pointed_thing.above.y > pointed_thing.under.y then
		return true
	end
end

function basic_signs.determine_sign_type(pos, placer, itemstack, pointed_thing)

	local playername = placer:get_player_name()
	local pt_name = minetest.get_node(pointed_thing.under).name
	local node = minetest.get_node(pos)  -- since we're in after-place, this will be the wall sign itself

	if minetest.is_protected(pointed_thing.under, playername) then
		minetest.record_protection_violation(pointed_thing.under, playername)
		return itemstack
	end

	local newparam2 = minetest.dir_to_facedir(placer:get_look_dir())

	if minetest.registered_nodes[pt_name] and
	   minetest.registered_nodes[pt_name].on_rightclick and
	   not placer:get_player_control().sneak then
		return minetest.registered_nodes[pt_name].on_rightclick(pos, node, placer, itemstack, pointed_thing)
	elseif signs_lib.check_for_pole(pos, pointed_thing) then
		minetest.swap_node(pos, {name = "default:sign_wall_wood_onpole",  param2 = node.param2})
	elseif signs_lib.check_for_ceiling(pointed_thing) then
		minetest.swap_node(pos, {name = "default:sign_wall_wood_hanging", param2 = newparam2})
	elseif basic_signs.check_for_floor(pointed_thing) then
		minetest.swap_node(pos, {name = "basic_signs:yard_sign",              param2 = newparam2})
	end
	signs_lib.update_sign(pos)

	if not creative.is_enabled_for(playername) then
		itemstack:take_item()
	end
	return itemstack
end

local def

local wgroups = table.copy(signs_lib.standard_wood_groups)
wgroups.not_in_creative_inventory = 1

local sgroups = table.copy(signs_lib.standard_steel_groups)
sgroups.not_in_creative_inventory = 1

minetest.override_item("default:sign_wall_wood", {
	after_place_node = basic_signs.determine_sign_type
})

signs_lib.register_sign("basic_signs:sign_wall_locked", {
	description = S("Locked Sign"),
	tiles = {
		"basic_signs_sign_wall_locked.png",
		"signs_lib_sign_wall_steel_edges.png",
	},
	inventory_image = "basic_signs_sign_wall_locked_inv.png",
	locked = true,
	entity_info = "standard",
	allow_hanging = true,
	allow_widefont = true
})

minetest.register_alias("locked_sign:sign_wall_locked", "basic_signs:sign_wall_locked")


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

local cbox = signs_lib.make_selection_boxes(35, 25, true, 0, 0, 0, true)

for i, color in ipairs(sign_colors) do
	signs_lib.register_sign("basic_signs:sign_wall_steel_"..color[1], {
		description = S("Sign (@1, steel)", color[2]),
		paramtype2 = "facedir",
		selection_box = cbox,
		mesh = "signs_lib_standard_wall_sign_facedir.obj",
		tiles = {
			"basic_signs_steel_"..color[1]..".png",
			"signs_lib_sign_wall_steel_edges.png",
		},
		inventory_image = "basic_signs_steel_"..color[1].."_inv.png",
		groups = signs_lib.standard_steel_groups,
		sounds = signs_lib.standard_steel_sign_sounds,
		default_color = color[3],
		entity_info = {
			mesh = "signs_lib_standard_wall_sign_entity.obj",
			yaw = signs_lib.standard_yaw
		},
		allow_hanging = true,
		allow_widefont = true
	})

	table.insert(signs_lib.lbm_restore_nodes, "signs:sign_wall_"..color[1])
	minetest.register_alias("signs:sign_wall_"..color[1], "basic_signs:sign_wall_steel_"..color[1])
end

signs_lib.register_sign("basic_signs:yard_sign", {
	description = "Wooden yard sign",
	paramtype2 = "facedir",
	selection_box = signs_lib.make_selection_boxes(35, 34.5, false, 0, -1.25, -19.69, true),
	mesh = "basic_signs_yard_sign.obj",
	tiles = {
		"signs_lib_sign_wall_wooden.png",
		"signs_lib_sign_wall_wooden_edges.png",
		"default_wood.png"
	},
	inventory_image = "default_sign_wood.png",
	entity_info = {
		mesh = "basic_signs_yard_sign_entity.obj",
		yaw = signs_lib.standard_yaw
	},
	groups = wgroups,
	drop = "default:sign_wall_wood",
	allow_onpole = false,
	allow_widefont = true
})

table.insert(signs_lib.lbm_restore_nodes, "signs:sign_yard")
minetest.register_alias("signs:sign_yard", "basic_signs:yard_sign")
