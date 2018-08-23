=-=-=-=-=-=-=-=-=-=

Castles Mod
by: Philipbenr And DanDuncombe

=-=-=-=-=-=-=-=-=-=

Licence: MIT

see: LICENSE

=-=-=-=-=-=-=-=-=-=

This mod adds decorative wall-mounted shields. It comes with three default shields, but it's very easy to mix and match the colours and patterns to generate additional shields for your server; see default_shields.lua for a good place to insert your own, or make use of the castle_shields.register_shield method in your own mods.

The three default shields were defined thusly:

castle_shields.register_shield("shield_1", "Mounted Shield", "red", "blue", "slash")
castle_shields.register_shield("shield_2", "Mounted Shield", "cyan", "yellow", "chevron")
castle_shields.register_shield("shield_3", "Mounted Shield", "grey", "green", "cross")

The following colors are permitted:
 "black", "blue", "brown", "cyan", "dark_green", "dark_grey", "green", "grey", "magenta", "orange", "pink", "red", "violet", "white", "yellow"
The following patterns are permitted:
 "slash", "chevron", "cross"