-- [[ DÉBUT CORRECTION: Attente de SD.lib ]]
Citizen.CreateThread(function()
    while _G.SD == nil or _G.SD.Callback == nil or _G.SD.Name == nil or _G.SD.Logger == nil or _G.SD.Money == nil or _G.SD.Inventory == nil do
        print("[exp_bank_robbery] (main.lua) En attente de la librairie SD...")
        Wait(1000)
    end
end)
while _G.SD == nil or _G.SD.Callback == nil or _G.SD.Name == nil or _G.SD.Logger == nil or _G.SD.Money == nil or _G.SD.Inventory == nil do
    Wait(10)
end
print("[exp_bank_robbery] (main.lua) Librairie SD chargée.")
-- [[ FIN CORRECTION ]]

local bank_robbed = nil

SD.Callback.Register("exp_bank_robbery:CanBeRobbed", function(source, bank_id)
    if bank_robbed then
        TriggerClientEvent("exp_bank_robbery:ShowNotification", source, {
            title = SD.Locale.T("hack_vault_name"),
            message = SD.Locale.T("vault_empty"),
            type = "error"
        })
        return(false)
    end

    if GetPoliceCount() < POLICE_REQUIRED then
        ShowNotification(source, {
            title = SD.Locale.T("not_enough_police_title"),
            message = SD.Locale.T("not_enough_police"),
            type = "error"
        })
        return(false)
    end

    Citizen.CreateThread(function()
        DiscordLog(source, {
            name = "start",
            message = SD.Name.GetFullName(source).." ("..source..") has stated a bank robbery.\nBank ID: "..bank_id
        })
    
        bank_robbed = bank_id
        Wait(BANK_TIMER)
        TriggerClientEvent("exp_bank_robbery:CloseVaultDoor", -1, bank_id)
        bank_robbed = nil
        DiscordLog(source, { -- Correction: _source n'existe pas, on utilise 'source'
            name = "reset",
            message = "Bank Robbery is reset.\nBank ID: "..bank_id
        })
    end)
    return(true)
end)

RegisterNetEvent("exp_bank_robbery:GiveGrabbedCash", function(amount)
    local _source = source
    local ped = GetPlayerPed(_source)
    if #(GetEntityCoords(ped) - BANKS[bank_robbed].vault_hack.position) > 50 then
        DiscordLog(_source, {
            name = "cheat",
            message = SD.Name.GetFullName(_source).." (".._source..") is cheating!\nBank ID: "..bank_robbed,
            color = 16711680
        })
        return
    end
    DiscordLog(_source, {
        name = "cash",
        message = SD.Name.GetFullName(_source).." (".._source..") just collected $"..amount..".\nBank ID: "..bank_robbed,
    })
    SD.Money.AddMoney(_source, MONEY_TYPE, amount)
end)

RegisterNetEvent("exp_bank_robbery:LockDoor", function(bank, state)
    TriggerClientEvent("exp_bank_robbery:LockDoor", -1, bank, state)
end)

RegisterNetEvent("exp_bank_robbery:OpenVaultDoor", function(bank_id)
    TriggerClientEvent("exp_bank_robbery:OpenVaultDoor", -1, bank_id)
end)

SD.Callback.Register("exp_bank_robbery:GetBankRobbed", function(source)
    return(bank_robbed)
end)

SD.Callback.Register("exp_bank_robbery:HasItem", function(source, item)
    -- [[ CORRECTION CHANGELOG v1.0.6 ]]
    -- HasItem renvoie maintenant la QUANTITÉ, pas 1.
    if SD.Inventory.HasItem(source, item) > 0 then
        return true
    else
        return false
    end
    -- [[ FIN CORRECTION ]]
end)

function ShowNotification(player_src, event)
    TriggerClientEvent("exp_bank_robbery:ShowNotification", player_src, event)
end
