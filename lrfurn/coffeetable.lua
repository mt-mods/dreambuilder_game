
local S = homedecor_i18n.gettext

--[[
		local node = minetest.get_node(pos)
		local yaw = placer:get_look_yaw()
		local dir = minetest.yaw_to_dir(yaw-1.5)
		local fdir = minetest.dir_to_facedir(dir)

		print(placer:get_look_yaw(), yaw)
		print(node.param2, fdir)

		if lrfurn.check_right(pos, fdir, false, placer) then
			local pos2 = find_coffee_table_second_node(pos, fdir)
]]--

local function find_second_node(pos, param2)
	if param2 == 0 then
		pos.z = pos.z+1
	elseif param2 == 1 then
		pos.x = pos.x+1
	elseif param2 == 2 then
		pos.z = pos.z-1
	elseif param2 == 3 then
		pos.x = pos.x-1
	end
	return pos
end

minetest.register_alias("lrfurn:coffeetable_back", "lrfurn:coffeetable")
minetest.register_alias("lrfurn:coffeetable_front", "air")

minetest.register_node("lrfurn:coffeetable", {
	description = S("Coffee Table"),
	drawtype = "nodebox",
	tiles = {"lrfurn_coffeetable_back.png", "lrfurn_coffeetable_back.png",  "lrfurn_coffeetable_back.png",  "lrfurn_coffeetable_back.png",  "lrfurn_coffeetable_back.png",  "lrfurn_coffeetable_back.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
					--legs
					{ -0.375,  -0.5, -0.375,  -0.3125, -0.0625, -0.3125 },
					{  0.3125, -0.5, -0.375,   0.375,  -0.0625, -0.3125 },
					{ -0.375,  -0.5,  1.3125, -0.3125, -0.0625,  1.375  },
					{ 0.3125,  -0.5,  1.3125,  0.375,  -0.0625,  1.375  },
					--tabletop
					{-0.4375, -0.0625, -0.4375, 0.4375, 0, 1.4375},
				}
	},
	selection_box = {
		type = "fixed",
		fixed = {
					{-0.4375, -0.5, -0.4375, 0.4375, 0.0, 1.4375},
				}
	},

	after_place_node = function(pos, placer, itemstack, pointed_thing)
		if minetest.is_protected(pos, placer:get_player_name()) then return true end
		local node = minetest.get_node(pos)
		local fdir = node.param2

		if lrfurn.check_right(pos, fdir, false, placer) then
			minetest.set_node(pos, { name = node.name, param2 = (fdir + 1) % 4 })
		else
			minetest.chat_send_player(placer:get_player_name(),
			  S("No room to place the coffee table!"))
			minetest.set_node(pos, {name = "air"})
			return true
		end
	end,
})

minetest.register_craft({
	output = "lrfurn:coffeetable",
	recipe = {
		{"", "", "", },
		{"stairs:slab_wood", "stairs:slab_wood", "stairs:slab_wood", },
		{"group:stick", "", "group:stick", }
	}
})

minetest.register_craft({
	output = "lrfurn:coffeetable",
	recipe = {
		{"", "", "", },
		{"moreblocks:slab_wood", "moreblocks:slab_wood", "moreblocks:slab_wood", },
		{"group:stick", "", "group:stick", }
	}
})

if minetest.setting_get("log_mods") then
	minetest.log("action", "[lrfurn/coffeetable] "..S("Loaded!"))
end
