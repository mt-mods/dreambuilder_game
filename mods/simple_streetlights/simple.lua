-- generate the simple fence-based streetlights

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
			local form ="formspec_version[4]"..
					"size[8,4]"..
					"button_exit[3,2.5;2,0.5;proceed;Proceed]"..
					"field[1.75,1.5;4.5,0.5;channel;Channel for future streetlights;]"
			minetest.show_formspec(name, "simple_streetlights:set_channel", form)
		end
	end
end

local digiline_wire_node = "digilines:wire_std_00000000"

local poles_tab = {
--    material name,  mod name,           node name,                        optional base, optional height, top section
	{ "wood",         "default",          "default:fence_wood" },
	{ "junglewood",   "default",          "default:fence_junglewood" },
	{ "brass",        "homedecor_fences", "homedecor:fence_brass"},
	{ "wrought_iron", "homedecor_fences", "homedecor:fence_wrought_iron" },
	{ "steel",        "gloopblocks",      "gloopblocks:fence_steel"}
}

local lights_tab = {
--    light name,       mod name,             node name,                      optional param2
	{ "meselamp",       "default",            "default:meselamp" },
	{ "ilight",         "ilights",            "ilights:light" },
	{ "glowlight_cube", "homedecor_lighting", "homedecor:glowlight_small_cube" }
}

for _, pole in ipairs(poles_tab) do
	local matname  = pole[1]
	local matmod   = pole[2]
	local matnode  = pole[3]
	local basenode = pole[4]
	local height   = pole[5]
	local topnodes = pole[6]

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
						streetlights.check_and_place(itemstack, placer, pointed_thing, {
							base=basenode,
							pole=matnode,
							light=lightnode,
							param2=lightparam2,
							topnodes = topnodes,
							height = height
						})
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
							streetlights.check_and_place(itemstack, placer, pointed_thing, {
								base=basenode,
								pole=matnode,
								light=lightnode,
								param2=lightparam2,
								topnodes = topnodes,
								height = height,
								needs_digiline_wire=true
							})
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
								streetlights.check_and_place(itemstack, placer, pointed_thing, {
									base=basenode,
									pole=matnode,
									light=lightnode,
									param2=lightparam2,
									topnodes = topnodes,
									height = height,
									needs_digiline_wire=true,
									distributor_node=distributor
								})
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
