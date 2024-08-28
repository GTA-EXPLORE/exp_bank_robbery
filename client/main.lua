player = {}
bank_to_vault = {}
local bank = nil
Entities = {}

Citizen.CreateThread(function()
    while not DoesEntityExist(PlayerPedId()) do Wait(100) end

    SD.Callback("exp_bank_robbery:GetBankRobbed", false, function(bank_robbed)
        SetupBanks(bank_robbed)
    end)
end)

local vh_to_bank = {}
function SetupBanks(bank_robbed)
    RequestModel(BANKS.pillbox.vault_hack.model)
    while not HasModelLoaded(BANKS.pillbox.vault_hack.model) do Wait(100) end

    for k, v in pairs(BANKS) do
        local vault_hack = CreateObject(v.vault_hack.model, v.vault_hack.position, false, false, false)
        SetEntityAsMissionEntity(vault_hack)
        FreezeEntityPosition(vault_hack, true)
        SetEntityRotation(vault_hack, v.vault_hack.rotation)
        SetEntityInvincible(vault_hack, true)
        vh_to_bank[vault_hack] = k
        Entities[#Entities+1] = vault_hack
        
        AddDoorToSystem(GetHashKey("bank_robbery_"..k), v.door.model, v.door.position)

        bank_to_vault[k] = CreateObject(v.vault_door.model, v.vault_door.position, false, false, false)
        FreezeEntityPosition(bank_to_vault[k], true)
        SetEntityRotation(bank_to_vault[k], 0.0, 0.0, bank_robbed == k and v.vault_door.reset_yaw-90 or v.vault_door.reset_yaw)
        SetEntityInvincible(bank_to_vault[k], true)
        SetEntityAsMissionEntity(bank_to_vault[k])
        Entities[#Entities+1] = bank_to_vault[k]

        AddEntityMenuItem({
            entity = vault_hack,
            event = "exp_bank_robbery:StartVaultHack",
            name = SD.Locale.T("hack_vault_name"),
            desc = SD.Locale.T("hack_vault")
        })
    end

    if bank then
        local door_hack = GetClosestObjectOfType(bank.door_hack.position, 1.0, bank.door_hack.model)
        while bank and not DoesEntityExist(door_hack) do Wait(100)
            door_hack = GetClosestObjectOfType(bank.door_hack.position, 1.0, bank.door_hack.model)
        end
        AddEntityMenuItem({
            entity = door_hack,
            event = "exp_bank_robbery:StartDoorHack",
            name = SD.Locale.T("hack_vault_name"),
            desc = SD.Locale.T("hack_vault")
        })
    end
end

RegisterNetEvent("exp_bank_robbery:StartVaultHack", function(data)
    local entity = data.entity

    if HACK_ITEM then
        SD.Callback("exp_bank_robbery:HasItem", false, function(has_item)
            if not has_item then
                ShowNotification({
                    title = SD.Locale.T("hack_vault"),
                    message = SD.Locale.T("no_laptop"),
                    type = "error"
                })
                return
            end
            
            StartVaultHack(entity)
        end, HACK_ITEM)
    else
        StartVaultHack(entity)
    end
end)

function StartVaultHack(entity)
    bank = BANKS[vh_to_bank[entity]]
    bank.bank = vh_to_bank[entity]
    SD.Callback("exp_bank_robbery:CanBeRobbed", false, function(allowed)
        if not allowed then return end
        player.Ped = PlayerPedId()
        
        local success = AnimateHacking(entity)

        TriggerServerEvent("exp_bank_robbery:SendPoliceAlert", GetEntityCoords(player.Ped))
        if success then
            PrepareInside()
            
            TriggerServerEvent("exp_bank_robbery:OpenVaultDoor", bank.bank)
            ShowNotification({
                title = SD.Locale.T("hack_vault_name"),
                message = SD.Locale.T("vault_hacked"),
                type = "success"
            })
        end
    end, bank.bank)
end

RegisterNetEvent("exp_bank_robbery:GrabCash", function(data)
    local entity = data.entity
    player.Ped = PlayerPedId()
    if not DoesPedHaveAnyBag(player.Ped) then
        ShowNotification({
            title = SD.Locale.T("grab_cash"),
            message = SD.Locale.T("no_bag"),
            type = "error"
        })
        return
    end
    player.MoneyBag = 0
    AnimateGrabCash(entity)
    TriggerServerEvent("exp_bank_robbery:GiveGrabbedCash", player.MoneyBag)
end)

function PrepareInside()
    RequestModel(bank.first_cash.model)
    RequestModel(bank.second_cash.model)
    RequestModel(bank.third_cash.model)
    RequestModel(bank.door_hack.model)
    RequestModel(bank.door.model)
    while not HasModelLoaded(bank.first_cash.model)
        or not HasModelLoaded(bank.second_cash.model)
        or not HasModelLoaded(bank.third_cash.model)
        or not HasModelLoaded(bank.door_hack.model)
        or not HasModelLoaded(bank.door.model) do Wait(100)
    end
    
    -- FIRST CASH LOCATION

    local old_first_cash = GetClosestObjectOfType(bank.first_cash.position, 1.0, bank.first_cash.model)
    if DoesEntityExist(old_first_cash) then
        NetworkRequestControlOfEntity(old_first_cash)
        while not NetworkHasControlOfEntity(old_first_cash) do Wait(10) end
        DeleteObject(old_first_cash)
    end

    local old_first_cash_empty = GetClosestObjectOfType(bank.first_cash.position, 1.0, GetHashKey("hei_prop_hei_cash_trolly_03"))
    if DoesEntityExist(old_first_cash_empty) then
        NetworkRequestControlOfEntity(old_first_cash_empty)
        while not NetworkHasControlOfEntity(old_first_cash_empty) do Wait(10) end
        DeleteObject(old_first_cash_empty)
    end

    local first_cash = CreateObject(bank.first_cash.model, bank.first_cash.position, true, true)
    SetEntityRotation(first_cash, bank.first_cash.rotation)
    FreezeEntityPosition(first_cash, true)
    PlaceObjectOnGroundProperly(first_cash)
    Entities[#Entities+1] = first_cash

    -- SECOND CASH LOCATION

    local old_second_cash = GetClosestObjectOfType(bank.second_cash.position, 1.0, bank.second_cash.model)
    if DoesEntityExist(old_second_cash) then
        NetworkRequestControlOfEntity(old_second_cash)
        while not NetworkHasControlOfEntity(old_second_cash) do Wait(10) end
        DeleteObject(old_second_cash)
    end

    local old_second_cash_empty = GetClosestObjectOfType(bank.second_cash.position, 1.0, GetHashKey("hei_prop_hei_cash_trolly_03"))
    if DoesEntityExist(old_second_cash_empty) then
        NetworkRequestControlOfEntity(old_second_cash_empty)
        while not NetworkHasControlOfEntity(old_second_cash_empty) do Wait(10) end
        DeleteObject(old_second_cash_empty)
    end

    local second_cash = CreateObject(bank.second_cash.model, bank.second_cash.position, true, true)
    SetEntityRotation(second_cash, bank.second_cash.rotation)
    FreezeEntityPosition(second_cash, true)
    PlaceObjectOnGroundProperly(second_cash)
    Entities[#Entities+1] = second_cash

    -- THIRD CASH LOCATION

    local old_third_cash = GetClosestObjectOfType(bank.third_cash.position, 1.0, bank.third_cash.model)
    if DoesEntityExist(old_third_cash) then
        NetworkRequestControlOfEntity(old_third_cash)
        while not NetworkHasControlOfEntity(old_third_cash) do Wait(10) end
        DeleteObject(old_third_cash)
    end

    local old_third_cash_empty = GetClosestObjectOfType(bank.third_cash.position, 1.0, GetHashKey("hei_prop_hei_cash_trolly_03"))
    if DoesEntityExist(old_third_cash_empty) then
        NetworkRequestControlOfEntity(old_third_cash_empty)
        while not NetworkHasControlOfEntity(old_third_cash_empty) do Wait(10) end
        DeleteObject(old_third_cash_empty)
    end

    local third_cash = CreateObject(bank.third_cash.model, bank.third_cash.position, true, true)
    SetEntityRotation(third_cash, bank.third_cash.rotation)
    FreezeEntityPosition(third_cash, true)
    PlaceObjectOnGroundProperly(third_cash)
    Entities[#Entities+1] = third_cash

    -- DOOR HACK LOCATION

    local old_door_hack = GetClosestObjectOfType(bank.door_hack.position, 0.5, bank.door_hack.model)
    if DoesEntityExist(old_door_hack) then
        NetworkRequestControlOfEntity(old_door_hack)
        while not NetworkHasControlOfEntity(old_door_hack) do Wait(10) end
        DeleteObject(old_door_hack)
    end

    local door_hack = CreateObject(bank.door_hack.model, bank.door_hack.position, true, true)
    SetEntityRotation(door_hack, bank.door_hack.rotation)
    FreezeEntityPosition(door_hack, true)
    Entities[#Entities+1] = door_hack

    TriggerServerEvent("exp_bank_robbery:LockDoor", bank.bank, true)
end

RegisterNetEvent("exp_bank_robbery:StartDoorHack", function(data)
    local entity = data.entity
    local success = AnimateHacking(entity)
    if success then
        TriggerServerEvent("exp_bank_robbery:LockDoor", bank.bank, false)

        ShowNotification({
            title = SD.Locale.T("hack_door_name"),
            message = SD.Locale.T("door_hacked"),
            type = "success"
        })
    end
end)

function AddMoneyToBag()
    player.MoneyBag = player.MoneyBag + MONEY_PER_STACK
end

RegisterNetEvent("exp_bank_robbery:LockDoor", function(bank_id, state)
    DoorSystemSetDoorState(GetHashKey("bank_robbery_"..bank_id), state)
    if state then
        bank = BANKS[bank_id]
        bank.bank = bank_id
        local first_cash = GetClosestObjectOfType(bank.first_cash.position, 1.0, bank.first_cash.model)
        while bank and not DoesEntityExist(first_cash) do Wait(100)
            first_cash = GetClosestObjectOfType(bank.first_cash.position, 1.0, bank.first_cash.model)
        end

        AddEntityMenuItem({
            entity = first_cash,
            event = "exp_bank_robbery:GrabCash",
            name = SD.Locale.T("grab_cash_name"),
            desc = SD.Locale.T("grab_cash")
        })

        local second_cash = GetClosestObjectOfType(bank.second_cash.position, 1.0, bank.second_cash.model)
        while bank and not DoesEntityExist(second_cash) do Wait(100)
            second_cash = GetClosestObjectOfType(bank.second_cash.position, 1.0, bank.second_cash.model)
        end
        AddEntityMenuItem({
            entity = second_cash,
            event = "exp_bank_robbery:GrabCash",
            name = SD.Locale.T("grab_cash_name"),
            desc = SD.Locale.T("grab_cash")
        })

        local third_cash = GetClosestObjectOfType(bank.third_cash.position, 1.0, bank.third_cash.model)
        while bank and not DoesEntityExist(third_cash) do Wait(100)
            third_cash = GetClosestObjectOfType(bank.third_cash.position, 1.0, bank.third_cash.model)
        end

        AddEntityMenuItem({
            entity = third_cash,
            event = "exp_bank_robbery:GrabCash",
            name = SD.Locale.T("grab_cash_name"),
            desc = SD.Locale.T("grab_cash")
        })

        local door_hack = GetClosestObjectOfType(bank.door_hack.position, 1.0, bank.door_hack.model)
        while bank and not DoesEntityExist(door_hack) do Wait(100)
            door_hack = GetClosestObjectOfType(bank.door_hack.position, 1.0, bank.door_hack.model)
        end

        AddEntityMenuItem({
            entity = door_hack,
            event = "exp_bank_robbery:StartDoorHack",
            name = SD.Locale.T("hack_vault_name"),
            desc = SD.Locale.T("hack_vault")
        })

        if GetResourceState("exp_target_menu") == "started" then
            exports.exp_target_menu:SetModelOffset({
                model = bank.first_cash.model,
                offset = vector3(0.0, 0.0, 0.5)
            })
        end
    end
end)

RegisterNetEvent("exp_bank_robbery:OpenVaultDoor", function(bank_id)
    for i = 1, 90, 0.2 do
        SetEntityRotation(bank_to_vault[bank_id], 0.0, 0.0, BANKS[bank_id].vault_door.reset_yaw-i)
        Wait(10)
    end
end)

RegisterNetEvent("exp_bank_robbery:CloseVaultDoor", function(bank_id)
    SetEntityRotation(bank_to_vault[bank_id], 0.0, 0.0, BANKS[bank_id].vault_door.reset_yaw)
    bank = nil
end)

RegisterNetEvent("exp_bank_robbery:ShowPoliceAlert", function(position)
    local blip_icon = SetBlip(SD.Locale.T("alert_title"), position, POL_ALERT_SPRITE, POL_ALERT_COLOR, 1.0)
    SetBlipAsShortRange(blip_icon, false)
    if POL_ALERT_WAVE then
        local blip_wave = SetBlip("", position, 161, POL_ALERT_COLOR, 1.0)
        SetBlipDisplay(blip_wave, 8)
        SetBlipAsShortRange(blip_wave, false)
    end

    Wait(POL_ALERT_TIME)
    
    RemoveBlip(blip_icon)
    RemoveBlip(blip_wave)
    ShowNotification({
        title = SD.Locale.T("alert_title"),
        message = SD.Locale.T("alert_content")
    })
end)

RegisterNetEvent("exp_bank_robbery:ShowNotification", function(data)
    ShowNotification(data)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for index, value in ipairs(Entities) do
        DeleteEntity(value)
    end
end)