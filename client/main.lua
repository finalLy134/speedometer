local vehicle = nil
local inVehicle = false

CreateThread(function()
    while true do
        vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
        if vehicle ~= 0 and GetIsVehicleEngineRunning(vehicle) then
            inVehicle = true
        else
            inVehicle = false
        end
        SetSpeedometer()
        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        while (inVehicle) do
            UpdateSpeedometer()
            Wait(Config.UpdateInterval)
        end
        Wait(2500)
    end
end)

function SetSpeedometer()
    SendNUIMessage({
        action = "toggle",
        inVehicle = inVehicle
    })
end

function UpdateSpeedometer()
    if not inVehicle or vehicle == nil then return end

    local speed = GetEntitySpeed(vehicle)

    SendNUIMessage({
        action = "update",
        speed = speed,
    })
end
