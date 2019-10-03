-- Class-OM signs

local S = signs_lib.gettext
local cbox = signs_lib.make_selection_boxes(12, 36, nil)

for _, d in ipairs({"l", "c", "r"}) do
	signs_lib.register_sign("street_signs:sign_object_marker_type3_"..d, {
		description = "OM3-"..string.upper(d)..": Type 3 object marker",
		selection_box = cbox,
		mesh = "street_signs_object_marker_type_3_wall.obj",
		tiles = {
			"street_signs_object_marker_type3_"..d..".png",
			"street_signs_sign_edge.png"
		},
		inventory_image = "street_signs_object_marker_type3_"..d.."_inv.png",
		groups = signs_lib.standard_steel_groups,
		sounds = signs_lib.standard_steel_sign_sounds,
		allow_onpole = true,
		uses_slim_pole_mount = true,
	})
end
