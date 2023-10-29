local ServerCallbacks, CurrentRequestId = {}, 0

function TriggerServerCallback(name, cb, ...)
	ServerCallbacks[CurrentRequestId] = cb

	TriggerServerEvent('exp_bank_robbery:triggerServerCallback', name, CurrentRequestId, ...)

	if CurrentRequestId < 65535 then
		CurrentRequestId = CurrentRequestId + 1
	else
		CurrentRequestId = 0
	end
end

RegisterNetEvent('exp_bank_robbery:serverCallback')
AddEventHandler('exp_bank_robbery:serverCallback', function(requestId, ...)
	ServerCallbacks[requestId](...)
	ServerCallbacks[requestId] = nil
end)

function SetBlip(name, position, sprite, color, scale)
	local blip = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite (blip, sprite)
	SetBlipDisplay(blip, 4)
	SetBlipColour(blip, color)
	SetBlipScale  (blip, scale or 1.0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(name)
	EndTextCommandSetBlipName(blip)
    return blip
end