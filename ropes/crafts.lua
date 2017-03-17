-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

if minetest.get_modpath("farming") then
	minetest.register_craft({
		output =  'ropes:ropesegment',
		recipe = {
			{'farming:cotton','farming:cotton'},
			{'farming:cotton','farming:cotton'},
			{'farming:cotton','farming:cotton'}
		}
	})
end

minetest.register_craftitem("ropes:ropesegment", {
	description = S("Rope Segment"),
	_doc_items_longdesc = ropes.doc.ropesegment_longdesc,
    _doc_items_usagehelp = ropes.doc.ropesegment_usage,
	groups = {vines = 1},
	inventory_image = "ropes_item.png",
})

local cotton_burn_time = 1
ropes.wood_burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack("default:wood")}}).time
ropes.rope_burn_time = cotton_burn_time * 6
local stick_burn_time = minetest.get_craft_result({method="fuel", width=1, items={ItemStack("default:stick")}}).time
ropes.ladder_burn_time = ropes.rope_burn_time * 2 + stick_burn_time * 3

minetest.register_craft({
	type = "fuel",
	recipe = "ropes:ropesegment",
	burntime = ropes.rope_burn_time,
})