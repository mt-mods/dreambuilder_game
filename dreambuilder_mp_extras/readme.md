# Overview

Dreambuilder is my attempt to give the player pretty much everything they'll ever want to build with, and all the tools they should ever need to actually get the job done. This modpack was, for most of its life, maintained as a subgame based on minetest_game, minus a couple of mods that I don't like, with a number of minor things changed, and a number of extra mods added on. Since then, many things have changed, from game content to packaging format. Read on!

This modpack is in use on my Creative server and on my Survival server, which also has a few extra mods installed for its specific needs. It should give you a pretty good idea nonetheless. Expect lag, as it's a significantly-developed multiplayer server, after all.

##  

# What's in it?  What's changed from the default stuff?

* Being that this was originally based on an old version of minetest_game, it retains the light-colored user interface theme despite having since been updated, because I don't like feeling like I live in a cave when I open a formspec.
* The complete Plantlife Modpack along with More Trees and Vines mods add a huge amount of variation to your landscape (as a result, they will add mapgen lag). Active spawning of Horsetail ferns is disabled by default, and I've added papyrus growth on dirt/grass with leaves (using a copy of the default growth ABM).
* This modpack includes RealBadAngel's Unified Inventory mod, which overrides minetest_game's default inventory to give you a much more powerful user interface, with crafting guide, bags, and more, and it also means that if you're using this modpack in creative mode, your stacks are NOT infinite (and they shouldn't be).
* The default bones and TNT mods have been disabled (by way of "empty" mods, to trick the dependency resolver into skipping the real ones). They're not exactly useful for building stuff with.
* Stu's split-limb player model replaces the default one.
* The default hotbar HUD holds 16 items instead of 8, taken from the top two rows of your inventory. The first 10 slots can be accessed by number keys 1-9 and 0, the rest via your mouse wheel. You can use `/hotbar ##` to change the number of slots from 1 to 23.
* The default lavacooling code has been supplanted by better, safer code from my Gloopblocks mod. That mod also provides stone/cobble --> mossy stone/cobble transformation in the presence of water.
* An extensive selection of administration tools for single-player and server use are included, such as areas, maptools, worldedit, xban, and more.
* A few textures here and there are different.
* The mapgen won't spawn apples on default trees, nor will they appear on a sapling-grown default tree. Only the *real* apple trees supplied by the Moretrees mod will bear apples (both at mapgen time and sapling-grown).  Or at least that's how it's supposed to work. :stuck_out_tongue:  While on that subject, apples now use a 3d model instead of the plantlike version.

##  

# Okay, what else?

A whole boatload of other mods have been added, which is where most of the content actually comes from. To be a little more specific, as of August 2017, this modpack has a total of 165 mods (counting all of the various sub-mods that themselves come as part of some modpack, such as mesecons or home decor) and supplies almost 2000 items in the inventory/craft guide (almost 14,300 unique items in total, counting everything that isn't displayed in the inventory)! A mostly-complete list of mods is as follows:

areas
arrowboards
bedrock
bees
biome_lib
blox
bobblocks (without the traps or mesecons support)
campfire
castles++ (Philipbenr's re-fork, without the "orbs")
caverealms
coloredwood
colormachine
cottages
currency
datastorage
digilines
digistuff
display_blocks
farming_plus
framedglass
gardening
gloopblocks
glooptest (without treasure chests)
ilights
inventory_sorter
invsaw
item_tweaks
locks
maptools
markers
memorandum
moreblocks
moreores
moretrees
nixie_tubes
notice
peaceful_npc
pipeworks
plasticbox
player_textures (cheapie's fork, with several default skins)
prefab_redo
quartz
replacer
rgblightstone
signs_lib
solidcolor
stained_glass
teleport_request
titanium
travelnet
unifiedbricks (bucket dependency removed)
unifieddyes
unified_inventory
unifiedmesecons
vines
windmill
xban2
The full Home Decor modpack
The full Technic modpack
The full Plantlife modpack
Cheapie's Roads modpack
Zeg9's Steel modpack
Zeg9's UFO modpack
The full Mesecons modpack
Jeija's Jumping modpack
The full Worldedit modpack

### Your Inventory Display

This modpack, as previously mentioned, replaces the standard inventory with Unified Inventory, which almost defies description here. Unified Inventory includes waypoints, a crafting guide, set/go home buttons, set day/set night buttons, a full creative inventory on the right if you're playing in that mode - and you only have to click/tap the item once to get the it, instead of multiple clicks/drag and drop, a trash slot, a clear all inventory button, a search feature for the inventory, and more. Basically, you just need to use it a few times and you'll find yourself wondering how you ever got along with the standard inventory!

### The Circular Saw

This modpack uses the More Blocks mod, which comes with the Stairsplus mod and more importantly, the Circular Saw mod by Sokomine and co. This mod replaces the traditional method of creating stairs, slabs, and the like: rather that crafting a stairs block by placing several of the material into your crafting grid, you must first craft a circular saw (really, a table saw), place that on the ground, and then use that to shape the material you had in mind. It can create dozens of shapes, including the standard stairs and slabs. Give it a try and see for yourself!

### Land Ownership

This modpack uses ShadowNinja's areas mod for land protection, as well as cheapie's protector blocks.  Of course, land protection is only useful if you're using this Modpack on a public server.

#### Protection blocks:
These are easy.  Craft one, place it, and everything within 15m of it becomes yours immediately (if someone else doesn't own some of the land therein, of course).  If you dig one of these, the area protection it created is removed; if you shift-dig, the protection is preserved, but the block is deleted, giving back some steel ingots if you're in survival mode, or nothing at all if in creative mode.

#### Areas:
If you want fine control, use the areas mod's commands.  There are three ways to select a region to protect:

**Option A:**

Just type `/area_pos set` and then punch two nodes that are diagonally opposite one another, so that they form a 3d box that fully encloses the area you want to claim. A black **`[1]`** or **`[2]`** will appear where you punched.

**Option B:**

1. Move to one corner, on the ground.
2. Type `/area_pos1` and press enter. A black **`[1]`** will appear.
3. Move to the other corner and go up a ways above your area - not too high though.
4. Type `/area_pos2` and press enter. A black **`[2]`** will appear.

**Option C:**

Just give actual coordinates to the `/area_xxx` commands, e.g.:
`/area_pos1 123,45,678 /area_pos2 987,654,321`

**Claim it:**

Once you've marked your area using one of the above methods, you must actually claim it. This is the step that actually protects it against vandalism and unauthorized access. Just type:
/protect some description here

By default, users may protect up to 3 zones with these commands, and each can be up to 50x100x50 meters in size, but this can be changed by plugging appropriate settings into your minetest.conf.

**Sublet it:**

Ok, you've claimed an area, and you want to let someone else build there. Simple. Set the coordinates of the box you want to let them build in, using the commands above (Options A, B, or C). Then do:
`/add_owner your_area# their_name description here`

For example, if you own area #123 and the other person's name is "Mike", and you want to sublet them some area called "Mike's home", you might do something like this:

`/add_owner 123 Mike Mikes Home`

You can add as many users as you like to your areas. You will need to issue one such command per user.

## Dependencies:
This modpack requires Minetest 0.4.16 or later, and a corresponding copy of minetest_game. Anything too old will likely either crash, show nodes with the wrong shape or colors, throw nonsensical warnings/errors, or open up wormholes.

## Hardware requirements:
This modpack defines a very large number of items and produces a well-detailed landscape, and so it requires a significant amount of resources compared to vanilla Minetest game. At least a 2 GHz dual core CPU and 2 GB free RAM are required for good performance. If you use my HDX texture pack, you'll need more RAM (at least 4 GB free recommended).

This modpack is NOT intended for use on mobile devices.

## Download/Install:
...if you're reading this, you're either on the Dreambuilder Github repo page, so clone it from there, or download the ZIP... or maybe you already have it. ;-)  You can also fetch it from [url]https://daconcepts.com/vanessa/hobbies/minetest/Dreambuilder_Modpack.tar.bz2[/url]

Just rename the project folder to "dreambuilder_modpack", if necessary, and move it to your Minetest mods directory. Then select and enable it for the world you want to use it in. Depending on the condition of the world you are using, and for brand new maps, this modpack may take a minute or two to start, during which time you may see the hotbar and hand, all-grey window content where the world should be, or other odd-looking things. Just wait it out, it will eventually start and settle down.

## License:
Each of the base mods in this modpack retains the standard license that its author has assigned, even if the license file is missing from the archive. All changes and any supplemental content made by me is WTFPL unless explicitly stated otherwise.

# Open Source Software
This modpack is open source, or at least as much so as I have control over. Since it started from the standard minetest_game distribution, you'll want to look at that. You can find it at its usual Github repository, here:
[url]https://github.com/minetest/minetest_game[/url]

An online copy of the archive of mods the modpack is built from can be found here (with full git histories, including my changes and any files that went missing from the completed modpack, where applicable):
[url]http://minetest.daconcepts.com/my-main-mod-archive/[/url]

# Notes:
For best results, I recommend adding the following to your minetest.conf (perhaps to a secondary copy of that file that you only use when playing worlds with this modpack):

```
enable_item_drops = false
enable_item_pickup = true
remove_items = -1
disable_fire = true
enable_mesh_cache = false
```
