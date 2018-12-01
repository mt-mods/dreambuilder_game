digistuff.sounds_playing = {}

minetest.register_node("digistuff:piezo", {
	description = "Digilines Piezoelectric Beeper",
	groups = {cracky=3},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,
	on_destruct = function(pos)
		local pos_hash = minetest.hash_node_position(pos)
		if digistuff.sounds_playing[pos_hash] then
			minetest.sound_stop(digistuff.sounds_playing[pos_hash])
			digistuff.sounds_playing[pos_hash] = nil
		end
	end,
	tiles = {
		"digistuff_piezo_top.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png"
		},
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
	end,
	digiline = 
	{
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
					local meta = minetest.get_meta(pos)
					local setchan = meta:get_string("channel")
					if channel ~= setchan then return end
					if msg == "shortbeep" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						minetest.sound_play({name = "digistuff_piezo_short_single",gain = 0.2},{pos = pos,max_hear_distance = 16})
					elseif msg == "longbeep" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						minetest.sound_play({name = "digistuff_piezo_long_single",gain = 0.2},{pos = pos,max_hear_distance = 16})
					elseif msg == "fastrepeat" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						digistuff.sounds_playing[pos_hash] = minetest.sound_play({name = "digistuff_piezo_fast_repeat",gain = 0.2},{pos = pos,max_hear_distance = 16,loop = true})
					elseif msg == "slowrepeat" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						digistuff.sounds_playing[pos_hash] = minetest.sound_play({name = "digistuff_piezo_slow_repeat",gain = 0.2},{pos = pos,max_hear_distance = 16,loop = true})
					elseif msg == "stop" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
					end
				end
		},
	},
})
