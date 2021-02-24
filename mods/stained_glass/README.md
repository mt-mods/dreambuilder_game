
Doyousketch2's Stained Glass mod
 ver 1.7

Image: http://oi47.tinypic.com/hst6s3.jpg

With alpha enabled: http://oi44.tinypic.com/5vraxf.jpg 

==============================================================================
Originally developed by Eli Innes/Doyousketch2, and distributed 
under GPL v2.  Further changes by VanessaE (removing from creative inventory)
and Jeremy Anderson (fixing craft recipes, renaming blocks)

==============================================================================

Dependencies: VanessaE's Unified Dyes, Calinou's More Blocks

to Install:

Unzip the mod file you just downloaded.

it should be something like: Doyousketch2-stained_glass-1.1.zip
or stained_glass-master.zip, depending on where you downloaded it from

rename the new folder that looks like: 
Doyousketch2-stained_glass-1.1 -or- stained_glass-master
to simply read "stained_glass"

then move it into your Minetest mods folder.

Even better, get stained_glass from one of the github pages:
https://github.com/doyousketch2/stained_glass
https://github.com/VanessaE/stained_glass
https://github.com/andersje/stained_glass

-- this will get you the latest version of the code, and you
can update at any time by doing a git pull



==============================================================================
To turn off types of glass, alter settings.txt in the stained_glass directory.
By default, all six (SIX!) types of stained_glass are enabled:  regular (based on super_glow_glass), med_glow (based on glow_glass) and no-glow (Based on default:glass), trap regular (based on trap_super_glow_glass), trap med_glow (based on trap_glow_glass) and trap_noglow (based on trapglass)

stained_glass.full_light = true
stained_glass.med_light = true
stained_glass.no_light = true
stained_glass.trap_full_light = true
stained_glass.trap_med_light = true
stained_glass.trap_no_light = true

Setting any of these to false will prevent that type of stained_glass from being loaded.  If you set them all to false, you won't get any stained_glass.  Mix and match as you choose -- you can turn on only one, if you wish, and it will work just fine.

One of the high points of trap stained glass is that liquids flow through it -- making illuminated waterfalls a possibility.


==============================================================================

(use trap super glow glass or trap glow glass or trapglass  -- now available in moreblocks -- to make the trap variant of this)

Recipe for standard colors:

image: http://oi50.tinypic.com/1ibs7c.jpg

	dye
	super glow glass
	super glow glass
	super glow glass



Recipe for pastel colors:

image: http://oi45.tinypic.com/2wbvkti.jpg

	light dye
	white paint
	super glow glass
	super glow glass
	super glow glass

Recipe for faint colors:

image: http://oi45.tinypic.com/2wbvkti.jpg

	light dye
	white paint
	white paint
	super glow glass
	super glow glass
	super glow glass


All recipes produce three glowing stained glass blocks.


==============================================================================


The Palette includes:

	red, orange, yellow, lime, green, aqua
	cyan, skyblue, blue, violet, magenta, redviolet

Full & half-saturation, medium and dark shades have been included
as well as light, pastel, and faint tints.

Look at settings.txt to see how you can enable/disable full-glow, half-glow and no-glow blocks -- tested in all combinations.  enjoy.


==============================================================================


Misc. Notes
-----------

Blocks are now available by name:  
e.g.  /giveme stained_glass:orange 3 #  get 3 orange sg blocks
or /giveme stained_glass:light_yellow
or /giveme stained_glass:pastel_yellow
or /giveme stained_glass:faint_yellow
or /giveme stained_glass:yellow

or /giveme stained_glass:lowglow_yellow
or /giveme stained_glass:noglow_dark_green
or /giveme stained_glass:trap_noglow_dark_green
or /giveme stained_glass:trap_lowglow_yellow 
or /giveme stained_glass:trap_medium_aqua

You get the idea.  


NUMERIC CODES FOR BLOCKS  (this is the old way of coding these blocks
developed by Doyousketch2)

Please don't try to use /give commands, the items are now in numerical format,
and it would be tough to try to explain it.

If you really want to try, it goes like this:

yellow    = 1
lime      = 2
green     = 3
aqua      = 4
cyan      = 5
skyblue   = 6
blue      = 7
violet    = 8
magenta   = 9
redviolet = 10
red       = 11
orange    = 12


however, minetest sees it in the order 10, 11, 12, 1, 2, 3...
so redviolet actually comes first.

and for whatever reason, minetest doesn't take blank spaces _ into consideration.
so the attributes just act like the next column of digits.

I had to offset them to keep it all in order.

Brightness:

dark   = 3
medium = 4
full   = 5

Saturation:

50%    = 6
full   = 7

so "Red, dark 50%"  would be: stained_glass:11_3_6
"Blue, medium full-saturation" is: stained_glass:7_4_7

then we get to the bright colors.

same hue numbers, 1 - 12
but the attributes are:

light  = 8
pastel = 9
faint  = 91

so "Violet, light" is: stained_glass:8_8
and ""Orange, faint" is: stained_glass:12_91

I think this is too much to keep track of, but I hope this explains things in case anybody else is developing code.
For everyday purposes, let the computer keep track of the registered nodes, and just pick them out with the menu instead.


==============================================================================


