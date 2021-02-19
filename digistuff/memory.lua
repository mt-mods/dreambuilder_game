minetest.register_node("digistuff:ram", {
	description = "Digilines 128Kbit SRAM",
	groups = {cracky=3},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
		for i=0,31,1 do
			meta:set_string(string.format("data%02d",i),"")
		end
	end,
	tiles = {
		"digistuff_ram_top.png",
		"jeija_microcontroller_bottom.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png"
	},
	inventory_image = "digistuff_ram_top.png",
	drawtype = "nodebox",
	selection_box = {
		--From luacontroller
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
	},
	_digistuff_channelcopier_fieldname = "channel",
	node_box = {
		--From Luacontroller
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, -7/16, 8/16}, -- Bottom slab
			{-5/16, -7/16, -5/16, 5/16, -6/16, 5/16}, -- Circuit board
			{-3/16, -6/16, -3/16, 3/16, -5/16, 3/16}, -- IC
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
	end,
	digiline = 
	{
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
				local meta = minetest.get_meta(pos)
				if meta:get_string("channel") ~= channel or type(msg) ~= "table" then return end
				if msg.command == "read" then
					if type(msg.address) == "number" and msg.address >= 0 and msg.address <= 31 then
						digiline:receptor_send(pos,digiline.rules.default,channel,meta:get_string(string.format("data%02i",math.floor(msg.address))))					
					end
				elseif msg.command == "write" then
					if type(msg.address) == "number" and msg.address >= 0 and msg.address <= 31 and type(msg.data) == "string" then
						meta:set_string(string.format("data%02i",math.floor(msg.address)),string.sub(msg.data,1,512))
					end
				end
			end
		},
	},
})

minetest.register_node("digistuff:eeprom", {
	description = "Digilines 128Kbit EEPROM",
	groups = {cracky=3},
	stack_max = 1,
	after_place_node = function(pos,_,istack)
		local meta = minetest.get_meta(pos)
		local smeta = istack:get_meta()
		for i=0,31,1 do
			meta:set_string(string.format("data%02d",i),smeta:get_string(string.format("data%02d",i)))
		end
		meta:set_string("channel",smeta:get_string("channel"))
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,
	on_dig = function(pos,node,player)
		local name = player:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		local istack = ItemStack("digistuff:eeprom")
		local smeta = istack:get_meta()
		for i=0,31,1 do
			smeta:set_string(string.format("data%02d",i),meta:get_string(string.format("data%02d",i)))
		end
		smeta:set_string("channel",meta:get_string("channel"))
		minetest.remove_node(pos)
		smeta:set_string("description","Digilines 128KBit EEPROM (with data)")
		local inv = minetest.get_inventory({type = "player",name = name,})
		if player.is_fake_player or not inv:room_for_item("main",istack) then
			minetest.handle_node_drops(pos,{istack},player)
		else
			inv:add_item("main",istack)
		end
		digilines.update_autoconnect(pos)
	end,
	tiles = {
		"digistuff_eeprom_top.png",
		"jeija_microcontroller_bottom.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png",
		"jeija_microcontroller_sides.png"
	},
	inventory_image = "digistuff_eeprom_top.png",
	drawtype = "nodebox",
	selection_box = {
		--From luacontroller
		type = "fixed",
		fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
	},
	_digistuff_channelcopier_fieldname = "channel",
	node_box = {
		--From Luacontroller
		type = "fixed",
		fixed = {
			{-8/16, -8/16, -8/16, 8/16, -7/16, 8/16}, -- Bottom slab
			{-5/16, -7/16, -5/16, 5/16, -6/16, 5/16}, -- Circuit board
			{-3/16, -6/16, -3/16, 3/16, -5/16, 3/16}, -- IC
		}
	},
	paramtype = "light",
	sunlight_propagates = true,
	on_receive_fields = function(pos, formname, fields, sender)
		local name = sender:get_player_name()
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		local meta = minetest.get_meta(pos)
		if fields.channel then meta:set_string("channel",fields.channel) end
	end,
	digiline = 
	{
		receptor = {},
		effector = {
			action = function(pos,node,channel,msg)
				local meta = minetest.get_meta(pos)
				if meta:get_string("channel") ~= channel or type(msg) ~= "table" then return end
				if msg.command == "read" then
					if type(msg.address) == "number" and msg.address >= 0 and msg.address <= 31 then
						digiline:receptor_send(pos,digiline.rules.default,channel,meta:get_string(string.format("data%02i",math.floor(msg.address))))					
					end
				elseif msg.command == "write" then
					if type(msg.address) == "number" and msg.address >= 0 and msg.address <= 31 and type(msg.data) == "string" then
						meta:set_string(string.format("data%02i",math.floor(msg.address)),string.sub(msg.data,1,512))
					end
				end
			end
		},
	},
})

minetest.register_craft({
	output = "digistuff:ram",
	recipe = {
		{"basic_materials:plastic_sheet","basic_materials:plastic_sheet","basic_materials:plastic_sheet"},
		{"mesecons_gates:nand_off","basic_materials:plastic_sheet","mesecons_gates:nand_off"},
		{"mesecons:wire_00000000_off","basic_materials:silicon","mesecons:wire_00000000_off"},
	}
})

minetest.register_craft({
	output = "digistuff:eeprom",
	recipe = {
		{"basic_materials:plastic_sheet","mesecons:wire_00000000_off","basic_materials:plastic_sheet"},
		{"digilines:wire_std_00000000","basic_materials:plastic_sheet","digilines:wire_std_00000000"},
		{"mesecons:wire_00000000_off","basic_materials:silicon","mesecons:wire_00000000_off"},
	}
})
