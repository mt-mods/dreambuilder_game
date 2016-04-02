glooptest.tech_module = {}
glooptest.debug("MESSAGE","Loading Tech Module Now!")

--dofile(minetest.get_modpath("glooptest").."/tech_module/api.lua")

local fixed = {
    { -8/16, -8/16, -8/16, 8/16, -4/16, 8/16 }, -- base
    { -8/16, 3/16, -8/16, 8/16, 8/16, 8/16 }, -- top
    { 3/16, -7/16, 3/16, 7/16, 7/16, 7/16 },
    { 3/16, -7/16, -7/16, 7/16, 7/16, -3/16 },
    { -7/16, -7/16, 3/16, -3/16, 7/16, 7/16 },
    { -7/16, -7/16, -7/16, -3/16, 7/16, -3/16 },
}

-- {used item, produced node}
glooptest.tech_module.table_changers = {
	{},
}

function glooptest.tech_module.register_table(used_item, produced_node)
	if minetest.registered_items[used_item] ~= nil and minetest.registered_items[produced_node] ~= nil then
		table.insert(glooptest.tech_module.table_changers, {item = used_item, node = produced_node})
	end
end

minetest.register_alias("glooptest:table", "glooptest:wooden_table")
minetest.register_node("glooptest:wooden_table", {
    description = "Wooden Table",
    drawtype = "nodebox",
	tiles = {"glooptest_table_tb.png","glooptest_table_tb.png","glooptest_table_side.png"},
	paramtype = "light",
	groups = {choppy=3, snappy=3},
    node_box = {
        type = "fixed",
        fixed = fixed,
    },
	--[[
	on_rightclick = function(pos, node, clicker, itemstack)
		local clicking_item = itemstack
		for ind,content in glooptest.tech_module.table_changers do
			if content.item == clicking_item:get_name() then
				minetest.place_node(pos, {name=content.node})
				return ItemStack(clicking_item:get_name().." "..tostring(clicking_item:get_count()-1))
			end
		end
	end,
	--]]
})

minetest.register_craft({
	output = "glooptest:table",
	recipe = {
		{"group:wood","group:wood","group:wood"},
		{"default:stick","","default:stick"},
		{"group:wood","","group:wood"},
	}
})

minetest.register_craftitem("glooptest:upgrade_core", {
	description = "Upgrade Core",
	inventory_image = "glooptest_upgrade_core.png",
})

minetest.register_craft({
	output = "glooptest:upgrade_core",
	recipe = {
		{"glooptest:akalin_ingot", "glooptest:crystal_glass", "glooptest:akalin_ingot"},
		{"glooptest:crystal_glass", "default:mese_crystal_fragment", "glooptest:crystal_glass"},
		{"glooptest:akalin_ingot", "glooptest:crystal_glass", "glooptest:akalin_ingot"},
	},
})

if LOAD_ORE_MODULE == true then
	minetest.register_craftitem("glooptest:encrusting_upgrade", {
		description = "Encrusting Upgrade",
		inventory_image = "glooptest_encrusting_upgrade.png",
	})
	
	minetest.register_craft({
		output = "glooptest:encrusting_upgrade",
		recipe = {
			{"group:glooptest_gem", "group:glooptest_gem", "group:glooptest_gem"},
			{"glooptest:hammer_steel", "glooptest:upgrade_core", "glooptest:handsaw_steel"},
			{"group:glooptest_gem", "group:glooptest_gem", "group:glooptest_gem"},
		},
	})
end
