
notice = { }

function notice.send(target, text)
	local player = minetest.get_player_by_name(target)
	if not player then
		return false, ("There's no player named '%s'."):format(target)
	end
	local fs = { }
	--[[
	for _, line in ipairs(text:split("|")) do
		table.insert(fs, ("label[1,%f;%s]"):format(y+1, minetest.formspec_escape(line)))
		y = y + 0.5
	end
	--]]
	local lines = { }
	for i, line in ipairs(text:split("|")) do
		local lt = { }
		for i = 1, #line, 40 do
			table.insert(lt, line:sub(i, i+39))
		end
		lines[i] = table.concat(lt, "\n")
	end
	text = table.concat(lines, "\n")
	text = minetest.formspec_escape(text)
	table.insert(fs, "size[8,4]")
	table.insert(fs, "label[1,.2;"..text.."]")
	table.insert(fs, "button_exit[3,3.2;2,0.5;ok;OK]")
	fs = table.concat(fs)
	minetest.after(0.5, function()
		minetest.show_formspec(target, "notice:notice", fs)
	end)
	return true
end

minetest.register_privilege("notice", "Send notices to players.")

minetest.register_chatcommand("notice", {
	params = "<player> <text>",
	privs = { notice=true, },
	description = "Show a notice to a player.",
	func = function(name, params)
		local target, text = params:match("(%S+)%s+(.+)")
		if not (target and text) then
			return false, "Usage: /notice <player> <text>"
		end
		local ok, err = notice.send(target, text)
		if not ok then
			return false, err
		end
		return true, "Notice sent!"
	end,
})