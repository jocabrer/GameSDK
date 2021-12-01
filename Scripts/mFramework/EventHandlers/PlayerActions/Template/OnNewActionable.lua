g_mEventHandlers['Client_OnNewActionable'] = function(source_id, event)
    local player = System.GetEntity(source_id)
    Log('@OnNewActionable Detected for Client: ' .. player.player:GetSteam64Id())
    System.ShowDebugger()
    dump(event, nil, 1)
end
