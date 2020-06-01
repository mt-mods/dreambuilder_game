#!/bin/bash

echo -e "\nBuilding Dreambuilder ..."
echo -e "=================================================================\n"

/home/vanessa/Minetest-related/Scripts/customize-dreambuilder.sh

timestamp=`date +%Y%m%d-%H%M`

echo -e "\nUpdate git repos..."
echo -e "=================================================================\n"

cd /home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack
git add .
git commit -a
git push
git tag $timestamp
git push --tags
cd ~

echo -e "\nRecreate secondary game archive ..."
echo -e "=================================================================\n"

echo "Build timestamp: $timestamp" > \
	/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack/build-date.txt

rm -f /home/vanessa/Minetest-related/Dreambuilder_Modpack.tar.bz2
cd /home/vanessa/Minetest-related/mods/my_mods

tar -jcf /home/vanessa/Digital-Audio-Concepts-Website/vanessa/hobbies/minetest/Dreambuilder_Modpack.tar.bz2 \
	--exclude=".git/*" \
	dreambuilder_modpack

rm	/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack/build-date.txt

/home/vanessa/Scripts/sync-website.sh

echo -e "\nDone.  Build timestamp: $timestamp \n"

