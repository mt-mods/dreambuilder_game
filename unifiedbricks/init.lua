--Unified Bricks by Vsevolod Borislav (wowiamdiamonds)
--
--License: WTFPL
--
--Depends: default, bucket, unifieddyes, vessels
--
--Obviously, offers the same colors in unifieddyes.
--Thanks go to VanessaE for making unifieddyes, gentextures.sh, etc.

unifiedbricks = {}
unifiedbricks.old_static_list = {}
unifiedbricks.old_static_list_formals = {}

minetest.register_alias("unifieddyes:white","unifieddyes:white_paint")
minetest.register_alias("unifieddyes:lightgrey","unifieddyes:lightgrey_paint")
minetest.register_alias("unifieddyes:grey","unifieddyes:grey_paint")
minetest.register_alias("unifieddyes:darkgrey","unifieddyes:darkgrey_paint")

HUES = {
	"red",
	"orange",
	"yellow",
	"lime",
	"green",
	"aqua",
	"cyan",
	"skyblue",
	"blue",
	"violet",
	"magenta",
	"redviolet",
	"black",
	"darkgrey",
	"grey",
	"lightgrey",
	"white"
}
TYPES = {
	"clayblock_",
	"clay_",
	"brick_",
	"brickblock_",
	"multicolor_"
}
SATURATION = {
	"_s50",
	""
}
DARKNESS = {
	"dark_",
	"medium_",
	"",
	"light_"
}
--formal versions
FORMALHUES = {
	"Red",
	"Orange",
	"Yellow",
	"Lime",
	"Green",
	"Aqua",
	"Cyan",
	"Sky blue",
	"Blue",
	"Violet",
	"Magenta",
	"Red violet",
	"Black",
	"Dark grey",
	"Grey",
	"Light grey",
	"White"
}
FORMALTYPES = {
	" clay",
	" clay lump",
	" brick",
	" bricks",
	" multicolor bricks"
}
FORMALSATURATION = {
	" (low saturation)",
	""
}
FORMALDARKNESS = {
	"Dark ",
	"Medium ",
	"Bright ",
	"Light "
}

-- param2-coloring-enabled nodes

minetest.register_node("unifiedbricks:brickblock", {
	description = "Brick Block",
	tiles = {
		"unifiedbricks_brickblock.png",
		{ name = "unifiedbricks_mortar.png", color = 0xffffffff },
	},
	drawtype = "mesh",
	mesh = "unifiedbricks_brick_block.obj",
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	is_ground_content = true,
	groups = {cracky=3, not_in_creative_inventory=1, ud_param2_colorable = 1},
	sounds = default.node_sound_stone_defaults(),
	after_dig_node = unifieddyes.after_dig_node,
	drop = "default:brick"
})

minetest.override_item("default:brick", {
	ud_replacement_node = "unifiedbricks:brickblock",
	groups = {cracky = 3, ud_param2_colorable = 1}
})

minetest.register_node("unifiedbricks:clayblock", {
	description = "Clay Block",
	tiles = {
		"unifiedbricks_clayblock.png",
	},
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette.png",
	is_ground_content = true,
	groups = {crumbly=3, not_in_creative_inventory=1, ud_param2_colorable = 1},
		sounds = default.node_sound_dirt_defaults({
			footstep = "",
		}),
	after_dig_node = unifieddyes.after_dig_node,
	drop = "default:clay"
})

minetest.override_item("default:clay", {
	ud_replacement_node = "unifiedbricks:clayblock",
	groups = {crumbly = 3, ud_param2_colorable = 1}
})


-- static nodes

unifiedbricks.register_old_static_block = function(name, formalname, blocktype)
	table.insert(unifiedbricks.old_static_list, "unifiedbricks:"..blocktype.."_"..name)
	table.insert(unifiedbricks.old_static_list_formals, formalname)
end

unifiedbricks.register_multicolor = function(name, formalname, drop_one, drop_two, drop_three)
	minetest.register_node("unifiedbricks:" .. TYPES[5] .. name, {
		description = formalname .. FORMALTYPES[5],
		tiles = {"unifiedbricks_" .. TYPES[5] .. name .. ".png"},
		is_ground_content = true,
		groups = {cracky=3},
		drop = {
			max_items = 4,
			items = {
				items = {
					{ "default:brick",
					"unifieddyes:"..drop_one,
					"unifieddyes:"..drop_two,
					"unifieddyes:"..drop_three,
					rarity = 1 }
				}
			}
		},
		sounds = default.node_sound_stone_defaults(),
	})
end

unifiedbricks.register_multicolor_craft = function(name, dye_one, dye_two, dye_three)
	minetest.register_craft( {
	   type = "shapeless",
	   output = "unifiedbricks:multicolor_" .. name,
	   recipe = {
			"default:brick",
			"unifieddyes:"..dye_one,
			"unifieddyes:"..dye_two,
			"unifieddyes:"..dye_three
		},
	})
end

--REGISTERS ALL STATIC NODES EXCEPT MULTICOLOR BRICK BLOCKS
for i = 1,17 do
	for j = 1,4 do
		if i > 12 then
			formalname = FORMALHUES[i]
			name = HUES[i]
			if j == 1 then
				unifiedbricks.register_old_static_block(name, formalname, "clayblock")
			elseif j == 4 then
				unifiedbricks.register_old_static_block(name, formalname, "brickblock")
			end
		else
			for k = 1,4 do
				if k == 4 then
					formalname = FORMALDARKNESS[k] .. FORMALHUES[i]
					name = DARKNESS[k] .. HUES[i]
					if j == 1 then
						unifiedbricks.register_old_static_block(name, formalname, "clayblock")
					elseif j == 4 then
						unifiedbricks.register_old_static_block(name, formalname, "brickblock")
					end
				else
					for l = 1,2 do
						formalname = FORMALDARKNESS[k] .. FORMALHUES[i] .. FORMALSATURATION[l]
						name = DARKNESS[k] .. HUES[i] .. SATURATION[l]
						if j == 1 then
							unifiedbricks.register_old_static_block(name, formalname, "clayblock")
						elseif j == 4 then
							unifiedbricks.register_old_static_block(name, formalname, "brickblock")
						end
					end
				end
			end
		end
	end
end

--REGISTERS ALL MULTICOLOR EVERYTHING
for i = 1,13 do
	if i == 13 then
		name = HUES[14]
		formalname = FORMALHUES[14]
		brick_one = HUES[14]
		brick_two = HUES[15]
		brick_three = HUES[16]
		unifiedbricks.register_multicolor(name, formalname, brick_one, brick_two, brick_three)
		unifiedbricks.register_multicolor_craft(name, brick_one, brick_two, brick_three)

		name = HUES[15]
		formalname = FORMALHUES[15]
		brick_one = HUES[15]
		brick_two = HUES[14]
		brick_three = HUES[16]
		unifiedbricks.register_multicolor(name, formalname, brick_one, brick_two, brick_three)
		unifiedbricks.register_multicolor_craft(name, brick_one, brick_two, brick_three)

		name = HUES[16]
		formalname = FORMALHUES[16]
		brick_one = HUES[16]
		brick_two = HUES[14]
		brick_three = HUES[15]
		unifiedbricks.register_multicolor(name, formalname, brick_one, brick_two, brick_three)
		unifiedbricks.register_multicolor_craft(name, brick_one, brick_two, brick_three)
	else
		name = DARKNESS[1] .. HUES[i]
		formalname = FORMALDARKNESS[1] .. FORMALHUES[i]
		brick_one = DARKNESS[1] .. HUES[i]
		brick_two = DARKNESS[2] .. HUES[i]
		brick_three = DARKNESS[2] .. HUES[i] .. SATURATION[1]
		unifiedbricks.register_multicolor(name, formalname, brick_one, brick_two, brick_three)
		unifiedbricks.register_multicolor_craft(name, brick_one, brick_two, brick_three)

		name = DARKNESS[2] .. HUES[i]
		formalname = FORMALDARKNESS[2] .. FORMALHUES[i]
		brick_one = DARKNESS[2] .. HUES[i]
		brick_two = DARKNESS[1] .. HUES[i]
		brick_three = DARKNESS[3] .. HUES[i] .. SATURATION[1]
		unifiedbricks.register_multicolor(name, formalname, brick_one, brick_two, brick_three)
		unifiedbricks.register_multicolor_craft(name, brick_one, brick_two, brick_three)

		name = DARKNESS[4] .. HUES[i]
		formalname = FORMALDARKNESS[4] .. FORMALHUES[i]
		brick_one = DARKNESS[3] .. HUES[i]
		brick_two = DARKNESS[4] .. HUES[i]
		brick_three = DARKNESS[2] .. HUES[i] .. SATURATION[1]
		unifiedbricks.register_multicolor(name, formalname, brick_one, brick_two, brick_three)
		unifiedbricks.register_multicolor_craft(name, brick_one, brick_two, brick_three)
	end
end

-- convert in-map static nodes to use param2 coloring

minetest.register_lbm({
	name = "unifiedbricks:convert_brickblocks",
	label = "Convert clay blocks and single-color brick blocks to use param2 color",
	run_at_every_load = true,
	nodenames = unifiedbricks.old_static_list,
	action = function(pos, node)

		local name = node.name
		local t = string.find(name, "_")
		local type = string.sub(name, 1, t - 1)
		local color1 = string.sub(name, t + 1)

		local color2 = string.gsub(color1, "grey", "_grey")
		if color2 == "_grey" then color2 = "grey" end

		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color2)

		if string.find(type, "brickblock") then
			minetest.set_node(pos, { name = "unifiedbricks:brickblock", param2 = paletteidx })
			local meta = minetest.get_meta(pos)
			meta:set_string("dye", "unifieddyes:"..color1)
		elseif string.find(type, "clayblock") then
			minetest.set_node(pos, { name = "unifiedbricks:clayblock", param2 = paletteidx })
			local meta = minetest.get_meta(pos)
			meta:set_string("dye", "unifieddyes:"..color1)
		end
	end
})

print("[UnifiedBricks] Loaded!")
