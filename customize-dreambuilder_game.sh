#!/bin/bash

upstream_mods_path="/home/vanessa/Minetest-related/mods"
modpack_path=$upstream_mods_path"/my_mods/dreambuilder_modpack"

# This script manages all of the various individual changes
# for dreambuilder_game, e.g. updating mods, copying file components,
# making changes to the code, etc.

echo "Bring all mods up-to-date from "$upstream_mods_path

cd $upstream_mods_path

MODS_LIST="ShadowNinjas_mods/areas \
ShadowNinjas_mods/bedrock \
bas080s_mods/bees \
bas080s_mods/vines \
my_mods/biome_lib \
my_mods/coloredwood \
my_mods/currency \
my_mods/gloopblocks \
my_mods/ilights \
my_mods/moretrees \
my_mods/misc_overrides \
my_mods/nixie_tubes \
my_mods/pipeworks \
my_mods/signs_lib \
my_mods/unifieddyes \
blox \
bobblocks \
campfire \
Calinous_mods/bedrock \
Calinous_mods/carbone_mobs \
Calinous_mods/maptools \
Calinous_mods/moreblocks \
Calinous_mods/moreores \
pilzadams_mods/carts \
pilzadams_mods/farming_plus \
pilzadams_mods/player_textures \
Philipbenrs_mods/castle \
caverealms \
Sokomines_mods/colormachine \
Sokomines_mods/cottages \
Sokomines_mods/locks \
Sokomines_mods/markers \
Sokomines_mods/replacer \
Sokomines_mods/travelnet \
Sokomines_mods/windmill \
Sokomines_mods/windmill \
RBAs_mods/datastorage \
RBAs_mods/framedglass \
RBAs_mods/item_tweaks \
RBAs_mods/unified_inventory \
display_blocks \
gardening \
cys_mods/inventory_sorter \
Mossmanikins_mods/memorandum \
kaezas_mods/minetest-kaeza_misc/notice \
kaezas_mods/xban2 \
cheapies_mods/plasticbox \
DanDuncombes_mods/prefab \
quartz \
CWzs_mods/spawn \
CWzs_mods/teleport_request \
stained_glass \
titanium \
unifiedbricks \
usesdirt"

MODPACKS_LIST="$(ls -d worldedit/*/) \
$(ls -d Jeijas_mods/jumping/*/)
$(ls -d my_mods/homedecor_modpack/*/) \
$(ls -d RBAs_mods/technic/*/) \
$(ls -d cheapies_mods/streets/*/) \
$(ls -d my_mods/plantlife_modpack/*/) \
$(ls -d Zeg9s_mods/steel/*/) \
$(ls -d Zeg9s_mods/ufos/*/) \
$(ls -d Jeijas_mods/digilines/*/) \
$(ls -d nekogloops_mods/glooptest/*/) \
$(ls -d Jeijas_mods/mesecons/*/)"

for i in $MODS_LIST; do 
	echo "rsync -a $i $modpack_path --exclude .git*"
	rsync -a $i $modpack_path --exclude .git*
done

for i in $(echo $MODPACKS_LIST |sed "s:/ : :g; s:/$::"); do
	echo "rsync -a $i $modpack_path --exclude .git*"
	rsync -a $i $modpack_path --exclude .git*
done

# above, all the stuff of the form $(ls -d foo/*/) are modpacks
# those special commands copy out just the folders from within.

echo "Configure dreambuilder_game and its mods..."

# Disable some components from minetest_game and from other mods

rm -rf	$modpack_path/bobblocks/trap.lua \
		$modpack_path/castle/orbs.lua \

touch	$modpack_path/bobblocks/trap.lua \
		$modpack_path/castle/orbs.lua

sed -i "s/bucket//" \
	$modpack_path/unifiedbricks/depends.txt

sed -i "s/mesecons =/foo =/" \
	$modpack_path/bobblocks/blocks.lua

sed -i "s/LOAD_OTHERGEN_MODULE = true/LOAD_OTHERGEN_MODULE = false/" \
        $modpack_path/glooptest/module.cfg

# Add in all of the regular player skins for the player_textures mod

rm -f $modpack_path/player_textures/textures/*

LIST="player_Calinou.png
player_cheapie.png
player_crazyginger72.png
player_Evergreen.png
player_Jordach.png
player_kaeza.png
player_oOChainLynxOo.png
player_PilzAdam_back.png
player_PilzAdam.png
player_playzooki.png
player_sdzen.png
player_ShadowNinja.png
player_shadowzone.png
player_Sokomine.png
player_VanessaEzekowitz.png
player_Zeg9.png"

while read -r FILE; do
	cp /home/vanessa/Minetest-related/player_skins/$FILE \
	   $modpack_path/player_textures/textures
done <<< "$LIST"
