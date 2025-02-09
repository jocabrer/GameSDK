Log('ELProject >> Registering events');

-- CLIENT EVENTS
g_mEventHandlers['ELPInitUI'] = function(playerId, data,source_id, target_id)

    UIAction.ShowElement('mod_ELAmmoCounterUI', 1);
    Script.SetTimerForFunction(3000, 'ELPPlayerGeneralUpdateAfterDelay', {});
    
end

-- CLIENT EVENTS
g_mEventHandlers['PVEInitUI'] = function(playerId, data, source_id, target_id)
    
    local player = System.GetEntity(g_localActorId);
    
    UIAction.ShowElement('mod_ELMinimapUI', 1);

    local mapName = System.GetCVar('sv_map');
    local mapScale = 0;

    if (System.IsValidMapPos({x = 8692, y = 8692, z = 100}) == true) then
        mapScale = 8192;
    elseif (System.IsValidMapPos({x = 4596, y = 4596, z = 100}) == true) then
        mapScale = 4096;
    elseif (System.IsValidMapPos({x = 2548, y = 2548, z = 100}) == true) then
        mapScale = 2048;
    elseif (System.IsValidMapPos({x = 1524, y = 1524, z = 100}) == true) then
        mapScale = 1024;
    elseif (System.IsValidMapPos({x = 1012, y = 1012, z = 100}) == true) then
        mapScale = 512;
    elseif (System.IsValidMapPos({x = 756, y = 756, z = 100}) == true) then
        mapScale = 256;
    elseif (System.IsValidMapPos({x = 628, y = 628, z = 100}) == true) then
        mapScale = 128;
    end

    UIAction.CallFunction('mod_ELMinimapUI', 1, 'InitMinimap', mapScale, mapName);
    Script.SetTimerForFunction(5000, 'UpdateMiniMapCountersAfterDelay', {});
    
end

g_mEventHandlers['PVEUpdatePlayerCount'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    player.ELPPlayerCount = data.playerCount;
end

g_mEventHandlers['ELPUpdateKills'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    player.ELPKills = data.playerKills;
end

g_mEventHandlers['APOCCIInitUI'] = function(playerId, data, source_id, target_id)
    Log('initializing car info');
    Script.SetTimerForFunction(5000, 'APOCCIShowCarInfoAfterDelay', {});
end

-- SERVER EVENTS