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

    if GetResourceState("qb-target") == "started" then
        exports["qb-target"]:AddTargetEntity(data.entity, {
            options = {
                {
                    label = data.desc,
                    event = data.event,
                }
            },
            distance = 1.5
        })
    end
end

function SetBlip(name, coords, sprite, color, scale)
	local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

	SetBlipSprite(blip, sprite)
	SetBlipDisplay(blip, 4)
	SetBlipColour(blip, color)
	SetBlipScale(blip, scale or 1.0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
    return blip
end