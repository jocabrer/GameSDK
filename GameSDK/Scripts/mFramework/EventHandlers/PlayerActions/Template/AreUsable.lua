g_mEventHandlers['Client_AreUsable'] = function(source_id, event)
    local player = System.GetEntity(source_id)
    Log('@AreUsable Detected for Client: ' .. player.player:GetSteam64Id())
    dump(event, nil, 1)
end
