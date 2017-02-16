local modes = {
	{
		name = "off",
		desc = "Off",
		texture = "arrowboards_bg.png^arrowboards_off.png",
	},
	{
		name = "flashing_arrow_right",
		desc = "Flashing Right Arrow",
		texture = {
			name = "[combine:64x128:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_arrow3.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.5},
		},
	},
	{
		name = "flashing_arrow_left",
		desc = "Flashing Left Arrow",
		texture = {
			name = "[combine:64x128:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_arrow3.png^[transformFX",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.5},
		},
	},
	{
		name = "flashing_arrow_dual",
		desc = "Flashing Dual Arrow",
		texture = {
			name = "[combine:64x128:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_dualarrow.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.5},
		},
	},
	{
		name = "seq_arrow_right",
		desc = "Sequential Right Arrow",
		texture = {
			name = "[combine:64x256:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_arrow1.png:0,128=arrowboards_bg.png:0,128=arrowboards_arrow2.png:0,192=arrowboards_bg.png:0,192=arrowboards_arrow3.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 3},
		},
	},
	{
		name = "seq_arrow_left",
		desc = "Sequential Left Arrow",
		texture = {
			name = "[combine:64x256:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_arrow1.png:0,128=arrowboards_bg.png:0,128=arrowboards_arrow2.png:0,192=arrowboards_bg.png:0,192=arrowboards_arrow3.png^[transformFX",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 3},
		},
	},
	{
		name = "seq_chevron_right",
		desc = "Sequential Right Chevron",
		texture = {
			name = "[combine:64x256:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_chevron1.png:0,128=arrowboards_bg.png:0,128=arrowboards_chevron2.png:0,192=arrowboards_bg.png:0,192=arrowboards_chevron3.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 3},
		},
	},
	{
		name = "seq_chevron_left",
		desc = "Sequential Left Chevron",
		texture = {
			name = "[combine:64x256:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_chevron1.png:0,128=arrowboards_bg.png:0,128=arrowboards_chevron2.png:0,192=arrowboards_bg.png:0,192=arrowboards_chevron3.png^[transformFX",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 3},
		},
	},
	{
		name = "flashing_caution_corners",
		desc = "Flashing Caution (four corners)",
		texture = {
			name = "[combine:64x128:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_caution1.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.5},
		},
	},
	{
		name = "flashing_caution_line",
		desc = "Flashing Caution (horizontal line)",
		texture = {
			name = "[combine:64x128:0,0=arrowboards_bg.png:0,0=arrowboards_off.png:0,64=arrowboards_bg.png:0,64=arrowboards_caution2.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.5},
		},
	},
	{
		name = "alternating_diamond_caution",
		desc = "Alternating Diamond Caution",
		texture = {
			name = "[combine:64x128:0,0=arrowboards_bg.png:0,0=arrowboards_caution3.png:0,64=arrowboards_bg.png:0,64=(arrowboards_caution3.png^[transformFX)",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1.5},
		},
	},
}

for k,v in ipairs(modes) do
	minetest.register_node("arrowboards:"..v.name,{
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {not_in_creative_inventory=1},
		tiles = {"arrowboards_bg.png^[transformFY","arrowboards_bg.png","arrowboards_bg.png","arrowboards_bg.png","arrowboards_bg.png",v.texture},
		drawtype = "nodebox",
		light_source = 4,
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5,-0.04,-0.5,0.5,0.5,-0.4}, --Display
				{-0.4,-0.5,-0.5,-0.3,-0.04,-0.4}, --Left Pole
				{0.4,-0.5,-0.5,0.3,-0.04,-0.4}, --Right Pole
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{0,0,0,0,0,0},
			},
		},
	})
end

minetest.register_node("arrowboards:base",{
	description = "Arrow Board",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {dig_immediate=2},
	tiles = {"arrowboards_base.png"},
	inventory_image = "arrowboards_inv.png",
	drawtype = "nodebox",
	light_source = 4,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,-0.25,0.5}, --Base
			{-0.4,-0.25,-0.5,-0.3,0.5,-0.4}, --Left Pole
			{0.4,-0.25,-0.5,0.3,0.5,-0.4}, --Right Pole
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5,-0.5,-0.5,0.5,-0.25,0.5}, --Base
			{-0.5,-0.25,-0.5,0.5,1.5,-0.4}, -- The Rest
		},
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		local fs = "size[4,1]dropdown[0,0;4;mode;"
		for _,v in ipairs(modes) do
			fs = fs..v.desc..","
		end
		fs = string.sub(fs,1,-2)
		fs = fs..";1]"
		meta:set_string("formspec",fs)
	end,
	on_receive_fields = function(pos,formname,fields,sender)
		local name = sender:get_player_name()
		if fields.quit or not fields.mode then return end
		if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,{protection_bypass=true}) then
			minetest.record_protection_violation(pos,name)
			return
		end
		for k,v in ipairs(modes) do
			if fields.mode == v.desc then
				local meta = minetest.get_meta(pos)
				local fs = "size[4,1]dropdown[0,0;4;mode;"
				for _,v in ipairs(modes) do
					fs = fs..v.desc..","
				end
				fs = string.sub(fs,1,-2)
				fs = fs..";"..k.."]"
				meta:set_string("formspec",fs)
				pos.y = pos.y + 1
				local node = minetest.get_node(pos)
				node.name = "arrowboards:"..v.name
				minetest.set_node(pos,node)
			end
		end
	end,
	--Some of this might be "borrowed" from the LTC-4000E :P
	after_place_node = function(pos,placer)
		local node = minetest.get_node(pos)
		local toppos = {x=pos.x,y=pos.y + 1,z=pos.z}
		local topnode = minetest.get_node(toppos)
		local placername = placer:get_player_name()
		if topnode.name ~= "air" then
			if placer:is_player() then
				minetest.chat_send_player(placername,"Can't place arrow board - no room for the top half!")
			end
			minetest.set_node(pos,{name="air"})
			return true
		end
		if minetest.is_protected(toppos,placername) and not minetest.check_player_privs(placername,{protection_bypass=true}) then
			if placer:is_player() then
				minetest.chat_send_player(placername,"Can't place arrow board - top half is protected!")
				minetest.record_protection_violation(toppos,placername)
			end
			minetest.set_node(pos,{name="air"})
			return true
		end
		node.name = "arrowboards:off"
		minetest.set_node(toppos,node)
	end,
	on_destruct = function(pos)
		pos.y = pos.y + 1
		if string.sub(minetest.get_node(pos).name,1,12) == "arrowboards:" then
			minetest.set_node(pos,{name="air"})
		end
	end,
	on_rotate = function(pos,node,user,mode,new_param2)
		if not screwdriver then
			return false
		end
		local ret = screwdriver.rotate_simple(pos,node,user,mode,new_param2)
		minetest.after(0,function(pos)
			local newnode = minetest.get_node(pos)
			local param2 = newnode.param2
			pos.y = pos.y + 1
			local topnode = minetest.get_node(pos)
			topnode.param2 = param2
			minetest.set_node(pos,topnode)
		end,pos)
		return ret
	end,
})

minetest.register_craft({
	output = "arrowboards:base",
	recipe = {
		{"mesecons_lightstone:lightstone_yellow_off","mesecons_luacontroller:luacontroller0000","mesecons_lightstone:lightstone_yellow_off"},
		{"mesecons_lightstone:lightstone_yellow_off","default:steel_ingot","mesecons_lightstone:lightstone_yellow_off"},
		{"default:steel_ingot","default:steel_ingot","default:steel_ingot"},
	},
})
