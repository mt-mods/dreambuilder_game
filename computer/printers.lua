-- Printers of some kind or another

local S = homedecor.gettext

minetest.register_node("computer:printer", {
	description = S("Printer-Scanner Combo"),
	inventory_image = "computer_printer_inv.png",
	tiles = {"computer_printer_t.png","computer_printer_bt.png","computer_printer_l.png",
			"computer_printer_r.png","computer_printer_b.png","computer_printer_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.3125, -0.125, 0.4375, -0.0625, 0.375},
			{-0.4375, -0.5, -0.125, 0.4375, -0.4375, 0.375},
			{-0.4375, -0.5, -0.125, -0.25, -0.0625, 0.375},
			{0.25, -0.5, -0.125, 0.4375, -0.0625, 0.375},
			{-0.4375, -0.5, -0.0625, 0.4375, -0.0625, 0.375},
			{-0.375, -0.4375, 0.25, 0.375, -0.0625, 0.4375},
			{-0.25, -0.25, 0.4375, 0.25, 0.0625, 0.5},
			{-0.25, -0.481132, -0.3125, 0.25, -0.4375, 0}
		},
	},
})

-- "bedflinger" style 3D Printer (Prusa i3 or equivalent)

local cbox = {
	type = "fixed",
	fixed = {-0.25, -0.25, -0.5, 0.3, 0.3, 0.25 }
}

minetest.register_node("computer:3dprinter_bedflinger", {
	description = S('3D Printer ("bedflinger")'),
	inventory_image = "computer_3dprinter_bedflinger_inv.png",
	tiles = {
		{ name = "computer_3dprinter_bedflinger.png", color = 0xffffffff },
		"computer_3dprinter_filament.png"
	},
	paramtype = "light",
	walkable = true,
	groups = {snappy=3, ud_param2_colorable = 1},
	sound = default.node_sound_wood_defaults(),
	drawtype = "mesh",
	mesh = "computer_3dprinter_bedflinger.obj",
	paramtype2 = "colorwallmounted",
	palette = "unifieddyes_palette_colorwallmounted.png",
	selection_box = cbox,
	collision_box = cbox,
	after_place_node = function(pos, placer, itemstack, pointed_thing)
		unifieddyes.fix_rotation_nsew(pos, placer, itemstack, pointed_thing)
	end,
	on_dig = unifieddyes.on_dig,
	on_rotate = unifieddyes.fix_after_screwdriver_nsew,
})

