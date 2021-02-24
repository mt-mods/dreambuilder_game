local fdir_to_right = {
	{  1,  0 },
	{  0, -1 },
	{ -1,  0 },
	{  0,  1 }
}

--digilines compatibility

local rules_alldir = {
	{x =  0, y =  0, z = -1},  -- borrowed from lightstones
	{x =  1, y =  0, z =  0},
	{x = -1, y =  0, z =  0},
	{x =  0, y =  0, z =  1},
	{x =  1, y =  1, z =  0},
	{x =  1, y = -1, z =  0},
	{x = -1, y =  1, z =  0},
	{x = -1, y = -1, z =  0},
	{x =  0, y =  1, z =  1},
	{x =  0, y = -1, z =  1},
	{x =  0, y =  1, z = -1},
	{x =  0, y = -1, z = -1},
	{x =  0, y = -1, z =  0},
}

local enable_digilines = minetest.get_modpath("digilines")

ilights.player_channels = {} -- last light source channel name that was set by a given player

if enable_digilines then

	minetest.register_on_player_receive_fields(function(player, formname, fields)
		if not player then return end
		if fields.channel and fields.channel ~= "" and formname == "simple_streetlights:set_channel" then
			local playername = player:get_player_name()
			minetest.chat_send_player(playername, "*** The light source on all streetlights placed from now on will have the channel set to \""..fields.channel.."\"")
			ilights.player_channels[playername] = fields.channel
		end
	end)

	function ilights.digiline_on_use(itemstack, user, pointed_thing)
		if user and user:get_player_control().sneak then
			local name = user:get_player_name()
			local form = "field[channel;Set a channel for future streetlights;]"
			minetest.show_formspec(name, "simple_streetlights:set_channel", form)
		end
	end
end

local digiline_wire_node = "digilines:wire_std_00000000"

minetest.register_privilege("streetlight", {
	description = "Allows using streetlight spawners",
	give_to_singleplayer = true
})

local function check_and_place(itemstack, placer, pointed_thing, pole, light, param2, needs_digiline_wire, distributor_node)
	local controls = placer:get_player_control()
	if not placer then return end
	local playername = placer:get_player_name()

	local player_name = placer:get_player_name()
	local fdir = minetest.dir_to_facedir(placer:get_look_dir())

	local pos1 = minetest.get_pointed_thing_position(pointed_thing)
	local node1 = minetest.get_node(pos1)
	if not node1 or node1.name == "ignore" then return end
	local def1 = minetest.registered_items[node1.name]

	if (def1 and def1.buildable_to) then
		pos1.y = pos1.y-1
	end

	local rc = streetlights.rightclick_pointed_thing(pos1, placer, itemstack, pointed_thing)
	if rc then return rc end

	if not minetest.check_player_privs(placer, "streetlight") then
		minetest.chat_send_player(playername, "*** You don't have permission to use a streetlight spawner.")
		return
	end

	local node1 = minetest.get_node(pos1)

	local node2, node3, node4
	local def1 = minetest.registered_items[node1.name]
	local def2, def3, def4

	local pos2, pos3, pos4
	for i = 1, 5 do
		pos2 = { x=pos1.x, y = pos1.y+i, z=pos1.z }
		node2 = minetest.get_node(pos2)
		def2 = minetest.registered_items[node2.name]
		if minetest.is_protected(pos2, player_name) or not (def2 and def2.buildable_to) then return end
	end

	pos3 = { x = pos1.x+fdir_to_right[fdir+1][1], y = pos1.y+5, z = pos1.z+fdir_to_right[fdir+1][2] }
	node3 = minetest.get_node(pos3)
	def3 = minetest.registered_items[node3.name]
	if minetest.is_protected(pos3, player_name) or not (def3 and def3.buildable_to) then return end

	pos4 = { x = pos1.x+fdir_to_right[fdir+1][1], y = pos1.y+4, z = pos1.z+fdir_to_right[fdir+1][2] }
	node4 = minetest.get_node(pos4)
	def4 = minetest.registered_items[node4.name]

	local pos0 = { x = pos1.x, y = pos1.y-1, z = pos1.z }

	if minetest.is_protected(pos4, player_name) or not (def3 and def4.buildable_to) then return end

	if controls.sneak and minetest.is_protected(pos1, player_name) then return end
	if distributor_node and minetest.is_protected(pos0, player_name) then return end

	if not creative.is_enabled_for(player_name) then
		local inv = placer:get_inventory()
		if not inv:contains_item("main", pole.." 6") then
			minetest.chat_send_player(playername, "*** You don't have enough "..pole.." in your inventory!")
			return
		end

		if not inv:contains_item("main", light) then
			minetest.chat_send_player(playername, "*** You don't have any "..light.." in your inventory!")
			return
		end

		if needs_digiline_wire and not inv:contains_item("main", digiline_wire_node.." 6") then
			minetest.chat_send_player(playername, "*** You don't have enough Digiline wires in your inventory!")
			return
		end

		if controls.sneak then
			if not inv:contains_item("main", streetlights.concrete) then
				minetest.chat_send_player(playername, "*** You don't have any concrete in your inventory!")
				return
			else
				inv:remove_item("main", streetlights.concrete)
			end
		end

		if distributor_node and needs_digiline_wire then
			if not inv:contains_item("main", distributor_node) then
				minetest.chat_send_player(playername, "*** You don't have any "..distributor_node.." in your inventory!")
				return
			else
				inv:remove_item("main", distributor_node)
			end
		end

		inv:remove_item("main", pole.." 6")
		inv:remove_item("main", light)

		if needs_digiline_wire then
			inv:remove_item("main", digiline_wire_node.." 6")
		end

	end

	if controls.sneak then
		minetest.set_node(pos1, { name = streetlights.concrete })
	end

	local pole2 = pole
	if needs_digiline_wire then
		pole2 = pole.."_digilines"
	end

	for i = 1, 5 do
		pos2 = {x=pos1.x, y = pos1.y+i, z=pos1.z}
		minetest.set_node(pos2, {name = pole2 })
	end

	minetest.set_node(pos3, { name = pole2 })
	minetest.set_node(pos4, { name = light, param2 = param2 })

	if needs_digiline_wire and ilights.player_channels[playername] then
		minetest.get_meta(pos4):set_string("channel", ilights.player_channels[playername])
	end

	if distributor_node and needs_digiline_wire then
		minetest.set_node(pos0, { name = distributor_node })
		digilines.update_autoconnect(pos0)
	end

end

local poles_tab = {
--    material name,  mod name,           node name
	{ "wood",         "default",          "default:fence_wood" },
	{ "junglewood",   "default",          "default:fence_junglewood" },
	{ "brass",        "homedecor_fences", "homedecor:fence_brass" },
	{ "wrought_iron", "homedecor_fences", "homedecor:fence_wrought_iron" },
	{ "steel",        "gloopblocks",      "gloopblocks:fence_steel" }
}

local lights_tab = {
--    light name,       mod name,             node name,                      optional param2
	{ "meselamp",       "default",            "default:meselamp" },
	{ "ilight",         "ilights",            "ilights:light" },
	{ "glowlight_cube", "homedecor_lighting", "homedecor:glowlight_small_cube" }
}

for _, pole in ipairs(poles_tab) do
	local matname = pole[1]
	local matmod =  pole[2]
	local matnode = pole[3]

	if minetest.get_modpath(matmod) then

		for _, light in ipairs(lights_tab) do
			local lightname =   light[1]
			local lightmod =    light[2]
			local lightnode =   light[3]
			local lightparam2 = light[4] or 0

			if enable_digilines then
				local def = table.copy(minetest.registered_nodes[matnode])
				local dl_overlay

				if def.drawtype == "fencelike" then
					dl_overlay = "simple_streetlights_pole_digiline_overlay_fl.png"
				else
					dl_overlay = "simple_streetlights_pole_digiline_overlay_cnb.png"
				end

				for i,t in ipairs(def.tiles) do
					def.tiles[i] = t.."^"..dl_overlay
				end
				def.description = def.description.." (digilines conducting)"
				def.digiline = {
					wire = {
						rules = {
							{x= 0, y= 0, z=-1},
							{x= 0, y= 0, z= 1},
							{x= 1, y= 0, z= 0},
							{x=-1, y= 0, z= 0},
							{x= 0, y=-1, z= 0},
							{x= 0, y= 1, z= 0},
							{x= 0, y=-2, z= 0}
						}
					}
				}
				def.drop = {
					items = {
						{items = { matnode.."_digilines" } },
					}
				}
				def.palette = nil                      -- if the coloredwood mod exists and loads first, it'll create these
				def.groups.ud_param2_colorable = nil   -- settings, which we don't want in the cloned node.

				minetest.register_node(":"..matnode.."_digilines", def)

				minetest.register_craft({
					output = matnode.."_digilines",
					type = "shapeless",
					recipe = {
						matnode,
						digiline_wire_node,
					}
				})
			end

			if minetest.get_modpath(lightmod) then

				minetest.register_tool("simple_streetlights:spawner_"..matname.."_"..lightname, {
					description = "Streetlight spawner ("..matname.." pole, "..lightname..")",
					inventory_image = "simple_streetlights_inv_pole_"..matname..".png"..
					                  "^simple_streetlights_inv_light_source_"..lightname..".png",
					use_texture_alpha = true,
					tool_capabilities = { full_punch_interval=0.1 },
					on_place = function(itemstack, placer, pointed_thing)
						check_and_place(itemstack, placer, pointed_thing, matnode, lightnode, lightparam2)
					end
				})

				minetest.register_craft({
					output = "simple_streetlights:spawner_"..matname.."_"..lightname,
					type = "shapeless",
					recipe = {
						matnode,
						matnode,
						matnode,
						matnode,
						matnode,
						matnode,
						lightnode
					}
				})

				if enable_digilines and minetest.registered_nodes[lightnode].digiline then

					minetest.register_tool("simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines", {
						description = "Streetlight spawner ("..matname.." pole, with "..lightname..", digilines conducting pole)",
						inventory_image = "simple_streetlights_inv_pole_"..matname..".png"..
										  "^simple_streetlights_inv_pole_digiline_overlay.png"..
										  "^simple_streetlights_inv_light_source_"..lightname..".png",
						use_texture_alpha = true,
						tool_capabilities = { full_punch_interval=0.1 },
						on_place = function(itemstack, placer, pointed_thing)
							check_and_place(itemstack, placer, pointed_thing, matnode, lightnode, lightparam2, true)
						end,
						on_use = ilights.digiline_on_use
					})

					minetest.register_craft({
						output = "simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines",
						type = "shapeless",
						recipe = {
							matnode,
							matnode,
							matnode,
							matnode,
							matnode,
							matnode,
							lightnode,
							digiline_wire_node,
						}
					})

					minetest.register_craft({
						output = "simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines",
						type = "shapeless",
						recipe = {
							"simple_streetlights:spawner_"..matname.."_"..lightname,
							digiline_wire_node
						}
					})

					local distributor = nil
					local dist_overlay = nil

					if minetest.registered_items[streetlights.distributor] then
						distributor = streetlights.distributor
						dist_overlay = "^simple_streetlights_inv_pole_distributor_overlay.png"
					elseif minetest.registered_items[streetlights.vert_digiline] then
						distributor = streetlights.vert_digiline
						dist_overlay = "^simple_streetlights_inv_pole_vertical_digiline_overlay.png"
					end

					if distributor then
						minetest.register_tool("simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines_distributor", {
							description = "Streetlight spawner ("..matname.." pole, with "..lightname..", digilines conducting pole, with distributor 2m below)",
							inventory_image = "simple_streetlights_inv_pole_"..matname..".png"..
											  "^simple_streetlights_inv_pole_digiline_overlay.png"..
											  dist_overlay..
											  "^simple_streetlights_inv_light_source_"..lightname..".png",
							use_texture_alpha = true,
							tool_capabilities = { full_punch_interval=0.1 },
							on_place = function(itemstack, placer, pointed_thing)
								check_and_place(itemstack, placer, pointed_thing, matnode, lightnode, lightparam2, true, distributor)
							end,
							on_use = ilights.digiline_on_use
						})

						minetest.register_craft({
							output = "simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines_distributor",
							type = "shapeless",
							recipe = {
								matnode,
								matnode,
								matnode,
								matnode,
								matnode,
								matnode,
								lightnode,
								digiline_wire_node,
								distributor
							}
						})

						minetest.register_craft({
							output = "simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines_distributor",
							type = "shapeless",
							recipe = {
								"simple_streetlights:spawner_"..matname.."_"..lightname,
								digiline_wire_node,
								distributor
							}
						})

						minetest.register_craft({
							output = "simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines_distributor",
							type = "shapeless",
							recipe = {
								"simple_streetlights:spawner_"..matname.."_"..lightname.."_digilines",
								distributor
							}
						})
					end
				end
			end
		end
	end
end
