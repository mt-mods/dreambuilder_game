-- Convert old road/streets modpack signs to street_signs versions

local S = street_signs.gettext

if minetest.get_modpath("infrastructure") then
	local signs_equiv = {
		["infrastructure:road_sign_stop"]              = "street_signs:sign_stop",
		["infrastructure:road_sign_stop_on_post"]      = "street_signs:sign_stop_onpole",
		["infrastructure:road_sign_yield"]             = "street_signs:sign_yield",
		["infrastructure:road_sign_yield_on_post"]     = "street_signs:sign_yield_onpole",
		["infrastructure:road_sign_crosswalk"]         = "street_signs:sign_pedestrian_crossing",
		["infrastructure:road_sign_crosswalk_on_post"] = "street_signs:sign_pedestrian_crossing_onpole",
	}

	local old_signs = {}

	for old, new in pairs(signs_equiv) do
		minetest.unregister_item(old)
		if not string.find(old, "on_post") then
			minetest.clear_craft({output = old})
		end
		old_signs[#old_signs+1] = old
	end

	minetest.register_alias_force("infrastructure:road_sign_retroreflective_surface", "air")
	minetest.register_alias_force("infrastructure:crosswalk_safety_sign_bottom", "street_signs:sign_stop_for_ped")
	minetest.register_alias_force("infrastructure:crosswalk_safety_sign_top", "air")

	minetest.register_lbm({
		nodenames = old_signs,
		name = "street_signs:convert_signs",
		label = "Convert roads/streets modpack signs",
		run_at_every_load = true,
		action = function(pos, node)
			local newname = signs_equiv[node.name]
			local dir = minetest.facedir_to_dir(node.param2)
			if not dir then return end
			minetest.set_node(pos, {name = newname, param2 = minetest.dir_to_wallmounted(dir)})
		end
	})
end
