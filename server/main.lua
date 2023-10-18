local bank_robbed = nil

RegisterServerCallback("exp_bank_robbery:CanBeRobbed", function(source, callback, bank_id)
    if bank_robbed then
        TriggerClientEvent("exp_bank_robbery:ShowNotification", source, {
            title = _("hack_vault_name"),
            message = _("vault_empty"),
            type = "error"
        })
        return
    end

    if GetPoliceCount() < POLICE_REQUIRED then
        ShowNotification(source, {
            title = _("not_enough_police_title"),
            message = _("not_enough_police"),
            type = "error"
        })
        return
    end

    callback()

    DiscordLog(_source, {
        name = "start"
    })

    bank_robbed = bank_id
    Wait(BANK_TIMER)
    TriggerClientEvent("exp_bank_robbery:CloseVaultDoor", -1, bank_id)
    bank_robbed = nil
    DiscordLog(_source, {
        name = "reset"
    })
end)

RegisterServerEvent("exp_bank_robbery:GiveGrabbedCash")
AddEventHandler("exp_bank_robbery:GiveGrabbedCash", function(amount)
    local _source = source
    local ped = GetPlayerPed(_source)
    if #(GetEntityCoords(ped) - BANKS[bank_robbed].vault_hack.position) > 50 then
        DiscordLog(_source, {
            name = "cheat"
        })
        return
    end
    DiscordLog(_source, {
        name = "cash",
        earnings = amount
    })
    GiveGrabbedCash(_source, {earnings = amount})
end)

RegisterServerEvent("exp_bank_robbery:LockDoor")
AddEventHandler("exp_bank_robbery:LockDoor", function(bank, state)
    TriggerClientEvent("exp_bank_robbery:LockDoor", -1, bank, state)
end)

RegisterServerEvent("exp_bank_robbery:OpenVaultDoor")
AddEventHandler("exp_bank_robbery:OpenVaultDoor", function(bank_id)
    TriggerClientEvent("exp_bank_robbery:OpenVaultDoor", -1, bank_id)
end)

RegisterServerCallback("exp_bank_robbery:GetBankRobbed", function(source, callback)
    callback(bank_robbed)
end)

RegisterServerCallback("exp_bank_robbery:HasItem", function(source, callback, item)
    callback(DoesPlayerHaveItem(source, item))
end)

function ShowNotification(player_src, event)
    TriggerClientEvent("exp_bank_robbery:ShowNotification", player_src, event)
end