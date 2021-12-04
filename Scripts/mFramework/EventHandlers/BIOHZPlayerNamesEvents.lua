Log('BIOHZPlayerNames >> Registering events');

-- CLIENT EVENTS
g_mEventHandlers['BIOHZPNInitUI'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    UIAction.ShowElement('mod_BIOHZPlayerNamesDummyUI', 200);
    Script.SetTimerForFunction(5000, 'BIOHZPNShowPlayerNamesAfterDelay', {});
end

g_mEventHandlers['BIOHZPNSetAdminState'] = function(playerId, data, source_id, target_id)
    player = System.GetEntity(source_id);

    if (player and player.player) then
        if (data.isAdmin == true) then
            player.BIOHZIsAdmin = data.isAdmin;
        else
            player.BIOHZIsAdmin = nil;
        end
    end
end

g_mEventHandlers['BIOHZLogoUpdatePlayerCount'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    player.BIOHZLogoPlayerCount = data.playerCount;
end

g_mEventHandlers['BIOHZMKInitUI'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    player.BIOHZMKMarkerList = BIOHZMKJSON.parse(data.markers);

    System.AddCCommand('BIOHZMenu', 'BIOHZMKManageMenu(%1)', '');
    System.AddKeyBind('tilde', 'BIOHZMenu tilde');

    for key, marker in pairs(player.BIOHZMKMarkerList) do
        if (marker[2] == 4) then
            player.BIOHZMKCorpseTimerId = Script.SetTimerForFunction(1200000, 'BIOHZMKRemoveCorpseMarker', player);
            break;
        end
    end

    UIAction.ShowElement('mod_BIOHZMarkersDummyUI', 200);
    Script.SetTimerForFunction(5000, 'BIOHZMKShowMarkersAfterDelay', {});
end

g_mEventHandlers['BIOHZMKAddMarker'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    local newMarker = BIOHZMKJSON.parse(data.marker);
    newMarker = {
        newMarker.name,
        1,
        newMarker.pos
    };

    table.insert(player.BIOHZMKMarkerList, newMarker);
end

g_mEventHandlers['BIOHZMKRemoveMarker'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    
    for key, marker in pairs(player.BIOHZMKMarkerList) do
        if (marker[1] == data.markerName and marker[2] == 1) then
            table.remove(player.BIOHZMKMarkerList, key);
            break;
        end
    end
end

g_mEventHandlers['BIOHZMKAddMarkerAll'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    local newMarker = BIOHZMKJSON.parse(data.marker);
    newMarker = {
        newMarker.name,
        2,
        newMarker.pos
    };

    table.insert(player.BIOHZMKMarkerList, newMarker);
end

g_mEventHandlers['BIOHZMKRemoveMarkerAll'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    
    for key, marker in pairs(player.BIOHZMKMarkerList) do
        if (marker[1] == data.markerName and marker[2] == 2) then
            table.remove(player.BIOHZMKMarkerList, key);
            break;
        end
    end
end

g_mEventHandlers['BIOHZMKUpdateBase'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    local addedMarker = false;
    
    local newMarker = BIOHZMKJSON.parse(data.marker);

    if (newMarker.x) then
        for key, marker in pairs(player.BIOHZMKMarkerList) do
            if (marker[2] == 3) then
                marker[3] = newMarker;
                addedMarker = true;
                break;
            end
        end

        if (addedMarker == false) then
            table.insert(player.BIOHZMKMarkerList, {
                'Base',
                3,
                newMarker
            });
        end
    else
        for key, marker in pairs(player.BIOHZMKMarkerList) do
            if (marker[2] == 3) then
                table.remove(player.BIOHZMKMarkerList, key);
                break;
            end
        end
    end
end

g_mEventHandlers['BIOHZMKKillCorpseTimer'] = function(playerId, data, source_id, target_id)
    local player = System.GetEntity(g_localActorId);
    
    if (player.BIOHZMKCorpseTimerId) then
        Script.KillTimer(player.BIOHZMKCorpseTimerId);
        player.BIOHZMKCorpseTimerId = nil;

        for key, marker in pairs(player.BIOHZMKMarkerList) do
            if (marker[2] == 4) then
                table.remove(player.BIOHZMKMarkerList, key);
                break;
            end
        end
    end
end

-- SERVER EVENTS
g_mEventHandlers['BIOHZPNGetAdminState'] = function(playerId, data, source_id, target_id)
    BIOHZPNGetAdminState(playerId, source_id);
end