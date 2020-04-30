#!/bin/bash

upstream_mods_path="/home/vanessa/Minetest-related/mods"
modpack_path=$upstream_mods_path"/my_mods/dreambuilder_modpack"

# This script manages all of the various individual changes
# for dreambuilder, e.g. updating mods, copying file components,
# making changes to the code, etc.

rm -rf $modpack_path/*
touch $modpack_path/modpack.txt

echo -e "\nBring all mods up-to-date from "$upstream_mods_path

cd $upstream_mods_path

# No trailing slashes on these items' paths!
MODS_LIST="ShadowNinjas_mods/bedrock \
my_mods/biome_lib \
my_mods/coloredwood \
my_mods/currency \
my_mods/gloopblocks \
my_mods/ilights \
my_mods/moretrees \
my_mods/misc_overrides \
my_mods/nixie_tubes \
my_mods/led_marquee \
my_mods/pipeworks \
my_mods/signs_lib \
my_mods/basic_signs \
my_mods/street_signs \
my_mods/unifieddyes \
my_mods/dreambuilder_mp_extras \
my_mods/simple_streetlights \
my_mods/basic_materials \
my_mods/dreambuilder_hotbar \
Calinous_mods/bedrock \
Calinous_mods/maptools \
Calinous_mods/moreblocks \
Calinous_mods/moreores \
Sokomines_mods/cottages \
Sokomines_mods/locks \
Sokomines_mods/travelnet \
Sokomines_mods/windmill \
RBAs_mods/datastorage \
RBAs_mods/framedglass \
RBAs_mods/unified_inventory \
Mossmanikins_mods/memorandum \
cheapies_mods/plasticbox \
cheapies_mods/prefab_redo \
cheapies_mods/invsaw \
cheapies_mods/unifiedmesecons \
cheapies_mods/digistuff \
cheapies_mods/rgblightstone \
cheapies_mods/solidcolor \
cheapies_mods/arrowboards \
cheapies_mods/digidisplay \
Jeijas_mods/digilines \
Jeijas_mods/jumping \
CWzs_mods/player_textures \
CWzs_mods/replacer \
nekogloops_mods/glooptest \
TenPlus1s_mods/farming \
TenPlus1s_mods/bees \
TenPlus1s_mods/bakedclay \
TenPlus1s_mods/cblocks \
TenPlus1s_mods/bonemeal \
tumeninodes-mods/facade \
Zeg9s_mods/steel \
DonBatmans_mods/mymillwork \
quartz \
stained_glass \
titanium \
unifiedbricks \
display_blocks \
gardening \
caverealms_lite \
deezls_mods/extra_stairsplus \
blox \
bobblocks \
campfire \
item_drop \
notify_hud_provider"

MODPACKS_LIST="$(ls -d worldedit/*/) \
$(ls -d my_mods/homedecor_modpack/*/) \
$(ls -d RBAs_mods/technic/*/) \
$(ls -d my_mods/plantlife_modpack/*/) \
$(ls -d Zeg9s_mods/ufos/*/) \
$(ls -d Jeijas_mods/mesecons/*/) \
$(ls -d Philipbenrs_mods/castle-modpack/*/) \
$(ls -d cheapies_mods/roads/*/) \
$(ls -d cool_trees/*/)"


for i in $MODS_LIST; do
	rsync -a $i $modpack_path --exclude .git*
done

for i in $(echo $MODPACKS_LIST |sed "s:/ : :g; s:/$::"); do
	rsync -a $i $modpack_path --exclude .git*
done

# above, all the stuff of the form $(ls -d foo/*/) are modpacks
# those special commands copy out just the folders from within.

echo -e "\nConfigure Dreambuilder and its mods..."

# Disable some components

rm -f  $modpack_path/dreambuilder_mp_extras/models/character.b3d

rm -rf $modpack_path/orbs_of_time

rm -f  $modpack_path/bobblocks/trap.lua
touch  $modpack_path/bobblocks/trap.lua

rm -f  $modpack_path/replacer/inspect.lua
touch  $modpack_path/replacer/inspect.lua

rm -rf $modpack_path/wrench

sed -i "s/bucket//" \
    $modpack_path/unifiedbricks/depends.txt

sed -i "s/mesecons =/foo =/" \
    $modpack_path/bobblocks/blocks.lua

sed -i "s/LOAD_OTHERGEN_MODULE = true/LOAD_OTHERGEN_MODULE = false/" \
    $modpack_path/glooptest/module.cfg

sed -i 's/"stairsplus_in_creative_inventory", true)/"stairsplus_in_creative_inventory", false)/' \
    $modpack_path/moreblocks/config.lua

echo "moreblocks.stairsplus_in_creative_inventory (Display Stairs+ nodes in creative inventory) bool false" \
    > $modpack_path/moreblocks/settingtypes.txt

rm -rf $modpack_path/worldedit_brush

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
player_VanessaE.png
player_Zeg9.png"

while read -r FILE; do
cp /home/vanessa/Minetest-related/player_skins/$FILE \
    $modpack_path/player_textures/textures
done <<< "$LIST"

cp -a /home/vanessa/Minetest-related/mods/my_mods/dreambuilder_mp_upstream_files/readme.md $modpack_path

cp /home/vanessa/Minetest-related/Scripts/customize-dreambuilder.sh $modpack_path"/dreambuilder_mp_extras/"
cp /home/vanessa/Minetest-related/Scripts/update-dreambuilder-online-files.sh $modpack_path"/dreambuilder_mp_extras"

echo "Copying Dreambuilder to mods directory..."

rsync -a -v --delete $modpack_path /home/vanessa/.minetest/mods/

echo -e "\nCustomization completed.  Here's what will be included in the modpack:\n"

ls $modpack_path

echo -e "\nUploading to the server..."

rsync -L --delete --progress -a -v -z -e "ssh" \
--exclude=".git*" \
--chown=minetest:minetest \
/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack \
minetest@daconcepts.com:/home/minetest/mods/my_mods
