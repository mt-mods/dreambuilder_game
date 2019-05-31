local schems = {
	single = minetest.register_schematic(string.format("schems%sstreetlight-single.mts",DIR_DELIM)),
	double = minetest.register_schematic(string.format("schems%sstreetlight-double.mts",DIR_DELIM)),
}

local singleMaterials = {
	ItemStack("streets:bigpole 6"),
	ItemStack("streets:bigpole_edge 2"),
	ItemStack("homedecor:glowlight_quarter 1"),
}

local doubleMaterials = {
	ItemStack("streets:bigpole 7"),
	ItemStack("streets:bigpole_edge 2"),
	ItemStack("streets:bigpole_tjunction 1"),
	ItemStack("homedecor:glowlight_quarter 2"),
}

local offsets = {
	single = {
		[0] = {x = 0,y = 0,z = 0},
		[90] = {x = 0,y = 0,z = 0},
		[180] = {x = 0,y = 0,z = -2},
		[270] = {x = -2,y = 0,z = 0},
	},
	double = {
		[0] = {x = 0,y = 0,z = -2},
		[90] = {x = -2,y = 0,z = 0},
		[180] = {x = 0,y = 0,z = -2},
		[270] = {x = -2,y = 0,z = 0},
	},
}

local function takeMaterials(player, sneak, materials)
	local name = player:get_player_name()
	if creative and creative.is_enabled_for(name) then return true end
	local inv = minetest.get_inventory({type = "player",name = name})
	local hasMaterials = true
	for _,i in ipairs(materials) do
		if not inv:contains_item("main",i) then hasMaterials = false end
	end
	if sneak and streetlights.basic_materials and not inv:contains_item("main", streetlights.concrete) then
		hasMaterials = false
	end
	if hasMaterials then
		for _,i in ipairs(materials) do inv:remove_item("main",i) end
		if sneak then
			inv:remove_item("main", streetlights.concrete)
		end
		return true
	else
		minetest.chat_send_player(name,"You don't have the necessary materials to do that!")
		return false
	end
end

local function place(itemstack,player,pointed)
	if not player then return end
	local sneak = player:get_player_control().sneak
	local name = player:get_player_name()
	if not minetest.check_player_privs(name,{streetlight = true}) then
		minetest.chat_send_player(name,"*** You don't have permission to use a streetlight spawner.")
		return
	end
	local pos = pointed.above
	if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass = true}) then
		minetest.record_protection_violation(pos,name)
		return
	end
	local isDouble = string.sub(itemstack:get_name(),-6,-1) == "double"
	if not takeMaterials(player, sneak, isDouble and doubleMaterials or singleMaterials) then return end
	local facedir = minetest.facedir_to_dir(minetest.dir_to_facedir(player:get_look_dir()))
	local schemDir = 0
	if facedir.x == 1 then schemDir = 180
	elseif facedir.z == 1 then schemDir = 90
	elseif facedir.z == -1 then schemDir = 270 end
	local offset = offsets[isDouble and "double" or "single"][schemDir]
	if sneak and streetlights.basic_materials then
		minetest.set_node({x=pos.x, y=pos.y-1, z=pos.z}, {name = streetlights.concrete})
	end
	local pos = vector.add(pos,offset)
	minetest.place_schematic(pos,isDouble and schems.double or schems.single,schemDir,nil,false)
end

minetest.register_tool(":minedot_streetlights:spawner_single",{
	description = "MineDOT-style Street Light Spawner (single-sided)",
	inventory_image = "minedot_streetlights_single.png",
	on_place = place,
})

minetest.register_tool(":minedot_streetlights:spawner_double",{
	description = "MineDOT-style Street Light Spawner (double-sided)",
	inventory_image = "minedot_streetlights_double.png",
	on_place = place,
})
