-- simple LED marquee mod
-- by Vanessa Dannenberg

led_marquee = {}

local S
if minetest.get_modpath("intllib") then
	S = intllib.make_gettext_pair()
else
	S = function(s) return s end
end

-- the following functions based on the so-named ones in Jeija's digilines mod

local reset_meta = function(pos)
	minetest.get_meta(pos):set_string("formspec", "field[channel;Channel;${channel}]")
end

local on_digiline_receive_std = function(pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	if setchan ~= channel then return end
	local num = tonumber(msg)
	if msg == "colon" or msg == "period" or msg == "off" or (num and (num >= 0 and num <= 9)) then
			minetest.swap_node(pos, { name = "led_marquee:marquee_"..msg, param2 = node.param2})
	end
end

-- convert Lua's idea of a UTF-8 char to ISO-8859-1

-- first char is non-break space, 0xA0
local iso_chars=" ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷øùúûüýþÿ"

local get_iso = function(c)
	local hb = string.byte(c,1) or 0
	local lb = string.byte(c,2) or 0
	local dec = lb+hb*256
	local char = dec - 49664
	if dec > 49855 then char = dec - 49856 end
	return char
end

local make_iso = function(s)
	local i = 1
	local s2 = ""
	while i <= string.len(s) do
		if string.byte(s,i) > 159 then
			s2 = s2..string.char(get_iso(string.sub(s, i, i+1)))
			i = i + 2
		else
			s2 = s2..string.sub(s, i, i)
			i = i + 1
		end
	end
	return s2
end

-- scrolling

led_marquee.set_timer = function(pos, timeout)
	local timer = minetest.get_node_timer(pos)
	timer:stop()
	if timeout > 0 then
		local meta = minetest.get_meta(pos)
		timer:start(timeout)
	end
end

led_marquee.scroll_text = function(pos, elapsed, skip)
	local meta = minetest.get_meta(pos)
	local msg = meta:get_string("last_msg")
	local channel = meta:get_string("channel")
	local index = meta:get_int("index")
	if not index or index < 1 or not string.byte(msg, index) then index = 1 end
	local len = string.len(msg)
	skip = skip or 1

	index = index + skip

	while index < len and string.byte(msg, index) < 28 do
		index = index + 1
		if index > len then index = 1 break end
	end

	if string.byte(msg, index - 1) < 28 then
		led_marquee.display_msg(pos, channel, string.sub(msg, index - 1)..string.rep(" ", skip + 1))
	else
		local i = index - 1
		local color = ""
		while i > 0 and string.byte(msg, i) > 27 do
			i = i - 1
			if i == 0 then break end
		end
		if i > 0 then color = string.sub(msg, i, i) end
		led_marquee.display_msg(pos, channel, color..string.sub(msg, index)..string.rep(" ", skip + 1))
	end

	meta:set_int("index", index)
	if not elapsed or elapsed < 0.5 then return false end
	return true
end

-- the nodes:

local fdir_to_right = {
	{  0, -1 },
	{  0, -1 },
	{  0, -1 },
	{  0,  1 },
	{  1,  0 },
	{ -1,  0 },
}

local cbox = {
	type = "wallmounted",
	wall_top = { -8/16, 7/16, -8/16, 8/16, 8/16, 8/16 },
	wall_bottom = { -8/16, -8/16, -8/16, 8/16, -7/16, 8/16 },
	wall_side = { -8/16, -8/16, -8/16, -7/16, 8/16, 8/16 }
}

led_marquee.display_msg = function(pos, channel, msg)
	msg = string.sub(msg, 1, 4096)
	if string.sub(msg,1,1) == string.char(255) then -- treat it as incoming UTF-8
		msg = make_iso(string.sub(msg, 2, 4096))
	end

	local master_fdir = minetest.get_node(pos).param2 % 8
	local master_meta = minetest.get_meta(pos)
	local last_color = master_meta:get_int("last_color")
	local pos2 = table.copy(pos)
	if not last_color or last_color < 0 or last_color > 27 then
		last_color = 0
		master_meta:set_int("last_color", 0)
	end
	local i = 1
	local len = string.len(msg)
	local wrapped = nil
	while i <= len do
		local node = minetest.get_node(pos2)
		local fdir = node.param2 % 8
		local meta = minetest.get_meta(pos2)
		local setchan = nil
		if meta then setchan = meta:get_string("channel") end
		local asc = string.byte(msg, i, i)
		if not string.match(node.name, "led_marquee:char_") then
			if not wrapped then
				pos2.x = pos.x
				pos2.y = pos2.y-1
				pos2.z = pos.z
				wrapped = true
			else
				break
			end
		elseif string.match(node.name, "led_marquee:char_")
			and fdir ~= master_fdir or (setchan ~= nil and setchan ~= "" and setchan ~= channel) then
			break
		elseif asc == 28 then
			pos2.x = pos.x
			pos2.y = pos2.y-1
			pos2.z = pos.z
			i = i + 1
			wrapped = nil
		elseif asc == 29 then
			local c = string.byte(msg, i+1, i+1) or 0
			local r = string.byte(msg, i+2, i+2) or 0
			pos2.x = pos.x + (fdir_to_right[fdir+1][1])*c
			pos2.y = pos.y - r
			pos2.z = pos.z + (fdir_to_right[fdir+1][2])*c
			i = i + 3
			wrapped = nil
		elseif asc > 30 and asc < 256 then
			minetest.swap_node(pos2, { name = "led_marquee:char_"..asc, param2 = master_fdir + (last_color*8)})
			pos2.x = pos2.x + fdir_to_right[fdir+1][1]
			pos2.z = pos2.z + fdir_to_right[fdir+1][2]
			i = i + 1
			wrapped = nil
		elseif asc < 28 then
			last_color = asc
			master_meta:set_int("last_color", asc)
			i = i + 1
			wrapped = nil
		end
	end
end

local on_digiline_receive_string = function(pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	local last_color = meta:get_int("last_color")
	if not last_color or last_color < 0 or last_color > 27 then
		last_color = 0
		meta:set_int("last_color", 0)
	end
	local fdir = node.param2 % 8

	if setchan ~= channel then return end
	if msg and msg ~= "" and type(msg) == "string" then
		if string.len(msg) > 1 then
			if msg == "clear" then
				led_marquee.set_timer(pos, 0)
				msg = string.rep(" ", 2048)
				meta:set_string("last_msg", msg)
				led_marquee.display_msg(pos, channel, msg)
				meta:set_int("index", 1)
			elseif msg == "allon" then
				led_marquee.set_timer(pos, 0)
				msg = string.rep(string.char(144), 2048)
				meta:set_string("last_msg", msg)
				led_marquee.display_msg(pos, channel, msg)
				meta:set_int("index", 1)
			elseif msg == "start_scroll" then
				local timeout = meta:get_int("timeout")
				if not timeout or timeout < 0.5 or timeout > 5 then timeout = 0 end
				led_marquee.set_timer(pos, timeout)
			elseif msg == "stop_scroll" then
				led_marquee.set_timer(pos, 0)
				return
			elseif string.sub(msg, 1, 12) == "scroll_speed" then
				local timeout = tonumber(string.sub(msg, 13))
				if not timeout or timeout < 0.5 or timeout > 5 then timeout = 0 end
				meta:set_int("timeout", timeout)
				led_marquee.set_timer(pos, timeout)
			elseif string.sub(msg, 1, 11) == "scroll_step" then
				local skip = tonumber(string.sub(msg, 12))
				led_marquee.scroll_text(pos, nil, skip)
			elseif msg == "get" then -- get the master panel's displayed char as ASCII numerical value
				digilines.receptor_send(pos, digiline.rules.default, channel, tonumber(string.match(minetest.get_node(pos).name,"led_marquee:char_(.+)"))) -- wonderfully horrible string manipulaiton
			elseif msg == "getstr" then -- get the last stored message
				digilines.receptor_send(pos, digiline.rules.default, channel, meta:get_string("last_msg"))
			elseif msg == "getindex" then -- get the scroll index
				digilines.receptor_send(pos, digiline.rules.default, channel, meta:get_int("index"))
			else
				led_marquee.set_timer(pos, 0)
				meta:set_string("last_msg", msg)
				led_marquee.display_msg(pos, channel, msg)
				meta:set_int("index", 1)
			end
		else
			local asc = string.byte(msg)
			if asc > 30 and asc < 256 then
				minetest.swap_node(pos, { name = "led_marquee:char_"..asc, param2 = fdir + (last_color*8)})
				meta:set_string("last_msg", tostring(msg))
				meta:set_int("index", 1)
			elseif asc < 28 then
				last_color = asc
				meta:set_int("last_color", asc)
			end
		end
	elseif msg and type(msg) == "number" then
		meta:set_string("last_msg", tostring(msg))
		led_marquee.display_msg(pos, channel, tostring(msg))
		meta:set_int("index", 1)
	end
end

-- the nodes!

for i = 31, 255 do
	local groups = { cracky = 2, not_in_creative_inventory = 1}
	local light = LIGHT_MAX-2
	local description = S("Alphanumeric LED marquee panel ("..i..")")
	local tiles = {
				{ name="led_marquee_base.png", color="white"},
				{ name="led_marquee_leds_off.png", color="white"},
				"led_marquee_char_"..i..".png",
			}

	if i == 31 then
		tiles = {
			{ name="led_marquee_base.png", color="white"},
			{ name="led_marquee_leds_off.png", color="white"},
				{
				name = "led_marquee_char_31.png",
				animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 0.75}
				}
		}
	end

	if i == 32 then
		groups = {cracky = 2}
		light = nil
		description = S("Alphanumeric LED marquee panel")
	end

	minetest.register_node("led_marquee:char_"..i, {
		description = description,
		drawtype = "mesh",
		mesh = "led_marquee.obj",
		tiles = tiles,
		palette="led_marquee_palette.png",
		use_texture_alpha = true,
		groups = groups,
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		light_source = light,
		selection_box = cbox,
		node_box = cbox,
		on_construct = function(pos)
			reset_meta(pos)
		end,
		on_receive_fields = function(pos, formname, fields, sender)
			if (fields.channel) then
				minetest.get_meta(pos):set_string("channel", fields.channel)
			end
		end,
		digiline = {
			receptor = {},
			effector = {
				action = on_digiline_receive_string,
			},
		},
		drop = "led_marquee:char_32",
		on_timer = led_marquee.scroll_text
	})
end

-- crafts

minetest.register_craft({
	output = "led_marquee:char_32 6",
	recipe = {
		{ "default:glass", "default:glass", "default:glass" },
		{ "mesecons_lamp:lamp_off", "mesecons_lamp:lamp_off", "mesecons_lamp:lamp_off" },
		{ "group:wood", "mesecons_microcontroller:microcontroller0000", "group:wood" }
	},
})

