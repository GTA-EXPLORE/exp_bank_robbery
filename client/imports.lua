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