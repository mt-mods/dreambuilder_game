minetest.register_alias_force("cottages:straw",      "farming:straw")
minetest.register_alias_force("castle:straw",        "farming:straw")
minetest.register_alias_force("darkage:straw",       "farming:straw")
minetest.register_alias_force("cottages:straw_bale", "castle_farming:bound_straw")
minetest.register_alias_force("darkage:straw_bale",  "castle_farming:bound_straw")
minetest.register_alias_force("castle:bound_straw",  "castle_farming:bound_straw")

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

minetest.register_node("castle_farming:bound_straw", {
	description = S("Bound Straw"),
	drawtype = "normal",
	tiles = {"castle_straw_bale.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3},
	sounds = default.node_sound_leaves_defaults(),
	paramtype = "light",
})

minetest.register_node("castle_farming:straw_dummy", {
	description = S("Training Dummy"),
	tiles = {"castle_straw_dummy.png"},
	groups = {choppy=4, flammable=1, oddly_breakable_by_hand=3},
	sounds = default.node_sound_leaves_defaults(),
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.25, -0.5, -0.125, 0, 0.1875, 0.125}, -- right_leg
			{0, -0.5, -0.125, 0.25, 0.1875, 0.125}, -- left_leg
			{-0.25, 0.1875, -0.1875, 0.25, 0.875, 0.125}, -- torso
			{0.25, 0.1875, -0.125, 0.5, 0.875, 0.125}, -- left_arm
			{-0.5, 0.1875, -0.125, -0.25, 0.875, 0.125}, -- right_arm
			{-0.25, 0.875, -0.25, 0.25, 1.3125, 0.1875}, -- head
		}
	}
})

minetest.register_craft({
	output = "castle_farming:straw_dummy",
	recipe = {
		{"group:stick", "castle_farming:bound_straw","group:stick"},
		{"", "castle_farming:bound_straw",""},
		{"group:stick", "","group:stick"},
	},
})

minetest.register_craft({
	output = "castle_farming:bound_straw 6",
	type = "shapeless",
	recipe = {"farming:straw", "farming:straw", "farming:straw", "farming:straw", "farming:straw", "farming:straw", "ropes:ropesegment",}
})

minetest.register_craft({
	output = "castle_farming:bound_straw",
	type = "shapeless",
	recipe = {"farming:straw", "farming:cotton",}
})

minetest.register_craft({
	type = "fuel",
	recipe = "castle_farming:bound_straw",
	burntime = 10
})

local stick_burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack("default:stick")}}).time

minetest.register_craft({
	type = "fuel",
	recipe = "castle_farming:straw_dummy",
	burntime = 10*2 + 4*stick_burn_time
})
