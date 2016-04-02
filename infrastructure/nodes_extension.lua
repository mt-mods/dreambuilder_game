-- **************************************************************************************************** MATERIALS

-- Galvanized steel stair, slab, panel and microblock
	register_stair_slab_panel_micro("infrastructure", "galvanized_steel", "infrastructure:galvanized_steel",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=2},
			{"infrastructure_galvanized_steel.png"},
			"Galvanized steel",
			"galvanized_steel",
			0)

-- **************************************************************************************************** CENTER LINES

-- Asphalt stair, slab, panel and microblock with center solid line
	register_stair_slab_panel_micro("infrastructure", "asphalt_center_solid_line", "infrastructure:asphalt_center_solid_line",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{
				"streets_asphalt.png^infrastructure_single_yellow_line.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			"Asphalt with center solid line",
			"asphalt_center_solid_line",
			0)

-- Asphalt stair, slab, panel and microblock with center solid line on one side
	register_stair_slab_panel_micro("infrastructure", "asphalt_center_solid_one_side", "infrastructure:asphalt_center_solid_one_side",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{
				"streets_asphalt.png^infrastructure_solid_yellow_line_one_side.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			"Asphalt with center solid line on one side",
			"asphalt_center_solid_one_side",
			0)

-- Asphalt stair, slab, panel and microblock with center solid double line
	register_stair_slab_panel_micro("infrastructure", "asphalt_center_solid_double", "infrastructure:asphalt_center_solid_double",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{
				"streets_asphalt.png^infrastructure_double_yellow_line.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			"Asphalt with center solid double line",
			"asphalt_center_solid_double",
			0)

-- Asphalt block with center corner single line
	register_stair_slab_panel_micro("infrastructure", "asphalt_center_corner_single", "infrastructure:asphalt_center_corner_single",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{
				"streets_asphalt.png^infrastructure_single_yellow_line_corner.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			"Asphalt with center corner single line",
			"asphalt_center_corner_single",
			0)

-- Asphalt block with center corner double line
	register_stair_slab_panel_micro("infrastructure", "asphalt_center_corner_double", "infrastructure:asphalt_center_corner_double",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{
				"streets_asphalt.png^infrastructure_solid_double_yellow_line_corner.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			"Asphalt with center corner double line",
			"asphalt_center_corner_double",
			0)

-- **************************************************************************************************** TRAFFIC MARKS

-- Asphalt stair, slab, panel and microblock with arrow straight
	register_stair_slab_panel_micro("infrastructure", "asphalt_arrow_straight", "infrastructure:asphalt_arrow_straight",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{"streets_arrow_straight.png", "infrastructure_asphalt.png"},
			"Asphalt with arrow straight",
			"asphalt_arrow_straight",
			0)

-- Asphalt stair, slab, panel and microblock with arrow straight + left
	register_stair_slab_panel_micro("infrastructure", "asphalt_arrow_straight_left", "infrastructure:asphalt_arrow_straight_left",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{"streets_asphalt.png^streets_arrow_straight_left.png", "infrastructure_asphalt.png"},
			"Asphalt with arrow straight + left",
			"asphalt_arrow_straight_left",
			0)

-- Asphalt stair, slab, panel and microblock with arrow straight + right
	register_stair_slab_panel_micro("infrastructure", "asphalt_arrow_straight_right", "infrastructure:asphalt_arrow_straight_right",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{"streets_asphalt.png^streets_arrow_straight_right.png", "infrastructure_asphalt.png"},
			"Asphalt with arrow straight + right",
			"asphalt_arrow_straight_right",
			0)

-- Asphalt stair, slab, panel and microblock with arrow left
	register_stair_slab_panel_micro("infrastructure", "asphalt_arrow_left", "infrastructure:asphalt_arrow_left",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{"streets_asphalt.png^streets_arrow_left.png", "infrastructure_asphalt.png"},
			"Asphalt with arrow left",
			"asphalt_arrow_left",
			0)

-- Asphalt stair, slab, panel and microblock with arrow right
	register_stair_slab_panel_micro("infrastructure", "asphalt_arrow_right", "infrastructure:asphalt_arrow_right",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{"streets_asphalt.png^streets_arrow_right.png", "infrastructure_asphalt.png"},
			"Asphalt with arrow right",
			"asphalt_arrow_right",
			0)

-- Asphalt stair, slab, panel and microblock with "P"-sign
	register_stair_slab_panel_micro("infrastructure", "asphalt_parking", "infrastructure:asphalt_parking",
			{not_in_creative_inventory=NOT_IN_CREATIVE_INVENTORY, cracky=1},
			{"streets_asphalt.png^streets_parking.png", "infrastructure_asphalt.png"},
			"Asphalt with a parking sign",
			"asphalt_parking",
			0)

-- Register known infrastructure nodes in circular saw if avaiable
	if circular_saw then
		for i,v in ipairs({
-- Materials
			"asphalt",
			"concrete",
			"galvanized_steel",
-- Center lines
			"asphalt_center_dashed",
			"asphalt_center_solid",
			"asphalt_center_solid_one_side",
			"asphalt_center_solid_double",
			"asphalt_center_corner_single",
			"asphalt_center_corner_double",
-- Traffic marks
			"asphalt_arrow_straight",
			"asphalt_arrow_straight_left",
			"asphalt_arrow_straight_right",
			"asphalt_arrow_left",
			"asphalt_arrow_right",
			"asphalt_parking"
		}) do
			table.insert(circular_saw.known_stairs, "infrastructure:"..v);
		end
	end
