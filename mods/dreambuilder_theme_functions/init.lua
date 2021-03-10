-- This mod just supplies helpers to build slot backgrounds for mods that use formspec v1

dreambuilder_theme = {}

function dreambuilder_theme.single_slot_v1(xpos, ypos, bright)
	return string.format("background9[%f,%f;%f,%f;%s_ui_single_slot%s.png;false;16]",
	xpos, ypos, 1, 1.08, dreambuilder_theme.name, (bright and "_bright" or "") )
end

function dreambuilder_theme.make_inv_img_grid_v1(xpos, ypos, width, height, bright)
	local tiled = {}
	local n=1
	for y = 0, (height - 1) do
		for x = 0, (width -1) do
			tiled[n] = dreambuilder_theme.single_slot_v1(xpos + x, ypos + y, bright)
			n = n + 1
		end
	end
	return table.concat(tiled)
end
