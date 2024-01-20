-- Define a function to start the hurricane
function startHurricane()
    -- Gradually change the weather to thunder over a period of 5 minutes
    for i = 1, 5 do
        Citizen.Wait(60000) -- Wait for 1 minute
        local weatherTypes = {'CLEAR', 'EXTRASUNNY', 'CLOUDS', 'OVERCAST', 'RAIN', 'THUNDER'}
        TriggerEvent('qb-weathersync:server:setWeather', weatherTypes[i])
    end

    -- Gradually increase the wind speed to maximum over a period of 5 minutes
    for i = 1, 5 do
        Citizen.Wait(60000) -- Wait for 1 minute
        SetWind(i * 0.2)
        SetWindSpeed(i * 2.4)
    end

    -- Randomize the wind direction
    SetWindDirection(math.random() * 360.0)

    -- Start a particle effect at the player's location
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    -- First particle effect
    local particleDict1 = "core"
    local particleName1 = "wind_debris_paper"

    RequestNamedPtfxAsset(particleDict1)
    while not HasNamedPtfxAssetLoaded(particleDict1) do
        Citizen.Wait(1)
    end

    UseParticleFxAssetNextCall(particleDict1)
    local particleEffect1 = StartParticleFxLoopedAtCoord(particleName1, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    -- Second particle effect
    local particleDict2 = "core"
    local particleName2 = "wind_debris_leaves"

    RequestNamedPtfxAsset(particleDict2)
    while not HasNamedPtfxAssetLoaded(particleDict2) do
        Citizen.Wait(1)
    end

    UseParticleFxAssetNextCall(particleDict2)
    local particleEffect2 = StartParticleFxLoopedAtCoord(particleName2, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)

    -- Store the particle effects in a table so we can stop them later
    local particleEffects = {particleEffect1, particleEffect2}

    -- Turn off the power
    SetBlackout(true)

    return particleEffects
end

-- Define a function to stop the hurricane
function stopHurricane(particleEffects)
    -- Stop the particle effects
    for i, effect in ipairs(particleEffects) do
        StopParticleFxLooped(effect, 0)
    end

    -- Turn the power back on
    SetBlackout(false)

    -- Reset the weather to extra sunny
    TriggerEvent('qb-weathersync:server:setWeather', 'EXTRASUNNY')

    -- Reset the wind speed to normal
    SetWind(0.0)
    SetWindSpeed(0.0)
end

-- Event handlers
RegisterNetEvent('startHurricane')
AddEventHandler('startHurricane', function()
    local particleEffects = startHurricane()
    -- Store the particleEffects somewhere if you need to stop the hurricane later
end)

RegisterNetEvent('stopHurricane')
AddEventHandler('stopHurricane', function()
    -- Retrieve the particleEffects from where you stored them
    stopHurricane(particleEffects)
end)

RegisterCommand('startHurricane', function()
    -- Send a request to the server to start the hurricane
    TriggerServerEvent('startHurricane')
end, false)