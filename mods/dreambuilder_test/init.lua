
-- validate known nodenames
mtt.validate_nodenames(minetest.get_modpath("dreambuilder_test") .. "/nodenames.txt")

-- emerge a part of the landscape
mtt.emerge_area({x=-32,y=-32,z=-32}, {x=32,y=32,z=32})