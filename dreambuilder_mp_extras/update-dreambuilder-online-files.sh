#!/bin/bash

echo -e "\nBuilding Dreambuilder ..."
echo -e "=================================================================\n"

/home/vanessa/Minetest-related/Scripts/customize-dreambuilder.sh

timestamp=`date +%Y%m%d-%H%M`

echo -e "\nCopy Dreambuilder to /home/vanessa/.minetest/mods..."
echo -e "=================================================================\n"

rm -rf /home/vanessa/.minetest/mods/dreambuilder_modpack

cp -a /home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack \
	/home/vanessa/.minetest/mods/

echo -e "\nUpdate git repos..."
echo -e "=================================================================\n"

rm -rf /run/shm/dreambuilder_modpack*

rsync -aL \
	/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack/* \
	/run/shm/dreambuilder_modpack_raw

rsync -a --exclude ".git*" \
	/run/shm/dreambuilder_modpack_raw/* \
	/run/shm/dreambuilder_modpack

cp -a /home/vanessa/Minetest-related/mods/my_mods/dreambuilder_git_refs/.git* \
	/run/shm/dreambuilder_modpack

cd /run/shm/dreambuilder_modpack
git add .
git commit -a
git push
git tag $timestamp
git push --tags
cd ~

echo -e "\nRecreate secondary game archive ..."
echo -e "=================================================================\n"

echo "Build timestamp: $timestamp" > \
	/run/shm/dreambuilder_modpack/build-date.txt

rm -f /home/vanessa/Minetest-related/Dreambuilder_Modpack.tar.bz2
cd /run/shm

tar -jcf /home/vanessa/Digital-Audio-Concepts-Website/vanessa/hobbies/minetest/Dreambuilder_Modpack.tar.bz2 \
	--exclude=".git/*" \
	dreambuilder_modpack

rm	/home/vanessa/Minetest-related/mods/my_mods/dreambuilder_modpack/build-date.txt

/home/vanessa/Scripts/sync-website.sh

rm -rf /run/shm/dreambuilder_modpack*

echo -e "\nDone.  Build timestamp: $timestamp \n"

