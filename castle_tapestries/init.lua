-- Used for localization, choose either built-in or intllib.
local S = minetest.get_translator("castle_tapestries")

-- cottages support
local use_cottages = minetest.get_modpath("cottages")

local tapestry = {}

minetest.register_alias("castle:tapestry_top", "castle_tapestries:tapestry_top")
minetest.register_alias("castle:tapestry", "castle_tapestries:tapestry")
minetest.register_alias("castle:tapestry_long", "castle_tapestries:tapestry_long")
minetest.register_alias("castle:tapestry_very_long", "castle_tapestries:tapestry_very_long")

minetest.register_node("castle_tapestries:tapestry_top", {
	drawtype = "nodebox",
	description = S("Tapestry Top"),
	tiles = {"default_wood.png"},
	sunlight_propagates = true,
	groups = {flammable=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.6,-0.5,0.375,0.6,-0.375,0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.6,-0.5,0.375,0.6,-0.375,0.5},
		},
	},
})

minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry_top',
	recipe = {'default:stick'},
})

tapestry.colours = {
	"white",
	"grey",
	"black",
	"red",
	"yellow",
	"green",
	"cyan",
	"blue",
	"magenta",
	"orange",
	"violet",
	"dark_grey",
	"dark_green",
	"pink",
	"brown",
}

-- Regular-length tapestry

minetest.register_node("castle_tapestries:tapestry", {
	drawtype = "mesh",
	mesh = "castle_tapestry.obj",
	description = S("Tapestry"),
	tiles = {"castle_tapestry.png"},
	inventory_image = "castle_tapestry_inv.png",
	groups = {oddly_breakable_by_hand=3,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5,-0.5,0.4375,0.5,1.5,0.5},
	},
	after_place_node = unifieddyes.fix_rotation_nsew,
	on_dig = unifieddyes.on_dig,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew
})

-- Long tapestry

minetest.register_node("castle_tapestries:tapestry_long", {
	drawtype = "mesh",
	mesh = "castle_tapestry_long.obj",
	description = S("Tapestry (Long)"),
	tiles = {"castle_tapestry.png"},
	inventory_image = "castle_tapestry_long_inv.png",
	groups = {oddly_breakable_by_hand=3,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5,-0.5,0.4375,0.5,2.5,0.5},
	},
	after_place_node = unifieddyes.fix_rotation_nsew,
	on_dig = unifieddyes.on_dig,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew
})

-- Very long tapestry

minetest.register_node("castle_tapestries:tapestry_very_long", {
	drawtype = "mesh",
	mesh = "castle_tapestry_very_long.obj",
	description = S("Tapestry (Very Long)"),
	tiles = {"castle_tapestry.png"},
	inventory_image = "castle_tapestry_very_long_inv.png",
	groups = {oddly_breakable_by_hand=3,flammable=3, ud_param2_colorable = 1},
	sounds = default.node_sound_defaults(),
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = {
		type = "wallmounted",
		wall_side = {-0.5,-0.5,0.4375,0.5,3.5,0.5},
	},
	after_place_node = unifieddyes.fix_rotation_nsew,
	on_dig = unifieddyes.on_dig,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew
})

-- Crafting

minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry',
	recipe = {'wool:white', 'default:stick'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry_long',
	recipe = {'wool:white', 'castle_tapestries:tapestry'},
})

minetest.register_craft({
	type = "shapeless",
	output = 'castle_tapestries:tapestry_very_long',
	recipe = {'wool:white', 'castle_tapestries:tapestry_long'},
})

if use_cottages then
	minetest.register_craft({
		type = "shapeless",
		output = 'castle_tapestries:tapestry',
		recipe = {'cottages:wool', 'default:stick'},
	})


	minetest.register_craft({
		type = "shapeless",
		output = 'castle_tapestries:tapestry_long',
		recipe = {'cottages:wool', 'castle_tapestries:tapestry'},
	})
	minetest.register_craft({
		type = "shapeless",
		output = 'castle_tapestries:tapestry_very_long',
		recipe = {'cottages:wool', 'castle_tapestries:tapestry_long'},
	})
end


unifieddyes.register_color_craft({
	output = "castle_tapestries:tapestry",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "castle_tapestries:tapestry",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE",
	}
})

unifieddyes.register_color_craft({
	output = "castle_tapestries:tapestry_long",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "castle_tapestries:tapestry_long",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE",
	}
})

unifieddyes.register_color_craft({
	output = "castle_tapestries:tapestry_very_long",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "castle_tapestries:tapestry_very_long",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE",
	}
})

-- Convert static tapestries to param2 color

local old_static_tapestries = {}

for _, color in ipairs(tapestry.colours) do
	table.insert(old_static_tapestries, "castle:tapestry_"..color)
	table.insert(old_static_tapestries, "castle:long_tapestry_"..color)
	table.insert(old_static_tapestries, "castle:very_long_tapestry_"..color)
end

minetest.register_lbm({
	name = "castle_tapestries:convert_tapestries",
	label = "Convert tapestries to use param2 color",
	run_at_every_load = false,
	nodenames = old_static_tapestries,
	action = function(pos, node)
		local oldname = node.name
		local color = string.sub(oldname, string.find(oldname, "_", -12) + 1)

		if color == "red" then
			color = "medium_red"
		elseif color == "cyan" then
			color = "medium_cyan"
		elseif color == "blue" then
			color = "medium_blue"
		elseif color == "magenta" then
			color = "medium_magenta"
		end

		local paletteidx, _ = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")

		local old_fdir = math.floor(node.param2 % 32)
		local new_fdir = 3

		if old_fdir == 0 then
			new_fdir = 3
		elseif old_fdir == 1 then
			new_fdir = 4
		elseif old_fdir == 2 then
			new_fdir = 2
		elseif old_fdir == 3 then
			new_fdir = 5
		end

		local param2 = paletteidx + new_fdir
		local newname = "castle_tapestries:tapestry"
		if string.find(oldname, ":long") then
			newname = "castle_tapestries:tapestry_long"
		elseif string.find(oldname, ":very_long") then
			newname = "castle_tapestries:tapestry_very_long"
		end

		minetest.set_node(pos, { name = newname, param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
	end
})
