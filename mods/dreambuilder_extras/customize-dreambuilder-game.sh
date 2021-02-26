#!/bin/bash

# This script manages all of the various individual changes
# for dreambuilder, e.g. updating mods, copying file components,
# making changes to the code, etc.

upstream_mods_path="/home/vanessa/Minetest-related/mods"
minetest_game_path="/home/vanessa/Minetest-related/games/minetest_game/"
game_path=$upstream_mods_path"/my_mods/dreambuilder_game"

if [ ! -d "$upstream_mods_path" ] ; then
	if [ ! -z $2 ] ; then
		upstream_mods_path=$1
		minetest_game_path=$2
	else
		echo "Script does not appear to be running on Vanessa's PC, so you must supply mod and game paths."
		echo -e "\nUsage:  customize-dreambuilder-game.sh <mods path> <minetest_game path>"
		exit 1
	fi
fi

workdir="/run/shm/dreambuilder_game"

echo -e "\nSetting up..."

rm -rf $game_path/* $workdir*
mkdir $workdir

echo -e "\nAdding minetest_game as the base..."

cp -a $minetest_game_path/* $workdir

echo -e "\nConfiguring it..."

rm -rf $workdir/mods/bones \
       $workdir/mods/tnt \
       $workdir/mods/mtg_craftguide \
       $workdir/mods/sethome \
       $workdir/mods/farming

cp -a $upstream_mods_path"/my_mods/dreambuilder_extras" $workdir/mods

rm $workdir"/README.md" \
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
mv $workdir"/mods/dreambuilder_extras/minetest.conf"                    $workdir
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
LINK_MODS_LIST="my_mods/biome_lib \
my_mods/coloredwood \
my_mods/currency \
my_mods/gloopblocks \
my_mods/ilights \
my_mods/moretrees \
my_mods/misc_overrides \
my_mods/nixie_tubes \
my_mods/led_marquee \
my_mods/signs_lib \
my_mods/basic_signs \
my_mods/street_signs \
my_mods/unifieddyes \
my_mods/simple_streetlights \
my_mods/basic_materials \
my_mods/dreambuilder_hotbar \
Calinous_mods/bedrock \
Calinous_mods/maptools \
Calinous_mods/moreores \
Sokomines_mods/cottages \
Sokomines_mods/locks \
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
nekogloops_mods/glooptest \
Calinous_mods/moreblocks \
CWzs_mods/replacer \
CWzs_mods/player_textures \
bobblocks \
unifiedbricks \
my_mods/pipeworks \
RBAs_mods/unified_inventory"

LINK_MODPACKS_LIST="$(ls -d my_mods/homedecor_modpack/*/) \
$(ls -d my_mods/plantlife_modpack/*/) \
$(ls -d Zeg9s_mods/ufos/*/) \
$(ls -d cheapies_mods/roads/*/) \
$(ls -d cool_trees/*/)"

COPY_MODPACKS_LIST="$(ls -d RBAs_mods/technic/*/) \
$(ls -d Philipbenrs_mods/castle-modpack/*/) \
$(ls -d worldedit/*/) \
$(ls -d Jeijas_mods/mesecons/*/)"

for i in $LINK_MODS_LIST; do
	ln -s $upstream_mods_path"/"$i $workdir/mods
done

for i in $(echo $LINK_MODPACKS_LIST |sed "s:/ : :g; s:/$::"); do
	ln -s $upstream_mods_path"/"$i $workdir/mods
done

for i in $COPY_MODS_LIST; do
	rsync -a $upstream_mods_path"/"$i $workdir/mods --exclude .git*
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

# Create the standard in-game lightly-shaded theme, and expand on it

rm $workdir"/mods/default/textures/gui_formbg.png"

inv_slot_colors="\"listcolors\[#00000000;#00000000;#00000000;#A0A0A0;#FFF\]\" .."
          form_bgcolor="#F0F0F0FF"
             btn_color="#B0B0B0FF"
     editor_text_color="#000000FF"
       editor_bg_color="#F0F0F0FF"
       scrollbar_color="#808080FF"
scrollbar_handle_color="#606060FF"

sed -i 's/"field\[.*\]"/ \
\t\t\t"formspec_version[4]".. \
\t\t\t"size[8,4]".. \
\t\t\t"button_exit[3,2.5;2,0.5;proceed;Proceed]".. \
\t\t\t"field[1.75,1.5;4.5,0.5;channel;Channel;$\{channel\}]" \
\t\t/' \
       $workdir"/mods/technic/machines/switching_station.lua"

sed -i 's/"field\[.*")/ \
\t\t\t\t\t\t"formspec_version[4]".. \
\t\t\t\t\t\t"size[8,4]".. \
\t\t\t\t\t\t"button_exit[3,2.5;2,0.5;proceed;Proceed]".. \
\t\t\t\t\t\t"field[1.75,1.5;4.5,0.5;channel;Digiline Channel;"..meta:get_string("channel").."]" \
\t\t\t\t\t)/' \
       $workdir"/mods/technic/machines/register/battery_box.lua"

sed -i 's/INSERT_BGCOLOR/default.gui_bg = "bgcolor['"$form_bgcolor"';false]"/' \
        $workdir"/mods/dreambuilder_extras/init.lua"

sed -i "s/bgcolor\[.*\]//" \
        $workdir"/mods/default/init.lua"

sed -i "s/bgcolor\[.*\]//" \
        $workdir"/mods/beds/init.lua"

sed -i "s/listcolors\[.*\]/listcolors[#FFFFFF30;#B0B0B0;#606060;#A0A0A0;#FFF] \
\n\t\t\tstyle_type[button;bgcolor="$btn_color"] \
\n\t\t\tstyle_type[button_exit;bgcolor="$btn_color"] \
\n\t\t\tstyle_type[image_button;bgcolor="$btn_color";border=false] \
\n\t\t\tstyle_type[image_button_exit;bgcolor="$btn_color";border=false] \
\n\t\t\tstyle_type[item_image_button;bgcolor="$btn_color";border=false] \
\n\t\t\tstyle_type[scrollbar;bgimg="$scrollbar_color";fgimg="$scrollbar_handle_color";border=true] \
\n\t      ]]/" \
       $workdir"/mods/default/init.lua"

sed -i 's/"style_type\[.*\]"/"style_type[label,textarea;font=mono]" \
\t\t.."style_type[textarea;textcolor='"$editor_text_color"';border=false]"/' \
       $workdir"/mods/mesecons_luacontroller/init.lua"

sed -i 's/"size\[8,9\]" \.\./"size[8,9]" .. \
\t\t"image[-0.39,-0.4;10.7,11.4;default_chest_inv_bg.png]" .. \
\t\t'"$inv_slot_colors"'/' \
    $workdir"/mods/pipeworks/compat-chests.lua"

sed -i 's/"size\[8,8.5\]"\.\./"size[8,8.5]".. \
\t\t"image[-0.39,-0.4;10.7,10.9;default_furnace_inv_bg.png]" .. \
\t\t'"$inv_slot_colors"'/' \
    $workdir"/mods/pipeworks/compat-furnaces.lua"

sed -i 's/"size\[8,7;\]" ../"size[8,7]" .. \
\t"image[-0.39,-0.4;10.7,9.1;vessels_inv_bg.png]" .. \
\t'"$inv_slot_colors"'/' \
    $workdir"/mods/vessels/init.lua"

rm $workdir"/mods/unified_inventory/textures/ui_bags_header.png" \
   $workdir"/mods/unified_inventory/textures/ui_bags_inv"* \
   $workdir"/mods/unified_inventory/textures/ui_bags_trash.png" \
   $workdir"/mods/unified_inventory/textures/ui_crafting_form.png" \
   $workdir"/mods/unified_inventory/textures/ui_form_bg.png" \
   $workdir"/mods/unified_inventory/textures/ui_main_inventory.png" \
   $workdir"/mods/unified_inventory/textures/ui_single_slot.png"

mv $workdir"/mods/dreambuilder_extras/ui_"*".png" $workdir"/mods/unified_inventory/textures/"

sed -i 's/local n = 4/formspec[4]="style_type[image_button;bgcolor='"$btn_color"']" \
\tlocal n = 5/' \
    $workdir"/mods/unified_inventory/internal.lua"


# Add in all of the regular player skins for the player_textures mod

rm -f $workdir/mods/player_textures/textures/*

LIST="player_Calinou.png
player_cheapie.png
player_kaeza.png
player_Sokomine.png
player_VanessaE.png"

while read -r FILE; do
cp $upstream_mods_path"/../player_skins/"$FILE \
    $workdir/mods/player_textures/textures
done <<< "$LIST"

rsync -aL \
	--exclude=".git*" \
	$workdir"/" \
	$workdir"_no_git"

rsync -aL \
	$workdir"_no_git/" \
	$game_path

rm -rf $workdir*


echo -e "\nCustomization completed.\n"

#echo -e "Here's what will be included in the game:\n"
#ls -a $game_path $game_path/mods
