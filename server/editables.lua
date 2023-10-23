ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GiveGrabbedCash(player_src, event)
    local xPlayer = ESX.GetPlayerFromId(player_src)
    xPlayer.addAccountMoney('black_money', event.earnings)
end

RegisterNetEvent("exp_bank_robbery:SendPoliceAlert")
AddEventHandler("exp_bank_robbery:SendPoliceAlert", function(coords)
    for _, server_id in ipairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(server_id)
        if xPlayer.getJob().name == "lspd" then
            xPlayer.triggerEvent("exp_bank_robbery:ShowPoliceAlert", coords)
        end
    end
end)

function DoesPlayerHaveItem(player_src, item)
    return ESX.GetPlayerFromId(player_src).getInventoryItem(item).count > 0
end

function DiscordLog(player_src, event)
    -- Setup our discord log here.
end

function GetPoliceCount()
    local players = ESX.GetPlayers()
    local count = 0

    for i = 1, #players do
        local player = ESX.GetPlayerFromId(players[i])
        if player.job.name == 'lspd' then
            count = count + 1
        end
    end

    return count
end