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

-- Teleport to safe zone 
ChatCommands['!zone'] = function(playerId, command)
    Log('>> !zone - %s', command);
    local player = System.GetEntity(playerId);

    local rnd = random(1, 10)

    if rnd <= 1 then
        player.player:TeleportTo('4937 4715 142.8');
    elseif rnd <= 2 then
        player.player:TeleportTo('4928 4721 142.8');
    elseif rnd <= 3 then
        player.player:TeleportTo('4950 4705 142.8');
    elseif rnd <= 4 then
        player.player:TeleportTo('4915 4663 142.8');
    elseif rnd <= 5 then
        player.player:TeleportTo('4910 4685 142.8');
    elseif rnd <= 6 then
        player.player:TeleportTo('4892 4683 141.8');
    elseif rnd <= 7 then
        player.player:TeleportTo('4907 4712 142.8');
    elseif rnd <= 8 then
        player.player:TeleportTo('4895 4737 142.8');
    elseif rnd <= 9 then
        player.player:TeleportTo('4912 4718 142.8');
    elseif rnd <= 10 then
        player.player:TeleportTo('4960 4727 142.8');
    end

    
end