-- Industrial lights mod by DanDuncombe
-- License: CC-By-Sa

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

ilights.types = {
	{"white",		"White",		"#ffffff" },
	{"grey",		"Grey",			"#a0a0a0" },
	{"black",		"Black",		"#000000" },
	{"red",			"Red",			"#ff0000" },
	{"yellow",		"Yellow",		"#ffff00" },
	{"green",		"Green",		"#00ff00" },
	{"cyan",		"Cyan",			"#00ffff" },
	{"blue",		"Blue",			"#0000ff" },
	{"magenta",		"Magenta",		"#ff00ff" },
	{"orange",		"Orange",		"#ff8000" },
	{"violet",		"Violet",		"#8000ff" },
	{"dark_grey",	"Dark Grey",	"#404040" },
	{"dark_green",	"Dark Green",	"#008000" },
	{"pink",		"Pink",			"#ffb0ff" },
	{"brown",		"Brown",		"#604000" },
}

local lamp_cbox = {
	type = "fixed",
	fixed = { -11/32, -8/16, -11/32, 11/32, 4/16, 11/32 }
}

for _, row in ipairs(ilights.types) do
	local name =     row[1]
	local desc =     row[2]
	local colordef = row[3]

	-- Node Definition

	minetest.register_node("ilights:light_"..name, {
		description = desc.." Industrial Light",
	    drawtype = "mesh",
		mesh = "ilights_lamp.obj",
		tiles = {
			"ilights_lamp_base.png",
			"ilights_lamp_cage.png",
			"ilights_lamp_bulb.png^[colorize:"..colordef..":200",
			"ilights_lamp_bulb_base.png",
			"ilights_lamp_lens.png^[colorize:"..colordef.."20:75"
		},
		use_texture_alpha = true,
		groups = {cracky=3},
	    paramtype = "light",
	    paramtype2 = "facedir",
	    light_source = 15,
		selection_box = lamp_cbox,
		collision_box = lamp_cbox,
		on_place = minetest.rotate_node
	})

	if name then

		--Choose craft material
		minetest.register_craft({
			output = "ilights:light_"..name.." 3",
			recipe = {
				{ "",                     "default:steel_ingot",  "" },
				{ "dye:"..name,           "default:glass",        "dye:"..name },
				{ "default:steel_ingot",  "default:torch",        "default:steel_ingot" }
			},
		})

	end
end

