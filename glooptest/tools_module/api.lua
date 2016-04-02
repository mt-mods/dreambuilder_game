function glooptest.tools_module.set_tool_recipe(modname,type,material,name)
	if type == "sword" then
		minetest.register_craft({
			recipe = {{material},{material},{"default:stick"}},
			output = modname..":sword_"..name,
		})
	end
	if type == "axe" then
		minetest.register_craft({
			recipe = {{material, material}, {material, "default:stick"}, {"","default:stick"}},
			output = modname..":axe_"..name,
		})
		minetest.register_craft({
			recipe = {{material, material}, {"default:stick", material}, {"default:stick", ""}},
			output = modname..":axe_"..name,
		})
	end
	if type == "pick" or type == "pickaxe" then
		minetest.register_craft({
			recipe = {{material, material, material}, {"","default:stick",""}, {"","default:stick",""}},
			output = modname..":pick_"..name,
		})
	end
	if type == "shovel" then
		minetest.register_craft({
			recipe = {{material},{"default:stick"},{"default:stick"}},
			output = modname..":shovel_"..name,
		})
	end
	if type == "handsaw" then
		minetest.register_craft({
			recipe = {{material, "default:stick"},{material, "default:stick"},{"", "default:stick"}},
			output = modname..":handsaw_"..name,
		})
		minetest.register_craft({
			recipe = {{"default:stick", material},{"default:stick", material},{"default:stick", ""}},
			output = modname..":handsaw_"..name,
		})
	end
	if type == "hammer" then
		minetest.register_craft({
			recipe = {{material, "default:stick", material}, {material, "default:stick", material}, {"", "default:stick", ""}},
			output = modname..":hammer_"..name,
		})
	end
end

function glooptest.tools_module.register_tools(modname, name, desc, material, uses)
	if uses.handsaw ~= nil and uses.handsaw.makes ~= false then
		minetest.register_tool(modname..":handsaw_"..name, {
			description = desc.." Handsaw",
			inventory_image = uses.handsaw.texture,
			tool_capabilities = uses.handsaw.caps,
		})
		glooptest.tools_module.set_tool_recipe(modname,"handsaw",material,name)
	end
	if uses.hammer ~= nil and uses.hammer.makes ~= false then
		minetest.register_tool(modname..":hammer_"..name, {
			description = desc.." Hammer",
			inventory_image = uses.hammer.texture,
			tool_capabilities = uses.hammer.caps,
		})
		glooptest.tools_module.set_tool_recipe(modname,"hammer",material,name)
	end
	if uses.sword ~= nil and uses.sword.makes ~= false then
		minetest.register_tool(modname..":sword_"..name, {
			description = desc.." Sword",
			inventory_image = uses.sword.texture,
			tool_capabilities = uses.sword.caps,
		})
		glooptest.tools_module.set_tool_recipe(modname,"sword",material,name)
	end
	if uses.axe ~= nil and uses.axe.makes ~= false then
		minetest.register_tool(modname..":axe_"..name, {
			description = desc.." Axe",
			inventory_image = uses.axe.texture,
			tool_capabilities = uses.axe.caps,
		})
		glooptest.tools_module.set_tool_recipe(modname,"axe",material,name)
	end
	if uses.pick ~= nil and uses.pick.makes ~= false then
		minetest.register_tool(modname..":pick_"..name, {
			description = desc.." Pickaxe",
			inventory_image = uses.pick.texture,
			tool_capabilities = uses.pick.caps,
		})
		glooptest.tools_module.set_tool_recipe(modname,"pick",material,name)
	end
	if uses.shovel ~= nil and uses.shovel.makes ~= false then
		minetest.register_tool(modname..":shovel_"..name, {
			description = desc.." Shovel",
			inventory_image = uses.shovel.texture,
			wield_image = uses.shovel.texture.."^[transformR90",
			tool_capabilities = uses.shovel.caps,
		})
		glooptest.tools_module.set_tool_recipe(modname,"shovel",material,name)
	end
end