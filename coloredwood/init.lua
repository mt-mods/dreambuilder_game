-- Colored Wood mod by Vanessa Ezekowitz
-- based on my unifieddyes template.
--
-- License:  WTFPL
--
-- This mod provides 89 colors of wood, fences, and sticks, and enough
-- cross-compatible recipes to make everything fit together naturally.
--
-- Colored wood is created by placing a regular wood block on the ground
-- and then right-clicking on it with some dye.
-- All materials are flammable and can be used as fuel.
--
-- Hues are on a 30 degree spacing starting at red = 0 degrees.
-- "s50" in a file/item name means "saturation: 50%".
-- Texture brightness levels for the colors are 100%, 66% ("medium"),
-- and 33% ("dark").

coloredwood = {}

coloredwood.enable_stairsplus = true
if minetest.settings:get_bool("coloredwood_enable_stairsplus") == false or not minetest.get_modpath("moreblocks") then
	coloredwood.enable_stairsplus = false
end

coloredwood.shades = {
	"dark_",
	"medium_",
	""		-- represents "no special shade name", e.g. full.
}

coloredwood.shades2 = {
	"Dark ",
	"Medium ",
	""		-- represents "no special shade name", e.g. full.
}

coloredwood.default_hues = {
	"white",
	"grey",
	"dark_grey",
	"black",
	"violet",
	"blue",
	"cyan",
	"dark_green",
	"green",
	"yellow",
	"orange",
	"red",
	"magenta"
}

coloredwood.hues = {
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
	"redviolet"
}

coloredwood.hues2 = {
	"Red ",
	"Orange ",
	"Yellow ",
	"Lime ",
	"Green ",
	"Aqua ",
	"Cyan ",
	"Sky Blue ",
	"Blue ",
	"Violet ",
	"Magenta ",
	"Red-violet "
}

coloredwood.greys = {
	"black",
	"darkgrey",
	"grey",
	"lightgrey",
	"white"
}

coloredwood.greys2 = {
	"Black ",
	"Dark Grey ",
	"Medium Grey ",
	"Light Grey ",
	"White "
}

coloredwood.greys3 = {
	"dye:black",
	"dye:dark_grey",
	"dye:grey",
	"dye:light_grey",
	"dye:white"
}

coloredwood.hues_plus_greys = {}

for _, hue in ipairs(coloredwood.hues) do
	table.insert(coloredwood.hues_plus_greys, hue)
end

table.insert(coloredwood.hues_plus_greys, "grey")

-- helper functions

local function is_stairsplus(name, colorized)

	-- the format of a coloredwood stairsplus node is:
	-- "coloredwood:$CLASS_wood_$COLOR_$SHAPE"
	-- where $CLASS is "slab", "stair", etc., $SHAPE is "three quarter", "alt", etc.,
	-- and $COLOR is one of the 13 color sets (counting "grey")

	local a = string.find(name, ":")
	local b = string.find(name, "_")

	local class = string.sub(name, a+1, b-1) -- from colon to underscore is the class
	local shape = ""
	local rest
	local colorshape

	if class == "stair"
	  or class == "slab"
	  or class == "panel"
	  or class == "micro"
	  or class == "slope" then

		if colorized then
			colorshape = string.sub(name, b+6)
			local c = string.find(colorshape, "_") or 0  -- first word after "_wood_" is color
			shape = string.sub(colorshape, c) -- everything after the color is the shape
			if colorshape == shape then shape = "" end -- if there was no shape
		else
			shape = string.sub(name, b+5) -- everything after "_wood_" is the shape
		end
	end
	return class, shape
end

-- the actual nodes!

minetest.register_node("coloredwood:wood_block", {
	description = "Colored wooden planks",
	tiles = { "coloredwood_base.png" },
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	walkable = true,
	sunlight_propagates = false,
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2, not_in_creative_inventory=1, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
})

for _, color in ipairs(coloredwood.hues_plus_greys) do

	-- moreblocks/stairsplus support

	if coloredwood.enable_stairsplus then

	--	stairsplus:register_all(modname, subname, recipeitem, {fields})

		stairsplus:register_all(
			"coloredwood",
			"wood_"..color,
			"coloredwood:wood_"..color,
			{
				description = "Colored wood",
				tiles = { "coloredwood_base.png" },
				paramtype = "light",
				paramtype2 = "colorfacedir",
				palette = "unifieddyes_palette_"..color.."s.png",
				after_place_node = function(pos, placer, itemstack, pointed_thing)
					minetest.rotate_node(itemstack, placer, pointed_thing)
				end,
				groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=2, not_in_creative_inventory=1, ud_param2_colorable = 1},
			}
		)
	end
end

local coloredwood_cuts = {}

-- force settings for stairsplus default wood stair/slab/etc nodes
-- and fix other stuff for colored versions of stairsplus nodes

if coloredwood.enable_stairsplus then

	for _, i in pairs(minetest.registered_nodes) do

		if (string.find(i.name, "moreblocks:stair_wood")
		  or string.find(i.name, "moreblocks:slab_wood")
		  or string.find(i.name, "moreblocks:panel_wood")
		  or string.find(i.name, "moreblocks:micro_wood")
		  or string.find(i.name, "moreblocks:slope_wood"))
		  and not string.find(i.name, "wood_tile") then

			table.insert(coloredwood_cuts, i.name)

			minetest.override_item(i.name, {
				groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, not_in_creative_inventory=1, ud_param2_colorable = 1},
			})
		end
	end
end

-- "coloredwood:slope_wood_outer_half_raised"

for _, mname in ipairs(coloredwood_cuts) do

	local class, shape = is_stairsplus(mname, nil)

	unifieddyes.register_color_craft({
		output_prefix = "coloredwood:"..class.."_wood_",
		output_suffix = shape,
		palette = "split",
		type = "shapeless",
		neutral_node = mname,
		recipe = {
			"NEUTRAL_NODE",
			"MAIN_DYE"
		}
	})
end

minetest.override_item("default:wood", {
	palette = "unifieddyes_palette_extended.png",
	airbrush_replacement_node = "coloredwood:wood_block",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, wood = 1, ud_param2_colorable = 1},
})

default.register_fence("coloredwood:fence", {
	description = "Colored wooden fence",
	texture = "coloredwood_fence_base.png",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, ud_param2_colorable = 1},
	sounds = default.node_sound_wood_defaults(),
	material = "default:wood"
})

minetest.override_item("default:fence_wood", {
	palette = "unifieddyes_palette_extended.png",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, ud_param2_colorable = 1}
})

-- Crafts

unifieddyes.register_color_craft({
	output = "coloredwood:wood_block",
	palette = "extended",
	type = "shapeless",
	neutral_node = "default:wood",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

unifieddyes.register_color_craft({
	output = "coloredwood:fence",
	palette = "extended",
	type = "shapeless",
	neutral_node = "default:fence_wood",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

-- ============================
-- convert the old static nodes

coloredwood.old_static_nodes = {}
coloredwood.old_13_color_nodes = {}

for _, hue in ipairs(coloredwood.hues) do
	table.insert(coloredwood.old_13_color_nodes, "coloredwood:wood_"..hue)
	for _, sat in ipairs({"", "_s50"}) do
		for _, val in ipairs ({"dark_", "medium_", "light_", ""}) do
			table.insert(coloredwood.old_static_nodes, "coloredwood:wood_"..val..hue..sat)
			table.insert(coloredwood.old_static_nodes, "coloredwood:fence_"..val..hue..sat)
		end
	end
end

for _, shade in ipairs(coloredwood.greys) do
	table.insert(coloredwood.old_static_nodes, "coloredwood:wood_"..shade)
	table.insert(coloredwood.old_static_nodes, "coloredwood:fence_"..shade)
end

table.insert(coloredwood.old_13_color_nodes, "coloredwood:wood_grey")


-- add all of the stairsplus nodes, if moreblocks is installed.
if coloredwood.enable_stairsplus then
	for _, shape in ipairs(circular_saw.names) do
		local a = shape[1]
		local b = shape[2]
		for _, hue in ipairs(coloredwood.hues) do
			for _, shade in ipairs(coloredwood.shades) do
				table.insert(coloredwood.old_static_nodes, "coloredwood:"..a.."_wood_"..shade..hue..b)
				table.insert(coloredwood.old_static_nodes, "coloredwood:"..a.."_wood_"..shade..hue.."_s50"..b)
			end
			table.insert(coloredwood.old_static_nodes, "coloredwood:"..a.."_wood_light_"..hue..b) -- light doesn't have extra shades or s50
		end
	end

	for _, shape in ipairs(circular_saw.names) do
		local a = shape[1]
		local b = shape[2]
		for _, hue in ipairs(coloredwood.greys) do
			for _, shade in ipairs(coloredwood.shades) do
				table.insert(coloredwood.old_static_nodes, "coloredwood:"..a.."_wood_"..hue..b)
			end
		end
	end
end

print("[Colored Wood] Loaded!")
