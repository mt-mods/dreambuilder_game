--------------------------------------------------------
-- supporting junk


function min(a,b)
    if a < b then
        return a
    else
        return b
    end
end

if not string.starts then
    function string.starts(String,Start)
        return string.sub(String,1,string.len(Start))==Start
    end
end

--------------------------------------------------------

function sortInventory(inv,sorter)
    local tabl = inv:get_list("main")
    if(tabl == nil) then
        -- we don't sort furnaces!
        return false
    end

    table.sort(tabl,sorter)
    -- note take_item will set the name to '' when empty
    -- NEVER reduce the inventory array size for chests
    inv:set_list('main',tabl)
    return true
end

sorters = {
    wise = function(a,b)
        -- XXX: this needs to have stricter ordering!
        -- (why is air scoring higher than the end?)
        if(a == nil) then
            if b == nil then
                return true
            else
                return false
            end
        elseif b == nil then
            return true
        end

        local aname = a:get_name()
        local bname = b:get_name()
        -- make sure empty slots go at the end

        if(string.len(aname) == 0) then
            return false
        end
        if(string.len(bname) == 0) then
            return true
        end

        -- if the nodes are entirely different, sorted
        if (aname ~= bname) then
            return aname < bname
        end

        -- same node types
        -- may need to collapse the two together!
        local bothmax = a:get_stack_max()
        if bothmax == 1 then
            -- it's unstackable
            local awear = a:get_wear()
            local bwear = b:get_wear()
            return awear < bwear
        end
        local acount = a:get_count()
        local bcount = b:get_count()
        if(acount == bothmax) then
            --print('same?',acount,bcount,bothmax)
            return bcount ~= bothmax
        elseif (bcount == bothmax) then
            --print('bcount bothmax derp')
            return false
        end
        local num = min(bcount,bothmax-acount)
        a:add_item(b:take_item(num))
        -- nothing can have both count AND wear, right?
        -- now a:count > b:count so a should go first
        --print('numnum',num)
        return true
    end,
    amount = function(a,b)
        return a:get_count() > b:get_count()
    end,
    wear = function(a,b)
        return a:get_wear() < b:get_wear()
    end,
    -- etc...
}

function registerWand(method,sorter)
    if method == nil then
        name = "inventory_sorter:wand"
        sorter = sorters.wise
        assert(sorter ~= nil)
        desc = 'Chest Sorter'
        image = 'inventory_sorter_wand.png'
    else
        name = "inventory_sorter:wand_"..method
        desc = "Chest Sorter ("..method..')'
        image = 'inventory_sorter_wand_'..method..'.png'
    end

    minetest.register_tool(name, {
        description = desc,
        inventory_image = image,
        wield_image = image,
        stack_max = 1,
        tool_capabilities = {
            full_punch_interval=0,
            max_drop_level=0
        },
        on_use = function(self,user,punched)
            local pos = minetest.get_pointed_thing_position(punched)
            if pos==nil then
                return
            end
            local meta = minetest.get_meta(pos)
            local inv = meta:get_inventory()
            if(inv == nil) then
                minetest.chat_send_player(user:get_player_name(),"That can't be sorted.","Sorter -!-")
                return
            end
            -- this isn't exported, but default locked chest does this
            local owner = meta:get_string("owner")
            if(owner ~= nil and string.len(owner) ~= 0 and user:get_player_name() ~= owner) then
                minetest.chat_send_player(user:get_player_name(),"That's not yours!","Sorter -!-")
                return
            end
            -- Sokomine's shared chest locks
            if locks ~= nil then
                if punched == nil or punched.name == nil then
                    punched = minetest.get_node(pos)
                end
                if punched and punched.name:starts('locks:') and not locks:lock_allow_use(pos,user) then
                    -- the error has already been reported (yay side effects)
                    return
                end
            end

            if(sortInventory(inv,sorter)) then
                minetest.chat_send_player(user:get_player_name(),"Chest sorted.","Sorter -!-")
            end
        end
    })
end

function debugSorter(a,b)
    result = sorters.wise(a,b)
    function derp(a)
        return a:get_name()..":"..a:get_count()..":"..a:get_wear()
    end
    if a then
        a = derp(a)
    end
    if b then
        b = derp(b)
    end
    if result then
        print('a goes first',a,b)
    else
        print('b goes first',a,b)
    end
    return result
end
function test()
    function thingy(name,stack_max)
        return {
            get_name=function(self) return name end,
            get_stack_max=function(self) return stack_max end,
            get_count=function(self) return stack_max end,
            get_wear=function(self) return 1/stack_max end,
            take_item=function() end,
            add_item=function() end,
            derp=function()
                return name..', '..tostring(stack_max)
            end
        }
    end
    tabl = {thingy('thing1',1),thingy('hting2',1),nil,thingy('thing1',2),thingy('thing1',4),thingy('thing1',10)}
    table.sort(tabl,sorter)
    for n,v in pairs(tabl) do
        print(n,v:get_name(),v:get_count())
    end
end
-- test()
-- print('yay')
-- error('...')

for name,sorter in pairs(sorters) do
    registerWand(name,sorter)
end

registerWand()

minetest.register_craft({
    output = 'inventory_sorter:wand',
    recipe = {
        {'default:stick','default:stick',''},
        {'default:stick','default:stick',''},
        {'','default:stick',''}
    }
})

-- is this one automatic...?

minetest.register_craft({
    output = 'inventory_sorter:wand',
    recipe = {
        {'','default:stick','default:stick'},
        {'','default:stick','default:stick'},
        {'','','default:stick'}
    }
})

minetest.register_chatcommand('sort',{
    params = '[optional algorithm: amount,wear]',
    description = 'Sort your inventory! No takebacks.',
    privs={interact=true},
    func = function(name,param)
        local sorter = sorters.wise;
        if string.len(param) > 0 then
            sorter = sorters[param];
            if sorter == nil then
                minetest.chat_send_player(name,"/sort [algorithm]","Sorter -!-")
                minetest.chat_send_player(name,"Valid algorithms:","Sorter -!-")
                for n,v in pairs(sorters) do
                    minetest.chat_send_player(name,'    '..n,"Sorter -!-")
                end
                return;
            end
        end
        if(sortInventory(minetest.get_player_by_name(name):get_inventory(),sorter)) then
            minetest.chat_send_player(name,"Sorted.","Sorter -!-")
        end
    end
})
