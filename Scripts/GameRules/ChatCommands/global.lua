ChatCommands["!say"] = function(playerId, command)
    Log(">> !say- %s", command)

    local player = System.GetEntity(playerId)
    local playerName = player:GetName()
    g_gameRules.game:SendTextMessage(4, 0, playerName.." "..command);

end

-- Teleport to safe zone 4850 4787 
ChatCommands['!zona'] = function(playerId, command)
    Log('>> !zona - %s', command);
    local player = System.GetEntity(playerId);
    player.player:TeleportTo('4912 4718 142.8');
end

-- Teleport to safe zone 4850 4787 
ChatCommands['!zone'] = function(playerId, command)
    Log('>> !zone - %s', command);
    local player = System.GetEntity(playerId);
    player.player:TeleportTo('4912 4718 142.8');
end