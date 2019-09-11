notify = notify or {}
notify.hud = notify.hud or {}

-- the only API gurantee is that notify.hud.sendtext(mt_player player, string text, optional int timeout) is available
minetest.register_on_joinplayer(function(player)
	--register the hud elements to use later
	--this is a simple implementation, so just one

	local hud_fg = player:hud_add({
		hud_elem_type = "text",
		position = { x=0.5,y=0.8 },
		text = "",
		direction = 0,
		number = "0xFFFFFF"
		})
	player:get_meta():set_int("notify_fg", hud_fg)
end)

notify.hud.sendtext = function(player, text, timeout)
	if not player then return end
	if not text then return end
	if timeout <= 0 or not timeout then timeout = 1 end
	minetest.after(1, notify.hud.timeout, player)
	player:get_meta():set_int("time_left", timeout)
	player:hud_change(player:get_meta():get_int("notify_fg"), "text", text)
end

notify.hud.timeout = function(player) -- checks whether player timed out yet
	if not player then return end
	local timeout = player:get_meta():get_int("time_left")
	timeout = timeout -1
	if timeout <= 0 then
		player:hud_change(player:get_meta():get_int("notify_fg"), "text", "")
	else
		player:get_meta():set_int("time_left", timeout)
		minetest.after(1, notify.hud.timeout, player)
	end
end
