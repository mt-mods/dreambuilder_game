minetest.register_node("digistuff:camera", {
	tiles = {
		"digistuff_camera_top.png",
		"digistuff_camera_bottom.png",
		"digistuff_camera_right.png",
		"digistuff_camera_left.png",
		"digistuff_camera_back.png",
		"digistuff_camera_front.png",
	},
	digiline = 
	{
		receptor = {}
	},
	groups = {cracky=2},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
				{-0.1,-0.5,-0.28,0.1,-0.3,0.3}, --Camera Body
				{-0.045,-0.42,-0.34,0.045,-0.36,-0.28}, -- Lens
				{-0.05,-0.9,-0.05,0.05,-0.5,0.05}, --Pole
			}
	},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.1,-0.5,-0.34,0.1,-0.3,0.3}, --Camera Body
			}
	},
	description = "Digilines Camera",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","size[8,6;]field[1,1;6,2;channel;Channel;${channel}]field[1,2;6,2;radius;Radius (max 10);${radius}]field[1,3;6,2;distance;Distance (max 20);${distance}]button_exit[2.25,4;3,1;submit;Save]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
		if fields.distance and tonumber(fields.distance) then meta:set_int("distance",math.max(math.min(20,fields.distance),0)) end
		if fields.radius and tonumber(fields.radius) then meta:set_int("radius",math.max(math.min(10,fields.radius),1)) end
	end,
	sounds = default and default.node_sound_stone_defaults()
})

minetest.register_abm({
	nodenames = {"digistuff:camera"},
	interval = 1.0,
	chance = 1,
	action = function(pos,node)
			local meta = minetest.get_meta(pos)
			local channel = meta:get_string("channel")
			local radius = meta:get_int("radius")
			local distance = meta:get_int("distance")
			local dir = vector.multiply(minetest.facedir_to_dir(node.param2),-1)
			local spot = vector.add(pos,vector.multiply(dir,distance))
			local i = 0
			while i <= 10 and minetest.get_node(spot).name == "air" do
				--Downward search for ground level
				spot = vector.add(spot,vector.new(0,-1,0))
				i = i + 1
			end
			if minetest.get_node(spot).name == "air" or minetest.get_node(spot).name == "ignore" then
				--Ground not in range
				return
			end

			local found_any = false
			local players_found = {}
			local objs = minetest.get_objects_inside_radius(spot,radius)
			if objs then
				local _,obj
				for _,obj in ipairs(objs) do
					if obj:is_player() then
						table.insert(players_found,obj:get_player_name())
						found_any = true
					end
				end
				if found_any then
					digiline:receptor_send({x=pos.x,y=pos.y-1,z=pos.z}, digiline.rules.default, channel, players_found)
				end
			end
		end
})

minetest.register_craft({
	output = "digistuff:camera",
	recipe = {
		{"homedecor:plastic_sheeting","homedecor:plastic_sheeting","homedecor:plastic_sheeting"},
		{"default:glass","homedecor:ic","mesecons_luacontroller:luacontroller0000"},
		{"homedecor:plastic_sheeting","homedecor:plastic_sheeting","homedecor:plastic_sheeting"},
	}
})
