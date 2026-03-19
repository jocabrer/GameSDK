g_mEventHandlers["@DynamicActions"] = function(playerId, event, source_id, target_id)
    if (not type(event) == "table") then
        Log("SKIPPED - Invalid event Data")
        return
    end
    Log("DynamicActions Update Detected")
    if (not type(event.method) == "string") then
        Log("SKIPPED - Invalid Update Method")
        return
    else
        local ClassToUpdate = _G[event.class]
        if ClassToUpdate and (ClassToUpdate.CustomActions) then
            Log("Updating CustomActions for Class: %s", event.class)
            if event.disableVanilla == true then
                Log("Vanilla Actions are being Hidden for this Item")
                ClassToUpdate.disableVanillaActions = true
            elseif event.disableVanilla == false then
                Log("Vanilla Actions are being Shown for this Item")
                ClassToUpdate.disableVanillaActions = false
            end
            if event.method == "SetActions" then
                for idx, action in ipairs(event.actions) do
                    Log("Setting Action: %s for Class %s", action.name, event.class)
                    local _stub = function()
                        --[[handled serverside]]
                    end
                    RegisterCustomActionForItem(event.class, action.name, _stub)
                    if not (_G[event.class].Server.OnClActionPerformed) then
                        RegisterServerListenerForItem(event.class)
                    end
                end
            elseif event.method == "RemoveActions" then
                for idx, action in pairs(event.actions) do
                    Log("Removing Action: %s for Class %s", action.name, event.class)
                    ClassToUpdate.CustomActions[tostring(action.name)] = nil
                end
            end
        else
            Log("ERROR - Item Class not Found")
        end
    end
end

g_mEventHandlers["@TableSync"] = function(playerId, event, source_id, target_id)
    if (not type(event) == "table") then
        Log("SKIPPED - Invalid event Data")
        return
    end
    local SynchedTable = {}
    local RemoteTable = event.payload
    local targetEntity = target_id
    local targetClass = event.class
    local TableTarget = nil
    Log("Recieved TableSync Event > Processing...")
    if not targetClass and (type(targetEntity) == "userdata") then
        Log("   > Target Appears to Be a specified Entity")
        TableTarget = System.GetEntity(targetEntity)
    elseif type(targetClass) == "string" and (targetClass ~= "") then
        Log("   > Target Appears to Be a Class or Table")
        TableTarget = _G[targetClass]
    end

    if TableTarget and type(TableTarget) == "table" then
        local tableClass = (TableTarget.class or targetClass)
        Log("   > Found Target: %s", (tableClass))
        _G[tableClass] = mergef(TableTarget, RemoteTable, true)
    end
end

--
-- ─── METHODS ────────────────────────────────────────────────────────────────────
--

--- * Send a DynamicActions update to Specified Client
---@param player table Entity for the Client you wish to Update actions for
---@param className string itemClass you wish to Update action for
---@param updateType string either SetActions|RemoveActions`
---@param actions table either {"actionName" = function() --action code end} to add or {"ActionName"} to delete
---@param disableVanilla boolean set to true|false to toggle Vanilla Action Visability
function mUpdateDynamicActionsForClient(player, className, updateType, actions, disableVanilla)
    if not (_G[className].Server.OnClActionPerformed) then
        RegisterServerListenerForItem(className)
    end
    return mSendEvent(
        player.id,
        {
            Type = "@DynamicActions",
            Data = {class = className, method = updateType, disableVanilla = disableVanilla, actions = actions}
        }
    )
end

--- * Send a DynamicActions update to All Clients
---@param className string itemClass you wish to Update action for
---@param updateType string either SetActions|RemoveActions`
---@param actions table either {"actionName" = function() --action code end} to add or {"ActionName"} to delete
---@param disableVanilla boolean set to true|false to toggle Vanilla Action Visability
function mUpdateDynamicActionsAllClients(className, updateType, actions, disableVanilla)
    if not (_G[className].Server.OnClActionPerformed) then
        RegisterServerListenerForItem(className)
    end
    return mSendEvent(
        "allClients",
        {
            Type = "@DynamicActions",
            Data = {class = className, method = updateType, disableVanilla = disableVanilla, actions = actions}
        }
    )
end

--- * Sync a table to a specified class or entity on a remote client
---@param player table entity - player entity of client to sync
---@param target table|userdata classname|entityId of the class/entity to Sync
---@param tbl table table containing the keys/tables to replicate to the remote client
--- Note tbl does not support functions (though you can serialise it somehow and send it as string to loadsting on the client)
function mSyncRemoteEntitityTableForClient(player, target, tbl)
    if type(target) == "userdata" then
        return mSendEvent(
            player.id,
            {
                Type = "@TableSync",
                Data = {payload = tbl}
            },
            false,
            target
        )
    elseif type(target) == "string" and (target ~= "") then
        return mSendEvent(
            player.id,
            {
                Type = "@TableSync",
                Data = {class = target, payload = tbl}
            }
        )
    end
end

--- * Sync a table to a specified class or entity to ALL Connected clients
---@param target table|userdata classname|entityId of the class/entity to Sync
---@param tbl table table containing the keys/tables to replicate to the remote client
--- Note tbl does not support functions (though you can serialise it somehow and send it as string to loadsting on the client)
function mSyncRemoteEntitityTableAllClients(target, tbl)
    if type(target) == "userdata" then
        return mSendEvent(
            "allClients",
            {
                Type = "@TableSync",
                Data = {payload = tbl}
            },
            false,
            target
        )
    elseif type(target) == "string" and (target ~= "") then
        return mSendEvent(
            "allClients",
            {
                Type = "@TableSync",
                Data = {class = target, payload = tbl}
            }
        )
    end
end
