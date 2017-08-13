--Spawn Command Function
function npc_command( command_name, npc_command_type, command_desc)
	local function spawn_for_command(name, param)
		local npcs_to_spawn = tonumber(param) or 1
		local player = minetest.get_player_by_name(name)
		local pos = player:getpos()
		local max_spawn = 20
		local max_surround_npc = 30
		local active_npc_count = table.getn(minetest.get_objects_inside_radius(pos, 50))
		if active_npc_count == nil then
			active_npc_count = 0
		end
		if npcs_to_spawn + active_npc_count > max_surround_npc then
			minetest.chat_send_player(name, "There are too many NPCs around you.")
		elseif npcs_to_spawn >= max_spawn + 1 then
			minetest.chat_send_player(name, "The spawn limit is"..max_spawn)
		else
			for n = 1, npcs_to_spawn do
			offsetx = math.random(-5,5)
			offsety = math.random(2,4)
			offsetz = math.random(-5,5)
				minetest.add_entity({ x=pos.x+offsetx, y=pos.y+offsety, z=pos.z+offsetz }, ("peaceful_npc:npc_"..npc_command_type))
			end
		end
	end

	--Spawn command
	minetest.register_chatcommand(command_name, {
		description = command_desc,
		privs = {peacefulnpc=true},
		func = spawn_for_command
	})
end

npc_command( "summonnpc_fast", "fast", "Summons Fast NPCs")
npc_command( "summonnpc_def", "def", "Summon Default NPCs")
npc_command( "summonnpc_dwarf", "dwarf", "Summon Dwarf NPCs")

print("Peaceful NPC commands.lua loaded! By jojoa1997!")