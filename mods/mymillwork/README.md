mymillwork
========

Crown Mold, Baseboards, Columns and more To minetest

Licence - DWYWPL

If you want to add or remove a texture simply edit the materials.lua file.

Each texture has 24 nodes so careful that you don't add too many textures.



API example:

```lua
mymillwork.register("default:stone",
    "default_stone",
    "Stone",
    "default_stone.png",
    {cracky=3, stone=1, not_in_creative_inventory=1},
)
```
