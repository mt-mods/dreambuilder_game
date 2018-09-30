-- sign crafts

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

for _, c in ipairs(street_signs.big_sign_colors) do

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

	for _, c in ipairs(street_signs.big_sign_colors) do

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

