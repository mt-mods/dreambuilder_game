local function cyan(str)
	return minetest.colorize("#00FFFF",str)
end

local function red(str)
	return minetest.colorize("#FF5555",str)
end

local radius = minetest.setting_get("areasprotector_radius") or 8

local function remove_display(pos)
	local objs = minetest.get_objects_inside_radius(pos, 0.5)
	for _,o in pairs(objs) do
		o:remove()
	end
end

minetest.register_node("areasprotector:protector",{
	description = "Protector Block",
	groups = {cracky=1},
	tiles = {
		"default_steel_block.png",
		"default_steel_block.png",
		"default_steel_block.png^areasprotector_protector.png"
	},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.5, -0.5, 0.5, 0.5, 0.5 },
	},
	on_place = function(itemstack,player,pointed)
		local pos = pointed.above
		local pos1 = vector.add(pos,vector.new(radius,radius,radius))
		local pos2 = vector.add(pos,vector.new(-1*radius,-1*radius,-1*radius))
		local name = player:get_player_name()
		local perm,err = areas:canPlayerAddArea(pos1,pos2,name)
		if not perm then
			minetest.chat_send_player(name,red("You are not allowed to protect that area: ")..err)
			return itemstack
		end
		local id = areas:add(name,"Protected by Protector Block",pos1,pos2)
		areas:save()
		local msg = string.format("The area from %s to %s has been protected as #%s",cyan(minetest.pos_to_string(pos1)),cyan(minetest.pos_to_string(pos2)),cyan(id))
		minetest.chat_send_player(name,msg)
		minetest.set_node(pos,{name="areasprotector:protector"})
		local meta = minetest.get_meta(pos)
		local infotext = string.format("Protecting area %d owned by %s",id,name)
		meta:set_string("infotext",infotext)
		meta:set_int("area_id",id)
		meta:set_string("owner",name)
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
	on_destruct = function(pos)
		local meta = minetest.get_meta(pos)
		local owner = meta:get_string("owner")
		local id = meta:get_int("area_id")
		if areas.areas[id] and areas:isAreaOwner(id,owner) then
			areas:remove(id)
			areas:save()
		end
	end,
	on_punch = function(pos, node, puncher)
		local objs = minetest.get_objects_inside_radius(pos,.5) -- a radius of .5 since the entity serialization seems to be not that precise
		local removed = false
		for _, o in pairs(objs) do
			if (not o:is_player()) and o:get_luaentity().name == "areasprotector:display" then
				o:remove()
				removed = true
			end
		end
		if not removed then -- nothing was removed: there wasn't the entity
			minetest.add_entity(pos, "areasprotector:display")
			minetest.after(4, remove_display, pos)
		end
	end
})

-- entities code below (and above) mostly copied-pasted from Zeg9's protector mod

minetest.register_entity("areasprotector:display", {
	physical = false,
	collisionbox = {0,0,0,0,0,0},
	visual = "wielditem",
	visual_size = {x=1.0/1.5,y=1.0/1.5}, -- wielditem seems to be scaled to 1.5 times original node size
	textures = {"areasprotector:display_node"},
	on_step = function(self, dtime)
		if minetest.get_node(self.object:getpos()).name ~= "areasprotector:protector" then
			self.object:remove()
			return
		end
	end,
})

local nb_radius = radius + 0.55

minetest.register_node("areasprotector:display_node", {
	tiles = {"areasprotector_display.png"},
	walkable = false,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- sides
			{ -nb_radius, -nb_radius, -nb_radius, -nb_radius,  nb_radius,  nb_radius },
			{ -nb_radius, -nb_radius,  nb_radius,  nb_radius,  nb_radius,  nb_radius },
			{  nb_radius, -nb_radius, -nb_radius,  nb_radius,  nb_radius,  nb_radius },
			{ -nb_radius, -nb_radius, -nb_radius,  nb_radius,  nb_radius, -nb_radius },
			-- top
			{ -nb_radius,  nb_radius, -nb_radius,  nb_radius,  nb_radius,  nb_radius },
			-- bottom
			{ -nb_radius, -nb_radius, -nb_radius,  nb_radius, -nb_radius,  nb_radius },
			-- middle (surround protector)
			{-.55,-.55,-.55, .55,.55,.55},
		},
	},
	selection_box = {
		type = "regular",
	},
	paramtype = "light",
	groups = {dig_immediate=3,not_in_creative_inventory=1},
	drop = "",
})

minetest.register_craft({
	output = "areasprotector:protector",
	type = "shapeless",
	recipe = {"default:steelblock","default:steel_ingot"},
})
