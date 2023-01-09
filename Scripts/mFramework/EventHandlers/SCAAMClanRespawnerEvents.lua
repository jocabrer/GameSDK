Log('SCAAMClanRespawner >> Registering events');
g_mEventHandlers['SCAAMCRDisableSelected'] = function(playerId, event, source_id, target_id)
    UIAction.CallFunction('mod_SCAAMClanRespawnerUI', 0, 'DisableCurrentSelected');
end

g_mEventHandlers['SCAAMCRSetRespawn'] = function(playerId, event, source_id, target_id)
    SCAAMClanRespawnerSetRespawn(playerId, event.clanmateSteamId);
end