-- xPanes mod by xyz
-- made into xbars mod by Melkor
-- and finaly made into bedrock mod by ShadowNinja

local function rshift(x, by)
  return math.floor(x / 2 ^ by)
end

local directions = {
    {x = 1, y = 0, z = 0},
    {x = 0, y = 0, z = 1},
    {x = -1, y = 0, z = 0},
    {x = 0, y = 0, z = -1},
}

local function update_bar(pos)
    if minetest.env:get_node(pos).name:find("bedrock:bar") == nil then
        return
    end
    local sum = 0
    for i = 1, 4 do
        local node = minetest.env:get_node({x = pos.x + directions[i].x, y = pos.y + directions[i].y, z = pos.z + directions[i].z})
        if minetest.registered_nodes[node.name] and (minetest.registered_nodes[node.name].walkable ~= false) then
            sum = sum + 2 ^ (i - 1)
        end
    end
    if sum == 0 then
        sum = 15
    end
    minetest.env:add_node(pos, {name = "bedrock:bar_"..sum})
end

local function update_nearby_bars(pos)
    for i = 1,4 do
        update_bar({x = pos.x + directions[i].x, y = pos.y + directions[i].y, z = pos.z + directions[i].z})
    end
end

local half_blocks = {
    {0, -0.5, -0.06, 0.5, 0.5, 0.06},
    {-0.06, -0.5, 0, 0.06, 0.5, 0.5},
    {-0.5, -0.5, -0.06, 0, 0.5, 0.06},
    {-0.06, -0.5, -0.5, 0.06, 0.5, 0}
}

local full_blocks = {
    {-0.5, -0.5, -0.06, 0.5, 0.5, 0.06},
    {-0.06, -0.5, -0.5, 0.06, 0.5, 0.5}
}

for i = 1, 15 do
    local need = {}
    local cnt = 0
    for j = 1, 4 do
        if rshift(i, j - 1) % 2 == 1 then
            need[j] = true
            cnt = cnt + 1
        end
    end
    local take = {}
    if need[1] == true and need[3] == true then
        need[1] = nil
        need[3] = nil
        table.insert(take, full_blocks[1])
    end
    if need[2] == true and need[4] == true then
        need[2] = nil
        need[4] = nil
        table.insert(take, full_blocks[2])
    end
    for k in pairs(need) do
        table.insert(take, half_blocks[k])
    end
    local texture = "bedrock_bar.png"
    if cnt == 1 then
        texture = "bedrock_bar_half.png"
    end
    minetest.register_node("bedrock:bar_"..i, {
        drawtype = "nodebox",
        tiles = {"bedrock_bar_white.png", "bedrock_bar_white.png", texture},
        paramtype = "light",
        groups = {unbreakable = 1},
        drop = "bedrock:bar",
        node_box = {
            type = "fixed",
            fixed = take
        },
        selection_box = {
            type = "fixed",
            fixed = take
        }
    })
end

minetest.register_node("bedrock:bar", {
    description = "Bedrock Bar",
    tiles = {"bedrock_bar.png"},
    inventory_image = "bedrock_bar.png",
    wield_image = "bedrock_bar.png",
    node_placement_prediction = "",
    on_construct = update_bar
})

minetest.register_on_placenode(update_nearby_bars)
minetest.register_on_dignode(update_nearby_bars)

minetest.register_craft({
	output = 'bedrock:bar 16',
	recipe = {
		{'bedrock:bedrock', '', 'bedrock:bedrock'},
        	{'bedrock:bedrock', '', 'bedrock:bedrock'},
        	{'bedrock:bedrock', '', 'bedrock:bedrock'}		
	}
})
