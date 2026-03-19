g_mEventHandlers['Client_DisplayActionableMenu'] = function(source_id, event)
    local player = System.GetEntity(source_id)
    Log('@DisplayActionableMenu Detected for Client: ' .. player.player:GetSteam64Id())
    local obj = System.GetEntity(event.Target)
    if obj then
        Log('Target:')
        dump(obj, nil, 1)
        local actions = nil
        if obj.GetActions then
            actions = obj:GetActions(player)
        else
            local state = obj:GetState()
            if state ~= '' then
                state = obj[state]
                if state.GetActions then
                    actions = state.GetActions(obj, player)
                end
            end
        end
        Log('Available Actions:')
        dump(actions, true, 1)
        Log('Current Index:' .. event.Data.Index)
    end
end
