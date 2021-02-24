-- Automatic warning device

infrastructure.sound_handles = {}

local soundnames = {
	"gstype2",
	"safetrantype1",
	"safetrantype3",
	"wch",
	"nl",
	"uk",
	"de",
}

local soundfriendlynames = {
	["gstype2"] = "US - GS \"Type 2\"",
	["safetrantype1"] = "US - Safetran \"Type 1\"",
	["safetrantype3"] = "US - Safetran \"Type 3\"",
	["wch"] = "US - WCH",
	["nl"] = "Netherlands",
	["uk"] = "UK",
	["de"] = "Germany",
}

function infrastructure.play_bell(pos)
	local pos_hash = minetest.hash_node_position(pos)
	if not infrastructure.sound_handles[pos_hash] then
		local meta = minetest.get_meta(pos)
		local soundname = "infrastructure_ebell_"
		local selectedsound = meta:get_string("selectedsound")
		if selectedsound and string.len(selectedsound) > 0 then
			soundname = soundname..selectedsound
		else
			soundname = soundname.."gstype2"
		end
		infrastructure.sound_handles[pos_hash] = minetest.sound_play(soundname,
				{pos = pos, gain = AUTOMATIC_WARNING_DEVICE_VOLUME, loop = true, max_hear_distance = 30,})
	end
end

function infrastructure.stop_bell(pos)
	local pos_hash = minetest.hash_node_position(pos)
	local sound_handle = infrastructure.sound_handles[pos_hash]
	if sound_handle then
		minetest.sound_stop(sound_handle)
		infrastructure.sound_handles[pos_hash] = nil
	end
end
function infrastructure.left_light_direction(pos, param2)
	if param2 == 0 then
		pos.x = pos.x - 1
	elseif param2 == 1 then
		pos.z = pos.z + 1
	elseif param2 == 2 then
		pos.x = pos.x + 1
	elseif param2 == 3 then
		pos.z = pos.z - 1
	end
end

function infrastructure.right_light_direction(pos, param2)
	if param2 == 0 then
		pos.x = pos.x + 2
	elseif param2 == 1 then
		pos.z = pos.z - 2
	elseif param2 == 2 then
		pos.x = pos.x - 2
	elseif param2 == 3 then
		pos.z = pos.z + 2
	end
end

function infrastructure.lights_enabled(pos)
	local node = minetest.get_node(pos)
	local param2 = node.param2
	minetest.swap_node(pos, {name = "infrastructure:automatic_warning_device_middle_center_on", param2 = node.param2})
	infrastructure.left_light_direction(pos, param2)
	minetest.swap_node(pos, {name = "infrastructure:automatic_warning_device_middle_left_on", param2 = node.param2})
	infrastructure.right_light_direction(pos, param2)
	minetest.swap_node(pos, {name = "infrastructure:automatic_warning_device_middle_right_on", param2 = node.param2})
end

function infrastructure.lights_disabled(pos)
	local node = minetest.get_node(pos)
	local param2 = node.param2
	minetest.swap_node(pos, {name = "infrastructure:automatic_warning_device_middle_center_off", param2 = node.param2})
	infrastructure.left_light_direction(pos, param2)
	minetest.swap_node(pos, {name = "infrastructure:automatic_warning_device_middle_left_off", param2 = node.param2})
	infrastructure.right_light_direction(pos, param2)
	minetest.swap_node(pos, {name = "infrastructure:automatic_warning_device_middle_right_off", param2 = node.param2})
end

function infrastructure.activate_lights(pos)
	pos.y = pos.y + 2
	local node = minetest.get_node(pos)
	if node.name == "infrastructure:automatic_warning_device_middle_center_off" then
		infrastructure.play_bell(pos)
		infrastructure.lights_enabled(pos)
	elseif (node.name == "infrastructure:automatic_warning_device_middle_center_on") then
		infrastructure.stop_bell(pos,node)
		infrastructure.lights_disabled(pos, node)
	end
end

local function ebell_updateformspec(pos)
	local meta = minetest.get_meta(pos)
	local fs = "size[5,3]"
	fs = fs.."field[0.3,0.3;5,1;channel;Channel;${channel}]"
	fs = fs.."label[0,0.7;Model (changes will be applied on next start)]"
	fs = fs.."dropdown[0,1.1;5;sound;"
	for _,model in ipairs(soundnames) do
		fs = fs..minetest.formspec_escape(soundfriendlynames[model])..","
	end
	fs = string.sub(fs,1,-2)
	local idx = 1
	local selected = meta:get_string("selectedsound")
	for k,v in ipairs(soundnames) do
		if selected == v then idx = k end
	end
	fs = fs..";"..idx.."]"
	fs = fs.."button_exit[1,2.1;2,1;save;OK]"
	meta:set_string("formspec",fs)
end

minetest.register_node("infrastructure:ebell",{
	description = "Railroad Crossing Electronic Bell",
	tiles = {
		"streets_pole.png",
		"streets_pole.png",
		"infrastructure_ebell_sides.png",
		"infrastructure_ebell_sides.png",
		"infrastructure_ebell_sides.png",
		"infrastructure_ebell_sides.png",
		},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.2,-0.5,-0.2,0.2,-0.35,0.2,},
			{-0.12,-0.35,-0.12,0.12,0.2,0.12,},
		},
	},
	_digistuff_channelcopier_fieldname = "channel",
	groups = {cracky = 3,},
	on_destruct = infrastructure.stop_bell,
	after_place_node = ebell_updateformspec,
	on_receive_fields = function(pos,formname,fields,sender)
		if not fields.save then return end
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then
			meta:set_string("channel",fields.channel)
		end
		if fields.sound then
			for _,sound in ipairs(soundnames) do
				if fields.sound == soundfriendlynames[sound] then
					meta:set_string("selectedsound",sound)
					ebell_updateformspec(pos)
				end
			end
		end
	end,
	digiline = {
		wire = {
			rules = {
				{x =  1,y =  0,z =  0},
				{x = -1,y =  0,z =  0},
				{x =  0,y =  0,z =  1},
				{x =  0,y =  0,z = -1},
				{x =  0,y = -1,z =  0},
			},
		},
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
				local setchan = minetest.get_meta(pos):get_string("channel")
				if setchan ~= channel then
					return
				end
				if msg == "bell_on" or msg == "on" then
					infrastructure.play_bell(pos)
				elseif msg == "bell_off" or msg == "off" then
					infrastructure.stop_bell(pos)
				end
			end
		}
	}
})

minetest.register_node("infrastructure:automatic_warning_device_top", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_top_side.png",
		"infrastructure_automatic_warning_device_top_side.png",
		"infrastructure_automatic_warning_device_top_side.png",
		"infrastructure_automatic_warning_device_top.png"
	},
	on_destruct = infrastructure.stop_bell,
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -1/2, -1/16, 1/16, 0, 1/16},
			{-1/8, 0, -1/8, 1/8, 3/8, 1/8},
			{-1/4, 1/8, -1/4, 1/4, 1/4, 1/4},
			{-1/2, -1/2, -1/16, 1/2, 0, -1/16},
			{-1/8, -1/2, -1/16, 1/8, -1/4, 1/8}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})

minetest.register_node("infrastructure:automatic_warning_device_middle_right_on", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_middle_right_side.png",
		{name="infrastructure_automatic_warning_device_middle_right_anim.png",animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.5}}
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = AUTOMATIC_WARNING_DEVICE_LIGHT_RANGE,
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, -1/16, -1/4, 1/2, -1/16},
			{-1/2, -5/16, -1/16, -7/16, 1/16, 3/16},
			{-1/2, 1/32, -5/16, -15/32, 3/32, -1/16},
			{-15/32, -1/8, -3/16, -13/32, 1/32, -1/16}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})

minetest.register_node("infrastructure:automatic_warning_device_middle_right_off", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_middle_right_side.png",
		"infrastructure_automatic_warning_device_middle_right_off.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-1/2, -1/2, -1/16, -1/4, 1/2, -1/16},
			{-1/2, -5/16, -1/16, -7/16, 1/16, 3/16},
			{-1/2, 1/32, -5/16, -15/32, 3/32, -1/16},
			{-15/32, -1/8, -3/16, -13/32, 1/32, -1/16}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})

minetest.register_node("infrastructure:automatic_warning_device_middle_left_on", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_middle_left_side.png",
		{name="infrastructure_automatic_warning_device_middle_left_anim.png",animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.5}}
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = AUTOMATIC_WARNING_DEVICE_LIGHT_RANGE,
	node_box = {
		type = "fixed",
		fixed = {
			{1/4, -1/2, -1/16, 1/2, 1/2, -1/16},
			{7/16, -5/16, -1/16, 1/2, 1/16, 3/16},
			{15/32, 1/32, -5/16, 1/2, 3/32, -1/16},
			{13/32, -1/8, -3/16, 15/32, 1/32, -1/16}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})

minetest.register_node("infrastructure:automatic_warning_device_middle_left_off", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_middle_left_side.png",
		"infrastructure_automatic_warning_device_middle_left_off.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{1/4, -1/2, -1/16, 1/2, 1/2, -1/16},
			{7/16, -5/16, -1/16, 1/2, 1/16, 3/16},
			{15/32, 1/32, -5/16, 1/2, 3/32, -1/16},
			{13/32, -1/8, -3/16, 15/32, 1/32, -1/16}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})

minetest.register_node("infrastructure:automatic_warning_device_middle_center_on", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_middle_center_side.png",
		"infrastructure_automatic_warning_device_middle_center_side.png",
		"infrastructure_automatic_warning_device_middle_center_side.png",
		{name="infrastructure_automatic_warning_device_middle_center_anim.png",animation={type="vertical_frames", aspect_w=64, aspect_h=64, length=1.5}}
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	light_source = AUTOMATIC_WARNING_DEVICE_LIGHT_RANGE,
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
			{-1/2, -1/2, -1/16, 1/2, 1/2, -1/16},
			{-1/2, -5/16, -1/16, -3/16, 1/16, 3/16},
			{3/16, -5/16, -1/16, 1/2, 1/16, 3/16},
			{-3/16, -3/16, -1/16, 3/16, -1/16, 1/8},
			{-1/2, 1/32, -5/16, -7/32, 3/32, -1/16},
			{-7/32, -1/8, -3/16, -5/32, 1/32, -1/16},
			{7/32, 1/32, -5/16, 1/2, 3/32, -1/16},
			{5/32, -1/8, -3/16, 7/32, 1/32, -1/16}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})


minetest.register_node("infrastructure:automatic_warning_device_middle_center_off", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_middle_center_side.png",
		"infrastructure_automatic_warning_device_middle_center_side.png",
		"infrastructure_automatic_warning_device_middle_center_side.png",
		"infrastructure_automatic_warning_device_middle_center_off.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
			{-1/2, -1/2, -1/16, 1/2, 1/2, -1/16},
			{-1/2, -5/16, -1/16, -3/16, 1/16, 3/16},
			{3/16, -5/16, -1/16, 1/2, 1/16, 3/16},
			{-3/16, -3/16, -1/16, 3/16, -1/16, 1/8},
			{-1/2, 1/32, -5/16, -7/32, 3/32, -1/16},
			{-7/32, -1/8, -3/16, -5/32, 1/32, -1/16},
			{7/32, 1/32, -5/16, 1/2, 3/32, -1/16},
			{5/32, -1/8, -3/16, 7/32, 1/32, -1/16}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})


minetest.register_node("infrastructure:automatic_warning_device_middle", {
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_middle_side.png",
		"infrastructure_automatic_warning_device_middle_side.png",
		"infrastructure_automatic_warning_device_middle_side.png",
		"infrastructure_automatic_warning_device_middle.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3, not_in_creative_inventory = 1},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, -1/2, -1/16, 1/16, 1/2, 1/16},
			{-3/8, -3/8, -1/8, 3/8, 3/8, -1/16},
			{-1/8, -1/8, -1/16, 1/8, 1/8, 1/8}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0}
	}
})

minetest.register_node("infrastructure:automatic_warning_device_bottom", {
	description = "Automatic warning device",
	inventory_image = "infrastructure_automatic_warning_device.png",
	wield_image = "infrastructure_automatic_warning_device.png",
	tiles = {
		"infrastructure_traffic_lights_side.png",
		"infrastructure_traffic_lights_side.png",
		"infrastructure_automatic_warning_device_bottom.png",
		"infrastructure_automatic_warning_device_bottom.png",
		"infrastructure_automatic_warning_device_bottom.png",
		"infrastructure_automatic_warning_device_bottom.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3},
	node_box = {
		type = "fixed",
		fixed = {
			{-1/16, 0, -1/16, 1/16, 1/2, 1/16},
			{-1/2, -1/2, -1/4, 1/2, -3/8, 1/4},
			{-1/4, -1/2, -1/2, 1/4, -3/8, 1/2},
			{-1/8, -3/8, -1/8, 1/8, 0, 1/8}
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
		-- top
			{-1/8, 0 + 3, -1/8, 1/8, 3/8 + 3, 1/8},
			{-1/4, 1/8 + 3, -1/4, 1/4, 1/4 + 3, 1/4},
			{-1/8, -1/2 + 3, -1/16 + 0.01, 1/8, -1/4 + 3, 1/8},
		-- middle center, left and right
			{-9/16, -5/16 + 2, -1/16, -3/16, 1/16 + 2, 3/16},
			{3/16, -5/16 + 2, -1/16, 9/16, 1/16 + 2, 3/16},

			{-3/16, -3/16 + 2, -1/16 + 0.01, 3/16, -1/16 + 2, 1/8},

			{-1/2, 1/32 + 2, -5/16, -7/32, 3/32 + 2, -1/16 - 0.01},
			{-7/32, -1/8 + 2, -3/16, -5/32, 1/32 + 2, -1/16 - 0.01},
			{13/32 - 1, -1/8 + 2, -3/16, 15/32 - 1, 1/32 + 2, -1/16 - 0.01},

			{7/32, 1/32 + 2, -5/16, 1/2, 3/32 + 2, -1/16 - 0.01},
			{5/32, -1/8 + 2, -3/16, 7/32, 1/32 + 2, -1/16 - 0.01},
			{-15/32 + 1, -1/8 + 2, -3/16, -13/32 + 1, 1/32 + 2, -1/16 - 0.01},
		-- middle
			{-3/8, -3/8 + 1, -1/8, 3/8, 3/8 + 1, -1/16},
			{-1/8, -1/8 + 1, -1/16, 1/8, 1/8 + 1, 1/8},
		-- bottom
			{-1/2, -1/2, -1/4, 1/2, -3/8, 1/4},
			{-1/4, -1/2, -1/2, 1/4, -3/8, 1/2},
			{-1/8, -3/8, -1/8, 1/8, 0, 1/8},
		-- post
			{-1/16, 0, -1/16, 1/16, 3, 1/16}
		}
	},
	_digistuff_channelcopier_fieldname = "channel",

	on_construct = function(pos)
		local node = minetest.get_node(pos)
		local param2 = node.param2

		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", "field[channel;Channel;${channel}]")

		pos.y = pos.y + 1
		node.name = "infrastructure:automatic_warning_device_middle"
		minetest.set_node(pos, node)

		pos.y = pos.y + 2
		node.name = "infrastructure:automatic_warning_device_top"
		minetest.set_node(pos, node)

		pos.y = pos.y - 1
		node.name = "infrastructure:automatic_warning_device_middle_center_1"
		minetest.set_node(pos, node)

		infrastructure.left_light_direction(pos, param2)
		node.name = "infrastructure:automatic_warning_device_middle_left_1"
		minetest.set_node(pos, node)

		infrastructure.right_light_direction(pos, param2)
		node.name = "infrastructure:automatic_warning_device_middle_right_1"
		minetest.set_node(pos, node)
	end,

	on_destruct = function(pos)
		local node = minetest.get_node(pos)
		local param2 = node.param2
		pos.y=pos.y+2
		infrastructure.stop_bell(pos, node)
		pos.y=pos.y-2

		for i = 1, 3 do
			pos.y = pos.y + 1
			minetest.remove_node(pos)
		end

		pos.y = pos.y - 1

		infrastructure.left_light_direction(pos, param2)
		minetest.remove_node(pos)

		infrastructure.right_light_direction(pos, param2)
		minetest.remove_node(pos)
	end,

	on_punch = function(pos, node)
		infrastructure.activate_lights(pos, node)
	end,

	on_receive_fields = function(pos, formname, fields, sender)
		if (fields.channel) then
			minetest.get_meta(pos):set_string("channel", fields.channel)
			minetest.get_meta(pos):set_string("state", "Off")
		end
	end,

	digiline = {
		receptor = {},
		effector = {
			action = function(pos, node, channel, msg)
				local setchan = minetest.get_meta(pos):get_string("channel")
				if setchan ~= channel then
					return
				end
				if (msg=="bell_on") then
					infrastructure.play_bell(pos)
				elseif (msg=="bell_off") then
					infrastructure.stop_bell(pos)
				elseif (msg=="lights_on") then
					pos.y = pos.y+2
					infrastructure.lights_enabled(pos)
				elseif (msg=="lights_off") then
					pos.y = pos.y+2	
					infrastructure.lights_disabled(pos)
				end
			end
		}
	}
})




minetest.register_alias("infrastructure:automatic_warning_device", "infrastructure:automatic_warning_device_bottom")
minetest.register_alias("awd", "infrastructure:automatic_warning_device_bottom")
minetest.register_alias("infrastructure:automatic_warning_device_middle_left_1","infrastructure:automatic_warning_device_middle_left_off")
minetest.register_alias("infrastructure:automatic_warning_device_middle_left_2","infrastructure:automatic_warning_device_middle_left_off")
minetest.register_alias("infrastructure:automatic_warning_device_middle_right_1","infrastructure:automatic_warning_device_middle_right_off")
minetest.register_alias("infrastructure:automatic_warning_device_middle_right_2","infrastructure:automatic_warning_device_middle_right_off")
minetest.register_alias("infrastructure:automatic_warning_device_middle_center_1","infrastructure:automatic_warning_device_middle_center_off")
minetest.register_alias("infrastructure:automatic_warning_device_middle_center_2","infrastructure:automatic_warning_device_middle_center_off")
minetest.register_alias("infrastructure:automatic_warning_device_middle_center_3","infrastructure:automatic_warning_device_middle_center_off")
