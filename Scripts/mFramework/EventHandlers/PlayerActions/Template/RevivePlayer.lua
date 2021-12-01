g_mEventHandlers['Client_RevivePlayer'] = function(source_id, event)
    local player = System.GetEntity(source_id)
    Log('--> ' .. player:GetName() .. ' - ' .. player.player:GetSteam64Id() .. ' Is Reviving')
    Log('')
end
