ChatCommands["!say"] = function(playerId, command)
    Log(">> !say- %s", command)

    local player = System.GetEntity(playerId)
    local playerName = player:GetName()
    g_gameRules.game:SendTextMessage(4, 0, playerName.." "..command);

end

