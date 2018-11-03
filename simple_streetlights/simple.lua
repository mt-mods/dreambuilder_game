
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

local function check_and_place(itemstack, placer, pointed_thing, pole, light)
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

	if not creative or not creative.is_enabled_for(player_name) then
		local inv = placer:get_inventory()
		if not inv:contains_item("main", pole.." 5") or not inv:contains_item("main", light) then return end
		inv:remove_item("main", pole.." 5")
		inv:remove_item("main", light)
	end

	for i = 1, 5 do
		pos2 = {x=pos1.x, y = pos1.y+i, z=pos1.z}
		minetest.set_node(pos2, {name = pole })
	end
	minetest.set_node(pos3, { name = pole    })
	minetest.set_node(pos4, { name = light, param2 = 0 })
end

minetest.register_tool("simple_streetlights:spawner_wood_meselamp", {
	description = "Streetlight spawner (wooden pole, Mese lamp cube)",
	inventory_image = "simple_streetlights_spawner_wood_meselamp.png",
	use_texture_alpha = true,
	tool_capabilities = { full_punch_interval=0.1 },
	on_place = function(itemstack, placer, pointed_thing)
		check_and_place(itemstack, placer, pointed_thing, "default:fence_wood", "default:meselamp")
	end
})

if minetest.get_modpath("ilights") then
	minetest.register_tool("simple_streetlights:spawner_wood_white", {
		description = "Streetlight spawner (wooden pole, white light)",
		inventory_image = "simple_streetlights_spawner_wood_white.png",
		use_texture_alpha = true,
		tool_capabilities = { full_punch_interval=0.1 },
		on_place = function(itemstack, placer, pointed_thing)
			check_and_place(itemstack, placer, pointed_thing, "default:fence_wood", "ilights:light")
		end
	})

	if minetest.get_modpath("gloopblocks") then
		minetest.register_tool("simple_streetlights:spawner_steel_white", {
			description = "Streetlight spawner (steel pole, white light)",
			inventory_image = "simple_streetlights_spawner_steel_white.png",
			use_texture_alpha = true,
			tool_capabilities = { full_punch_interval=0.1 },
			on_place = function(itemstack, placer, pointed_thing)
				check_and_place(itemstack, placer, pointed_thing, "gloopblocks:fence_steel", "ilights:light")
			end
		})
	end

	if minetest.get_modpath("homedecor") then
		minetest.register_tool("simple_streetlights:spawner_wrought_iron_white", {
			description = "Streetlight spawner (wrought iron pole, white light)",
			inventory_image = "simple_streetlights_spawner_wrought_iron_white.png",
			use_texture_alpha = true,
			tool_capabilities = { full_punch_interval=0.1 },
			on_place = function(itemstack, placer, pointed_thing)
				check_and_place(itemstack, placer, pointed_thing, "homedecor:fence_wrought_iron", "ilights:light")
			end
		})

		minetest.register_tool("simple_streetlights:spawner_brass_white", {
			description = "Streetlight spawner (brass pole, white light)",
			inventory_image = "simple_streetlights_spawner_brass_white.png",
			use_texture_alpha = true,
			tool_capabilities = { full_punch_interval=0.1 },
			on_place = function(itemstack, placer, pointed_thing)
				check_and_place(itemstack, placer, pointed_thing, "homedecor:fence_brass", "ilights:light")
			end
		})
	end
end
