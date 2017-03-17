castle_shields.register_shield = function(name, desc, background_color, foreground_color, mask)

	local tile_side = "castle_shield_"..background_color..".png"
	local tile_front = "castle_shield_"..background_color..".png^(castle_shield_"..foreground_color..".png^[mask:castle_shield_mask_"..mask..".png)"

	minetest.register_node(minetest.get_current_modname()..":"..name, {
		description = desc,
		tiles = {tile_side, tile_side, tile_side, tile_side, "castle_shield_back.png", tile_front},
		drawtype="nodebox",
		paramtype2 = "facedir",
		paramtype = "light",
		groups={cracky=3},
		sounds = default.node_sound_metal_defaults(),
		node_box = {
			type = "fixed",
			fixed = {
				{-0.500000,-0.125000,0.375000,0.500000,0.500000,0.500000},
				{-0.437500,-0.312500,0.375000,0.425000,0.500000,0.500000},
				{-0.312500,-0.437500,0.375000,0.312500,0.500000,0.500000},
				{-0.187500,-0.500000,0.375000,0.187500,0.500000,0.500000},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.500000,-0.500000,0.375000,0.500000,0.500000,0.500000},
			},
		},
	})
	
	minetest.register_craft({
		output = minetest.get_current_modname()..":"..name,
		recipe = {
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"default:steel_ingot", "default:steel_ingot", "default:steel_ingot"},
			{"dye:"..background_color, "default:steel_ingot", "dye:"..foreground_color},
		}
	})
end