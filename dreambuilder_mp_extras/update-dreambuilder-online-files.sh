#!/bin/bash

echo -e "\nBuilding Dreambuilder ..."
echo -e "=================================================================\n"

/home/vanessa/Minetest-related/Scripts/customize-dreambuilder.sh

timestamp=`date +%Y%m%d-%H%M`

echo -e "\nCopy the Dreambuilder to /home/vanessa/.minetest/mods..."
echo -e "=================================================================\n"

rsync -a --exclude=".git/" \
		/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack \
		/home/vanessa/.minetest/mods/

echo -e "\nUpdate git repo..."
echo -e "=================================================================\n"

cd /home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack
git add .
git commit -a
git push
git tag $timestamp
git push --tags

echo -e "\nRecreate secondary game archive ..."
echo -e "=================================================================\n"

echo "Build timestamp: $timestamp" > \
	/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack/build-date.txt

rm -f /home/vanessa/Minetest-related/Dreambuilder_Modpack.tar.bz2
cd /home/vanessa/Minetest-related/mods/my_mods/

tar -jcf /home/vanessa/Digital-Audio-Concepts-Website/vanessa/hobbies/minetest/Dreambuilder_Modpack.tar.bz2 \
	--exclude=".git/*" \
	dreambuilder_modpack
rm	/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack/build-date.txt

echo -e "\nSync the local mod cache to the web server ..."
echo -e "================================================\n"

rsync -L --exclude=\*.git \
	--delete --progress -a -v -z -O --checksum -e "ssh" \
	/home/vanessa/Minetest-related/mods/ \
	minetest@daconcepts.com:/home/minetest/www/my-main-mod-archive

/home/vanessa/Scripts/sync-website.sh

echo -e "\nDone.  Build timestamp: $timestamp \n"

