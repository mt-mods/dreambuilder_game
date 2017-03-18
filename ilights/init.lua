-- Industrial lights mod by DanDuncombe
-- License: CC-By-Sa
-- rewritten by VanessaE to use param2 colorization

ilights = {}

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end

if minetest.get_modpath("unified_inventory") or not minetest.setting_getbool("creative_mode") then
	ilights.expect_infinite_stacks = false
else
	ilights.expect_infinite_stacks = true
end

ilights.modpath = minetest.get_modpath("ilights")

-- The important stuff!

local lamp_cbox = {
	type = "wallmounted",
	wall_top =    { -11/32,  -4/16, -11/32, 11/32,  8/16, 11/32 },
	wall_bottom = { -11/32,  -8/16, -11/32, 11/32,  4/16, 11/32 },
	wall_side =   {  -8/16, -11/32, -11/32,  4/16, 11/32, 11/32 }
}

minetest.register_node("ilights:light", {
	description = "Industrial Light",
	drawtype = "mesh",
	mesh = "ilights_lamp.obj",
	tiles = {
		{ name = "ilights_lamp_base.png", color = 0xffffffff },
		{ name = "ilights_lamp_cage.png", color = 0xffffffff },
		"ilights_lamp_bulb.png",
		{ name = "ilights_lamp_bulb_base.png", color = 0xffffffff },
		"ilights_lamp_lens.png"
	},
	use_texture_alpha = true,
	groups = {cracky=3, ud_param2_colorable = 1},
	paramtype = "light",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	light_source = 14,
	selection_box = lamp_cbox,
	node_box = lamp_cbox,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		unifieddyes.recolor_on_place(pos, placer, itemstack, pointed_thing)
	end,
	after_dig_node = unifieddyes.after_dig_node
})

minetest.register_craft({
	output = "ilights:light 3",
	recipe = {
		{ "",                     "default:steel_ingot",  "" },
		{ "",                     "default:glass",        "" },
		{ "default:steel_ingot",  "default:torch",        "default:steel_ingot" }
	},
})

-- convert old static nodes to param2 coloring

ilights.colors = {
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
	"brown"
}

ilights.old_static_nodes = {}

for _, i in ipairs (ilights.colors) do
	table.insert(ilights.old_static_nodes, "ilights:light_"..i)
end

minetest.register_lbm({
	name = "ilights:convert",
	label = "Convert ilights static nodes to use param2 color",
	run_at_every_load = false,
	nodenames = ilights.old_static_nodes,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_") + 1)
		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local old_fdir = math.floor(node.param2 / 4)
		local param2

		if old_fdir == 5 then
			new_fdir = 0
		elseif old_fdir == 1 then
			new_fdir = 5
		elseif old_fdir == 2 then
			new_fdir = 4
		elseif old_fdir == 3 then
			new_fdir = 3
		elseif old_fdir == 4 then
			new_fdir = 2
		elseif old_fdir == 0 then
			new_fdir = 1
		end
		param2 = paletteidx + new_fdir

		minetest.set_node(pos, { name = "ilights:light", param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
	end
})
