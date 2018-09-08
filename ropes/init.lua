ropes = {
  name = 'ropes',
}

-- internationalization boilerplate
local MP = minetest.get_modpath(minetest.get_current_modname())
local S, NS = dofile(MP.."/intllib.lua")

ropes.ropeLength = tonumber(minetest.settings:get("ropes_rope_length")) or 50
ropes.ropeLadderLength = tonumber(minetest.settings:get("ropes_rope_ladder_length")) or 50
ropes.woodRopeBoxMaxMultiple = tonumber(minetest.settings:get("ropes_wood_rope_box_max_multiple")) or 2
ropes.copperRopeBoxMaxMultiple = tonumber(minetest.settings:get("ropes_copper_rope_box_max_multiple")) or 5
ropes.steelRopeBoxMaxMultiple = tonumber(minetest.settings:get("ropes_steel_rope_box_max_multiple")) or 9
ropes.create_all_definitions = minetest.settings:get_bool("ropes_create_all_definitions")

dofile( minetest.get_modpath( ropes.name ) .. "/doc.lua" )
dofile( minetest.get_modpath( ropes.name ) .. "/functions.lua" )
dofile( minetest.get_modpath( ropes.name ) .. "/crafts.lua" )
dofile( minetest.get_modpath( ropes.name ) .. "/ropeboxes.lua" )
dofile( minetest.get_modpath( ropes.name ) .. "/ladder.lua" )
dofile( minetest.get_modpath( ropes.name ) .. "/loot.lua" )


for i=1,5 do
	minetest.register_alias(string.format("vines:%irope_block", i), string.format("ropes:%irope_block", i))
end
minetest.register_alias("vines:rope", "ropes:rope")
minetest.register_alias("vines:rope_bottom", "ropes:rope_bottom")
minetest.register_alias("vines:rope_end", "ropes:rope_bottom")
minetest.register_alias("vines:rope_top", "ropes:rope_top")
minetest.register_alias("vines:ropeladder_top", "ropes:ropeladder_top")
minetest.register_alias("vines:ropeladder", "ropes:ropeladder")
minetest.register_alias("vines:ropeladder_bottom", "ropes:ropeladder_bottom")
minetest.register_alias("vines:ropeladder_falling", "ropes:ropeladder_falling")
minetest.register_alias("vines:rope_block", "ropes:steel5rope_block")
for i=1,9 do
	minetest.register_alias(string.format("ropes:%irope_block", i), string.format("ropes:steel%irope_block", i))
end
minetest.register_alias("castle:ropes", "ropes:rope")
minetest.register_alias("castle:ropebox", "ropes:steel1rope_block")
minetest.register_alias("castle:box_rope", "ropes:rope")

print(S("[Ropes] Loaded!"))
