Log('SCAAMAmalgamatedTerminal >> Registering events');

--------------------------------------------------------------------------
------------------------------ CLIENT EVENTS -----------------------------
--------------------------------------------------------------------------
g_mEventHandlers['SCAAMATInitPlayer'] = function(playerId, data, source_id, target_id)
    SCAAMATInitPlayer(data, source_id);
end

g_mEventHandlers['SCAAMATCloseUI'] = function(playerId, data, source_id, target_id)
    SCAAMATUIFunctions:ToggleTerminalUI('unload');
end

--------------------------------------------------------------------------
------------------------------ SERVER EVENTS -----------------------------
--------------------------------------------------------------------------
g_mEventHandlers['SCAAMATSendMessage'] = function(playerId, data, source_id, target_id)
    SCAAMATSendMessage(data, playerId);
end

g_mEventHandlers['SCAAMATSwitchAppSlots'] = function(playerId, data, source_id, target_id)
    SCAAMATSwitchAppSlots(data);
end

g_mEventHandlers['SCAAMATFreeTerminal'] = function(playerId, data, source_id, target_id)
    SCAAMATFreeTerminal(data);
end

g_mEventHandlers['SCAAMATGetMarketData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetMarketData(data, playerId);
end

g_mEventHandlers['SCAAMATGetMarketItemData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetMarketItemData(data, playerId);
end

g_mEventHandlers['SCAAMATAttemptTrade'] = function(playerId, data, source_id, target_id)
    SCAAMATAttemptTrade(data, playerId);
end

g_mEventHandlers['SCAAMATGetMyMarketData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetMyMarketData(playerId);
end

g_mEventHandlers['SCAAMATGetMyMarketItemData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetMyMarketItemData(data, playerId);
end

g_mEventHandlers['SCAAMATGetStorageItemData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetStorageItemData(data, playerId);
end

g_mEventHandlers['SCAAMATGetMyOffersData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetMyOffersData(playerId);
end

g_mEventHandlers['SCAAMATGetStorageData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetStorageData(playerId);
end

g_mEventHandlers['SCAAMATAttemptItemRemoval'] = function(playerId, data, source_id, target_id)
    SCAAMATAttemptItemRemoval(data, playerId);
end

g_mEventHandlers['SCAAMATAttemptStorageItemClaim'] = function(playerId, data, source_id, target_id)
    SCAAMATAttemptStorageItemClaim(data, playerId);
end

g_mEventHandlers['SCAAMATAttemptAddingItem'] = function(playerId, data, source_id, target_id)
    SCAAMATAttemptAddingItem(data, playerId, source_id);
end

g_mEventHandlers['SCAAMATGetMessagesData'] = function(playerId, data, source_id, target_id)
    SCAAMATGetMessagesData(playerId);
end

g_mEventHandlers['SCAAMATOpenMessage'] = function(playerId, data, source_id, target_id)
    SCAAMATOpenMessage(data, playerId);
end

g_mEventHandlers['SCAAMATRemoveMessage'] = function(playerId, data, source_id, target_id)
    SCAAMATRemoveMessage(data, playerId);
end

g_mEventHandlers['SCAAMATAttemptSendMessage'] = function(playerId, data, source_id, target_id)
    SCAAMATAttemptSendMessage(data, playerId);
end

g_mEventHandlers['SCAAMATGetFloppyDataForTerminal'] = function(playerId, data, source_id, target_id)
    SCAAMATGetFloppyDataForTerminal(playerId, source_id);
end

g_mEventHandlers['SCAAMATInstallApp'] = function(playerId, data, source_id, target_id)
    SCAAMATInstallApp(data, playerId, source_id);
end

g_mEventHandlers['SCAAMATAddStashCoordinate'] = function(playerId, data, source_id, target_id)
    SCAAMATAddStashCoordinate(data, source_id, playerId);
end