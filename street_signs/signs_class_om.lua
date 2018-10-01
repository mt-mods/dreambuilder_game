-- Class-OM signs

local S = street_signs.gettext
local cbox

for _, d in ipairs({"l", "c", "r"}) do

	cbox = street_signs.make_selection_boxes(12, 36, nil)

	minetest.register_node("street_signs:sign_object_marker_type3_"..d, {
		description = "OM3-"..string.upper(d)..": Type 3 object marker",
		paramtype = "light",
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		drawtype = "mesh",
		node_box = cbox,
		selection_box = cbox,
		mesh = "street_signs_object_marker_type_3.obj",
		tiles = { "street_signs_object_marker_type3_"..d..".png",
			"street_signs_sign_edge.png"
		},
		inventory_image = "street_signs_object_marker_type3_"..d.."_inv.png",
		groups = {choppy=2, dig_immediate=2},
	})
end
