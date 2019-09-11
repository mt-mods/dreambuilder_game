-- Mod:     BEES
-- Author:  Bas080 (Tweaked by TenPlus1)
-- License: MIT


-- Intllib support
local S
if minetest.global_exists("intllib") then
	S = intllib.Getter()
else
	S = function(s) return s end
end


-- FUNCTIONS

local floor = math.floor
local random = math.random

local hive_wild = function(pos, grafting)

	local spos = pos.x .. "," .. pos.y .. "," ..pos.z
	local formspec = "size[8,9]"
		.. "list[nodemeta:".. spos .. ";combs;1.5,3;5,1;]"
		.. "list[current_player;main;0,5;8,4;]"

	if grafting then
		formspec = formspec .."list[nodemeta:".. spos .. ";queen;3.5,1;1,1;]"
	end

	return formspec
end


local hive_artificial = function(pos)

	local spos = pos.x..","..pos.y..","..pos.z
	local formspec = "size[8,9]"
		.. "list[nodemeta:"..spos..";queen;3.5,1;1,1;]"
		.. "list[nodemeta:"..spos..";frames;0,3;8,1;]"
		.. "list[current_player;main;0,5;8,4;]"

	return formspec
end


local polinate_flower = function(pos, flower)

	local spawn_pos = {
		x = pos.x + random(-3, 3),
		y = pos.y + random(-3, 3),
		z = pos.z + random(-3, 3)
	}
	local floor_pos = {x = spawn_pos.x, y = spawn_pos.y - 1, z = spawn_pos.z}
	local spawn = minetest.get_node(spawn_pos).name
	local floor = minetest.get_node(floor_pos).name

	if floor == "group:soil" and spawn == "air" then
		minetest.set_node(spawn_pos, {name = flower})
	end
end


-- NODES

minetest.register_node("bees:extractor", {
	description = S("Honey Extractor"),
	tiles = {
		"bees_extractor.png", "bees_extractor.png", "bees_extractor.png",
		"bees_extractor.png", "bees_extractor.png", "bees_extractor_front.png"
	},
	paramtype2 = "facedir",
	groups = {
		choppy = 2, oddly_breakable_by_hand = 2, tubedevice = 1,
		tubedevice_receiver = 1
	},

	on_construct = function(pos, node)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local pos = pos.x .. "," .. pos.y .. "," .. pos.z

		inv:set_size("frames_filled", 1)
		inv:set_size("frames_emptied", 1)
		inv:set_size("bottles_empty", 1)
		inv:set_size("bottles_full", 1)
		inv:set_size("wax", 1)

		meta:set_string("formspec", "size[8,9]"
			--input
			.. "list[nodemeta:"..pos..";frames_filled;2,1;1,1;]"
			.. "list[nodemeta:"..pos..";bottles_empty;2,3;1,1;]"
			--output
			.. "list[nodemeta:"..pos..";frames_emptied;5,0.5;1,1;]"
			.. "list[nodemeta:"..pos..";wax;5,2;1,1;]"
			.. "list[nodemeta:"..pos..";bottles_full;5,3.5;1,1;]"
			--player inventory
			.. "list[current_player;main;0,5;8,4;]"
		)
	end,

	on_timer = function(pos, node)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		if not inv:contains_item("frames_filled", "bees:frame_full")
		or not inv:contains_item("bottles_empty", "vessels:glass_bottle") then
			return
		end

		if inv:room_for_item("frames_emptied", "bees:frame_empty")
		and inv:room_for_item("wax", "bees:wax")
		and inv:room_for_item("bottles_full", "bees:bottle_honey") then

			--add to output
			inv:add_item("frames_emptied", "bees:frame_empty")
			inv:add_item("wax", "bees:wax")
			inv:add_item("bottles_full", "bees:bottle_honey")

			--remove from input
			inv:remove_item("bottles_empty", "vessels:glass_bottle")
			inv:remove_item("frames_filled", "bees:frame_full")

			local p = {
				x = pos.x + random() - 0.5,
				y = pos.y + random() - 0.5,
				z = pos.z + random() - 0.5
			}

			--wax flying all over the place
			minetest.add_particle({
				pos = {x = pos.x, y = pos.y, z = pos.z},
				vel = {
					x = random(-1, 1),
					y = random(4),
					z = random(-1, 1)
				},
				acc = {x = 0, y = -6, z = 0},
				expirationtime = 2,
				size = random(1, 3),
				collisiondetection = false,
				texture = "bees_wax_particle.png",
			})

			local timer = minetest.get_node_timer(pos)

			timer:start(5)
		else
			local timer = minetest.get_node_timer(pos)

			timer:start(5) -- Try again in 5 seconds (was 1)
		end
	end,

	tube = {
		insert_object = function(pos, node, stack, direction)

			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local timer = minetest.get_node_timer(pos)

			if stack:get_name() == "bees:frame_full" then

				if inv:is_empty("frames_filled") then
					timer:start(5)
				end

				return inv:add_item("frames_filled",stack)

			elseif stack:get_name() == "vessels:glass_bottle" then

				if inv:is_empty("bottles_empty") then
					timer:start(5)
				end

				return inv:add_item("bottles_empty",stack)
			end

			return stack
		end,

		can_insert = function(pos,node,stack,direction)

			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()

			if stack:get_name() == "bees:frame_full" then

				return inv:room_for_item("frames_filled",stack)

			elseif stack:get_name() == "vessels:glass_bottle" then

				return inv:room_for_item("bottles_empty",stack)
			end

			return false
		end,

		input_inventory = {"frames_emptied", "bottles_full", "wax"},

		connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
	},

	on_metadata_inventory_put = function(pos, listname, index, stack, player)

		local timer = minetest.get_node_timer(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		-- if inventory empty start timer for honey bottle, empty frame and wax
		if inv:get_stack(listname, 1):get_count() == stack:get_count() then
			timer:start(5)
		end
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)

		if (listname == "bottles_empty" and stack:get_name() == "vessels:glass_bottle")
		or (listname == "frames_filled" and stack:get_name() == "bees:frame_full") then
			return stack:get_count()
		else
			return 0
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		return 0
	end,

	allow_metadata_inventory_take = function(pos, listname, index, stack, player)

		if player and minetest.is_protected(pos, player:get_player_name()) then
			return 0
		end

		return stack:get_count()
	end,
})


minetest.register_node("bees:bees", {
	description = S("Bees"),
	drawtype = "plantlike",
	paramtype = "light",
	groups = {not_in_creative_inventory = 1},
	tiles = {
		{
			name = "bees_strip.png",
			animation = {
				type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2.0
			}
		}
	},
	damage_per_second = 1,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.3, -0.4, -0.3, 0.3, 0.4, 0.3},
		}
	},

	on_punch = function(pos, node, puncher)

		puncher:set_hp(puncher:get_hp() - 2)
	end,
})


minetest.register_node("bees:hive_wild", {
	description = S("Wild Bee Hive"),
	tiles = { --Neuromancer"s base texture
		"bees_hive_wild.png", "bees_hive_wild.png", "bees_hive_wild.png",
		"bees_hive_wild.png", "bees_hive_wild_bottom.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "wallmounted",
	drop = {
		max_items = 6,
		items = {
			{ items = {"bees:honey_comb"}, rarity = 5}
		}
	},
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 3, attached_node = 1},
	node_box = { --VanessaE's wild hive nodebox contribution
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.250000,0.250000,0.375000,0.250000}, --NodeBox 2
			{-0.312500,-0.375000,-0.312500,0.312500,0.250000,0.312500}, --NodeBox 4
			{-0.375000,-0.250000,-0.375000,0.375000,0.125000,0.375000}, --NodeBox 5
			{-0.062500,-0.500000,-0.062500,0.062500,0.500000,0.062500}, --NodeBox 6
		}
	},

	on_timer = function(pos)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)
		local rad = 10
		local flowers = minetest.find_nodes_in_area(
			{x = pos.x - rad, y = pos.y - rad, z = pos.z - rad},
			{x = pos.x + rad, y = pos.y + rad, z = pos.z + rad},
			"group:flower")

		-- Queen dies if no flowers nearby
		if #flowers == 0 then

			inv:set_stack("queen", 1, "")

			meta:set_string("infotext", S("Colony died, not enough flowers in area!"))

			return
		end

		-- Requires 2 or more flowers to make honey
		if #flowers < 3 then return end

		local flower = flowers[random(#flowers)]

		polinate_flower(flower, minetest.get_node(flower).name)

		local stacks = inv:get_list("combs")

		for k, v in pairs(stacks) do

			if inv:get_stack("combs", k):is_empty() then

				inv:set_stack("combs", k, "bees:honey_comb")

				timer:start(1000 / #flowers)

				return
			end
		end
		--what to do if all combs are filled
	end,

	on_construct = function(pos)

		minetest.get_node(pos).param2 = 0

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)

		meta:set_int("agressive", 1)

		timer:start(100 + random(100))

		inv:set_size("queen", 1)
		inv:set_size("combs", 5)
		inv:set_stack("queen", 1, "bees:queen")

		for i = 1, random(3) do
			inv:set_stack("combs", i, "bees:honey_comb")
		end
	end,

	on_punch = function(pos, node, puncher)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		if inv:contains_item("queen", "bees:queen") then

			puncher:set_hp(puncher:get_hp() - 4)
		end
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, taker)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local timer= minetest.get_node_timer(pos)

		if listname == "combs" and inv:contains_item("queen", "bees:queen") then

			timer:start(10)

			taker:set_hp(taker:get_hp() - 2)
		end
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, taker)

		local timer = minetest.get_node_timer(pos)

		if not timer:is_started() then
			timer:start(10)
		end
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)

		 --restart the colony by adding a queen
		if listname == "queen" and stack:get_name() == "bees:queen" then
			return 1
		else
			return 0
		end
	end,

	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)

		minetest.show_formspec(clicker:get_player_name(),
			"bees:hive_artificial",
			hive_wild(pos, (itemstack:get_name() == "bees:grafting_tool"))
		)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		if meta:get_int("agressive") == 1
		and inv:contains_item("queen", "bees:queen") then

			clicker:set_hp(clicker:get_hp() - 4)
		else
			meta:set_int("agressive", 1)
		end
	end,

	can_dig = function(pos,player)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		if inv:is_empty("queen") and inv:is_empty("combs") then
			return true
		else
			return false
		end
	end,

	after_dig_node = function(pos, oldnode, oldmetadata, user)

		local wielded

		if user:get_wielded_item() ~= nil then
			wielded = user:get_wielded_item()
		else
			return
		end

		if "bees:grafting_tool" == wielded:get_name() then

			local inv = user:get_inventory()

			if inv then
				inv:add_item("main", ItemStack("bees:queen"))
			end
		end
	end
})


minetest.register_node("bees:hive_artificial", {
	description = S("Artificial Bee Hive"),
	tiles = {
		"default_wood.png", "default_wood.png", "default_wood.png",
		"default_wood.png", "default_wood.png", "bees_hive_artificial.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {
		snappy = 1, choppy = 2, oddly_breakable_by_hand = 2,
		flammable = 3, wood = 1
	},
	sounds = default.node_sound_wood_defaults(),
	node_box = {
		type = "fixed",
		fixed = {
			{-4/8, 2/8, -4/8, 4/8, 3/8, 4/8},
			{-3/8, -4/8, -2/8, 3/8, 2/8, 3/8},
			{-3/8, 0/8, -3/8, 3/8, 2/8, -2/8},
			{-3/8, -4/8, -3/8, 3/8, -1/8, -2/8},
			{-3/8, -1/8, -3/8, -1/8, 0/8, -2/8},
			{1/8, -1/8, -3/8, 3/8, 0/8, -2/8},
		}
	},

	on_construct = function(pos)

		local timer = minetest.get_node_timer(pos)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		meta:set_int("agressive", 1)

		inv:set_size("queen", 1)
		inv:set_size("frames", 8)

		meta:set_string("infotext", S("Requires Queen bee to function"))
	end,

	on_rightclick = function(pos, node, clicker, itemstack)

		if minetest.is_protected(pos, clicker:get_player_name()) then
			return
		end

		minetest.show_formspec(clicker:get_player_name(),
			"bees:hive_artificial",
			hive_artificial(pos)
		)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()

		if meta:get_int("agressive") == 1
		and inv:contains_item("queen", "bees:queen") then

			clicker:set_hp(clicker:get_hp() - 4)
		else
			meta:set_int("agressive", 1)
		end
	end,

	on_timer = function(pos,elapsed)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)

		if inv:contains_item("queen", "bees:queen") then

			if inv:contains_item("frames", "bees:frame_empty") then

				timer:start(30)

				local rad = 10
				local flowers = minetest.find_nodes_in_area(
					{x = pos.x - rad, y = pos.y - rad, z = pos.z - rad},
					{x = pos.x + rad, y = pos.y + rad, z = pos.z + rad},
					"group:flower")

				local progress = meta:get_int("progress")

				progress = progress + #flowers

				meta:set_int("progress", progress)

				if progress > 1000 then

					local flower = flowers[random(#flowers)]

					polinate_flower(flower, minetest.get_node(flower).name)

					local stacks = inv:get_list("frames")

					for k, v in pairs(stacks) do

						if inv:get_stack("frames", k):get_name() == "bees:frame_empty" then

							meta:set_int("progress", 0)

							inv:set_stack("frames", k, "bees:frame_full")

							return
						end
					end
				else
					meta:set_string("infotext", S("progress:")
						.. " " .. progress .. " + " .. #flowers .. " / 1000")
				end
			else
				meta:set_string("infotext", S("Does not have empty frame(s)"))

				timer:stop()
			end
		end
	end,

	on_metadata_inventory_take = function(pos, listname, index, stack, player)

		if listname == "queen" then

			local timer = minetest.get_node_timer(pos)
			local meta = minetest.get_meta(pos)

			meta:set_string("infotext", S("Requires Queen bee to function"))

			timer:stop()
		end
	end,

	allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)

		local inv = minetest.get_meta(pos):get_inventory()

		if from_list == to_list then

			if inv:get_stack(to_list, to_index):is_empty() then
				return 1
			else
				return 0
			end
		else
			return 0
		end
	end,

	on_metadata_inventory_put = function(pos, listname, index, stack, player)

		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local timer = minetest.get_node_timer(pos)

		if listname == "queen" or listname == "frames" then

			meta:set_string("queen", stack:get_name())
			meta:set_string("infotext", S("Queen inserted, now for the empty frames"))

			if inv:contains_item("frames", "bees:frame_empty") then

				timer:start(30)

				meta:set_string("infotext", S("Bees are aclimating"))
			end
		end
	end,

	allow_metadata_inventory_put = function(pos, listname, index, stack, player)

		if not minetest.get_meta(pos):get_inventory():get_stack(listname, index):is_empty() then return 0 end

		if listname == "queen" then

			if stack:get_name():match("bees:queen*") then
				return 1
			end

		elseif listname == "frames" then

			if stack:get_name() == ("bees:frame_empty") then
				return 1
			end
		end

		return 0
	end,
})

-- ABMS

minetest.register_abm({
	nodenames = {"bees:hive_artificial", "bees:hive_wild", "bees:hive_industrial"},
	interval = 10,
	chance = 4,

	action = function(pos, node)

		-- Bee particle
		minetest.add_particle({
			pos = {x = pos.x, y = pos.y, z = pos.z},
			vel = {
				x = (random() - 0.5) * 5,
				y = (random() - 0.5) * 5,
				z = (random() - 0.5) * 5
			},
			acc = {
				x = random() - 0.5,
				y = random() - 0.5,
				z = random() - 0.5
			},
			expirationtime = random(2.5),
			size = random(3),
			collisiondetection = true,
			texture = "bees_particle_bee.png",
		})

		-- floating hive check and removal
		if node.name == "bees:hive_wild" then

			local num = #minetest.find_nodes_in_area(
				{x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				{x = pos.x + 1, y = pos.y + 1, z = pos.z + 1},
				{"air"})

			if num and num > 25 then
				minetest.remove_node(pos)
			end
		end
	end,
})


-- spawn abm. This should be changed to a more realistic type of spawning
minetest.register_abm({
	nodenames = {"group:leaves"},
	neighbors = {"air"},
	interval = 800,--1600,
	chance = 10,--20,

	action = function(pos, node)

		if floor(pos.x / 40) ~= pos.x / 40
		or floor(pos.z / 40) ~= pos.z / 40
		or floor(pos.y /  5) ~= pos.y / 5 then return end

		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local nod = minetest.get_node_or_nil(p)
		local def = nod and minetest.registered_nodes[nod.name]

		if not def or def.walkable then return end

		if minetest.find_node_near(p, 5, "group:flora") then
			minetest.add_node(p, {name = "bees:hive_wild"})
		end
	end,
})


-- spawning bees around bee hive
minetest.register_abm({
	nodenames = {"bees:hive_wild", "bees:hive_artificial", "bees:hive_industrial"},
	neighbors = {"group:flowers", "group:leaves"},
	interval = 30,
	chance = 4,

	action = function(pos, node, _, _)

		local p = {
			x = pos.x + random(-5, 5),
			y = pos.y - random(0, 3),
			z = pos.z + random(-5, 5)
		}

		if minetest.get_node(p).name == "air" then
			minetest.add_node(p, {name="bees:bees"})
		end
	end,
})


-- remove bees
minetest.register_abm({
	nodenames = {"bees:bees"},
	interval = 30,
	chance = 5,

	action = function(pos, node, _, _)
		minetest.remove_node(pos)
	end,
})


-- ITEMS

minetest.register_craftitem("bees:frame_empty", {
	description = S("Empty hive frame"),
	inventory_image = "bees_frame_empty.png",
	stack_max = 24,
})

minetest.register_craftitem("bees:frame_full", {
	description = S("Filled hive frame"),
	inventory_image = "bees_frame_full.png",
	stack_max = 12,
})

minetest.register_craftitem("bees:bottle_honey", {
	description = S("Honey bottle"),
	inventory_image = "bees_bottle_honey.png",
	stack_max = 12,
	on_use = minetest.item_eat(3, "vessels:glass_bottle"),
	groups = {vessel = 1},
})

minetest.register_craftitem("bees:wax", {
	description = S("Bees wax"),
	inventory_image = "bees_wax.png",
	stack_max = 48,
})

minetest.register_craftitem("bees:honey_comb", {
	description = S("honey comb"),
	inventory_image = "bees_comb.png",
	on_use = minetest.item_eat(2),
	stack_max = 8,
})

minetest.register_craftitem("bees:queen", {
	description = S("Queen Bee"),
	inventory_image = "bees_particle_bee.png",
	stack_max = 1,
})


-- CRAFTS

minetest.register_craft({
	output = "bees:extractor",
	recipe = {
		{"", "default:steel_ingot", ""},
		{"default:steel_ingot", "default:stick", "default:steel_ingot"},
		{"default:mese_crystal", "default:steel_ingot", "default:mese_crystal"},
	}
})

minetest.register_craft({
	output = "bees:smoker",
	recipe = {
		{"default:steel_ingot", "wool:red", ""},
		{"", "default:torch", ""},
		{"", "default:steel_ingot",""},
	}
})

minetest.register_craft({
	output = "bees:hive_artificial",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"group:wood", "default:stick", "group:wood"},
		{"group:wood", "default:stick", "group:wood"},
	}
})

minetest.register_craft({
	output = "bees:grafting_tool",
	recipe = {
		{"", "", "default:steel_ingot"},
		{"", "default:stick", ""},
		{"", "", ""},
	}
})

minetest.register_craft({
	output = "bees:frame_empty",
	recipe = {
		{"group:wood", "group:wood", "group:wood"},
		{"default:stick", "default:stick", "default:stick"},
		{"default:stick", "default:stick", "default:stick"},
	}
})

if minetest.get_modpath("bushes_classic") then

	minetest.register_craft({
		type = "cooking",
		cooktime = 5,
		recipe = "bees:bottle_honey",
		output = "bushes:sugar",
	})
end


-- TOOLS

minetest.register_tool("bees:smoker", {
	description = S("smoker"),
	inventory_image = "bees_smoker.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		damage_groups = {fleshy = 2},
	},

	on_use = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under

		for i = 1, 6 do

			minetest.add_particle({
				pos = {
					x = pos.x + random() - 0.5,
					y = pos.y,
					z = pos.z + random() - 0.5
				},
				vel = {x = 0, y = 0.5 + random(), z = 0},
				acc = {x = 0, y = 0, z = 0},
				expirationtime = 2 + random(2.5),
				size = random(3),
				collisiondetection = false,
				texture = "bees_smoke_particle.png",
			})
		end

		itemstack:add_wear(65535 / 200)

		local meta = minetest.get_meta(pos)

		meta:set_int("agressive", 0)

		return itemstack
	end,
})

minetest.register_tool("bees:grafting_tool", {
	description = S("Grafting tool"),
	inventory_image = "bees_grafting_tool.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level=0,
		damage_groups = {fleshy = 2},
	},
})


-- COMPATIBILTY --remove after all has been updated

-- ALIASES
minetest.register_alias("bees:honey_extractor", "bees:extractor")

-- BACKWARDS COMPATIBILITY WITH OLDER VERSION
minetest.register_alias("bees:honey_bottle", "bees:bottle_honey")

minetest.register_lbm({
	nodenames = {"bees:hive", "bees:hive_artificial_inhabited"},
	name = "bees:replace_old_hives",
	label = "Replace old hives",
	run_at_every_load = true,

	action = function(pos, node)

		if node.name == "bees:hive" then

			minetest.set_node(pos, {name = "bees:hive_wild"})

			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()

			inv:set_stack("queen", 1, "bees:queen")
		end

		if node.name == "bees:hive_artificial_inhabited" then

			minetest.set_node(pos, {name = "bees:hive_artificial"})

			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()

			inv:set_stack("queen", 1, "bees:queen")

			local timer = minetest.get_node_timer(pos)

			timer:start(60)
		end
	end
})


-- PIPEWORKS

if minetest.get_modpath("pipeworks") then

	minetest.register_node("bees:hive_industrial", {
		description = S("Industrial Bee Hive"),
		tiles = {"bees_hive_industrial.png"},
		paramtype2 = "facedir",
		groups = {
			snappy = 1, choppy = 2, oddly_breakable_by_hand = 2,
			tubedevice = 1, tubedevice_receiver = 1
		},
		sounds = default.node_sound_wood_defaults(),

		tube = {
			insert_object = function(pos, node, stack, direction)

				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()

				if stack:get_name() ~= "bees:frame_empty"
				or stack:get_count() > 1 then
					return stack
				end

				for i = 1, 8 do

					if inv:get_stack("frames", i):is_empty() then

						inv:set_stack("frames", i, stack)

						local timer = minetest.get_node_timer(pos)

						timer:start(30)

						meta:set_string("infotext", S("Bees are aclimating"))

						return ItemStack("")
					end
				end

				return stack
			end,

			can_insert = function(pos,node,stack,direction)

				local meta = minetest.get_meta(pos)
				local inv = meta:get_inventory()

				if stack:get_name() ~= "bees:frame_empty"
				or stack:get_count() > 1 then
					return false
				end

				for i = 1, 8 do

					if inv:get_stack("frames", i):is_empty() then
						return true
					end
				end

				return false
			end,

			can_remove = function(pos,node,stack,direction)

				if stack:get_name() == "bees:frame_full" then
					return 1
				else
					return 0
				end
			end,

			input_inventory = "frames",

			connect_sides = {left = 1, right = 1, back = 1, front = 1, bottom = 1, top = 1}
		},

		on_construct = function(pos)

			local timer = minetest.get_node_timer(pos)
			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()

			meta:set_int("agressive", 1)

			inv:set_size("queen", 1)
			inv:set_size("frames", 8)

			meta:set_string("infotext", S("Requires Queen bee to function"))
		end,

		on_rightclick = function(pos, node, clicker, itemstack)

			if minetest.is_protected(pos, clicker:get_player_name()) then
				return
			end

			minetest.show_formspec(clicker:get_player_name(),
				"bees:hive_artificial",
				hive_artificial(pos)
			)

			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()

			if meta:get_int("agressive") == 1
			and inv:contains_item("queen", "bees:queen") then

				clicker:set_hp(clicker:get_hp() - 4)
			else
				meta:set_int("agressive", 1)
			end
		end,

		on_timer = function(pos,elapsed)

			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local timer = minetest.get_node_timer(pos)

			if inv:contains_item("queen", "bees:queen") then

				if inv:contains_item("frames", "bees:frame_empty") then

					timer:start(30)

					local rad = 10
					local minp = {x = pos.x - rad, y = pos.y - rad, z = pos.z - rad}
					local maxp = {x = pos.x + rad, y = pos.y + rad, z = pos.z + rad}
					local flowers = minetest.find_nodes_in_area(minp, maxp, "group:flower")
					local progress = meta:get_int("progress")

					progress = progress + #flowers

					meta:set_int("progress", progress)

					if progress > 1000 then

						local flower = flowers[random(#flowers)]

						polinate_flower(flower, minetest.get_node(flower).name)

						local stacks = inv:get_list("frames")

						for k, v in pairs(stacks) do

							if inv:get_stack("frames", k):get_name() == "bees:frame_empty" then

								meta:set_int("progress", 0)

								inv:set_stack("frames", k, "bees:frame_full")

								return
							end
						end
					else
						meta:set_string("infotext", S("progress:")
							.. " " .. progress .. " + " .. #flowers .. " / 1000")
					end
				else
					meta:set_string("infotext", S("Does not have empty frame(s)"))

					timer:stop()
				end
			end
		end,

		on_metadata_inventory_take = function(pos, listname, index, stack, player)

			if listname == "queen" then

				local timer = minetest.get_node_timer(pos)
				local meta = minetest.get_meta(pos)

				meta:set_string("infotext", S("Requires Queen bee to function"))

				timer:stop()
			end
		end,

		allow_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)

			local inv = minetest.get_meta(pos):get_inventory()

			if from_list == to_list then

				if inv:get_stack(to_list, to_index):is_empty() then
					return 1
				else
					return 0
				end
			else
				return 0
			end
		end,

		on_metadata_inventory_put = function(pos, listname, index, stack, player)

			local meta = minetest.get_meta(pos)
			local inv = meta:get_inventory()
			local timer = minetest.get_node_timer(pos)

			if listname == "queen" or listname == "frames" then

				meta:set_string("queen", stack:get_name())
				meta:set_string("infotext", S("Queen inserted, now for the empty frames"))

				if inv:contains_item("frames", "bees:frame_empty") then

					timer:start(30)

					meta:set_string("infotext", S("Bees are aclimating"))
				end
			end
		end,

		allow_metadata_inventory_put = function(pos, listname, index, stack, player)

			if not minetest.get_meta(pos):get_inventory():get_stack(listname, index):is_empty() then
				return 0
			end

			if listname == "queen" then

				if stack:get_name():match("bees:queen*") then
					return 1
				end

			elseif listname == "frames" then

				if stack:get_name() == ("bees:frame_empty") then
					return 1
				end
			end

			return 0
		end,
	})

	minetest.register_craft({
		output = "bees:hive_industrial",
		recipe = {
			{"default:steel_ingot","homedecor:plastic_sheeting","default:steel_ingot"},
			{"pipeworks:tube_1","bees:hive_artificial","pipeworks:tube_1"},
			{"default:steel_ingot","homedecor:plastic_sheeting","default:steel_ingot"},
		}
	})
end


-- LUCKY BLOCKS

if minetest.get_modpath("lucky_block") then

	local add_bees = function(pos, player)

		local objs = minetest.get_objects_inside_radius(pos, 15)
		local violet = minetest.get_color_escape_sequence("#ff00ff")

		minetest.chat_send_player(player:get_player_name(),
			violet .. S("Bees! Bees for all!"))

		for n = 1, #objs do

			if objs[n]:is_player() then

				local player_pos = objs[n]:get_pos()

				player_pos.y = player_pos.y + 1

				minetest.swap_node(player_pos, {name = "bees:bees"})
			end
		end
	end

	lucky_block:add_blocks({
		{"cus", add_bees},
		{"dro", {"bees:grafting_tool"}, 1},
		{"dro", {"bees:frame_empty"}, 2},
		{"dro", {"bees:queen"}, 1},
		{"nod", "bees:extractor"},
		{"dro", {"bees:frame_full"}, 2},
		{"dro", {"bees:bottle_honey"}, 3},
		{"dro", {"bees:smoker"}, 1},
		{"nod", "bees:hive_artificial"},
	})
end


print(S("[MOD] Bees Loaded!"))
