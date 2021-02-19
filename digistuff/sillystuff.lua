local heatsinkable_nodes = {
	["digistuff:nic"] = true,
	["digistuff:gpu"] = true,
	["digistuff:ram"] = true,
	["digistuff:eeprom"] = true,
}

for i=0,15,1 do
	local bit0 = i%2>0 and "1" or "0"
	local bit1 = i%4>2 and "1" or "0"
	local bit2 = i%8>4 and "1" or "0"
	local bit3 = i%16>8 and "1" or "0"
	heatsinkable_nodes["mesecons_luacontroller:luacontroller"..bit0..bit1..bit2..bit3] = true
	heatsinkable_nodes["digistuff:ioexpander_"..i] = true
end

minetest.register_node("digistuff:heatsink", {
	description = "Heatsink (decorative)",
	groups = {cracky=3},
	tiles = {
		"digistuff_piezo_sides.png"
	},
	drawtype = "nodebox",
	selection_box = {
		type = "fixed",
		fixed = {-0.19,-0.5,-0.2,0.19,-0.3,0.2 },
	},
	node_box = {
		--From Luacontroller
		type = "fixed",
		fixed = {
			{-0.19, -0.5,-0.2, 0.19, -0.45, 0.2}, -- Base
			{-0.19,-0.45,-0.2,-0.17,  -0.3, 0.2},
			{-0.15,-0.45,-0.2,-0.13,  -0.3, 0.2},
			{-0.11,-0.45,-0.2,-0.09,  -0.3, 0.2},
			{-0.07,-0.45,-0.2,-0.05,  -0.3, 0.2},
			{-0.03,-0.45,-0.2,-0.01,  -0.3, 0.2},
			{ 0.19,-0.45,-0.2, 0.17,  -0.3, 0.2},
			{ 0.15,-0.45,-0.2, 0.13,  -0.3, 0.2},
			{ 0.11,-0.45,-0.2, 0.09,  -0.3, 0.2},
			{ 0.07,-0.45,-0.2, 0.05,  -0.3, 0.2},
			{ 0.03,-0.45,-0.2, 0.01,  -0.3, 0.2},
		}
	},
	after_place_node = function(pos)
		local icpos = vector.add(pos,vector.new(0,-1,0))
		if heatsinkable_nodes[minetest.get_node(icpos).name] then
			minetest.set_node(pos,{name = "digistuff:heatsink_onic"})
		end
	end,
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.register_node("digistuff:heatsink_onic", {
	drop = "digistuff:heatsink",
	description = "Heatsink (decorative, placed on IC - you hacker you!)",
	groups = {cracky=3,not_in_creative_inventory=1,},
	tiles = {
		"digistuff_piezo_sides.png"
	},
	drawtype = "nodebox",
	selection_box = {
		type = "fixed",
		fixed = {-0.19,-1.3125,-0.2,0.19,-1.1525,0.2 },
	},
	node_box = {
		--From Luacontroller
		type = "fixed",
		fixed = {
			{-0.19, -1.3125,-0.2, 0.19, -1.2625, 0.2}, -- Base
			{-0.19,-1.2625,-0.2,-0.17,  -1.1525, 0.2},
			{-0.15,-1.2625,-0.2,-0.13,  -1.1525, 0.2},
			{-0.11,-1.2625,-0.2,-0.09,  -1.1525, 0.2},
			{-0.07,-1.2625,-0.2,-0.05,  -1.1525, 0.2},
			{-0.03,-1.2625,-0.2,-0.01,  -1.1525, 0.2},
			{ 0.19,-1.2625,-0.2, 0.17,  -1.1525, 0.2},
			{ 0.15,-1.2625,-0.2, 0.13,  -1.1525, 0.2},
			{ 0.11,-1.2625,-0.2, 0.09,  -1.1525, 0.2},
			{ 0.07,-1.2625,-0.2, 0.05,  -1.1525, 0.2},
			{ 0.03,-1.2625,-0.2, 0.01,  -1.1525, 0.2},
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
})

minetest.register_craft({
	output = "digistuff:heatsink",
	recipe = {
		{"basic_materials:steel_strip","basic_materials:steel_strip","basic_materials:steel_strip"},
		{"","default:steel_ingot",""}
	}
})
