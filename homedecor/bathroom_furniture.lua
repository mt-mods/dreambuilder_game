
local S = homedecor_i18n.gettext

local bathroom_tile_colors = {
	{ "1",       S("white/grey"),       "#c0c0c0:200" },
	{ "2",       S("white/dark grey"),  "#404040:150" },
	{ "3",       S("white/black"),      "#000000:200" },
	{ "4",       S("black/dark grey"),  ""            },
	{ "red",     S("white/red"),        "#d00000:150" },
	{ "green",   S("white/green"),      "#00d000:150" },
	{ "blue",    S("white/blue"),       "#0000d0:150" },
	{ "yellow",  S("white/yellow"),     "#ffff00:150" },
	{ "tan",     S("white/tan"),        "#ceaf42:150" }
}

for _, c in ipairs(bathroom_tile_colors) do
	local color, shade, hue = unpack(c)

	local coloredtile = "homedecor_bathroom_tiles_bg.png^(homedecor_bathroom_tiles_fg.png^[colorize:"..hue..")"

	if color == "4" then
		coloredtile = "(homedecor_bathroom_tiles_bg.png^[colorize:#000000:75)"..
					  "^(homedecor_bathroom_tiles_fg.png^[colorize:#000000:200)"
	end

	minetest.register_node("homedecor:tiles_"..color, {
		description = S("Bathroom/kitchen tiles (@1)", shade),
		tiles = {
			coloredtile,
			coloredtile,
			coloredtile,
			coloredtile,
			"("..coloredtile..")^[transformR90",
			"("..coloredtile..")^[transformR90"
		},
		groups = {cracky=3},
		paramtype = "light",
		sounds = default.node_sound_stone_defaults(),
	})
end

local tr_cbox = {
	type = "fixed",
	fixed = { -0.375, -0.3125, 0.25, 0.375, 0.375, 0.5 }
}

homedecor.register("towel_rod", {
	description = S("Towel rod with towel"),
	mesh = "homedecor_towel_rod.obj",
	tiles = {
		"homedecor_generic_terrycloth.png",
		"default_wood.png",
	},
	inventory_image = "homedecor_towel_rod_inv.png",
	selection_box = tr_cbox,
	walkable = false,
	groups = {snappy=2,choppy=2,oddly_breakable_by_hand=3,flammable=3},
	sounds = default.node_sound_defaults(),
})

homedecor.register("medicine_cabinet", {
	description = S("Medicine cabinet"),
	mesh = "homedecor_medicine_cabinet.obj",
	tiles = {
		'default_wood.png',
		'homedecor_medicine_cabinet_mirror.png'
	},
	inventory_image = "homedecor_medicine_cabinet_inv.png",
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.1875, 0.3125, 0.3125, 0.5, 0.5}
	},
	walkable = false,
	groups = { snappy = 3 },
	sounds = default.node_sound_wood_defaults(),
	on_punch = function(pos, node, puncher, pointed_thing)
		node.name = "homedecor:medicine_cabinet_open"
		minetest.swap_node(pos, node)
	end,
	infotext=S("Medicine cabinet"),
	inventory = {
		size=6,
	},
})

homedecor.register("medicine_cabinet_open", {
	mesh = "homedecor_medicine_cabinet_open.obj",
	tiles = {
		'default_wood.png',
		'homedecor_medicine_cabinet_mirror.png',
		'homedecor_medicine_cabinet_inside.png'
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.3125, -0.1875, -0.25, 0.3125, 0.5, 0.5}
	},
	walkable = false,
	groups = { snappy = 3, not_in_creative_inventory=1 },
	drop = "homedecor:medicine_cabinet",
	on_punch = function(pos, node, puncher, pointed_thing)
		node.name = "homedecor:medicine_cabinet"
		minetest.swap_node(pos, node)
	end,
})
