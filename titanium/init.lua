---
---Titanium Mod Version 4 By Aqua. Added new Google Glass Titanium. Be nice this is my first mod!!! Subscribe to my YouTube: youtube.com/theshaunzero!
---

---
---blocks
---

local enable_walking_light = minetest.setting_getbool("titanium_walking_light")
if enable_walking_light ~= false then
	enable_walking_light = true
end

minetest.register_node( "titanium:titanium_in_ground", {
	description = "Titanium Ore",
	tiles  = { "default_stone.png^titanium_titanium_in_ground.png" },
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
	drop = 'craft "titanium:titanium" 1',
})

minetest.register_node( "titanium:block", {
	description = "Titanium Block",
	tiles  = { "titanium_block.png" },
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("titanium:glass", {
	description = "Titanium Glass",
	drawtype = "glasslike",
	tiles  = {"titanium_glass.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = true,
	groups = {snappy=1,cracky=2,oddly_breakable_by_hand=2},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craftitem( "titanium:titanium", {
	description = "Titanium",
	inventory_image = "titanium_titanium.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_craftitem( "titanium:tougher_titanium", {
	description = "Tougher Titanium",
	inventory_image = "tougher_titanium.png",
	on_place_on_ground = minetest.craftitem_place_item,
})

minetest.register_node( "titanium:titanium_plate", {
	description = "Titanium Plate",
	tiles  = {"titanium_plate.png"},
	inventory_image = "titanium_plate.png",
	is_ground_content = true,
	groups = {cracky=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node( "titanium:titanium_tv_1", {
	description = "Titanium TV",
	tiles  = { "titanium_tv_1.png" },
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'titanium:titanium_tv_1',
	light_source = 8,
})

minetest.register_node( "titanium:titanium_tv_2", {
	description = "Titanium TV",
	tiles  = { "titanium_tv_2.png" },
	is_ground_content = true,
	groups = {snappy=1,bendy=2,cracky=1,melty=2,level=2},
	drop = 'titanium:titanium_tv_1',
	light_source = 8,
})

minetest.register_abm({
	nodenames = {"titanium:titanium_tv_1", "titanium:titanium_tv_2"}, 
	interval = 12,
	chance = 1,
	catch_up = false,
	action = function(pos)
		local i = math.random(1,2)
		if i == 1 then
			minetest.add_node(pos,{name="titanium:titanium_tv_1"})
		end
		if i == 2 then
			minetest.add_node(pos,{name="titanium:titanium_tv_2"})
		end
	end 
})

---
---tools
---

minetest.register_tool("titanium:sword", {
	description = "Titanium Sword",
	inventory_image = "titanium_sword.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=1,
		groupcaps={
			fleshy={times={[1]=2.00, [2]=0.60, [3]=0.20}, uses=100, maxlevel=2},
			snappy={times={[2]=0.60, [3]=0.20}, uses=100, maxlevel=1},
			choppy={times={[3]=0.70}, uses=100, maxlevel=0}
		}
	}
})

minetest.register_tool("titanium:axe", {
	description = "Titanium Axe",
	inventory_image = "titanium_axe.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			choppy={times={[1]=2.50, [2]=1.50, [3]=1.00}, uses=150, maxlevel=2},
			fleshy={times={[2]=1.00, [3]=0.50}, uses=120, maxlevel=1}
		}
	},
})

minetest.register_tool("titanium:shovel", {
	description = "Titanium Shovel",
	inventory_image = "titanium_shovel.png",
	tool_capabilities = {
		max_drop_level=1,
		groupcaps={
			crumbly={times={[1]=1.0, [2]=0.50, [3]=0.50}, uses=150, maxlevel=3}
		}
	},
})

minetest.register_tool("titanium:pick", {
	description = "Titanium Pickaxe",
	inventory_image = "titanium_pick.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=3,
		groupcaps={
			cracky={times={[1]=2.4, [2]=1.0, [3]=0.6}, uses=160, maxlevel=3},
			crumbly={times={[1]=2.4, [2]=1.0, [3]=0.6}, uses=160, maxlevel=3},
			snappy={times={[1]=2.4, [2]=1.0, [3]=0.6}, uses=160, maxlevel=3}
		}
	},
})

---
---crafting
---

minetest.register_craft({
	output = 'titanium:pick',
	recipe = {
		{'titanium:titanium', 'titanium:titanium', 'titanium:titanium'},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'titanium:axe',
	recipe = {
		{'titanium:titanium', 'titanium:titanium', ''},
		{'titanium:titanium', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'titanium:shovel',
	recipe = {
		{'', 'titanium:titanium', ''},
		{'', 'default:stick', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'titanium:sword',
	recipe = {
		{'', 'titanium:titanium', ''},
		{'', 'titanium:titanium', ''},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = 'titanium:block',
	recipe = {
		{'titanium:titanium', 'titanium:titanium', 'titanium:titanium'},
		{'titanium:titanium', 'titanium:titanium', 'titanium:titanium'},
		{'titanium:titanium', 'titanium:titanium', 'titanium:titanium'},
	}
})

minetest.register_craft({
	output = 'titanium:titanium 9',
	recipe = {
		{'', 'titanium:block', ''},
	}
})

minetest.register_craft({
	output = 'titanium:glass 3',
	recipe = {
		{'', 'titanium:titanium', ''},
		{'titanium:titanium', 'default:glass', 'titanium:titanium'},
		{'', 'titanium:titanium', ''},
	}
})

minetest.register_craft({
	output = 'titanium:tougher_titanium',
	recipe = {
		{'titanium:titanium', 'titanium:titanium'},
		{'titanium:titanium', 'titanium:titanium'},
	}
})

minetest.register_craft({
	output = 'titanium:titanium_tv_1',
	recipe = {
		{'default:steel_ingot', 'titanium:tougher_titanium', 'default:steel_ingot'},
		{'titanium:tougher_titanium', 'default:glass', 'titanium:tougher_titanium'},
		{'default:steel_ingot', 'titanium:tougher_titanium', 'default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'titanium:titanium_plate 9',
	recipe = {
		{'titanium:titanium', 'titanium:titanium', 'titanium:titanium'},
		{'titanium:titanium', 'titanium:tougher_titanium', 'titanium:titanium'},
		{'titanium:titanium', 'titanium:titanium', 'titanium:titanium'},
	}
})

minetest.register_ore({
	ore_type = "scatter",
	ore =      "titanium:titanium_in_ground",
	wherein =  "default:stone",
	noise_params = {
		offset = 0,
		scale = 1,
		spread = {x=100, y=100, z=100},
		seed = 21,
		octaves = 2,
		persist = 0.70,
	},
	clust_scarcity = 8192,
	clust_num_ores = 5,
	clust_size = 2,
	y_min = -31000,
	y_max = -1500,
})

if enable_walking_light then

	local players = {}
	local player_positions = {}
	local last_wielded = {}

	function round(num) 
		return math.floor(num + 0.5) 
	end

	function check_for_googles (player)
	if player==nil then return false end
	local inv = player:get_inventory()
	local hotbar=inv:get_list("main")
	for index=1,8,1 do
		if hotbar[index]:get_name() == "titanium:sam_titanium" then
			return "titanium:sam_titanium"
		end
	end
	return false
	end   

	minetest.register_on_joinplayer(function(player)
		local player_name = player:get_player_name()
		table.insert(players, player_name)
		last_wielded[player_name] = player:get_wielded_item():get_name()
		local pos = player:getpos()
		local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
		local wielded_item = check_for_googles(player)
		if wielded_item ~= "titanium:sam_titanium" then
			minetest.add_node(rounded_pos,{type="node",name="titanium:who_knows"})
			minetest.add_node(rounded_pos,{type="node",name="air"})
		end
		player_positions[player_name] = {}
		player_positions[player_name]["x"] = rounded_pos.x;
		player_positions[player_name]["y"] = rounded_pos.y;
		player_positions[player_name]["z"] = rounded_pos.z;
	end)

	minetest.register_on_leaveplayer(function(player)
		local player_name = player:get_player_name()
		for i,v in ipairs(players) do
			if v == player_name then 
				table.remove(players, i)
				last_wielded[player_name] = nil
				local pos = player:getpos()
				local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
				minetest.add_node(rounded_pos,{type="node",name="titanium:who_knows"})
				minetest.add_node(rounded_pos,{type="node",name="air"})
				player_positions[player_name]["x"] = nil
				player_positions[player_name]["y"] = nil
				player_positions[player_name]["z"] = nil
				player_positions[player_name]["m"] = nil
				player_positions[player_name] = nil
			end
		end
	end)

	minetest.register_globalstep(function(dtime)
		for i,player_name in ipairs(players) do
			local player = minetest.get_player_by_name(player_name)
			local wielded_item = check_for_googles(player)
			if wielded_item == "titanium:sam_titanium" then
				local pos = player:getpos()
				local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
				if (last_wielded[player_name] ~= "titanium:sam_titanium") or (player_positions[player_name]["x"] ~= rounded_pos.x or player_positions[player_name]["y"] ~= rounded_pos.y or player_positions[player_name]["z"] ~= rounded_pos.z) then
					local is_air  = minetest.get_node_or_nil(rounded_pos)
					if is_air == nil or (is_air ~= nil and (is_air.name == "air" or is_air.name == "titanium:light")) then
						minetest.add_node(rounded_pos,{type="node",name="titanium:light"})
					end
					if (player_positions[player_name]["x"] ~= rounded_pos.x or player_positions[player_name]["y"] ~= rounded_pos.y or player_positions[player_name]["z"] ~= rounded_pos.z) then
						local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
						local is_light = minetest.get_node_or_nil(old_pos)
						if is_light ~= nil and is_light.name == "titanium:light" then
							minetest.add_node(old_pos,{type="node",name="titanium:who_knows"})
							minetest.add_node(old_pos,{type="node",name="air"})
						end
					end
					player_positions[player_name]["x"] = rounded_pos.x
					player_positions[player_name]["y"] = rounded_pos.y
					player_positions[player_name]["z"] = rounded_pos.z
				end

				last_wielded[player_name] = wielded_item;
			elseif last_wielded[player_name] == "titanium:sam_titanium" then
				local pos = player:getpos()
				local rounded_pos = {x=round(pos.x),y=round(pos.y)+1,z=round(pos.z)}
				repeat
					local is_light  = minetest.get_node_or_nil(rounded_pos)
					if is_light ~= nil and is_light.name == "titanium:light" then
						minetest.add_node(rounded_pos,{type="node",name="titanium:who_knows"})
						minetest.add_node(rounded_pos,{type="node",name="air"})
					end
				until minetest.get_node_or_nil(rounded_pos) ~= "titanium:light"
				local old_pos = {x=player_positions[player_name]["x"], y=player_positions[player_name]["y"], z=player_positions[player_name]["z"]}
				repeat
					is_light  = minetest.get_node_or_nil(old_pos)
					if is_light ~= nil and is_light.name == "titanium:light" then
						minetest.add_node(old_pos,{type="node",name="titanium:who_knows"})
						minetest.add_node(old_pos,{type="node",name="air"})
					end
				until minetest.get_node_or_nil(old_pos) ~= "titanium:light"
				last_wielded[player_name] = wielded_item
			end
		end
	end)

	------------------------------------------------------
	-- Version 4------------------------------------------

	minetest.register_node("titanium:light", {
		drawtype = "glasslike",
		tiles  = {"titanium.png"},
		inventory_image = minetest.inventorycube("titanium.png"),
		paramtype = "light",
		walkable = false,
		is_ground_content = true,
		sunlight_propagates = true,
		buildable_to = true,
		light_source = 11,
		selection_box = {
			type = "fixed",
			fixed = {0, 0, 0, 0, 0, 0},
		},
	})

	minetest.register_tool("titanium:sam_titanium", {
		description = "Google Glass Titanium",
		inventory_image = "sam_titanium.png",
		wield_image = "sam_titanium.png",
		tool_capabilities = {
			max_drop_level=1,
			groupcaps={
					cracky={times={[2]=1.20, [3]=0.80}, uses=5, maxlevel=1}
			}
		},
	})

	minetest.register_craft({
		output = 'titanium:sam_titanium',
		recipe = {
			{'titanium:titanium_plate', 'default:torch', 'titanium:titanium_plate'},
			{'titanium:glass', 'default:mese_crystal', 'titanium:glass'},
			{'', '', ''},
		}
	})
	--------------------------------------------------------
	minetest.register_node("titanium:who_knows", {
		description = "?Who Knows?",
		tiles = {"titanium.png"},
		is_ground_content = true,
		groups = {not_in_creative_inventory=1},
	})
end

minetest.log("info", "[Titanium Mod] Loaded! By Aqua! Subscribe to my YouTube: youtube.com/theshaunzero!")
