-- **************************************************************************************************** MATERIALS

-- Galvanized steel stair, slab, panel and microblock
	stairsplus:register_all(
		"infrastructure",
		"galvanized_steel",
		"infrastructure:galvanized_steel",
		{
			groups = {not_in_creative_inventory=1, cracky=2},
			tiles = { "infrastructure_galvanized_steel.png" },
			description = "Galvanized steel",
		}
	)

-- **************************************************************************************************** CENTER LINES

-- Asphalt stair, slab, panel and microblock with center solid line
	stairsplus:register_all(
		"infrastructure",
		"asphalt_center_solid_line",
		"infrastructure:asphalt_center_solid_line",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^infrastructure_single_yellow_line.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			description = "Asphalt with center solid line",
		}
	)

-- Asphalt stair, slab, panel and microblock with center solid line on one side
	stairsplus:register_all(
		"infrastructure",
		"asphalt_center_solid_one_side",
		"infrastructure:asphalt_center_solid_one_side",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^infrastructure_solid_yellow_line_one_side.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			description = "Asphalt with center solid line on one side",
		}
	)

-- Asphalt stair, slab, panel and microblock with center solid double line
	stairsplus:register_all(
		"infrastructure",
		"asphalt_center_solid_double",
		"infrastructure:asphalt_center_solid_double",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^infrastructure_double_yellow_line.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			description = "Asphalt with center solid double line",
		}
	)

-- Asphalt block with center corner single line
	stairsplus:register_all(
		"infrastructure",
		"asphalt_center_corner_single",
		"infrastructure:asphalt_center_corner_single",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^infrastructure_single_yellow_line_corner.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			description = "Asphalt with center corner single line",
		}
	)

-- Asphalt block with center corner double line
	stairsplus:register_all(
		"infrastructure",
		"asphalt_center_corner_double",
		"infrastructure:asphalt_center_corner_double",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^infrastructure_solid_double_yellow_line_corner.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png"
			},
			description = "Asphalt with center corner double line",
		}
	)

-- **************************************************************************************************** TRAFFIC MARKS

-- Asphalt stair, slab, panel and microblock with arrow straight
	stairsplus:register_all(
		"infrastructure",
		"asphalt_arrow_straight",
		"infrastructure:asphalt_arrow_straight",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_arrow_straight.png",
				"infrastructure_asphalt.png"
			},
			description = "Asphalt with arrow straight",
		}
	)

-- Asphalt stair, slab, panel and microblock with arrow straight + left
	stairsplus:register_all(
		"infrastructure",
		"asphalt_arrow_straight_left",
		"infrastructure:asphalt_arrow_straight_left",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^streets_arrow_straight_left.png",
				"infrastructure_asphalt.png"
			},
			description = "Asphalt with arrow straight + left",
		}
	)

-- Asphalt stair, slab, panel and microblock with arrow straight + right
	stairsplus:register_all(
		"infrastructure",
		"asphalt_arrow_straight_right",
		"infrastructure:asphalt_arrow_straight_right",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^streets_arrow_straight_right.png",
				"infrastructure_asphalt.png"
			},
			description = "Asphalt with arrow straight + right",
		}
	)

-- Asphalt stair, slab, panel and microblock with arrow left
	stairsplus:register_all(
		"infrastructure",
		"asphalt_arrow_left",
		"infrastructure:asphalt_arrow_left",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^streets_arrow_left.png",
				"infrastructure_asphalt.png"
			},
			description = "Asphalt with arrow left",
		}
	)

-- Asphalt stair, slab, panel and microblock with arrow right
	stairsplus:register_all(
		"infrastructure",
		"asphalt_arrow_right",
		"infrastructure:asphalt_arrow_right",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^streets_arrow_right.png",
				"infrastructure_asphalt.png"
			},
			description = "Asphalt with arrow right",
		}
	)

-- Asphalt stair, slab, panel and microblock with "P"-sign
	stairsplus:register_all(
		"infrastructure",
		"asphalt_parking",
		"infrastructure:asphalt_parking",
		{
			groups = {not_in_creative_inventory=1, cracky=1},
			tiles = {
				"streets_asphalt.png^streets_parking.png",
				"infrastructure_asphalt.png"
			},
			description = "Asphalt with a parking sign",
		}
	)
