--	item_drop code by cyisfor
--	https://github.com/cyisfor/item_drop


if drops == nil then
	drops = {}
end

local movers = {}

local removedAlreadyDammit = {}

vector.fixedNormalize = function(v)
	assert(v)
	local len = vector.length(v)
	if len == 0 then
		-- no length 1 vector will ever equal this
		return vector.new(0,0,0)
	else
		return vector.divide(v, len)
	end
end

if not vector.dot then
	vector.dot = function(p1,p2)
		return p1.x * p2.x + p1.y * p2.y + p1.z * p2.z
	end
end

local function removeObject(object)
	movers[object] = nil
	removedAlreadyDammit[object] = true
	object:remove()
end

local function removeObjectWithSound(object)
	movers[object] = nil
	removedAlreadyDammit[object] = true
	local pos=object:getpos() 
	minetest.sound_play("item_gone", {
		pos=pos,
		gain = 0.2,
		max_hear_distance = 32,
	})
	object:remove()
end

-- returns whether the pickup failed or not.
-- nil pickupRadius means to infinity and beyond
local function pickup(player, inv, object, pickupRadius)
	if removedAlreadyDammit[object] then
		-- this gets called after the timeout, as well as when it hits the player
		return true
	end
	if player == nil then return true end

	-- itemstring is serialized item so includes metadata
	local lua = object:get_luaentity()
	local item = ItemStack(lua.itemstring)
	if inv and inv:room_for_item("main", item) then
		inv:add_item("main", item)
		if object:get_luaentity().itemstring ~= "" then
			minetest.sound_play("item_drop_pickup", {
				to_player = player:get_player_name(),
				gain = 0.4,
			})
		end
		lua.itemstring = ''
		removeObject(object)
		return false
	else
		return true
	end
end

local function isGood(object)
	-- only want items swooping up after players, not after chests!
	if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
		return true
	else
		return false
	end
end

local function stop(object)
	movers[object] = nil
	-- no pickup, even though it's close, so
	-- stop moving towards the player
	object:setvelocity({x=0, y=0, z=0})
	object:setacceleration({x=0, y=0, z=0})
	-- also we can walk on it and it can push pressure plates
	-- physical_state = false means "please make us physical again"
	local lua = object:get_luaentity()
	if lua then
		lua.physical_state = false
	end
	--object:set_properties({
	-- physical = true
	--})
end

local function pickupOrStop(object, inv, player, pickupRadius)
	local lua = object:get_luaentity()
	if object == nil or lua == nil or lua.itemstring == nil then
		return
	end
	if pickup(player, inv, object, pickupRadius) then
		stop(object)
	end
end

-- GMass... it's the player's mass if the player were a giant planetlike object
-- which things orbit around
-- in the following units:
-- if G = 6.67×10−11 then
-- GMass = 1 for 14,992,503,748 kilograms
drops.playerGMass = 1.7
-- the player is faaaaaaaat

local function moveTowards(object, player, pickupRadius, attractRadius)
	-- move it towards the player, then pick it up after a delay!
	local pos1 = player:getpos()
	if pos1 == nil then return end
	local pos2 = object:getpos()
	if pos2 == nil then return end
	pos1.y = pos1.y+0.5 -- head towards player's belt
	local direct = vector.subtract(pos1, pos2)
	local R = vector.length(direct)
	local v = object:getvelocity()
	local stopped = v.x == 0 and v.y == 0 and v.z == 0
	-- when direction(X) = direction(V) we passed the player
	-- so project V onto X. If same, passed. If not, approaching.
	-- projection = norm(X) * (length(V) * cos(theta))
	-- => length(V) * dot(V,X) / length(V) / length(X)
	-- = dot(V,X) / length(X)
	-- if X is normalized, length(X) == 1 so... dot product!
	-- sign(dot) > 0 = same direction sign(dot)< 0 = different
	direct = vector.fixedNormalize(direct)

	-- idea, set velocity not acceleration but set it
	-- not to velocity + acceleration, but to the projection of that
	-- onto the direction vector. object will always have velocity towards YOU

	if R > attractRadius then
		stop(object)
		return
	end
	if R < pickupRadius or (not stopped and vector.dot(v,direct) < 0) then
		pickupOrStop(object,player:get_inventory(),player,nil)
		return
	end
	-- Fg = G*M1*M2/R^2
	-- M1*A1 = G * M1 * M2 / R^2
	-- A1 = G * M2 / R ^2
	-- G = whatever it takes for stuff to orbit around the player
	-- and the weight of the player is ^^^
	-- A1 = C / R^2	
	local A
	A = drops.playerGMass / R^2
	A = math.max(A,2*drops.playerGMass)
	object:setacceleration(vector.multiply(direct,A))
end

if minetest.setting_get("enable_item_pickup") == "true" then
	local tickets = 0 -- XXX: oy vey
	moveDelay = 0
	minetest.register_globalstep(function(dtime)
		-- it's much more efficient to just restart... no way to unregister_globalstep right?
		if not minetest.setting_get("enable_item_pickup") then return end
		moveDelay = moveDelay + dtime
		local pickupRadius = tonumber(minetest.setting_get("pickup_radius"))
		local attractRadius = tonumber(minetest.setting_get("attract_radius"))
		if not pickupRadius then pickupRadius = 0.5 end
		if not attractRadius then attractRadius = 3 end

		if moveDelay > 0.1 then
			moveDelay = 0
			-- correct your trajectory while moving
			for object,pair in pairs(movers) do
				local player = pair[1]
				moveTowards(object,player,pickupRadius,attractRadius)
			end
		end
		for _, player in ipairs(minetest.get_connected_players()) do
			if player:get_hp() > 0 or not minetest.setting_getbool("enable_damage") then
				local playerPosition = player:getpos()
				if playerPosition ~= nil then
					playerPosition.y = playerPosition.y + 0.5
					local inv = player:get_inventory()

					for _,i in ipairs({"x","y","z"}) do
						if playerPosition[i] > 31000 or playerPosition[i] < -31000 then
							return
						end
					end

					for _, object in ipairs(minetest.get_objects_inside_radius(playerPosition, 3)) do
						if isGood(object) and (object:get_luaentity().dropped_by ~= player:get_player_name() or object:get_luaentity().age > 3) and
							inv and
							inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring))
							then
								local ticket = tickets
								movers[object] = {player,ticket}
								tickets = tickets + 1
								moveTowards(object, player, pickupRadius, attractRadius)
								-- make sure object doesn't push the player around!
								object:get_luaentity().physical_state = true
								object:get_luaentity().object:set_properties({
									physical = false,
									collide_with_objects = false,
									weight = 0
								})
								-- pleeease no immortal orbiting entities
								-- unless you want them to be >:)
								minetest.after(30, function(object)
									-- only if it's still moving
									-- but what if it started moving a second time?
									local pair = movers[object]
									if pair and pair[2] == ticket then
										stop(object)
									end
								end, object)
						end
					end
				end
			end
		end
	end)
end

if minetest.setting_get("enable_item_drops") == "true" then
	local old_handle_node_drops = minetest.handle_node_drops

	function new_handle_node_drops(pos, drops, digger)
		if digger and digger.is_fake_player then
			return old_handle_node_drops(pos, drops, digger)
		end
		local inv
		-- the digger might be a node, like a constructor
		if minetest.setting_getbool("creative_mode") and digger and digger:is_player() then
			inv = digger:get_inventory()
		end
		for _, item in ipairs(drops) do
			local count, name
			if type(item) == "string" then
				count = 1
				name = item
			else
				count = item:get_count()
				name = item:get_name()
			end
			-- Only drop the item if not in creative, or if the item is not in creative inventory
			if not inv or not inv:contains_item("main", ItemStack(name)) then
				for i=1, count do
					local obj = minetest.add_item(pos, item)
					if obj ~= nil then
						local x = math.random(1, 5)
						if math.random(1, 2) == 1 then
							x = -x
						end
						local z = math.random(1, 5)
						if math.random(1, 2) == 1 then
							z = -z
						end
						-- hurl it out into space at a random velocity
						-- (still falling though)
					obj:setvelocity({x=1/x, y=obj:getvelocity().y, z=1/z})			
					end
				end
			end
		end
		-- the items have been dropped. Don't use builtin/item.lua or it could put the items
		-- into an inventory! (see quarry)
		-- return old_handle_node_drops(pos, drops, digger)
	end

	function checkSetting(pos, drops, digger)
		if minetest.setting_get("enable_item_drops") == "true" then
			return new_handle_node_drops(pos, drops, digger)
		else
			return old_handle_node_drops(pos, drops, digger)
		end
	end
	minetest.handle_node_drops = checkSetting

end

function minetest.item_drop(itemstack, dropper, pos)
	if dropper and dropper.get_player_name then
		local v = dropper:get_look_dir()
		local p = {x=pos.x+v.x, y=pos.y+1.5+v.y, z=pos.z+v.z}
		local r
		if dropper:get_player_control().sneak then
			r = itemstack
			itemstack = itemstack:to_table()
			itemstack.count = 1
			itemstack = ItemStack(itemstack)
			r:take_item()
		else
			r = ItemStack("")
		end
		minetest.sound_play("item_drop", {
			pos=pos,
			gain = 1.0,
			max_hear_distance = 32,
		})
		local obj = minetest.add_item(p, itemstack)
		if obj then
			v.x = v.x*2
			v.y = v.y*2 + 1
			v.z = v.z*2
			obj:setvelocity(v)
			obj:get_luaentity().dropped_by = dropper:get_player_name()
		end
		return r
	else
		minetest.add_item(pos, itemstack)
		return ItemStack("")
	end
end
