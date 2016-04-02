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

==============================================================================


Recipe for standard colors:

dye
super glow glass
super glow glass
super glow glass


Recipe for pastel colors:

light dye
white paint
super glow glass
super glow glass
super glow glass


Recipe for faint colors:

light dye
white paint
white paint
super glow glass
super glow glass
super glow glass

recipe for low-glow-stained-glass:
as above, but substitute 'glow glass' for super glow glass.

recipe for no-glow-stained-glass:
as regular stained glass, but substitute plain 'glass' for super glow glass


All recipes produce three stained glass blocks.

==============================================================================
]]--

function makenode(arg)
	local name=arg.blockname
	local myglow=arg.glow
	local myprefix=arg.prefix
	local imagename=arg.imagename
	local safe=arg.walkflag
	local Description

        local function tchelper(first, rest)
                return first:upper()..rest:lower()
        end -- from lua-users.org/wiki/StringRecipes
        -- above function is used to turn red_violet_s50 to 'Red Violet S50'

	--register item attributes

        Description=string.gsub("Stained Glass - " ..myprefix..name, "_", " ")
        Description=Description:gsub("(%a)([%w_']*)", tchelper) 

	minetest.register_node("stained_glass:"..myprefix..name, {
		description = Description,
		drawtype = "glasslike",
		tiles = {"stained_glass_" .. imagename .. ".png"},
		paramtype = "light",
		sunlight_propagates = true,
		use_texture_alpha = true,
		light_source = myglow,
		is_ground_content = true,
		walkable=safe, -- if not safe, this is trapglass
		groups = {snappy=2,cracky=3,oddly_breakable_by_hand=3, not_in_creative_inventory=1},
		sounds = default.node_sound_glass_defaults()
	})
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

		minetest.register_craft({
			type = "shapeless",
			output = "stained_glass:"..myprefix..name.." 3",
			recipe = myrecipe,
		})

		makenode{blockname=name, glow=myglow, prefix=myprefix, imagename=imagename, walkflag=false}
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

		minetest.register_craft({
			type = "shapeless",
			output = "stained_glass:"..myprefix..name.." 3",
			recipe = myrecipe,
		})

		makenode{blockname=name, glow=myglow, prefix=myprefix, imagename=name, walkflag=true}

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
			-- print(huename .. " is set to true -- substituting dye:huename ")
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

print("[stained_glass] Loaded!")


