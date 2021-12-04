Log('BIOHZMKREvent >> Registering events');

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