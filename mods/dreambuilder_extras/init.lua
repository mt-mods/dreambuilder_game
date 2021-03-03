-- The actual "mod part" of this "extras" folder just suplies 3d apples
--  and makes the lavacooling a bit more random and hence natural-loking.
--
-- by Vanessa Dannenberg

default.cool_lava = function (pos, node) end

minetest.register_abm({
	nodenames = {"default:lava_source", "default:lava_flowing"},
	neighbors = {"group:water"},
	interval = 5,
	chance = 15,
	catch_up = false,
	action = function(...)
		default.cool_lava(...)
	end,
})

minetest.override_item("default:apple", {
	drawtype = "mesh",
	mesh = "default_apple.obj",
	tiles = {"default_apple_3d.png"}
})
