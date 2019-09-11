Api:
notify.hud.sendtext(mt_player player, string text, optional int timeout)

usage:
add notify_hud_provider as an optional dependency to your mod,
and then check for the existance of the above api call before using it

You may call it like so for example
notify.hud.sendtext(minetest.get_player_by_name("bentaphile", "Hey there", 10)

or, for example if you are in a hook that already is in possesion of a player object
notify.hud.sendtext(player, "Your " .. tool .. " Has been repaired!", 5)


(This, so that subgames may provide their own implementation, without having to use the same modname, this also allows another mod to take this name to overide the subgame)

