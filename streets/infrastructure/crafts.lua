-- **************************************************************************************************** MATERIALS

-- Galvanized steel
	if minetest.get_modpath("technic") then
		technic.register_alloy_recipe({input = {"default:steel_ingot 6", "technic:zinc_ingot 1"}, output = "infrastructure:galvanized_steel 6", time = 4})
	else
		minetest.register_craft({
			output = '"infrastructure:galvanized_steel" 6',
			recipe = {
				{'', 'default:copper_ingot', ''},
				{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
				{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
			}
		})
	end

-- Galvanized steel fence
	minetest.register_craft({
		output = '"infrastructure:fence_galvanized_steel" 6',
		recipe = {
			{'infrastructure:galvanized_steel', 'infrastructure:galvanized_steel', 'infrastructure:galvanized_steel'},
			{'infrastructure:galvanized_steel', 'infrastructure:galvanized_steel', 'infrastructure:galvanized_steel'}
		}
	})

-- **************************************************************************************************** PRECAST CONCRETE

-- Concrete seperating wall
	minetest.register_craft({
		output = '"infrastructure:precast_concrete_seperating_wall" 5',
		recipe = {
			{'', 'infrastructure:concrete', ''},
			{'', 'infrastructure:concrete', ''},
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'}
		}
	})

-- Concrete cylinder
	minetest.register_craft({
		output = '"infrastructure:precast_concrete_cylinder" 8',
		recipe = {
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'},
			{'infrastructure:concrete', '', 'infrastructure:concrete'},
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'}
		}
	})

-- Concrete grid paver
	minetest.register_craft({
		output = '"infrastructure:precast_concrete_grid_paver" 5',
		recipe = {
			{'infrastructure:concrete', '', 'infrastructure:concrete'},
			{'', 'infrastructure:concrete', ''},
			{'infrastructure:concrete', '', 'infrastructure:concrete'}
		}
	})

-- **************************************************************************************************** STEEL STRUCTURES

-- Truss
	minetest.register_craft({
		output = '"infrastructure:truss" 5',
		recipe = {
			{'infrastructure:galvanized_steel', '', 'infrastructure:galvanized_steel'},
			{'', 'infrastructure:galvanized_steel', ''},
			{'infrastructure:galvanized_steel', '', 'infrastructure:galvanized_steel'}
		}
	})

-- Wire netting
	minetest.register_craft({
		output = '"infrastructure:wire_netting" 10',
		recipe = {
			{'', 'infrastructure:galvanized_steel', ''},
			{'infrastructure:galvanized_steel', '', 'infrastructure:galvanized_steel'},
			{'', 'infrastructure:galvanized_steel', ''}
		}
	})

-- Razor wire
	minetest.register_craft({
		output = '"infrastructure:razor_wire" 5',
		recipe = {
			{'infrastructure:galvanized_steel'},
			{'default:cactus'},
			{'infrastructure:galvanized_steel'}
		}
	})

-- Drainage channel grating
	minetest.register_craft({
		output = '"infrastructure:drainage_channel_grating" 2',
		recipe = {
			{'infrastructure:galvanized_steel', '', 'infrastructure:galvanized_steel'}
		}
	})

-- Louver
	minetest.register_craft({
		output = '"infrastructure:drainage_channel_grating" 2',
		recipe = {
			{'infrastructure:galvanized_steel'},
			{''},
			{'infrastructure:galvanized_steel'}
		}
	})

-- Riffled sheet
	minetest.register_craft({
		output = '"infrastructure:riffled_sheet" 4',
		recipe = {
			{'infrastructure:galvanized_steel', 'infrastructure:fence_galvanized_steel'},
			{'infrastructure:fence_galvanized_steel', 'infrastructure:galvanized_steel'}
		}
	})

-- Corrugated sheet
	minetest.register_craft({
		output = '"infrastructure:corrugated_sheet" 4',
		recipe = {
			{"","infrastructure:galvanized_steel",""},
			{"infrastructure:galvanized_steel","","infrastructure:galvanized_steel"}
		}
	})

-- Louvers
	minetest.register_craft({
		output = "infrastructure:louver_opened",
		recipe = {
			{"infrastructure:fence_galvanized_steel","infrastructure:galvanized_steel","infrastructure:fence_galvanized_steel"},
			{"","",""},
			{"infrastructure:fence_galvanized_steel","infrastructure:galvanized_steel","infrastructure:fence_galvanized_steel"}
		}
	})

-- **************************************************************************************************** ADVANCED ITEMS

-- Raised pavement marker yellow/yellow
	minetest.register_craft({
		output = '"infrastructure:marker_yellow_yellow" 1',
		recipe = {
			{'wool:yellow', 'infrastructure:asphalt', 'wool:yellow'},
			{'infrastructure:asphalt', 'infrastructure:asphalt', 'infrastructure:asphalt'}
		}
	})

-- Raised pavement marker red/yellow
	minetest.register_craft({
		output = '"infrastructure:marker_red_yellow" 1',
		recipe = {
			{'wool:yellow', 'infrastructure:asphalt', 'wool:red'},
			{'infrastructure:asphalt', 'infrastructure:asphalt', 'infrastructure:asphalt'}
		}
	})

-- Retroreflective delineators
	minetest.register_craft({
		output = '"infrastructure:delineator" 1',
		recipe = {
			{'wool:yellow', 'infrastructure:concrete', 'wool:red'},
			{'', 'infrastructure:concrete', ''},
			{'', 'infrastructure:concrete', ''}
		}
	})

	minetest.register_craft({
		output = '"infrastructure:delineator_guardrail" 1',
		recipe = {
			{'wool:yellow', 'infrastructure:concrete', 'wool:red'},
			{'', 'infrastructure:concrete', ''}
		}
	})

-- Wire rope safety barrier
	minetest.register_craft({
		output = '"infrastructure:wire_rope_safety_barrier" 1',
		recipe = {
			{'default:steel_ingot', '', 'default:steel_ingot'},
			{'', 'default:steel_ingot', ''},
			{'', 'default:steel_ingot', ''}
		}
	})

-- Cable barrier terminal
	minetest.register_craft({
		output = '"infrastructure:cable_barrier_terminal" 1',
		recipe = {
			{'default:steel_ingot', '', ''},
			{'', 'default:steel_ingot', ''},
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
		}
	})

-- Corrugated guide rail
	minetest.register_craft({
		output = '"infrastructure:corrugated_guide_rail" 1',
		recipe = {
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
			{'', 'default:steel_ingot', ''},
			{'', 'default:steel_ingot', ''}
		}
	})

-- Energy absorbing terminal
	minetest.register_craft({
		output = '"infrastructure:energy_absorbing_terminal" 1',
		recipe = {
			{'', 'default:steel_ingot', ''},
			{'default:steel_ingot', 'default:steel_ingot', ''},
			{'', 'default:steel_ingot', ''}
		}
	})

	minetest.register_craft({
		output = '"infrastructure:energy_absorbing_terminal" 1',
		recipe = {
			{'infrastructure:energy_absorbing_terminal_inversed'}
		}
	})

	minetest.register_craft({
		output = '"infrastructure:energy_absorbing_terminal_inversed" 1',
		recipe = {
			{'infrastructure:energy_absorbing_terminal'}
		}
	})

-- Fitch barrel
	minetest.register_craft({
		output = '"infrastructure:fitch_barrel" 1',
		recipe = {
			{'wool:black', 'wool:black', 'wool:black'},
			{'wool:yellow', 'default:sand', 'wool:yellow'},
			{'wool:yellow', 'wool:yellow', 'wool:yellow'}
		}
	})

-- Crowd control barricade
	minetest.register_craft({
		output = '"infrastructure:crowd_control_barricade" 1',
		recipe = {
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'},
			{'default:steel_ingot', '', 'default:steel_ingot'}
		}
	})

if ENABLE_EMERGENCY_PHONE then
-- Emergency phone
	minetest.register_craft({
		output = '"infrastructure:emergency_phone" 1',
		recipe = {
			{'default:mese_crystal', 'default:mese_crystal', 'default:mese_crystal'},
			{'default:mese_crystal', 'default:apple', 'default:mese_crystal'},
			{'default:mese_crystal', 'default:stick', 'default:mese_crystal'}
		}
	})
	minetest.register_craft({
		output = '"infrastructure:emergency_phone" 1',
		recipe = {
			{'default:mese', 'default:mese', 'default:mese'},
			{'default:mese', 'default:apple', 'default:mese'},
			{'default:mese', 'default:stick', 'default:mese'}
		}
	})
end

-- Manhole cover
	minetest.register_craft({
		output = '"infrastructure:manhole_cover_closed" 1',
		recipe = {
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'},
			{'infrastructure:concrete', 'default:steel_ingot', 'infrastructure:concrete'},
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'}
		}
	})

-- Traffic lights for pedestrians
	minetest.register_craft({
		output = '"infrastructure:traffic_lights_pedestrians" 1',
		recipe = {
			{'', 'default:steel_ingot', ''},
			{'default:steel_ingot', 'wool:red', 'default:steel_ingot'},
			{'default:steel_ingot', 'wool:green', 'default:steel_ingot'}
		}
	})

-- Crosswalk warning light
	minetest.register_craft({
		output = '"infrastructure:crosswalk_warning_light" 1',
		recipe = {
			{'', 'default:steel_ingot', ''},
			{'default:steel_ingot', 'wool:yellow', 'default:steel_ingot'},
			{'', 'wool:green', ''}
		}
	})

-- Curve chevron
	minetest.register_craft({
		output = '"infrastructure:curve_chevron" 1',
		recipe = {
			{'wool:yellow', 'wool:black', 'wool:yellow'},
			{'wool:black', 'wool:yellow', 'wool:yellow'},
			{'wool:yellow', 'wool:black', 'wool:yellow'}
		}
	})

-- Crosswalk lighting
	minetest.register_craft({
		output = '"infrastructure:crosswalk_lighting" 1',
		recipe = {
			{'wool:white', 'wool:white', 'wool:white'},
			{'', 'mesecons_torch:mesecon_torch_on', ''},
			{'wool:white', 'wool:white', 'wool:white'}
		}
	})

-- Crosswalk safety sign
	minetest.register_craft({
		output = '"infrastructure:crosswalk_safety_sign" 1',
		recipe = {
			{'', 'wool:green', ''},
			{'', 'wool:green', ''},
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'}
		}
	})

-- Road sign crosswalk
	minetest.register_craft({
		output = '"infrastructure:road_sign_crosswalk" 1',
		recipe = {
			{'wool:green', 'wool:green', 'wool:green'},
			{'wool:green', 'wool:blue', 'wool:green'},
			{'wool:green', 'wool:green', 'wool:green'}
		}
	})

-- Road sign right_of_way
	minetest.register_craft({
		output = '"infrastructure:road_sign_right_of_way" 1',
		recipe = {
			{"", 'wool:white', ""},
			{'wool:white', 'wool:yellow', 'wool:white'},
			{"", 'wool:white', ""}
		}
	})

-- Road sign stop
	minetest.register_craft({
		output = '"infrastructure:road_sign_stop" 1',
		recipe = {
			{'wool:red', 'wool:red', 'wool:red'},
			{'wool:red', 'wool:white', 'wool:red'},
			{'wool:red', 'wool:red', 'wool:red'}
		}
	})

-- Road sign yield
	minetest.register_craft({
		output = '"infrastructure:road_sign_yield" 1',
		recipe = {
			{'wool:orange', 'wool:orange', 'wool:orange'},
			{'wool:red', 'wool:orange', 'wool:red'},
			{'', 'wool:red', ''}
		}
	})

-- Automatic warning device
	minetest.register_craft({
		output = '"infrastructure:automatic_warning_device" 1',
		recipe = {
			{'wool:red', 'default:steel_ingot', 'wool:red'},
			{'', 'default:steel_ingot', ''},
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'}
		}
	})

-- Boom barrier
	minetest.register_craft({
		output = '"infrastructure:boom_barrier_mechanism" 1',
		recipe = {
			{'default:steel_ingot', 'default:steel_ingot', ''},
			{'', 'default:steel_ingot', ''},
			{'infrastructure:concrete', 'infrastructure:concrete', 'infrastructure:concrete'}
		}
	})

	minetest.register_craft({
		output = '"infrastructure:boom_barrier_arm" 1',
		recipe = {
			{'', 'wool:red', ''},
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
		}
	})

-- Aircraft warning light
	minetest.register_craft({
		output = '"infrastructure:aircraft_warning_light" 1',
		recipe = {
			{'', 'wool:red', ''},
			{'wool:red', 'default:torch', 'wool:red'},
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
		}
	})

-- Warning light
	minetest.register_craft({
		output = '"infrastructure:warning_light" 1',
		recipe = {
			{'wool:yellow', 'wool:yellow', ''},
			{'wool:yellow', 'default:torch', ''},
			{'default:steel_ingot', 'default:steel_ingot', 'default:steel_ingot'}
		}
	})

-- Anti-dazzling panel
	minetest.register_craft({
		output = '"infrastructure:anti_dazzling_panel" 1',
		recipe = {
			{'wool:grey', 'wool:grey'},
			{'wool:grey', 'wool:yellow'},
			{'wool:grey', 'wool:grey'}
		}
	})

-- Traffic cone
	minetest.register_craft({
		output = '"infrastructure:traffic_cone" 1',
		recipe = {
			{'', 'wool:orange', ''},
			{'wool:orange', '', 'wool:orange'},
		}
	})

-- Noise barrier
	minetest.register_craft({
		output = '"infrastructure:noise_barrier" 1',
		recipe = {
			{'default:steel_ingot', 'wool:green', 'default:steel_ingot'},
			{'wool:green', 'default:steel_ingot', 'wool:green'},
			{'default:steel_ingot', 'wool:green', 'default:steel_ingot'}
		}
	})
