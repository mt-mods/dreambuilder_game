minetest.register_alias("castle:pillars_bottom", "castle:pillars_stonewall_bottom")
minetest.register_alias("castle:pillars_top", "castle:pillars_stonewall_top")
minetest.register_alias("castle:pillars_middle", "castle:pillars_stonewall_middle")

local pillar = {}

pillar.types = {
	{"stonewall", "Stonewall", "castle_stonewall", "castle:stonewall"},
    {"cobble", "Cobble", "default_cobble", "default:cobble"},
    {"stonebrick", "Stonebrick", "default_stone_brick", "default:stonebrick"},
    {"sandstonebrick", "Sandstone Brick", "default_sandstone_brick", "default:sandstonebrick"},
    {"desertstonebrick", "Desert Stone Brick", "default_desert_stone_brick", "default:desert_stonebrick"},
    {"stone", "Stone", "default_stone", "default:stone"},
    {"sandstone", "Sandstone", "default_sandstone", "default:sandstone"},
    {"desertstone", "Desert Stone", "default_desert_stone", "default:desert_stone"},
}

for _, row in ipairs(pillar.types) do
	local name = row[1]
	local desc = row[2]
	local tile = row[3]
	local craft_material = row[4]
	-- Node Definition
	minetest.register_node("castle:pillars_"..name.."_bottom", {
	    drawtype = "nodebox",
		description = desc.." Pillar Base",
		tiles = {tile..".png"},
		groups = {cracky=3,attached_node=1},
		sounds = default.node_sound_defaults(),
	    paramtype = "light",
	    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.375000,0.500000},
			{-0.375000,-0.375000,-0.375000,0.375000,-0.125000,0.375000},
			{-0.250000,-0.125000,-0.250000,0.250000,0.500000,0.250000}, 
		},
	},
	})
	minetest.register_node("castle:pillars_"..name.."_top", {
	    drawtype = "nodebox",
		description = desc.." Pillar Top",
		tiles = {tile..".png"},
		groups = {cracky=3,attached_node=1},
		sounds = default.node_sound_defaults(),
	    paramtype = "light",
	    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.312500,-0.500000,0.500000,0.500000,0.500000}, 
			{-0.375000,0.062500,-0.375000,0.375000,0.312500,0.375000}, 
			{-0.250000,-0.500000,-0.250000,0.250000,0.062500,0.250000},
		},
	},
	})
	minetest.register_node("castle:pillars_"..name.."_middle", {
	    drawtype = "nodebox",
		description = desc.." Pillar Middle",
		tiles = {tile..".png"},
		groups = {cracky=3,attached_node=1},
		sounds = default.node_sound_defaults(),
	    paramtype = "light",
	    paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.250000,-0.500000,-0.250000,0.250000,0.500000,0.250000},
		},
	},
	})
	if craft_material then
		--Choose craft material
		minetest.register_craft({
			output = "castle:pillars_"..name.."_bottom 4",
			recipe = {
			{"",craft_material,""},
			{"",craft_material,""},
			{craft_material,craft_material,craft_material} },
		})
	end
	if craft_material then
		--Choose craft material
		minetest.register_craft({
			output = "castle:pillars_"..name.."_top 4",
			recipe = {
			{craft_material,craft_material,craft_material},
			{"",craft_material,""},
			{"",craft_material,""} },
		})
	end
	if craft_material then
		--Choose craft material
		minetest.register_craft({
			output = "castle:pillars_"..name.."_middle 4",
			recipe = {
			{craft_material,craft_material},
			{craft_material,craft_material},
			{craft_material,craft_material} },
		})
	end
end
