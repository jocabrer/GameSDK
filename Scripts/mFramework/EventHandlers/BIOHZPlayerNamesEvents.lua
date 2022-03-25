Log('BIOHZPlayerNames >> Registering events');

-- CLIENT EVENTS
g_mEventHandlers['BIOHZPNInitUI'] = function()
    LogWarning('BIOHZPNInitUI: Entró .');
    local player = System.GetEntity(g_localActorId);
    UIAction.ShowElement('mod_BIOHZPlayerNamesDummyUI', 200);
    Script.SetTimerForFunction(5000, 'BIOHZPNShowPlayerNamesAfterDelay', {});
end

g_mEventHandlers['BIOHZPNSetAdminState'] = function(playerId, data, source_id, target_id)

    LogWarning('BIOHZPNSetAdminState: estamos acá. data.isAdmin ' .. data.isAdmin );

    player = System.GetEntity(playerId);

    if (player and player.player) then
        if (data.isAdmin == true) then
            player.BIOHZIsAdmin = data.isAdmin;
        else
            player.BIOHZIsAdmin = nil;
        end
    end
end


-- SERVER EVENTS
g_mEventHandlers['BIOHZPNGetAdminState'] = function(playerId, data, source_id, target_id)
    BIOHZPNGetAdminState(playerId, source_id);
end