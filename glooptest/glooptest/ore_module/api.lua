function glooptest.ore_module.set_tool_recipe(modname,type,material,name)
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

generation_ores = {}

function glooptest.ore_module.register_ore(modname, name, desc, uses)
	if uses.block ~= nil and uses.block.makes ~= false then
		minetest.register_node(modname..":"..name.."block", {
			description = desc.." Block",
			tiles = {uses.block.texture},
			is_ground_content = true,
			light_source = uses.block.light or 0,
			groups = uses.block.groups,
			sounds = uses.block.sounds
		})
		if uses.block.fromingots == true and uses.ingot ~= nil then
			minetest.register_craft({
				output = modname..":"..name.."block",
				recipe = {
					{modname..":"..name.."_ingot", modname..":"..name.."_ingot", modname..":"..name.."_ingot"},
					{modname..":"..name.."_ingot", modname..":"..name.."_ingot", modname..":"..name.."_ingot"},
					{modname..":"..name.."_ingot", modname..":"..name.."_ingot", modname..":"..name.."_ingot"}
				}
			})
			minetest.register_craft({
				output = modname..":"..name.."_ingot 9",
				recipe = {
					{modname..":"..name.."block"}
				}
			})
		end
	end
	if uses.ore ~= nil and uses.ore.makes ~= false then
		minetest.register_node(modname..":mineral_"..name, {
			description = desc.." Ore",
			tiles = {uses.ore.texture.base.."^"..uses.ore.texture.overlay},
			is_ground_content = true,
			drop = uses.ore.drop,
			light_source = uses.ore.light or 0,
			groups = uses.ore.groups,
			sounds = uses.ore.sounds
		})
		minetest.register_ore({
			ore_type       = "scatter",
			ore            = modname..":mineral_"..name,
			wherein        = uses.ore.generate.generate_inside_of,
			clust_scarcity = uses.ore.generate.chunks_per_mapblock,
			clust_num_ores = uses.ore.generate.max_blocks_per_chunk,
			clust_size     = uses.ore.generate.chunk_size,
			y_min     = uses.ore.generate.miny,
			y_max     = uses.ore.generate.maxy,
		})
	end
	if uses.lump ~= nil and uses.lump.makes ~= false then
		minetest.register_craftitem(modname..":"..name.."_"..uses.lump.name, {
			description = desc.." "..uses.lump.desc,
			inventory_image = uses.lump.texture,
		})
	end
	if uses.ingot ~= nil and uses.ingot.makes ~= false then
		minetest.register_craftitem(modname..":"..name.."_ingot", {
			description = desc.." Ingot",
			inventory_image = uses.ingot.texture,
		})
		if uses.ingot.smeltrecipe == true and uses.lump ~= nil then
			minetest.register_craft({
				type = "cooking",
				output = modname..":"..name.."_ingot",
				recipe = modname..":"..name.."_"..uses.lump.name,
			})
		end
	end
	if uses.tools ~= nil and uses.tools.make ~= nil then
		if uses.tools.make.sword == true then
			minetest.register_tool(modname..":sword_"..name, {
				description = desc.." Sword",
				inventory_image = uses.tools.texture.sword,
				tool_capabilities = uses.tools.caps.sword,
			})
			glooptest.ore_module.set_tool_recipe(modname,"sword",modname..":"..name.."_ingot",name)
		end
		if uses.tools.make.axe == true then
			minetest.register_tool(modname..":axe_"..name, {
				description = desc.." Axe",
				inventory_image = uses.tools.texture.axe,
				tool_capabilities = uses.tools.caps.axe,
			})
			glooptest.ore_module.set_tool_recipe(modname,"axe",modname..":"..name.."_ingot",name)
		end
		if uses.tools.make.pick == true then
			minetest.register_tool(modname..":pick_"..name, {
				description = desc.." Pickaxe",
				inventory_image = uses.tools.texture.pick,
				tool_capabilities = uses.tools.caps.pick,
			})
			glooptest.ore_module.set_tool_recipe(modname,"pick",modname..":"..name.."_ingot",name)
		end
		if uses.tools.make.shovel == true then
			minetest.register_tool(modname..":shovel_"..name, {
				description = desc.." Shovel",
				inventory_image = uses.tools.texture.shovel,
				wield_image = uses.tools.texture.shovel.."^[transformR90",
				tool_capabilities = uses.tools.caps.shovel,
			})
			glooptest.ore_module.set_tool_recipe(modname,"shovel",modname..":"..name.."_ingot",name)
		end
	end
end
