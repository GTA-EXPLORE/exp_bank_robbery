-- [[ DÉBUT CORRECTION: Attente de SD.lib ]]
Citizen.CreateThread(function()
    while _G.SD == nil or _G.SD.GetPlayers == nil or _G.SD.HasGroup == nil or _G.SD.Logger == nil or _G.SD.Inventory == nil do
        print("[exp_bank_robbery] (functions.lua) En attente de la librairie SD...")
        Wait(1000)
    end
end)
while _G.SD == nil or _G.SD.GetPlayers == nil or _G.SD.HasGroup == nil or _G.SD.Logger == nil or _G.SD.Inventory == nil do
    Wait(10)
end
print("[exp_bank_robbery] (functions.lua) Librairie SD chargée.")
-- [[ FIN CORRECTION ]]


function GetPoliceCount()
    local count = 0
    for _, sid in ipairs(SD.GetPlayers()) do
        -- [[ CORRECTION v1.1.7 ]]
        -- On vérifie 'sid' (l'ID du joueur) et non 'source'
        -- On ajoute 'true' pour ignorer la vérification de service (duty)
        if SD.HasGroup(sid, POLICE_JOBS, true) then
            count = count + 1
        end
    end
    return count
end

function DiscordLog(player_src, event)
    -- [[ CORRECTION v1.1.6 ]]
    -- La fonction s'appelle SD.Logger.Log(source, title, message)
    -- On utilise player_src, un titre, et le message
    SD.Logger.Log(player_src, "EXP Bank Robbery", event.message)
    -- [[ FIN CORRECTION ]]
end

function DoesPlayerHaveItem(player_src, item)
    -- L'appel est correct, mais la VRAIE vérification se fait dans main.lua
    SD.Inventory.HasItem(player_src, item)
end
