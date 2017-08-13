--Spawn code
function npc_spawner(pos, SPAWN_TYPE)
	local MAX_NPC = 5
	local count = table.getn(minetest.get_objects_inside_radius(pos, 50))
	if count == nil then
		count = 0
	end
	
	if count <= MAX_NPC then
		minetest.add_entity({x=pos.x+math.random(-1,1),y=pos.y+math.random(2,3),z=pos.z+math.random(-1,1)}, SPAWN_TYPE)
	end
end

--Item Code for default npcs
minetest.register_node("peaceful_npc:summoner_npc_def", {
	description = "Default NPC Summoner",
	image = "peaceful_npc_npc_summoner_def.png",
	inventory_image = "peaceful_npc_npc_summoner_def.png",
	wield_image = "peaceful_npc_npc_summoner_def.png",
	paramtype = "light",
	tiles = {"peaceful_npc_spawnegg.png"},
	is_ground_content = true,
	drawtype = "glasslike",
	groups = {crumbly=3},
	selection_box = {
		type = "fixed",
		fixed = {0,0,0,0,0,0}
	},
	sounds = default.node_sound_dirt_defaults(),
	on_place = function(itemstack, placer, pointed)
		local name = placer:get_player_name()
		if (minetest.check_player_privs(name, {peacefulnpc=true})) then
            pos = pointed.above
            pos.y = pos.y + 1
        minetest.add_entity(pointed.above,"peaceful_npc:npc_def")
        itemstack:take_item(1)
	else
		minetest.chat_send_player(name, "Nope! You need to have the peacefulnpc priv!")
	end
	return itemstack
end	
})

minetest.register_node("peaceful_npc:spawner_npc_def", {
	description = "Default NPC Portal",
	drawtype = "glasslike",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_glass_defaults(),
	tiles = {"peaceful_npc_spawner_def.png"},
	sunlight_propagates = true,
	paramtype = "light",
	mesecons = {effector = {
		action_on = function(pos) npc_spawner(pos, "peaceful_npc:npc_def") end,
	}}
})
minetest.register_abm({
	nodenames = {"peaceful_npc:spawner_npc_def"},
	interval = 20,
	chance = 10,
	action = function(pos)
		npc_spawner(pos, "peaceful_npc:npc_def")
	end,
})

--Item Code for fast npcs
minetest.register_node("peaceful_npc:summoner_npc_fast", {
	description = "Fast NPC Summoner",
	image = "peaceful_npc_npc_summoner_fast.png",
	inventory_image = "peaceful_npc_npc_summoner_fast.png",
	wield_image = "peaceful_npc_npc_summoner_fast.png",
	paramtype = "light",
	tiles = {"peaceful_npc_spawnegg.png"},
	is_ground_content = true,
	drawtype = "glasslike",
	groups = {crumbly=3},
	selection_box = {
		type = "fixed",
		fixed = {0,0,0,0,0,0}
	},
	sounds = default.node_sound_dirt_defaults(),
	on_place = function(itemstack, placer, pointed)
		local name = placer:get_player_name()
		if (minetest.check_player_privs(name, {peacefulnpc=true})) then
            pos = pointed.above
            pos.y = pos.y + 1
        minetest.add_entity(pointed.above,"peaceful_npc:npc_fast")
        itemstack:take_item(1)
	else
		minetest.chat_send_player(name, "Nope! You need to have the peacefulnpc priv!")
	end
	return itemstack
end	
})

minetest.register_node("peaceful_npc:spawner_npc_fast", {
	description = "Fast NPC Portal",
	drawtype = "glasslike",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_glass_defaults(),
	tiles = {"peaceful_npc_spawner_fast.png"},
	sunlight_propagates = true,
	paramtype = "light",
	mesecons = {effector = {
		action_on = function(pos) npc_spawner(pos, "peaceful_npc:npc_fast") end,
	}}
})
minetest.register_abm({
	nodenames = {"peaceful_npc:spawner_npc_fast"},
	interval = 30,
	chance = 10,
	action = function(pos)
		npc_spawner(pos, "peaceful_npc:npc_fast")
	end,
})

--Item Code for dwarf npcs
minetest.register_node("peaceful_npc:summoner_npc_dwarf", {
	description = "Dwarf NPC Summoner",
	image = "peaceful_npc_npc_summoner_dwarf.png",
	inventory_image = "peaceful_npc_npc_summoner_dwarf.png",
	wield_image = "peaceful_npc_npc_summoner_dwarf.png",
	paramtype = "light",
	tiles = {"peaceful_npc_spawnegg.png"},
	is_ground_content = true,
	drawtype = "glasslike",
	groups = {crumbly=3},
	selection_box = {
		type = "fixed",
		fixed = {0,0,0,0,0,0}
	},
	sounds = default.node_sound_dirt_defaults(),
	on_place = function(itemstack, placer, pointed)
		local name = placer:get_player_name()
		if (minetest.check_player_privs(name, {peacefulnpc=true})) then
            pos = pointed.above
            pos.y = pos.y + 1
        minetest.add_entity(pointed.above,"peaceful_npc:npc_dwarf")
        itemstack:take_item(1)
	else
		minetest.chat_send_player(name, "Nope! You need to have the peacefulnpc priv!")
	end
	return itemstack
end	
})

minetest.register_node("peaceful_npc:spawner_npc_dwarf", {
	description = "Dwarf NPC Portal",
	drawtype = "glasslike",
	groups = {snappy=1,choppy=2,oddly_breakable_by_hand=2,flammable=3,wood=1},
	sounds = default.node_sound_glass_defaults(),
	tiles = {"peaceful_npc_spawner_dwarf.png"},
	sunlight_propagates = true,
	paramtype = "light",
	mesecons = {effector = {
		action_on = function(pos) npc_spawner(pos, "peaceful_npc:npc_dwarf") end,
	}}
})
minetest.register_abm({
	nodenames = {"peaceful_npc:spawner_npc_dwarf"},
	interval = 60,
	chance = 10,
	action = function(pos)
		npc_spawner(pos, "peaceful_npc:npc_dwarf")
	end,
})

if instakill_sword == true then
	--Adds instakill sword
	minetest.register_tool("peaceful_npc:sword_instakill", {
		description = "Instakill Sword",
		inventory_image = "default_tool_steelsword.png",
		tool_capabilities = {
			full_punch_interval = 0.1,
			max_drop_level = 1,
			groupcaps={
				fleshy={times={[1]=0.005, [2]=0.005, [3]=0.005}, uses=0, maxlevel=3},
				snappy={times={[2]=0.005, [3]=0.005}, uses=0, maxlevel=2},
				choppy={times={[3]=0.005}, uses=0, maxlevel=1}
			},
		}
	})
end

print("Peaceful NPC items.lua loaded! By jojoa1997!")
