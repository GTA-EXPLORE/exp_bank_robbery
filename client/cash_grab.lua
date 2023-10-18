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

    local net_scene = NetworkCreateSynchronisedScene(anim_pos, anim_rot, 2, false, false, 1065353216, 0, 1.3)
    NetworkAddPedToSynchronisedScene(player.Ped, net_scene, anim_dict, "intro", 1.0, -4.0, 1, 16, 1148846080, 0)
    local bag = CreateObject(bag_model, player.Pos, 1, 1, 0)
    NetworkAddEntityToSynchronisedScene(bag, net_scene, anim_dict, "bag_intro", 4.0, -8.0, 1)

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
    
    Citizen.CreateThread(function()
        while in_net_scene_2 do Wait(1)
            if HasAnimEventFired(player.Ped, GetHashKey("CASH_APPEAR")) then SetEntityVisible(cash_prop, true) end
            if HasAnimEventFired(player.Ped, GetHashKey("RELEASE_CASH_DESTROY")) then
                AddMoneyToBag()
                SetEntityVisible(cash_prop, false)
            end
        end
    end)
    Wait((GetAnimDuration(anim_dict, "grab")*1000)/1.3-100)
    DeleteObject(trolley)
    local empty_trolley = CreateObject(empty_trolley_model, anim_pos, true, true)
    PlaceObjectOnGroundProperly(empty_trolley)
    FreezeEntityPosition(empty_trolley, true)
    SetEntityRotation(empty_trolley, anim_rot)
    DeleteObject(cash_prop)
    in_net_scene_2 = false

    NetworkStartSynchronisedScene(net_scene_3)
    Wait((GetAnimDuration(anim_dict, "exit")*1000)/1.3-100)

    DeleteObject(bag)
    SetPedComponentVariation(player.Ped, 5, self_bag.drawable, self_bag.texture, 0) -- gives bag back to ped
    FreezeEntityPosition(player.Ped, false)
    return true
end