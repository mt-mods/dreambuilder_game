--[[

Stained Glass 

This mod provides luminescent stained glass blocks for Minetest 0.4.7+

Depends:
[moreblocks] by Calinou
[unifieddyes] by VanessaE

==============================================================================
Sat 04 May 2013 01:52:35 PM EDT

Copyright (C) 2013, Eli Innis
Email: doyousketch2 @ yahoo.com

Unified Dyes was released under GNU-GPL 2.0, see LICENSE for info.
More Blocks was released under zlib/libpng for code and CC BY-SA 3.0 Unported for textures, see LICENSE.txt for info.


Additional changes by VanessaEzekowitz in July 2013 to take all items 
out of creative inventory.

August 2013 -- Jeremy Anderson tries to get this working after the new color
changes, and to resurrect the craft recipes. Still GPL'd as far as I'm concerned.

August 2013 -- rewritten a bit by VanessaEzekowitz to further condense the code.

January 2017 -- rewritten a bit more by Vanessa E. to use engine param2 colorization
				and place-then-paint creation of colors.  To get the pastel colors,
				place super glow glass, right-click with dye to color it, then right-
				click with Moreblocks' "sweeper" to "brush off" some of the color.  Do
				it again to change pastel to faint.  Right click a pastel or faint with
				some dye to re-color it (you have to dig and re-place if you want to
				darken it).  Crafting is no longer used to create the colors.

August 2018 -- altered to use proper colored itemstacks with crafting

==============================================================================
]]--

stainedglass = {}
stainedglass.old_static_nodes = {}

local myglow = LIGHT_MAX-3

minetest.register_node("stained_glass:stained_glass", {
	description = "Stained Glass",
	drawtype = "glasslike",
	tiles = { "stained_glass.png" },
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	sunlight_propagates = true,
	use_texture_alpha = true,
	light_source = myglow,
	is_ground_content = true,
	walkable = true,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, not_in_creative_inventory=1, ud_param2_colorable = 1},
	sounds = default.node_sound_glass_defaults(),
	on_construct = unifieddyes.on_construct,
	on_dig = unifieddyes.on_dig,
})

minetest.override_item("moreblocks:super_glow_glass", {
	palette = "unifieddyes_palette_extended.png",
	airbrush_replacement_node = "stained_glass:stained_glass",
	groups = {snappy = 2, cracky = 3, oddly_breakable_by_hand = 3, ud_param2_colorable = 1},
})

-- trap glass

minetest.register_node("stained_glass:stained_trap_glass", {
	description = "Stained Trap-glass",
	drawtype = "glasslike",
	tiles = { "stained_glass.png" },
	paramtype = "light",
	paramtype2 = "color",
	palette = "unifieddyes_palette_extended.png",
	sunlight_propagates = true,
	use_texture_alpha = true,
	light_source = myglow,
	is_ground_content = true,
	walkable = false,
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, not_in_creative_inventory=1, ud_param2_colorable = 1},
	sounds = default.node_sound_glass_defaults(),
	on_construct = unifieddyes.on_construct,
	on_dig = unifieddyes.on_dig,
})

minetest.override_item("moreblocks:trap_super_glow_glass", {
	palette = "unifieddyes_palette_extended.png",
	airbrush_replacement_node = "stained_glass:stained_trap_glass",
	groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, ud_param2_colorable = 1},
})

-- crafting

unifieddyes.register_color_craft({
	output = "stained_glass:stained_glass",
	palette = "extended",
	type = "shapeless",
	neutral_node = "moreblocks:super_glow_glass",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

unifieddyes.register_color_craft({
	output = "stained_glass:stained_trap_glass",
	palette = "extended",
	type = "shapeless",
	neutral_node = "moreblocks:trap_super_glow_glass",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE"
	}
})

-- old static stuff

function stainedglass.makenode(arg)
	local name=arg.blockname
	local myglow=arg.glow
	local myprefix=arg.prefix
	local imagename=arg.imagename
	local safe=arg.walkflag

	local function tchelper(first, rest)
			return first:upper()..rest:lower()
	end -- from lua-users.org/wiki/StringRecipes

	table.insert(stainedglass.old_static_nodes, "stained_glass:"..name)
end

-- maybe someday, I can cleanly combine these two functions.

function stained_trapglass_define(arg)
	local code=arg.colorcode
	local name=arg.colorname	
	local rawdyename=arg.recipe 
	local mydye=arg.recipe 
	local myshadename=arg.shade
	local imagename=name

	local stained_glass_blocktype = { }

	local stained_glass_lightlevel = { }
	
	if stained_glass.trap_full_light then
		stained_glass_lightlevel[""] = LIGHT_MAX
		stained_glass_blocktype[""] = "moreblocks:trap_super_glow_glass"
	end  -- see settings.txt for these settings.

	if stained_glass.trap_med_light then
		stained_glass_lightlevel["lowglow_"] = LIGHT_MAX-3
		stained_glass_blocktype["lowglow_"] = "moreblocks:trap_glow_glass"
	end

	if stained_glass.trap_no_light then
		stained_glass_lightlevel["noglow_"] = 0
		stained_glass_blocktype["noglow_"] = "moreblocks:trap_glass"
	end

	for myprefix,myglow in pairs(stained_glass_lightlevel) do
		local glasstype = stained_glass_blocktype[myprefix]
		local name="trap_" .. name

		-- define myrecipe as a table, pass it in.

		local myrecipe = { mydye, glasstype, glasstype, glasstype }
		-- those four items will ALWAYS be there.  For faint and pastel, we 
		-- need to add additional dyes.  If you have defined a new shade, then
		-- you should probably handle it here.  

		if myshadename == "pastel_" then
			myrecipe[5] = "dye:white"
		end

		if myshadename == "faint_" then
			myrecipe[5] = "dye:white"
			myrecipe[6] = "dye:white"
		end

		stainedglass.makenode{blockname=name, glow=myglow, prefix=myprefix, imagename=imagename, walkflag=false}
	end
end

function stained_glass_define(arg)
	local code=arg.colorcode
	local name=arg.colorname	
	local rawdyename=arg.recipe 
	local mydye=arg.recipe 
	local myshadename=arg.shade
	local imagename=name

	local stained_glass_blocktype = { }

	local stained_glass_lightlevel = { }
	
	if stained_glass.full_light then
		stained_glass_lightlevel[""] = LIGHT_MAX
		stained_glass_blocktype[""] = "moreblocks:super_glow_glass"
	end  -- see settings.txt for these settings.

	if stained_glass.med_light then
		stained_glass_lightlevel["lowglow_"] = LIGHT_MAX-3
		stained_glass_blocktype["lowglow_"] = "moreblocks:glow_glass"
	end

	if stained_glass.no_light then
		stained_glass_lightlevel["noglow_"] = 0
		stained_glass_blocktype["noglow_"] = "default:glass"
	end

	for myprefix,myglow in pairs(stained_glass_lightlevel) do
		local glasstype = stained_glass_blocktype[myprefix]

		-- define myrecipe as a table, pass it in.

		local myrecipe = { mydye, glasstype, glasstype, glasstype }
		-- those four items will ALWAYS be there.  For faint and pastel, we 
		-- need to add additional dyes.  If you have defined a new shade, then
		-- you should probably handle it here.  

		if myshadename == "pastel_" then
			myrecipe[5] = "dye:white"
		end

		if myshadename == "faint_" then
			myrecipe[5] = "dye:white"
			myrecipe[6] = "dye:white"
		end

		stainedglass.makenode{blockname=name, glow=myglow, prefix=myprefix, imagename=name, walkflag=true}

		if myprefix == "" then
			local aliasname
			minetest.register_alias( "stained_glass:" .. code, "stained_glass:" .. name)
			if string.match(name,"redviolet") then
				local oldname=name
				aliasname=string.gsub(name, "redviolet","red_violet") -- need to support red_violet existence, too.
				minetest.register_alias( "stained_glass:" .. aliasname, "stained_glass:" .. oldname)
			end
		end
		-- and an alias from the numeric to the named block
		-- we need to keep the numeric block for all the people that used
		-- pre-v1.4 blocks in their worlds.
		-- no aliases for noglow- and lowglow- blocks, because they didn't
		-- exist until v1.5
	end
end

-- true means this color's recipe must use a direct "dye:xxxxx" item name
-- (perhaps because the related groups overlap two or more distinct colors)
-- false means the recipe uses "group:dye,unicolor_xxxxx"

stained_glass= {}
local worldpath=minetest.get_worldpath()
local modpath=minetest.get_modpath("stained_glass")
dofile(modpath .. "/settings.txt")

-- the new settings.txt file has a variety of possible settings.
-- see the file for examples.  We'll access those settings where its important, in
-- the stained glass module, where we'll build up the tables to contain 
-- only what we need. 

stained_glass_hues = {
	{ "yellow", true },
	{ "lime", false },
	{ "green", true },
	{ "aqua", false },
	{ "cyan", false },
	{ "skyblue", true },
	{ "blue", false },
	{ "violet", false }, 
	{ "magenta", true },
	{ "redviolet", true },
	{ "red", true },
	{ "orange", false },

-- please note that these only apply when our shadelevel is ""

}

stained_glass_shades = {
	{"dark_",   3  },
	{"medium_", 4  },
	{"",        5  }, -- full brightness
	{"light_",  8  },
	{"pastel_", 9  },
	{"faint_",  91 }

	-- note that dark_ medium_ and plain also have a half-saturation
	--  equivalent automatically defined in the code
}

for i in ipairs(stained_glass_hues) do

	local huename = stained_glass_hues[i][1]
	local huenumber = i

	for j in ipairs(stained_glass_shades) do

		local shadename = stained_glass_shades[j][1]
		local shadenumber = stained_glass_shades[j][2]

		local recipevalue = nil

 		recipevalue = "group:dye,unicolor_"..shadename..huename
		if (shadename == "" and stained_glass_hues[i][2]) then
			recipevalue = "dye:"..huename
		elseif (shadename=="pastel_" or shadename=="faint_") then 
			-- force light_dye for pastel and faint colors
			recipevalue = "group:dye,unicolor_light_"..huename
		else  -- default case
			recipevalue = "group:dye,unicolor_"..shadename..huename
		end

		if shadename == "dark_" or shadename == "medium_" or shadename == "" then
			stained_glass_define({
				colorcode = huenumber.."_"..shadenumber.."_7",
				colorname = shadename..huename,
				recipe = recipevalue,
				shade = shadename,
			})

			stained_trapglass_define({
				colorcode = huenumber.."_"..shadenumber.."_7",
				colorname = shadename..huename,
				recipe = recipevalue,
				shade = shadename,
			}) -- only defines something if the trap is enabled.

			-- below is the automatic "half saturation" block
			-- which was mentioned previously
			-- this is unicolor only, so switch dyename
			-- back to unicolor...
			recipevalue="group:dye,unicolor_"..shadename..huename
			stained_glass_define({
				colorcode = huenumber.."_"..shadenumber.."_6",
				colorname = shadename..huename.."_s50",
				recipe = recipevalue.."_s50",
				shade = shadename,
			})
			stained_trapglass_define({
				colorcode = huenumber.."_"..shadenumber.."_6",
				colorname = shadename..huename.."_s50",
				recipe = recipevalue.."_s50",
				shade = shadename,
			}) -- only defines something if the trap is enabled.
			-- because we define two blocks inside this chunk of
			--  code, we can't just define the relevant vars and
			--  move the proc_call after the if-then loop.

		elseif shadename == "light_" or shadename == "pastel_" or shadename == "faint_" then 
			stained_glass_define({
				colorcode = huenumber.."_"..shadenumber,
				colorname = shadename..huename,
				recipe = recipevalue,
				shade = shadename,
			})
			stained_trapglass_define({
				colorcode = huenumber.."_"..shadenumber,
				colorname = shadename..huename,
				recipe = recipevalue,
				shade = shadename,
			}) -- only defines something if the trap is enabled.
			
		end

	end
end

-- convert in-map static nodes to use param2 coloring

minetest.register_lbm({
	name = "stained_glass:convert_glass",
	label = "Convert static glass blocks to use param2 color",
	run_at_every_load = false,
	nodenames = stainedglass.old_static_nodes,
	action = function(pos, node)
		local name = node.name

		name = string.gsub(name, "aqua", "spring")
		name = string.gsub(name, "skyblue", "azure")
		name = string.gsub(name, "redviolet", "rose")

		local n = string.find(name, ":")
		local color = string.sub(name, n + 1)
		local h,s,v = unifieddyes.get_hsv(name)

		if string.find(name, "trap") then
			n = string.find(color, "_")
			color = string.sub(color, n + 1)
			local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")
			minetest.set_node(pos, { name = "stained_glass:stained_trap_glass", param2 = paletteidx })
		else
			local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "extended")
			minetest.set_node(pos, { name = "stained_glass:stained_glass", param2 = paletteidx })
		end
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..v..h..s)
		meta:set_string("palette", "ext")
	end
})


print("[stained_glass] Loaded!")
