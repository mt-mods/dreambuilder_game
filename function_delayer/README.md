allows executing functions after a delay to reduce possible lag (EDD scheduler?)

minetest.after executes the function after a specific time (and not exactly if it's lagging (dtime can be long))  
and minetest.delay_function executes the function after a specific time only if it's lagging, the function can be and is usually executed earlier.

If you e.g. want to grow 1000 big trees you can  
either place them all at once and need to wait long until you can play again  
or you can use minetest.delay_function to let the trees grow in globalsteps with time limit. e.g. growing of a couple of trees is not allowed to take more than 1s but all trees have to been grown after a specific time

Do not use make minetest.delay_function constantly call itself instead of using globalstep or minetest.after because  
it would call itself immediately very often in a loop, so without pauses.

TODO:  
— add minetest.add_task where nice level can be set  
— ensure if get_us_time really is faster (https://forum.minetest.net/viewtopic.php?p=214962#p214962)
