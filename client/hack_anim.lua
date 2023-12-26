function AnimateHacking(panel)
    local animDict = "anim@heists@ornate_bank@hack"

    RequestAnimDict(animDict)
    RequestModel(GetHashKey("hei_prop_hst_laptop"))
    RequestModel(GetHashKey("hei_p_m_bag_var22_arm_s"))
    RequestModel(GetHashKey("hei_prop_heist_card_hack_02"))

    while not HasAnimDictLoaded(animDict)
        or not HasModelLoaded(GetHashKey("hei_prop_hst_laptop"))
        or not HasModelLoaded(GetHashKey("hei_p_m_bag_var22_arm_s"))
        or not HasModelLoaded(GetHashKey("hei_prop_heist_card_hack_02")) do Wait(50)
    end
    local ped = PlayerPedId()
    local targetPosition, targetRotation = GetEntityCoords(ped), GetEntityRotation(ped)
    local animPos = GetEntityCoords(panel) -- These are fixed locations so if you want to change animation location change here

    local self_bag = {
        drawable = GetPedDrawableVariation(ped, 5),
        texture = GetPedTextureVariation(ped, 5)
    }

    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)

    -- part1
    FreezeEntityPosition(ped, true)
    local netScene = NetworkCreateSynchronisedScene(animPos, GetEntityRotation(panel), 2, false, false, 1065353216, 0, 1.0)
    NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "hack_enter", 1.5, -4.0, 1, 16, 1148846080, 0)
    local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene, animDict, "hack_enter_bag", 4.0, -8.0, 1)
    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)
    -- part2
    local netScene2 = NetworkCreateSynchronisedScene(animPos, GetEntityRotation(panel), 2, false, false, 1065353216, 0, 0.5)
    NetworkAddPedToSynchronisedScene(ped, netScene2, animDict, "hack_loop", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene2, animDict, "hack_loop_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene2, animDict, "hack_loop_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene2, animDict, "hack_loop_card", 4.0, -8.0, 1)
    -- part3
    local netScene3 = NetworkCreateSynchronisedScene(animPos, GetEntityRotation(panel), 2, false, false, 1065353216, 0, 1.0)
    NetworkAddPedToSynchronisedScene(ped, netScene3, animDict, "hack_exit", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, netScene3, animDict, "hack_exit_bag", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(laptop, netScene3, animDict, "hack_exit_laptop", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(card, netScene3, animDict, "hack_exit_card", 4.0, -8.0, 1)

    SetPedComponentVariation(ped, 5, 0, 0, 0) -- removes bag from ped so no 2 bags

    local view_mode = GetFollowPedCamViewMode()
    SetFollowPedCamViewMode(4)

    NetworkStartSynchronisedScene(netScene)
    Wait(GetAnimDuration("anim@heists@ornate_bank@hack", "hack_enter_card")*1000-100)
    -- NetworkStopSynchronisedScene(netScene)

    NetworkStartSynchronisedScene(netScene2)
    Wait(1000)
    local is_hack_finished, has_succeeded = false, false
    Citizen.CreateThread(function()
        StartHack(function ()
            is_hack_finished = true
            has_succeeded = true
        end, function ()
            is_hack_finished = true
            has_succeeded = false
            ShowNotification({
                title = _("hack_failed_name"),
                message = _("hack_failed"),
                type = "error"
            })
        end)
    end)
    Wait(GetAnimDuration("anim@heists@ornate_bank@hack", "hack_loop_laptop")*1000-1100)
    while not is_hack_finished do
        NetworkStartSynchronisedScene(netScene2)
        Wait(GetAnimDuration("anim@heists@ornate_bank@hack", "hack_loop_laptop")*1000-1100)
    end
    -- NetworkStopSynchronisedScene(netScene2)
    
    NetworkStartSynchronisedScene(netScene3)
    Wait(GetAnimDuration("anim@heists@ornate_bank@hack", "hack_exit_card")*1000-100)
    -- NetworkStopSynchronisedScene(netScene3)
    
    DeleteObject(bag)
    DeleteObject(laptop)
    DeleteObject(card)
    FreezeEntityPosition(ped, false)
    SetPedComponentVariation(ped, 5, self_bag.drawable, self_bag.texture, 0) -- gives bag back to ped
    SetFollowPedCamViewMode(view_mode)
    return has_succeeded
end