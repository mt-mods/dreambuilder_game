# LED marquee mod 

*by Vanessa Dannenberg*

This mod provides set of alphanumeric LED marquee panels, controlled by Mesecons' Digilines mod.

Simply place a panel, right-click it, and set a channel.

Then send a character, a string, or one of several control words to that channel from a Mesecons Lua Controller and the mod will try to display it.  The panels use the standard 7-bit ASCII character set (with a few alterations).

A single character will be displayed on the connected panel.  A numeric message (i.e. not a string) will display the first digit on the connected panel.

Strings will be displayed using all panels in a lineup, so long as they all face the same way, starting from the panel the Lua Controller is connected to, going left to right.  The other panels in the line do not need to be connected to anything - think of them as being connected together internally.  Only the panel at the far left need be connected to the Lua Controller.

The string will spread down the line until either a panel is found that faces the wrong way, or has a channel that's not empty/nil and is set to something other than what the first is set to, or if a node is encountered that is not an alpha-numeric panel at all.

Panels to the left of the connected one are ignored (unless they, too, have their own connections).

You can put multiple lines of panels end to end to form independent displays, so long as the panels that start each of the lines have unique channel names set.

The string is padded with spaces and then trimmed to 64 characters.

Any unrecognized symbol or character, whether part of a string or singularly is ignored, except as noted below.

This mod uses the full ISO-8859-1 character set (see https://en.wikipedia.org/wiki/ISO/IEC_8859-1 for details), plus a bunch of symbols stuffed into the empty 128-159 range that should be useful on a marquee:
    
* 128,129: musical notes
* 130-140: box drawing glyphs
* 141-144: block shades
* 145-152: arrows
* 153-156: explosion/splat
* 157-159: smileys

The panels also respond to these control messages:

* the keywords "off", "colon" and "period" translate to a blank space, ":", and ".", respectively (they're leftover from the nixie tubes fork, but might be useful anyway)
* "del" is mapped to character #127, a square with an X in it.
* "allon" is mapped to character #144, the full/all-on block graphic.
* "cursor" or character code 31 will display a short, thick, flashing line at the bottom of the panel.
* "off_multi" turns all panels in a lineup off
* "allon_multi" turns on all LEDs of all panels in a lineup.

A byte value of 0 to 30 will change colors (i.e. string.char(0 to 30) ).  Color values 0 to 11 are:

Red (0), orange, yellow, lime, green, aqua, cyan, sky blue, blue, violet, magenta, or red-violet (11)

Colors 12 to 23 are the same as 0 to 11, but lower brightness.

Colors 23 - 30 are white, light grey, medium grey, dim grey, light blue, brown, and pink.

The left-most/"master" panel will remember the last color used, and defaults to red.

You can use "get" and "getstr" to read the one character from the connected panel.  These messages will not read the other panels in the lineup.

All panels emit a small amount of light when displaying something.

The panels only mount on a wall.
