g_mEventHandlers['Client_OnNewUsable'] = function(source_id, event)
    local player = System.GetEntity(source_id)
    Log('@OnNewUsable Detected for Client: ' .. player.player:GetSteam64Id())
    dump(event, nil, 1)
end
