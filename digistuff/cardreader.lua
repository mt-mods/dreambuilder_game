local cardreader_rules = {
	{x =  1, y =  0,z =  0,},
	{x =  2, y =  0,z =  0,},
	{x = -1, y =  0,z =  0,},
	{x = -2, y =  0,z =  0,},
	{x =  0, y =  1,z =  0,},
	{x =  0, y =  2,z =  0,},
	{x =  0, y = -1,z =  0,},
	{x =  0, y = -2,z =  0,},
	{x =  0, y =  0,z =  1,},
	{x =  0, y =  0,z =  2,},
	{x =  0, y =  0,z = -1,},
	{x =  0, y =  0,z = -2,},
}

minetest.register_craftitem("digistuff:card",{
	description = "Blank Magnetic Card",
	image = "digistuff_magnetic_card.png",
	stack_max = 1,
	on_use = function(stack,_,pointed)
		local pos = pointed.under
		if not pos then return end
		if minetest.get_node(pos).name ~= "digistuff:card_reader" then return end
		local meta = minetest.get_meta(pos)
		local channel = meta:get_string("channel")
		local stackmeta = stack:get_meta()
		if meta:get_int("writepending") > 0 then
			local data = meta:get_string("writedata")
			meta:set_int("writepending",0)
			meta:set_string("infotext","Ready to Read")
			digiline:receptor_send(pos,cardreader_rules,channel,{event = "write",})
			stackmeta:set_string("data",data)
			stackmeta:set_string("description",string.format("Magnetic Card (%s)",meta:get_string("writedescription")))
			return stack
		else
			local channel = meta:get_string("channel")
			local data = stackmeta:get_string("data")
			digiline:receptor_send(pos,cardreader_rules,channel,{event = "read",data = data,})
		end
	end,
})

minetest.register_node("digistuff:card_reader",{
	description = "Digilines Magnetic Card Reader/Writer",
	groups = {cracky = 3,digiline_receiver = 1,},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
		meta:set_int("writepending",0)
		meta:set_string("infotext","Ready to Read")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
	end,
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = {
		"digistuff_cardreader_sides.png",
		"digistuff_cardreader_sides.png",
		"digistuff_cardreader_sides.png",
		"digistuff_cardreader_sides.png",
		"digistuff_cardreader_sides.png",
		"digistuff_cardreader_top.png",
	},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.08,-0.12,0.4,0.08,0.12,0.5},
		}
	},
	digiline = {
		receptor = {},
		wire = {
			rules = cardreader_rules,
		},
		effector = {
			action = function(pos,node,channel,msg)
				local setchannel = minetest.get_meta(pos):get_string("channel")
				if channel ~= setchannel or type(msg) ~= "table" then return end
				if msg.command == "write" and (type(msg.data) == "string" or type(msg.data) == "number") then
					local meta = minetest.get_meta(pos)
					meta:set_string("infotext","Ready to Write")
					meta:set_int("writepending",1)
					if type(msg.data) ~= "string" then msg.data = tostring(msg.data) end
					meta:set_string("writedata",string.sub(msg.data,1,256))
					if type(msg.description) == "string" then
						meta:set_string("writedescription",string.sub(msg.description,1,64))
					else
						meta:set_string("writedescription","no name")
					end
				end
			end,
		},
	},
})

minetest.register_craft({
	output = "digistuff:card",
	recipe = {
		{"basic_materials:plastic_sheet",},
		{"default:iron_lump",},
	}
})

minetest.register_craft({
	output = "digistuff:card_reader",
	recipe = {
		{"basic_materials:plastic_sheet","basic_materials:plastic_sheet","digilines:wire_std_00000000",},
		{"basic_materials:plastic_sheet","basic_materials:copper_wire","mesecons_luacontroller:luacontroller0000",},
		{"basic_materials:plastic_sheet","basic_materials:plastic_sheet","",},
	}
})
