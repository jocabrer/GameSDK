ChatCommands['!discord'] = function(playerId, command)
    local HelpChannel = nil
    if not mFramework.Discord then
        g_gameRules.game:SendTextMessage(4, playerId, 'DiscordClient not Enabled on This Server')
        return
    end

    local DiscordChannels = mFramework.Discord['Channels']
    if DiscordChannels then
        local player = System.GetEntity(playerId)
        local playerName = player:GetName()
        local steamId = player.player:GetSteam64Id()

        local message = command:gsub("^"..'', '')
        local Channel = DiscordChannels['Default']
        
        Channel:SendMessage(
            'game-msg-' .. playerName .. '[' .. steamId .. ']', message,
            function() g_gameRules.game:SendTextMessage(4, playerId, 'Message Sent / Mensaje enviado') end
        )
    else
        g_gameRules.game:SendTextMessage(4, playerId, 'No Channels')
    end
end
