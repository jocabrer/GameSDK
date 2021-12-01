--
-- ────────────────────────────────────────────────────── I ──────────
--   :::::: S V A L T E K : :  :   :    :     :        :          :
-- ────────────────────────────────────────────────────────────────
-- mFramework
-- ────────────────────────────────────────────────────────────────────────────────

local JSON = require("JSON")

local CustomPlayer = {
    Methods = {
        Client = {
            ClEventReceive = function(self, source_Id, target_Id, event_string)
                if (not source_Id == NULL_ENTITY) then
                    if (not source_Id) or (not System.GetEntity(source_Id)) then
                        return nil, 'Invalid source_id'
                    end
                end
                if (not target_Id == NULL_ENTITY) then
                    if (not target_Id) or (not System.GetEntity(target_Id)) then
                        return nil, 'Invalid target_id'
                    end
                end
                local event = JSON.parse(event_string)
                if (not event) or (event.Type == '' or type(event.Type) ~= 'string') then
                    Log('$3 --> Failed, Invalid Event Type....')
                    dump(event, nil, 3)
                    return
                end
                if (not type(event.Data) == 'table') or (event.Data == {}) then
                    Log('$3 --> Failed, Invalid Event Data....')
                    Log('Event Type: ' .. event.Type)
                    dump((event.Data or event), nil, 3)
                    return
                end
                return self:mEventHandler(source_Id, target_Id, event)
            end,
            ClSetCVarString = function(self, VarToChange, ValueToChange)
                if (VarToChange ~= '' or nil) or (ValueToChange ~= '' or nil) then
                    System.SetCVar(VarToChange, ValueToChange)
                end
            end,
            ClSetCVarNumber = function(self, VarToChange, ValueToChange)
                if (VarToChange ~= '' or nil) or (ValueToChange ~= nil) then
                    System.SetCVar(VarToChange, ValueToChange)
                end
            end,
        },
        Server = {
            SvEventReceive = function(self, source_Id, target_Id, event_string)
                if (not source_Id == NULL_ENTITY) then
                    if (not source_Id) or (not System.GetEntity(source_Id)) then
                        return nil, 'Invalid source_id'
                    end
                end
                if (not target_Id == NULL_ENTITY) then
                    if (not target_Id) or (not System.GetEntity(target_Id)) then
                        return nil, 'Invalid target_id'
                    end
                end
                local event = JSON.parse(event_string)
                if (not event) or (event.Type == '' or type(event.Type) ~= 'string') then
                    Log('$3 --> Failed, Invalid Event Type....')
                    dump(event, nil, 3)
                    return
                end
                if (not type(event.Data) == 'table') or (event.Data == {}) then
                    Log('$3 --> Failed, Invalid Event Data....')
                    Log('Event Type: ' .. event.Type)
                    dump((event.Data or event), nil, 3)
                    return
                end
                return self:mEventHandler(source_Id, target_Id, event)
            end,
        },
        mEventHandler = function(self, source_Id, target_Id, event)
            -- Hand over to Registered Handler if it Exists
            if (g_mEventHandlers[event.Type]) then
                local Handler = g_mEventHandlers[event.Type]
                if (type(Handler) == 'function') then
                    Log('$4 --> Calling Registered Handler....')
                    return Handler(self.id, event.Data, source_Id, target_Id)
                end
            else
                Log('$3 --> Skipped, UnKnown Event....')
                return
            end
        end,
        --[[
            Function: player:SendEventToServer {Event}, sourceId, targetId
            Event: Table Defining the Event
            {
                Type = 'STRING', -- Event Type (Event Name, this should be the Same as Your Event Handler)
                Data = 'TABLE', -- Your Event Data this Table can be anything but can only contain STRING or NUMBER values
            }
            sourceId: The Event Source
            targetId: The Event Target
            ! IMPORTANT Source/Target EntityId Must allways Be relevant to Both the Server and Client Involved
        ]]
        SendEventToServer = function(self, event, source_Id, target_Id)
            if (not source_Id) or (source_Id == false) then source_Id = NULL_ENTITY end
            if (not target_Id) or (target_Id == false) then target_Id = NULL_ENTITY end

            local event_string = JSON.stringify(event)
            return self.server:SvEventReceive(source_Id, target_Id, event_string)
        end,
        --[[
            Function: player:SendEventToClient {Event}, sourceId, targetId
            Event: Table Defining the Event
            {
                Type = 'STRING', -- Event Type (Event Name, this should be the Same as Your Event Handler)
                Data = 'TABLE', -- Your Event Data this Table can be anything but can only contain STRING or NUMBER values
            }
            sourceId: The Event Source
            targetId: The Event Target
            ! IMPORTANT Source/Target EntityId Must allways Be relevant to Both the Server and Client Involved
        ]]
        SendEventToClient = function(self, event, source_Id, target_Id, broadcast)
            Log('mSendEvent ->')
            if (not source_Id) or (source_Id == false) then source_Id = NULL_ENTITY end
            if (not target_Id) or (target_Id == false) then target_Id = NULL_ENTITY end

            local event_string = JSON.stringify(event)
            if broadcast then
                return self.allClients:ClEventReceive(source_Id, target_Id, event_string)
            else
                return self.onClient:ClEventReceive(self.actor:GetChannel(), source_Id, target_Id, event_string)
            end
        end,
        mGetPlayerData = function(self, Key)
            local PlayerData = (mPlayerManager:GetPlayerPersistantStorage(self) or {})
            if (PlayerData[Key]) then
                return PlayerData[Key]
            else
                return nil
            end
        end,
        mSetPlayerData = function(self, Key, Value)
            local PlayerData = (mPlayerManager:GetPlayerPersistantStorage(self) or {})
            PlayerData[Key] = Value
            local _result = mPlayerManager:SetPlayerPersistantStorage(self, PlayerData)
            if (not _result[Key] == PlayerData[Key]) then
                return nil
            else
                return true
            end
        end,
        isPlayerOwner = function(self)
            local steamid = self.player:GetSteam64Id()
            local Owners = mPlayerManager:GetOwnersteamIds()
            if type(Owners) == 'table' then
                for _, Owner in ipairs(Owners) do if (Owner.id == steamid) then return true end end
                return false
            end
        end,
        mGetServerRank = function(self) return mPlayerManager:GetPlayerRank(self) end,
        mSetServerRank = function(self, RankID)
            if (not RankID) then
                return nil, 'mSetServerRank requires a valid RankID'
            else
                return mPlayerManager:SetPlayerRank(self, RankID)
            end
        end,
    },
    Expose = {
        ServerProperties = {},
        ClientMethods = {
            ClEventReceive = {RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID, STRING},
            ClSetCVarString = {RELIABLE_ORDERED, POST_ATTACH, STRING, STRING},
            ClSetCVarNumber = {RELIABLE_ORDERED, POST_ATTACH, STRING, INT16},
        },
        ServerMethods = {SvEventReceive = {RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID, STRING}},
    },
}

Log(' - Loading mFramework CustomPlayer')
local _status, _result = mReExpose('Player', CustomPlayer.Methods, CustomPlayer.Expose);
Log('>> Result: ' .. tostring(_status or 'Failed') .. ' ' .. tostring(_result or 'No Message'));

---* Send An event to Server or Client/allClients
---@param To string required  - EventReciever can be a specific playerId or the string `Server` or `allClients`
---@param Event table required  - EventTable
---@param source_Id userdata optional  - source entityId
---@param target_Id userdata optional  - target entityId
function mSendEvent(To, Event, source_Id, target_Id)
    -- validate
    -- TODO: Add Error Messages
    if (type(Event) ~= 'table') or Event == {} then return end
    local thisPlayer
    if To == ('Server' or 'server') then
        thisPlayer = System.GetEntity(g_localActorId)
        return thisPlayer:SendEventToServer(Event, (source_Id or false), (target_Id or false))
    elseif To == ('allClients' or 'allclients') then
        if CryAction.IsDedicatedServer() then
            local players = CryAction.GetPlayerList()
            thisPlayer = _G['player']
        else
            thisPlayer = System.GetEntity(g_localActorId)
        end
        return thisPlayer:SendEventToClient(Event, (source_Id or false), (target_Id or false), true)
    elseif type(To) == 'userdata' then
        thisPlayer = System.GetEntity(To)
        if thisPlayer.SendEventToClient then
            return thisPlayer:SendEventToClient(Event, (source_Id or false), (target_Id or false))
        end
    end
end

-- ────────────────────────────────────────────────────────────────────────────────
-- mFramework END
-- ────────────────────────────────────────────────────────────────────────────────
