local ped = PlayerPedId()

local inVehicle = false
local vehicle = nil

CreateThread(function()
    while true do
        if (IsPedInAnyVehicle(ped, true)) then
            inVehicle = true
            vehicle = GetVehiclePedIsIn(ped, false)

            if (not GetIsVehicleEngineRunning(vehicle)) then
                inVehicle = false
            end
        else
            inVehicle = false
            vehicle = nil
        end
        SetSpeedometer()
        Wait(1000)
    end
end)

CreateThread(function()
    while true do
        while (inVehicle) do
            UpdateSpeedometer()
            Wait(100)
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
