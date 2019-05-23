local cave_nodes = { -- Default stairs/slabs/panels/microblocks:
        "caverealms:glow_crystal",
        "caverealms:glow_emerald",
        "caverealms:glow_mese",
        "caverealms:glow_ore",
        "caverealms:glow_emerald_ore",
        "caverealms:glow_ruby",
        "caverealms:glow_amethyst",
        "caverealms:glow_ruby_ore",
        "caverealms:salt_crystal",
        "caverealms:stone_with_salt",
        "caverealms:glow_obsidian",
        "caverealms:glow_obsidian_glass",
        
}
 
    
    for _, name in pairs(cave_nodes) do
	local nodename = "caverealms:"..name
	local a,b = string.find(name, ":")
	if b then
		nodename = name
		name = string.sub(name, b+1)
	end
	local ndef = minetest.registered_nodes[nodename]
	if ndef then
		local drop
		if type(ndef.drop) == "string" then
			drop = ndef.drop:sub((b or 8)+1)
		end

		local tiles = ndef.tiles
		if #ndef.tiles > 1 and ndef.drawtype:find("glass") then
			tiles = { ndef.tiles[1] }
		end

		stairsplus:register_all("caverealms", name, nodename, {
			description = ndef.description,
			drop = drop,
			groups = ndef.groups,
			sounds = ndef.sounds,
			tiles = tiles,
			sunlight_propagates = true,
			light_source = ndef.light_source
		})
	end
end
