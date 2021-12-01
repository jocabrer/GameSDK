g_mEventHandlers['Client_DidActionsChange'] = function(source_id, event)
    local player = System.GetEntity(source_id)
    Log('@DidActionsChange Detected for Client: ' .. player.player:GetSteam64Id())
    dump(event, nil, 1)
end
