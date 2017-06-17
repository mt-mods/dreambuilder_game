--[[
Minetest Mod - Simple Shooter [shooter] 0.5.3
=======================================

License Source Code: 2013 Stuart Jones - LGPL v2.1

License Textures: Stuart Jones - WTFPL

Licence Models: Stuart Jones - CC-BY-SA 3.0

License Sounds: freesound.org

--]]
minetest.register_alias("crossbow", "castle_weapons:crossbow")
minetest.register_alias("bolt", "castle_weapons:crossbow_bolt")
minetest.register_alias("castle:crossbow", "castle_weapons:crossbow")
minetest.register_alias("castle:bolt", "castle_weapons:crossbow_bolt")
minetest.register_alias("castle:crossbow_bolt", "castle_weapons:crossbow_bolt")
minetest.register_alias("castle:crossbow_loaded", "castle_weapons:crossbow_loaded")

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

local crossbow={}

CROSSBOW_USES = 300
CROSSBOW_BOLT_TOOL_CAPS = {damage_groups={fleshy=4}}
CROSSBOW_BOLT_LIFETIME = 60-- 1  minute
CROSSBOW_ENABLE_PARTICLE_FX = false
CROSSBOW_ENABLE_PROTECTION = true
CROSSBOW_EXPLOSION_TEXTURE = "castle_crossbow_hit.png"
CROSSBOW_ALLOW_NODES = true
CROSSBOW_ALLOW_ENTITIES = true
CROSSBOW_ALLOW_PLAYERS = true
CROSSBOW_PLAYER_OFFSET = {x=0, y=1, z=0}
CROSSBOW_ENTITY_OFFSET = {x=0, y=0, z=0}
CROSSBOW_ENTITIES = {
"mobs:chicken",
"mobs:cow",
"mobs:dirt_monster",
"mobs:dungeon_master",
"mobs:goat",
"mobs:mese_monster",
"mobs:npc",
"mobs:oerkki",
"mobs:pig",
"mobs:pumba",
"mobs:rat",
"mobs:rhino",
"mobs:sand_monster",
"mobs:sheep",
"mobs:spider",
"mobs:stone_monster",
"mobs:tree_monster",
}

if minetest.is_singleplayer() == true then
	CROSSBOW_ALLOW_ENTITIES = true
	CROSSBOW_ALLOW_PLAYERS = true
end

local allowed_entities = {}
for _,v in ipairs(CROSSBOW_ENTITIES) do
	allowed_entities[v] = 1
end

local function get_dot_product(v1, v2)
	return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end

local function get_particle_pos(p, v, d)
	return vector.add(p, vector.multiply(v, {x=d, y=d, z=d}))
end

function crossbow:spawn_particles(pos, texture)
	if CROSSBOW_ENABLE_PARTICLE_FX == true then
		if type(texture) ~= "string" then
			texture = CROSSBOW_EXPLOSION_TEXTURE
		end
		local spread = {x=0.1, y=0.1, z=0.1}
		minetest.add_particlespawner({
			amount = 15,
			time = 0.3,
			minpos = vector.subtract(pos, spread),
			maxpos = vector.add(pos, spread),
			minvel = {x=-1, y=1, z=-1},
			maxvel = {x=1, y=2, z=1},
			minacc = {x=-2, y=-2, z=-2},
			maxacc = {x=2, y=-2, z=2},
			minexptime = 0.1,
			maxexptime = 0.75,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			texture = texture,
		})
	end
end

function crossbow:punch_node(pos, def)
	local node = minetest.get_node(pos)
	if not node then
		return
	end
	local item = minetest.registered_items[node.name]
	if not item then
		return
	end
	if CROSSBOW_ENABLE_PROTECTION then
		if minetest.is_protected(pos, def.name) then
			return
		end
	end
	if item.groups then
		for k, v in pairs(def.groups) do
			local level = item.groups[k] or 0
			if level >= v then
				minetest.remove_node(pos)
				if item.tiles then
					if item.tiles[1] then
						crossbow:spawn_particles(pos, item.tiles[1])
					end
				end
				break
			end
		end
	end
end

function crossbow:is_valid_object(object)
	if object then
		if object:is_player() == true then
			return CROSSBOW_ALLOW_PLAYERS
		end
		if CROSSBOW_ALLOW_ENTITIES == true then
			local luaentity = object:get_luaentity()
			if luaentity then
				if luaentity.name then
					if allowed_entities[luaentity.name] then
						return true
					end
				end
			end
		end
	end
end

function crossbow:get_intersect_pos(ray, plane, collisionbox)
	local v = vector.subtract(ray.pos, plane.pos)
	local r1 = get_dot_product(v, plane.normal)
	local r2 = get_dot_product(ray.dir, plane.normal)
	if r2 ~= 0 then
		local t = -(r1 / r2)
		local td = vector.multiply(ray.dir, {x=t, y=t, z=t})
		local pt = vector.add(ray.pos, td)
		local pd = vector.subtract(pt, plane.pos)
		if math.abs(pd.x) < collisionbox[4] and
				math.abs(pd.y) < collisionbox[5] and
				math.abs(pd.z) < collisionbox[6] then
			return pt
		end
	end
end

function crossbow:process_round(round)
	local target = {object=nil, distance=10000}
	local p1 = round.pos
	local v1 = round.ray
	for _,ref in ipairs(castle.objects) do
		local p2 = vector.add(ref.pos, ref.offset)
		if p1 and p2 and ref.name ~= round.name then
			local d = vector.distance(p1, p2)
			if d < round.def.step and d < target.distance then
				local ray = {pos=p1, dir=v1}
				local plane = {pos=p2, normal={x=-1, y=0, z=-1}}
				local pos = crossbow:get_intersect_pos(ray, plane, ref.collisionbox)
				if pos then
					target.object = ref.object
					target.pos = pos
					target.distance = d
				end
			end
		end
	end
	if target.object and target.pos then
		local success, pos = minetest.line_of_sight(p1, target.pos, 1)
		if success then
			local user = minetest.get_player_by_name(round.name)
			if user then
				target.object:punch(user, nil, round.def.tool_caps, v1)
				crossbow:spawn_particles(target.pos, CROSSBOW_EXPLOSION_TEXTURE)
			end
			return 1
		elseif pos and CROSSBOW_ALLOW_NODES == true then
			crossbow:punch_node(pos, round.def)
			return 1
		end
	elseif CROSSBOW_ALLOW_NODES == true then
		local d = round.def.step
		local p2 = vector.add(p1, vector.multiply(v1, {x=d, y=d, z=d}))
		local success, pos = minetest.line_of_sight(p1, p2, 1)
		if pos then
			crossbow:punch_node(pos, round.def)
			return 1
		end
	end
end

local function get_animation_frame(dir)
	local angle = math.atan(dir.y)
	local frame = 90 - math.floor(angle * 360 / math.pi)
	if frame < 1 then
		frame = 1
	elseif frame > 180 then
		frame = 180
	end
	return frame
end

local function get_target_pos(p1, p2, dir, offset)
	local d = vector.distance(p1, p2) - offset
	local td = vector.multiply(dir, {x=d, y=d, z=d})
	return vector.add(p1, td)
end

local function punch_object(puncher, object)
	if puncher and crossbow:is_valid_object(object) then
		if puncher ~= object then
			local dir = puncher:get_look_dir()
			local p1 = puncher:getpos()
			local p2 = object:getpos()
			local tpos = get_target_pos(p1, p2, dir, 0)
			crossbow:spawn_particles(tpos, CROSSBOW_EXPLOSION_TEXTURE)
			object:punch(puncher, nil, CROSSBOW_BOLT_TOOL_CAPS, dir)
		end
	end
end

local function stop_crossbow_bolt(object, pos, stuck)
	local acceleration = {x=0, y=-10, z=0}
	if stuck == true then
		pos = pos or object:getpos()
		acceleration = {x=0, y=0, z=0}
		object:moveto(pos)
	end
	object:set_properties({
		physical = true,
		collisionbox = {-1/8,-1/8,-1/8, 1/8,1/8,1/8},
	})
	object:setvelocity({x=0, y=0, z=0})
	object:setacceleration(acceleration)
end

minetest.register_craftitem("castle_weapons:crossbow_bolt", {
	description = S("Bolt"),
	stack_max =  20,
	inventory_image = "castle_crossbow_bolt_inv.png",
})

minetest.register_entity("castle_weapons:crossbow_bolt_entity", {
	physical = false,
	visual = "mesh",
	mesh = "castle_crossbow_bolt.b3d",
	visual_size = {x=1.0, y=1.0},
	textures = {
  "castle_crossbow_bolt_uv.png"
   },
	timer = 0,
	lifetime = CROSSBOW_BOLT_LIFETIME,
	player = nil,
	state = "init",
	node_pos = nil,
	collisionbox = {0,0,0, 0,0,0},
	on_activate = function(self, staticdata)
		self.object:set_armor_groups({immortal=1})
		if staticdata == "expired" then
			self.object:remove()
		end
	end,
	on_punch = function(self, puncher)
		if puncher then
			if puncher:is_player() then
				local stack = "castle_weapons:crossbow_bolt"
				local inv = puncher:get_inventory()
				if inv:room_for_item("main", stack) then
					inv:add_item("main", stack)
					self.object:remove()
				end
			end
		end
	end,
	on_step = function(self, dtime)
		if self.state == "init" then
			return
		end
		self.timer = self.timer + dtime
		self.lifetime = self.lifetime - dtime
		if self.lifetime < 0 then
			self.object:remove()
			return
		elseif self.state == "dropped" then
			return
		elseif self.state == "stuck" then
			if self.timer > 1 then
				if self.node_pos then
					local node = minetest.get_node(self.node_pos)
					if node.name then
						local item = minetest.registered_items[node.name]
						if item then
							if not item.walkable then
								self.state = "dropped"
								stop_crossbow_bolt(self.object)
								return
							end
						end
					end
				end
				self.timer = 0
			end
			return
		end
		if self.timer > 0.2 then
			local pos = self.object:getpos()
			local dir = vector.normalize(self.object:getvelocity())
			local frame = get_animation_frame(dir)
			self.object:set_animation({x=frame, y=frame}, 0)
			local objects = minetest.get_objects_inside_radius(pos, 5)
			for _,obj in ipairs(objects) do
				if crossbow:is_valid_object(obj) then
					local collisionbox = {-0.25,-1.0,-0.25, 0.25,0.8,0.25}
					local offset = CROSSBOW_PLAYER_OFFSET
					if not obj:is_player() then
						offset = CROSSBOW_ENTITY_OFFSET
						local ent = obj:get_luaentity()
						if ent then
							local def = minetest.registered_entities[ent.name]
							collisionbox = def.collisionbox or collisionbox
						end
					end
					local opos = vector.add(obj:getpos(), offset)
					local ray = {pos=pos, dir=dir}
					local plane = {pos=opos, normal={x=-1, y=0, z=-1}}
					local ipos = crossbow:get_intersect_pos(ray, plane, collisionbox)
					if ipos then
						punch_object(self.player, obj)
					end
				end
			end
			local p = vector.add(pos, vector.multiply(dir, {x=5, y=5, z=5}))
			local _, npos = minetest.line_of_sight(pos, p, 1)
			if npos then
				local node = minetest.get_node(npos)
				local tpos = get_target_pos(pos, npos, dir, 0.66)
				self.node_pos = npos
				self.state = "stuck"
				stop_crossbow_bolt(self.object, tpos, true)
				minetest.sound_play("castle_crossbow_bolt", {gain = 0.08, max_hear_distance = 2})
			end
			self.timer = 0
		end
	end,
	get_staticdata = function(self)
		return "expired"
	end,
})

	minetest.register_tool("castle_weapons:crossbow_loaded", {
		description = S("Crossbow"),
		inventory_image = "castle_crossbow_loaded.png",
		groups = {not_in_creative_inventory=1},
		on_use = function(itemstack, user, pointed_thing)
			minetest.sound_play("castle_crossbow_click", {object=user})
			if not minetest.settings:get_bool("creative_mode") then
				itemstack:add_wear(65535/CROSSBOW_USES)
			end
			itemstack = "castle_weapons:crossbow 1 "..itemstack:get_wear()
			local pos = user:getpos()
			local dir = user:get_look_dir()
			local yaw = user:get_look_yaw()
			if pos and dir and yaw then
				pos.y = pos.y + 1.5
				local obj = minetest.add_entity(pos, "castle_weapons:crossbow_bolt_entity")
				local ent = nil
				if obj then
					ent = obj:get_luaentity()
				end
				if ent then
					obj:set_properties({
						textures = {"castle_crossbow_bolt_uv.png"}
					})
					minetest.sound_play("castle_crossbow_shoot", {object=obj})
					local frame = get_animation_frame(dir)
					obj:setyaw(yaw + math.pi)
					obj:set_animation({x=frame, y=frame}, 0)
					obj:setvelocity({x=dir.x * 14, y=dir.y * 14, z=dir.z * 14})
					if pointed_thing.type ~= "nothing" then
						local ppos = minetest.get_pointed_thing_position(pointed_thing, false)
						local _, npos = minetest.line_of_sight(pos, ppos, 1)
						if npos then
							ppos = npos
							pointed_thing.type = "node"
						end
						if pointed_thing.type == "object" then
							punch_object(user, pointed_thing.ref)
						elseif pointed_thing.type == "node" then
							local node = minetest.get_node(ppos)
							local tpos = get_target_pos(pos, ppos, dir, 0.66)
							minetest.after(0.2, function(object, pos, npos)
								ent.node_pos = npos
								ent.state = "stuck"
								stop_crossbow_bolt(object, pos, true)
        minetest.sound_play("castle_crossbow_bolt", {gain = 0.08, max_hear_distance = 2})
							end, obj, tpos, ppos)
							return itemstack
						end
					end
					obj:setacceleration({x=dir.x * -3, y=-5, z=dir.z * -3})
					ent.player = ent.player or user
					ent.state = "flight"
				end
			end
			return itemstack
		end,
	})

minetest.register_tool("castle_weapons:crossbow", {
	description = S("Crossbow"),
	inventory_image = "castle_crossbow_inv.png",
	on_use = function(itemstack, user, pointed_thing)
		local inv = user:get_inventory()
if inv:contains_item("main", "castle_weapons:crossbow_bolt") then
				minetest.sound_play("castle_crossbow_reload", {object=user})
				if not minetest.settings:get_bool("creative_mode") then
					inv:remove_item("main", "castle_weapons:crossbow_bolt 1")
				end
				return "castle_weapons:crossbow_loaded 1 "..itemstack:get_wear()
			end
		minetest.sound_play("castle_crossbow_click", {object=user})
	end,
})

-----------
--Crafting
-----------

minetest.register_craft({
	output = 'castle_weapons:crossbow',
	recipe = {
		{'default:steel_ingot', 'default:stick', 'default:steel_ingot'},
		{'farming:string', 'farming:string', 'farming:string'},
		{'', 'default:stick', ''},
	}
})

minetest.register_craft({
	output = "castle_weapons:crossbow_bolt 6",
	recipe = {
		{'default:stick', 'default:stick', 'default:steel_ingot'},
	}
})