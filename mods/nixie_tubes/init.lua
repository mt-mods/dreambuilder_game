-- simple nixie tubes mod
-- by Vanessa Ezekowitz

nixie_tubes = {}

local S
if minetest.get_modpath("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end

local nixie_types = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"0",
	"colon",
	"period",
	"off"
}

local tube_cbox = {
	type = "fixed",
	fixed = { -11/32, -8/16, -11/32, 11/32, 8/16, 11/32 }
}

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
		if string.sub(node.name,1,21) == "nixie_tubes:numitron_" then
			minetest.swap_node(pos, { name = "nixie_tubes:numitron_"..msg, param2 = node.param2})
		else
			minetest.swap_node(pos, { name = "nixie_tubes:tube_"..msg, param2 = node.param2})
		end
	end
end

local on_digiline_receive_deca = function(pos, node, channel, msg)

	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	if setchan ~= channel then return end
	local tubenum = string.gsub(node.name, "nixie_tubes:decatron_", "")
	local num = tonumber(msg)

	if msg == "off" or (num and (num >= 0 and num <= 9)) then
		minetest.swap_node(pos, { name = "nixie_tubes:decatron_"..msg, param2 = node.param2})

	elseif msg == "inc" then
		num = (tonumber(tubenum) or 0) + 1
		if num > 9 then
			num = 0
			digiline:receptor_send(pos, digiline.rules.default, channel, "carry")
		end
		minetest.swap_node(pos, { name = "nixie_tubes:decatron_"..num, param2 = node.param2})

	elseif msg == "dec" then
		num = (tonumber(tubenum) or 0) - 1
		if num < 0 then
			num = 9
			digiline:receptor_send(pos, digiline.rules.default, channel, "borrow")
		end
		minetest.swap_node(pos, { name = "nixie_tubes:decatron_"..num, param2 = node.param2})

	elseif msg == "get" then
		digiline:receptor_send(pos, digiline.rules.default, channel, tubenum)

	end
end

-- the nodes:

for _,tube in ipairs(nixie_types) do
	local groups = { cracky = 2, not_in_creative_inventory = 1}
	local light = LIGHT_MAX-4
	local light2 = LIGHT_MAX-5
	local description = S("Nixie Tube ("..tube..")")
	local description2 = S("Decatron ("..tube..")")
	local description3 = S("Numitron Tube")
	local cathode = "nixie_tube_cathode_off.png^nixie_tube_cathode_"..tube..".png"
	local cathode2 = "decatron_cathode_"..tube..".png"
	local cathode3 = "numitron_filaments.png^numitron_"..tube..".png"

	if tube == "off" then
		groups = {cracky = 2}
		light = nil
		light2 = nil
		description = S("Nixie Tube")
		description2 = S("Decatron")
		cathode = "nixie_tube_cathode_off.png"
		cathode2 = "nixie_tube_blank.png"
		cathode3 = "numitron_filaments.png"
	end

	minetest.register_node("nixie_tubes:tube_"..tube, {
		description = description,
		drawtype = "mesh",
		mesh = "nixie_tube.obj",
		tiles = {
			"nixie_tube_base.png",
			"nixie_tube_backing.png",
			cathode,
			"nixie_tube_anode.png",
			"nixie_tube_glass.png",
		},
		use_texture_alpha = true,
		groups = groups,
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = light,
		selection_box = tube_cbox,
		collision_box = tube_cbox,
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
				action = on_digiline_receive_std
			},
		},
		drop = "nixie_tubes:tube_off"
	})

	minetest.register_node("nixie_tubes:numitron_"..tube, {
		description = description3,
		drawtype = "mesh",
		mesh = "nixie_tube.obj",
		tiles = {
			"nixie_tube_base.png",
			"nixie_tube_backing.png",
			cathode3,
			"nixie_tube_anode.png",
			"nixie_tube_glass.png",
		},
		use_texture_alpha = true,
		groups = groups,
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = light,
		selection_box = tube_cbox,
		collision_box = tube_cbox,
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
				action = on_digiline_receive_std
			},
		},
		drop = "nixie_tubes:numitron_off"
	})

	if tube ~= "colon" and tube ~= "period" then
		minetest.register_node("nixie_tubes:decatron_"..tube, {
			description = description2,
			drawtype = "mesh",
			mesh = "decatron.obj",
			tiles = {
				"nixie_tube_base.png",
				"decatron_internals.png",
				"decatron_anode.png",
				"decatron_cathode_pins.png",
				cathode2,
				"nixie_tube_glass.png",
			},
			use_texture_alpha = true,
			groups = groups,
			paramtype = "light",
			paramtype2 = "facedir",
			light_source = light2,
			selection_box = tube_cbox,
			collision_box = tube_cbox,
			after_place_node = function(pos, placer, itemstack, pointed_thing)
				minetest.set_node(pos, { name = "air"})
				minetest.rotate_node(itemstack, placer, pointed_thing)
				if minetest.get_node(pos).param2 == 12 then
					minetest.set_node(pos, { name = "nixie_tubes:decatron_off", param2 = 15 })
				end
			end,
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
					action = on_digiline_receive_deca
				},
			},
			drop = "nixie_tubes:decatron_off"
		})
	end
end

-- Alpha-numeric tubes (Burroughs B-7971 or similar)

--[[

Map of display wires:

      --1------
     |\   |8  /|
    6| \  |  / |2
     | 7\ | /9 |
     |   \|/   |
14--> ---- ---- <--10
     |   /|\   |
     |13/ | \11|
    5| /  |  \ |3
     |/ 12|   \|
      ------4--
          _
      --¯¯ ¯¯-- <--15

-- Wire positions in table:
-- char = { 1, 2, 3, 4, .... , 13, 14, 15 }

]]--

local alnum_chars = {
	{ string.char(31),	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,1 } },	-- "cursor" segment
	{ " ",	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0 } },	-- 32
	{ "!",	{ 0,0,0,0,1,1,0,0,0,0,0,0,0,0,0 } },
	{ '"',	{ 0,0,0,0,0,1,0,1,0,0,0,0,0,0,0 } },
	{ "#",	{ 0,1,1,1,0,0,0,1,0,1,0,1,0,1,0 } },
	{ "$",	{ 1,0,1,1,0,1,0,1,0,1,0,1,0,1,0 } },
	{ "%",	{ 0,0,1,0,0,1,0,0,1,0,0,0,1,0,0 } },
	{ "&",	{ 1,0,0,1,1,0,1,0,1,0,1,0,0,1,0 } },
	{ "'",	{ 0,0,0,0,0,0,0,1,0,0,0,0,0,0,0 } },
	{ "(",	{ 0,0,0,0,0,0,0,0,1,0,1,0,0,0,0 } },
	{ ")",	{ 0,0,0,0,0,0,1,0,0,0,0,0,1,0,0 } },
	{ "*",	{ 0,0,0,0,0,0,1,1,1,1,1,1,1,1,0 } },
	{ "+",	{ 0,0,0,0,0,0,0,1,0,1,0,1,0,1,0 } },
	{ ",",	{ 0,0,0,0,0,0,0,0,0,0,0,0,1,0,0 } },
	{ "-",	{ 0,0,0,0,0,0,0,0,0,0,0,0,0,1,0 } },
	{ ".",	{ 0,0,0,0,1,0,0,0,0,0,0,0,0,0,0 } },
	{ "/",	{ 0,0,0,0,0,0,0,0,1,0,0,0,1,0,0 } },
	{ "0",	{ 1,1,1,1,1,1,0,0,1,0,0,0,1,0,0 } },	-- 48
	{ "1",	{ 0,1,1,0,0,0,0,0,1,0,0,0,0,0,0 } },
	{ "2",	{ 1,1,0,1,0,0,0,0,0,1,0,0,1,0,0 } },
	{ "3",	{ 1,1,1,1,0,0,0,0,0,1,0,0,0,0,0 } },
	{ "4",	{ 0,1,1,0,0,1,0,0,0,1,0,0,0,1,0 } },
	{ "5",	{ 1,0,1,1,0,1,0,0,0,1,0,0,0,1,0 } },
	{ "6",	{ 1,0,1,1,1,1,0,0,0,1,0,0,0,1,0 } },
	{ "7",	{ 1,0,0,0,0,0,0,0,1,0,0,1,0,0,0 } },
	{ "8",	{ 1,1,1,1,1,1,0,0,0,1,0,0,0,1,0 } },
	{ "9",	{ 1,1,1,0,0,1,0,0,0,1,0,0,0,1,0 } },
	{ ":",	{ 0,0,0,0,0,0,0,1,0,0,0,1,0,0,0 } },	-- 58
	{ ";",	{ 0,0,0,0,0,0,0,1,0,0,0,0,1,0,0 } },
	{ "<",	{ 0,0,0,0,0,0,0,0,1,0,1,0,0,1,0 } },
	{ "=",	{ 0,0,0,1,0,0,0,0,0,1,0,0,0,1,0 } },
	{ ">",	{ 0,0,0,0,0,0,1,0,0,1,0,0,1,0,0 } },
	{ "?",	{ 1,1,0,0,0,0,0,0,0,1,0,1,0,0,0 } },
	{ "@",	{ 1,1,0,1,1,1,0,1,0,1,0,0,0,0,0 } },	-- 64
	{ "A",	{ 1,1,1,0,1,1,0,0,0,1,0,0,0,1,0 } },
	{ "B",	{ 1,1,1,1,0,0,0,1,0,1,0,1,0,0,0 } },
	{ "C",	{ 1,0,0,1,1,1,0,0,0,0,0,0,0,0,0 } },
	{ "D",	{ 1,1,1,1,0,0,0,1,0,0,0,1,0,0,0 } },
	{ "E",	{ 1,0,0,1,1,1,0,0,0,0,0,0,0,1,0 } },
	{ "F",	{ 1,0,0,0,1,1,0,0,0,0,0,0,0,1,0 } },
	{ "G",	{ 1,0,1,1,1,1,0,0,0,1,0,0,0,0,0 } },
	{ "H",	{ 0,1,1,0,1,1,0,0,0,1,0,0,0,1,0 } },
	{ "I",	{ 1,0,0,1,0,0,0,1,0,0,0,1,0,0,0 } },
	{ "J",	{ 0,1,1,1,1,0,0,0,0,0,0,0,0,0,0 } },
	{ "K",	{ 0,0,0,0,1,1,0,0,1,0,1,0,0,1,0 } },
	{ "L",	{ 0,0,0,1,1,1,0,0,0,0,0,0,0,0,0 } },
	{ "M",	{ 0,1,1,0,1,1,1,0,1,0,0,0,0,0,0 } },
	{ "N",	{ 0,1,1,0,1,1,1,0,0,0,1,0,0,0,0 } },
	{ "O",	{ 1,1,1,1,1,1,0,0,0,0,0,0,0,0,0 } },
	{ "P",	{ 1,1,0,0,1,1,0,0,0,1,0,0,0,1,0 } },
	{ "Q",	{ 1,1,1,1,1,1,0,0,0,0,1,0,0,0,0 } },
	{ "R",	{ 1,1,0,0,1,1,0,0,0,1,1,0,0,1,0 } },
	{ "S",	{ 1,0,1,1,0,1,0,0,0,1,0,0,0,1,0 } },
	{ "T",	{ 1,0,0,0,0,0,0,1,0,0,0,1,0,0,0 } },
	{ "U",	{ 0,1,1,1,1,1,0,0,0,0,0,0,0,0,0 } },
	{ "V",	{ 0,0,0,0,1,1,0,0,1,0,0,0,1,0,0 } },
	{ "W",	{ 0,1,1,0,1,1,0,0,0,0,1,0,1,0,0 } },
	{ "X",	{ 0,0,0,0,0,0,1,0,1,0,1,0,1,0,0 } },
	{ "Y",	{ 0,0,0,0,0,0,1,0,1,0,0,1,0,0,0 } },
	{ "Z",	{ 1,0,0,1,0,0,0,0,1,0,0,0,1,0,0 } },
	{ "[",	{ 1,0,0,1,1,1,0,0,0,0,0,0,0,0,0 } },	-- 91
	{ "\\",	{ 0,0,0,0,0,0,1,0,0,0,1,0,0,0,0 } },
	{ "]",	{ 1,1,1,1,0,0,0,0,0,0,0,0,0,0,0 } },
	{ "^",	{ 0,0,0,0,0,0,0,0,0,0,1,0,1,0,0 } },
	{ "_",	{ 0,0,0,1,0,0,0,0,0,0,0,0,0,0,0 } },
	{ "`",	{ 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0 } },
	{ "a",	{ 1,1,1,1,0,0,0,0,0,1,0,0,1,0,0 } },	-- 97
	{ "b",	{ 0,0,0,1,1,1,0,0,0,0,1,0,0,1,0 } },
	{ "c",	{ 0,0,0,1,1,0,0,0,0,1,0,0,0,1,0 } },
	{ "d",	{ 0,1,1,1,0,0,0,0,0,1,0,0,1,0,0 } },
	{ "e",	{ 0,0,0,1,1,0,0,0,0,0,0,0,1,1,0 } },
	{ "f",	{ 1,0,0,0,1,1,0,0,0,0,0,0,0,1,0 } },
	{ "g",	{ 1,1,1,1,0,0,1,0,0,1,0,0,0,0,0 } },
	{ "h",	{ 0,0,0,0,1,1,0,0,0,0,1,0,0,1,0 } },
	{ "i",	{ 0,0,0,0,0,0,0,0,0,0,0,1,0,0,0 } },
	{ "j",	{ 0,1,1,1,0,0,0,0,0,0,0,0,0,0,0 } },
	{ "k",	{ 0,0,0,0,0,0,0,1,1,0,1,1,0,0,0 } },
	{ "l",	{ 0,0,0,0,0,0,0,1,0,0,0,1,0,0,0 } },
	{ "m",	{ 0,0,1,0,1,0,0,0,0,1,0,1,0,1,0 } },
	{ "n",	{ 0,0,0,0,1,0,0,0,0,0,1,0,0,1,0 } },
	{ "o",	{ 0,0,1,1,1,0,0,0,0,1,0,0,0,1,0 } },
	{ "p",	{ 1,0,0,0,1,1,0,0,1,0,0,0,0,1,0 } },
	{ "q",	{ 1,1,1,0,0,0,1,0,0,1,0,0,0,0,0 } },
	{ "r",	{ 0,0,0,0,1,0,0,0,0,0,0,0,0,1,0 } },
	{ "s",	{ 0,0,0,1,0,0,0,0,0,1,1,0,0,0,0 } },
	{ "t",	{ 0,0,0,1,1,1,0,0,0,0,0,0,0,1,0 } },
	{ "u",	{ 0,0,1,1,1,0,0,0,0,0,0,0,0,0,0 } },
	{ "v",	{ 0,0,0,0,1,0,0,0,0,0,0,0,1,0,0 } },
	{ "w",	{ 0,0,1,0,1,0,0,0,0,0,1,0,1,0,0 } },
	{ "x",	{ 0,0,0,0,0,0,1,0,1,0,1,0,1,0,0 } },
	{ "y",	{ 0,0,0,0,0,0,1,0,1,0,0,0,1,0,0 } },
	{ "z",	{ 0,0,0,4,0,0,0,0,0,0,0,0,1,1,0 } },
	{ "{",	{ 1,0,0,1,0,0,1,0,0,0,0,0,1,1,0 } },
	{ "|",	{ 0,0,0,0,0,0,0,1,0,0,0,1,0,0,0 } },
	{ "}",	{ 1,0,0,1,0,0,0,0,1,1,1,0,0,0,0 } },
	{ "~",	{ 0,1,0,0,0,1,1,0,0,1,0,0,0,0,0 } },
	{ string.char(127),	{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,0 } },	-- "DEL"
	{ string.char(144),	{ 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1 } },	-- all-on
}

local fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 },
}

local padding = " "
local allon = string.char(128)
for i = 1, 64 do
	padding = padding.." "
	allon = allon..string.char(128)
end

local display_string = function(pos, channel, string)
	if string == "off_multi" then
		string = ""
	elseif string == "allon_multi" then
		string = allon
	end
	local padded_string = string.sub(string..padding, 1, 64)
	local fdir = minetest.get_node(pos).param2 % 4
	local pos2 = pos
	for i = 1, 64 do
		local node = minetest.get_node(pos2)
		local meta = minetest.get_meta(pos2)
		local setchan = meta:get_string("channel")
		if not string.match(node.name, "nixie_tubes:alnum_") or (setchan ~= nil and setchan ~= "" and setchan ~= channel) then break end
		local asc = string.byte(padded_string, i, i)
		if node.param2 == fdir and ((asc > 30 and asc < 128) or asc == 144) then
			minetest.swap_node(pos2, { name = "nixie_tubes:alnum_"..asc, param2 = node.param2})
		end
		pos2.x = pos2.x + fdir_to_right[fdir+1][1]
		pos2.z = pos2.z + fdir_to_right[fdir+1][2]
	end
end

local on_digiline_receive_alnum = function(pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	if setchan ~= channel then return end
	if msg and msg ~= "" and type(msg) == "string" then
		if string.len(msg) > 1 then
			if msg == "off" then
				minetest.swap_node(pos, { name = "nixie_tubes:alnum_32", param2 = node.param2})
			elseif msg == "colon" then
				minetest.swap_node(pos, { name = "nixie_tubes:alnum_58", param2 = node.param2})
			elseif msg == "period" then
				minetest.swap_node(pos, { name = "nixie_tubes:alnum_46", param2 = node.param2})
			elseif msg == "del" then
				minetest.swap_node(pos, { name = "nixie_tubes:alnum_127", param2 = node.param2})
			elseif msg == "allon" then
				minetest.swap_node(pos, { name = "nixie_tubes:alnum_144", param2 = node.param2})
			elseif msg == "cursor" then
				minetest.swap_node(pos, { name = "nixie_tubes:alnum_31", param2 = node.param2})
			else
				display_string(pos, channel, msg)
			end
		else
			local asc = string.byte(msg)
			if (asc > 30 and asc < 128) or asc == 144 then
				minetest.swap_node(pos, { name = "nixie_tubes:alnum_"..asc, param2 = node.param2})
			elseif msg == "get" then -- get value as ASCII numerical value
				digiline:receptor_send(pos, digiline.rules.default, channel, tonumber(string.match(minetest.get_node(pos).name,"nixie_tubes:alnum_(.+)"))) -- wonderfully horrible string manipulaiton
			elseif msg == "getstr" then -- get actual char
				digiline:receptor_send(pos, digiline.rules.default, channel, string.char(tonumber(string.match(minetest.get_node(pos).name,"nixie_tubes:alnum_(.+)"))))
			end
		end
	elseif msg and type(msg) == "number" then
		if msg == 0 then
			minetest.swap_node(pos, { name = "nixie_tubes:alnum_32", param2 = node.param2})
		elseif (msg > 30 and msg < 128) or msg == 144 then
			minetest.swap_node(pos, { name = "nixie_tubes:alnum_"..tostring(msg), param2 = node.param2})
		end
	end
end

for i in ipairs(alnum_chars) do
	local char = alnum_chars[i][1]
	local bits = alnum_chars[i][2]

	local groups = { cracky = 2, not_in_creative_inventory = 1}
	local light = LIGHT_MAX-4
	local description = S("Alphanumeric Nixie Tube ("..char..")")

	local wires = "nixie_tube_alnum_wires.png"
	for j = 1, 15 do
		if bits[j] == 1 then
			wires = wires.."^nixie_tube_alnum_seg_"..j..".png"
		end
	end

	if char == " " then
		groups = {cracky = 2}
		light = nil
		description = S("Alphanumeric Nixie Tube")
		wires = "nixie_tube_alnum_wires.png"
	end

	minetest.register_node("nixie_tubes:alnum_"..string.byte(char), {
		description = description,
		drawtype = "mesh",
		mesh = "nixie_tube.obj",
		tiles = {
			"nixie_tube_base.png",
			"nixie_tube_backing.png",
			wires,
			"nixie_tube_anode.png",
			"nixie_tube_glass.png",
		},
		use_texture_alpha = true,
		groups = groups,
		paramtype = "light",
		paramtype2 = "facedir",
		light_source = light,
		selection_box = tube_cbox,
		collision_box = tube_cbox,
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
				action = on_digiline_receive_alnum
			},
		},
		drop = "nixie_tubes:alnum_32"
	})
end

-- crafts

minetest.register_craft({
	output = "nixie_tubes:tube_off 4",
	recipe = {
		{ "", "default:glass", "" },
		{ "default:glass", "default:sign_wall", "default:glass" },
		{ "default:glass", "default:mese_crystal_fragment", "default:glass" }
	},
})

minetest.register_craft({
	output = "nixie_tubes:numitron_off 4",
	recipe = {
		{ "", "default:glass", "" },
		{ "default:glass", "default:copper_ingot", "default:glass" },
		{ "default:glass", "default:mese_crystal_fragment", "default:glass" }
	},
})


minetest.register_craft({
	output = "nixie_tubes:alnum_32 4",
	recipe = {
		{ "", "default:glass", "" },
		{ "default:glass", "default:sign_wall", "default:glass" },
		{ "default:glass", "default:mese_crystal", "default:glass" }
	},
})

