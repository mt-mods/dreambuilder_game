# Overview

Dreambuilder is my attempt to give the player pretty much everything they'll ever want to build with, and all the tools they should ever need to actually get the job done.  Of course, needs change, but this game should be a pretty good start!

This game is in use on [url=https://forum.minetest.net/viewtopic.php?f=10&t=4057]my Creative server[/url] and on [url=https://forum.minetest.net/viewtopic.php?id=7017]my Survival server[/url], which also have extra mods installed for their specific needs (admin stuff mostly).  They should give you a pretty good idea nonetheless.  Expect lag, as they're both significantly-developed multiplayer servers, after all.

##

# What's in it?  What's changed from the default stuff?

* The complete Plantlife Modpack along with More Trees add a huge amount of variation to your landscape (as a result, they will add mapgen lag).  Active spawning of Horsetail ferns is disabled by default, and I've added papyrus growth on dirt/grass with leaves (using a copy of the default growth ABM).
* This game includes RealBadAngel's Unified Inventory mod, which overrides minetest_game's default inventory to give you a much more powerful user interface, with crafting guide, bags, and much more.
* The default hotbar HUD holds 16 items instead of 8, taken from the top two rows of your inventory.  You can use [icode]/hotbar ##[/icode] (8, 16, 24, or 32) to change the number of slots.  Your setting is retained across restarts.
* The default lavacooling code has been supplanted by better, safer code from my Gloop Blocks mod.  That mod also provides stone/cobble --> mossy stone/cobble transformation in the presence of water.
* An extensive selection of administration tools for single-player and server use are included, such as areas, maptools, worldedit, xban, and more.
* A few textures here and there are different from their defaults.
* By way of Technic, all locked chests use a padlock in their recipes instead of a steel ingot. 
 Most other locked items work this way, too.
* The mapgen won't spawn apples on default trees, nor will they appear on a sapling-grown default tree. Only the *real* apple trees supplied by the More Trees mod will bear apples (both at mapgen time and sapling-grown).  While on that subject, apples now use a 3d model instead of the plantlike version.
* A whole boatload of other mods have been added, which is where most of the content actually comes from.  To be a little more specific, as of Feb. 2021, this game has a total of 209 mods (counting all of the various sub-mods that themselves are normally as part of some modpack, such as Mesecons, Home Decor, Roads, etc.) and supplies over 3000 items in the inventory/craft guide, and tens of thousands of unique items in total (counting everything that isn't displayed in the inventory)!

##  

# Okay, what else?

A whole boatload of other mods have been added, which is where most of the content actually comes from. To be a little more specific, as of February 2021, this game has a total of 208 mods (counting all of the various components that themselves come as part of some modpack, such as mesecons or homedecor) and supplies over 3100 items in the inventory/craft guide (there are tens of thousands of unique items in total, counting everything that isn't displayed in the inventory)!

A complete list of mods is as follows:

* Ambience (TenPlus1; https://notabug.org/TenPlus1/ambience)
* Arrowboards (cheapie; https://cheapiesystems.com/git/arrowboards/)
* Bakedclay (TenPlus1; https://notabug.org/TenPlus1/bakedclay)
* Basic materials (https://gitlab.com/VanessaE/basic_materials)
* Basic signs (https://gitlab.com/VanessaE/basic_signs)
* Bedrock (Calinou; https://github.com/Calinou/bedrock)
* Bees (bas080; TenPlus1's fork; https://notabug.org/TenPlus1/bees)
* Biome lib (https://gitlab.com/VanessaE/biome_lib) 
* Blox (my fork; https://gitlab.com/VanessaE/blox)
* Bobblocks (RabbiBob; no traps or mesecons support; https://github.com/minetest-mods/BobBlocks)
* Bonemeal (TenPlus1; https://notabug.org/TenPlus1/bonemeal)
* Caverealms lite (Ezhh; https://github.com/Ezhh/caverealms_lite)
* Cblocks (TenPlus1; https://notabug.org/TenPlus1/cblocks)
* Coloredwood (https://gitlab.com/VanessaE/coloredwood)
* Cottages (Sokomine; https://github.com/Sokomine/cottages)
* Currency (DanDuncombe; my fork; https://gitlab.com/VanessaE/currency)
* Datastorage (RealBadAngel; https://github.com/minetest-technic/datastorage)
* Digidisplay (cheapie; https://cheapiesystems.com/git/digidisplay/)
* Digilines (Jeija; https://github.com/minetest-mods/digilines)
* Digistuff (cheapie; https://cheapiesystems.com/git/digistuff/)
* Display blocks (jojoa1997; cheapie's "redo" fork, https://cheapiesystems.com/git/display_blocks_redo/)
* Dreambuilder hotbar (https://gitlab.com/VanessaE/dreambuilder_hotbar)
* Extra stairsplus (deezl)
* Facade (Tumeninodes; https://github.com/TumeniNodes/facade)
* Farming (TenPlus1's "redo" fork; https://notabug.org/TenPlus1/farming)
* Framedglass (RealBadAngel; https://github.com/minetest-mods/framedglass)
* Function delayer (HybridDog; https://github.com/HybridDog/function_delayer)
* Gardening (philipbenr; https://forum.minetest.net/viewtopic.php?t=6575)
* Gloopblocks (Nekogloop; my fork; https://gitlab.com/VanessaE/gloopblocks)
* Glooptest (Nekogloop; https://github.com/GloopMaster/glooptest; no treasure chests)
* Ilights (DanDuncombe; my fork; https://gitlab.com/VanessaE/ilights)
* Invsaw (cheapie; https://cheapiesystems.com/git/invsaw/)
* Item drop (PilzAdam; https://github.com/minetest-mods/item_drop)
* Jumping (Jeija; https://github.com/minetest-mods/jumping)
* Led marquee (https://gitlab.com/VanessaE/led_marquee)
* Locks (Sokomine; https://github.com/Sokomine/locks)
* Maptools (Calinou; https://github.com/minetest-mods/maptools)
* Memorandum (Mossmanikin; https://github.com/Mossmanikin/memorandum)
* Moreblocks (Calinou; https://github.com/minetest-mods/moreblocks)
* Moreores (Calinou; https://github.com/minetest-mods/moreores)
* Moretrees (https://gitlab.com/VanessaE/moretrees)
* Mymillwork (DonBatman; laza83's smooth meshes fork; https://github.com/laza83/mymillwork)
* New campfire (googol; my fork; https://gitlab.com/VanessaE/new_campfire)
* Nixie tubes (https://gitlab.com/VanessaE/nixie_tubes)
* Pipeworks (https://gitlab.com/VanessaE/pipeworks)
* Plasticbox (cheapie; https://cheapiesystems.com/git/plasticbox/)
* Player textures (Pilzadam; CWz's fork, with several default skins; )
* Prefab redo (DanDuncombe; cheapie's "redo" fork; https://cheapiesystems.com/git/prefab_redo/)
* Quartz (4Evergreen4; https://github.com/minetest-mods/quartz)
* Replacer (Sokomine; CWz's fork; https://github.com/ChaosWormz/replacer )
* Rgblightstone (cheapie; https://cheapiesystems.com/git/rgblightstone/)
* Signs lib (https://gitlab.com/VanessaE/signs_lib)
* Simple streetlights (https://gitlab.com/VanessaE/simple_streetlights)
* Solidcolor (cheapie; https://cheapiesystems.com/git/solidcolor/)
* Stained glass (doyousketch2; https://github.com/minetest-mods/stained_glass)
* Steel (Zeg9; my fork; https://gitlab.com/VanessaE/steel)
* Street signs (https://gitlab.com/VanessaE/street_signs)
* Titanium (Aqua; HybridDog's fork; https://github.com/HybridDog/titanium)
* Travelnet (Sokomine; https://github.com/Sokomine/travelnet)
* Ufos (Zeg9; https://github.com/Zeg9/minetest-ufos/)
* Unifiedbricks (wowiamdiamonds; https://github.com/minetest-mods/unifiedbricks)
* Unifieddyes (https://gitlab.com/VanessaE/unifieddyes)
* Unified inventory (RealBadAngel; https://github.com/minetest-mods/unified_inventory)
* Unifiedmesecons (cheapie; https://cheapiesystems.com/git/unifiedmesecons/)
* Windmill (Sokomine; https://github.com/Sokomine/windmill)


Modpacks:


* Castle-Modpack (philipbenr; minus the orbs; https://github.com/minetest-mods/castle)
* Cool trees modpack (runsy; https://github.com/runsy/cool_trees/)
* Homedecor modpack (https://gitlab.com/VanessaE/homedecor_modpack) 
* Mesecons modpack (Jeija; https://github.com/minetest-mods/mesecons)
* Plantlife modpack (https://gitlab.com/VanessaE/plantlife_modpack)
* Roads modpack (cheapie; https://cheapiesystems.com/git/roads/)
* Technic modpack (RealBadAngel; https://github.com/minetest-mods/technic)
* Worldedit modpack (Uberi; https://github.com/Uberi/Minetest-WorldEdit)


Base game content imported from minetest_game:


* beds
* binoculars
* boats
* bucket
* butterflies
* carts
* creative
* default
* doors
* dungeon_loot
* dye
* env_sounds
* fire
* fireflies
* flowers
* game_commands
* give_initial_stuff
* map
* player_api
* screwdriver
* sfinv
* spawn
* stairs
* vessels
* walls
* weather
* wool
* xpanes


### Your Inventory Display

This game, as previously mentioned, replaces the standard inventory with Unified Inventory, which almost defies description here.  Unified Inventory includes waypoints, a crafting guide, set/go home buttons, set day/set night buttons, a full creative inventory on the right if you're playing in that mode - and you only have to click/tap the item once to get the it, instead of multiple clicks/drag and drop, a trash slot, a clear all inventory button, a search feature for the inventory, and more.  Basically, you just need to use it a few times and you'll find yourself wondering how you ever got along with the standard inventory!

### The Table Saw

This game uses the More Blocks mod, which comes with Sokomine's Stairsplus, with its table saw component.  This mod replaces the traditional method of creating stairs, slabs, and the like:  rather that crafting a stairs block by placing several of the material into your crafting grid, you must first craft a table saw, place that on the ground, and then use that to shape the material you had in mind.  It can create dozens of shapes, including the standard stairs and slabs.  Give it a try and see for yourself!

### Land Ownership

This game uses ShadowNinja's areas mod for land protection, and also has cheapie's areasprotector, which supplies simple protection blocks, using areas as the backend.  For more info on the areas mod, visit [url=https://forum.minetest.net/viewtopic.php?t=7239]the forum thread for it[/url].  cheapie's mod can be found on [url=https://cheapiesystems.com/git/areasprotector/]her git repository[/url].  Of course, these mods are only useful if you're running a multi-player server.
What's it look like?  Screenshots or it didn't happen!

These are a few examples of what can be found or built with this game.  Most of these screenshots came from my Creative server, since it has plenty of content just ripe for this purpose. :-)

Wide angle view of Dopium Estate:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/dopium-estate.png
Close-up view of the reactor on Dopium Estate:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/dopium-reactor.png
KikaRz's House:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/kikarz-estate.png
Just a tiny portion of CrazyGinger72's epic racetrack:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/cg72-racetrack.png
CG72's skyscraper near the racetrack:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/cg72-tower.png
A cubicle farm in another of CG72's office buildings:
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/cg72-office.png
A cave realm deep underground on one of my test worlds
http://daconcepts.com/vanessa/hobbies/minetest/screenshots/Dreambuilder/caverealm.png

## Dependencies:
This game requires Minetest 5.4.0 or later.

## Hardware requirements:
This game defines a very large number of items and produces a well-detailed landscape, and so it requires a significant amount of resources.  At least a 2 GHz dual core CPU and 4 GB free RAM are required for good performance.  If you use my HDX texture pack, you'll need a LOT more RAM.

This game is NOT recommended for use on mobile devices (though some newer devices, say from mid-2018 or later, may work okay).

## Download:
...if you're reading this, you're either on the Dreambuilder Gitlab repo page, so clone it from there, or download the ZIP from the button at the top of this repository page... or maybe you already have it. ;-)

## Install:
If you downloaded the zip, just extract it and rename the resultant directory to "dreambuilder_game", if necessary.  If you're using the git repository, just clone it and keep the name as-is.

Move it to your Minetest games directory.  When you start Minetest, you'll notice a little red "house" icon at the bottom of the main menu.  Click that to select Dreambuilder, then create or select a world as you see fit.

Depending on the conditions of the world, this game may take as much as 2 minutes to start, during which time you may see the hotbar and hand, but all-grey window content where the world should be.  Just wait it out, it will eventually start.

## License:
Each of the base mods in this game retains the standard licenses their original authors assigned, even if the license file is missing from the archive.  For all of my Dreambuilder-specific changes and their related assets, LGPL 3.0 for code, CC-by-SA 4.0 for media and such.

## Open Source Software
This game is open source, or at least as much so as I have control over.
