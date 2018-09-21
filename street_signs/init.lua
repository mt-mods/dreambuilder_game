-- This mod provides basic green two-stack street name signs
-- forked from signs_lib by Diego Martinez et. al

street_signs = {}
street_signs.path = minetest.get_modpath(minetest.get_current_modname())
screwdriver = screwdriver or {}

-- Load support for intllib.
local S, NS = dofile(street_signs.path .. "/intllib.lua")
street_signs.gettext = S

-- text encoding
dofile(street_signs.path .. "/encoding.lua");

street_signs.wallmounted_rotate = function(pos, node, user, mode, new_param2)
	if mode ~= screwdriver.ROTATE_AXIS then return false end
	minetest.swap_node(pos, {name = node.name, param2 = (node.param2 + 1) % 6})
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

street_signs.standard_sign_model = {
	nodebox = {
		type = "fixed",
		fixed = {
			{ -1/32, 23/16, -1/32, 1/32, 24/16, 1/32 },
			{ -1/32, 18/16, -8/16, 1/32, 23/16, 8/16 },
			{ -1/32, 17/16, -1/32, 1/32, 18/16, 1/32 },
			{ -8/16, 12/16, -1/32, 8/16, 17/16, 1/32 },
			{ -1/16, -8/16, -1/16, 1/16, 12/16, 1/16 },
		}
	},
	yaw = {
		0,
		math.pi / -2,
		math.pi,
		math.pi / 2,
	}
}

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

-- Font name.
local font_name = "street_signs_font"

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

-- Set by build_char_db()
local LINE_HEIGHT
local SIGN_WIDTH
local COLORBGW, COLORBGH

-- Size of the canvas, in characters.
-- Please note that CHARS_PER_LINE is multiplied by the average character
-- width to get the total width of the canvas, so for proportional fonts,
-- either more or fewer characters may fit on a line.
local CHARS_PER_LINE = 30
local NUMBER_OF_LINES = 4

-- 4 rows, max 80 chars per, plus a bit of fudge to
-- avoid excess trimming (e.g. due to color codes)

local MAX_INPUT_CHARS = 400

-- This holds the individual character widths.
-- Indexed by the actual character (e.g. charwidth["A"])
local charwidth

-- helper functions to trim sign text input/output

local function trim_input(text)
	return text:sub(1, math.min(MAX_INPUT_CHARS, text:len()))
end

local function build_char_db()

	charwidth = { }

	-- To calculate average char width.
	local total_width = 0
	local char_count = 0

	for c = 32, 255 do
		local w, h = read_image_size(CHAR_PATH:format(font_name, c))
		if w and h then
			local ch = string.char(c)
			charwidth[ch] = w
			total_width = total_width + w
			char_count = char_count + 1
		end
	end

	COLORBGW, COLORBGH = read_image_size(TP.."/street_signs_color_n.png")
	assert(COLORBGW and COLORBGH, "error reading bg dimensions")
	LINE_HEIGHT = COLORBGH + 6

	-- XXX: Is there a better way to calc this?
	SIGN_WIDTH = math.floor((total_width / char_count) * CHARS_PER_LINE)

end

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

local function fill_line(x, y, w, c)
	c = c or "0"
	local tex = { }
	for xx = 0, math.max(0, w), COLORBGW do
		table.insert(tex, (":%d,%d=street_signs_color_%s.png"):format(x + xx, y, c))
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

local function make_line_texture(line, lineno, pos)

	local width = 0
	local maxw = 0

	local words = { }
	local n = minetest.registered_nodes[minetest.get_node(pos).name]
	local default_color = n.default_color or 0

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
				local w = charwidth[c]
				if w then
					width = width + w + 1
					if width >= (SIGN_WIDTH - charwidth[" "]) then
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
		width = width + charwidth[" "] + 1
		maxw = math_max(width, maxw)
		table.insert(words, { chars=chars, w=ch_offs })
	end

	-- Okay, we actually build the "line texture" here.

	local texture = { }

	local start_xpos = math.floor((SIGN_WIDTH - maxw) / 2) + 6

	local xpos = start_xpos
	local ypos = (LINE_HEIGHT * lineno) + 4

	cur_color = nil

	for word_i, word in ipairs(words) do
		local xoffs = (xpos - start_xpos)
		if (xoffs > 0) and ((xoffs + word.w) > maxw) then
			table.insert(texture, fill_line(xpos, ypos, maxw, "n"))
			xpos = start_xpos
			ypos = ypos + LINE_HEIGHT
			lineno = lineno + 1
			if lineno >= NUMBER_OF_LINES then break end
			table.insert(texture, fill_line(xpos, ypos, maxw, cur_color))
		end
		for ch_i, ch in ipairs(word.chars) do
			if ch.col ~= cur_color then
				cur_color = ch.col
				table.insert(texture, fill_line(xpos + ch.off, ypos, maxw, cur_color))
			end
			table.insert(texture, (":%d,%d=%s"):format(xpos + ch.off, ypos, ch.tex))
		end
		table.insert(
			texture, 
			(":%d,%d="):format(xpos + word.w, ypos) .. char_tex(font_name, " ")
		)
		xpos = xpos + word.w + charwidth[" "]
		if xpos >= (SIGN_WIDTH + charwidth[" "]) then break end
	end

	table.insert(texture, fill_line(xpos, ypos, maxw, "n"))
	table.insert(texture, fill_line(start_xpos, ypos + LINE_HEIGHT, maxw, "n"))

	return table.concat(texture), lineno
end

local function make_sign_texture(lines, pos)
	local texture = { ("[combine:%dx%d"):format(SIGN_WIDTH, LINE_HEIGHT * NUMBER_OF_LINES) }
	local lineno = 0
	for i = 1, #lines do
		if lineno >= NUMBER_OF_LINES then break end
		local linetex, ln = make_line_texture(lines[i], lineno, pos)
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
	if not fields then return end

	fields.text = trim_input(fields.text)
	if not fields.text then return end

	meta:set_string("infotext", make_infotext(fields.text).." ")
	meta:set_string("text", fields.text)

	local objects = minetest.get_objects_inside_radius(pos, 0.5)
	local found
	for _, v in ipairs(objects) do
		local e = v:get_luaentity()
		if e and e.name == "street_signs:text" then
			if found then
				v:remove()
			else
				set_obj_text(v, fields.text, nil, pos)
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
	local text = minetest.add_entity(pos, "street_signs:text")
	local yaw = street_signs.standard_sign_model.yaw[minetest.get_node(pos).param2 + 1]
	if not yaw then return end
	text:setyaw(yaw)
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

minetest.register_node("street_signs:sign_basic", {
	description = "Basic street name sign",
	paramtype = "light",
	sunlight_propagates = true,
	paramtype2 = "facedir",
	drawtype = "mesh",
	node_box = street_signs.standard_sign_model.nodebox,
	selection_box = street_signs.standard_sign_model.nodebox,
	mesh = "street_signs_basic.obj",
	tiles = { "street_signs_basic.png" },
	groups = {choppy=2, dig_immediate=2},
	default_color = "f",
	on_construct = function(pos) 
		street_signs.construct_sign(pos)
	end,
	on_destruct = function(pos)
		street_signs.destruct_sign(pos)
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		street_signs.receive_fields(pos, formname, fields, sender)
	end,
	on_punch = function(pos, node, puncher)
		street_signs.update_sign(pos)
	end,
})

local signs_text_on_activate

signs_text_on_activate = function(self)
	local pos = self.object:getpos()
	local meta = minetest.get_meta(pos)
	local text = meta:get_string("text")
	if text and minetest.registered_nodes[minetest.get_node(pos).name] then
		text = trim_input(text)
		set_obj_text(self.object, text, nil, pos)
	end
end

minetest.register_entity("street_signs:text", {
	collisionbox = { 0, 0, 0, 0, 0, 0 },
	visual = "mesh",
	mesh = "street_signs_basic_entity.obj",
	textures = {},
	on_activate = signs_text_on_activate,
})

build_char_db()

-- craft it!

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

if minetest.get_modpath("signs_lib") then
	minetest.register_craft({
		output = "street_signs:sign_basic",
		recipe = {
			{ "", "signs:sign_wall_green", "" },
			{ "", "default:steel_ingot",   "" },
			{ "", "default:steel_ingot",   "" },
		}
	})
end

-- restore signs' text after /clearobjects and the like, the next time
-- a block is reloaded by the server.

minetest.register_lbm({
	nodenames = { "street_signs:sign_basic" },
	name = "street_signs:restore_sign_text",
	label = "Restore sign text",
	run_at_every_load = true,
	action = function(pos, node)
		street_signs.update_sign(pos)
	end
})

if minetest.settings:get("log_mods") then
	minetest.log("action", S("[MOD] Street signs loaded"))
end
