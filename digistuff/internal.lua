digistuff.mesecons_installed = minetest.get_modpath("mesecons")

digistuff.rotate_rules = function(rulesin,dir)
	local rules = {}
	for k,v in ipairs(rulesin) do rules[k] = v end
	if dir.z > 0 then
		return rules
	elseif dir.z < 0 then
		for _,i in ipairs(rules) do
			i.x = -i.x
			i.z = -i.z
		end
		return rules
	elseif dir.x > 0 then
		for _,i in ipairs(rules) do
			local z = i.x
			i.x = i.z
			i.z = -z
		end
		return rules
	elseif dir.x < 0 then
		for _,i in ipairs(rules) do
			local z = i.x
			i.x = -i.z
			i.z = z
		end
		return rules
	elseif dir.y > 0 then
		for _,i in ipairs(rules) do
			local z = i.y
			i.y = i.z
			i.z = z
		end
		return rules
	elseif dir.y < 0 then
		for _,i in ipairs(rules) do
			local z = i.y
			i.y = -i.z
			i.z = -z
		end
		return rules
	else
		minetest.log("warning",string.format("digistuff.rotate_rules() called with invalid direction %s,%s,%s",dir.x,dir.y,dir.z))
		return {}
	end
end

digistuff.check_protection = function(pos,player)
	assert(type(pos) == "table","Position must be a table")
	assert(type(player) == "string" or type(player) == "userdata","Invalid player specified")
	if type(player) == "userdata" then player = player:get_player_name() end
	if minetest.is_protected(pos,player) and not minetest.check_player_privs(player,{protection_bypass=true}) then
		minetest.record_protection_violation(pos,player)
		return false
	end
	return true
end
