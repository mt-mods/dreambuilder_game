-- abort if the function already exists
if minetest.delay_function then
	minetest.log("error", "[function_delayer] minetest.delay_function already exists.")
	return
end

local clock = minetest.get_us_time
local load_time_start = clock()

local maxdelay = 1 * 1000000
local skipstep = 5
local lastmod_effect = 2


local tasks = {}

-- used for the table.sort function
local previous_modname
local function sort_times(a, b)
	a, b = tasks[a], tasks[b]
	local a_first = b.time - a.time
	if a.mod_origin ~= b.mod_origin then
		if a.mod_origin == previous_modname then
			a_first = a_first - lastmod_effect
		elseif b.mod_origin == previous_modname then
			a_first = a_first + lastmod_effect
		end
	end
	a_first = a_first > 0
	previous_modname = a_first and a.mod_origin or b.mod_origin
	return a_first
end

local needs_sort, toadd, supramod
local todo = {}
function minetest.delay_function(task, func, ...)
	if type(task) == "number" then
		task = {time = task}
	end
	if toadd then
		task.time = task.time + toadd
	end
	local id = #tasks+1
	todo[#todo+1] = id
	task.mod_origin = supramod or minetest.get_last_run_mod()
	if func then
		task.func = func
		task.params = {...}
	end
	tasks[id] = task

	needs_sort = true
end

local stepnum = 0
local col_dtime = 0
minetest.register_globalstep(function(dtime)
	local count = #todo

	-- abort if nothing is todo
	if count == 0 then
		return
	end

	-- abort if it's not the skipstepths step
	stepnum = (stepnum+1)%skipstep
	col_dtime = col_dtime+dtime
	if stepnum ~= 0 then
		return
	end
	dtime = col_dtime
	col_dtime = 0

	-- get the start time
	local ts = clock() - dtime * 1000000

	if needs_sort then
		-- execute the functions with lower delays earlier
		table.sort(todo, sort_times)
		needs_sort = false
	end

	-- execute expired functions
	toadd = dtime
	local n = 1
	while true do
		local id = todo[n]
		if not id then
			break
		end
		local task = tasks[id]
		local time = task.time - dtime
		if time < 0 then
			local params = task.params or {}
			params[#params+1] = time
			local func = task.func
			supramod = task.mod_origin
			table.remove(todo, n)
			tasks[id] = nil
			func(unpack(params))
		else
			task.time = time
			n = n+1
		end
		--print("expired")
	end
	toadd = nil
	supramod = nil

	-- execute functions until the time limit is reached
	while todo[1]
	and clock() - ts < maxdelay do
		local task = tasks[todo[1]]
		local params = task.params or {}
		params[#params+1] = task.time
		local func = task.func
		supramod = task.mod_origin
		tasks[todo[1]] = nil
		table.remove(todo, 1)
		func(unpack(params))
	end
	supramod = nil
end)

-- requested by raymoo
minetest.register_on_shutdown(function()
	-- execute functions until nothing is left
	while todo[1] do
		local task = tasks[todo[1]]
		tasks[todo[1]] = nil
		table.remove(todo, 1)
		if task.run_on_shutdown then
			local params = task.params or {}
			params[#params+1] = task.time -- time is wrong here
			local func = task.func
			supramod = task.mod_origin
			func(unpack(params))
		end
	end
end)


local time = (clock()-load_time_start)/1000000
local msg = "[function_delayer] loaded after ca. "..time.." seconds"
if time > 0.01 then
	print(msg)
else
	minetest.log("info", msg)
end
