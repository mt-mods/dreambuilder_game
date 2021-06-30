#!/bin/bash

# This script manages all of the various individual changes
# for dreambuilder, e.g. updating mods, copying file components,
# making changes to the code, etc.

upstream_mods_path="/home/vanessa/Minetest-related/mods"
minetest_game_path="/home/vanessa/Minetest-related/games/minetest_game/"
game_path=$upstream_mods_path"/my_mods/dreambuilder_game"

workdir="/run/shm/dreambuilder_game"

echo -e "\nSetting up..."

rm -rf $game_path/* $workdir*
mkdir $workdir
rm -f /tmp/herefile*

echo -e "\nAdding minetest_game as the base..."

cp -a $minetest_game_path/* $workdir

echo -e "\nConfiguring it..."

rm -rf $workdir/mods/bones \
       $workdir/mods/tnt \
       $workdir/mods/mtg_craftguide \
       $workdir/mods/sethome \
       $workdir/mods/farming

cp -a $upstream_mods_path"/my_mods/dreambuilder_extras" $workdir/mods

rm	$workdir"/README.md" \
	$workdir"/mods/default/README.txt" \
	$workdir"/game.conf" \
	$workdir"/minetest.conf" \
	$workdir"/minetest.conf.example" \
	$workdir"/settingtypes.txt" \
	$workdir"/screenshot.png" \
	$workdir"/menu/icon.png" \
	$workdir"/menu/header.png"

mv $workdir"/mods/dreambuilder_extras/README.md"                        $workdir
mv $workdir"/mods/dreambuilder_extras/default_README.txt"               $workdir"/mods/default/README.txt"
mv $workdir"/mods/dreambuilder_extras/game.conf"                        $workdir
mv $workdir"/mods/dreambuilder_extras/minetest.conf.example"            $workdir
mv $workdir"/mods/dreambuilder_extras/settingtypes.txt"                 $workdir
mv $workdir"/mods/dreambuilder_extras/dreambuilder_screenshot.png"      $workdir"/screenshot.png"
mv $workdir"/mods/dreambuilder_extras/dreambuilder_menu_icon.png"       $workdir"/menu/icon.png"
mv $workdir"/mods/dreambuilder_extras/dreambuilder_menu_overlay.png"    $workdir"/menu/background.png"

# Convert fake "apple" trees back into just normal default trees,
# and don't let them spawn with apples.  Ever.

mv $workdir"/mods/dreambuilder_extras/default_tree.mts"               $workdir"/mods/default/schematics/"
mv $workdir"/mods/dreambuilder_extras/default_tree_from_sapling.mts"  $workdir"/mods/default/schematics/"

mv $workdir"/mods/default/schematics/apple_log.mts" \
   $workdir"/mods/default/schematics/default_log.mts"

rm $workdir"/mods/default/schematics/apple_tree.mts"
rm $workdir"/mods/default/schematics/apple_tree_from_sapling.mts"

sed -i "s:/schematics/apple_tree_from_sapling.mts:/schematics/default_tree_from_sapling.mts:g" $workdir"/mods/default/trees.lua"
sed -i "s:/schematics/apple_tree.mts:/schematics/default_tree.mts:" $workdir"/mods/default/mapgen.lua"
sed -i "s:/schematics/apple_log.mts:/schematics/default_log.mts:" $workdir"/mods/default/mapgen.lua"

sed -i 's/local c_apple = minetest.get_content_id("default:apple")/local c_apple = minetest.get_content_id("default:leaves")/' $workdir"/mods/default/trees.lua"

sed -i 's/Apple Wood Planks/Wood Planks/g' $workdir"/mods/default/nodes.lua"
sed -i 's/Apple Tree Leaves/Leaves/'       $workdir"/mods/default/nodes.lua"
sed -i 's/Apple Tree Sapling/Sapling/'     $workdir"/mods/default/nodes.lua"
sed -i 's/Apple Tree/Tree/'                $workdir"/mods/default/nodes.lua"

sed -i "s/apple_tree.mts/default_tree.mts/"                           $workdir"/mods/default/README.txt"
sed -i "s/apple_log.mts/default_log.mts/"                             $workdir"/mods/default/README.txt"
sed -i "s/apple_tree_from_sapling.mts/default_tree_from_sapling.mts/" $workdir"/mods/default/README.txt"

echo -e "\nBring all mods up-to-date from "$upstream_mods_path

cd $upstream_mods_path

# No trailing slashes on these items' paths!

LINK_MODS_LIST="
my_mods/biome_lib \
my_mods/coloredwood \
my_mods/currency \
my_mods/gloopblocks \
my_mods/ilights \
my_mods/moretrees \
my_mods/nixie_tubes \
my_mods/led_marquee \
my_mods/signs_lib \
my_mods/basic_signs \
my_mods/street_signs \
my_mods/unifieddyes \
my_mods/simple_streetlights \
my_mods/basic_materials \
Calinous_mods/bedrock \
Calinous_mods/maptools \
Calinous_mods/moreores \
Sokomines_mods/cottages \
Sokomines_mods/travelnet \
Sokomines_mods/windmill \
RBAs_mods/datastorage \
RBAs_mods/framedglass \
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
cheapies_mods/display_blocks_redo \
Jeijas_mods/digilines \
Jeijas_mods/jumping \
TenPlus1s_mods/farming \
TenPlus1s_mods/bees \
TenPlus1s_mods/bakedclay \
TenPlus1s_mods/cblocks \
TenPlus1s_mods/bonemeal \
TenPlus1s_mods/ambience \
tumeninodes-mods/facade \
Zeg9s_mods/steel \
DonBatmans_mods/mymillwork \
HybridDogs_mods/titanium \
HybridDogs_mods/function_delayer \
quartz \
stained_glass \
gardening \
caverealms_lite \
deezls_mods/extra_stairsplus \
blox \
new_campfire \
item_drop"

COPY_MODS_LIST="
Sokomines_mods/locks \
nekogloops_mods/glooptest \
Calinous_mods/moreblocks \
CWzs_mods/replacer \
bobblocks \
unifiedbricks \
my_mods/pipeworks \
my_mods/dreambuilder_hotbar \
RBAs_mods/unified_inventory \
Zeg9s_mods/ufos/ufos"

LINK_MODPACKS_LIST="
$(ls -d my_mods/home_workshop_modpack/*/) \
$(ls -d my_mods/plantlife_modpack/*/) \
$(ls -d cheapies_mods/roads_modpack/*/) \
$(ls -d cool_trees_modpack/*/)"

COPY_MODPACKS_LIST="
$(ls -d my_mods/homedecor_modpack/*/) \
$(ls -d RBAs_mods/technic_modpack/*/) \
$(ls -d Philipbenrs_mods/castle-modpack/*/) \
$(ls -d worldedit_modpack/*/) \
$(ls -d Jeijas_mods/mesecons_modpack/*/)"

for i in $LINK_MODS_LIST; do
	ln -s $upstream_mods_path"/"$i $workdir/mods
done

for i in $COPY_MODS_LIST; do
	rsync -a $upstream_mods_path"/"$i $workdir/mods --exclude .git*
done

for i in $(echo $LINK_MODPACKS_LIST |sed "s:/ : :g; s:/$::"); do
	ln -s $upstream_mods_path"/"$i $workdir/mods
done

for i in $(echo $COPY_MODPACKS_LIST |sed "s:/ : :g; s:/$::"); do
	rsync -a $upstream_mods_path"/"$i $workdir/mods --exclude .git*
done

# above, all the stuff of the form $(ls -d foo/*/) are modpacks
# those special commands copy out just the folders from within.

echo -e "\nConfiguring the rest of Dreambuilder..."

# Disable some components

rm -f  $workdir/mods/dreambuilder_extras/models/character.b3d

rm -rf $workdir/mods/orbs_of_time

rm -f  $workdir/mods/bobblocks/trap.lua
touch  $workdir/mods/bobblocks/trap.lua

rm -f  $workdir/mods/replacer/inspect.lua
touch  $workdir/mods/replacer/inspect.lua

rm -rf $workdir/mods/wrench

sed -i "s/bucket//" \
    $workdir/mods/unifiedbricks/depends.txt

sed -i "s/mesecons =/foo =/" \
    $workdir/mods/bobblocks/blocks.lua

sed -i "s/LOAD_OTHERGEN_MODULE = true/LOAD_OTHERGEN_MODULE = false/" \
    $workdir/mods/glooptest/module.cfg

rm -rf $workdir/mods/worldedit_brush

# Create the standard in-game lightly-shaded theme, expand on it, make it user-configurable

LISTCOLORS_HIDE_SLOTS='"listcolors[#00000000;"..dreambuilder_theme.listcolor_slot_bg_hover..";#00000000]"..'

mv $workdir"/mods/dreambuilder_extras/minetest.conf" $workdir

##########

sed -i "s/bgcolor\[.*\]//" \
        $workdir"/mods/beds/init.lua"

##########

sed -i 's/gui_formbg.png/"..dreambuilder_theme.name.."_gui_formbg.png/' \
	$workdir"/mods/default/init.lua"

sed -i '/tableoptions/d' $workdir"/mods/default/craftitems.lua"

sed -i '/-- GUI related stuff/,/end)/{//!d;d}' \
	$workdir"/mods/default/init.lua"

sed -i '/default.gui_bg/,/default.get_hotbar_bg/{//!d;d}' \
	$workdir"/mods/default/init.lua"

echo "depends = dreambuilder_theme_settings" >> $workdir"/mods/default/mod.conf"

##########

sed -i 's/"style_type\[.*\]"/"style_type[label,textarea;font=mono]" \
\t\t.."style_type[textarea;textcolor="..dreambuilder_theme.editor_text_color..";border=false]"/' \
	$workdir"/mods/mesecons_luacontroller/init.lua"

sed -i 's/jeija_luac_background.png/"..dreambuilder_theme.name.."_jeija_luac_background.png/' \
	$workdir"/mods/mesecons_luacontroller/init.lua"

sed -i 's/jeija_luac_runbutton.png/"..dreambuilder_theme.name.."_jeija_luac_runbutton.png/' \
	$workdir"/mods/mesecons_luacontroller/init.lua"

sed -i 's/jeija_close_window.png/"..dreambuilder_theme.name.."_jeija_close_window.png/' \
	$workdir"/mods/mesecons_luacontroller/init.lua"

sed -i "0,/depends =/s//depends = dreambuilder_theme_settings, /" $workdir"/mods/mesecons/mod.conf"

##########

sed -i "/size\[8,9\]/ {
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 0.26, 8, 4, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.82, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 6.03, 8, 3, false)..
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	}" $workdir"/mods/pipeworks/compat-chests.lua"

sed -i 's/default.get_hotbar_bg(0,4.85)/""/' \
	$workdir"/mods/pipeworks/compat-chests.lua"

sed -i "/size\[8,8.5\]/ {
	a \\\t\tdreambuilder_theme.single_slot_v1(2.75, 0.45, false)..
	a \\\t\tdreambuilder_theme.single_slot_v1(2.75, 2.45, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(4.75, 0.92, 2, 2, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0,    4.22, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0,    5.45, 8, 3, false)..
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	}" $workdir"/mods/pipeworks/compat-furnaces.lua"

sed -i '/default.get_hotbar_bg(0, 4.25) ../ {d}' \
	$workdir"/mods/pipeworks/compat-furnaces.lua"

sed -i "0, /depends = /s//depends = dreambuilder_theme_settings, /" $workdir"/mods/pipeworks/mod.conf"

##########

sed -i "/size\[8,7;\]/ {
	a \\\t$LISTCOLORS_HIDE_SLOTS
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(0, 0.25, 8, 2, false)..
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(0, 2.82, 8, 1, true)..
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.03, 8, 3, false)..
    }" $workdir"/mods/vessels/init.lua"

sed -i 's/vessels_shelf_slot.png/"..dreambuilder_theme.name.."_vessels_shelf_slot.png/' \
	$workdir"/mods/vessels/init.lua"

sed -i 's/default.get_hotbar_bg(0, 2.85)/""/' \
	$workdir"/mods/vessels/init.lua"

sed -i "0, /depends = /s//depends = dreambuilder_theme_settings, /" $workdir"/mods/vessels/mod.conf"

##########

sed -i 's/"field\[.*\]"/ \
\t\t\t"formspec_version[4]".. \
\t\t\t"size[8,4]".. \
\t\t\t"button_exit[3,2.5;2,0.5;proceed;Proceed]".. \
\t\t\t"field[1.75,1.5;4.5,0.5;channel;Channel;$\{channel\}]" \
\t\t/' \
       $workdir"/mods/technic/machines/switching_station.lua"

sed -i "/size\[8,9\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.single_slot_v1(3, 0.95, false)..
	a \\\t\tdreambuilder_theme.single_slot_v1(5, 0.95, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(3.5, 2.95, 2, 1, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	}" $workdir"/mods/technic/machines/register/battery_box.lua"


sed -i 's/"field\[.*")/ \
\t\t\t\t\t\t"formspec_version[4]".. \
\t\t\t\t\t\t"size[8,4]".. \
\t\t\t\t\t\t"button_exit[3,2.5;2,0.5;proceed;Proceed]".. \
\t\t\t\t\t\t"field[1.75,1.5;4.5,0.5;channel;Digiline Channel;"..meta:get_string("channel").."]" \
\t\t\t\t\t)/' \
       $workdir"/mods/technic/machines/register/battery_box.lua"

sed -i "/size\[8,9;\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.single_slot_v1(3, 0.95, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(5, 0.95, 2, 2, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	}" $workdir"/mods/technic/machines/register/machine_base.lua"

sed -i "/formspec = formspec/ {
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(1, 2.95, 2, 1, false)..
	}" $workdir"/mods/technic/machines/register/machine_base.lua"

# this bit makes electric alloy furnaces look right
sed -i "/if data\.upgrade then/ {
	i \\\tif data.typename == \"alloy\" then
	i \\\t\tformspec = formspec .. dreambuilder_theme.single_slot_v1(2, 0.95, false)
	i \\\tend
}" $workdir"/mods/technic/machines/register/machine_base.lua"


sed -i "/size\[8,9;\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	a \\\t\tdreambuilder_theme.single_slot_v1(3, 0.95, false)..
	}" $workdir"/mods/technic/machines/register/generator.lua"

# this coal alloy furnace change will match in two places, on purpose.
sed -i "/size\[8,9\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(2, 0.95, 2, 1, false)..
	a \\\t\tdreambuilder_theme.single_slot_v1(2, 2.95, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(5, 0.95, 2, 2, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	}" $workdir"/mods/technic/machines/other/coal_alloy_furnace.lua"

sed -i "/size\[8,9;\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 1.95, 8, 2, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	}" $workdir"/mods/technic/machines/other/injector.lua"

sed -i "/size\[8,9;\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(1, 2.95, 2, 1, false)..
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	a \\\tdreambuilder_theme.single_slot_v1(3, 0.95, false)..
	}" $workdir"/mods/technic/machines/MV/tool_workshop.lua"

sed -i "/size\[8,9\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(2, 0.95, 3, 2, false)..
	}" $workdir"/mods/technic/machines/HV/nuclear_reactor.lua"

sed -i "/size\[8,9;\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.97, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.97, 8, 3, false)..
	}" $workdir"/mods/technic/machines/other/constructor.lua"

sed -i "/list\[current_name/ {
	i \\\t\t\t\t\t..dreambuilder_theme.single_slot_v1(6, i-1.05, false)
	}" $workdir"/mods/technic/machines/other/constructor.lua"

sed -i "/size\[9,11;\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.single_slot_v1(0.5, 5.45, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(5, 5.45, 4, 1, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 6.95,  8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 7.95,  8, 3, false)..
	}" $workdir"/mods/technic_cnc/cnc.lua"

sed -i "0, /depends = /s//depends = dreambuilder_theme_settings, /" $workdir"/mods/technic/mod.conf"

##########

sed -i "/\"label\[0,0;\"/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
}" $workdir"/mods/technic_chests/register.lua"

sed -i '/"background\["..data.hileft/ {d}' \
	$workdir"/mods/technic_chests/register.lua"

sed -i '/"background\["..data.loleft/ {
	a \\t\t\tdreambuilder_theme.make_inv_img_grid_v1(data.hileft, 0.95, data.width, data.height, false)..
	a \\t\t\tdreambuilder_theme.make_inv_img_grid_v1(data.loleft, data.lotop-0.05, 8, 1, true)..
	a \\t\t\tdreambuilder_theme.make_inv_img_grid_v1(data.loleft, data.lotop+0.95, 8, 3, false)..
	d
	}' $workdir"/mods/technic_chests/register.lua"

sed -i '/"background\[-0.19,-0.25;"/ {
	a \\t\t\t"background[0,0;1,1;"..dreambuilder_theme.name.."_technic_chest_form_bg.png;true]"..
	d
	}'	$workdir"/mods/technic_chests/register.lua"

#sed -i 's/technic_chest_form_bg.png/"..dreambuilder_theme.name.."_technic_chest_form_bg.png;true/' \
#	$workdir"/mods/technic_chests/register.lua"

sed -i "0, /depends = /s//depends = dreambuilder_theme_settings, /" $workdir"/mods/technic_chests/mod.conf"

##########

sed -i "/image\[2.75,1.5;1,1;/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.single_slot_v1(2.75, 0.45, false)..
	a \\\t\tdreambuilder_theme.single_slot_v1(2.75, 2.45, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(4.75, 0.92, w, h, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0,    4.22, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0,    5.45, 8, 3, false)..
	}" $workdir"/mods/homedecor_common/furnaces.lua"

sed -i "0, /depends = /s//depends = dreambuilder_theme_settings, /" $workdir"/mods/homedecor_common/mod.conf"

##########

sed -i "/size\[8,10\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 0.95, 8, 4, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.82, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 7.03, 8, 3, false)..
	}" $workdir"/mods/locks/shared_locked_chest.lua"

sed -i 's/default.get_hotbar_bg(0,5.85)/""/' \
	$workdir"/mods/locks/shared_locked_chest.lua"

# This one will match in two places, deliberately.
sed -i "/size\[8,9\]/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.single_slot_v1(2, 0.45, false)..
	a \\\t\tdreambuilder_theme.single_slot_v1(2, 2.45, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(5, 0.95, 2, 2, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.95, 8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.95, 8, 3, false)..
	}" $workdir"/mods/locks/shared_locked_furnace.lua"

echo "dreambuilder_theme_settings" >> $workdir"/mods/locks/depends.txt"

##########

sed -i '/default.gui_bgimg/ {d}' $workdir"/mods/castle_storage/ironbound_chest.lua"
sed -i '/default.gui_bg/ {d}' $workdir"/mods/castle_storage/ironbound_chest.lua"

sed -i "/default.gui_slots/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, -0.05, 8, 4, false)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.95,  8, 1, true)..
	a \\\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.95,  8, 3, false)..
	d
}" $workdir"/mods/castle_storage/ironbound_chest.lua"

sed -i '/default.gui_bgimg/ {d}' $workdir"/mods/castle_storage/crate.lua"
sed -i '/default.gui_bg/ {d}' $workdir"/mods/castle_storage/crate.lua"

sed -i "/default.gui_slots/ {
	a \\\t\t$LISTCOLORS_HIDE_SLOTS
	a \\\t\t\t\tdreambuilder_theme.make_inv_img_grid_v1(0, -0.05, 8, 4, false)..
	a \\\t\t\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 4.95,  8, 1, true)..
	a \\\t\t\t\tdreambuilder_theme.make_inv_img_grid_v1(0, 5.95,  8, 3, false)..
	d
}" $workdir"/mods/castle_storage/crate.lua"

##########

sed -i "/size\[8,5.5\]/ {
	a \\\t$LISTCOLORS_HIDE_SLOTS
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(0, 1.46, 8, 1, true)..
	a \\\tdreambuilder_theme.make_inv_img_grid_v1(0, 2.46, 8, 3, false)..
	a \\\tdreambuilder_theme.single_slot_v1(3.5, -0.03, false)..
	}" $workdir"/mods/ufos/furnace.lua"

echo "dreambuilder_theme_settings" >> $workdir"/mods/ufos/depends.txt"

##########

sed -i 's/"listcolors\[#00000000;#00000000\]"/""/' $workdir"/mods/unified_inventory/internal.lua"
sed -i 's/"listcolors\[#00000000;#00000000\]"/""/' $workdir"/mods/unified_inventory/bags.lua"
sed -i 's/"listcolors\[#00000000;#00000000\]"/""/' $workdir"/mods/unified_inventory/register.lua"

sed -i "/formspec\[n\] = fsdata.formspec/ {
	a \\\tformspec[n+1]=\"style_type[image_button;bgcolor=\"..dreambuilder_theme.btn_color..\"]\"
	a \\\tformspec[n+2]=${LISTCOLORS_HIDE_SLOTS%..}
	a \\\tn = n + 3
}" $workdir"/mods/unified_inventory/internal.lua"

sed -i '0,/n = n+1/s///' $workdir"/mods/unified_inventory/internal.lua"

sed -i '/pagedef.formspec_prepend/ {
	a \\t\t"no_prepend[]"..default.gui_bg,
	d
	}' $workdir"/mods/unified_inventory/internal.lua"

sed -i '/ui.single_slot(8.425, 1.5)/ {
	a \\t\t\t"style_type[button;bgcolor="..dreambuilder_theme.btn_color.."]",
	}' $workdir"/mods/unified_inventory/bags.lua"

sed -i 's/ui_formbg_9_sliced.png/"..dreambuilder_theme.name.."_ui_formbg_9_sliced.png/' \
	$workdir"/mods/unified_inventory/init.lua"

sed -i 's/ui_single_slot/"..dreambuilder_theme.name.."_ui_single_slot/' \
	$workdir"/mods/unified_inventory/api.lua"

sed -i 's/ui_trash_slot_icon.png/"..dreambuilder_theme.name.."_ui_trash_slot_icon.png/' \
	$workdir"/mods/unified_inventory/api.lua"

sed -i "0, /depends = /s//depends = dreambuilder_theme_settings, /" $workdir"/mods/unified_inventory/mod.conf"

##########

mv	$workdir"/mods/dreambuilder_extras/dreambuilder_theme_settings" \
	$workdir"/mods/"

rsync -a $upstream_mods_path"/my_mods/dreambuilder_themes/dreambuilder_theme_light" $workdir/mods

# Finally, strip-out the individual mods' .git dirs
# and copy the completed game to the target dir

rsync -aL \
	--exclude=".git*" \
	$workdir"/" \
	$workdir"_no_git"

rsync -aL \
	$workdir"_no_git/" \
	$game_path

rm -rf $workdir*


echo -e "\nCustomization completed.\n"

echo -e "Here's what will be included in the game:\n"
ls -a $game_path $game_path/mods
