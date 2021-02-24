--[[
	StreetsMod: All kinds of asphalt with labels
]]

labels = {}

labels.printer = {}

labels.printer.marktypes = {}

function labels.printer.can_dig(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	return (inv:is_empty("whitecart") and inv:is_empty("yellowcart") and inv:is_empty("paper"))
end

function labels.printer.checksupplies(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local whitecart = inv:get_stack("whitecart",1)
	local yellowcart = inv:get_stack("yellowcart",1)
	local paper = inv:get_stack("paper",1)
	if not whitecart:to_table() or not yellowcart:to_table() or not paper:to_table() then
		return false
	end
	local whitecart_good = whitecart:to_table().name == "streets:whitecartridge" and whitecart:to_table().wear < 60000
	local yellowcart_good = yellowcart:to_table().name == "streets:yellowcartridge" and yellowcart:to_table().wear < 60000
	local paper_good = paper:to_table().name == "default:paper"
	local good = yellowcart_good and whitecart_good and paper_good
	return good
end

function labels.printer.nom(pos,color,amount)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local whitecart = inv:get_stack("whitecart",1)
	local yellowcart = inv:get_stack("yellowcart",1)
	local paper = inv:get_stack("paper",1)
	if color == "white" then
		whitecart:add_wear(amount*1000)
	elseif color == "yellow" then
		yellowcart:add_wear(amount*1000)
	end
	paper:take_item(1)
	inv:set_stack("yellowcart",1,yellowcart)
	inv:set_stack("whitecart",1,whitecart)
	inv:set_stack("paper",1,paper)
end

function labels.printer.populateoutput(pos)
	local typescount = #labels.printer.marktypes
	local pagesize = 8*5
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local page = meta:get_int("page")
	local maxpage = math.ceil(typescount/pagesize)
	inv:set_list("output",{})
	inv:set_size("output", typescount)
	if labels.printer.checksupplies(pos) then
		for k,v in ipairs(labels.printer.marktypes) do
			inv:set_stack("output",k,v.name)
		end
	end
	meta:set_string("formspec", "size[11,10]"..
			"label[0,0;Yellow\nCartridge]" ..
			"list[current_name;yellowcart;1.5,0;1,1;]" ..
			"label[0,1;White\nCartridge]" ..
			"list[current_name;whitecart;1.5,1;1,1;]" ..
			"label[0,2;Paper]" ..
			"list[current_name;paper;1.5,2;1,1;]" ..
			"list[current_name;output;2.8,0;8,5;"..tostring((page-1)*pagesize).."]" ..
			"list[current_player;main;1.5,6.25;8,4;]"..
			"button[4,5;1,1;prevpage;<<<]"..
			"button[7,5;1,1;nextpage;>>>]"..
			"label[5.25,5.25;Page "..page.." of "..maxpage.."]")
	meta:set_int("maxpage",maxpage)
end

function labels.printer.on_construct(pos)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	meta:set_int("page",1)
	meta:set_int("maxpage",1)
	inv:set_size("yellowcart", 1)
	inv:set_size("whitecart", 1)
	inv:set_size("paper", 1)
	labels.printer.populateoutput(pos)
end

function labels.printer.on_receive_fields(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local page = meta:get_int("page")
	local maxpage = meta:get_int("maxpage")
	if fields.prevpage then
		page = page - 1
		if page < 1 then
			page = maxpage
		end
		meta:set_int("page",page)
	elseif fields.nextpage then
		page = page + 1
		if page > maxpage then
			page = 1
		end
		meta:set_int("page",page)
	end
	labels.printer.populateoutput(pos)
end

function labels.printer.allow_metadata_inventory_put(pos, listname, index, stack, player)
	if listname == "yellowcart" then
		if stack:get_name() == "streets:yellowcartridge" then
			return 1
		else
			return 0
		end
	elseif listname == "whitecart" then
		if stack:get_name() == "streets:whitecartridge" then
			return 1
		else
			return 0
		end
	elseif listname == "paper" then
		if stack:get_name() == "default:paper" then
			return stack:get_count()
		else
			return 0
		end
	else
		return 0
	end
end

function labels.printer.on_metadata_inventory_put(pos)
	labels.printer.populateoutput(pos)
end

function labels.printer.on_metadata_inventory_take(pos, listname, index)
	if listname == "output" then
		local cost = labels.printer.marktypes[index].inkamt
		local color = labels.printer.marktypes[index].color
		labels.printer.nom(pos,color,cost)
	end
	labels.printer.populateoutput(pos)
end

function labels.printer.allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	return 0
end

minetest.register_tool(":streets:yellowcartridge",{
	description = "Yellow Ink Cartridge",
	inventory_image = "streets_yellow_cartridge.png"
	}
)

minetest.register_tool(":streets:whitecartridge",{
	description = "White Ink Cartridge",
	inventory_image = "streets_white_cartridge.png"
	}
)

minetest.register_craft({
	output = "streets:yellowcartridge",
	recipe =       {{"homedecor:plastic_sheeting","homedecor:plastic_sheeting","homedecor:plastic_sheeting"},
			{"homedecor:plastic_sheeting","dye:yellow","homedecor:plastic_sheeting"},
			{"homedecor:plastic_sheeting","",""}}
})

minetest.register_craft({
	output = "streets:whitecartridge",
	recipe =       {{"homedecor:plastic_sheeting","homedecor:plastic_sheeting","homedecor:plastic_sheeting"},
			{"homedecor:plastic_sheeting","dye:white","homedecor:plastic_sheeting"},
			{"homedecor:plastic_sheeting","",""}}
})

minetest.register_craft({
	output = "streets:yellowcartridge",
	type = "shapeless",
	recipe =       {"streets:yellowcartridge","dye:yellow"}
})

minetest.register_craft({
	output = "streets:whitecartridge",
	type = "shapeless",
	recipe =       {"streets:whitecartridge","dye:white"}
})

minetest.register_craft({
	output = "streets:printer",
	recipe =       {{"","homedecor:plastic_sheeting","basic_materials:energy_crystal_simple"},
			{"homedecor:motor","default:steel_ingot","group:wool"},
			{"","homedecor:plastic_sheeting","homedecor:motor"}}
})

minetest.register_node(":streets:printer", {
	description = "Road Markings Printer",
	inventory_image = "streets_printer_inv.png",
	tiles = {"streets_printer_t.png","streets_printer_bt.png","streets_printer_l.png",
			"streets_printer_r.png","streets_printer_b.png","streets_printer_f.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = {snappy=3},
	sound = default.node_sound_wood_defaults(),
	drawtype = "nodebox",
	on_construct = labels.printer.on_construct,
	allow_metadata_inventory_put = labels.printer.allow_metadata_inventory_put,
	on_metadata_inventory_put = labels.printer.on_metadata_inventory_put,
	on_metadata_inventory_take = labels.printer.on_metadata_inventory_take,
	allow_metadata_inventory_move = labels.printer.allow_metadata_inventory_move,
	on_receive_fields = labels.printer.on_receive_fields,
	can_dig = labels.printer.can_dig,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.3125, -0.125, 0.4375, -0.0625, 0.375},
			{-0.4375, -0.5, -0.125, 0.4375, -0.4375, 0.375},
			{-0.4375, -0.5, -0.125, -0.25, -0.0625, 0.375},
			{0.25, -0.5, -0.125, 0.4375, -0.0625, 0.375},
			{-0.4375, -0.5, -0.0625, 0.4375, -0.0625, 0.375},
			{-0.375, -0.4375, 0.25, 0.375, -0.0625, 0.4375},
			{-0.25, -0.25, 0.4375, 0.25, 0.0625, 0.5},
			{-0.25, -0.481132, -0.3125, 0.25, -0.4375, 0}
		},
	},
})

streets.register_label = function(friendlyname,name,tex,color,ink_needed,hide)
	local groups = {snappy = 3,attached_node = 1,oddly_breakable_by_hand = 1}
	if hide then groups.not_in_creative_inventory = 1 end
	minetest.register_node(":streets:mark_"..name,{
		description = streets.S("Marking Overlay: "..friendlyname),
		tiles = {tex,"streets_rw_transparent.png"},
		drawtype = "nodebox",
		paramtype = "light",
		paramtype2 = "facedir",
		groups = groups,
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

	if minetest.get_modpath("moreblocks") then
		stairsplus:register_all("streets", name, "streets:mark_"..name.."_on_asphalt", {
			description = "Asphalt with Marking: "..friendlyname,
			tiles = {"streets_asphalt.png^"..tex,"streets_asphalt.png","streets_asphalt.png","streets_asphalt.png","streets_asphalt.png^"..tex.."^[transformR180","streets_asphalt.png^"..tex},
			groups = {cracky=3}
		})
	end
	local printdata = {name="streets:mark_"..name,color=color,inkamt=ink_needed}
	table.insert(labels.printer.marktypes,printdata)
end


--White Markings
streets.register_label("All-White","all_white","streets_all_white.png","white",9)

streets.register_label("Solid White Side Line","solid_white_side_line","streets_asphalt_side.png","white",3)

minetest.register_alias("streets:asphalt_side","streets:mark_solid_white_side_line_on_asphalt")
minetest.register_alias("streets:asphalt_sideline","streets:mark_solid_white_side_line_on_asphalt")

streets.register_label("Solid White Side Line (rotated)","solid_white_side_line_rotated","streets_asphalt_side.png^[transformR180","white",3,true)

minetest.register_alias("streets:asphalt_sideline_r","streets:mark_solid_white_side_line_rotated_on_asphalt")


streets.register_label("Solid White Center Line","solid_white_center_line","streets_asphalt_solid_line.png","white",2)

minetest.register_alias("streets:asphalt_middle","streets:mark_solid_white_center_line_on_asphalt")
minetest.register_alias("streets:asphalt_solid_line","streets:mark_solid_white_center_line_on_asphalt")


streets.register_label("Dashed White Center Line","dashed_white_center_line","streets_asphalt_dashed_line.png","white",1)

minetest.register_alias("streets:asphalt_middle_dashed","streets:mark_dashed_white_center_line_on_asphalt")
minetest.register_alias("streets:asphalt_dashed_line","streets:mark_dashed_white_center_line_on_asphalt")


streets.register_label("Solid White Side Line (corner)","solid_white_side_line_corner","streets_asphalt_outer_edge.png","white",4)

minetest.register_alias("streets:asphalt_outer_edge","streets:mark_solid_white_side_line_corner_on_asphalt")


streets.register_label("Solid White Side Line (corner, rotated)","solid_white_side_line_corner_rotated","streets_asphalt_outer_edge.png^[transformR270","white",4,true)

minetest.register_alias("streets:asphalt_outer_edge_r","streets:mark_solid_white_side_line_corner_rotated_on_asphalt")


streets.register_label("Parking (white)","white_parking","streets_parking.png","white",4)

minetest.register_alias("streets:asphalt_parking","streets:mark_white_parking_on_asphalt")


streets.register_label("White Arrow (straight)","white_arrow_straight","streets_arrow_straight.png","white",3)

minetest.register_alias("streets:asphalt_arrow_straight","streets:mark_white_arrow_straight_on_asphalt")


streets.register_label("White Arrow (left)","white_arrow_left","streets_arrow_left.png","white",3)

minetest.register_alias("streets:asphalt_arrow_left","streets:mark_white_arrow_left_on_asphalt")


streets.register_label("White Arrow (right)","white_arrow_right","streets_arrow_right.png","white",3)

minetest.register_alias("streets:asphalt_arrow_right","streets:mark_white_arrow_right_on_asphalt")


streets.register_label("White Arrow (left+straight)","white_arrow_left_straight","streets_arrow_straight_left.png","white",4)

minetest.register_alias("streets:asphalt_arrow_straight_left","streets:mark_white_arrow_left_straight_on_asphalt")


streets.register_label("White Arrow (straight+right)","white_arrow_straight_right","streets_arrow_straight_right.png","white",4)

minetest.register_alias("streets:asphalt_arrow_straight_right","streets:mark_white_arrow_straight_right_on_asphalt")


streets.register_label("White Arrow (left+straight+right)","white_arrow_left_straight_right","streets_arrow_alldirs.png","white",5)

minetest.register_alias("streets:asphalt_arrow_alldirs","streets:mark_white_arrow_left_straight_right_on_asphalt")


--Yellow streetsmod markings

streets.register_label("Solid Yellow Center Line","solid_yellow_center_line","streets_rw_solid_line.png","yellow",3)

minetest.register_alias("streets:rw_asphalt_solid","streets:mark_solid_yellow_center_line")


streets.register_label("Dashed Yellow Center Line","dashed_yellow_center_line","streets_rw_dashed_line.png","yellow",2)

minetest.register_alias("streets:rw_asphalt_dashed","streets:mark_dashed_yellow_center_line")


streets.register_label("Yellow X","yellow_x","streets_rw_cross.png","yellow",3)

minetest.register_alias("streets:rw_cross","streets:mark_yellow_x")


streets.register_label("Solid Yellow Side Line (corner)","solid_yellow_side_line_corner","streets_rw_outer_edge.png","yellow",4)

minetest.register_alias("streets:rw_outer_edge","streets:solid_yellow_side_line_corner")


streets.register_label("Solid Yellow Side Line (corner,rotated)","solid_yellow_side_line_corner_rotated","streets_rw_outer_edge.png^[transformR270","yellow",5,true)

minetest.register_alias("streets:rw_outer_edge","streets:solid_yellow_side_line_corner")


streets.register_label("Parking (yellow)","yellow_parking","streets_rw_parking.png","yellow",4)

minetest.register_alias("streets:rw_parking","streets:mark_yellow_parking")


streets.register_label("Yellow Arrow (straight)","yellow_arrow_straight","streets_rw_arrow_straight.png","yellow",3)

minetest.register_alias("streets:rw_straight","streets:mark_yellow_arrow_straight")


streets.register_label("Yellow Arrow (left)","yellow_arrow_left","streets_rw_arrow_left.png","yellow",3)

minetest.register_alias("streets:rw_left","streets:mark_yellow_arrow_left")


streets.register_label("Yellow Arrow (right)","yellow_arrow_right","streets_rw_arrow_right.png","yellow",3)

minetest.register_alias("streets:rw_right","streets:mark_yellow_arrow_right")


streets.register_label("Yellow Arrow (left+straight)","yellow_arrow_left_straight","streets_rw_arrow_straight_left.png","yellow",4)

minetest.register_alias("streets:rw_straight_left","streets:mark_yellow_arrow_left_straight")


streets.register_label("Yellow Arrow (straight+right)","yellow_arrow_straight_right","streets_rw_arrow_straight_right.png","yellow",4)

minetest.register_alias("streets:rw_straight_right","streets:mark_yellow_arrow_straight_right")


streets.register_label("Yellow Arrow (left+straight+right)","yellow_arrow_left_straight_right","streets_rw_arrow_alldirs.png","yellow",5)

minetest.register_alias("streets:rw_alldirs","streets:mark_yellow_arrow_left_straight_right")

streets.register_label("Solid Yellow Side Line","solid_yellow_side_line","streets_rw_asphalt_side.png","yellow",3)

minetest.register_alias("streets:rw_sideline","streets:mark_solid_yellow_side_line")

streets.register_label("Solid Yellow Side Line (rotated)","solid_yellow_side_line_rotated","streets_rw_asphalt_side.png^[transformR180","yellow",3,true)

streets.register_label("Yellow Diagonal Lines","yellow_diagonal","streets_yellow_diagonal_lines.png","yellow",5)

--Infrastructure markings

streets.register_label("Solid Yellow Center Line (wide)","solid_yellow_center_line_wide","infrastructure_single_yellow_line.png","yellow",4)

minetest.register_alias("infrastructure:asphalt_center_solid_line","streets:mark_solid_yellow_center_line_wide_on_asphalt")


streets.register_label("Solid Yellow Center Line (wide,offset)","solid_yellow_center_line_wide_offset","infrastructure_solid_yellow_line_one_side.png","yellow",4)

minetest.register_alias("infrastructure:asphalt_center_solid_one_side","streets:mark_solid_yellow_center_line_wide_offset_on_asphalt")


streets.register_label("Double Yellow Center Line (wide)","double_yellow_center_line_wide","infrastructure_double_yellow_line.png","yellow",6)

minetest.register_alias("infrastructure:asphalt_center_solid_double","streets:mark_double_yellow_center_line_wide_on_asphalt")


streets.register_label("Solid Yellow Center Line (wide,corner)","solid_yellow_center_line_wide_corner","infrastructure_single_yellow_line_corner.png","yellow",4)

minetest.register_alias("infrastructure:asphalt_center_corner_single","streets:mark_solid_yellow_center_line_wide_corner_on_asphalt")


streets.register_label("Double Yellow Center Line (wide,corner)","double_yellow_center_line_wide_corner","infrastructure_solid_double_yellow_line_corner.png","yellow",6)

minetest.register_alias("infrastructure:asphalt_center_corner_double","streets:mark_double_yellow_center_line_wide_corner_on_asphalt")


minetest.register_alias("infrastructure:asphalt_arrow_straight", "streets:asphalt_arrow_straight")


minetest.register_alias("infrastructure:asphalt_arrow_straight_left", "streets:asphalt_arrow_straight_left")


minetest.register_alias("infrastructure:asphalt_arrow_straight_right", "streets:asphalt_arrow_straight_left")


minetest.register_alias("infrastructure:asphalt_arrow_left", "streets:asphalt_arrow_left")


minetest.register_alias("infrastructure:asphalt_arrow_right", "streets:asphalt_arrow_right")


minetest.register_alias("infrastructure:asphalt_parking", "streets:asphalt_parking")
