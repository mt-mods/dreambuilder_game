
local fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 }
}

minetest.register_privilege("streetlight", {
	description = "Allows using streetlight spawners",
	give_to_singleplayer = true
})

local function check_and_place(itemstack, placer, pointed_thing, pole, light, param2)
	local sneak = placer:get_player_control().sneak
	if not placer then return end
	if not minetest.check_player_privs(placer, "streetlight") then
		minetest.chat_send_player(placer:get_player_name(), "*** You don't have permission to use a streetlight spawner.")
		return
	end
	local player_name = placer:get_player_name()
	local fdir = minetest.dir_to_facedir(placer:get_look_dir())

	local pos1 = minetest.get_pointed_thing_position(pointed_thing)
	local node1 = minetest.get_node(pos1)
	if not node1 or node1.name == "ignore" then return end
	local def1 = minetest.registered_items[node1.name]

	print(dump(pos1))
	print(node1.name)
	print(dump(def1))


	if (def1 and def1.buildable_to) then
		pos1.y = pos1.y-1
	end
	local node1 = minetest.get_node(pos1)

	local node2, node3, node4
	local def1 = minetest.registered_items[node1.name]
	local def2, def3, def4

	local pos2, pos3, pos4
	for i = 1, 5 do
		pos2 = { x=pos1.x, y = pos1.y+i, z=pos1.z }
		node2 = minetest.get_node(pos2)
		def2 = minetest.registered_items[node2.name]
		if minetest.is_protected(pos2, player_name) or not (def2 and def2.buildable_to) then return end
	end

	pos3 = { x = pos1.x+fdir_to_right[fdir+1][1], y = pos1.y+5, z = pos1.z+fdir_to_right[fdir+1][2] }
	node3 = minetest.get_node(pos3)
	def3 = minetest.registered_items[node3.name]
	if minetest.is_protected(pos3, player_name) or not (def3 and def3.buildable_to) then return end

	pos4 = { x = pos1.x+fdir_to_right[fdir+1][1], y = pos1.y+4, z = pos1.z+fdir_to_right[fdir+1][2] }
	node4 = minetest.get_node(pos4)
	def4 = minetest.registered_items[node4.name]
	if minetest.is_protected(pos4, player_name) or not (def3 and def4.buildable_to) then return end

	if sneak and minetest.is_protected(pos1, player_name) then return end

	if not creative.is_enabled_for(player_name) then
		local inv = placer:get_inventory()
		if not inv:contains_item("main", pole.." 6") then
			minetest.chat_send_player(placer:get_player_name(), "*** You don't have enough "..pole.." in your inventory!")
			return
		end

		if not inv:contains_item("main", light) then
			minetest.chat_send_player(placer:get_player_name(), "*** You don't have any "..light.." in your inventory!")
			return
		end

		if sneak then
			if not inv:contains_item("main", streetlights.concrete) then
				minetest.chat_send_player(placer:get_player_name(), "*** You don't have any concrete in your inventory!")
				return
			else
				inv:remove_item("main", streetlights.concrete)
			end
		end

		inv:remove_item("main", pole.." 6")
		inv:remove_item("main", light)

	end

	if sneak then
		minetest.set_node(pos1, { name = streetlights.concrete })
	end

	for i = 1, 5 do
		pos2 = {x=pos1.x, y = pos1.y+i, z=pos1.z}
		minetest.set_node(pos2, {name = pole })
	end
	minetest.set_node(pos3, { name = pole    })
	minetest.set_node(pos4, { name = light, param2 = param2 })
end

local poles_tab = {
--    material name,  mod name,           node name
	{ "wood",         "default",          "default:fence_wood" },
	{ "junglewood",   "default",          "default:fence_junglewood" },
	{ "brass",        "homedecor_fences", "homedecor:fence_brass" },
	{ "wrought_iron", "homedecor_fences", "homedecor:fence_wrought_iron" },
	{ "steel",        "gloopblocks",      "gloopblocks:fence_steel" }
}

local lights_tab = {
--    light name,       mod name,             node name,                      optional param2
	{ "meselamp",       "default",            "default:meselamp" },
	{ "ilight",         "ilights",            "ilights:light" },
	{ "glowlight_cube", "homedecor_lighting", "homedecor:glowlight_small_cube" }
}

for _, pole in ipairs(poles_tab) do
	local matname = pole[1]
	local matmod =  pole[2]
	local matnode = pole[3]

	if minetest.get_modpath(matmod) then

		for _, light in ipairs(lights_tab) do
			local lightname =   light[1]
			local lightmod =    light[2]
			local lightnode =   light[3]
			local lightparam2 = light[4] or 0

			if minetest.get_modpath(lightmod) then

				minetest.register_tool("simple_streetlights:spawner_"..matname.."_"..lightname, {
					description = "Streetlight spawner ("..matname.." pole, "..lightname..")",
					inventory_image = "simple_streetlights_inv_pole_"..matname..".png"..
					                  "^simple_streetlights_inv_light_source_"..lightname..".png",
					use_texture_alpha = true,
					tool_capabilities = { full_punch_interval=0.1 },
					on_place = function(itemstack, placer, pointed_thing)
						check_and_place(itemstack, placer, pointed_thing, matnode, lightnode, lightparam2)
					end
				})

				minetest.register_craft({
					output = "simple_streetlights:spawner_"..matname.."_"..lightname,
					type = "shapeless",
					recipe = {
						matnode,
						matnode,
						matnode,
						matnode,
						matnode,
						matnode,
						lightnode
					}
				})

			end
		end
	end
end
