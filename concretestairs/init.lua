--[[
	StreetsMod: Concrete stairs (compatible to circular saw)
]]
if rawget(_G, "register_stair_slab_panel_micro")
and type(register_stair_slab_panel_micro) == "function" then
	register_stair_slab_panel_micro("streets", "concrete", "basic_materials:concrete_block", {cracky=2}, {"basic_materials_concrete_block.png"}, "Concrete", "concrete", nil)
	table.insert(circular_saw.known_stairs,"basic_materials:concrete_block")
	minetest.register_alias("stairs:stair_concrete","streets:stair_concrete")
else
	minetest.register_alias("stairs:stair_concrete","prefab:concrete_stair")
	minetest.register_alias("stairs:slab_concrete","prefab:concrete_slab")
end
