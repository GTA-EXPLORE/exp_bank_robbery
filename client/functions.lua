function AddEntityMenuItem(data)
    
    if GetResourceState("exp_target_menu") == "started" then
        exports.exp_target_menu:AddEntityMenuItem({
            entity = data.entity,
            event = data.event,
            name = data.name,
            desc = data.desc
        })
    end

    if GetResourceState("ox_target") == "started" then
        exports.ox_target:addLocalEntity(data.entity, {
            label = data.desc,
            event = data.event,
            distance = 1.5
          })
    end
end