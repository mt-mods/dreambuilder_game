--Spawn function
function def_spawn(pos)
	minetest.add_entity(pos, "peaceful_npc:npc_def")
	print("want to spawn npc_def at "..dump(pos))
	if mode_debug == true then
		minetest.chat_send_all("want to spawn npc_def at "..dump(pos))
	end
end

function fast_spawn(pos)
	minetest.add_entity(pos, "peaceful_npc:npc_fast")
	print("want to spawn npc_fast at "..dump(pos))
	if mode_debug == true then
		minetest.chat_send_all("want to spawn npc_fast at "..dump(pos))
	end
end

function dwarf_spawn(pos)
	minetest.add_entity(pos, "peaceful_npc:npc_dwarf")
	print("want to spawn npc_dwarf at "..dump(pos))
	if mode_debug == true then
		minetest.chat_send_all("want to spawn npc_dwarf at "..dump(pos))
	end
end

--Mapgen biomes
plaingen_biome = {
	surface = "default:dirt_with_grass",
	avoid_nodes = {"group:liquid", "group:tree"},
	avoid_radius = 20,
	rarity = 93,
	max_count = 1,
	min_elevation = -10,
	max_elevation = 30,
}

forestgen_biome = {
	surface = {"group:tree", "default:leaves"},
	avoid_nodes = {"group:liquid"},
	avoid_radius = 10,
	rarity = 96,
	max_count = 1,
	min_elevation = 20,
	max_elevation = 50,
}

beachgen_biome = {
	surface = "default:sand",
	avoid_nodes = {"group:liquid"},
	avoid_radius = 1,
	rarity = 90,
	max_count = 1,
	min_elevation = 0,
	max_elevation = 10,
}

desertgen_biome = {
	surface = { "default:desert_sand", "default:desert_stone"},
	avoid_nodes = {"group:liquid"},
	avoid_radius = 100,
	rarity = 95,
	max_count = 1,
	min_elevation = 0,
	max_elevation = 150,
}

cavegen_biome = {
	surface = { "default:stone_with_iron", "default:stone_with_coal", "default:stone_with_mese"},
	avoid_nodes = {"group:liquid"},
	avoid_radius = 5,
	rarity = 98,
	max_count = 1,
	min_elevation = -500,
	max_elevation = -50,
	check_air = true,
	spawn_replace_node = true,
}
	
--spawn definers
biome_lib:register_generate_plant(plaingen_biome, "def_spawn")
biome_lib:register_generate_plant(forestgen_biome, "def_spawn")
biome_lib:register_generate_plant(beachgen_biome, "fast_spawn")
biome_lib:register_generate_plant(desertgen_biome, "fast_spawn")
biome_lib:register_generate_plant(cavegen_biome, "dwarf_spawn")

print("Peaceful NPC spawning.lua loaded! By jojoa1997!")