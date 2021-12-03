Log('APOCCompassMod >> Registering events');
g_mEventHandlers['APOCCompassInit'] = function(playerId, event, source_id, target_id)
    local player = System.GetEntity(g_localActorId);

    System.AddCCommand('APOCCompass', 'APOCToggleCompass(%1)', '');
    System.AddKeyBind('delete', 'APOCCompass delete');
    
    player.APOCIsDead = false;
    player.APOCCompassToggle = true;

    UIAction.ShowElement('mod_APOCCompassUI', 0);

    APOCCompassStartPlayerGeneralUpdate();
end

g_mEventHandlers['APOCCompassToggleUI'] = function(playerId, event, source_id, target_id)
    local player = System.GetEntity(g_localActorId);

    player.APOCIsDead = event.isDead;
    APOCCompassUIFunctions:ToggleTheCompass(event.toggle);
end

