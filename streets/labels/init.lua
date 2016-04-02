--[[
	StreetsMod: All kinds of asphalt with labels
]]

streets.register_label = function(friendlyname,name,tex,craft)
	minetest.register_node(":streets:mark_"..name,{
		description = streets.S("Marking Overlay: "..friendlyname),
		tiles = {tex,"streets_rw_transparent.png"},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = {snappy = 3,attached_node = 1,oddly_breakable_by_hand = 1},
		sunlight_propagates = true,
		walkable = false,
		inventory_image = tex,
		wield_image = tex,
		after_place_node = function(pos)
			local node = minetest.get_node(pos)
			local lower_pos = {x = pos.x, y = pos.y-1, z = pos.z}
			local lower_node = minetest.get_node(lower_pos)
			if lower_node.name == "streets:asphalt" then
				lower_node.name = "streets:mark_"..(node.name:sub(14)).."_on_asphalt"
				lower_node.param2 = node.param2
				minetest.set_node(lower_pos,lower_node)
				minetest.remove_node(pos)
			end
		end,				
		node_box = {
			type = "fixed",
			fixed = {-0.5,-0.5,-0.5,0.5,-0.499,0.5}
		},
		selection_box = {
			type = "fixed",
			fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+1/16, 1/2}
		}
	})

	minetest.register_node(":streets:mark_"..name.."_on_asphalt",{
		description = streets.S("Asphalt With Marking: "..friendlyname),
		groups = {cracky=3},
		tiles = {"streets_asphalt.png^"..tex,"streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^"..tex.."^[transformR180","streets_asphalt.png^"..tex},
		paramtype2 = "facedir"
	})

	minetest.register_craft({
		output = "streets:mark_"..name.."_on_asphalt",
		type = "shapeless",
		recipe = {"streets:asphalt","streets:mark_"..name}
	})

	minetest.register_craft({
		output = "streets:mark_"..name.." 6",
		recipe = craft
	})
	if minetest.get_modpath("moreblocks") then
		stairsplus:register_all("streets", name, "streets:mark_"..name.."_on_asphalt", {
			description = "Asphalt with Marking: "..friendlyname,
			tiles = {"streets_asphalt.png^"..tex,"streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^"..tex.."^[transformR180","streets_asphalt.png^"..tex},
			groups = {cracky=3}
		})
	end
end


--White Markings
streets.register_label("Solid White Side Line","solid_white_side_line","streets_asphalt_side.png",{
		{"","",""},
		{"","",""},
		{"dye:white","dye:white","dye:white"}
	})

minetest.register_alias("streets:asphalt_side","streets:mark_solid_white_side_line_on_asphalt")
minetest.register_alias("streets:asphalt_sideline","streets:mark_solid_white_side_line_on_asphalt")

streets.register_label("Solid White Side Line (rotated)","solid_white_side_line_rotated","streets_asphalt_side.png^[transformR180",{{"streets:mark_solid_white_side_line"}})

minetest.register_alias("streets:asphalt_sideline_r","streets:mark_solid_white_side_line_rotated_on_asphalt")


streets.register_label("Solid White Center Line","solid_white_center_line","streets_asphalt_solid_line.png",{
		{"","dye:white",""},
		{"","dye:white",""},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_middle","streets:mark_solid_white_center_line_on_asphalt")
minetest.register_alias("streets:asphalt_solid_line","streets:mark_solid_white_center_line_on_asphalt")


streets.register_label("Dashed White Center Line","dashed_white_center_line","streets_asphalt_dashed_line.png",{
		{"","dye:white",""},
		{"","",""},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_middle_dashed","streets:mark_dashed_white_center_line_on_asphalt")
minetest.register_alias("streets:asphalt_dashed_line","streets:mark_dashed_white_center_line_on_asphalt")


streets.register_label("Solid White Side Line (corner)","solid_white_side_line_corner","streets_asphalt_outer_edge.png",{
		{"dye:white","dye:white","dye:white"},
		{"dye:white","",""},
		{"dye:white","",""}
	})

minetest.register_alias("streets:asphalt_outer_edge","streets:mark_solid_white_side_line_corner_on_asphalt")


streets.register_label("Solid White Side Line (corner, rotated)","solid_white_side_line_corner_rotated","streets_asphalt_outer_edge.png^[transformR270",{{"streets:mark_solid_white_line_corner"}})

minetest.register_alias("streets:asphalt_outer_edge_r","streets:mark_solid_white_side_line_corner_rotated_on_asphalt")


streets.register_label("Parking (white)","white_parking","streets_parking.png",{
		{"","dye:white","dye:white"},
		{"","dye:white","dye:white"},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_parking","streets:mark_white_parking_on_asphalt")


streets.register_label("White Arrow (straight)","white_arrow_straight","streets_arrow_straight.png",{
		{"","",""},
		{"","dye:white",""},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_arrow_straight","streets:mark_white_arrow_straight_on_asphalt")


streets.register_label("White Arrow (left)","white_arrow_left","streets_arrow_left.png",{
		{"","",""},
		{"dye:white","dye:white",""},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_arrow_left","streets:mark_white_arrow_left_on_asphalt")


streets.register_label("White Arrow (right)","white_arrow_right","streets_arrow_right.png",{
		{"","",""},
		{"","dye:white","dye:white"},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_arrow_right","streets:mark_white_arrow_right_on_asphalt")


streets.register_label("White Arrow (left+straight)","white_arrow_left_straight","streets_arrow_straight_left.png",{
		{"","dye:white",""},
		{"dye:white","dye:white",""},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_arrow_straight_left","streets:mark_white_arrow_left_straight_on_asphalt")


streets.register_label("White Arrow (straight+right)","white_arrow_straight_right","streets_arrow_straight_right.png",{
		{"","dye:white",""},
		{"","dye:white","dye:white"},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_arrow_straight_right","streets:mark_white_arrow_straight_right_on_asphalt")


streets.register_label("White Arrow (left+straight+right)","white_arrow_left_straight_right","streets_arrow_alldirs.png",{
		{"","dye:white",""},
		{"dye:white","dye:white","dye:white"},
		{"","dye:white",""}
	})

minetest.register_alias("streets:asphalt_arrow_alldirs","streets:mark_white_arrow_left_straight_right_on_asphalt")


--Yellow streetsmod markings

streets.register_label("Solid Yellow Center Line","solid_yellow_center_line","streets_rw_solid_line.png",{
		{"","dye:yellow",""},
		{"","dye:yellow",""},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_asphalt_solid","streets:mark_solid_yellow_center_line")


streets.register_label("Dashed Yellow Center Line","dashed_yellow_center_line","streets_rw_dashed_line.png",{
		{"","dye:yellow",""},
		{"","",""},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_asphalt_dashed","streets:mark_dashed_yellow_center_line")


streets.register_label("Yellow X","yellow_x","streets_rw_cross.png",{
		{"dye:yellow","","dye:yellow"},
		{"","dye:yellow",""},
		{"dye:yellow","","dye:yellow"}
	})

minetest.register_alias("streets:rw_cross","streets:mark_yellow_x")


streets.register_label("Solid Yellow Side Line (corner)","solid_yellow_side_line_corner","streets_rw_outer_edge.png",{
		{"dye:yellow","dye:yellow","dye:yellow"},
		{"dye:yellow","",""},
		{"dye:yellow","",""}
	})

minetest.register_alias("streets:rw_outer_edge","streets:solid_yellow_side_line_corner")


streets.register_label("Solid Yellow Side Line (corner,rotated)","solid_yellow_side_line_corner_rotated","streets_rw_outer_edge.png^[transformR270",{{"streets:mark_solid_yellow_side_line_corner"}})

minetest.register_alias("streets:rw_outer_edge","streets:solid_yellow_side_line_corner")


streets.register_label("Parking (yellow)","yellow_parking","streets_rw_parking.png",{
		{"","dye:yellow","dye:yellow"},
		{"","dye:yellow","dye:yellow"},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_parking","streets:mark_yellow_parking")


streets.register_label("Yellow Arrow (straight)","yellow_arrow_straight","streets_rw_arrow_straight.png",{
		{"","",""},
		{"","dye:yellow",""},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_straight","streets:mark_yellow_arrow_straight")


streets.register_label("Yellow Arrow (left)","yellow_arrow_left","streets_rw_arrow_left.png",{
		{"","",""},
		{"dye:yellow","dye:yellow",""},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_left","streets:mark_yellow_arrow_left")


streets.register_label("Yellow Arrow (right)","yellow_arrow_right","streets_rw_arrow_right.png",{
		{"","",""},
		{"","dye:yellow","dye:yellow"},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_right","streets:mark_yellow_arrow_right")


streets.register_label("Yellow Arrow (left+straight)","yellow_arrow_left_straight","streets_rw_arrow_straight_left.png",{
		{"","dye:yellow",""},
		{"dye:yellow","dye:yellow",""},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_straight_left","streets:mark_yellow_arrow_left_straight")


streets.register_label("Yellow Arrow (straight+right)","yellow_arrow_straight_right","streets_rw_arrow_straight_right.png",{
		{"","dye:yellow",""},
		{"","dye:yellow","dye:yellow"},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_straight_right","streets:mark_yellow_arrow_straight_right")


streets.register_label("Yellow Arrow (left+straight+right)","yellow_arrow_left_straight_right","streets_rw_arrow_alldirs.png",{
		{"","dye:yellow",""},
		{"dye:yellow","dye:yellow","dye:yellow"},
		{"","dye:yellow",""}
	})

minetest.register_alias("streets:rw_alldirs","streets:mark_yellow_arrow_left_straight_right")

streets.register_label("Solid Yellow Side Line","solid_yellow_side_line","streets_rw_asphalt_side.png",{
		{"dye:yellow","",""},
		{"dye:yellow","",""},
		{"dye:yellow","",""}
	})

minetest.register_alias("streets:rw_sideline","streets:mark_solid_yellow_side_line")

streets.register_label("Solid Yellow Side Line (rotated)","solid_yellow_side_line_rotated","streets_rw_asphalt_side.png^[transformR180",{{"streets:mark_solid_yellow_side_line"}})


--Infrastructure markings

streets.register_label("Solid Yellow Center Line (wide)","solid_yellow_center_line_wide","infrastructure_single_yellow_line.png",{
		{"","",""},
		{"dye:yellow","dye:yellow","dye:yellow"},
		{"","",""}
	})

minetest.register_alias("infrastructure:asphalt_center_solid_line","streets:mark_solid_yellow_center_line_wide_on_asphalt")


streets.register_label("Solid Yellow Center Line (wide,offset)","solid_yellow_center_line_wide_offset","infrastructure_solid_yellow_line_one_side.png",{
		{"","",""},
		{"","",""},
		{"dye:yellow","dye:yellow","dye:yellow"}
	})

minetest.register_alias("infrastructure:asphalt_center_solid_one_side","streets:mark_solid_yellow_center_line_wide_offset_on_asphalt")


streets.register_label("Double Yellow Center Line (wide)","double_yellow_center_line_wide","infrastructure_double_yellow_line.png",{
		{"dye:yellow","dye:yellow","dye:yellow"},
		{"","",""},
		{"dye:yellow","dye:yellow","dye:yellow"}
	})

minetest.register_alias("infrastructure:asphalt_center_solid_double","streets:mark_double_yellow_center_line_wide_on_asphalt")


streets.register_label("Solid Yellow Center Line (wide,corner)","solid_yellow_center_line_wide_corner","infrastructure_single_yellow_line_corner.png",{
		{"","dye:yellow","dye:yellow"},
		{"","dye:yellow",""},
		{"","dye:yellow",""}
	})

minetest.register_alias("infrastructure:asphalt_center_corner_single","streets:mark_solid_yellow_center_line_wide_corner_on_asphalt")


streets.register_label("Double Yellow Center Line (wide,corner)","double_yellow_center_line_wide_corner","infrastructure_solid_double_yellow_line_corner.png",{
		{"dye:yellow","dye:yellow","dye:yellow"},
		{"dye:yellow","",""},
		{"dye:yellow","","dye:yellow"}
	})

minetest.register_alias("infrastructure:asphalt_center_corner_double","streets:mark_double_yellow_center_line_wide_corner_on_asphalt")


minetest.register_alias("infrastructure:asphalt_arrow_straight", "streets:asphalt_arrow_straight")


minetest.register_alias("infrastructure:asphalt_arrow_straight_left", "streets:asphalt_arrow_straight_left")


minetest.register_alias("infrastructure:asphalt_arrow_straight_right", "streets:asphalt_arrow_straight_left")


minetest.register_alias("infrastructure:asphalt_arrow_left", "streets:asphalt_arrow_left")


minetest.register_alias("infrastructure:asphalt_arrow_right", "streets:asphalt_arrow_right")


minetest.register_alias("infrastructure:asphalt_parking", "streets:asphalt_parking")
