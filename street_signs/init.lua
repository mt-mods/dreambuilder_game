-- This mod provides your standard green street name signs
-- (that is, the two-up, 2m high ones identifying street intersections),
-- the larger kind found above or alongside highways,
-- and a selection of other kinds of signs like stop, pedestrian crossing,
-- yield, US Route, and so on (all from MUTCD 2009 R2)
--
-- forked from signs_lib by Diego Martinez et. al

street_signs = {}
street_signs.path = minetest.get_modpath(minetest.get_current_modname())
screwdriver = screwdriver or {}

-- Load support for intllib.
local S, NS = dofile(street_signs.path .. "/intllib.lua")
street_signs.lbm_restore_nodes = {}

street_signs.big_sign_sizes = {
--    "size",   lines, chars, hscale, vscale, xoffs, yoffs, box
	{ "small",  3,     50,    1.3,    1.05,    7,     5,     { -0.5, -0.5, -0.5, -0.4, 0.5, 1.5 } },
	{ "medium", 6,     50,    1.3,    1.05,    7,     5,     { -0.5, -0.5, -0.5, -0.4, 1.5, 1.5 } },
	{ "large",  6,     80,    1,      1.05,    7,     5,     { -0.5, -0.5, -0.5, -0.4, 1.5, 2.5 } }
}

street_signs.big_sign_colors = {
	{ "green",  "f", "dye:green",  "dye:white" },
	{ "blue",   "f", "dye:blue",   "dye:white" },
	{ "yellow", "0", "dye:yellow", "dye:black" },
	{ "orange", "0", "dye:orange", "dye:black" }
}

dofile(street_signs.path.."/signs_misc_generic.lua")
dofile(street_signs.path.."/signs_class_d.lua")
dofile(street_signs.path.."/signs_class_om.lua")
dofile(street_signs.path.."/signs_class_m.lua")
dofile(street_signs.path.."/signs_class_r.lua")
dofile(street_signs.path.."/signs_class_w.lua")

dofile(street_signs.path.."/crafting.lua")
dofile(street_signs.path.."/compat_convert.lua")

-- restore signs' text after /clearobjects and the like, the next time
-- a block is reloaded by the server.

minetest.register_lbm({
	nodenames = street_signs.lbm_restore_nodes,
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
