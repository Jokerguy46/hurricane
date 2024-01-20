-- Server-side script

-- List of admin identifiers
local admins = {
    'license:110000112345678',  -- Your identifier in the correct format
    'license:110000123456789',  -- Another admin's identifier
    -- Add more admin identifiers here
}
-- Check if a player is an admin
function IsPlayerAdmin(source)
    -- Get the player's identifiers
    local identifiers = GetPlayerIdentifiers(source)

    -- Check if the first identifier is in the list of admins
    for i, admin in ipairs(admins) do
        if admin == identifiers[1] then
            return true
        end
    end

    -- If the identifier was not found in the list of admins, return false
    return false
end
-- Existing code...

RegisterCommand('stopHurricane', function(source, args, rawCommand)
    -- Check if the player is an admin
    if IsPlayerAdmin(source) then
        -- Trigger the stopHurricane event on all clients
        -- ...
    end
end, false)

RegisterCommand('getIdentifier', function(source, args, rawCommand)
    -- Get the player's identifier
    local identifier = GetPlayerIdentifiers(source)[1]

    -- Send a message to the player with their identifier
    TriggerClientEvent('chat:addMessage', source, { args = { 'SYSTEM', 'Your identifier is: ' .. identifier } })
end, false)

-- Add the startHurricane command and event handler here

RegisterCommand('startHurricane', function(source, args, rawCommand)
    -- Check if the player is an admin
    if IsPlayerAdmin(source) then
        -- Trigger the startHurricane event on all clients
        -- Replace this with your actual code to start the hurricane
        TriggerClientEvent('startHurricane', -1)
    else
        -- Send a message to the player saying they're not an admin
        TriggerClientEvent('chat:addMessage', source, { args = { 'SYSTEM', 'You are not an admin.' } })
    end
end, false)

RegisterCommand('listIdentifiers', function(source, args, rawCommand)
    -- Check if the player is an admin
    if IsPlayerAdmin(source) then
        -- Get a list of all currently connected players
        local players = GetPlayers()

        -- Loop through the list of players
        for i, player in ipairs(players) do
            -- Get the player's identifier
            local identifier = GetPlayerIdentifiers(player)[1]

            -- Print the player's identifier to the console
            print('Player ' .. player .. ' identifier: ' .. identifier)
        end
    else
        -- Send a message to the player saying they're not an admin
        TriggerClientEvent('chat:addMessage', source, { args = { 'SYSTEM', 'You are not an admin.' } })
    end
end, false)