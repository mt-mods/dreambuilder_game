-- Industrial lights mod by DanDuncombe
-- rewritten by VanessaE to use param2 colorization

ilights = {}

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.global_exists("intllib") then
	if intllib.make_gettext_pair then
		-- New method using gettext.
		S = intllib.make_gettext_pair()
	else
		-- Old method using text files.
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end

if minetest.get_modpath("unified_inventory") or not minetest.settings:get_bool("creative_mode") then
	ilights.expect_infinite_stacks = false
else
	ilights.expect_infinite_stacks = true
end

ilights.modpath = minetest.get_modpath("ilights")

local function is_protected(pos, clicker)
	if minetest.is_protected(pos, clicker:get_player_name()) then
		minetest.record_protection_violation(pos,
		clicker:get_player_name())
		return true
	end
	return false
end

if minetest.get_modpath("mesecons") then
	actions = {
		action_off = function(pos, node)
			local sep = string.find(node.name, "_", -5)
			local onoff = string.sub(node.name, sep + 1)
			if minetest.get_meta(pos):get_int("toggled") > 0 then
				minetest.swap_node(pos, {
					name = string.sub(node.name, 1, sep - 1).."_off",
					param2 = node.param2
				})
			end
		end,
		action_on = function(pos, node)
			minetest.get_meta(pos):set_int("toggled", 1)
			local sep = string.find(node.name, "_", -5)
			local onoff = string.sub(node.name, sep + 1)
			minetest.swap_node(pos, {
				name = string.sub(node.name, 1, sep - 1).."_on",
				param2 = node.param2
			})
		end
	}

	ilights.mesecons = {
		effector = table.copy(actions)
	}
	ilights.mesecons.effector.rules = mesecon.rules.wallmounted_get
end

-- digilines compatibility
-- this one is based on the so-named one in Jeija's digilines mod

local player_last_clicked = {}

local digiline_on_punch

local onoff_tab = {
	["off"] = "off",
	["low"] = "off",
	["med"] = "on",
	["hi"] = "on",
	["max"] = "on",
	["on"] = "on",
}

if minetest.get_modpath("digilines") then

	local on_digiline_receive_string = function(pos, node, channel, msg)
		local meta = minetest.get_meta(pos)
		local setchan = meta:get_string("channel")

		if setchan ~= channel then return end
		if msg ~= "" and (type(msg) == "string" or type(msg) == "number" ) then
			local n = tonumber(msg)
			if n then
				msg = (n > 3) and "on" or "off" -- same threshold as in homedecor's lights
			end

			local light = onoff_tab[msg]
			if light then
				local basename = string.sub(node.name, 1, string.find(node.name, "_", -5) - 1)
				if minetest.registered_nodes[basename.."_"..light] then
					minetest.swap_node(pos, {name = basename.."_"..light, param2 = node.param2})
				end
			end
		end
	end

	minetest.register_on_player_receive_fields(function(player, formname, fields)
		local name = player:get_player_name()
		local pos = player_last_clicked[name]
		if pos and formname == "ilights:set_channel" then
			if is_protected(pos, player) then return end
			if (fields.channel) then
				local meta = minetest.get_meta(pos)
				meta:set_string("channel", fields.channel)
			end
		end
	end)

	if minetest.get_modpath("mesecons") then
		ilights.digilines = {
			effector = {
				action = on_digiline_receive_string,
			},
			wire = {
				rules = mesecon.rules.wallmounted_get
			}
		}
	else
		ilights.digilines = {
			effector = {
				action = on_digiline_receive_string,
			},
			wire = {
				rules = rules_alldir
			}
		}
	end

	function digiline_on_punch(pos, node, puncher, pointed_thing)
		if is_protected(pos, puncher) then return end

		if puncher:get_player_control().sneak then
			local name = puncher:get_player_name()
			player_last_clicked[name] = pos
			local meta = minetest.get_meta(pos)
			local form = "formspec_version[4]"..
					"size[8,4]"..
					"button_exit[3,2.5;2,0.5;proceed;Proceed]"..
					"field[1.75,1.5;4.5,0.5;channel;Channel;]"
			minetest.show_formspec(name, "ilights:set_channel", form)
		end
	end
end

-- turn on/off

function ilights.toggle_light(pos, node, clicker, itemstack, pointed_thing)
	if is_protected(pos, clicker) then return end
	local sep = string.find(node.name, "_o", -5)
	local onoff = string.sub(node.name, sep + 1)
	local newname = string.sub(node.name, 1, sep - 1)..((onoff == "off") and "_on" or "_off")
	minetest.swap_node(pos, {name = newname, param2 = node.param2})
end

-- The important stuff!

local lamp_cbox = {
	type = "wallmounted",
	wall_top =    { -11/32,  -4/16, -11/32, 11/32,  8/16, 11/32 },
	wall_bottom = { -11/32,  -8/16, -11/32, 11/32,  4/16, 11/32 },
	wall_side =   {  -8/16, -11/32, -11/32,  4/16, 11/32, 11/32 }
}

for _, onoff in ipairs({"on", "off"}) do

	local light_source = (onoff == "on") and default.LIGHT_MAX or nil
	local nici = (onoff == "off") and 1 or nil

	minetest.register_node("ilights:light_"..onoff, {
		description = "Industrial Light",
		drawtype = "mesh",
		mesh = "ilights_lamp.obj",
		tiles = {
			{ name = "ilights_lamp_base.png", color = 0xffffffff },
			{ name = "ilights_lamp_cage.png", color = 0xffffffff },
			"ilights_lamp_bulb_"..onoff..".png",
			{ name = "ilights_lamp_bulb_base.png", color = 0xffffffff },
			"ilights_lamp_lens_"..onoff..".png"
		},
		use_texture_alpha = true,
		groups = {cracky=3, ud_param2_colorable = 1, not_in_creative_inventory = nici},
		paramtype = "light",
		paramtype2 = "colorwallmounted",
		palette = "unifieddyes_palette_colorwallmounted.png",
		light_source = light_source,
		selection_box = lamp_cbox,
		node_box = lamp_cbox,
		after_place_node = function(pos, placer, itemstack, pointed_thing)
			unifieddyes.fix_rotation(pos, placer, itemstack, pointed_thing)
		end,
		drop = {
			items = {
				{items = {"ilights:light_on"}, inherit_color = true },
			}
		},
		on_rightclick = ilights.toggle_light,
		mesecons =      ilights.mesecons,
		digiline =      ilights.digilines,
		on_punch =      digiline_on_punch,
		on_dig = unifieddyes.on_dig,
	})
end

minetest.register_alias("ilights:light", "ilights:light_on")

minetest.register_craft({
	output = "ilights:light_on 3",
	recipe = {
		{ "",                     "default:steel_ingot",  "" },
		{ "",                     "default:glass",        "" },
		{ "default:steel_ingot",  "default:torch",        "default:steel_ingot" }
	},
})

unifieddyes.register_color_craft({
	output = "ilights:light_on 3",
	palette = "wallmounted",
	neutral_node = "",
	recipe = {
		{ "",                     "default:steel_ingot",  ""                    },
		{ "",                     "default:glass",        "MAIN_DYE"            },
		{ "default:steel_ingot",  "default:torch",        "default:steel_ingot" }
	}
})

unifieddyes.register_color_craft({
	output = "ilights:light_on",
	palette = "wallmounted",
	type = "shapeless",
	neutral_node = "ilights:light",
	recipe = {
		"NEUTRAL_NODE",
		"MAIN_DYE",
	}
})

-- convert old static nodes to param2 coloring

ilights.colors = {
	"white",
	"grey",
	"black",
	"red",
	"yellow",
	"green",
	"cyan",
	"blue",
	"magenta",
	"orange",
	"violet",
	"dark_grey",
	"dark_green",
	"pink",
	"brown"
}

ilights.old_static_nodes = {}

for _, i in ipairs (ilights.colors) do
	table.insert(ilights.old_static_nodes, "ilights:light_"..i)
end

minetest.register_lbm({
	name = "ilights:convert",
	label = "Convert ilights static nodes to use param2 color",
	run_at_every_load = false,
	nodenames = ilights.old_static_nodes,
	action = function(pos, node)
		local name = node.name
		local color = string.sub(name, string.find(name, "_") + 1)
		local paletteidx = unifieddyes.getpaletteidx("unifieddyes:"..color, "wallmounted")
		local old_fdir = math.floor(node.param2 / 4)
		local param2

		if old_fdir == 5 then
			new_fdir = 0
		elseif old_fdir == 1 then
			new_fdir = 5
		elseif old_fdir == 2 then
			new_fdir = 4
		elseif old_fdir == 3 then
			new_fdir = 3
		elseif old_fdir == 4 then
			new_fdir = 2
		elseif old_fdir == 0 then
			new_fdir = 1
		end
		param2 = paletteidx + new_fdir

		minetest.set_node(pos, { name = "ilights:light", param2 = param2 })
		local meta = minetest.get_meta(pos)
		meta:set_string("dye", "unifieddyes:"..color)
	end
})
