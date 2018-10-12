local function removeEntity(pos)
	local entitiesNearby = minetest.get_objects_inside_radius(pos,0.5)
	for _,i in pairs(entitiesNearby) do
		if i:get_luaentity() and i:get_luaentity().name == "digidisplay:text" then
			i:remove()
		end
	end
end

local function generateTexture(fsize,text)
	local defTiny = {lines = 20,lineLen = 32,size = 256,margin = 4}
	local defSmall = {lines = 10,lineLen = 16,size = 128,margin = 4}
	local defMedium = {lines = 5,lineLen = 8,size = 64,margin = 4}
	local defLarge = {lines = 2,lineLen = 4,size = 32,margin = 4}
	local defHuge = {lines = 1,lineLen = 2,size = 16,margin = 2}
	local ddef
	if fsize == "tiny" then ddef = defTiny
	elseif fsize == "small" then ddef = defSmall
	elseif fsize == "medium" then ddef = defMedium
	elseif fsize == "large" then ddef = defLarge
	elseif fsize == "huge" then ddef = defHuge end
	if text == "" or not ddef then return "digidisplay_20.png" end
	local out = string.format("[combine:%dx%d",ddef.size,ddef.size)
	local line = 0
	local pos = 0
	local full = false
	for i=1,string.len(text),1 do
		local char = string.byte(string.sub(text,i,i))
		if char == 0xA then
			pos = 0
			line = line + 1
			if line >= ddef.lines then full = true end
		elseif not full then
			if char < 0x20 or char > 0x7A then
				char = 0x3F
			end
			out = out..string.format(":%d,%d=digidisplay_%02x.png",pos*7+ddef.margin,line*12+ddef.margin,char)
			pos = pos+1
			if pos >= ddef.lineLen then
				pos = 0
				line = line + 1
			end
			if line >= ddef.lines then
				full = true
			end
		end
	end
	return out
end

local function updateDisplay(pos)
	removeEntity(pos)
	local meta = minetest.get_meta(pos)
	local text = meta:get_string("text")
	local entity = minetest.add_entity(pos,"digidisplay:text")
	local nname = minetest.get_node(pos).name
	local fdir = minetest.facedir_to_dir(minetest.get_node(pos).param2)
	local etex = ""
	if nname == "digidisplay:tiny" then
		etex = generateTexture("tiny",text)
	elseif nname == "digidisplay:small" then
		etex = generateTexture("small",text)
	elseif nname == "digidisplay:medium" then
		etex = generateTexture("medium",text)
	elseif nname == "digidisplay:large" then
		etex = generateTexture("large",text)
	elseif nname == "digidisplay:huge" then
		etex = generateTexture("huge",text)
	else
		return
	end
	entity:set_properties({textures={etex}})
	entity:set_yaw((fdir.x ~= 0) and math.pi/2 or 0)
	entity:setpos(vector.add(pos,vector.multiply(fdir,0.39)))
end

minetest.register_entity("digidisplay:text",{
	initial_properties = {
		visual = "upright_sprite",
		physical = false,
		collisionbox = {0,0,0,0,0,0,},
		textures = {"digidisplay_20.png",},
	},
})

for _,i in pairs({"tiny","small","medium","large","huge"}) do
	minetest.register_node(string.format("digidisplay:%s",i),{
		description = string.format("Digilines Display (%s font)",i),
		tiles = {"digidisplay_bg.png",},
		groups = {cracky=3,digidisplay_lbm=1},
		paramtype = "light",
		paramtype2 = "facedir",
		on_rotate = screwdriver and screwdriver.rotate_simple,
		drawtype = "nodebox",
		inventory_image = string.format("digidisplay_inventory_%s.png",i),
		node_box = {
			type = "fixed",
			fixed = {-0.5,-0.5,0.4,0.5,0.5,0.5},
		},
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec","field[channel;Channel;${channel}]")
		end,
		on_destruct = removeEntity,
		on_receive_fields = function(pos,_,fields,sender)
			local name = sender:get_player_name()
			if not fields.channel then return end
			if minetest.is_protected(pos,name) and not minetest.check_player_privs(name,"protection_bypass") then
				minetest.record_protection_violation(pos,name)
				return
			end
			local meta = minetest.get_meta(pos)
			meta:set_string("channel",fields.channel)
		end,
		digiline = {
			wire = {
				rules = digiline.rules.default,
			},
			effector = {
				action = function(pos,_,channel,msg)
					local meta = minetest.get_meta(pos)
					local setchan = meta:get_string("channel")
					if type(msg) ~= "string" or setchan ~= channel then return end
					meta:set_string("text",msg)
					updateDisplay(pos)
				end,
			},
		},
	})
end

minetest.register_lbm({
	name = "digidisplay:respawn",
	label = "Respawn entities",
	nodenames = {"group:digidisplay_lbm"},
	run_at_every_load = true,
	action = updateDisplay,
})

minetest.register_craft({
	output = "digidisplay:medium",
	recipe = {
		{"mesecons_lightstone:lightstone_orange_off","mesecons_lightstone:lightstone_orange_off","mesecons_lightstone:lightstone_orange_off",},
		{"mesecons_lightstone:lightstone_orange_off","digilines:wire_std_00000000","mesecons_lightstone:lightstone_orange_off",},
		{"mesecons_lightstone:lightstone_orange_off","mesecons_lightstone:lightstone_orange_off","mesecons_lightstone:lightstone_orange_off",},
	},
})

local shapelessCrafts = {
	["digidisplay:small 2"] = {"digidisplay:tiny"},
	["digidisplay:medium 2"] = {"digidisplay:small"},
	["digidisplay:large 2"] = {"digidisplay:medium"},
	["digidisplay:huge 2"] = {"digidisplay:large"},
	["digidisplay:large"] = {"digidisplay:huge","digidisplay:huge"},
	["digidisplay:medium"] = {"digidisplay:large","digidisplay:large"},
	["digidisplay:small"] = {"digidisplay:medium","digidisplay:medium"},
	["digidisplay:tiny"] = {"digidisplay:small","digidisplay:small"},
}

for k,v in pairs(shapelessCrafts) do
	minetest.register_craft({
		type = "shapeless",
		output = k,
		recipe = v,
	})
end
