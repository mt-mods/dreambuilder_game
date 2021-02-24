--[[
	StreetsMod: Asphalt stairs
]]
if not minetest.get_modpath("moreblocks") then return end

	-- Asphalt solid line
		-- Stair
		minetest.register_node(":streets:asphalt_solid_line_stair",{
			description = streets.S("Asphalt stair"),
			tiles = {"streets_asphalt.png^streets_asphalt_solid_line.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_solid_line.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5},
					{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5}
				}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_solid_line_stair 6",
			recipe = {
				{"","","streets:asphalt_solid_line"},
				{"","streets:asphalt_solid_line","streets:asphalt_solid_line"},
				{"streets:asphalt_solid_line","streets:asphalt_solid_line","streets:asphalt_solid_line"}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_solid_line_stair 6",
			recipe = {
				{"streets:asphalt_solid_line","",""},
				{"streets:asphalt_solid_line","streets:asphalt_solid_line",""},
				{"streets:asphalt_solid_line","streets:asphalt_solid_line","streets:asphalt_solid_line"}
			}
		})
		-- Slab
		minetest.register_node(":streets:asphalt_solid_line_slab",{
			description = streets.S("Asphalt slab"),
			tiles = {"streets_asphalt.png^streets_asphalt_solid_line.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_solid_line.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5}
				}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_solid_line_slab 3",
			recipe = {
				{"","",""},
				{"","",""},
				{"streets:asphalt_solid_line","streets:asphalt_solid_line","streets:asphalt_solid_line"}
			}
		})
		------------------------------------------------------------
	-- Asphalt dashed line
		-- Stair
		minetest.register_node(":streets:asphalt_dashed_line_stair",{
			description = streets.S("Asphalt stair"),
			tiles = {"streets_asphalt.png^streets_asphalt_dashed_line.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_dashed_line.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5},
					{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5}
				}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_dashed_line_stair 6",
			recipe = {
				{"","","streets:asphalt_dashed_line"},
				{"","streets:asphalt_dashed_line","streets:asphalt_dashed_line"},
				{"streets:asphalt_dashed_line","streets:asphalt_dashed_line","streets:asphalt_dashed_line"}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_dashed_line_stair 6",
			recipe = {
				{"streets:asphalt_dashed_line","",""},
				{"streets:asphalt_dashed_line","streets:asphalt_dashed_line",""},
				{"streets:asphalt_dashed_line","streets:asphalt_dashed_line","streets:asphalt_dashed_line"}
			}
		})
		-- Slab
		minetest.register_node(":streets:asphalt_dashed_line_slab",{
			description = streets.S("Asphalt slab"),
			tiles = {"streets_asphalt.png^streets_asphalt_dashed_line.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_dashed_line.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5}
				}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_dashed_line_slab 3",
			recipe = {
				{"","",""},
				{"","",""},
				{"streets:asphalt_dashed_line","streets:asphalt_dashed_line","streets:asphalt_dashed_line"}
			}
		})
	-- Asphalt outer line
		minetest.register_node(":streets:asphalt_side_stair_l",{
			description = streets.S("Asphalt stair"),
			tiles = {"streets_asphalt.png^streets_asphalt_side.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_side.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5},
					{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5}
				}
			}
		})
		minetest.register_node(":streets:asphalt_side_stair_r",{
			description = streets.S(streets.S("Asphalt stair")),
			tiles = {"streets_asphalt.png^streets_asphalt_side_r.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_side_r.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			drop = "streets:asphalt_side_stair_l",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5},
					{-0.5, 0.0, 0.0, 0.5, 0.5, 0.5}
				}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_side_stair_l 6",
			recipe = {
				{"","","streets:asphalt_side"},
				{"","streets:asphalt_side","streets:asphalt_side"},
				{"streets:asphalt_side","streets:asphalt_side","streets:asphalt_side"}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_side_stair_l 6",
			recipe = {
				{"streets:asphalt_side","",""},
				{"streets:asphalt_side","streets:asphalt_side",""},
				{"streets:asphalt_side","streets:asphalt_side","streets:asphalt_side"}
			}
		})
		minetest.register_craft({
			type = "shapeless",
			output = "streets:asphalt_side_stair_r",
			recipe = {"streets:asphalt_side_stair_l"}
		})
		minetest.register_craft({
			type = "shapeless",
			output = "streets:asphalt_side_stair_l",
			recipe = {"streets:asphalt_side_stair_r"}
		})
		---------------------------------------------------------------------
		minetest.register_node(":streets:asphalt_side_slab_l",{
			description = streets.S(streets.S("Asphalt slab")),
			tiles = {"streets_asphalt.png^streets_asphalt_side.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_side.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5}
				}
			}
		})
		minetest.register_node(":streets:asphalt_side_slab_r",{
			description = streets.S(streets.S("Asphalt slab")),
			tiles = {"streets_asphalt.png^streets_asphalt_side_r.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^streets_asphalt_side_r.png"},
			groups = {cracky = 3,not_in_creative_inventory=1},
			paramtype = "light",
			paramtype2 = "facedir",
			drawtype = "nodebox",
			node_box = {
				type = "fixed",
				fixed = {
					{-0.5,-0.5,-0.5,0.5,0.0,0.5}
				}
			}
		})
		minetest.register_craft({
			output = "streets:asphalt_side_slab_l 3",
			recipe = {
				{"","",""},
				{"","",""},
				{"streets:asphalt_side","streets:asphalt_side","streets:asphalt_side"}
			}
		})
		minetest.register_craft({
			type = "shapeless",
			output = "streets:asphalt_side_r",
			recipe = {"streets:asphalt_side_l"}
		})
		minetest.register_craft({
			type = "shapeless",
			output = "streets:asphalt_side_l",
			recipe = {"streets:asphalt_side_r"}
		})

	-- Asphalt
	minetest.register_alias("streets:asphalt_stair","stairs:stair_asphalt")
	minetest.register_alias("streets:asphalt_slab","stairs:slab_asphalt")

	stairsplus:register_all(
		"streets",
		"asphalt",
		"streets:asphalt",
		{
			groups = {not_in_creative_inventory=1, cracky=3},
			tiles = {"streets_asphalt.png"},
			description = "Asphalt"
		}
	)

	stairsplus:register_all(
		"streets",
		"asphalt_solid_line",
		"streets:asphalt_solid_line",
		{
			groups = {not_in_creative_inventory=1, cracky=3},
			tiles = {
				"streets_asphalt.png^streets_asphalt_solid_line.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png^streets_asphalt_solid_line.png"
			},
			description = "Asphalt with solid centerline"
		}
	)

	stairsplus:register_all(
		"streets",
		"asphalt_dashed_line",
		"streets:asphalt_dashed_line",
		{
			groups = {not_in_creative_inventory=1, cracky=3},
			tiles = {
				"streets_asphalt.png^streets_asphalt_dashed_line.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png^streets_asphalt_dashed_line.png"
			},
			description = "Asphalt with dashed centerline"
		}
	)

	stairsplus:register_all(
		"streets",
		"asphalt_side",
		"streets:asphalt_sideline",
		{
			groups = {not_in_creative_inventory=1, cracky=3},
			tiles = {
				"streets_asphalt.png^streets_asphalt_side.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png^streets_asphalt_side.png"
			},
			description = "Asphalt with solid outer line (left)"
		}
	)

	stairsplus:register_all(
		"streets",
		"asphalt_side_r",
		"streets:asphalt_side_r",
		{
			groups = {not_in_creative_inventory=1, cracky=3},
			tiles = {
				"streets_asphalt.png^streets_asphalt_side_r.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png",
				"streets_asphalt.png^streets_asphalt_side_r.png"
			},
			description = "Asphalt with solid outer line (right)"
		}
	)

	stairsplus:register_all(
		"streets",
		"asphalt_outer_edge",
		"streets:asphalt_outer_edge",
		{
			groups = {not_in_creative_inventory=1, cracky=3},
			tiles = {
				"streets_asphalt.png^streets_asphalt_outer_edge.png",
				"streets_asphalt.png"
			},
			description = "Asphalt with solid outer line (corner/edge)",
		}
	)

	stairsplus:register_all(
		"streets",
		"asphalt_outer_edge_r",
		"streets:asphalt_outer_edge_r",
		{
			groups = {not_in_creative_inventory=1, cracky=3},
			tiles = {
				"streets_asphalt.png^(streets_asphalt_outer_edge.png^[transformR270)",
				"streets_asphalt.png"
			},
			description = "Asphalt with solid outer line (corner/edge, rotated)"
		}
	)
