if not minetest.get_modpath("mesecons_noteblock") then
	minetest.log("error","mesecons_noteblock is not installed - digilines noteblock will not be available!")
	return
end

local validnbsounds = dofile(minetest.get_modpath(minetest.get_current_modname())..DIR_DELIM.."nbsounds.lua")
minetest.register_node("digistuff:noteblock", {
	description = "Digilines Noteblock",
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
		"mesecons_noteblock.png"
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
					if msg == "get_sounds" then
						local soundnames = {}
						for i in pairs(validnbsounds) do
							table.insert(soundnames,i)
						end
						digiline:receptor_send(pos, digiline.rules.default, channel, soundnames)
						return
					end
					if type(msg) == "string" then
						local sound = validnbsounds[msg]
						if sound then minetest.sound_play(sound,{pos=pos}) end
					elseif type(msg) == "table" then
						if type(msg.sound) ~= "string" then return end
						local sound = validnbsounds[msg.sound]
						local volume = 1
						if type(msg.volume) == "number" then
							volume = math.max(0,math.min(1,msg.volume))
						end
						if sound then minetest.sound_play({name=sound,gain=volume},{pos=pos}) end
					end
				end
		},
	},
})
