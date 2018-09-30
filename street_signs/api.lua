-- signs api; most of this came from signs_lib but rewritten to some degree

local S = street_signs.gettext

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

-- make selection boxes
-- sizex/sizey specified in inches because that's what MUTCD uses.

function street_signs.make_selection_boxes(sizex, sizey, onpole, xoffs, yoffs, zoffs)
	local tx = (sizex * 0.0254 ) / 2
	local ty = (sizey * 0.0254 ) / 2
	local xo = xoffs and xoffs * 0.0254 or 0
	local yo = yoffs and yoffs * 0.0254 or 0
	local zo = zoffs and zoffs * 0.0254 or 0


	local t = { -0.5, -ty + yo, -tx + xo, -0.4375, ty + yo, tx + xo }

	if onpole == "_onpole" then
		return {
			type = "wallmounted",
			wall_side = { t[1] - 0.3125 + zo, t[2], t[3], t[4] - 0.3125 + zo, t[5], t[6] },
			wall_top = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
			wall_bottom = {-0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
		}
	else
		return {
			type = "wallmounted",
			wall_side = t,
			wall_top = { t[3] - xo, -t[1], t[2] + yo, t[6] - xo, -t[4], t[5] + yo},
			wall_bottom = { t[3] - xo, t[1], t[2] + yo, t[6] - xo, t[4], t[5] + yo }
		}
	end
end

-- switch models to pole-mounted if appropriate

street_signs.after_place_node = function(pos, placer, itemstack, pointed_thing)
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
