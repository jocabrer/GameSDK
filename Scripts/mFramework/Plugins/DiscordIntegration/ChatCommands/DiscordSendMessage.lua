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

        cmd_arg = cmdSplit(command, ' ')
        if not (#cmd_arg >= 3) then
            g_gameRules.game:SendTextMessage(4, playerId, 'Message to short')
            return
        elseif not (#cmd_arg >= 1) then
            g_gameRules.game:SendTextMessage(4, playerId, 'No channel specified: !discord [channelname] [message]')
            return
        end
        local message = command:gsub("^"..cmd_arg[1], '')
        local Channel = DiscordChannels[cmd_arg[1]]
        if not Channel then
            g_gameRules.game:SendTextMessage(4, playerId, 'The Specified Channel Does not exist')
            return
        end
        Channel:SendMessage(
            'game-msg-' .. playerName .. '[' .. steamId .. ']', message,
            function() g_gameRules.game:SendTextMessage(4, playerId, 'Message Sent') end
        )
    else
        g_gameRules.game:SendTextMessage(4, playerId, 'No Channels')
    end
end
