minetest.register_tool("digistuff:channelcopier",{
	description = "Digilines Channel Copier (shift-click to copy, click to paste)",
	inventory_image = "digistuff_channelcopier.png",
	on_use = function(itemstack,player,pointed)
		if not (pointed and pointed.under) then return itemstack end
		if not (player and player:get_player_name()) then return end
		local pos = pointed.under
		local name = player:get_player_name()
		local node = minetest.get_node(pos)
		if not node then return itemstack end
		if minetest.registered_nodes[node.name]._digistuff_channelcopier_fieldname then
			if player:get_player_control().sneak then
				local channel = minetest.get_meta(pointed.under):get_string(minetest.registered_nodes[node.name]._digistuff_channelcopier_fieldname)
				if type(channel) == "string" and channel ~= "" then
					local stackmeta = itemstack:get_meta()
					stackmeta:set_string("channel",channel)
					stackmeta:set_string("description","Digilines Channel Copier, set to: "..channel)
					if player and player:get_player_name() then minetest.chat_send_player(player:get_player_name(),"Digilines channel copier set to "..minetest.colorize("#00FFFF",channel)..". Click another node to paste this channel there.") end
				end
			else
				if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
					minetest.record_protection_violation(pos,name)
					return itemstack
				end
				if minetest.registered_nodes[node.name]._digistuff_channelcopier_fieldname then
					local channel = itemstack:get_meta():get_string("channel")
					if type(channel) ~= "string" or channel == "" then
						minetest.chat_send_player(name,minetest.colorize("#FF5555","Error:").." No channel has been set yet. Shift-click to copy one.")
						return itemstack
					end
					local oldchannel = minetest.get_meta(pos):get_string(minetest.registered_nodes[node.name]._digistuff_channelcopier_fieldname)
					minetest.get_meta(pos):set_string(minetest.registered_nodes[node.name]._digistuff_channelcopier_fieldname,channel)
					if type(oldchannel) == "string" and oldchannel ~= "" then
						if channel == oldchannel then
							minetest.chat_send_player(name,"Channel of target node is already "..minetest.colorize("#00FFFF",oldchannel)..".")
						else
							minetest.chat_send_player(name,string.format("Channel of target node changed from %s to %s.",minetest.colorize("#00FFFF",oldchannel),minetest.colorize("#00FFFF",channel)))
						end
					else
						minetest.chat_send_player(name,"Channel of target node set to "..minetest.colorize("#00FFFF",channel)..".")
					end
					if type(minetest.registered_nodes[node.name]._digistuff_channelcopier_onset) == "function" then
						minetest.registered_nodes[node.name]._digistuff_channelcopier_onset(pos,node,player,channel,oldchannel)
					end
				end
			end
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = "digistuff:channelcopier",
	recipe = {
		{"mesecons_fpga:programmer"},
		{"digilines:wire_std_00000000"}
	}
})


--NOTE: Asking to have your own mod added to here is not the right way to add compatibility with the channel copier.
--Instead, include a _digistuff_channelcopier_fieldname field in your nodedef set to the name of the metadata field that contains the channel.
--If you need an action to occur after the channel is set, place a function in _digistuff_channelcopier_onset.
--Function signature is _digistuff_channelcopier_onset(pos,node,player,new_channel,old_channel)

local additionalnodes = {
	["digilines:chest"] = "channel",
	["digilines:lcd"] = "channel",
	["digilines:lightsensor"] = "channel",
	["digilines:rtc"] = "channel",
	["pipeworks:digiline_detector_tube_1"] = "channel",
	["pipeworks:digiline_detector_tube_2"] = "channel",
	["pipeworks:digiline_detector_tube_3"] = "channel",
	["pipeworks:digiline_detector_tube_4"] = "channel",
	["pipeworks:digiline_detector_tube_5"] = "channel",
	["pipeworks:digiline_detector_tube_6"] = "channel",
	["pipeworks:digiline_detector_tube_7"] = "channel",
	["pipeworks:digiline_detector_tube_8"] = "channel",
	["pipeworks:digiline_detector_tube_9"] = "channel",
	["pipeworks:digiline_detector_tube_10"] = "channel",
	["pipeworks:digiline_filter"] = "channel",
}

for name,field in pairs(additionalnodes) do
	if minetest.registered_nodes[name] and not minetest.registered_nodes[name]._digistuff_channelcopier_fieldname then
		minetest.override_item(name,{_digistuff_channelcopier_fieldname = field})
	end
end


