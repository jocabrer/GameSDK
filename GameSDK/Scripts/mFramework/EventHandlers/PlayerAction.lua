if (not g_mPlayerActions) then g_mPlayerActions = {} end

--- global table holds all registered Event Handlers
g_mEventHandlers['PlayerAction'] = function(source_id, event)
    if (not source_id) or (not event) then
        Log('PlayerAction SKIPPED - Invalid event')
        return
    end
    if (not event.Target) or (not type(event.Data) == 'table') then
        Log('PlayerAction SKIPPED - Invalid event Data')
        return
    end
    if (not event.Data.Action) then
        Log('PlayerAction SKIPPED - No Action Provided')
        return
    end
    local player = System.GetEntity(source_id)
    local playerPos = player:GetWorldPos()
    Log(
        'Action:' .. tostring(event.Data.Action) .. ' Detected for Client: ' .. player.player:GetSteam64Id() .. ' @pos: x:' ..
            playerPos.x .. ' y:' .. playerPos.y .. ' z:' .. playerPos.z
    )
    if (tostring(event.Data.Action):find('@item_get @')) then
        if (type(g_mPlayerActions['@item_get'] == 'function')) then
            g_mPlayerActions['@item_get'](source_id, event.Target, event.Data)
            Log('')
            return true
        end
    elseif (tostring(event.Data.Action):find('@item_drop @')) then
        if (type(g_mPlayerActions['@item_drop'] == 'function')) then
            g_mPlayerActions['@item_drop'](source_id, event.Target, event.Data)
            Log('')
            return true
        end
    elseif (type(g_mPlayerActions[event.Data.Action]) == 'function') then
        g_mPlayerActions[event.Data.Action](source_id, event.Target, event.Data)
        Log('')
        return true
    end
end

Script.LoadScriptFolder('scripts/mFramework/EventHandlers/PlayerActions', true, true)
