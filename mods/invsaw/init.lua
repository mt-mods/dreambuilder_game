invsaw = {}

invsaw.users = {}

local fancy_inv = default.gui_bg..default.gui_bg_img..default.gui_slots
invsaw.formspec =       "size[11,10]"..fancy_inv..
			"label[0,0;Input\nmaterial]" ..
			"list[detached:invsaw_%s;input;1.5,0;1,1;]" ..
			"label[0,1;Left-over]" ..
			"list[detached:invsaw_%s;micro;1.5,1;1,1;]" ..
			"label[0,2;Recycle\noutput]" ..
			"list[detached:invsaw_%s;recycle;1.5,2;1,1;]" ..
			"field[0.3,3.5;1,1;max_offered;Max:;%s]" ..
			"button[1,3.2;1,1;Set;Set]" ..
			"list[detached:invsaw_%s;output;2.8,0;8,6;]" ..
			"list[current_player;main;1.5,6.25;8,4;]"

invsaw.nosawformspec =  "size[5,2]"..
			"label[0,0;You don't have a circular saw in your inventory!\nYou need to have one in order to use this function.]"..
			"button_exit[1.5,1;2,1;quit;OK]"

function invsaw.reset(inv,name)
	inv:set_list("input",  {})
	inv:set_list("micro",  {})
	inv:set_list("output", {})
	invsaw.users[name].micros = 0
end

function invsaw.update_inventory(inv, name, amount)

	amount = invsaw.users[name].micros + amount

	-- The material is recycled automaticly.
	inv:set_list("recycle",  {})

	if amount < 1 then -- If the last block is taken out.
		invsaw.reset(inv,name)
		return
	end
 
	local stack = inv:get_stack("input",  1)
	-- At least one "normal" block is necessary to see what kind of stairs are requested.
	if stack:is_empty() then
		-- Any microblocks not taken out yet are now lost.
		-- (covers material loss in the machine)
		invsaw.reset(inv,name)
		return

	end
	local node_name = stack:get_name() or ""
	local name_parts = circular_saw.known_nodes[node_name] or ""
	local modname  = name_parts[1] or ""
	local material = name_parts[2] or ""

	inv:set_list("input", { -- Display as many full blocks as possible:
		node_name.. " " .. math.floor(amount / 8)
	})

	-- The stairnodes made of default nodes use moreblocks namespace, other mods keep own:
	if modname == "default" then
		modname = "moreblocks"
	end
	-- print("circular_saw set to " .. modname .. " : "
	--	.. material .. " with " .. (amount) .. " microblocks.")

	-- 0-7 microblocks may remain left-over:
	inv:set_list("micro", {
		modname .. ":micro_" .. material .. "_bottom " .. (amount % 8)
	})
	-- Display:
	inv:set_list("output",
		circular_saw:get_output_inv(modname, material, amount,
				invsaw.users[name].max_offered))
	-- Store how many microblocks are available:
	invsaw.users[name].micros = amount

end

invsaw.allow_put = function(inv, listname, index, stack, player)
	-- The player is not allowed to put something in there:
	if listname == "output" or listname == "micro" then
		return 0
	end

	local stackname = stack:get_name()
	local count = stack:get_count()

	-- Only alow those items that are offered in the output inventory to be recycled:
	if listname == "recycle" then
		if not inv:contains_item("output", stackname) then
			return 0
		end
		local stackmax = stack:get_stack_max()
		local instack = inv:get_stack("input", 1)
		local microstack = inv:get_stack("micro", 1)
		local incount = instack:get_count()
		local incost = (incount * 8) + microstack:get_count()
		local maxcost = (stackmax * 8) + 7
		local cost = circular_saw:get_cost(inv, stackname)
		if (incost + cost) > maxcost then
			return math.max((maxcost - incost) / cost, 0)
		end
		return count
	end

	-- Only accept certain blocks as input which are known to be craftable into stairs:
	if listname == "input" then
		if not inv:is_empty("input") then
			if inv:get_stack("input", index):get_name() ~= stackname then
				return 0
			end
		end
		if not inv:is_empty("micro") then
			local microstackname = inv:get_stack("micro", 1):get_name():gsub("^.+:micro_", "", 1)
			local cutstackname = stackname:gsub("^.+:", "", 1)
			if microstackname ~= cutstackname then
				return 0
			end
		end
		for name, t in pairs(circular_saw.known_nodes) do
			if name == stackname and inv:room_for_item("input", stack) then
				return count
			end
		end
		return 0
	end
end

invsaw.on_take = function(inv, listname, index, stack, player)
	-- Prevent (inbuilt) swapping between inventories with different blocks
	-- corrupting player inventory or Saw with 'unknown' items.
	local input_stack = inv:get_stack(listname,  index)
	if not input_stack:is_empty() and input_stack:get_name()~=stack:get_name() then
		local player_inv = player:get_inventory()
		if player_inv:room_for_item("main", input_stack) then
			player_inv:add_item("main", input_stack)
		end

		invsaw.reset(inv,player:get_player_name())
		return
	end

	-- If it is one of the offered stairs: find out how many
	-- microblocks have to be substracted:
	if listname == "output" then
		-- We do know how much each block at each position costs:
		local cost = circular_saw.cost_in_microblocks[index]
				* stack:get_count()

		invsaw.update_inventory(inv, player:get_player_name(), -cost)
	elseif listname == "micro" then
		-- Each microblock costs 1 microblock:
		invsaw.update_inventory(inv, player:get_player_name(), -stack:get_count())
	elseif listname == "input" then
		-- Each normal (= full) block taken costs 8 microblocks:
		invsaw.update_inventory(inv, player:get_player_name(), 8 * -stack:get_count())
	end
	-- The recycle field plays no role here since it is processed immediately.
end

invsaw.on_put = function(inv, listname, index, stack, player)
	-- We need to find out if the circular_saw is already set to a
	-- specific material or not:
	local stackname = stack:get_name()
	local count = stack:get_count()

	-- Putting something into the input slot is only possible if that had
	-- been empty before or did contain something of the same material:
	if listname == "input" then
		-- Each new block is worth 8 microblocks:
		invsaw.update_inventory(inv, player:get_player_name(), 8 * count)
	elseif listname == "recycle" then
		-- Lets look which shape this represents:
		local cost = circular_saw:get_cost(inv, stackname)
		local input_stack = inv:get_stack("input", 1)
		-- check if this would not exceed input itemstack max_stacks
		if input_stack:get_count() + ((cost * count) / 8) <= input_stack:get_stack_max() then
			invsaw.update_inventory(inv, player:get_player_name(), cost * count)
		end
	end
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name(player)
	invsaw.users[name] = {}
	invsaw.users[name].micros = 0
	invsaw.users[name].max_offered = 99
	local inv = minetest.create_detached_inventory("invsaw_"..name,{
		allow_put = invsaw.allow_put,
		on_put = invsaw.on_put,
		on_take = invsaw.on_take,
		allow_move = function() return 0 end
	}, name)
	inv:set_size("input",1)
	inv:set_size("micro",1)
	inv:set_size("recycle",1)
	inv:set_size("output",48) --6*8
	invsaw.users[name].inv = inv
end)

minetest.register_on_player_receive_fields(function(player,formname,fields)
	local name = player:get_player_name()
	if fields.saw then
		local creative = minetest.setting_getbool("creative_mode") or minetest.check_player_privs(name,{creative=true})
		local havesaw = player:get_inventory():contains_item("main","moreblocks:circular_saw")
		if havesaw or creative then
			minetest.show_formspec(name,"invsaw:saw",string.format(invsaw.formspec,name,name,name,invsaw.users[name].max_offered,name))
		else
			minetest.show_formspec(name,"invsaw:nosaw",invsaw.nosawformspec)
		end
		return true
	elseif formname == "invsaw:saw" and fields.Set then
		invsaw.users[name].max_offered = tonumber(fields.max_offered) or 99
		invsaw.update_inventory(invsaw.users[name].inv,name,0)
		minetest.show_formspec(name,"invsaw:saw",string.format(invsaw.formspec,name,name,name,invsaw.users[name].max_offered,name))
		return true
	else
		return false
	end
end)

unified_inventory.register_button("saw", {
		type = "image",
		image = "invsaw_button.png",
		tooltip = "Circular Saw"
	})
