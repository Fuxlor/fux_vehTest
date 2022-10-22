ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand('test', function(source, args, rawCommand)
    local veh = args[1]
    local time = 3000
    local sorti = false
    local temps = 30
    local lastPos = GetEntityCoords(PlayerPedId())
    if veh ~= nil then
        RequestModel(veh)
        while not HasModelLoaded(veh) do Citizen.Wait(10) end 
        ESX.ShowAdvancedNotification('vehTest', '', 'Profite bien de tes 30 secondes de test !', 'CHAR_CARSITE', 2) -- notif début
        SetEntityCoords(PlayerPedId(), -963.1749, -3358.958, 13.9772) -- lieu de tp pour tester
        local pos = GetEntityCoords(PlayerPedId())
        local vehicle = CreateVehicle(veh, pos.x, pos.y, pos.z, 90, true, false)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
        Wait(100)
        while time > 0 do
            if IsPedInAnyVehicle(PlayerPedId(), true) then
                time = time - 0.7
                temps = time /100
                RageUI.Text({message='~g~'..math.floor(temps + 0.5*0).. ' ~w~secondes restantes'})
            else
                ESX.ShowAdvancedNotification('vehTest', '', 'Tu es sorti du véhicule !', 'CHAR_CARSITE', 2) -- notif fin
                sorti = true
                time = 0
            end
        Wait(0)
        end
        DeleteEntity(vehicle)
        if sorti == false then ESX.ShowAdvancedNotification('vehTest', '', 'C\'est fini !', 'CHAR_CARSITE', 2) end -- notif fin 
        SetEntityCoords(PlayerPedId(), lastPos)
    else
        ESX.ShowNotification('aucun véhicule fourni')
    end
end, false)
