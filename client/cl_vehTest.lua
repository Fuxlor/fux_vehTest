ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand('test', function(source, args, rawCommand)
    ESX.ShowAdvancedNotification('vehTest', '', 'Profite bien de tes 30 secondes de test !', 'CHAR_CARSITE', 2) -- notif début
    local veh = args[1]
    local time = 3000
    temps = 30
    local lastPos = GetEntityCoords(PlayerPedId())
    SetEntityCoords(PlayerPedId(), -963.1749, -3358.958, 13.9772) -- lieu de tp pour tester
    RequestModel(veh)
    while not HasModelLoaded(veh) do Citizen.Wait(10) end 
    local pos = GetEntityCoords(PlayerPedId())
    local vehicle = CreateVehicle(veh, pos.x, pos.y, pos.z, 90, true, false)
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    while time > 0 do
        time = time - 0.7
        temps = time /100
        RageUI.Text({message='~g~'..math.floor(temps + 0.5*0).. ' ~w~secondes restantes'})
    Wait(0)
    end
    DeleteEntity(vehicle)
    ESX.ShowAdvancedNotification('vehTest', '', 'C\'est fini !', 'CHAR_CARSITE', 2) -- notif fin
    SetEntityCoords(PlayerPedId(), lastPos)
end, false)