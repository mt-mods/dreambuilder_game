# nixie_tubes mod 

*by Vanessa Dannenberg*

This mod provides a set of classic Nixie tubes, and a set of alphanumeric 15-segment tubes similar to Burroughs B-7971, controlled by Mesecons' Digilines mod.

Simply place a tube, right-click it, and set a channel.

Then send a character, or one of several control words to that channel from a Mesecons Lua Controller and the mod will try to display it.

The classic tubes are numeric with colon and period symbols, and hence will respond to the literal numbers 0-9, and the words "colon", "period", and "off".  Any other symbol or string is ignored.

The alphanumeric tubes respond to singular characters from the standard 7-bit ASCII character set, or entire strings composed of such.

A single character will be displayed on the connected tube.  A decimal value as a numeric message (i.e. not a string) will display the first digit on the connected tube.

Strings will be displayed to all alphanumeric tubes in a lineup, so long as they all face the same way, starting from the tube the Lua Controller is connected to, going left to right.  The other tubes in the line do not need to be connected to anything - think of them as being connected together internally.  Only the tube at the far left need be connected to the Lua Controller.

The string will spread until either a tube is found that faces the wrong way, or has a channel that's not empty/nil and is set to something other than what the first is set to, or if a node is encountered that is not an alpha-numeric tube at all.

Tubes to the left of the connected one are ignored in the case of strings.

You can put multiple lines of tubes end to end to form independent displays, so long as the tubes that start each of the lines have unique channel names set.

The string is padded with spaces and then trimmed to 64 characters.

Any unrecognized symbol or character outside the ASCII 32 - 128 range, or characters 31 and 144, whether part of a string or singularly is ignored.

The alphanumeric tubes also respond to these control messages:

* "off", "colon" and "period" act the same as on the numeric tubes.  Note that neither a colon nor a period actually look all that great on a 15-segment
  display, so use a classic tube for those, if you can.
* "del" or character code 127 displays an all-on square, but without segment #15 (the bottom, chevron-shaped one).
* "allon" or character code 144 will display an all-on square, with segment #15 lit also.
* "cursor" or character code 31 will display just segment 15.
* "off_multi" turns all tubes in a lineup off
* "allon_multi" turns on all segments of all tubes in a lineup.

You can use "get" and "getstr" to read the one character from the first, connected tube.  These messages will not read the other tubes in the lineup.

This mod also provides Decatron tubes, which respond to 0-9 and "off", just as with the classic numeric tubes, along with the following actions:

* "inc" will increment the tube's current number value. If the value overflows from 9 back to 0, the tube will generate a "carry" message.
* "dec" will decrement the current value. If the value wraps from 0 back to 9, the tube will send out a "borrow" message.
* "get" will query the current state of the tube, responding with a single digit 0-9 or the word "off".

All tubes emit a small amount of light when displaying something.

Nixies can only be mounted on the floor, while Decatrons can be mounted on a wall (or a ceiling if so desired).

A Decatron has a small grey spot on its internal insulator to mark the "0" position.
