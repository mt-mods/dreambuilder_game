
-- Autor:    Sokomine
-- Textures: VanessaE
-- Version:  2.0
-- LIscence: GPLv3
-- Changelog:
-- 17.12.13 * added the 3- and 4-blade-versions 

-- two very large windmills
windmill.register_windmill( "windmill_large:large_windmill_sails", "Windmill sails (large)",
			"windmill_wooden_cw_with_sails_304px.png", "windmill_wooden_ccw_with_sails_304px.png",
			20.0, "windmill_wooden_inv.png", 1.0, "windmill:windmill_sails", 3 );

windmill.register_windmill( "windmill_large:large_windmill_idle",  "Windmill idle (large)",
			"windmill_wooden_cw_304px.png", "windmill_wooden_ccw_304px.png",
			20.0, "windmill_wooden_no_sails_inv.png", 2.0, "windmill:windmill_idle", 3 );



windmill.register_windmill( "windmill_large:large_windmill",  "Windmill rotors (large)",
			"windmill_4blade_304_cw.png", "windmill_4blade_304_cw.png",
			20.0, "windmill_4blade_inv.png", 2.0, "windmill:windmill", 3 );

windmill.register_windmill( "windmill_large:large_windmill_modern",  "Windmill turbine (large)",
			"windmill_3blade_304_cw.png", "windmill_3blade_304_cw.png",
			20.0, "windmill_3blade_inv.png", 2.0, "windmill:windmill_modern", 3 );



