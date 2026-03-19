mPlayerManager = {}

function mPlayerManager:InitPlayerManager()
    if (not mFramework.PersistantStorage) or (not type(mFramework.PersistantStorage.Collection) == 'function') then
        Log('$3 ERROR - mFramework PersistantStorage Unavailable')
        return nil, 'PlayerManager:InitPlayerData Failed'
    else
        -- Initialise PlayerData
        local _PlayerDataInit, _PlayerDataStatus = self:InitPlayerDataCollection()
        if (not _PlayerDataInit) then
            return nil, _PlayerDataStatus
        else
            return true, _PlayerDataStatus
        end
    end
end

function mPlayerManager:InitPlayerDataCollection()
    self.PersistantStorage = mFramework.PersistantStorage:Collection('PlayerData')
    if (not self.PersistantStorage) or (not self.PersistantStorage.GetPage) then
        Log('$3 ERROR - Couldnt Init PlayerData Collection')
        return nil, 'Init PlayerData Collection Failed'
    else
        Log('   - Init PlayerData Collection Success')
        return true, 'Init PlayerData Collection Ok'
    end
end

-- Fetch this Players PersistantStorage - Returns a table
function mPlayerManager:GetPlayerPersistantStorage(player)
    if (not player) or (not player.actor) then return nil, '(Param 1 [table]) player must be a valid player' end
    if (not self.PersistantStorage) then return nil, 'PlayerData Storage not Initialised' end
    local steamId = player.player:GetSteam64Id()
    return self.PersistantStorage:GetPage(steamId)
end

-- Saves a Table to this Players Persistant Storage (OverWrites Existing Data)
function mPlayerManager:SetPlayerPersistantStorage(player, data)
    if (not player) or (not player.actor) then return nil, '(Param 1 [table]) player must be a valid player' end
    if (not data) or (not type(data) == 'table') then return nil, '(Param 2 [table]) data must be a valid table and not empty' end
    if (not self.PersistantStorage) then return nil, 'PlayerData Storage not Initialised' end
    local steamId = player.player:GetSteam64Id()
    return self.PersistantStorage:SetPage(steamId, data)
end

-- Save All PersistantStorage
function mPlayerManager:Sync()
    Log('PlayerManager Syncing PersistantStorage')
    return mFramework.PersistantStorage:Save()
end

-- Read steamIds from OwnerIds file
function mPlayerManager:GetOwnersteamIds()
    local OwnerIds = {}
    if type(mFramework.Config['ServerOwners']) == 'table' then
        local ownerIds = mFramework.Config['ServerOwners']
        for _, OwnerSteamId in ipairs(ownerIds) do
            OwnerSteamId = OwnerSteamId:gsub('"', ''):gsub('""','')
            InsertIntoTable(OwnerIds, {id = OwnerSteamId})
        end
    end
    return OwnerIds
end

function mPlayerManager:AuthByRank(player, authorised)
    if (not type(authorised) == 'table') or (authorised == {}) then
        return nil, '[param 1] Invalid or Missing authorisation table'
    elseif (not player.actor and type(player) == 'userdata') then
        player = System.GetEntity(player)
    end
    if (not player) or (not player.actor) then
        return nil, '[param 2] Invalid Player (Entity or playerId)'
    else
        local playerRank = player:mGetServerRank()
        if (playerRank) and (playerRank.ID) then
            local authorisedRanks = table.concat(authorised, ', ')
            if (string.find(authorisedRanks, playerRank.ID)) or (string.find(authorisedRanks, playerRank:GetName())) then
                return true
            else
                return nil
            end
        else
            return nil
        end
    end
end

function mPlayerManager:GetPlayerRank(player)
    local PlayerRankID = player:mGetPlayerData('ServerRankID')
    if (PlayerRankID) then
        local PlayerRank = FindInTable(mFramework.ServerRanks.ServerRanks, 'ID', PlayerRankID)
        if (PlayerRank) and (PlayerRank.ID == PlayerRankID) then
            -- Player Has Valid Rank
            return PlayerRank, 'Player Rank Found'
        else
            -- Players RankID not Found in ServerRanks
            return nil, 'Player has invalid RankID'
        end
    else
        return nil, 'Player Has no Rank'
    end
end

function mPlayerManager:SetPlayerRank(player, RankID)
    local steamId = player.player:GetSteam64Id()
    local PlayerCurrentRankID = player:mGetPlayerData('ServerRankID')
    local PlayerNewRank = nil
    if (mF_DEBUG) then
        Log('PlayerManager:SetPlayerRank() ->')
        Log('   - Player: ' .. player:GetName() .. ' [' .. player.player:GetSteam64Id() .. ' ]')
        Log('   - Current Rank: ' .. tostring(PlayerCurrentRankID))
    end
    if (PlayerCurrentRankID == RankID) then
        if (mF_DEBUG) then
            Log(
                '   -- ERROR: Cannot Set PlayerRank to ' .. tostring(RankID) .. 'Player allready Rank:' ..
                    tostring(PlayerCurrentRankID)
            )
        end
        -- Player is Allrady this Rank
        return nil, steamId .. ' is Allready the Specified Rank'
    end
    if (mF_DEBUG) then Log('  - Validating Requested Rank') end
    PlayerNewRank = FindInTable(mFramework.ServerRanks.ServerRanks, 'ID', RankID)
    if (PlayerNewRank) and (PlayerNewRank.ID == RankID) then
        if (mF_DEBUG) then Log('  - Rank Found. Setting PlayerRank') end
        player:mSetPlayerData('ServerRankID', PlayerNewRank.ID)
        if (RankID == player:mGetPlayerData('ServerRankID')) then
            if (mF_DEBUG) then Log('  - SUCCESS!') end
            return true, steamId .. ' added to Rank: ' .. PlayerNewRank:GetName()
        else
            if (mF_DEBUG) then Log('  - FAILED , Unable to Update PlayerData') end
            return nil, ' Player not Added Failed to Update PlayerData'
        end
    else
        if (mF_DEBUG) then Log('  - ERROR Specified Rank does not Exist (or Failed to Access Persistant Storage)') end
        return nil, 'Specified Rank does not Exist'
    end
end

function mPlayerManager:GetOnlinePlayers()
    local PlayerList = {}
    for k, v in pairs(CryAction.GetPlayerList()) do
        PlayerList[k] = {
            ID = k,
            Name = v:GetName(),
            playerId = v.id,
            steamId = v.player:GetSteam64Id(),
            ServerRank = v:mGetServerRank(),
            IsOwner = v:isPlayerOwner(),
        }
    end
    return PlayerList
end
