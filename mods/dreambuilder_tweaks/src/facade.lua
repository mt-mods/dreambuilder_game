for k, v in pairs(minetest.registered_nodes) do
    if v.mod_origin=="facade" and k~="facade:shaper" then
        local groups = table.copy(k.groups or {})
        groups.not_in_creative_inventory = 1
        minetest.override_item(k, {
            groups = groups
        })
    end
end