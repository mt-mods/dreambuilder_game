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
	output = "digistuff:panel",
	recipe = {
		{"","digistuff:button",""},
		{"digistuff:button","digilines:lcd","digistuff:button"},
		{"","digistuff:button",""}
	}
})
