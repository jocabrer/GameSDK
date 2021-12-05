Log('ELProject >> Registering events');

-- CLIENT EVENTS
g_mEventHandlers['ELPInitUI'] = function(playerId,source_id, target_id)
    local player = System.GetEntity(g_localActorId);

    UIAction.ShowElement('mod_ELAmmoCounterUI', 1);
    Script.SetTimerForFunction(3000, 'ELPPlayerGeneralUpdateAfterDelay', {});
end


-- SERVER EVENTS