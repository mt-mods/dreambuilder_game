minetest.register_node("digistuff:detector", {
	tiles = {
	"digistuff_digidetector.png"
	},
	digiline = 
	{
		receptor = {}
	},
	groups = {cracky=2},
	description = "Digilines Player Detector",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","size[8,4;]field[1,1;6,2;channel;Channel;${channel}]field[1,2;6,2;radius;Radius;${radius}]button_exit[2.25,3;3,1;submit;Save]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
		if fields.msg then meta:set_string("msg",fields.msg) end
		if fields.radius then meta:set_string("radius",fields.radius) end
	end,
	sounds = default and default.node_sound_stone_defaults()
})

minetest.register_abm({
	nodenames = {"digistuff:detector"},
	interval = 1.0,
	chance = 1,
	action = function(pos)
			local meta = minetest.get_meta(pos)
			local channel = meta:get_string("channel")
			local radius = meta:get_string("radius")
			local found_any = false
			local players_found = {}
			if not radius or not tonumber(radius) or tonumber(radius) < 1 or tonumber(radius) > 10 then radius = 6 end
			local objs = minetest.get_objects_inside_radius(pos, radius)
			if objs then
				local _,obj
				for _,obj in ipairs(objs) do
					if obj:is_player() then
						table.insert(players_found,obj:get_player_name())
						found_any = true
					end
				end
				if found_any then
					digiline:receptor_send(pos, digiline.rules.default, channel, players_found)
				end
			end
		end
})

minetest.register_craft({
	output = "digistuff:detector",
	recipe = {
		{"mesecons_detector:object_detector_off"},
		{"mesecons_luacontroller:luacontroller0000"},
		{"digilines:wire_std_00000000"}
	}
})
