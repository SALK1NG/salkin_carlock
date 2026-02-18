local ESX = exports["es_extended"]:getSharedObject()
local dict = "anim@mp_player_intmenu@key_fob@"

-- Animation laden
Citizen.CreateThread(function()
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
end)

-- Hauptlogik: Schließen/Öffnen
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(1, Config.CarLock.ControlKey) then
            local playerPed = PlayerPedId()
            local coords = GetEntityCoords(playerPed)
            local vehicle = nil

            if IsPedInAnyVehicle(playerPed, false) then
                vehicle = GetVehiclePedIsIn(playerPed, false)
            else
                vehicle = GetClosestVehicle(coords)
            end

            if vehicle ~= 0 and vehicle ~= nil then
                local distance = #(coords - GetEntityCoords(vehicle))
                if distance < 7.0 then
                    local plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))
                    
                    ESX.TriggerServerCallback('salkin_carlock:isVehicleOwner', function(owner)
                        if owner then
                            ToggleVehicleLock(vehicle)
                        else
                            ESX.ShowNotification(Config.CarLock.NotCarOwner, 'error')
                        end
                    end, plate)
                end
            else
                ESX.ShowNotification(Config.CarLock.NoCar, 'error')
            end
        end
    end
end)

function GetClosestVehicle(coords)
    local vehicle, distance = ESX.Game.GetClosestVehicle(coords)
    if distance ~= -1 and distance <= 7.0 then
        return vehicle
    else
        return nil
    end
end

function ToggleVehicleLock(vehicle)
    local lockStatus = GetVehicleDoorLockStatus(vehicle)

    if lockStatus == 1 or lockStatus == 0 then -- Offen -> Schließen
        SetVehicleDoorsLocked(vehicle, 2)
        PlayVehicleDoorCloseSound(vehicle, 1)
        
        ESX.ShowNotification(Config.CarLock.CarLocked, 'info')
        
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
        end
        
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carlock', Config.CarLock.CarBleepVolume)
        VisualEffects(vehicle)
    elseif lockStatus == 2 then -- Geschlossen -> Öffnen
        SetVehicleDoorsLocked(vehicle, 1)
        PlayVehicleDoorOpenSound(vehicle, 0)
        
        ESX.ShowNotification(Config.CarLock.CarOpen, 'info')
        
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)
        end
        
        TriggerServerEvent('InteractSound_SV:PlayOnSource', 'carlock', Config.CarLock.CarBleepVolume)
        VisualEffects(vehicle)
    end
end

function VisualEffects(vehicle)
    if Config.CarLock.BlinkingLighstON then
        SetVehicleLights(vehicle, 2)
        Citizen.Wait(200)
        SetVehicleLights(vehicle, 0)
        Citizen.Wait(200)
        SetVehicleLights(vehicle, 2)
        Citizen.Wait(200)
        SetVehicleLights(vehicle, 0)
    end
end