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
