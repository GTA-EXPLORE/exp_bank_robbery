function AnimateGrabCash(trolley)
    NetworkRequestControlOfEntity(trolley)
    while not NetworkHasControlOfEntity(trolley) do Wait(100) end
    player.Ped = PlayerPedId()
    player.Pos = GetEntityCoords(player.Ped)
    FreezeEntityPosition(player.Ped, true)
    local cash_model = GetHashKey("hei_prop_heist_cash_pile")
    local bag_model = GetHashKey("hei_p_m_bag_var22_arm_s")
    local empty_trolley_model = GetHashKey("hei_prop_hei_cash_trolly_03")
    local anim_dict = "anim@heists@ornate_bank@grab_cash"
    RequestModel(cash_model)
    RequestModel(bag_model)
    RequestModel(empty_trolley_model)
    RequestAnimDict(anim_dict)

    while not HasAnimDictLoaded(anim_dict)
        or not HasModelLoaded(cash_model)
        or not HasModelLoaded(cash_model)
        or not HasModelLoaded(empty_trolley_model) do Wait(1)
    end

    local self_bag = {
        drawable = GetPedDrawableVariation(player.Ped, 5),
        texture = GetPedTextureVariation(player.Ped, 5)
    }

    local anim_pos, anim_rot = GetEntityCoords(trolley), GetEntityRotation(trolley)

    local trolleyFwd = GetEntityForwardVector(trolley)
    local trolley90 = vec(trolleyFwd.y, trolleyFwd.x*-1)
    -- trolleyFwd = vec(trolleyFwd.x*-1, trolleyFwd.y*-1)
    
    local camPos = vec(anim_pos.x + trolleyFwd.x*1.5 + trolley90.x*1.5, anim_pos.y + trolleyFwd.y*1.5 + trolley90.y*1.5, anim_pos.z+1)
    local camHeading = GetHeadingFromVector_2d(anim_pos.x - camPos.x, anim_pos.y - camPos.y)

    local grab_cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camPos, -20.0, 0.0, camHeading,  60.0, false, 0)
    SetCamActive(grab_cam, true)
    RenderScriptCams(true, true, 1000, true, true)


    local net_scene = NetworkCreateSynchronisedScene(anim_pos, anim_rot, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(player.Ped, net_scene, anim_dict, "intro", 1.0, -4.0, 1, 16, 1148846080, 0)
    local bag = CreateObject(bag_model, player.Pos, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(bag, net_scene, anim_dict, "bag_intro", 4.0, -8.0, 1)
    Entities[#Entities+1] = bag

    local net_scene_2 = NetworkCreateSynchronisedScene(anim_pos, anim_rot, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(player.Ped, net_scene_2, anim_dict, "grab", 1.0, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, net_scene_2, anim_dict, "bag_grab", 4.0, -8.0, 1)
    NetworkAddEntityToSynchronisedScene(trolley, net_scene_2, anim_dict, "cart_cash_dissapear", 4.0, -8.0, 1)

    local net_scene_3 = NetworkCreateSynchronisedScene(anim_pos, anim_rot, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(player.Ped, net_scene_3, anim_dict, "exit", 1.0, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, net_scene_3, anim_dict, "bag_exit", 4.0, -8.0, 1)

    SetPedComponentVariation(player.Ped, 5, 0, 0)
    NetworkStartSynchronisedScene(net_scene)
    Wait((GetAnimDuration(anim_dict, "intro")*1000)/1.3-100)

    local in_net_scene_2 = true
    NetworkStartSynchronisedScene(net_scene_2)
    local cash_prop = CreateObject(cash_model, player.Pos, true, true)
    FreezeEntityPosition(cash_prop, true)
    SetEntityInvincible(cash_prop, true)
    SetEntityNoCollisionEntity(cash_prop, player.Ped)
    SetEntityVisible(cash_prop, false)
    AttachEntityToEntity(cash_prop, player.Ped, GetPedBoneIndex(player.Ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
    Entities[#Entities+1] = cash_prop
    
    Citizen.CreateThread(function()
        while in_net_scene_2 do Wait(1)
            if HasAnimEventFired(player.Ped, GetHashKey("CASH_APPEAR")) then SetEntityVisible(cash_prop, true) end
            if HasAnimEventFired(player.Ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                AddMoneyToBag()
                SetEntityVisible(cash_prop, false)
            end
        end
    end)
    Wait((GetAnimDuration(anim_dict, "grab")*1000)/1.3)
    DeleteObject(trolley)
    local empty_trolley = CreateObject(empty_trolley_model, anim_pos, true, true)
    Entities[#Entities+1] = empty_trolley
    PlaceObjectOnGroundProperly(empty_trolley)
    FreezeEntityPosition(empty_trolley, true)
    SetEntityRotation(empty_trolley, anim_rot)
    DeleteObject(cash_prop)
    in_net_scene_2 = false

    NetworkStartSynchronisedScene(net_scene_3)
    Wait((GetAnimDuration(anim_dict, "exit")*1000)/1.3-100)
    
    SetCamActive(grab_cam, false)
    RenderScriptCams(false, true, 1000, true, true)

    DeleteObject(bag)
    SetPedComponentVariation(player.Ped, 5, self_bag.drawable, self_bag.texture, 0) -- gives bag back to ped
    FreezeEntityPosition(player.Ped, false)
    return true
end

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
    Entities[#Entities+1] = bag
    local laptop = CreateObject(GetHashKey("hei_prop_hst_laptop"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(laptop, netScene, animDict, "hack_enter_laptop", 4.0, -8.0, 1)
    Entities[#Entities+1] = laptop
    local card = CreateObject(GetHashKey("hei_prop_heist_card_hack_02"), targetPosition, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(card, netScene, animDict, "hack_enter_card", 4.0, -8.0, 1)
    Entities[#Entities+1] = card

    -- part2
    local netScene2 = NetworkCreateSynchronisedScene(animPos, GetEntityRotation(panel), 2, false, true, 1065353216, 0, 0.5)
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

    -- local view_mode = GetFollowPedCamViewMode()
    -- SetFollowPedCamViewMode(4)
    local panelFwd = GetEntityForwardVector(panel)
    local panel90 = vec(panelFwd.y*-1, panelFwd.x)
    panelFwd = vec(panelFwd.x*-1, panelFwd.y*-1)

    local camPos = vec(animPos.x + panelFwd.x*1.5 + panel90.x*1.5, animPos.y + panelFwd.y*1.5 + panel90.y*1.5, animPos.z)
    local camHeading = GetHeadingFromVector_2d(animPos.x - camPos.x, animPos.y - camPos.y)

    local hack_cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", camPos, -20.0, 0.0, camHeading,  60.0, false, 0)
    SetCamActive(hack_cam, true)
    RenderScriptCams(true, true, 1000, true, true)

    NetworkStartSynchronisedScene(netScene)
    Wait(GetAnimDuration(animDict, "hack_enter_card")*1000-100)

    NetworkStartSynchronisedScene(netScene2)
    Wait(1000)
    local has_succeeded = exports.exp_hack:StartHack({
        rounds = 2,
        squares = 3
    }, nil , function ()
        ShowNotification({
            title = SD.Locale.T("hack_failed_name"),
            message = SD.Locale.T("hack_failed"),
            type = "error"
        })
    end)
    
    NetworkStartSynchronisedScene(netScene3)
    Wait(GetAnimDuration(animDict, "hack_exit_card")*1000-100)
    
    DeleteObject(bag)
    DeleteObject(laptop)
    DeleteObject(card)
    FreezeEntityPosition(ped, false)
    SetPedComponentVariation(ped, 5, self_bag.drawable, self_bag.texture, 0) -- gives bag back to ped
    -- SetFollowPedCamViewMode(view_mode)
    SetCamActive(hack_cam, false)
    RenderScriptCams(false, true, 1000, true, true)
    return has_succeeded
end