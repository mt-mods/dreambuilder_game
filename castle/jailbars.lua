if minetest.get_modpath("xpanes") then
	xpanes.register_pane("jailbars", {
		description = "Jail Bars",
		tiles = {"castle_jailbars.png"},
		drawtype = "airlike",
		paramtype = "light",
		textures = {"castle_jailbars.png", "castle_jailbars.png", "xpanes_space.png"},
		inventory_image = "castle_jailbars.png",
		wield_image = "castle_jailbars.png",
		sounds = default.node_sound_stone_defaults(),
		groups = {cracky=1, pane=1},
		recipe = {{"default:steel_ingot","","default:steel_ingot"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
		{"default:steel_ingot","","default:steel_ingot"}}
	})
end

for i = 1, 15 do
	minetest.register_alias("castle:jailbars_"..i, "xpanes:jailbars_"..i)
end
minetest.register_alias("castle:jailbars", "xpanes:jailbars")
