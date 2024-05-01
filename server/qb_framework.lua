if GetResourceState("qb-core") == "started" then
    print("^5Starting with QB-Core^0")
    QBCore = exports['qb-core']:GetCoreObject()
    
    if HACK_ITEM then
        QBCore.Functions.AddItem(HACK_ITEM, {
            name = HACK_ITEM,
            label = 'Laptop',
            weight = 10,
            type = 'item',
            image = 'laptop.png',
            unique = false,
            useable = false,
            shouldClose = false,
            combinable = nil,
            description = 'Just a regular laptop.'
        })
    end
    
    function GiveGrabbedCash(player_src, event)
        QBCore.Functions.GetPlayer(player_src).Functions.AddMoney("cash", event.earnings)
    end
    
    RegisterNetEvent("exp_bank_robbery:SendPoliceAlert")
    AddEventHandler("exp_bank_robbery:SendPoliceAlert", function(coords)
        for ServerId, Player in ipairs(QBCore.Functions.GetQBPlayers()) do
            if Player.PlayerData.job.name == "police" then
                TriggerClientEvent("exp_bank_robbery:ShowPoliceAlert", ServerId, coords)
            end
        end
    end)
    
    function DoesPlayerHaveItem(player_src, item)
        return QBCore.Functions.GetPlayer(player_src).Functions.GetItemByName(item).amount > 0
    end
    
    function DiscordLog(player_src, event)
        -- Setup your logs
    end
    
    function GetPoliceCount()
        local count = 0
        for ServerId, Player in ipairs(QBCore.Functions.GetQBPlayers()) do
            if Player.PlayerData.job.type == "leo" then
                count = count + 1
            end
        end
        return count
    end
end
