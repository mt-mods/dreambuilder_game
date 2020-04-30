rgblightstone = {}

if type(minetest.colorize) == "function" then
	rgblightstone.colorize = minetest.colorize
else
	rgblightstone.colorize = function(color,text)
		return text
	end
end

function rgblightstone.autofill(pos,player)
	local name = player:get_player_name()
	if minetest.is_protected(pos, name) and not minetest.check_player_privs(name, { protection_bypass = true }) then
		minetest.record_protection_violation(pos, name)
		return
	end
	local meta = minetest.get_meta(pos)
	if (not meta:get_string("channel")) or meta:get_string("channel")=="" then
		local pos_above = {x=pos.x,y=pos.y+1,z=pos.z}
		local node_above = minetest.get_node(pos_above)
		local meta_above = minetest.get_meta(pos_above)
		if string.match(node_above.name,"rgblightstone") and
		meta_above:get_string("channel") and
		tonumber(meta_above:get_string("addrx")) and
		tonumber(meta_above:get_string("addry")) then
			local channel = meta_above:get_string("channel")
			local addrx = meta_above:get_string("addrx")
			local addry = tostring(1+tonumber(meta_above:get_string("addry")))
			meta:set_string("channel",channel)
			meta:set_string("addrx",addrx)
			meta:set_string("addry",addry)
			minetest.chat_send_player(player:get_player_name(),rgblightstone.colorize("#55FF55","Success: ").."Auto-filled with channel "..rgblightstone.colorize("#00FFFF",channel)..", X address "..rgblightstone.colorize("#00FFFF",addrx)..", and Y address "..rgblightstone.colorize("#00FFFF",addry)..".")
			meta:set_string("infotext","")
		else
			minetest.chat_send_player(player:get_player_name(),rgblightstone.colorize("#FF0000","ERROR: ").."Node above is not RGB Lightstone or is not configured correctly!")
		end
	end
end

function rgblightstone.handle_digilines(pos,node,channel,msg,truecolor)
	local meta = minetest.get_meta(pos)
	local setchan = meta:get_string("channel")
	if channel ~= setchan then
		return
	end

	local addrx = tonumber(meta:get_string("addrx"))
	local addry = tonumber(meta:get_string("addry"))

	if type(msg) == "table" then
		if not (addrx and addry and type(msg[addry]) == "table" and msg[addry][addrx]) then
			return
		end
		msg = msg[addry][addrx]
	end

	--Validation starts here
	if type(msg) ~= "string" then
		return
	end
	msg = string.upper(msg)
	--Drop a leading # if present (e.g. "#FF55AA")
	if string.sub(msg,1,1) == "#" then
		msg = string.sub(msg,2)
	end
	--Check length
	if string.len(msg) ~= 6 then
		return
	end
	--Make sure there aren't any invalid chars
	local acceptable_chars = {["0"]=true,["1"]=true,["2"]=true,["3"]=true,["4"]=true,["5"]=true,["6"]=true,["7"]=true,["8"]=true,["9"]=true,["A"]=true,["B"]=true,["C"]=true,["D"]=true,["E"]=true,["F"]=true}
	for i = 1,6,1 do
		if not acceptable_chars[string.sub(msg,i,i)] then
			return
		else
		end
	end
	--Should be a valid hex color by this point
	
	meta:set_string("color",msg)
	
	--Split into three colors
	local r = tonumber(string.sub(msg,1,2),16)
	local g = tonumber(string.sub(msg,3,4),16)
	local b = tonumber(string.sub(msg,5,6),16)
	
	--Convert RGB to HSV... or at least V, for the light
	local v = math.max(r,g,b)
	v = math.floor(v/255*14)
	v = math.max(0,math.min(14,v))

	if truecolor then
		node.name = "rgblightstone:rgblightstone_truecolor_"..v
		minetest.swap_node(pos,node)
		rgblightstone.update_entity(pos)
	else
		--Round to nearest available values and convert to a pixel count in the palette
		r = math.floor(r/32)
		g = math.floor(g/32)
		b = math.floor(b/64) --Blue has one fewer bit
		
		local paletteidx = 32*g+4*r+b

		--Set the color
		node.name = "rgblightstone:rgblightstone_"..v
		node.param2 = paletteidx
		minetest.swap_node(pos,node)
	end
end

function rgblightstone.handle_fields(pos,formname,fields,sender)
			local name = sender:get_player_name()
			if minetest.is_protected(pos, name) and not minetest.check_player_privs(name, { protection_bypass = true }) then
				minetest.record_protection_violation(pos, name)
				return
			end
			local meta = minetest.get_meta(pos)
			if fields.autofill then
				rgblightstone.autofill(pos,sender)
			else
				if fields.channel then
					meta:set_string("channel", fields.channel)
					meta:set_string("infotext","")
				end
				if fields.addrx then meta:set_string("addrx",fields.addrx) end
				if fields.addry then meta:set_string("addry",fields.addry) end
			end
end

function rgblightstone.update_entity(pos)
	local objs = minetest.get_objects_inside_radius(pos,0.5)
	for _,obj in ipairs(objs) do
		if obj:get_luaentity() and obj:get_luaentity().name == "rgblightstone:entity" then
			obj:remove()
		end
	end
	local obj = minetest.add_entity(pos,"rgblightstone:entity")
	local tex = "rgblightstone_white.png^[colorize:#"..minetest.get_meta(pos):get_string("color")..":255"
	obj:set_properties({textures = {tex,tex,tex,tex,tex,tex}})
end

minetest.register_entity("rgblightstone:entity",{
	hp_max = 1,
	physical = false,
	collisionbox = {0,0,0,0,0,0},
	visual_size = {x=1,y=1},
	visual = "cube",
	static_save = false,
})

for i=0,14,1 do 
	minetest.register_node("rgblightstone:rgblightstone_"..i, {
		tiles = {"rgblightstone_white.png"},
		palette = "rgblightstone_palette.png",
		groups = i == 0 and {cracky = 2,} or {cracky = 2,not_in_creative_inventory = 1,},
		description = i == 0 and "256-Color RGB Lightstone" or "256-Color RGB Lightstone (lit state - you hacker you!)",
		paramtype2 = "color",
		light_source = i,
		drop = "rgblightstone:rgblightstone_0",
		_digistuff_channelcopier_fieldname = "channel",
		_digistuff_channelcopier_onset = function(pos)
			minetest.get_meta(pos):set_string("infotext","")
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", "size[8,5;]field[1,1;6,2;channel;Channel;${channel}]field[1,2;2,2;addrx;X Address;${addrx}]field[5,2;2,2;addry;Y Address;${addry}]button_exit[2.25,3;3,1;submit;Save]button_exit[2.25,4;3,1;autofill;Auto-Fill From Node Above]label[3,2;Leave address blank\nfor individual mode]")
			meta:set_string("infotext","Not configured! Right-click to set up manually, or punch to auto-fill from the node above.")
			meta:set_string("color","000000")
		end,
		on_punch = function(pos,node,player,pointed_thing)
			rgblightstone.autofill(pos,player)
		end,
		on_receive_fields = rgblightstone.handle_fields,
		light_source = 0,
		digiline = {
			wire = {
				rules = {
					{x = 1,y = 0,z = 0},
					{x = -1,y = 0,z = 0},
					{x = 0,y = 0,z = 1},
					{x = 0,y = 0,z = -1},
					{x = 0,y = 1,z = 0},
					{x = 0,y = -1,z = 0},
				},
			},
			receptor = {},
			effector = {
				action = function(pos,node,channel,msg)
					rgblightstone.handle_digilines(pos,node,channel,msg,false)
				end
			}
		}
	})
	
	minetest.register_node("rgblightstone:rgblightstone_truecolor_"..i, {
		tiles = {"rgblightstone_white.png^[colorize:#000000:255"},
		groups = i == 0 and {cracky = 2,} or {cracky = 2,not_in_creative_inventory = 1,},
		description = i == 0 and "True-Color RGB Lightstone" or "True-Color RGB Lightstone (lit state - you hacker you!)",
		light_source = i,
		drop = "rgblightstone:rgblightstone_truecolor_0",
		_digistuff_channelcopier_fieldname = "channel",
		_digistuff_channelcopier_onset = function(pos)
			minetest.get_meta(pos):set_string("infotext","")
		end,
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", "size[8,5;]field[1,1;6,2;channel;Channel;${channel}]field[1,2;2,2;addrx;X Address;${addrx}]field[5,2;2,2;addry;Y Address;${addry}]button_exit[2.25,3;3,1;submit;Save]button_exit[2.25,4;3,1;autofill;Auto-Fill From Node Above]label[3,2;Leave address blank\nfor individual mode]")
			meta:set_string("infotext","Not configured! Right-click to set up manually, or punch to auto-fill from the node above.")
			meta:set_string("color","000000")
			rgblightstone.update_entity(pos)
		end,
		on_punch = function(pos,node,player,pointed_thing)
			rgblightstone.autofill(pos,player)
		end,
		after_destruct = function(pos)
			local objs = minetest.get_objects_inside_radius(pos,0.5)
			for _,obj in ipairs(objs) do
				if obj:get_luaentity() and obj:get_luaentity().name == "rgblightstone:entity" then
					obj:remove()
				end
			end
		end,
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {{-0.45,-0.45,-0.45,0.45,0.45,0.45}}
		},
		collision_box = {
			type = "fixed",
			fixed = {{-0.5,-0.5,-0.5,0.5,0.5,0.5}}
		},
		selection_box = {
			type = "fixed",
			fixed = {{-0.5,-0.5,-0.5,0.5,0.5,0.5}}
		},
		on_receive_fields = rgblightstone.handle_fields,
		light_source = 0,
		digiline = {
			wire = {
				rules = {
					{x = 1,y = 0,z = 0},
					{x = -1,y = 0,z = 0},
					{x = 0,y = 0,z = 1},
					{x = 0,y = 0,z = -1},
					{x = 0,y = 1,z = 0},
					{x = 0,y = -1,z = 0},
				},
			},
			receptor = {},
			effector = {
				action = function(pos,node,channel,msg)
					rgblightstone.handle_digilines(pos,node,channel,msg,true)
				end
			}
		}
	})
end

local tclist = {}
for i=0,14,1 do table.insert(tclist,"rgblightstone:rgblightstone_truecolor_"..i) end

minetest.register_lbm({
	name = "rgblightstone:restore_entities",
	label = "Restore true-color rgblightstone entities",
	nodenames = tclist,
	run_at_every_load = true,
	action = rgblightstone.update_entity,
})

minetest.register_alias("rgblightstone:rgblightstone","rgblightstone:rgblightstone_0")
minetest.register_alias("rgblightstone:rgblightstone_truecolor","rgblightstone:rgblightstone_truecolor_0")


minetest.register_craft({
	output = "rgblightstone:rgblightstone_0",
	recipe = {
		{"","mesecons_lightstone:lightstone_green_off",""},
		{"mesecons_lightstone:lightstone_red_off","mesecons_luacontroller:luacontroller0000","mesecons_lightstone:lightstone_blue_off"},
		{"","digilines:wire_std_00000000",""}
	}
})

minetest.register_craft({
	output = "rgblightstone:rgblightstone_truecolor_0",
	recipe = {
		{"","rgblightstone:rgblightstone_0",""},
		{"rgblightstone:rgblightstone_0","mesecons_luacontroller:luacontroller0000","rgblightstone:rgblightstone_0"},
		{"","digilines:wire_std_00000000",""}
	}
})
