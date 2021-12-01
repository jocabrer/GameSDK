g_mEventHandlers['Client_OnUsableMessage'] = function(source_id, event)
    local player = System.GetEntity(source_id)
    Log('@OnUsableMessage Detected for Client: ' .. player.player:GetSteam64Id())
    dump(event, nil, 1)
end
