digistuff.remove_receiver = function(pos,node)
	local dir = minetest.facedir_to_dir(node.param2)
	local rpos = vector.add(pos,vector.multiply(dir,2))
	local rnode = minetest.get_node(rpos)
	if rnode.name == "digistuff:receiver" then
		rnode.name = "digilines:wire_std_00000000"
		minetest.remove_node(rpos)
		minetest.set_node(rpos,rnode)
		digilines.update_autoconnect(rpos)
	end
end

digistuff.place_receiver = function(pos)
	local node = minetest.get_node(pos)
	local dir = minetest.facedir_to_dir(node.param2)
	if dir.y == 0 then
		local nodebehind = minetest.get_node(vector.add(pos,dir))
		if nodebehind.name == "digistuff:digimese" then return end
		local rpos = vector.add(pos,vector.multiply(dir,2))
		local rnode = minetest.get_node(rpos)
		if string.find(rnode.name,"^digilines:wire_std_") then
			minetest.remove_node(rpos)
			local newrnode = {pos = rpos,name = "digistuff:receiver",param2 = node.param2,}
			minetest.set_node(rpos,newrnode)
			digilines.update_autoconnect(rpos)
		end
	end
end

local old_update_autoconnect = digilines.update_autoconnect

digilines.update_autoconnect = function(pos,secondcall)
	if not secondcall then
		local node = minetest.get_node(pos)
		if string.find(node.name,"^digilines:wire_std_") then
			local checkdirs = {
				{x = 1,y = 0,z = 0},
				{x = -1,y = 0,z = 0},
				{x = 0,y = 0,z = 1},
				{x = 0,y = 0,z = -1},
			}
			local found = false
			for _,i in ipairs(checkdirs) do
				if not found then
					local checkpos = vector.add(pos,vector.multiply(i,2))
					local group = minetest.get_item_group(minetest.get_node(checkpos).name,"digiline_receiver")
					if group and group > 0 then
						digistuff.place_receiver(checkpos)
						if minetest.get_node(pos).name == "digistuff:receiver" then found = true end
					end
				end
			end
		end
	end
	old_update_autoconnect(pos,secondcall)
end

minetest.register_node("digistuff:digimese", {
	description = "Digimese",
	tiles = {"digistuff_digimese.png"},
	paramtype = "light",
	light_source = 3,
	groups = {cracky = 3, level = 2},
	is_ground_content = false,
	sounds = default and default.node_sound_stone_defaults(),
	digiline = { wire = { rules = {
	{x = 1, y = 0, z = 0},
	{x =-1, y = 0, z = 0},
	{x = 0, y = 1, z = 0},
	{x = 0, y =-1, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z =-1}}}}
})

minetest.register_node("digistuff:junctionbox", {
	description = "Digilines Junction Box",
	tiles = {"digistuff_junctionbox.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.1,-0.15,0.35,0.1,0.15,0.5},
			}
	},
	sounds = default and default.node_sound_stone_defaults(),
	digiline = {
		receptor = {},
		wire = {
			rules = {
				{x = 1,y = 0,z = 0},
				{x = -1,y = 0,z = 0},
				{x = 0,y = 0,z = 1},
				{x = 0,y = 0,z = -1},
				{x = 0,y = 1,z = 0},
				{x = 0,y = -1,z = 0},
				{x = 0,y = -2,z = 0},
				{x = 0,y = 2,z = 0},
				{x = -2,y = 0,z = 0},
				{x = 2,y = 0,z = 0},
				{x = 0,y = 0,z = -2},
				{x = 0,y = 0,z = 2},
			}
		},
	},
})

digistuff.receiver_get_rules = function(node)
	local rules = {
		{x = 0,y = 0,z = -2},
		{x = 0,y = 0,z =  1},
	}
	return digistuff.rotate_rules(rules,minetest.facedir_to_dir(node.param2))
end

minetest.register_node("digistuff:receiver", {
	description = "Digilines Receiver (you hacker you!)",
	tiles = {"digistuff_digiline_full.png"},
	paramtype = "light",
	groups = {dig_immediate = 3,not_in_creative_inventory = 1,},
	drop = "digilines:wire_std_00000000",
	is_ground_content = false,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.05,-0.05,-1.49,0.05,0.05,-0.5},
			{-0.2,-0.2,-0.5,0.2,0.2,-0.4},
			{-0.0625,-0.5,-0.5,0.0625,-0.2,-0.4},
			{-0.0625,-0.5,-0.4,0.0625,-0.4375,0.5},
			},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.2,-0.5,-0.5,0.2,0.2,0.5},
			{-0.075,-0.075,-1.49,0.075,0.075,-0.5},
		},
	},
	digiline = {
		receptor = {},
		wire = {
			rules = digistuff.receiver_get_rules,
		},
	},
})

digistuff.vertical_autoconnect = function(pos)
	local node = minetest.get_node(pos)
	if minetest.get_item_group(node.name,"vertical_digiline") == 0 then return end
	local uppos = vector.add(pos,vector.new(0,1,0))
	local dnpos = vector.add(pos,vector.new(0,-1,0))
	local upnode = minetest.get_node(uppos)
	local dnnode = minetest.get_node(dnpos)
	local shouldbe = "digistuff:vertical_bottom"
	if minetest.get_item_group(dnnode.name,"vertical_digiline") > 0 then
		if minetest.get_item_group(upnode.name,"vertical_digiline") > 0 then
			shouldbe = "digistuff:vertical_middle"
		else
			shouldbe = "digistuff:vertical_top"
		end
	end
	if shouldbe ~= node.name or upnode.name == "digistuff:vertical_bottom" or dnnode.name == "digistuff:vertical_top" then
		node.name = shouldbe
		minetest.set_node(pos,node)
		digilines.update_autoconnect(pos)
		digistuff.vertical_autoconnect(uppos)
		digistuff.vertical_autoconnect(dnpos)
	end
end

digistuff.vertical_remove = function(pos)
	local uppos = vector.add(pos,vector.new(0,1,0))
	local dnpos = vector.add(pos,vector.new(0,-1,0))
	digistuff.vertical_autoconnect(uppos)
	digistuff.vertical_autoconnect(dnpos)
end

minetest.register_node("digistuff:vertical_bottom", {
	description = "Vertical Digiline",
	tiles = {"digistuff_digiline_full.png"},
	paramtype = "light",
	groups = {dig_immediate = 3,vertical_digiline = 1,},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.4375,0.5},
				{-0.05,-0.4375,-0.05,0.05,0.5,0.05},
			},
	},
	collision_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.4375,0.5},
			},
	},
	after_place_node = digistuff.vertical_autoconnect,
	after_destruct = digistuff.vertical_remove,
	digiline = {
		receptor = {},
		wire = {
			rules = {
				{x =  1,y =  0,z =  0},
				{x = -1,y =  0,z =  0},
				{x =  0,y =  0,z =  1},
				{x =  0,y =  0,z = -1},
				{x =  0,y =  1,z =  0},
				{x =  0,y =  2,z =  0},
			},
		},
	},
})

minetest.register_node("digistuff:vertical_middle", {
	description = "Vertical Digiline (middle - you hacker you!)",
	tiles = {"digistuff_digiline_full.png"},
	paramtype = "light",
	groups = {dig_immediate = 3,not_in_creative_inventory = 1,vertical_digiline = 1,},
	drop = "digistuff:vertical_bottom",
	is_ground_content = false,
	paramtype = "light",
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.05,-0.5,-0.05,0.05,0.5,0.05},
			},
	},
	after_place_node = digistuff.vertical_autoconnect,
	after_destruct = digistuff.vertical_remove,
	digiline = {
		receptor = {},
		wire = {
			rules = {
				{x =  0,y =  1,z =  0},
				{x =  0,y = -1,z =  0},
			},
		},
	},
})

minetest.register_node("digistuff:vertical_top", {
	description = "Vertical Digiline (top - you hacker you!)",
	tiles = {"digistuff_digiline_full.png"},
	paramtype = "light",
	groups = {dig_immediate = 3,not_in_creative_inventory = 1,vertical_digiline = 1,},
	drop = "digistuff:vertical_bottom",
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.5,0.5,-0.4375,0.5},
			},
	},
	after_place_node = digistuff.vertical_autoconnect,
	after_destruct = digistuff.vertical_remove,
	digiline = {
		receptor = {},
		wire = {
			rules = {
				{x =  1,y =  0,z =  0},
				{x = -1,y =  0,z =  0},
				{x =  0,y =  0,z =  1},
				{x =  0,y =  0,z = -1},
				{x =  0,y = -1,z =  0},
			},
		},
	},
})

minetest.register_node("digistuff:insulated_straight", {
	description = "Insulated Digiline (straight)",
	tiles = {
		"digistuff_insulated_full.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_full.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple,
	groups = {dig_immediate = 3,},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.1,0.5,-0.4,0.1},
			},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.15,0.5,-0.35,0.15},
		},
	},
	after_place_node = digilines.update_autoconnect,
	after_destruct = digilines.update_autoconnect,
	digiline = {
		receptor = {},
		wire = {
			rules = function(node)
				local rules = {
					{x = 1,y = 0,z = 0},
					{x = -1,y = 0,z = 0},
				}
				return digistuff.rotate_rules(rules,minetest.facedir_to_dir(node.param2))
			end,
		},
	},
})

minetest.register_node("digistuff:insulated_tjunction", {
	description = "Insulated Digiline (T junction)",
	tiles = {
		"digistuff_insulated_full.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_edge.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple,
	groups = {dig_immediate = 3,},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.1,0.5,-0.4,0.1},
				{-0.1,-0.5,-0.5,0.1,-0.4,-0.1},
			},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,-0.35,0.15},
		},
	},
	after_place_node = digilines.update_autoconnect,
	after_destruct = digilines.update_autoconnect,
	digiline = {
		receptor = {},
		wire = {
			rules = function(node)
				local rules = {
					{x = 1,y = 0,z = 0},
					{x = -1,y = 0,z = 0},
					{x = 0,y = 0,z = -1},
				}
				return digistuff.rotate_rules(rules,minetest.facedir_to_dir(node.param2))
			end,
		},
	},
})

minetest.register_node("digistuff:insulated_corner", {
	description = "Insulated Digiline (corner)",
	tiles = {
		"digistuff_insulated_full.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_edge.png",
	},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	on_rotate = minetest.get_modpath("screwdriver") and screwdriver.rotate_simple,
	groups = {dig_immediate = 3,},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.1,-0.5,-0.5,0.1,-0.4,0.1},
				{-0.5,-0.5,-0.1,0.1,-0.4,0.1},
			},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.15,-0.35,0.15},
		},
	},
	after_place_node = digilines.update_autoconnect,
	after_destruct = digilines.update_autoconnect,
	digiline = {
		receptor = {},
		wire = {
			rules = function(node)
				local rules = {
					{x = -1,y = 0,z = 0},
					{x = 0,y = 0,z = -1},
				}
				return digistuff.rotate_rules(rules,minetest.facedir_to_dir(node.param2))
			end,
		},
	},
})

minetest.register_node("digistuff:insulated_fourway", {
	description = "Insulated Digiline (four-way junction)",
	tiles = {
		"digistuff_insulated_full.png",
		"digistuff_insulated_full.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_edge.png",
		"digistuff_insulated_edge.png",
	},
	paramtype = "light",
	walkable = false,
	groups = {dig_immediate = 3,},
	is_ground_content = false,
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5,-0.5,-0.1,0.5,-0.4,0.1},
				{-0.1,-0.5,-0.5,0.1,-0.4,-0.1},
				{-0.1,-0.5,0.1,0.1,-0.4,0.5},
			},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,-0.35,0.5},
		},
	},
	after_place_node = digilines.update_autoconnect,
	after_destruct = digilines.update_autoconnect,
	digiline = {
		receptor = {},
		wire = {
			rules = {
				{x = 1,y = 0,z = 0},
				{x = -1,y = 0,z = 0},
				{x = 0,y = 0,z = -1},
				{x = 0,y = 0,z = 1},
			},
		},
	},
})

minetest.register_craft({
	output = "digistuff:digimese",
	recipe = {
		{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000"},
		{"digilines:wire_std_00000000","default:mese","digilines:wire_std_00000000"},
		{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000"}
	}
})

minetest.register_craft({
	output = "digistuff:junctionbox",
	recipe = {
		{"homedecor:plastic_sheeting","digilines:wire_std_00000000","homedecor:plastic_sheeting",},
		{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000",},
		{"homedecor:plastic_sheeting","digilines:wire_std_00000000","homedecor:plastic_sheeting",},
	}
})

if minetest.get_modpath("mesecons_materials") then
	minetest.register_craft({
		output = "digistuff:insulated_straight 3",
		recipe = {
			{"mesecons_materials:fiber","mesecons_materials:fiber","mesecons_materials:fiber",},
			{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000",},
			{"mesecons_materials:fiber","mesecons_materials:fiber","mesecons_materials:fiber",},
		}
	})
end

minetest.register_craft({
	output = "digistuff:vertical_bottom 3",
	recipe = {
		{"digilines:wire_std_00000000",},
		{"digilines:wire_std_00000000",},
		{"digilines:wire_std_00000000",},
	}
})

minetest.register_craft({
	output = "digistuff:insulated_corner 3",
	recipe = {
		{"digistuff:insulated_straight","digistuff:insulated_straight",},
		{"","digistuff:insulated_straight",},
	}
})

minetest.register_craft({
	output = "digistuff:insulated_tjunction 4",
	recipe = {
		{"digistuff:insulated_straight","digistuff:insulated_straight","digistuff:insulated_straight",},
		{"","digistuff:insulated_straight","",},
	}
})

minetest.register_craft({
	output = "digistuff:insulated_fourway 5",
	recipe = {
		{"","digistuff:insulated_straight","",},
		{"digistuff:insulated_straight","digistuff:insulated_straight","digistuff:insulated_straight",},
		{"","digistuff:insulated_straight","",},
	}
})

for _,item in ipairs({"digistuff:insulated_corner","digistuff:insulated_tjunction","digistuff:insulated_fourway",}) do
	minetest.register_craft({
		output = "digistuff:insulated_straight",
		type = "shapeless",
		recipe = {item},
	})
end

minetest.register_craft({
	output = "digilines:wire_std_00000000",
	type = "shapeless",
	recipe = {"digistuff:vertical_bottom"},
})
