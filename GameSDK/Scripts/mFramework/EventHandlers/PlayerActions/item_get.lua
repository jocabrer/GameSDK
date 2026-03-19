g_mPlayerActions['@item_get'] = function(source_id, target_id, eventData)
    local player = System.GetEntity(source_id)
    local item = System.GetEntity(target_id)
    Log('   Player: ' .. mGetEntityInfo(source_id))
    Log('   Recived Item: ' .. mGetEntityInfo(target_id))
    Log('   EventData:')
    dump(eventData)
end
