minetest.register_craft({
	output = 'prefab:concrete 4',
	recipe = {
		{'default:stone', 'default:gravel', 'default:stone'},
		{'default:gravel', 'default:stone', 'default:gravel'},
		{'default:stone', 'default:gravel', 'default:stone'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_with_grass',
	recipe = {
		{'default:grass_1'},
		{'prefab:concrete'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_wall 3',
	recipe = {
		{'prefab:concrete'},
		{'prefab:concrete'},
		{'prefab:concrete'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_stair 4',
	recipe = {
		{'prefab:concrete', '', ''},
		{'prefab:concrete', 'prefab:concrete', ''},
		{'prefab:concrete', 'prefab:concrete', 'prefab:concrete'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_stair_inverted',
	recipe = {
		{'prefab:concrete_stair'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_slab 6',
	recipe = {
		{'prefab:concrete', 'prefab:concrete', 'prefab:concrete'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_slab_inverted',
	recipe = {
		{'prefab:concrete_slab'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_slit 4',
	recipe = {
		{'prefab:concrete', 'prefab:concrete', 'prefab:concrete'},
		{'', '', ''},
		{'prefab:concrete', 'prefab:concrete', 'prefab:concrete'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_window 6',
	recipe = {
		{'prefab:concrete', 'prefab:concrete', 'prefab:concrete'},
		{'prefab:concrete', 'default:glass', 'prefab:concrete'},
		{'prefab:concrete', 'prefab:concrete', 'prefab:concrete'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_ladder',
	recipe = {
		{'prefab:concrete'},
		{'default:ladder'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_fence',
	recipe = {
		{'prefab:concrete'},
		{'default:fence_wood'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_door',
	recipe = {
		{'prefab:concrete'},
		{'doors:door_wood'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_cylinder 4',
	recipe = {
		{'prefab:concrete','','prefab:concrete'},
		{'prefab:concrete','','prefab:concrete'},
		{'prefab:concrete','','prefab:concrete'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_bollard 2',
	recipe = {
		{'prefab:concrete_slab'},
		{'prefab:concrete_fence'},
		{'prefab:concrete_slab'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_bench 2',
	recipe = {
		{'prefab:concrete_slab'},
		{'prefab:concrete_fence'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_railing 2',
	recipe = {
		{'prefab:concrete_fence','prefab:concrete_fence'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_railing_corner 2',
	recipe = {
		{'prefab:concrete_railing','prefab:concrete_railing'},
	}
})

minetest.register_craft({
	output = 'prefab:electric_fence 2',
	recipe = {
		{'default:steel_ingot','default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'prefab:electric_fence_corner 2',
	recipe = {
		{'prefab:electric_fence','prefab:concrete_fence'},
		{'','prefab:electric_fence'},
	}
})

minetest.register_craft({
	output = 'prefab:electric_fence_end',
	recipe = {
		{'prefab:concrete_fence','default:steel_ingot'},
	}
})

minetest.register_craft({
	output = 'prefab:concrete_catwalk 4',
	recipe = {
		{'prefab:concrete_railing','','prefab:concrete_railing'},
		{'prefab:concrete_slab','prefab:concrete_slab','prefab:concrete_slab'},
	}
})