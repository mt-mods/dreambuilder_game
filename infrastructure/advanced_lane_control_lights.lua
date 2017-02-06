-- Lane control lights

for i = 1, 6 do
	local groups = {}
	if i == 1 then 
		groups = {cracky = 3}
	else
		groups = {cracky = 3, not_in_creative_inventory = 1}
	end

	minetest.register_node("infrastructure:lane_control_lights_"..tostring(i), {
		description = "Lane control lights",
		tiles = {
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_traffic_lights_side.png",
			"infrastructure_lane_control_lights_"..tostring(i)..".png"
		},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		on_construct = function(pos)
			local meta = minetest.get_meta(pos)
			meta:set_string("formspec", "field[channel;Channel;${channel}]")
		end,
		groups = {cracky = 3, not_in_creative_inventory = (i == 1 and 0 or 1)},
		light_source = TRAFFIC_LIGHTS_LIGHT_RANGE,
		drop = "infrastructure:lane_control_lights_1",
		node_box = {
			type = "fixed",
				fixed = {
					{-7/16, -7/16, -1/8, 7/16, 7/16, 1/8},
					{-7/16, 0, -1/4, -3/8, 7/16, -1/8},
					{3/8, 0, -1/4, 7/16, 7/16, -1/8},
					{-7/16, 3/8, -5/16, 7/16, 7/16, -1/8},
					{-1/16, -1/4, 0, 1/16, 1/4, 1/2 - 0.001},
					{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.001},
					{-1/4, -1/16, 0, 1/4, 1/16, 1/2 - 0.001}
				}
		},
		selection_box = {
			type = "fixed",
				fixed = {
					{-7/16, -7/16, -1/8, 7/16, 7/16, 1/8},
					{-7/16, 0, -1/4, -3/8, 7/16, -1/8},
					{3/8, 0, -1/4, 7/16, 7/16, -1/8},
					{-7/16, 3/8, -5/16, 7/16, 7/16, -1/8},
					{-1/16, -1/4, 0, 1/16, 1/4, 1/2 - 0.001},
					{-1/4, -1/4, 3/8, 1/4, 1/4, 1/2 - 0.001},
					{-1/4, -1/16, 0, 1/4, 1/16, 1/2 - 0.001}
				}

		},
		on_receive_fields = function(pos, formname, fields)
			if (fields.channel) then
				minetest.get_meta(pos):set_string("channel", fields.channel)
			end
		end,
		digiline = {
			receptor = {},
			effector = {
				action = function(pos, node, channel, msg)
					local setchan = minetest.get_meta(pos):get_string("channel")
					if setchan ~= channel or type(msg) ~= "string" then
						return
					end
					msg = string.lower(msg)
					if (msg=="off") then
						node.name = "infrastructure:lane_control_lights_1"
					elseif (msg=="green") then
						node.name = "infrastructure:lane_control_lights_3"
					elseif (msg=="red") then
						node.name = "infrastructure:lane_control_lights_2"
					elseif (msg=="yellowleft") then
						node.name = "infrastructure:lane_control_lights_5"
					elseif (msg=="yellowright") then
						node.name = "infrastructure:lane_control_lights_4"
					elseif (msg=="yellow") then
						node.name = "infrastructure:lane_control_lights_6"
					end
					minetest.set_node(pos,node)
					minetest.get_meta(pos):set_string("channel",setchan)
				end
			}
		}
	})
end

minetest.register_alias("infrastructure:lane_control_lights", "infrastructure:lane_control_lights_1")
