-- Minetest 0.4.7 mod: framedglass

framedglass = {}

minetest.register_craft({
	output = 'framedglass:wooden_framed_glass 4',
	recipe = {
		{'default:glass', 'default:glass', 'default:stick'},
		{'default:glass', 'default:glass', 'default:stick'},
		{'default:stick', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'framedglass:steel_framed_glass 4',
	recipe = {
		{'default:glass', 'default:glass', 'default:steel_ingot'},
		{'default:glass', 'default:glass', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', ''},
	}
})

minetest.register_craft({
	output = 'framedglass:wooden_framed_obsidian_glass 4',
	recipe = {
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:stick'},
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:stick'},
		{'default:stick', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'framedglass:steel_framed_obsidian_glass 4',
	recipe = {
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
		{'default:obsidian_glass', 'default:obsidian_glass', 'default:steel_ingot'},
		{'default:steel_ingot', 'default:steel_ingot', ''},
	}
})

minetest.register_node("framedglass:wooden_framed_glass", {
	description = "Wooden-framed Glass",
	drawtype = "glasslike_framed",
	tiles = {"framedglass_wooden_frame.png","framedglass_glass_face_streaks.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("framedglass:steel_framed_glass", {
	description = "Steel-framed Glass",
	drawtype = "glasslike_framed",
	tiles = {"framedglass_steel_frame.png","framedglass_glass_face_streaks.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_node("framedglass:wooden_framed_obsidian_glass", {
	description = "Wooden-framed Obsidian Glass",
	drawtype = "glasslike_framed",
	tiles = {"framedglass_wooden_frame.png","framedglass_glass_face_clean.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

-- helper functions copied partly from Unified Dyes

local creative_mode = minetest.setting_getbool("creative_mode")

local function select_node(pointed_thing)
	local pos = pointed_thing.under
	local node = minetest.get_node_or_nil(pos)
	local def = node and minetest.registered_nodes[node.name]

	if not def or not def.buildable_to then
		pos = pointed_thing.above
		node = minetest.get_node_or_nil(pos)
		def = node and minetest.registered_nodes[node.name]
	end
	return def and pos, def
end

local function is_buildable_to(placer_name, ...)
	for _, pos in ipairs({...}) do
		local node = minetest.get_node_or_nil(pos)
		local def = node and minetest.registered_nodes[node.name]
		if not (def and def.buildable_to) or minetest.is_protected(pos, placer_name) then
			return false
		end
	end
	return true
end

function framedglass.color_on_punch(pos, node, puncher, pointed_thing)
	local itemstack = puncher:get_wielded_item()
	local itemname = itemstack:get_name()

	if not string.find(itemname, "dye:")
	  and not string.find(itemname, "unifieddyes:") then
		return itemstack
	end

	local a,b = string.find(node.name, "_glass")
	local oldcolor = string.sub(node.name, b + 1)
	local newcolor = string.sub(itemname, string.find(itemname, ":") + 1)

	local oldcolor2 = string.gsub(oldcolor, "darkgreen", "dark_green")
	local oldcolor2 = string.gsub(oldcolor2, "darkgrey", "dark_grey")

	local newcolor2 = string.gsub(newcolor, "dark_green", "darkgreen")
	local newcolor2 = string.gsub(newcolor2, "dark_grey", "darkgrey")

	if oldcolor == newcolor2 then
		minetest.chat_send_player(puncher:get_player_name(), "That node is already "..newcolor.."." )
		return itemstack
	end

	if not (newcolor == "dark_grey"
			or newcolor == "dark_green"
			or minetest.registered_nodes["framedglass:steel_framed_obsidian_glass"..newcolor]) then
		minetest.chat_send_player(puncher:get_player_name(), "Framed glass doesn't support "..newcolor.."." )
		return itemstack
	end

	local inv = puncher:get_inventory()
	local prevdye = "dye:"..oldcolor2

	if not (inv:contains_item("main", prevdye) and creative_mode) and minetest.registered_items[prevdye] then
		if inv:room_for_item("main", prevdye) then
			inv:add_item("main", prevdye)
		else
			minetest.add_item(pos, prevdye)
		end
	end

	minetest.set_node(pos, { name = "framedglass:steel_framed_obsidian_glass"..newcolor2 })
	itemstack:take_item()
	return itemstack
end

local return_dye_after_dig = function(pos, oldnode, oldmetadata, digger)

	local a,b = string.find(oldnode.name, "_glass")
	local oldcolor = string.sub(oldnode.name, b + 1)
	local oldcolor2 = string.gsub(oldcolor, "darkgreen", "dark_green")
	local oldcolor2 = string.gsub(oldcolor2, "darkgrey", "dark_grey")

	local prevdye = "dye:"..oldcolor2

	local inv = digger:get_inventory()

	if prevdye and not (inv:contains_item("main", prevdye) and creative_mode) and minetest.registered_items[prevdye] then
		if inv:room_for_item("main", prevdye) then
			inv:add_item("main", prevdye)
		else
			minetest.add_item(pos, prevdye)
		end
	end
end

minetest.register_node("framedglass:steel_framed_obsidian_glass", {
	description = "Steel-framed Obsidian Glass",
	drawtype = "glasslike_framed",
	tiles = {"framedglass_steel_frame.png","framedglass_glass_face_clean.png"},
	paramtype = "light",
	sunlight_propagates = true,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
	on_punch = framedglass.color_on_punch,
	after_dig_node = return_dye_after_dig
})

function add_coloured_framedglass(name, desc, color)
	minetest.register_node( "framedglass:steel_framed_obsidian_glass"..name, {
		description = "Steel-framed "..desc.." Obsidian Glass",
		tiles = {
			"framedglass_steel_frame.png",
			{ name = "framedglass_whiteglass.png", color = color }
		},
		drawtype = "glasslike_framed",
		paramtype = "light",
		sunlight_propagates = true,
		is_ground_content = true,
		use_texture_alpha = true,
		groups = {cracky=3, not_in_creative_inventory=1},
		sounds = default.node_sound_glass_defaults(),
		on_punch = framedglass.color_on_punch,
		after_dig_node = return_dye_after_dig,
		drop = "framedglass:steel_framed_obsidian_glass"
	}) 
end

add_coloured_framedglass ("red",		"Red",			0xffff0000)
add_coloured_framedglass ("orange",		"Orange",		0xfffe7f00)
add_coloured_framedglass ("yellow",		"Yellow",		0xffffff01)
add_coloured_framedglass ("green",		"Green",		0xff0cff00)
add_coloured_framedglass ("cyan",		"Cyan",			0xff7affff)
add_coloured_framedglass ("blue",		"Blue",			0xff1600ff)
add_coloured_framedglass ("violet",		"Violet",		0xff7d00ff)
add_coloured_framedglass ("magenta",	"Magenta",		0xfffd05ff)

add_coloured_framedglass ("darkgreen",	"Dark Green",	0xff144f00)
add_coloured_framedglass ("pink",		"Pink",			0xffffa4a4)
add_coloured_framedglass ("brown",		"Brown",		0xff542a00)

add_coloured_framedglass ("white",		"White",		0xffffffff)
add_coloured_framedglass ("grey",		"Grey",			0xff7f817e)
add_coloured_framedglass ("darkgrey",	"Dark Grey",	0xff3f403e)
add_coloured_framedglass ("black",		"Black",		0xff000000)
