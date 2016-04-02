infrastructure = {}

-- Load settings
dofile(minetest.get_modpath("infrastructure").."/settings.lua")

-- Register nodes
dofile(minetest.get_modpath("infrastructure").."/nodes.lua")
-- Register special nodes
dofile(minetest.get_modpath("infrastructure").."/nodes_extension.lua")
-- Register advanced devices
dofile(minetest.get_modpath("infrastructure").."/advanced_road_signs.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_emergency_phone.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_traffic_lights_pedestrians.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_crosswalk_warning_light.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_lane_control_lights.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_curve_chevron.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_crosswalk_lighting.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_crosswalk_safety_sign.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_automatic_warning_device.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_boom_barrier.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_aircraft_warning_light.lua")
dofile(minetest.get_modpath("infrastructure").."/advanced_warning_light.lua")
-- Register crafting recipes
dofile(minetest.get_modpath("infrastructure").."/crafts.lua")

print("Infrastructure mod loaded succesfully!")
