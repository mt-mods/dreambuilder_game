# nixie_tubes mod 

*by Vanessa Ezekowitz*

This mod provides a set of classic Nixie tubes, and a set of alphanumeric 15-segment tubes similar to Burroughs B-7971, controlled by Mesecons' Digilines mod.

Simply place a tube, right-click it, and set a channel.

Then send a character or one of several control words to that channel from a Mesecons Lua Controller and the tube will try to display it.

The classic tubes are numeric with colon and period symbols, and hence will respond to the literal numbers 0-9, and the words "colon", "period", and "off".  Any other symbol or word is ignored.

The alphanumeric tubes respond to characters from the standard 7-bit ASCII character set, along with these messages:

* "off", "colon" and "period" act the same as on the numeric tubes.  Note that neither a colon nor a period actually look all that great on a 15-segment
  display, so use a classic tube for those, if you can.
* "del" or character code 127 displays an all-on square, but without segment #15 (the bottom, chevron-shaped one).
* "allon" or character code 128 will display an all-on square, with segment #15 lit also.
* "cursor" or character code 129 will display just segment 15.

Any unrecognized word or symbol outside the 32-129 range is ignored.

The Decatron tubes respond to 0-9 and "off", same as the others, along with the following actions:

* "inc" will increment the tube's current number value. If the value overflows from 9 back to 0, the tube will generate a "carry" message.
* "dec" will decrement the current value. If the value wraps from 0 back to 9, the tube will send out a "borrow" message.
* "get" will query the current state of the tube, responding with a single digit 0-9 or the word "off".

Tubes emit a small amount of light when displaying something.

Nixies can only be mounted on the floor, while Decatrons can be mounted on a wall (or a ceiling if so desired).

A Decatron has a small grey spot on its internal insulator to mark the "0" position.
