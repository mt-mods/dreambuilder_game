-- simple streetlight spawner mod

local modpath = minetest.get_modpath("simple_streetlights")

streetlights = {}
streetlights.basic_materials = minetest.get_modpath("basic_materials")
streetlights.concrete =      "basic_materials:concrete_block"
streetlights.distributor =   "streets:digiline_distributor"
streetlights.vert_digiline = "digistuff:vertical_bottom"

function streetlights.rightclick_pointed_thing(pos, placer, itemstack, pointed_thing)
	local node = minetest.get_node_or_nil(pos)
	if not node then return false end
	local def = minetest.registered_nodes[node.name]
	if not def or not def.on_rightclick then return false end
	return def.on_rightclick(pos, node, placer, itemstack, pointed_thing) or itemstack
end

dofile(modpath.."/simple.lua")
if minetest.get_modpath("homedecor_lighting") and minetest.get_modpath("streetspoles") then
	dofile(modpath.."/minedot.lua")
end
