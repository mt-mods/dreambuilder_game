-- Biome library mod by VanessaE
--
-- I got the temperature map idea from "hmmmm", values used for it came from
-- Splizard's snow mod.
--

biome_lib = {}

-- Boilerplate to support localized strings if intllib mod is installed.
local S
if minetest.global_exists("intllib") then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end
biome_lib.intllib = S

-- Various settings - most of these probably won't need to be changed

biome_lib.air = {name = "air"}

biome_lib.block_log = {}
biome_lib.block_recheck_list = {}
biome_lib.run_block_recheck_list = false

biome_lib.actionslist_aircheck = {}
biome_lib.actionslist_no_aircheck = {}

biome_lib.surfaceslist_aircheck = {}
biome_lib.surfaceslist_no_aircheck = {}

-- the mapgen rarely creates useful surfaces outside this range, but mods can
-- still specify a wider range if needed.
biome_lib.mapgen_elevation_limit = { ["min"] = -16, ["max"] = 48 } 

biome_lib.modpath = minetest.get_modpath("biome_lib")

local function tableize(s)
	return string.split(string.trim(string.gsub(s, " ", "")))
end

local c1 = minetest.settings:get("biome_lib_default_grow_through_nodes")
biome_lib.default_grow_through_nodes = {["air"] = true}
if c1 then
	for _, i in ipairs(tableize(c1)) do
		biome_lib.default_grow_through_nodes[i] = true
	end
else
	biome_lib.default_grow_through_nodes["default:snow"] = true
end

local c2 = minetest.settings:get("biome_lib_default_water_nodes")
biome_lib.default_water_nodes = {}
if c2 then
	for _, i in ipairs(tableize(c2)) do
		biome_lib.default_water_nodes[i] = true
	end
else
	biome_lib.default_water_nodes["default:water_source"] = true
	biome_lib.default_water_nodes["default:water_flowing"] = true
	biome_lib.default_water_nodes["default:river_water_source"] = true
	biome_lib.default_water_nodes["default:river_water_flowing"] = true
end

local c3 = minetest.settings:get("biome_lib_default_wet_surfaces")
local c4 = minetest.settings:get("biome_lib_default_ground_nodes")
local c5 = minetest.settings:get("biome_lib_default_grow_nodes")

biome_lib.default_wet_surfaces = c3 and tableize(c3) or {"default:dirt", "default:dirt_with_grass", "default:sand"}
biome_lib.default_ground_nodes = c4 and tableize(c4) or {"default:dirt_with_grass"}
biome_lib.default_grow_nodes =   c5 and tableize(c5) or {"default:dirt_with_grass"}

biome_lib.debug_log_level = tonumber(minetest.settings:get("biome_lib_debug_log_level")) or 0

local rr = tonumber(minetest.settings:get("biome_lib_queue_ratio")) or -200
biome_lib.queue_ratio = 100 - rr
biome_lib.entries_per_step = math.max(-rr, 1)

-- the timer that manages the block timeout is in microseconds, but the timer
-- that manages the queue wakeup call has to be in seconds, and works best if
-- it takes a fraction of the block timeout interval.

local t = tonumber(minetest.settings:get("biome_lib_block_timeout")) or 300

biome_lib.block_timeout = t * 1000000

-- we don't want the wakeup function to trigger TOO often,
-- in case the user's block timeout setting is really low
biome_lib.block_queue_wakeup_time = math.min(t/2, math.max(20, t/10))

local time_speed = tonumber(minetest.settings:get("time_speed"))

biome_lib.plantlife_seed_diff = 329 -- needs to be global so other mods can see it

local perlin_octaves = 3
local perlin_persistence = 0.6
local perlin_scale = 100

local temperature_seeddiff = 112
local temperature_octaves = 3
local temperature_persistence = 0.5
local temperature_scale = 150

local humidity_seeddiff = 9130
local humidity_octaves = 3
local humidity_persistence = 0.5
local humidity_scale = 250

local time_scale = 1

if time_speed and time_speed > 0 then
	time_scale = 72 / time_speed
end

--PerlinNoise(seed, octaves, persistence, scale)

biome_lib.perlin_temperature = PerlinNoise(temperature_seeddiff, temperature_octaves, temperature_persistence, temperature_scale)
biome_lib.perlin_humidity = PerlinNoise(humidity_seeddiff, humidity_octaves, humidity_persistence, humidity_scale)

-- Local functions

function biome_lib.dbg(msg, level)
	local l = tonumber(level) or 0
	if biome_lib.debug_log_level >= l then
		print("[Biome Lib] "..msg)
		minetest.log("verbose", "[Biome Lib] "..msg)
	end
end

local function get_biome_data(pos, perlin_fertile)
	local fertility = perlin_fertile:get_2d({x=pos.x, y=pos.z})

	if type(minetest.get_biome_data) == "function" then
		local data = minetest.get_biome_data(pos)
		if data then
			return fertility, data.heat / 100, data.humidity / 100
		end
	end

	local temperature = biome_lib.perlin_temperature:get2d({x=pos.x, y=pos.z})
	local humidity = biome_lib.perlin_humidity:get2d({x=pos.x+150, y=pos.z+50})

	return fertility, temperature, humidity
end

function biome_lib:is_node_loaded(node_pos)
	local n = minetest.get_node_or_nil(node_pos)
	if (not n) or (n.name == "ignore") then
		return false
	end
	return true
end

function biome_lib:set_defaults(biome)
	biome.seed_diff = biome.seed_diff or 0
	biome.min_elevation = biome.min_elevation or biome_lib.mapgen_elevation_limit.min
	biome.max_elevation = biome.max_elevation or biome_lib.mapgen_elevation_limit.max
	biome.temp_min = biome.temp_min or 1
	biome.temp_max = biome.temp_max or -1
	biome.humidity_min = biome.humidity_min or 1
	biome.humidity_max = biome.humidity_max or -1
	biome.plantlife_limit = biome.plantlife_limit or 0.1
	biome.near_nodes_vertical = biome.near_nodes_vertical or 1

-- specific to on-generate

	biome.neighbors = biome.neighbors or biome.surface
	biome.near_nodes_size = biome.near_nodes_size or 0
	biome.near_nodes_count = biome.near_nodes_count or 1
	biome.rarity = biome.rarity or 50
	biome.max_count = biome.max_count or 125
	if biome.check_air ~= false then biome.check_air = true end

-- specific to abm spawner
	biome.seed_diff = biome.seed_diff or 0
	biome.light_min = biome.light_min or 0
	biome.light_max = biome.light_max or 15
	biome.depth_max = biome.depth_max or 1
	biome.facedir = biome.facedir or 0
end

local function search_table(t, s)
	for i = 1, #t do
		if t[i] == s then return true end
	end
	return false
end

-- register the list of surfaces to spawn stuff on, filtering out all duplicates.
-- separate the items by air-checking or non-air-checking map eval methods

function biome_lib:register_generate_plant(biomedef, nodes_or_function_or_model)

	-- if calling code passes an undefined node for a surface or 
	-- as a node to be spawned, don't register an action for it.

	if type(nodes_or_function_or_model) == "string"
	  and string.find(nodes_or_function_or_model, ":")
	  and not minetest.registered_nodes[nodes_or_function_or_model] then
		biome_lib.dbg("Warning: Ignored registration for undefined spawn node: "..dump(nodes_or_function_or_model), 2)
		return
	end

	if type(nodes_or_function_or_model) == "string"
	  and not string.find(nodes_or_function_or_model, ":") then
		biome_lib.dbg("Warning: Registered function call using deprecated string method: "..dump(nodes_or_function_or_model), 2)
	end

	biome_lib.mapgen_elevation_limit.min = math.min(biomedef.min_elevation or 0, biome_lib.mapgen_elevation_limit.min)
	biome_lib.mapgen_elevation_limit.max = math.max(biomedef.max_elevation or 0, biome_lib.mapgen_elevation_limit.max)

	if biomedef.check_air == false then 
		biome_lib.dbg("Register no-air-check mapgen hook: "..dump(nodes_or_function_or_model), 3)
		biome_lib.actionslist_no_aircheck[#biome_lib.actionslist_no_aircheck + 1] = { biomedef, nodes_or_function_or_model }
		local s = biomedef.surface
		if type(s) == "string" then
			if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
				if not search_table(biome_lib.surfaceslist_no_aircheck, s) then
					biome_lib.surfaceslist_no_aircheck[#biome_lib.surfaceslist_no_aircheck + 1] = s
				end
			else
				biome_lib.dbg("Warning: Ignored no-air-check registration for undefined surface node: "..dump(s), 2)
			end
		else
			for i = 1, #biomedef.surface do
				local s = biomedef.surface[i]
				if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
					if not search_table(biome_lib.surfaceslist_no_aircheck, s) then
						biome_lib.surfaceslist_no_aircheck[#biome_lib.surfaceslist_no_aircheck + 1] = s
					end
				else
					biome_lib.dbg("Warning: Ignored no-air-check registration for undefined surface node: "..dump(s), 2)
				end
			end
		end
	else
		biome_lib.dbg("Register with-air-checking mapgen hook: "..dump(nodes_or_function_or_model), 3)
		biome_lib.actionslist_aircheck[#biome_lib.actionslist_aircheck + 1] = { biomedef, nodes_or_function_or_model }
		local s = biomedef.surface
		if type(s) == "string" then
			if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
				if not search_table(biome_lib.surfaceslist_aircheck, s) then
					biome_lib.surfaceslist_aircheck[#biome_lib.surfaceslist_aircheck + 1] = s
				end
			else
				biome_lib.dbg("Warning: Ignored with-air-checking registration for undefined surface node: "..dump(s), 2)
			end
		else
			for i = 1, #biomedef.surface do
				local s = biomedef.surface[i]
				if s and (string.find(s, "^group:") or minetest.registered_nodes[s]) then
					if not search_table(biome_lib.surfaceslist_aircheck, s) then
						biome_lib.surfaceslist_aircheck[#biome_lib.surfaceslist_aircheck + 1] = s
					end
				else
					biome_lib.dbg("Warning: Ignored with-air-checking registration for undefined surface node: "..dump(s), 2)
				end
			end
		end
	end
end

-- Function to check whether a position matches the given biome definition
-- Returns true when the surface can be populated

local function populate_single_surface(biome, pos, perlin_fertile_area, checkair)
	local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }

	if math.random(1, 100) <= biome.rarity then
		return
	end

	local fertility, temperature, humidity = get_biome_data(pos, perlin_fertile_area)

	local pos_biome_ok = pos.y >= biome.min_elevation and pos.y <= biome.max_elevation
		and fertility > biome.plantlife_limit
		and temperature <= biome.temp_min and temperature >= biome.temp_max
		and humidity <= biome.humidity_min and humidity >= biome.humidity_max
	
	if not pos_biome_ok then
		return -- Y position mismatch, outside of biome
	end

	local biome_surfaces_string = dump(biome.surface)
	local surface_ok = false

	if not biome.depth then
		local dest_node = minetest.get_node(pos)
		if string.find(biome_surfaces_string, dest_node.name) then
			surface_ok = true
		else
			if string.find(biome_surfaces_string, "group:") then
				for j = 1, #biome.surface do
					if string.find(biome.surface[j], "^group:") 
					  and minetest.get_item_group(dest_node.name, biome.surface[j]) then
						surface_ok = true
						break
					end
				end
			end
		end
	elseif not string.find(biome_surfaces_string,
			minetest.get_node({ x = pos.x, y = pos.y-biome.depth-1, z = pos.z }).name) then
		surface_ok = true
	end
	
	if not surface_ok then
		return -- Surface does not match the given node group/name
	end

	if checkair and minetest.get_node(p_top).name ~= "air" then
		return
	end

	if biome.below_nodes and
			not string.find(dump(biome.below_nodes),
				minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
			) then
		return -- Node below does not match
	end

	if biome.ncount and
			#minetest.find_nodes_in_area(
				{x=pos.x-1, y=pos.y, z=pos.z-1},
				{x=pos.x+1, y=pos.y, z=pos.z+1},
				biome.neighbors
			) <= biome.ncount then
		return -- Not enough similar biome nodes around
	end

	if biome.near_nodes and
			#minetest.find_nodes_in_area(
				{x=pos.x-biome.near_nodes_size, y=pos.y-biome.near_nodes_vertical, z=pos.z-biome.near_nodes_size},
				{x=pos.x+biome.near_nodes_size, y=pos.y+biome.near_nodes_vertical, z=pos.z+biome.near_nodes_size}, 
				biome.near_nodes
			) < biome.near_nodes_count then
		return -- Long distance neighbours do not match
	end

	-- Position fits into given biome
	return true
end

function biome_lib.populate_surfaces(biome, nodes_or_function_or_model, snodes, checkair)
	local items_added = 0

	biome_lib:set_defaults(biome)

	-- filter stage 1 - find nodes from the supplied surfaces that are within the current biome.

	local in_biome_nodes = {}
	local perlin_fertile_area = minetest.get_perlin(biome.seed_diff, perlin_octaves, perlin_persistence, perlin_scale)

	for i = 1, #snodes do
		local pos = vector.new(snodes[i])
		if populate_single_surface(biome, pos, perlin_fertile_area, checkair) then
			in_biome_nodes[#in_biome_nodes + 1] = pos
		end
	end

	-- filter stage 2 - find places within that biome area to place the plants.

	local num_in_biome_nodes = #in_biome_nodes

	if num_in_biome_nodes == 0 then
		return 0
	end

	for i = 1, math.min(math.ceil(biome.max_count/25), num_in_biome_nodes) do
		local tries = 0
		local spawned = false
		while tries < 2 and not spawned do
			local pos = in_biome_nodes[math.random(1, num_in_biome_nodes)]
			if biome.spawn_replace_node then
				pos.y = pos.y-1
			end
			local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }

			if not (biome.avoid_nodes and biome.avoid_radius
					and minetest.find_node_near(p_top, biome.avoid_radius
					+ math.random(-1.5,2), biome.avoid_nodes)) then
				if biome.delete_above then
					minetest.swap_node(p_top, biome_lib.air)
					minetest.swap_node({x=p_top.x, y=p_top.y+1, z=p_top.z}, biome_lib.air)
				end

				if biome.delete_above_surround then
					minetest.swap_node({x=p_top.x-1, y=p_top.y, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x+1, y=p_top.y, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y, z=p_top.z-1}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y, z=p_top.z+1}, biome_lib.air)

					minetest.swap_node({x=p_top.x-1, y=p_top.y+1, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x+1, y=p_top.y+1, z=p_top.z}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y+1, z=p_top.z-1}, biome_lib.air)
					minetest.swap_node({x=p_top.x,   y=p_top.y+1, z=p_top.z+1}, biome_lib.air)
				end

				if biome.spawn_replace_node then
					minetest.swap_node(pos, biome_lib.air)
				end

				local objtype = type(nodes_or_function_or_model)

				if objtype == "table" then
					if nodes_or_function_or_model.axiom then
						biome_lib:generate_tree(p_top, nodes_or_function_or_model)
						biome_lib.dbg("An L-tree was spawned at "..minetest.pos_to_string(p_top), 4)
						spawned = true
					else
						local fdir = nil
						if biome.random_facedir then
							fdir = math.random(biome.random_facedir[1], biome.random_facedir[2])
						end
						local n=nodes_or_function_or_model[math.random(#nodes_or_function_or_model)]
						minetest.swap_node(p_top, { name = n, param2 = fdir })
						biome_lib.dbg("Node \""..n.."\" was randomly picked from a list and placed at "..minetest.pos_to_string(p_top), 4)
						spawned = true
					end
				elseif objtype == "string" and
				  minetest.registered_nodes[nodes_or_function_or_model] then
					local fdir = nil
					if biome.random_facedir then
						fdir = math.random(biome.random_facedir[1], biome.random_facedir[2])
					end
					minetest.swap_node(p_top, { name = nodes_or_function_or_model, param2 = fdir })
					biome_lib.dbg("Node \""..nodes_or_function_or_model.."\" was placed at "..minetest.pos_to_string(p_top), 4)
					spawned = true
				elseif objtype == "function" then
					nodes_or_function_or_model(pos)
					biome_lib.dbg("A function was run on surface node at "..minetest.pos_to_string(pos), 4)
					spawned = true
				elseif objtype == "string" and pcall(loadstring(("return %s(...)"):
					format(nodes_or_function_or_model)),pos) then
					spawned = true
					biome_lib.dbg("An obsolete string-specified function was run on surface node at "..minetest.pos_to_string(p_top), 4)
				else
					biome_lib.dbg("Warning: Ignored invalid definition for object "..dump(nodes_or_function_or_model).." that was pointed at {"..dump(pos).."}", 2)
				end
			else
				tries = tries + 1
			end
		end
		if spawned then items_added = items_added + 1 end
	end
	return items_added
end

-- Primary log read-out/mapgen spawner

local function confirm_block_surroundings(p)
	local n=minetest.get_node_or_nil(p)
	if not n or n.name == "ignore" then return false end

	for x = -32,32,64 do -- step of 64 causes it to only check the 8 corner blocks
		for y = -32,32,64 do
			for z = -32,32,64 do
				local n=minetest.get_node_or_nil({x=p.x + x, y=p.y + y, z=p.z + z})
				if not n or n.name == "ignore" then return false end
			end
		end
	end
	return true
end

function biome_lib.generate_block(shutting_down)

	if shutting_down then
		if #biome_lib.block_recheck_list > 0 then
			for i = 1, #biome_lib.block_recheck_list do
				biome_lib.block_log[#biome_lib.block_log + 1] = biome_lib.block_recheck_list[i]
			end
			biome_lib.block_recheck_list = {}
		end
		biome_lib.run_block_recheck_list = false
	else
		if biome_lib.run_block_recheck_list
		  and not biome_lib.block_recheck_list[1] then
				biome_lib.run_block_recheck_list = false
		end
	end

	local blocklog = biome_lib.run_block_recheck_list
	  and biome_lib.block_recheck_list
	  or biome_lib.block_log

	if not blocklog[1] then return end

	local minp =		blocklog[1][1]
	local maxp =		blocklog[1][2]
	local airflag = 	blocklog[1][3]
	local pos_hash = 	minetest.hash_node_position(minp)

	if not biome_lib.pos_hash then -- we need to read the maplock and get the surfaces list
		local now = minetest.get_us_time()
		biome_lib.pos_hash = {}
		minetest.load_area(minp)
		if not confirm_block_surroundings(minp)
		  and not shutting_down
		  and (blocklog[1][4] + biome_lib.block_timeout) > now then -- if any neighbors appear not to be loaded and the block hasn't expired yet, defer it

			if biome_lib.run_block_recheck_list then
				biome_lib.block_log[#biome_lib.block_log + 1] = table.copy(biome_lib.block_recheck_list[1])
				table.remove(biome_lib.block_recheck_list, 1)
			else
				biome_lib.block_recheck_list[#biome_lib.block_recheck_list + 1] = table.copy(biome_lib.block_log[1])
				table.remove(biome_lib.block_log, 1)
			end
			biome_lib.pos_hash = nil
				biome_lib.dbg("Mapblock at "..minetest.pos_to_string(minp)..
					" had a neighbor not fully emerged, skipped it for now.", 4)
			return
		else
			biome_lib.pos_hash.surface_node_list = airflag
				and minetest.find_nodes_in_area_under_air(minp, maxp, biome_lib.surfaceslist_aircheck)
				or minetest.find_nodes_in_area(minp, maxp, biome_lib.surfaceslist_no_aircheck)
			if #biome_lib.pos_hash.surface_node_list == 0 then
				biome_lib.dbg("Mapblock at "..minetest.pos_to_string(minp).." dequeued:  no detected surfaces.", 4)
				table.remove(blocklog, 1)
				biome_lib.pos_hash = nil
				return
			else
				biome_lib.pos_hash.action_index = 1
				biome_lib.dbg("Mapblock at "..minetest.pos_to_string(minp)..
					" has "..#biome_lib.pos_hash.surface_node_list..
					" surface nodes to work on (airflag="..dump(airflag)..")", 4)
			end
		end
	elseif not (airflag and biome_lib.actionslist_aircheck[biome_lib.pos_hash.action_index])
	  and not (not airflag and biome_lib.actionslist_no_aircheck[biome_lib.pos_hash.action_index]) then
		-- the block is finished, remove it
		if #biome_lib.pos_hash.surface_node_list > 0 then
			biome_lib.dbg("Deleted mapblock "..minetest.pos_to_string(minp).." from the block log", 4)
		end
		table.remove(blocklog, 1)
		biome_lib.pos_hash = nil
	else
		-- below, [1] is biome, [2] is the thing to be added
		local added = 0
		if airflag then
			if biome_lib.actionslist_aircheck[biome_lib.pos_hash.action_index] then
				added = biome_lib.populate_surfaces(
							biome_lib.actionslist_aircheck[biome_lib.pos_hash.action_index][1],
							biome_lib.actionslist_aircheck[biome_lib.pos_hash.action_index][2],
							biome_lib.pos_hash.surface_node_list, true)
				biome_lib.pos_hash.action_index = biome_lib.pos_hash.action_index + 1
			end
		else
			if biome_lib.actionslist_no_aircheck[biome_lib.pos_hash.action_index] then
				added = biome_lib.populate_surfaces(
							biome_lib.actionslist_no_aircheck[biome_lib.pos_hash.action_index][1],
							biome_lib.actionslist_no_aircheck[biome_lib.pos_hash.action_index][2],
							biome_lib.pos_hash.surface_node_list, false)
				biome_lib.pos_hash.action_index = biome_lib.pos_hash.action_index + 1
			end
		end
		if added > 0 then
			biome_lib.dbg("biome_lib.populate_surfaces ran on mapblock at "..
				minetest.pos_to_string(minp)..".  Entry #"..
				(biome_lib.pos_hash.action_index-1).." added "..added.." items.", 4)
		end
	end
end

-- "Play" them back, populating them with new stuff in the process

minetest.register_globalstep(function(dtime)
	if not biome_lib.block_log[1] then return end -- the block log is empty

	if math.random(100) > biome_lib.queue_ratio then return end
	for s = 1, biome_lib.entries_per_step do
		biome_lib.generate_block()
	end
end)

-- Periodically wake-up the queue to give old blocks a chance to time-out
-- if the player isn't currently exploring (i.e. they're just playing in one area)

function biome_lib.wake_up_queue()
	if #biome_lib.block_recheck_list > 1
	  and #biome_lib.block_log == 0 then
		biome_lib.block_log[#biome_lib.block_log + 1] =
			table.copy(biome_lib.block_recheck_list[#biome_lib.block_recheck_list])
		biome_lib.block_recheck_list[#biome_lib.block_recheck_list] = nil
		biome_lib.run_block_recheck_list = true
		biome_lib.dbg("Woke-up the map queue to give old blocks a chance to time-out.", 3)
	end
	minetest.after(biome_lib.block_queue_wakeup_time, biome_lib.wake_up_queue)
end

biome_lib.wake_up_queue()

-- Play out the entire log all at once on shutdown
-- to prevent unpopulated map areas

local function format_time(t)
	if t > 59999999 then
		return os.date("!%M minutes and %S seconds", math.ceil(t/1000000))
	else
		return os.date("!%S seconds", math.ceil(t/1000000))
	end
end

function biome_lib.check_remaining_time()
	if minetest.get_us_time() > (biome_lib.shutdown_last_timestamp + 10000000) then -- report progress every 10s
		biome_lib.shutdown_last_timestamp = minetest.get_us_time()

		local entries_remaining = #biome_lib.block_log + #biome_lib.block_recheck_list

		local total_purged = biome_lib.starting_count - entries_remaining
		local elapsed_time = biome_lib.shutdown_last_timestamp - biome_lib.shutdown_start_time
		biome_lib.dbg(string.format("%i entries, approximately %s remaining.",
			entries_remaining, format_time(elapsed_time/total_purged * entries_remaining)))
	end
end

minetest.register_on_shutdown(function()
	biome_lib.shutdown_start_time = minetest.get_us_time()
	biome_lib.shutdown_last_timestamp = minetest.get_us_time()+1

	biome_lib.starting_count = #biome_lib.block_log + #biome_lib.block_recheck_list

	if biome_lib.starting_count == 0 then
		return
	end

	biome_lib.dbg("Stand by, purging the mapblock log "..
		"(there are "..biome_lib.starting_count.." entries) ...", 0)

	while #biome_lib.block_log > 0 do
		biome_lib.generate_block(true)
		biome_lib.check_remaining_time()
	end

	if #biome_lib.block_recheck_list > 0 then
		biome_lib.block_log = table.copy(biome_lib.block_recheck_list)
		biome_lib.block_recheck_list = {}
		while #biome_lib.block_log > 0 do
			biome_lib.generate_block(true)
			biome_lib.check_remaining_time()
		end
	end
	biome_lib.dbg("Log purge completed after "..
		format_time(minetest.get_us_time() - biome_lib.shutdown_start_time)..".", 0)
end)

-- The spawning ABM

function biome_lib:spawn_on_surfaces(sd,sp,sr,sc,ss,sa)

	local biome = {}

	if type(sd) ~= "table" then
		biome.spawn_delay = sd	-- old api expects ABM interval param here.
		biome.spawn_plants = {sp}
		biome.avoid_radius = sr
		biome.spawn_chance = sc
		biome.spawn_surfaces = {ss}
		biome.avoid_nodes = sa
	else
		biome = sd
	end

	if biome.spawn_delay*time_scale >= 1 then
		biome.interval = biome.spawn_delay*time_scale
	else
		biome.interval = 1
	end

	biome_lib:set_defaults(biome)
	biome.spawn_plants_count = #(biome.spawn_plants)

	local n
	if type(biome.spawn_plants) == "table" then
		n = "random: "..biome.spawn_plants[1]..", ..."
	else
		n = biome.spawn_plants
	end
	biome.label = biome.label or "biome_lib spawn_on_surfaces(): "..n

	minetest.register_abm({
		nodenames = biome.spawn_surfaces,
		interval = biome.interval,
		chance = biome.spawn_chance,
		neighbors = biome.neighbors,
		label = biome.label,
		action = function(pos, node, active_object_count, active_object_count_wider)
			local p_top = { x = pos.x, y = pos.y + 1, z = pos.z }	
			local n_top = minetest.get_node(p_top)
			local perlin_fertile_area = minetest.get_perlin(biome.seed_diff, perlin_octaves, perlin_persistence, perlin_scale)

			local fertility, temperature, humidity = get_biome_data(pos, perlin_fertile_area)

			local pos_biome_ok = pos.y >= biome.min_elevation and pos.y <= biome.max_elevation
				and fertility > biome.plantlife_limit
				and temperature <= biome.temp_min and temperature >= biome.temp_max
				and humidity <= biome.humidity_min and humidity >= biome.humidity_max
				and biome_lib:is_node_loaded(p_top)

			if not pos_biome_ok then
				return -- Outside of biome
			end

			local n_light = minetest.get_node_light(p_top, nil)
			if n_light < biome.light_min or n_light > biome.light_max then
				return -- Too dark or too bright
			end

			if biome.avoid_nodes and biome.avoid_radius and minetest.find_node_near(
					p_top, biome.avoid_radius + math.random(-1.5,2), biome.avoid_nodes) then
				return -- Nodes to avoid are nearby
			end

			if biome.neighbors and biome.ncount and
					#minetest.find_nodes_in_area(
						{x=pos.x-1, y=pos.y, z=pos.z-1},
						{x=pos.x+1, y=pos.y, z=pos.z+1},
						biome.neighbors
					) <= biome.ncount then
				return -- Near neighbour nodes are not present
			end

			local NEAR_DST = biome.near_nodes_size
			if biome.near_nodes and biome.near_nodes_count and biome.near_nodes_size and
					#minetest.find_nodes_in_area(
						{x=pos.x-NEAR_DST, y=pos.y-biome.near_nodes_vertical, z=pos.z-NEAR_DST},
						{x=pos.x+NEAR_DST, y=pos.y+biome.near_nodes_vertical, z=pos.z+NEAR_DST},
						biome.near_nodes
					) < biome.near_nodes_count then
				return -- Far neighbour nodes are not present
			end

			if (biome.air_count and biome.air_size) and
					#minetest.find_nodes_in_area(
						{x=p_top.x-biome.air_size, y=p_top.y, z=p_top.z-biome.air_size},
						{x=p_top.x+biome.air_size, y=p_top.y, z=p_top.z+biome.air_size},
						"air"
					) < biome.air_count then
				return -- Not enough air
			end

			local walldir = biome_lib:find_adjacent_wall(p_top, biome.verticals_list, biome.choose_random_wall)
			if biome.alt_wallnode and walldir then
				if n_top.name == "air" then
					minetest.swap_node(p_top, { name = biome.alt_wallnode, param2 = walldir })
				end
				return
			end

			local currentsurface = minetest.get_node(pos).name

			if biome_lib.default_water_nodes[currentsurface] and
					#minetest.find_nodes_in_area(
						{x=pos.x, y=pos.y-biome.depth_max-1, z=pos.z},
						vector.new(pos),
						biome_lib.default_wet_surfaces
					) == 0 then
				return -- On water but no ground nearby
			end

			local rnd = math.random(1, biome.spawn_plants_count)
			local plant_to_spawn = biome.spawn_plants[rnd]
			local fdir = biome.facedir
			if biome.random_facedir then
				fdir = math.random(biome.random_facedir[1],biome.random_facedir[2])
			end
			if type(biome.spawn_plants) == "string" then
				assert(loadstring(biome.spawn_plants.."(...)"))(pos)
			elseif not biome.spawn_on_side and not biome.spawn_on_bottom and not biome.spawn_replace_node then
				if n_top.name == "air" then
					minetest.swap_node(p_top, { name = plant_to_spawn, param2 = fdir })
				end
			elseif biome.spawn_replace_node then
				minetest.swap_node(pos, { name = plant_to_spawn, param2 = fdir })

			elseif biome.spawn_on_side then
				local onside = biome_lib:find_open_side(pos)
				if onside then
					minetest.swap_node(onside.newpos, { name = plant_to_spawn, param2 = onside.facedir })
				end
			elseif biome.spawn_on_bottom then
				if minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "air" then
					minetest.swap_node({x=pos.x, y=pos.y-1, z=pos.z}, { name = plant_to_spawn, param2 = fdir} )
				end
			end
		end
	})
end

-- Function to decide how to replace a plant - either grow it, replace it with
-- a tree, run a function, or die with an error.

function biome_lib:replace_object(pos, replacement, grow_function, walldir, seeddiff)
	local growtype = type(grow_function)
	if growtype == "table" then
		minetest.swap_node(pos, biome_lib.air)
		biome_lib:grow_tree(pos, grow_function)
		return
	elseif growtype == "function" then
		local perlin_fertile_area = minetest.get_perlin(seeddiff, perlin_octaves, perlin_persistence, perlin_scale)
		local fertility, temperature, _ = get_biome_data(pos, perlin_fertile_area)
		grow_function(pos, fertility, temperature, walldir)
		return
	elseif growtype == "string" then
		local perlin_fertile_area = minetest.get_perlin(seeddiff, perlin_octaves, perlin_persistence, perlin_scale)
		local fertility, temperature, _ = get_biome_data(pos, perlin_fertile_area)
		assert(loadstring(grow_function.."(...)"))(pos, fertility, temperature, walldir)
		return
	elseif growtype == "nil" then
		minetest.swap_node(pos, { name = replacement, param2 = walldir})
		return
	elseif growtype ~= "nil" and growtype ~= "string" and growtype ~= "table" then
		error("Invalid grow function "..dump(grow_function).." used on object at ("..dump(pos)..")")
	end
end

dofile(biome_lib.modpath .. "/search_functions.lua")
assert(loadfile(biome_lib.modpath .. "/growth.lua"))(time_scale)

-- Check for infinite stacks

if minetest.get_modpath("unified_inventory") or not minetest.settings:get_bool("creative_mode") then
	biome_lib.expect_infinite_stacks = false
else
	biome_lib.expect_infinite_stacks = true
end

-- read a field from a node's definition

function biome_lib:get_nodedef_field(nodename, fieldname)
	if not minetest.registered_nodes[nodename] then
		return nil
	end
	return minetest.registered_nodes[nodename][fieldname]
end

if biome_lib.debug_log_level >= 3 then
	biome_lib.last_count = 0

	function biome_lib.show_pending_block_count()
		if biome_lib.last_count ~= #biome_lib.block_log then
			biome_lib.dbg(string.format("Pending block counts - ready to process: %-8icurrently deferred: %i",
				#biome_lib.block_log, #biome_lib.block_recheck_list), 3)
			biome_lib.last_count = #biome_lib.block_log
			biome_lib.queue_idle_flag = false
		elseif not biome_lib.queue_idle_flag then
			if #biome_lib.block_recheck_list > 0 then
				biome_lib.dbg("Mapblock queue only contains blocks that can't yet be processed.",  3)
				biome_lib.dbg("Idling the queue until new blocks arrive or the next wake-up call occurs.",  3)
			else
				biome_lib.dbg("Mapblock queue has run dry.",  3)
				biome_lib.dbg("Idling the queue until new blocks arrive.",  3)
			end
			biome_lib.queue_idle_flag = true
		end
		minetest.after(1, biome_lib.show_pending_block_count)
	end

	biome_lib.show_pending_block_count()
end

minetest.after(0, function()
	biome_lib.dbg("Registered a total of "..(#biome_lib.surfaceslist_aircheck)+(#biome_lib.surfaceslist_no_aircheck).." surface types to be evaluated, spread", 0)
	biome_lib.dbg("across "..#biome_lib.actionslist_aircheck.." actions with air-checking and "..#biome_lib.actionslist_no_aircheck.." actions without.", 0)
	biome_lib.dbg("within an elevation range of "..biome_lib.mapgen_elevation_limit.min.." and "..biome_lib.mapgen_elevation_limit.max.." meters.", 0)

end)

biome_lib.dbg("[Biome Lib] Loaded", 0)
