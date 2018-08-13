local valid_sounds = {
	csharp = "mesecons_noteblock_csharp",
	d = "mesecons_noteblock_d",
	dsharp = "mesecons_noteblock_dsharp",
	e = "mesecons_noteblock_e",
	f = "mesecons_noteblock_f",
	fsharp = "mesecons_noteblock_fsharp",
	g = "mesecons_noteblock_g",
	gsharp = "mesecons_noteblock_gsharp",
	a = "mesecons_noteblock_a",
	asharp = "mesecons_noteblock_asharp",
	b = "mesecons_noteblock_b",
	c = "mesecons_noteblock_c",
	csharp2 = "mesecons_noteblock_csharp2",
	d2 = "mesecons_noteblock_d2",
	dsharp2 = "mesecons_noteblock_dsharp2",
	e2 = "mesecons_noteblock_e2",
	f2 = "mesecons_noteblock_f2",
	fsharp2 = "mesecons_noteblock_fsharp2",
	g2 = "mesecons_noteblock_g2",
	gsharp2 = "mesecons_noteblock_gsharp2",
	a2 = "mesecons_noteblock_a2",
	asharp2 = "mesecons_noteblock_asharp2",
	b2 = "mesecons_noteblock_b2",
	c2 = "mesecons_noteblock_c2",
	hihat = "mesecons_noteblock_hihat",
	kick = "mesecons_noteblock_kick",
	snare = "mesecons_noteblock_snare",
	crash = "mesecons_noteblock_crash",
	litecrash = "mesecons_noteblock_litecrash",
	fire = "fire_large",
	explosion = "tnt_explode",
	digistuff_piezo_short = "digistuff_piezo_short_single",
	digistuff_piezo_long = "digistuff_piezo_long_single"
}

local mod_sounds = {
	pbj_pup = {
		pbj_pup_barks = "pbj_pup_barks",
		pbj_pup_howl = "pbj_pup_howl"
	},
	anvil = {
		anvil_clang = "anvil_clang"
	},
	bees = {
		bees = "bees"
	},
	bobblocks = {
		bobblocks_glass_block = "bobblocks_glassblock",
		bobblocks_health = "bobblocks_health",
		bobblocks_trap = "bobblocks_trap_fall",
		bobblocks_trap_large = "bobblocks_trap_fall_major"
	},
	fake_fire = {
		fake_fire_extinguish = "fire_extinguish"
	},
	homedecor = {
		homedecor_book_close = "homedecor_book_close",
		homedecor_doorbell = "homedecor_doorbell",
		homedecor_door_close = "homedecor_door_close",
		homedecor_door_open = "homedecor_door_open",
		homedecor_faucet = "homedecor_faucet",
		homedecor_gate = "homedecor_gate_open_close",
		homedecor_shower = "homedecor_shower",
		homedecor_telephone = "homedecor_telephone_ringing",
		homedecor_toilet = "homedecor_toilet_flush",
		homedecor_trash = "homedecor_trash_all",
		homedecor_insert_coin = "insert_coin",
		homedecor_toaster = "toaster"
	},
	infrastructure = {
		infrastructure_emergency_phone = "infrastructure_emergency_phone"
	},
	item_tweaks = {
		item_drop = "item_drop",
		item_pickup = "item_drop_pickup"
	},
	mesecons_button = {
		mesecons_button_push = "mesecons_button_push",
		mesecons_button_pop = "mesecons_button_pop",
	},
	mesecons_pistons = {
		mesecons_piston_extend = "piston_extend",
		mesecons_piston_retract = "piston_retract"
	},
	mesecons_walllever = {
		mesecons_lever = "mesecons_lever"
	},
	technic = {
		technic_chainsaw = "chainsaw",
		technic_mining_drill = "mining_drill",
		technic_laser_mk1 = "technic_laser_mk1",
		technic_laser_mk2 = "technic_laser_mk2",
		technic_laser_mk3 = "technic_laser_mk3",
		technic_prospector_hit = "technic_prospector_hit",
		technic_prospector_miss = "technic_prospector_miss"
	},
	teleport_request = {
		teleport_request_accept = "whoosh"
	},
	unified_inventory = {
		unified_inventory_day = "birds",
		unified_inventory_click = "click",
		unified_inventory_sethome = "dingdong",
		unified_inventory_refill = "electricity",
		unified_inventory_night = "owl",
		unified_inventory_turn_page_1 = "paperflip1",
		unified_inventory_turn_page_2 = "paperflip2",
		unified_inventory_home = "teleport",
		unified_inventory_trash = "trash",
		unified_inventory_clear = "trash_all"
	},
	carts = {
		carts_cart_moving = "carts_cart_moving"
	},
	default = {
		default_break_glass = "default_break_glass",
		default_chest_close = "default_chest_close",
		default_chest_open = "default_chest_open",
		default_cool_lava = "default_cool_lava",
		default_dig_choppy = "default_dig_choppy",
		default_dig_cracky = "default_dig_cracky",
		default_dig_crumbly = "default_dig_crumbly",
		default_dig_dig_immediate = "default_dig_dig_immediate",
		default_dig_metal = "default_dig_metal",
		default_dig_oddly_breakable_by_hand = "default_dig_oddly_breakable_by_hand",
		default_dig_snappy = "default_dig_snappy",
		default_dirt_footstep = "default_dirt_footstep",
		default_dug_metal = "default_dug_metal",
		default_dug_node = "default_dug_node",
		default_glass_footstep = "default_glass_footstep",
		default_grass_footstep = "default_grass_footstep",
		default_gravel_footstep = "default_gravel_footstep",
		default_hard_footstep = "default_hard_footstep",
		default_item_smoke = "default_item_smoke",
		default_metal_footstep = "default_metal_footstep",
		default_place_node = "default_place_node",
		default_place_node_hard = "default_place_node_hard",
		default_place_node_metal = "default_place_node_metal",
		default_sand_footstep = "default_sand_footstep",
		default_snow_footstep = "default_snow_footstep",
		default_tool_breaks = "default_tool_breaks",
		default_water_footstep = "default_water_footstep",
		default_wood_footstep = "default_wood_footstep"
	},
	doors = {
		doors_door_open = "doors_door_open",
		doors_door_close = "doors_door_close",
		doors_gate_open = "doors_fencegate_open",
		doors_gate_close = "doors_fencegate_close",
		doors_glass_door_open = "doors_glass_door_open",
		doors_glass_door_close = "doors_glass_door_close",
		doors_steel_door_open = "doors_steel_door_open",
		doors_steel_door_close = "doors_steel_door_close",
	}
}

for mod,sounds in pairs(mod_sounds) do
	if minetest.get_modpath(mod) then
		for name,file in pairs(sounds) do
			valid_sounds[name] = file
		end
	end
end

return valid_sounds
