--
--Crafts
--
function npc_recipes(spawn_type, summon_core)
	minetest.register_craft({
		output = 'peaceful_npc:spawner_npc_'..spawn_type,
		recipe = {
			{'default:mese_block', 'default:glass', 'default:mese_block'},
			{'default:glass', 'peaceful_npc:summoner_npc_'..spawn_type, 'default:glass'},
			{'default:mese_block', 'default:glass', 'default:mese_block'},
		}
	})

	minetest.register_craft({
		output = 'peaceful_npc:summoner_npc_'..spawn_type,
		recipe = {
			{'default:mese_crystal', 'default:glass', 'default:mese_crystal'},
			{'default:glass', summon_core, 'default:glass'},
			{'default:mese_crystal', 'default:glass', 'default:mese_crystal'},
		}
	})

	minetest.register_craft({
		output = 'peaceful_npc:summoner_npc_'..spawn_type,
		recipe = {
			{'default:mese', 'default:glass', 'default:mese'},
			{'default:glass', summon_core, 'default:glass'},
			{'default:mese', 'default:glass', 'default:mese'},
		}
	})
end

npc_recipes('def', 'default:steel_ingot')
npc_recipes('fast', 'default:cactus')
npc_recipes('dwarf', 'bucket:bucket_lava')

print("Peaceful NPC recipes.lua loaded! By jojoa1997!")