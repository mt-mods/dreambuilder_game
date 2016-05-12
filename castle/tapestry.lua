local tapestry = {}

minetest.register_node("castle:tapestry_top", {
	drawtype = "nodebox",
 description = "Tapestry Top",
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
	output = 'castle:tapestry_top',
	recipe = {'default:stick'},
})

tapestry.colours = {
	{"white",      "White",      "white",    "#FFFFFF"},
	{"grey",       "Grey",       "grey",    "#4B4B4B"},
	{"black",      "Black",      "black",    "#1F1F1F"},
	{"red",        "Red",        "red",    "#B21414"},
	{"yellow",     "Yellow",     "yellow",    "#FFD011"},
 {"green",      "Green",      "green",    "#43A91C"},
	{"cyan",       "Cyan",       "cyan",    "#00737B"},
	{"blue",       "Blue",       "blue",    "#003A7E"},
	{"magenta",    "Magenta",    "magenta",    "#DD0487"},
	{"orange",     "Orange",     "orange",    "#D55014"},
	{"violet",     "Violet",     "violet",    "#5D01AC"},
	{"dark_grey",  "Dark Grey",  "dark_grey",    "#3A3A3A"},
	{"dark_green", "Dark Green", "dark_green",    "#206400"},
	{"pink", "Pink", "pink",    "#FF8383"},
	{"brown", "Brown", "brown",    "#6D3800"},
}

for _, row in ipairs(tapestry.colours) do
	local name = row[1]
	local desc = row[2]
	local craft_color_group = row[3]
	local defcolor = row[4]
	-- Node Definition
  minetest.register_node("castle:tapestry_"..name, {
  drawtype = "nodebox",
  description = desc.." Tapestry",
  --uses default wool textures for tapestry material
  tiles = {"wool_"..name..".png^[transformR90"},
  --uses custom texture for tapestry material
  --tiles = {"castle_tapestry_overlay.png^[colorize:" .. defcolor ..":205"},
  groups = {oddly_breakable_by_hand=3,flammable=3},
  sounds = default.node_sound_defaults(),
  paramtype = "light",
  paramtype2 = "facedir",
  node_box = {
  type = "fixed",
  fixed = {
			    {-0.3125,-0.5,0.4375,-0.1875,-0.375,0.5},
			    {0.1875,-0.5,0.4375,0.3125,-0.375,0.5},
			    {-0.375,-0.375,0.4375,-0.125,-0.25,0.5},
			    {0.125,-0.375,0.4375,0.375,-0.25,0.5},
			    {-0.4375,-0.25,0.4375,-0.0625,-0.125,0.5},
			    {0.0625,-0.25,0.4375,0.4375,-0.125,0.5},
			    {-0.5,-0.125,0.4375,0.0,0.0,0.5},
			    {0.0,-0.125,0.4375,0.5,0.0,0.5},
			    {-0.5,0.0,0.4375,0.5,1.5,0.5},
		    },
	    },
	    selection_box = {
		    type = "fixed",
		    fixed = {
			    {-0.5,-0.5,0.4375,0.5,1.5,0.5},
		    },
	    },
	})
	if craft_color_group then
		-- Crafting from wool and a stick
		minetest.register_craft({
			type = "shapeless",
			output = 'castle:tapestry_'..name,
			recipe = {'wool:'..craft_color_group, 'default:stick'},
		})
	end
end

for _, row in ipairs(tapestry.colours) do
  local name = row[1]
  local desc = row[2]
  local craft_color_group = row[3]
  local defcolor = row[4]
  -- Node Definition
  minetest.register_node("castle:long_tapestry_"..name, {
  drawtype = "nodebox",
  description = desc.." Tapestry (Long)",
  --uses default wool textures for tapestry material
  tiles = {"wool_"..name..".png^[transformR90"},
  --uses custom texture for tapestry material
  --tiles = {"castle_tapestry_overlay.png^[colorize:" .. defcolor ..":205"},
  groups = {oddly_breakable_by_hand=3,flammable=3},
  sounds = default.node_sound_defaults(),
  paramtype = "light",
  paramtype2 = "facedir",
  node_box = {
		    type = "fixed",
		    fixed = {
			    {-0.3125,-0.5,0.4375,-0.1875,-0.375,0.5},
			    {0.1875,-0.5,0.4375,0.3125,-0.375,0.5},
			    {-0.375,-0.375,0.4375,-0.125,-0.25,0.5},
			    {0.125,-0.375,0.4375,0.375,-0.25,0.5},
			    {-0.4375,-0.25,0.4375,-0.0625,-0.125,0.5},
			    {0.0625,-0.25,0.4375,0.4375,-0.125,0.5},
			    {-0.5,-0.125,0.4375,0.0,0.0,0.5},
			    {0.0,-0.125,0.4375,0.5,0.0,0.5},
			    {-0.5,0.0,0.4375,0.5,2.5,0.5},
		    },
	    },
	    selection_box = {
		    type = "fixed",
		    fixed = {
			    {-0.5,-0.5,0.4375,0.5,2.5,0.5},
		    },
	    },
	})
	if craft_color_group then
		-- Crafting from normal tapestry and wool
		minetest.register_craft({
			type = "shapeless",
			output = 'castle:long_tapestry_'..name,
			recipe = {'wool:'..craft_color_group, 'castle:tapestry_'..name},
		})
	end
end

for _, row in ipairs(tapestry.colours) do
  local name = row[1]
  local desc = row[2]
  local craft_color_group = row[3]
 	local defcolor = row[4]
  -- Node Definition
  minetest.register_node("castle:very_long_tapestry_"..name, {
  drawtype = "nodebox",
  description = desc.." Tapestry (Very Long)",
  --uses default wool textures for tapestry material
  tiles = {"wool_"..name..".png^[transformR90"},
  --uses custom texture for tapestry material
  --tiles = {"castle_tapestry_overlay.png^[colorize:" .. defcolor ..":205"},
  groups = {oddly_breakable_by_hand=3,flammable=3},
  sounds = default.node_sound_defaults(),
  paramtype = "light",
  paramtype2 = "facedir",
  node_box = {
  type = "fixed",
  fixed = {
			    {-0.3125,-0.5,0.4375,-0.1875,-0.375,0.5},
			    {0.1875,-0.5,0.4375,0.3125,-0.375,0.5},
			    {-0.375,-0.375,0.4375,-0.125,-0.25,0.5},
			    {0.125,-0.375,0.4375,0.375,-0.25,0.5},
			    {-0.4375,-0.25,0.4375,-0.0625,-0.125,0.5},
			    {0.0625,-0.25,0.4375,0.4375,-0.125,0.5},
			    {-0.5,-0.125,0.4375,0.0,0.0,0.5},
			    {0.0,-0.125,0.4375,0.5,0.0,0.5},
			    {-0.5,0.0,0.4375,0.5,3.5,0.5},
		    },
	    },
	    selection_box = {
		    type = "fixed",
		    fixed = {
			    {-0.5,-0.5,0.4375,0.5,3.5,0.5},
		    },
	    },
	})
	if craft_color_group then
		-- Crafting from long tapestry and wool
		minetest.register_craft({
			type = "shapeless",
			output = 'castle:very_long_tapestry_'..name,
			recipe = {'wool:'..craft_color_group, 'castle:long_tapestry_'..name},
		})
	end
end
