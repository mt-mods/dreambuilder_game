local material = {}
local shape = {}
local make_ok = {}
local anzahl = {}


minetest.register_node("mymillwork:machine", {
	description = "Millwork Machine",
	tiles = {
		"mymillwork_machine_top.png",
		"mymillwork_machine_bottom.png",
		"mymillwork_machine_side2.png",
		"mymillwork_machine_side1.png",
		"mymillwork_machine_back.png",
		"mymillwork_machine_front.png"
		},
	drawtype = "nodebox",
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=2, cracky=3, dig_immediate=1},
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.1875, -0.5, 0.5, -0.0625, 0.5},
			{-0.5, -0.5, -0.5, -0.3125, -0.1875, -0.3125},
			{-0.5, -0.5, 0.3125, -0.3125, -0.1875, 0.5},
			{0.3125, -0.5, 0.3125, 0.5, -0.1875, 0.5},
			{0.3125, -0.5, -0.5, 0.5, -0.1875, -0.3125},
			{0, -0.0625, 0.25, 0.0625, 0.375, 0.5},
			{-0.125, -0.0625, 0.25, -0.0625, 0.375, 0.5},
			{-0.1875, 0.125, -0.3125, 0.125, 0.5, 0.0625},
			{-0.125, 0.375, 0.0625, 0.0625, 0.5, 0.5},
			{-0.0625, 0.0625, -0.3125, 0, 0.125, 0.0625},
			{-0.0625, 0, -0.25, 0, 0.125, 0},
		}
	},

	after_place_node = function(pos, placer)
	local meta = minetest.get_meta(pos);
			meta:set_string("owner",  (placer:get_player_name() or ""));
			meta:set_string("infotext",  "Millwork Machine (owned by " .. (placer:get_player_name() or "") .. ")");
		end,

can_dig = function(pos,player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	if not inv:is_empty("ingot") or
	not inv:is_empty("res") then
		return false
	end
	return true
end,

on_construct = function(pos)
	local meta = minetest.get_meta(pos)
	meta:set_string("formspec", "invsize[10,11;]"..
		"background[-0.15,-0.25;10.40,11.75;mymillwork_background.png]"..
		"list[current_name;ingot;7,5.5.5;1,1;]"..
		"list[current_name;res;8.5,5.5;1,1;]"..
		"label[7,5;Input:]"..
		"label[8.5,5;Output:]"..
		"label[0,0;Choose Millwork:]"..

		"label[0.5,0.5;Crown Mould]"..
		"image_button[0.5,1;1,1;mymillwork_mach1.png;crownmould; ]"..
		"image_button[1.5,1;1,1;mymillwork_mach2.png;crownmould_ic; ]"..
		"image_button[2.5,1;1,1;mymillwork_mach3.png;crownmould_oc; ]"..
		"image_button[3.5,1;1,1;mymillwork_mach4.png;crownmould_beam; ]"..

		"label[0.5,2;Columns]"..
		"image_button[0.5,2.5;1,1;mymillwork_mach5.png;column; ]"..
		"image_button[1.5,2.5;1,1;mymillwork_mach6.png;column_base; ]"..
		"image_button[2.5,2.5;1,1;mymillwork_mach7.png;column_half; ]"..
		"image_button[3.5,2.5;1,1;mymillwork_mach8.png;column_half_base; ]"..
		"image_button[4.5,2.5;1,1;mymillwork_mach9.png;column_half_wbeam; ]"..
		"image_button[5.5,2.5;1,1;mymillwork_mach10.png;column_quarter; ]"..
		"image_button[6.5,2.5;1,1;mymillwork_mach11.png;column_quarter_base; ]"..
		"image_button[7.5,2.5;1,1;mymillwork_mach12.png;column_quarter_wbase; ]"..
		"image_button[8.5,2.5;1,1;mymillwork_mach13.png;column_quarter_fancybase; ]"..

		"label[0.5,3.5;Ceiling and Beams]"..
		"image_button[0.5,4;1,1;mymillwork_mach14.png;ceiling; ]"..
		"image_button[1.5,4;1,1;mymillwork_mach15.png;ceiling_post; ]"..
		"image_button[2.5,4;1,1;mymillwork_mach16.png;beam; ]"..
		"image_button[3.5,4;1,1;mymillwork_mach17.png;beam_t; ]"..
		"image_button[4.5,4;1,1;mymillwork_mach18.png;beam_ceiling_t; ]"..

		"label[0.5,5;Base]"..
		"image_button[0.5,5.5;1,1;mymillwork_mach19.png;base; ]"..
		"image_button[1.5,5.5;1,1;mymillwork_mach20.png;base_ic; ]"..
		"image_button[2.5,5.5;1,1;mymillwork_mach21.png;base_oc; ]"..
		"image_button[3.5,5.5;1,1;mymillwork_mach22.png;base_fancy; ]"..
		"image_button[4.5,5.5;1,1;mymillwork_mach23.png;base_fancy_ic; ]"..
		"image_button[5.5,5.5;1,1;mymillwork_mach24.png;base_fancy_oc; ]"..
		"list[current_player;main;1,7;8,4;]")
	meta:set_string("infotext", "Millwork Machine")
	local inv = meta:get_inventory()
	inv:set_size("ingot", 1)
	inv:set_size("res", 1)
end,

on_receive_fields = function(pos, formname, fields, sender)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()

if fields["crownmould"]
or fields["crownmould_ic"]
or fields["crownmould_oc"]
or fields["crownmould_beam"]
or fields["column"]
or fields["column_base"]
or fields["column_half"]
or fields["column_half_base"]
or fields["column_half_wbeam"]
or fields["column_quarter"]
or fields["column_quarter_base"]
or fields["column_quarter_wbase"]
or fields["column_quarter_fancybase"]
or fields["ceiling"]
or fields["ceiling_post"]
or fields["beam"]
or fields["beam_t"]
or fields["beam_ceiling_t"]
or fields["base"]
or fields["base_ic"]
or fields["base_oc"]
or fields["base_fancy"]
or fields["base_fancy_ic"]
or fields["base_fancy_oc"]
then

	if inv:is_empty("ingot") then
		return
	end

--Crown Mould
	if fields["crownmould"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mymillwork:crownmould_"

	elseif fields["crownmould_ic"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mymillwork:crownmould_ic_"

	elseif fields["crownmould_oc"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mymillwork:crownmould_oc_"

	elseif fields["crownmould_beam"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mymillwork:crownmould_beam_"

--Columns

	elseif fields["column"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mymillwork:column_"

	elseif fields["column_base"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mymillwork:column_base_"

	elseif fields["column_half"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mymillwork:column_half_"

	elseif fields["column_half_base"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mymillwork:column_half_base_"

	elseif fields["column_half_wbeam"] then
		make_ok = "0"
		anzahl = "1"
		shape = "mymillwork:column_half_wbeam_"

	elseif fields["column_quarter"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mymillwork:column_quarter_"

	elseif fields["column_quarter_base"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mymillwork:column_quarter_base_"

	elseif fields["column_quarter_wbase"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mymillwork:column_quarter_wbase_"

	elseif fields["column_quarter_fancybase"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mymillwork:column_quarter_fancybase_"

--Ceiling

	elseif fields["ceiling"] then
		make_ok = "0"
		anzahl = "6"
		shape = "mymillwork:ceiling_"

	elseif fields["ceiling_post"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mymillwork:ceiling_post_"

--Beam

	elseif fields["beam"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mymillwork:beam_"

	elseif fields["beam_t"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mymillwork:beam_t_"

	elseif fields["beam_ceiling_t"] then
		make_ok = "0"
		anzahl = "2"
		shape = "mymillwork:beam_ceiling_t_"

--Base

	elseif fields["base"] then
		make_ok = "0"
		anzahl = "8"
		shape = "mymillwork:base_"

	elseif fields["base_ic"] then
		make_ok = "0"
		anzahl = "4"
		shape = "mymillwork:base_ic_"

	elseif fields["base_oc"] then
		make_ok = "0"
		anzahl = "10"
		shape = "mymillwork:base_oc_"

	elseif fields["base_fancy"] then
		make_ok = "0"
		anzahl = "6"
		shape = "mymillwork:base_fancy_"

	elseif fields["base_fancy_ic"] then
		make_ok = "0"
		anzahl = "3"
		shape = "mymillwork:base_fancy_ic_"

	elseif fields["base_fancy_oc"] then
		make_ok = "0"
		anzahl = "8"
		shape = "mymillwork:base_fancy_oc_"
	end

		local ingotstack = inv:get_stack("ingot", 1)
		local resstack = inv:get_stack("res", 1)

	for i in ipairs(mymillwork.registered) do
		local itm = mymillwork.registered[i][1]
		local mat = mymillwork.registered[i][2]
		if ingotstack:get_name()== itm then
				material = mat
				make_ok = "1"
		end
	end

		if make_ok == "1" then
			local give = {}
			for i = 0, anzahl-1 do
				give[i+1]=inv:add_item("res",shape..material)
			end
			if not minetest.setting_getbool("creative_mode") then
				ingotstack:take_item()
			end
			inv:set_stack("ingot",1,ingotstack)
		end

end
end


})

--Craft

minetest.register_craft({
		output = 'mymillwork:machine',
		recipe = {
			{'', 'default:steel_ingot',''},
			{'default:steelblock', 'default:steelblock', 'default:steelblock'},
			{'default:steel_ingot','' , 'default:steel_ingot'},
		},
})
