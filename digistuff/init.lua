digistuff = {}
digistuff.sounds_playing = {}

digistuff.update_panel_formspec = function (pos,dispstr)
	local meta = minetest.get_meta(pos)
	local locked = meta:get_int("locked") == 1
	local fs = "size[10,8]"..
		"background[0,0;0,0;digistuff_panel_bg.png;true]"..
		"label[0,0;%s]"..
		(locked and "image_button[9,3;1,1;digistuff_panel_locked.png;unlock;]" or "image_button[9,3;1,1;digistuff_panel_unlocked.png;lock;]")..
		"image_button[2,4.5;1,1;digistuff_adwaita_go-up.png;up;]"..
		"image_button[1,5;1,1;digistuff_adwaita_go-previous.png;left;]"..
		"image_button[3,5;1,1;digistuff_adwaita_go-next.png;right;]"..
		"image_button[2,5.5;1,1;digistuff_adwaita_go-down.png;down;]"..
		"image_button[1,6.5;1,1;digistuff_adwaita_edit-undo.png;back;]"..
		"image_button[3,6.5;1,1;digistuff_adwaita_emblem-default.png;enter;]"..
		"field[6,5.75;2,1;channel;Channel;${channel}]"..
		"button[8,5.5;1,1;savechan;Set]"
	fs = fs:format(minetest.formspec_escape(dispstr)):gsub("|","\n")
	meta:set_string("formspec",fs)
	meta:set_string("text",dispstr)
end

digistuff.update_ts_formspec = function (pos)
	local meta = minetest.get_meta(pos)
	local fs = "size[10,8]"..
		"background[0,0;0,0;digistuff_ts_bg.png;true]"
	if meta:get_int("init") == 0 then
		fs = fs.."field[3.75,3;3,1;channel;Channel;]"..
		"button_exit[4,3.75;2,1;save;Save]"
	else
		local data = minetest.deserialize(meta:get_string("data")) or {}
		for _,field in pairs(data) do
			if field.type == "image" then
				fs = fs..string.format("image[%s,%s;%s,%s;%s]",field.X,field.Y,field.W,field.H,field.texture_name)
			elseif field.type == "field" then
				fs = fs..string.format("field[%s,%s;%s,%s;%s;%s;%s]",field.X,field.Y,field.W,field.H,field.name,field.label,field.default)
			elseif field.type == "pwdfield" then
				fs = fs..string.format("pwdfield[%s,%s;%s,%s;%s;%s]",field.X,field.Y,field.W,field.H,field.name,field.label)
			elseif field.type == "textarea" then
				fs = fs..string.format("textarea[%s,%s;%s,%s;%s;%s;%s]",field.X,field.Y,field.W,field.H,field.name,field.label,field.default)
			elseif field.type == "label" then
				fs = fs..string.format("label[%s,%s;%s]",field.X,field.Y,field.label)
			elseif field.type == "vertlabel" then
				fs = fs..string.format("vertlabel[%s,%s;%s]",field.X,field.Y,field.label)
			elseif field.type == "button" then
				fs = fs..string.format("button[%s,%s;%s,%s;%s;%s]",field.X,field.Y,field.W,field.H,field.name,field.label)
			elseif field.type == "button_exit" then
				fs = fs..string.format("button_exit[%s,%s;%s,%s;%s;%s]",field.X,field.Y,field.W,field.H,field.name,field.label)
			elseif field.type == "image_button" then
				fs = fs..string.format("image_button[%s,%s;%s,%s;%s;%s;%s]",field.X,field.Y,field.W,field.H,field.image,field.name,field.label)
			elseif field.type == "image_button_exit" then
				fs = fs..string.format("image_button_exit[%s,%s;%s,%s;%s;%s;%s]",field.X,field.Y,field.W,field.H,field.image,field.name,field.label)
			elseif field.type == "dropdown" then
				local choices = ""
				for _,i in ipairs(field.choices) do
					if type(i) == "string" then
						choices = choices..minetest.formspec_escape(i)..","
					end
				end
				choices = string.sub(choices,1,-2)
				fs = fs..string.format("dropdown[%s,%s;%s,%s;%s;%s;%s]",field.X,field.Y,field.W,field.H,field.name,choices,field.selected_id)
			end
		end
	end
	meta:set_string("formspec",fs)
end

digistuff.ts_on_receive_fields = function (pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	local playername = sender:get_player_name()
	local locked = meta:get_int("locked") == 1
	local can_bypass = minetest.check_player_privs(playername,{protection_bypass=true})
	local is_protected = minetest.is_protected(pos,playername)
	if (locked and is_protected) and not can_bypass then
		minetest.record_protection_violation(pos,playername)
		minetest.chat_send_player(playername,"You are not authorized to use this screen.")
		return
	end
	local init = meta:get_int("init") == 1
	if not init then
		if fields.save then
			meta:set_string("channel",fields.channel)
			meta:set_int("init",1)
			digistuff.update_ts_formspec(pos)
		end
	else
		fields.clicker = sender:get_player_name()
		digiline:receptor_send(pos, digiline.rules.default, setchan, fields)
	end
end

digistuff.process_command = function (meta, data, msg)
	if msg.command == "clear" then
		data = {}
	elseif msg.command == "addimage" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		if not msg.texture_name or type(msg.texture_name) ~= "string" then
			return	
		end
		local field = {type="image",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,texture_name=minetest.formspec_escape(msg.texture_name)}
		table.insert(data,field)
	elseif msg.command == "addfield" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		for _,i in pairs({"name","label","default"}) do
			if not msg[i] or type(msg[i]) ~= "string" then
				return
			end
		end
		local field = {type="field",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,name=minetest.formspec_escape(msg.name),label=minetest.formspec_escape(msg.label),default=minetest.formspec_escape(msg.default)}
		table.insert(data,field)
	elseif msg.command == "addpwdfield" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		for _,i in pairs({"name","label"}) do
			if not msg[i] or type(msg[i]) ~= "string" then
				return
			end
		end
		local field = {type="pwdfield",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,name=minetest.formspec_escape(msg.name),label=minetest.formspec_escape(msg.label)}
		table.insert(data,field)
	elseif msg.command == "addtextarea" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		for _,i in pairs({"name","label","default"}) do
			if not msg[i] or type(msg[i]) ~= "string" then
				return
			end
		end
		local field = {type="textarea",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,name=minetest.formspec_escape(msg.name),label=minetest.formspec_escape(msg.label),default=minetest.formspec_escape(msg.default)}
		table.insert(data,field)
	elseif msg.command == "addlabel" then
		for _,i in pairs({"X","Y"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		if not msg.label or type(msg.label) ~= "string" then
			return	
		end
		local field = {type="label",X=msg.X,Y=msg.Y,label=minetest.formspec_escape(msg.label)}
		table.insert(data,field)
	elseif msg.command == "addvertlabel" then
		for _,i in pairs({"X","Y"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		if not msg.label or type(msg.label) ~= "string" then
			return	
		end
		local field = {type="vertlabel",X=msg.X,Y=msg.Y,label=minetest.formspec_escape(msg.label)}
		table.insert(data,field)
	elseif msg.command == "addbutton" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		for _,i in pairs({"name","label"}) do
			if not msg[i] or type(msg[i]) ~= "string" then
				return
			end
		end
		local field = {type="button",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,name=minetest.formspec_escape(msg.name),label=minetest.formspec_escape(msg.label)}
		table.insert(data,field)
	elseif msg.command == "addbutton_exit" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		for _,i in pairs({"name","label"}) do
			if not msg[i] or type(msg[i]) ~= "string" then
				return
			end
		end
		local field = {type="button_exit",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,name=minetest.formspec_escape(msg.name),label=minetest.formspec_escape(msg.label)}
		table.insert(data,field)
	elseif msg.command == "addimage_button" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		for _,i in pairs({"image","name","label"}) do
			if not msg[i] or type(msg[i]) ~= "string" then
				return
			end
		end
		local field = {type="image_button",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,image=minetest.formspec_escape(msg.image),name=minetest.formspec_escape(msg.name),label=minetest.formspec_escape(msg.label)}
		table.insert(data,field)
	elseif msg.command == "addimage_button_exit" then
		for _,i in pairs({"X","Y","W","H"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		for _,i in pairs({"image","name","label"}) do
			if not msg[i] or type(msg[i]) ~= "string" then
				return
			end
		end
		local field = {type="image_button_exit",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,image=minetest.formspec_escape(msg.image),name=minetest.formspec_escape(msg.name),label=minetest.formspec_escape(msg.label)}
		table.insert(data,field)
	elseif msg.command == "adddropdown" then
		for _,i in pairs({"X","Y","W","H","selected_id"}) do
			if not msg[i] or type(msg[i]) ~= "number" then
				return
			end
		end
		if not msg.name or type(msg.name) ~= "string" then
			return
		end
		if not msg.choices or type(msg.choices) ~= "table" or #msg.choices < 1 then
			return
		end
		local field = {type="dropdown",X=msg.X,Y=msg.Y,W=msg.W,H=msg.H,name=msg.name,selected_id=msg.selected_id,choices=msg.choices}
		table.insert(data,field)
	elseif msg.command == "lock" then
		meta:set_int("locked",1)
	elseif msg.command == "unlock" then
		meta:set_int("locked",0)
	end
	return data
end

digistuff.ts_on_digiline_receive = function (pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	if channel ~= setchan then return end
	if type(msg) ~= "table" then return end
	local data = minetest.deserialize(meta:get_string("data")) or {}
	if msg.command then
		data = digistuff.process_command(meta,data,msg)
	else
		for _,i in ipairs(msg) do
			if i.command then
				data = digistuff.process_command(meta,data,i) or data
			end
		end
	end
	meta:set_string("data",minetest.serialize(data))
	digistuff.update_ts_formspec(pos)
end

digistuff.panel_on_digiline_receive = function (pos, node, channel, msg)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	if channel ~= setchan then return end
	if type(msg) ~= "string" then return end
	digistuff.update_panel_formspec(pos,msg)
end

digistuff.panel_on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	local playername = sender:get_player_name()
	local locked = meta:get_int("locked") == 1
	local can_bypass = minetest.check_player_privs(playername,{protection_bypass=true})
	local is_protected = minetest.is_protected(pos,playername)
	if fields.savechan then
		if can_bypass or not is_protected then
			meta:set_string("channel",fields.channel)
			local helpmsg = "Channel has been set. Waiting for data..."
			digistuff.update_panel_formspec(pos,helpmsg)
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to change the channel of this panel.")
		end
	elseif fields.up then
		if can_bypass or not is_protected or not locked then
			digiline:receptor_send(pos, digiline.rules.default, setchan, "up")
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to use this panel.")
		end
	elseif fields.down then
		if can_bypass or not is_protected or not locked then
			digiline:receptor_send(pos, digiline.rules.default, setchan, "down")
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to use this panel.")
		end
	elseif fields.left then
		if can_bypass or not is_protected or not locked then
			digiline:receptor_send(pos, digiline.rules.default, setchan, "left")
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to use this panel.")
		end
	elseif fields.right then
		if can_bypass or not is_protected or not locked then
			digiline:receptor_send(pos, digiline.rules.default, setchan, "right")
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to use this panel.")
		end
	elseif fields.back then
		if can_bypass or not is_protected or not locked then
			digiline:receptor_send(pos, digiline.rules.default, setchan, "back")
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to use this panel.")
		end
	elseif fields.enter then
		if can_bypass or not is_protected or not locked then
			digiline:receptor_send(pos, digiline.rules.default, setchan, "enter")
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to use this panel.")
		end
	elseif fields.lock then
		if can_bypass or not is_protected then
			meta:set_int("locked",1)
			minetest.chat_send_player(playername,"This panel has been locked. Access will now be controlled according to area protection.")
			digistuff.update_panel_formspec(pos,meta:get_string("text"))
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to lock this panel.")
		end
	elseif fields.unlock then
		if can_bypass or not is_protected then
			meta:set_int("locked",0)
			minetest.chat_send_player(playername,"This panel has been unlocked. It can now be used (but not locked or have the channel changed) by anyone.")
			digistuff.update_panel_formspec(pos,meta:get_string("text"))
		else
			minetest.record_protection_violation(pos,playername)
			minetest.chat_send_player(playername,"You are not authorized to unlock this panel.")
		end
	end
end

digistuff.button_turnoff = function (pos)
	local node = minetest.get_node(pos)
	if node.name=="digistuff:button_on" then --has not been dug
		minetest.swap_node(pos, {name = "digistuff:button_off", param2=node.param2})
		if minetest.get_modpath("mesecons") then  minetest.sound_play("mesecons_button_pop", {pos=pos}) end
	end
end

minetest.register_node("digistuff:digimese", {
	description = "Digimese",
	tiles = {"digistuff_digimese.png"},
	paramtype = "light",
	light_source = 3,
	groups = {cracky = 3, level = 2},
	is_ground_content = false,
	sounds = default and default.node_sound_stone_defaults(),
	digiline = { wire = { rules = {
	{x = 1, y = 0, z = 0},
	{x =-1, y = 0, z = 0},
	{x = 0, y = 1, z = 0},
	{x = 0, y =-1, z = 0},
	{x = 0, y = 0, z = 1},
	{x = 0, y = 0, z =-1}}}}
})

minetest.register_node("digistuff:button", {
	drawtype = "nodebox",
	tiles = {
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_off.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_wallmounted = true,
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
	type = "fixed",
		fixed = { -6/16, -6/16, 5/16, 6/16, 6/16, 8/16 }
	},
	node_box = {
		type = "fixed",
		fixed = {
		{ -6/16, -6/16, 6/16, 6/16, 6/16, 8/16 },	-- the thin plate behind the button
		{ -4/16, -2/16, 4/16, 4/16, 2/16, 6/16 }	-- the button itself
	}
	},
	digiline = 
	{
		receptor = {}
	},
	groups = {dig_immediate=2},
	description = "Digilines Button",
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","size[8,4;]field[1,1;6,2;channel;Channel;${channel}]field[1,2;6,2;msg;Message;${msg}]button_exit[2.25,3;3,1;submit;Save]")
	end,
	on_receive_fields = function(pos, formname, fields, sender)
		local meta = minetest.get_meta(pos)
		if fields.channel and fields.msg and fields.channel ~= "" and fields.msg ~= "" then
			meta:set_string("channel",fields.channel)
			meta:set_string("msg",fields.msg)
			meta:set_string("formspec","")
			minetest.swap_node(pos, {name = "digibutton:button_off", param2=minetest.get_node(pos).param2})
		else
			minetest.chat_send_player(sender:get_player_name(),"Channel and message must both be set!")
		end
	end,
	sounds = default and default.node_sound_stone_defaults(),
})

minetest.register_node("digistuff:button_off", {
	drawtype = "nodebox",
	tiles = {
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_sides.png",
	"digistuff_digibutton_off.png"
	},
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_wallmounted = true,
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
	type = "fixed",
		fixed = { -6/16, -6/16, 5/16, 6/16, 6/16, 8/16 }
	},
	node_box = {
		type = "fixed",
		fixed = {
		{ -6/16, -6/16, 6/16, 6/16, 6/16, 8/16 },	-- the thin plate behind the button
		{ -4/16, -2/16, 4/16, 4/16, 2/16, 6/16 }	-- the button itself
	}
	},
	digiline = 
	{
		receptor = {}
	},
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	drop = "digistuff:button",
	description = "Digilines Button (off state - you hacker you!)",
	on_rightclick = function (pos, node, clicker)
		local meta = minetest.get_meta(pos)
		digiline:receptor_send(pos, digiline.rules.default, meta:get_string("channel"), meta:get_string("msg"))
		minetest.swap_node(pos, {name = "digistuff:button_on", param2=node.param2})
		if minetest.get_modpath("mesecons") then minetest.sound_play("mesecons_button_push", {pos=pos}) end
		minetest.after(0.5, digistuff.button_turnoff, pos)
	end,
	sounds = default and default.node_sound_stone_defaults(),
})

minetest.register_node("digistuff:button_on", {
	drawtype = "nodebox",
	tiles = {
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_sides.png",
		"digistuff_digibutton_on.png"
		},
	paramtype = "light",
	paramtype2 = "facedir",
	legacy_wallmounted = true,
	walkable = false,
	light_source = 7,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = { -6/16, -6/16, 5/16, 6/16, 6/16, 8/16 }
	},
	node_box = {
	type = "fixed",
	fixed = {
		{ -6/16, -6/16,  6/16, 6/16, 6/16, 8/16 },
		{ -4/16, -2/16, 11/32, 4/16, 2/16, 6/16 }
	}
    	},
	digiline = 
	{
		receptor = {}
	},
	groups = {dig_immediate=2, not_in_creative_inventory=1},
	drop = 'digistuff:button',
	on_rightclick = function (pos, node, clicker)
		local meta = minetest.get_meta(pos)
		digiline:receptor_send(pos, digiline.rules.default, meta:get_string("channel"), meta:get_string("msg"))
		if minetest.get_modpath("mesecons") then minetest.sound_play("mesecons_button_push", {pos=pos}) end
	end,
	description = "Digilines Button (on state - you hacker you!)",
	sounds = default and default.node_sound_stone_defaults(),
})

minetest.register_craft({
	output = "digistuff:digimese",
	recipe = {
		{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000"},
		{"digilines:wire_std_00000000","default:mese","digilines:wire_std_00000000"},
		{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000"}
	}
})

minetest.register_craft({
	output = "digistuff:button",
	recipe = {
		{"mesecons_button:button_off"},
		{"mesecons_luacontroller:luacontroller0000"},
		{"digilines:wire_std_00000000"}
	}
})

minetest.register_alias("digibutton:button","digistuff:button")
minetest.register_alias("digibutton:button_off","digistuff:button_off")
minetest.register_alias("digibutton:button_on","digistuff:button_on")
minetest.register_alias("digibutton:digimese","digistuff:digimese")

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

minetest.register_node("digistuff:panel", {
	description = "Digilines Control Panel",
	groups = {cracky=3},
	on_construct = function(pos)
		local helpmsg = "Please set a channel."
		digistuff.update_panel_formspec(pos,helpmsg)
		minetest.get_meta(pos):set_int("locked",0)
	end,
	drawtype = "nodebox",
	tiles = {
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_panel_front.png"
		},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
		}
    	},
	on_receive_fields = digistuff.panel_on_receive_fields,
	digiline = 
	{
		receptor = {},
		effector = {
			action = digistuff.panel_on_digiline_receive
		},
	},
})

minetest.register_craft({
	output = "digistuff:detector",
	recipe = {
		{"mesecons_detector:object_detector_off"},
		{"mesecons_luacontroller:luacontroller0000"},
		{"digilines:wire_std_00000000"}
	}
})

minetest.register_craft({
	output = "digistuff:panel",
	recipe = {
		{"","digistuff:button",""},
		{"digistuff:button","digilines:lcd","digistuff:button"},
		{"","digistuff:button",""}
	}
})

minetest.register_craft({
	output = "digistuff:touchscreen",
	recipe = {
		{"mesecons_luacontroller:luacontroller0000","default:glass","default:glass"},
		{"default:glass","digilines:lcd","default:glass"},
		{"default:glass","default:glass","default:glass"}
	}
})

minetest.register_node("digistuff:touchscreen", {
	description = "Digilines Touchscreen",
	groups = {cracky=3},
	on_construct = function(pos)
		digistuff.update_ts_formspec(pos,true)
	end,
	drawtype = "nodebox",
	tiles = {
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_panel_back.png",
		"digistuff_ts_front.png"
		},
	paramtype = "light",
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{ -0.5, -0.5, 0.4, 0.5, 0.5, 0.5 }
		}
    	},
	on_receive_fields = digistuff.ts_on_receive_fields,
	digiline = 
	{
		receptor = {},
		effector = {
			action = digistuff.ts_on_digiline_receive
		},
	},
})

minetest.register_node("digistuff:piezo", {
	description = "Digilines Piezoelectric Beeper",
	groups = {cracky=3},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec","field[channel;Channel;${channel}")
	end,
	on_destruct = function(pos)
		local pos_hash = minetest.hash_node_position(pos)
		if digistuff.sounds_playing[pos_hash] then
			minetest.sound_stop(digistuff.sounds_playing[pos_hash])
			digistuff.sounds_playing[pos_hash] = nil
		end
	end,
	tiles = {
		"digistuff_piezo_top.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png",
		"digistuff_piezo_sides.png"
		},
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
					local setchan = meta:get_string("channel")
					if channel ~= setchan then return end
					if msg == "shortbeep" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						minetest.sound_play({name = "digistuff_piezo_short_single",gain = 0.2},{pos = pos,max_hear_distance = 16})
					elseif msg == "longbeep" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						minetest.sound_play({name = "digistuff_piezo_long_single",gain = 0.2},{pos = pos,max_hear_distance = 16})
					elseif msg == "fastrepeat" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						digistuff.sounds_playing[pos_hash] = minetest.sound_play({name = "digistuff_piezo_fast_repeat",gain = 0.2},{pos = pos,max_hear_distance = 16,loop = true})
					elseif msg == "slowrepeat" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
						digistuff.sounds_playing[pos_hash] = minetest.sound_play({name = "digistuff_piezo_slow_repeat",gain = 0.2},{pos = pos,max_hear_distance = 16,loop = true})
					elseif msg == "stop" then
						local pos_hash = minetest.hash_node_position(pos)
						if digistuff.sounds_playing[pos_hash] then
							minetest.sound_stop(digistuff.sounds_playing[pos_hash])
							digistuff.sounds_playing[pos_hash] = nil
						end
					end
				end
		},
	},
})

local http = minetest.request_http_api()

if http then
	minetest.register_node("digistuff:nic", {
		description = "Digilines NIC",
		groups = {cracky=3},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec","field[channel;Channel;${channel}")
		end,
		tiles = {
			"digistuff_nic_top.png",
			"jeija_microcontroller_bottom.png",
			"jeija_microcontroller_sides.png",
			"jeija_microcontroller_sides.png",
			"jeija_microcontroller_sides.png",
			"jeija_microcontroller_sides.png"
		},
		drawtype = "nodebox",
		selection_box = {
			--From luacontroller
			type = "fixed",
			fixed = { -8/16, -8/16, -8/16, 8/16, -5/16, 8/16 },
		},
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
						if meta:get_string("channel") ~= channel then return end
						if type(msg) ~= "string" then return end
						http.fetch({
							url = msg,
							timeout = 5,
							user_agent = "Minetest Digilines Modem",
							},
							function(res)
								digiline:receptor_send(pos, digiline.rules.default, channel, res)
							end)
					end
			},
		},
	})
	minetest.register_craft({
		output = "digistuff:nic",
		recipe = {
			{"","","mesecons:wire_00000000_off"},
			{"digilines:wire_std_00000000","mesecons_luacontroller:luacontroller0000","mesecons:wire_00000000_off"}
		}
	})
end

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

if minetest.get_modpath("mesecons_noteblock") then
	local validnbsounds = dofile(minetest.get_modpath("digistuff")..DIR_DELIM.."nbsounds.lua")
	minetest.register_node("digistuff:noteblock", {
		description = "Digilines Noteblock",
		groups = {cracky=3},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec","field[channel;Channel;${channel}")
		end,
		on_destruct = function(pos)
			local pos_hash = minetest.hash_node_position(pos)
			if digistuff.sounds_playing[pos_hash] then
				minetest.sound_stop(digistuff.sounds_playing[pos_hash])
				digistuff.sounds_playing[pos_hash] = nil
			end
		end,
		tiles = {
			"mesecons_noteblock.png"
			},
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
						if msg == "get_sounds" then
							local soundnames = {}
							for i in pairs(validnbsounds) do
								table.insert(soundnames,i)
							end
							digiline:receptor_send(pos, digiline.rules.default, channel, soundnames)
						end
						local meta = minetest.get_meta(pos)
						local setchan = meta:get_string("channel")
						if channel ~= setchan then return end
						if type(msg) == "string" then
							local sound = validnbsounds[msg]
							if sound then minetest.sound_play(sound,{pos=pos}) end
						elseif type(msg) == "table" then
							if type(msg.sound) ~= "string" then return end
							local sound = validnbsounds[msg.sound]
							local volume = 1
							if type(msg.volume) == "number" then
								volume = math.max(0,math.min(1,msg.volume))
							end
							if sound then minetest.sound_play({name=sound,gain=volume},{pos=pos}) end
						end
					end
			},
		},
	})
end

for i=0,14,1 do
	local mult = 255 - ((14-i)*16)
	minetest.register_node("digistuff:light_"..i, {
		drop = "digistuff:light_0",
		description = "Digilines Dimmable Light"..(i > 0 and " (on state - you hacker you!)" or ""),
		tiles = {"digistuff_light.png"},
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
					{-0.25,0.4,-0.25,0.25,0.5,0.25},
				}
		},
		groups = i > 0 and {cracky = 1, not_in_creative_inventory = 1} or {cracky = 1},
		is_ground_content = false,
		light_source = i,
		color = {r = mult,g = mult,b = mult},
		sounds = default and default.node_sound_glass_defaults(),
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec","field[channel;Channel;${channel}")
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
		digiline = {
			receptor = {},
			wire = {
				rules = {
					{x = 1,y = 0,z = 0},
					{x = -1,y = 0,z = 0},
					{x = 0,y = 0,z = 1},
					{x = 0,y = 0,z = -1},
					{x = 0,y = 1,z = 0},
					{x = 0,y = -1,z = 0},
					{x = 0,y = 2,z = 0},
				}
			},
			effector = {
				action = function(pos,node,channel,msg)
						local meta = minetest.get_meta(pos)
						if meta:get_string("channel") ~= channel then return end
						local value = tonumber(msg)
						if (not value) or value > 14 or value < 0 then return end
						node.name = "digistuff:light_"..math.floor(value)
						minetest.swap_node(pos,node)
					end
			},
		},
	})
end

minetest.register_node("digistuff:junctionbox", {
	description = "Digilines Junction Box",
	tiles = {"digistuff_junctionbox.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {cracky = 3},
	is_ground_content = false,
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
					{-0.1,-0.15,0.35,0.1,0.15,0.5},
				}
		},
	sounds = default and default.node_sound_stone_defaults(),
	digiline = {
		receptor = {},
		wire = {
			rules = {
				{x = 1,y = 0,z = 0},
				{x = -1,y = 0,z = 0},
				{x = 0,y = 0,z = 1},
				{x = 0,y = 0,z = -1},
				{x = 0,y = 1,z = 0},
				{x = 0,y = -1,z = 0},
				{x = 0,y = -2,z = 0},
				{x = 0,y = 2,z = 0},
				{x = -2,y = 0,z = 0},
				{x = 2,y = 0,z = 0},
				{x = 0,y = 0,z = -2},
				{x = 0,y = 0,z = 2},
			}
		},
	},
})

minetest.register_craft({
	output = "digistuff:light_0",
	recipe = {
		{"digilines:wire_std_00000000","mesecons_lamp:lamp_off",},
	}
})

minetest.register_craft({
	output = "digistuff:junctionbox",
	recipe = {
		{"homedecor:plastic_sheeting","digilines:wire_std_00000000","homedecor:plastic_sheeting",},
		{"digilines:wire_std_00000000","digilines:wire_std_00000000","digilines:wire_std_00000000",},
		{"homedecor:plastic_sheeting","digilines:wire_std_00000000","homedecor:plastic_sheeting",},
	}
})
