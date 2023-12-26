local Hacking = false
local f_sucess, f_fail

---@param _f_sucess function Success function
---@param _f_fail function Fail function
function StartHack(_f_sucess, _f_fail)
    if Hacking then return end
    Hacking = true
    f_sucess, f_fail = _f_sucess, _f_fail
    
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "START_HACK",
        resource = GetCurrentResourceName()
    })
end

RegisterNUICallback("Success", function ()
    if f_sucess then f_sucess() end
    ResetHack()
end)

RegisterNuiCallback("Failed", function ()
    if f_fail then f_fail() end
    ResetHack()
end)

function ResetHack()
    Hacking, f_sucess, f_fail = false, nil, nil
    SetNuiFocus(false, false)
end
