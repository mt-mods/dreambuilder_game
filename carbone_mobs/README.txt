=== MOBS-MOD for MINETEST-C55 ===
by PilzAdam

Inroduction:
This mod adds some basic hostile and friendly mobs to the game.

How to install:
Unzip the archive an place it in minetest-base-directory/mods/minetest/
if you have a windows client or a linux run-in-place client. If you have
a linux system-wide instalation place it in ~/.minetest/mods/minetest/.
If you want to install this mod only in one world create the folder
worldmods/ in your worlddirectory.
For further information or help see:
http://wiki.minetest.com/wiki/Installing_Mods

How to use the mod:
See https://github.com/PilzAdam/mobs/wiki

This mod can be configured via following minetest.conf variables: 
( reminder: minetest.conf lines starting with "#" are comments )

* display_mob_spawn = true -> show you a message in the chat when a mob spawns. see https://github.com/PilzAdam/mobs/wiki
* only_peaceful_mobs = true -> "When you add only_peaceful_mobs = true to minetest.conf then all hostile mobs will despawn."
                               "They do spawn, but they immediately despawn." (see https://forum.minetest.net/viewtopic.php?id=551)

So instead you can directly use this to avoid false-alarming spawn messages...
* spawn_friendly_mobs = true -> spawn friendly mobs (sheep, rat)
* spawn_hostile_mobs = true -> spawn hostile  mobs


For developers:
The API documentation is moved to https://github.com/PilzAdam/mobs/wiki/API

Some internal details: 

* armor: lower values means better armor, means you need a better weapon to hurt it.
         see e.g. https://github.com/PilzAdam/mobs/wiki/Dungeon-Master:
         stone sword is OK to attack against armor value of 60.


License:
Sourcecode: WTFPL (see below)
Grahpics: WTFPL (see below)
Models: WTFPL (by Pavel_S, see below)

See also:
http://minetest.net/

         DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO. 
