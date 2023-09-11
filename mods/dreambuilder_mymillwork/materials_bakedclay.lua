local clay = {
    {"white", "White"},
    {"grey", "Grey"},
    {"black", "Black"},
    {"red", "Red"},
    {"yellow", "Yellow"},
    {"green", "Green"},
    {"cyan", "Cyan"},
    {"blue", "Blue"},
    {"magenta", "Magenta"},
    {"orange", "Orange"},
    {"violet", "Violet"},
    {"brown", "Brown"},
    {"pink", "Pink"},
    {"dark_grey", "Dark Grey"},
    {"dark_green", "Dark Green"},
}

for _,c in ipairs(clay) do
    mymillwork.register("bakedclay:" .. c[1],
        "bakedclay_" .. c[1],
        c[2] .. " Clay",
        "baked_clay_" .. c[1] .. ".png",
        {crumbly = 3, not_in_creative_inventory = 1}
    )
end
