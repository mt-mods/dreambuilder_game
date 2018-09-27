-- This mod provides your standard green street name signs
-- (that is, the two-up, 2m high ones identifying street intersections),
-- and the larger kind found above or alongside highways
--
-- forked from signs_lib by Diego Martinez et. al

street_signs = {}
street_signs.path = minetest.get_modpath(minetest.get_current_modname())
screwdriver = screwdriver or {}

-- Load support for intllib.
local S, NS = dofile(street_signs.path .. "/intllib.lua")
street_signs.gettext = S

-- text encoding
dofile(street_signs.path .. "/encoding.lua");

local wall_dir_change = {
	[0] = 2,
	2,
	5,
	4,
	2,
	3,
}

street_signs.wallmounted_rotate = function(pos, node, user, mode)
	if mode ~= screwdriver.ROTATE_FACE then return false end
	minetest.swap_node(pos, { name = node.name, param2 = wall_dir_change[node.param2 % 6] })
	for _, v in ipairs(minetest.get_objects_inside_radius(pos, 0.5)) do
		local e = v:get_luaentity()
		if e and e.name == "street_signs:text" then
			v:remove()
		end
	end
	street_signs.update_sign(pos)
	return true
end

street_signs.facedir_rotate = function(pos, node, user, mode)
	if mode ~= screwdriver.ROTATE_FACE then return false end
	newparam2 = ((node.param2 % 6 ) == 0) and 1 or 0
	minetest.swap_node(pos, { name = node.name, param2 = newparam2 })
	for _, v in ipairs(minetest.get_objects_inside_radius(pos, 0.5)) do
		local e = v:get_luaentity()
		if e and e.name == "street_signs:text" then
			v:remove()
		end
	end
	street_signs.update_sign(pos)
	return true
end

street_signs.modpath = minetest.get_modpath("street_signs")

local DEFAULT_TEXT_SCALE = {x=10, y=10}

-- infinite stacks

if not minetest.settings:get_bool("creative_mode") then
	street_signs.expect_infinite_stacks = false
else
	street_signs.expect_infinite_stacks = true
end

-- CONSTANTS

-- Path to the textures.
local TP = street_signs.path .. "/textures"
-- Font file formatter
local CHAR_FILE = "%s_%02x.png"
-- Fonts path
local CHAR_PATH = TP .. "/" .. CHAR_FILE

-- Lots of overkill here. KISS advocates, go away, shoo! ;) -- kaeza

local PNG_HDR = string.char(0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A)

-- check if a file does exist
-- to avoid reopening file after checking again
-- pass TRUE as second argument
function file_exists(name, return_handle, mode)
	mode = mode or "r";
	local f = io.open(name, mode)
	if f ~= nil then
		if (return_handle) then
			return f
		end
		io.close(f) 
		return true 
	else 
		return false 
	end
end

-- Read the image size from a PNG file.
-- Returns image_w, image_h.
-- Only the LSB is read from each field!
local function read_image_size(filename)
	local f = file_exists(filename, true, "rb")
	-- file might not exist (don't crash the game)
	if (not f) then
		return 0, 0
	end
	f:seek("set", 0x0)
	local hdr = f:read(string.len(PNG_HDR))
	if hdr ~= PNG_HDR then
		f:close()
		return
	end
	f:seek("set", 0x13)
	local ws = f:read(1)
	f:seek("set", 0x17)
	local hs = f:read(1)
	f:close()
	return ws:byte(), hs:byte()
end

-- 4 rows, max 80 chars per, plus a bit of fudge to
-- avoid excess trimming (e.g. due to color codes)

local MAX_INPUT_CHARS = 400

-- helper functions to trim sign text input/output

local function trim_input(text)
	return text:sub(1, math.min(MAX_INPUT_CHARS, text:len()))
end

local function build_char_db(font_size)

	local cw = {}

	-- To calculate average char width.
	local total_width = 0
	local char_count = 0

	for c = 32, 255 do
		local w, h = read_image_size(CHAR_PATH:format("street_signs_font_"..font_size.."px", c))
		if w and h then
			local ch = string.char(c)
			cw[ch] = w
			total_width = total_width + w
			char_count = char_count + 1
		end
	end

	local cbw, cbh = read_image_size(TP.."/street_signs_color_"..font_size.."px_n.png")
	assert(cbw and cbh, "error reading bg dimensions")
	return cw, cbw, cbh, (total_width / char_count)
end

street_signs.charwidth15,
street_signs.colorbgw15,
street_signs.lineheight15,
street_signs.avgwidth15 = build_char_db(15)

street_signs.charwidth31,
street_signs.colorbgw31,
street_signs.lineheight31,
street_signs.avgwidth31 = build_char_db(31)

local sign_groups = {choppy=2, dig_immediate=2}
local fences_with_sign = { }

-- some local helper functions

local function split_lines_and_words(text)
	if not text then return end
	local lines = { }
	for _, line in ipairs(text:split("\n")) do
		table.insert(lines, line:split(" "))
	end
	return lines
end

local math_max = math.max

local function fill_line(x, y, w, c, font_size, colorbgw)
	c = c or "0"
	local tex = { }
	for xx = 0, math.max(0, w), colorbgw do
		table.insert(tex, (":%d,%d=street_signs_color_"..font_size.."px_%s.png"):format(x + xx, y, c))
	end
	return table.concat(tex)
end

-- make char texture file name
-- if texture file does not exist use fallback texture instead
local function char_tex(font_name, ch)
	local c = ch:byte()
	local exists, tex = file_exists(CHAR_PATH:format(font_name, c))
	if exists and c ~= 14 then
		tex = CHAR_FILE:format(font_name, c)
	else
		tex = CHAR_FILE:format(font_name, 0x0)
	end
	return tex, exists
end

local function make_line_texture(line, lineno, pos, line_width, line_height, cwidth_tab, font_size, colorbgw)
	local width = 0
	local maxw = 0
	local font_name = "street_signs_font_"..font_size.."px"

	local words = { }
	local node = minetest.get_node(pos)
	local def = minetest.registered_items[node.name]
	local default_color = def.default_color or 0

	local cur_color = tonumber(default_color, 16)

	-- We check which chars are available here.
	for word_i, word in ipairs(line) do
		local chars = { }
		local ch_offs = 0
		local word_l = #word
		local i = 1
		while i <= word_l  do
			local c = word:sub(i, i)
			if c == "#" then
				local cc = tonumber(word:sub(i+1, i+1), 16)
				if cc then
					i = i + 1
					cur_color = cc
				end
			else
				local w = cwidth_tab[c]
				if w then
					width = width + w + 1
					if width >= (line_width - cwidth_tab[" "]) then
						width = 0
					else
						maxw = math_max(width, maxw)
					end
					if #chars < MAX_INPUT_CHARS then
						table.insert(chars, {
							off = ch_offs,
							tex = char_tex(font_name, c),
							col = ("%X"):format(cur_color),
						})
					end
					ch_offs = ch_offs + w
				end
			end
			i = i + 1
		end
		width = width + cwidth_tab[" "] + 1
		maxw = math_max(width, maxw)
		table.insert(words, { chars=chars, w=ch_offs })
	end

	-- Okay, we actually build the "line texture" here.

	local texture = { }

	local start_xpos = math.floor((line_width - maxw) / 2) + def.x_offset

	local xpos = start_xpos
	local ypos = (line_height + def.line_spacing)* lineno + def.y_offset

	cur_color = nil

	for word_i, word in ipairs(words) do
		local xoffs = (xpos - start_xpos)
		if (xoffs > 0) and ((xoffs + word.w) > maxw) then
			table.insert(texture, fill_line(xpos, ypos, maxw, "n", font_size, colorbgw))
			xpos = start_xpos
			ypos = ypos + line_height + def.line_spacing
			lineno = lineno + 1
			if lineno >= def.number_of_lines then break end
			table.insert(texture, fill_line(xpos, ypos, maxw, cur_color, font_size, colorbgw))
		end
		for ch_i, ch in ipairs(word.chars) do
			if ch.col ~= cur_color then
				cur_color = ch.col
				table.insert(texture, fill_line(xpos + ch.off, ypos, maxw, cur_color, font_size, colorbgw))
			end
			table.insert(texture, (":%d,%d=%s"):format(xpos + ch.off, ypos, ch.tex))
		end
		table.insert(
			texture, 
			(":%d,%d="):format(xpos + word.w, ypos) .. char_tex(font_name, " ")
		)
		xpos = xpos + word.w + cwidth_tab[" "]
		if xpos >= (line_width + cwidth_tab[" "]) then break end
	end

	table.insert(texture, fill_line(xpos, ypos, maxw, "n", font_size, colorbgw))
	table.insert(texture, fill_line(start_xpos, ypos + line_height, maxw, "n", font_size, colorbgw))

	return table.concat(texture), lineno
end

local function make_sign_texture(lines, pos)
	local node = minetest.get_node(pos)
	local def = minetest.registered_items[node.name]

	local font_size
	local line_width
	local line_height
	local char_width
	local colorbgw

	if def.font_size and def.font_size == 31 then
		font_size = 31
		line_width = math.floor(street_signs.avgwidth31 * def.chars_per_line) * def.horiz_scaling
		line_height = street_signs.lineheight31
		char_width = street_signs.charwidth31
		colorbgw = street_signs.colorbgw31
	else
		font_size = 15
		line_width = math.floor(street_signs.avgwidth15 * def.chars_per_line) * def.horiz_scaling
		line_height = street_signs.lineheight15
		char_width = street_signs.charwidth15
		colorbgw = street_signs.colorbgw15
	end

	local texture = { ("[combine:%dx%d"):format(line_width, (line_height + def.line_spacing) * def.number_of_lines * def.vert_scaling) }

	local lineno = 0
	for i = 1, #lines do
		if lineno >= def.number_of_lines then break end
		local linetex, ln = make_line_texture(lines[i], lineno, pos, line_width, line_height, char_width, font_size, colorbgw)
		table.insert(texture, linetex)
		lineno = ln + 1
	end
	table.insert(texture, "^[makealpha:0,0,0")
	return table.concat(texture, "")
end

local function set_obj_text(obj, text, x, pos)
	local split = split_lines_and_words
	local text_ansi = Utf8ToAnsi(text)
	local n = minetest.registered_nodes[minetest.get_node(pos).name]
	local text_scale = (n and n.text_scale) or DEFAULT_TEXT_SCALE
	local texture = make_sign_texture(split(text_ansi), pos)
	obj:set_properties({
		textures={texture},
		visual_size = text_scale,
	})
end

street_signs.construct_sign = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string(
		"formspec",
		"size[5,2.25]"..
		"textarea[0.55,0.1;4.5,1.5;text;;${text}]"..
		"button_exit[1.5,1.65;2,1;ok;"..S("Write").."]"..
		"background[-0.20,-0.25;5.41,2.98;street_signs_bg.png]")
	meta:set_string("infotext", "")
end

street_signs.destruct_sign = function(pos)
	local objects = minetest.get_objects_inside_radius(pos, 0.5)
	for _, v in ipairs(objects) do
		local e = v:get_luaentity()
		if e and e.name == "street_signs:text" then
			v:remove()
		end
	end
end

local function make_infotext(text)
	text = trim_input(text)
	local lines = split_lines_and_words(text) or {}
	local lines2 = { }
	for _, line in ipairs(lines) do
		table.insert(lines2, (table.concat(line, " "):gsub("#[0-9a-fA-F]", ""):gsub("##", "#")))
	end
	return table.concat(lines2, "\n")
end

street_signs.update_sign = function(pos, fields)
	local meta = minetest.get_meta(pos)

	local text = fields and fields.text or meta:get_string("text")
	text = trim_input(text)

	meta:set_string("infotext", make_infotext(text).." ")
	meta:set_string("text", text)

	local objects = minetest.get_objects_inside_radius(pos, 0.5)
	local found
	for _, v in ipairs(objects) do
		local e = v:get_luaentity()
		if e and e.name == "street_signs:text" then
			if found then
				v:remove()
			else
				set_obj_text(v, text, nil, pos)
				found = true
			end
		end
	end
	if found then
		return
	end

	-- if there is no entity
	local signnode = minetest.get_node(pos)
	local signname = signnode.name
	local def = minetest.registered_items[signname]
	if not def.entity_info or not def.entity_info.yaw[signnode.param2 + 1] then return end
	local obj = minetest.add_entity(pos, "street_signs:text")

	obj:setyaw(def.entity_info.yaw[signnode.param2 + 1])
	obj:set_properties({
		mesh = def.entity_info.mesh,
	})
end

function street_signs.receive_fields(pos, formname, fields, sender)
	if minetest.is_protected(pos, sender:get_player_name()) then
		minetest.record_protection_violation(pos,
			sender:get_player_name())
		return
	end
	if fields and fields.text and fields.ok then
		minetest.log("action", S("@1 wrote \"@2\" to sign at @3",
			(sender:get_player_name() or ""),
			fields.text:gsub('\\', '\\\\'):gsub("\n", "\\n"),
			minetest.pos_to_string(pos)
		))
		street_signs.update_sign(pos, fields)
	end
end

local lbm_restore_nodes = {}

local cbox = {
	type = "fixed",
	fixed = {
		{ -1/32, 23/16, -1/32, 1/32, 24/16, 1/32 },
		{ -1/32, 18/16, -8/16, 1/32, 23/16, 8/16 },
		{ -1/32, 17/16, -1/32, 1/32, 18/16, 1/32 },
		{ -8/16, 12/16, -1/32, 8/16, 17/16, 1/32 },
		{ -1/16, -8/16, -1/16, 1/16, 12/16, 1/16 },
	}
}

local stdyaw = {
	0,
	math.pi / -2,
	math.pi,
	math.pi / 2,
}

local wmyaw = {
	nil,
	nil,
	math.pi / -2,
	math.pi / 2,
	0,
	math.pi,
}

local on_construct =function(pos) 
	street_signs.construct_sign(pos)
end
local on_destruct = function(pos)
	street_signs.destruct_sign(pos)
end
local on_receive_fields = function(pos, formname, fields, sender)
	street_signs.receive_fields(pos, formname, fields, sender)
end
local on_punch = function(pos, node, puncher)
	street_signs.update_sign(pos)
end

table.insert(lbm_restore_nodes, "street_signs:sign_basic")
table.insert(lbm_restore_nodes, "street_signs:sign_basic_top_only")

minetest.register_node("street_signs:sign_basic", {
	description = "Basic street name sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_basic.obj",
	tiles = { "street_signs_basic.png" },
	groups = {choppy=2, dig_immediate=2},
	default_color = "f",
	on_construct = on_construct,
	on_destruct = on_destruct,
	on_receive_fields = on_receive_fields,
	on_punch = on_punch,
	on_rotate = street_signs.facedir_rotate,
	number_of_lines = 2,
	horiz_scaling = 1,
	vert_scaling = 1,
	line_spacing = 6,
	font_size = 15,
	x_offset = 1,
	y_offset = 3,
	chars_per_line = 30,
	entity_info = {
		mesh = "street_signs_basic_entity.obj",
		yaw = stdyaw
	}
})

cbox = {
	type = "fixed",
	fixed = {
		{ -1/32,  7/16, -1/32, 1/32,  8/16, 1/32 },
		{ -1/32,  2/16, -8/16, 1/32,  7/16, 8/16 },
		{ -1/32,  1/16, -1/32, 1/32,  2/16, 1/32 },
		{ -8/16, -4/16, -1/32, 8/16,  1/16, 1/32 },
		{ -1/16, -8/16, -1/16, 1/16, -4/16, 1/16 },

	}
}

minetest.register_node("street_signs:sign_basic_top_only", {
	description = "Basic street name sign, top only",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_basic_top_only.obj",
	tiles = { "street_signs_basic.png" },
	groups = {choppy=2, dig_immediate=2},
	default_color = "f",
	on_construct = on_construct,
	on_destruct = on_destruct,
	on_receive_fields = on_receive_fields,
	on_punch = on_punch,
	on_rotate = street_signs.facedir_rotate,
	number_of_lines = 2,
	horiz_scaling = 1,
	vert_scaling = 1,
	line_spacing = 6,
	font_size = 15,
	x_offset = 1,
	y_offset = 3,
	chars_per_line = 30,
	entity_info = {
		mesh = "street_signs_basic_top_only_entity.obj",
		yaw = stdyaw
	}
})

local colors = {
	{ "green",  "f", "dye:green",  "dye:white" },
	{ "blue",   "f", "dye:blue",   "dye:white" },
	{ "yellow", "0", "dye:yellow", "dye:black" },
	{ "orange", "0", "dye:orange", "dye:black" }
}

for _, c in ipairs(colors) do

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 0.4375, 1.4375 }
	}

	local color = c[1]
	local defc = c[2]

	table.insert(lbm_restore_nodes, "street_signs:sign_highway_small_"..color)
	table.insert(lbm_restore_nodes, "street_signs:sign_highway_medium_"..color)
	table.insert(lbm_restore_nodes, "street_signs:sign_highway_large_"..color)

	minetest.register_node("street_signs:sign_highway_small_"..color, {
		description = "Small highway sign ("..color..")",
		inventory_image = "street_signs_highway_small_"..color.."_inv.png",
		wield_image = "street_signs_highway_small_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_small.obj",
		tiles = { "street_signs_highway_small_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = on_construct,
		on_destruct = on_destruct,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 3,
		horiz_scaling = 2,
		vert_scaling = 1.15,
		line_spacing = 2,
		font_size = 31,
		x_offset = 9,
		y_offset = 7,
		chars_per_line = 22,
		entity_info = {
			mesh = "street_signs_highway_small_entity.obj",
			yaw = wmyaw
		}
	})
	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 1.4375, 1.4375 }
	}

	minetest.register_node("street_signs:sign_highway_medium_"..color, {
		description = "Medium highway sign ("..color..")",
		inventory_image = "street_signs_highway_medium_"..color.."_inv.png",
		wield_image = "street_signs_highway_medium_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_medium.obj",
		tiles = { "street_signs_highway_medium_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = on_construct,
		on_destruct = on_destruct,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 6,
		horiz_scaling = 2,
		vert_scaling = 0.915,
		line_spacing = 2,
		font_size = 31,
		x_offset = 7,
		y_offset = 10,
		chars_per_line = 22,
		entity_info = {
			mesh = "street_signs_highway_medium_entity.obj",
			yaw = wmyaw
		}
	})

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.4375, -0.4375, -0.375, 1.4375, 2.4375 }
	}

	minetest.register_node("street_signs:sign_highway_large_"..color, {
		description = "Large highway sign ("..color..")",
		inventory_image = "street_signs_highway_large_"..color.."_inv.png",
		wield_image = "street_signs_highway_large_"..color.."_inv.png",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_highway_large.obj",
		tiles = { "street_signs_highway_large_"..color..".png" },
		default_color = defc,
		groups = {choppy=2, dig_immediate=2},
		on_construct = on_construct,
		on_destruct = on_destruct,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = street_signs.wallmounted_rotate,
		number_of_lines = 6,
		horiz_scaling = 2,
		vert_scaling = 0.915,
		line_spacing = 2,
		font_size = 31,
		x_offset = 12,
		y_offset = 11,
		chars_per_line = 25,
		entity_info = {
			mesh = "street_signs_highway_large_entity.obj",
			yaw = wmyaw
		}
	})
end

local after_place_node = function(pos, placer, itemstack, pointed_thing)
	local ppos = minetest.get_pointed_thing_position(pointed_thing)
	local pnode = minetest.get_node(ppos)
	local pdef = minetest.registered_items[pnode.name]
	if (pdef and pdef.drawtype == "fencelike")
	  or string.find(pnode.name, "default:fence_")
	  or pnode.name == "coloredwood:fence"
	  or (pnode.name == "streets:bigpole" and pnode.param2 < 4)
	  or (pnode.name == "streets:bigpole" and pnode.param2 > 19 and pnode.param2 < 24) then
		local node = minetest.get_node(pos)
		minetest.swap_node(pos, {name = itemstack:get_name().."_onpole", param2 = node.param2})
	end
end

for _, m in ipairs({"", "_onpole"}) do

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.3125, -0.3125, -0.4375, 0.3125, 0.3125 }
	}

	local nci = nil
	local on_rotate = street_signs.wallmounted_rotate

	if m ~= "" then
		nci = 1
		on_rotate = nil
		cbox = {
			type = "wallmounted",
			wall_side = { -0.8125, -0.3125, -0.3125, -0.75, 0.3125, 0.3125 }
		}
	end

	table.insert(lbm_restore_nodes, "street_signs:sign_us_route"..m)
	table.insert(lbm_restore_nodes, "street_signs:sign_us_interstate"..m)

	minetest.register_node("street_signs:sign_us_route"..m, {
		description = "Basic \"US Route\" sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_24x24"..m..".obj",
		tiles = { "street_signs_us_route.png" },
		inventory_image = "street_signs_us_route_inv.png",
		wield_image = "street_signs_us_route_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 1,
		horiz_scaling = 3.5,
		vert_scaling = 1.4,
		line_spacing = 6,
		font_size = 31,
		x_offset = 8,
		y_offset = 12,
		chars_per_line = 3,
		entity_info = {
			mesh = "street_signs_regulatory_24x24_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_us_route"
	})

	minetest.register_node("street_signs:sign_us_interstate"..m, {
		description = "Basic US \"Interstate\" sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_us_interstate"..m..".obj",
		tiles = { "street_signs_us_interstate.png" },
		inventory_image = "street_signs_us_interstate_inv.png",
		wield_image = "street_signs_us_interstate_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "f",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 1,
		horiz_scaling = 4.5,
		vert_scaling = 1.4,
		line_spacing = 6,
		font_size = 31,
		x_offset = 8,
		y_offset = 14,
		chars_per_line = 3,
		entity_info = {
			mesh = "street_signs_us_interstate_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_us_interstate"
	})

	if m ~= "" then
		cbox = {
			type = "wallmounted",
			wall_side = { -0.8125, -0.5, -0.5, -0.75, 0.5, 0.5 }
		}
	else
		cbox = {
			type = "wallmounted",
			wall_side = { -0.5, -0.5, -0.5, -0.4375, 0.5, 0.5 }
		}
	end

	table.insert(lbm_restore_nodes, "street_signs:sign_warning_3_line"..m)
	table.insert(lbm_restore_nodes, "street_signs:sign_warning_4_line"..m)
	table.insert(lbm_restore_nodes, "street_signs:sign_warning_orange_3_line"..m)
	table.insert(lbm_restore_nodes, "street_signs:sign_warning_orange_4_line"..m)

	minetest.register_node("street_signs:sign_warning_3_line"..m, {
		description = "Basic US diamond-shaped \"warning\" sign (3-line, yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_warning.png" },
		inventory_image = "street_signs_warning_3_line_inv.png",
		wield_image = "street_signs_warning_3_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 3,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 19,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_3_line"
	})

	minetest.register_node("street_signs:sign_warning_4_line"..m, {
		description = "Basic US diamond-shaped \"warning\" sign (4-line, yellow)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_warning.png" },
		inventory_image = "street_signs_warning_4_line_inv.png",
		wield_image = "street_signs_warning_4_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 4,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 25,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_4_line"
	})

	minetest.register_node("street_signs:sign_warning_orange_3_line"..m, {
		description = "Basic US diamond-shaped \"warning\" sign (3-line, orange)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_warning_orange.png" },
		inventory_image = "street_signs_warning_orange_3_line_inv.png",
		wield_image = "street_signs_warning_orange_3_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 3,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 19,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_orange_3_line"
	})

	minetest.register_node("street_signs:sign_warning_orange_4_line"..m, {
		description = "Basic US diamond-shaped \"warning\" sign (4-line, orange)",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_warning_orange.png" },
		inventory_image = "street_signs_warning_orange_4_line_inv.png",
		wield_image = "street_signs_warning_orange_4_line_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 4,
		horiz_scaling = 1.75,
		vert_scaling = 1.75,
		line_spacing = 1,
		font_size = 15,
		x_offset = 6,
		y_offset = 25,
		chars_per_line = 15,
		entity_info = {
			mesh = "street_signs_warning_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_warning_orange_4_line"
	})

	if m ~= "" then
		cbox = {
			type = "wallmounted",
			wall_side = { -0.8125, -0.625, -0.47, -0.75, 0.625, 0.47 }
		}
	else
		cbox = {
			type = "wallmounted",
			wall_side = { -0.5, -0.625, -0.47, -0.4375, 0.625, 0.47 }
		}
	end

	table.insert(lbm_restore_nodes, "street_signs:sign_speed_limit"..m)

	minetest.register_node("street_signs:sign_speed_limit"..m, {
		description = "Basic speed limit sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x48"..m..".obj",
		tiles = { "street_signs_speed_limit.png" },
		inventory_image = "street_signs_speed_limit_inv.png",
		wield_image = "street_signs_speed_limit_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		on_construct = on_construct,
		on_destruct = on_destruct,
		after_place_node = after_place_node,
		on_receive_fields = on_receive_fields,
		on_punch = on_punch,
		on_rotate = on_rotate,
		number_of_lines = 1,
		horiz_scaling = 2.65,
		vert_scaling = 2.3,
		line_spacing = 1,
		font_size = 31,
		x_offset = 8,
		y_offset = 37,
		chars_per_line = 4,
		entity_info = {
			mesh = "street_signs_regulatory_36x48_entity"..m..".obj",
			yaw = wmyaw
		},
		drop = "street_signs:sign_speed_limit"
	})

-- below this point are image-only signs (i.e. no user-input)

	if m ~= "" then
		cbox = {
			type = "wallmounted",
			wall_side = { -0.8125, -0.5, -0.5, -0.75, 0.5, 0.5 }
		}
	else
		cbox = {
			type = "wallmounted",
			wall_side = { -0.5, -0.5, -0.5, -0.4375, 0.5, 0.5 }
		}
	end

	minetest.register_node("street_signs:sign_stop"..m, {
		description = "Stop sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_stop"..m..".obj",
		tiles = { "street_signs_stop.png" },
		inventory_image = "street_signs_stop_inv.png",
		wield_image = "street_signs_stop_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop"
	})

	minetest.register_node("street_signs:sign_yield"..m, {
		description = "Yield sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_yield"..m..".obj",
		tiles = { "street_signs_yield.png" },
		inventory_image = "street_signs_yield_inv.png",
		wield_image = "street_signs_yield_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_yield"
	})

	minetest.register_node("street_signs:sign_pedestrian_crossing"..m, {
		description = "Pedestrian crossing sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_pedestrian_crossing.png" },
		inventory_image = "street_signs_pedestrian_crossing_inv.png",
		wield_image = "street_signs_pedestrian_crossing_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_pedestrian_crossing"
	})

	minetest.register_node("street_signs:sign_signal_ahead"..m, {
		description = "Traffic signal ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_signal_ahead.png" },
		inventory_image = "street_signs_signal_ahead_inv.png",
		wield_image = "street_signs_signal_ahead_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_signal_ahead"
	})

	minetest.register_node("street_signs:sign_stop_ahead"..m, {
		description = "Stop sign ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_stop_ahead.png" },
		inventory_image = "street_signs_stop_ahead_inv.png",
		wield_image = "street_signs_stop_ahead_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_stop_ahead"
	})

	minetest.register_node("street_signs:sign_yield_ahead"..m, {
		description = "Yield sign ahead",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_yield_ahead.png" },
		inventory_image = "street_signs_yield_ahead_inv.png",
		wield_image = "street_signs_yield_ahead_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_yield_ahead"
	})

	minetest.register_node("street_signs:sign_merging_traffic"..m, {
		description = "Merging traffic sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_merging_traffic.png" },
		inventory_image = "street_signs_merging_traffic_inv.png",
		wield_image = "street_signs_merging_traffic_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_merging_traffic"
	})

	minetest.register_node("street_signs:sign_two_way_traffic"..m, {
		description = "Two-way traffic sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_two_way_traffic.png" },
		inventory_image = "street_signs_two_way_traffic_inv.png",
		wield_image = "street_signs_two_way_traffic_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_two_way_traffic"
	})

	minetest.register_node("street_signs:sign_left_lane_ends"..m, {
		description = "Left lane ends sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_left_lane_ends.png" },
		inventory_image = "street_signs_left_lane_ends_inv.png",
		wield_image = "street_signs_left_lane_ends_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_left_lane_ends"
	})

	minetest.register_node("street_signs:sign_right_lane_ends"..m, {
		description = "Right lane ends sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_warning"..m..".obj",
		tiles = { "street_signs_right_lane_ends.png" },
		inventory_image = "street_signs_right_lane_ends_inv.png",
		wield_image = "street_signs_right_lane_ends_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		default_color = "0",
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_right_lane_ends"
	})

	if m ~= "" then
		cbox = {
			type = "wallmounted",
			wall_side = { -0.8125, -0.625, -0.47, -0.75, 0.625, 0.47 }
		}
	else
		cbox = {
			type = "wallmounted",
			wall_side = { -0.5, -0.625, -0.47, -0.4375, 0.625, 0.47 }
		}
	end

	minetest.register_node("street_signs:sign_keep_right"..m, {
		description = "Keep right sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x48"..m..".obj",
		tiles = { "street_signs_keep_right.png" },
		inventory_image = "street_signs_keep_right_inv.png",
		wield_image = "street_signs_keep_right_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_keep_right"
	})

	if m ~= "" then
		cbox = {
			type = "wallmounted",
			wall_side = { -0.8125, -0.4, -0.5625, -0.75, 0.4, 0.5625 }
		}
	else
		cbox = {
			type = "wallmounted",
			wall_side = { -0.5, -0.4, -0.5625, -0.4375, 0.4, 0.5625 }
		}
	end

	minetest.register_node("street_signs:sign_do_not_enter"..m, {
		description = "Do not enter sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_36x36"..m..".obj",
		tiles = { "street_signs_do_not_enter.png" },
		inventory_image = "street_signs_do_not_enter_inv.png",
		wield_image = "street_signs_do_not_enter_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_do_not_enter"
	})

	minetest.register_node("street_signs:sign_wrong_way"..m, {
		description = "Wrong way sign",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_regulatory_42x30"..m..".obj",
		tiles = { "street_signs_wrong_way.png" },
		inventory_image = "street_signs_wrong_way_inv.png",
		wield_image = "street_signs_wrong_way_inv.png",
		groups = {choppy=2, dig_immediate=2, not_in_creative_inventory = nci},
		after_place_node = after_place_node,
		on_rotate = on_rotate,
		drop = "street_signs:sign_wrong_way"
	})



end

cbox = {
	type = "fixed",
	fixed = { -0.1875, -0.5, -0.25, 0.1875, 0.6125, 0.25 }
}

minetest.register_node("street_signs:sign_stop_for_ped", {
	description = "Pedestrian crossing sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = cbox,
	selection_box = cbox,
	mesh = "street_signs_stop_for_ped.obj",
	tiles = { "street_signs_stop_for_ped.png" },
	inventory_image = "street_signs_stop_for_ped_inv.png",
	groups = {choppy=2, dig_immediate=2},
})

for _, d in ipairs({"l", "c", "r"}) do

	cbox = {
		type = "wallmounted",
		wall_side = { -0.5, -0.45, -0.1875, -0.4375, 0.5, 0.1875 }
	}

	minetest.register_node("street_signs:sign_object_marker_type3_"..d, {
		description = "Type 3 object marker ("..string.upper(d)..")",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_object_marker_type_3.obj",
		tiles = { "street_signs_object_marker_type3_"..d..".png" },
		inventory_image = "street_signs_object_marker_type3_"..d.."_inv.png",
		groups = {choppy=2, dig_immediate=2},
	})
end

local signs_text_on_activate

signs_text_on_activate = function(self)
	local pos = self.object:getpos()
	local meta = minetest.get_meta(pos)
	local signnode = minetest.get_node(pos)
	local signname = signnode.name
	local def = minetest.registered_items[signname]
	local text = meta:get_string("text")
	if text and def and def.entity_info then
		text = trim_input(text)
		set_obj_text(self.object, text, nil, pos)
		self.object:set_properties({
			mesh = def.entity_info.mesh,
		})
	end
end

minetest.register_entity("street_signs:text", {
	collisionbox = { 0, 0, 0, 0, 0, 0 },
	visual = "mesh",
	mesh = "street_signs_basic_entity.obj",
	textures = {},
	on_activate = signs_text_on_activate,
})

-- crafts

minetest.register_craft({
	output = "street_signs:sign_basic",
	recipe = {
		{ "dye:green", "default:sign_wall_steel", "dye:green" },
		{ "dye:white", "default:steel_ingot",     ""          },
		{ "",          "default:steel_ingot",     ""          },
	}
})

minetest.register_craft({
	output = "street_signs:sign_basic",
	recipe = {
		{ "dye:green", "default:sign_wall_steel", "dye:green" },
		{ "",          "default:steel_ingot",     "dye:white" },
		{ "",          "default:steel_ingot",     ""          },
	}
})

minetest.register_craft({
	output = "street_signs:sign_basic_top_only",
	recipe = {
		{ "dye:green", "default:sign_wall_steel", "dye:green" },
		{ "dye:white", "default:steel_ingot",     ""          },

	}
})

minetest.register_craft({
	output = "street_signs:sign_basic_top_only",
	recipe = {
		{ "dye:green", "default:sign_wall_steel", "dye:green" },
		{ "",          "default:steel_ingot",     "dye:white" },
	}
})

minetest.register_craft({
	output = "street_signs:sign_basic",
	recipe = {
		{ "street_signs:sign_basic_top_only" },
		{ "default:steel_ingot" }
	}
})

for _, c in ipairs(colors) do

	local color = c[1]
	local defc =  c[2]
	local dye1 =  c[3]
	local dye2 =  c[4]

	minetest.register_craft({
		output = "street_signs:sign_highway_small_"..color,
		recipe = {
			{ dye1,                      dye2,                      dye1 },
			{ dye1,                      dye2,                      dye1 },
			{ "default:sign_wall_steel", "default:sign_wall_steel", ""   }
		}
	})

	minetest.register_craft({
		output = "street_signs:sign_highway_small_"..color,
		recipe = {
			{ dye1, dye2,                      dye1                      },
			{ dye1, dye2,                      dye1                      },
			{ "",   "default:sign_wall_steel", "default:sign_wall_steel" }
		}
	})

	minetest.register_craft({
		output = "street_signs:sign_highway_medium_"..color,
		recipe = {
			{ "street_signs:sign_highway_small_"..color },
			{ "street_signs:sign_highway_small_"..color }
		}
	})

	minetest.register_craft({
		output = "street_signs:sign_highway_large_"..color,
		recipe = {
			{ "street_signs:sign_highway_small_"..color },
			{ "street_signs:sign_highway_small_"..color },
			{ "street_signs:sign_highway_small_"..color }
		}
	})
end

if minetest.get_modpath("signs_lib") then

	minetest.register_craft({
		output = "street_signs:sign_basic",
		recipe = {
			{ "", "signs:sign_wall_green", "" },
			{ "", "default:steel_ingot",   "" },
			{ "", "default:steel_ingot",   "" },
		}
	})

	minetest.register_craft({
		output = "street_signs:sign_basic_top_only",
		recipe = {
			{ "signs:sign_wall_green" },
			{ "default:steel_ingot" },
		}
	})

	for _, c in ipairs(colors) do

		local color = c[1]
		local defc =  c[2]

		minetest.register_craft({
			output = "street_signs:sign_highway_small_"..color,
			recipe = {
				{ "signs:sign_wall_"..color, "signs:sign_wall_"..color },
			}
		})

		minetest.register_craft({
			output = "street_signs:sign_highway_medium_"..color,
			recipe = {
				{ "signs:sign_wall_"..color, "signs:sign_wall_"..color },
				{ "signs:sign_wall_"..color, "signs:sign_wall_"..color }
			}
		})

		minetest.register_craft({
			output = "street_signs:sign_highway_large_"..color,
			recipe = {
				{ "signs:sign_wall_"..color, "signs:sign_wall_"..color, "signs:sign_wall_"..color },
				{ "signs:sign_wall_"..color, "signs:sign_wall_"..color, "signs:sign_wall_"..color }
			}
		})

	end
end

-- restore signs' text after /clearobjects and the like, the next time
-- a block is reloaded by the server.

minetest.register_lbm({
	nodenames = lbm_restore_nodes,
	name = "street_signs:restore_sign_text",
	label = "Restore sign text",
	run_at_every_load = true,
	action = function(pos, node)
		street_signs.update_sign(pos)
	end
})

-- Convert old road/streets modpack signs to street_signs versions

if minetest.get_modpath("infrastructure") then
	local old_signs = {
		"infrastructure:road_sign_stop",
		"infrastructure:road_sign_stop_on_post",
		"infrastructure:road_sign_yield",
		"infrastructure:road_sign_yield_on_post",
		"infrastructure:road_sign_crosswalk",
		"infrastructure:road_sign_crosswalk_on_post"
	}

	local signs_equiv = {
		["infrastructure:road_sign_stop"]              = "street_signs:sign_stop",
		["infrastructure:road_sign_stop_on_post"]      = "street_signs:sign_stop_onpole",
		["infrastructure:road_sign_yield"]             = "street_signs:sign_yield",
		["infrastructure:road_sign_yield_on_post"]     = "street_signs:sign_yield_onpole",
		["infrastructure:road_sign_crosswalk"]         = "street_signs:sign_pedestrian_crossing",
		["infrastructure:road_sign_crosswalk_on_post"] = "street_signs:sign_pedestrian_crossing_onpole",
	}

	for _, name in ipairs(old_signs) do
		minetest.unregister_item(name)
		if not string.find(name, "on_post") then
			minetest.clear_craft({output = name})
		end
	end

	minetest.register_alias_force("infrastructure:road_sign_retroreflective_surface", "air")
	minetest.register_alias_force("infrastructure:crosswalk_safety_sign_bottom", "street_signs:sign_stop_for_ped")
	minetest.register_alias_force("infrastructure:crosswalk_safety_sign_top", "air")

	minetest.register_lbm({
		nodenames = old_signs,
		name = "street_signs:convert_signs",
		label = "Convert roads/streets modpack signs",
		run_at_every_load = true,
		action = function(pos, node)
			local newname = signs_equiv[node.name]
			local dir = minetest.facedir_to_dir(node.param2)
			if not dir then return end
			minetest.set_node(pos, {name = newname, param2 = minetest.dir_to_wallmounted(dir)})
		end
	})
end

if minetest.settings:get("log_mods") then
	minetest.log("action", S("[MOD] Street signs loaded"))
end
