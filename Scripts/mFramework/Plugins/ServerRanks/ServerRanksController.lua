local ServerRank = mFramework.classes.ServerRank

local DefaultServerRanks = {
    [1] = {ID = 100, Name = 'Admin', Description = 'Server Admin', {BUILT_IN = true, IS_ADMIN = true}},
    [2] = {ID = 101, Name = 'Staff', Description = 'Server Staff', {BUILT_IN = true}},
    [3] = {ID = 102, Name = 'VIP', Description = 'VIP Player', {BUILT_IN = true}},
}

local mServerRanks = {}

function mServerRanks:InitServerRanksDefaults()
    local tmpServerRanks = self.ServerRanksData:GetPage('ServerRanks')
    if not (tmpServerRanks and tmpServerRanks[1]) or (not tmpServerRanks[1].ID) then
        self.ServerRanksData:SetPage('ServerRanks', DefaultServerRanks)
    else
        return true, 'Skipped'
    end

    local check = self.ServerRanksData:GetPage('ServerRanks')
    if (check and check[1]) and (check[1].ID == DefaultServerRanks[1].ID) then
        return true, 'Success Creating Default ServerRanks'
    else
        return nil, 'Failed Creating Default ServerRanks'
    end
end

function mServerRanks:LoadServerRankData()
    local allServerRanks = self.ServerRanksData:GetPage('ServerRanks')
    if (not allServerRanks) then
        self:InitServerRanksDefaults()
        allServerRanks = self.ServerRanksData:GetPage('ServerRanks')
    end
    if (allServerRanks) then
        self.ServerRanks = {}
        for k, v in ipairs(allServerRanks) do
            local tmpRank = ServerRank(v)
            if (not tmpRank) then
                return nil, 'failed to Initialise Default Rank: [' .. (v.ID or 'UnknownID') .. '] ' .. (v.Name or 'UnknownName')
            else
                local StoredRankProps = self.ServerRanksData:GetPage(v.ID)
                if StoredRankProps then tmpRank.Properties = StoredRankProps end
                table.insert(self.ServerRanks, tmpRank)
            end
        end
        return true, 'Load ServerRanks from PersistantStorage - OK'
    else
        return nil, 'failed to Load ServerRank Data'
    end
end

function mServerRanks:SaveServerRankData()
    for k, v in pairs(self.ServerRanks) do
        if (v.Properties) then
            Log('   - PlayerManager:    Saving ServerRank Data')
            Log('   - index [' .. k .. '] ID:' .. tostring(v.ID) .. ' Name: ' .. v.Properties.Name)
            self.ServerRanksData:SetPage(v.ID, v.Properties)
        end
    end
end

function mServerRanks:InitServerRanksCollection()
    self.ServerRanksData = mFramework.PersistantStorage:Collection('ServerRanks')
    if (not self.ServerRanksData) or (not self.ServerRanksData.GetPage) then
        Log('$3 ERROR - Couldnt Init ServerRanks Collection')
        return nil, 'Init ServerRanks Collection Failed'
    else
        local _status, _result = self:InitServerRanksDefaults()
        if (not _status) then
            Log('$3   - Failed to Initialise ServerRanks Defaults: ' .. tostring(_result or 'No Error'))
        else
            self['InitServerRanksDefaults'] = nil
            Log('$4   - Success Initialising ServerRanks Defaults')
        end
    end
    return self:LoadServerRankData()
end

local _allreadyInitialised = false
function mServerRanks:InitServerRanks()
    if not _allreadyInitialised then _allreadyInitialised = true else return end
    if (not mFramework.PersistantStorage) or (not type(mFramework.PersistantStorage.Collection) == 'function') then
        Log('$3 ERROR - mFramework PersistantStorage Unavailable')
        return nil, 'ServerRanks:Init Failed'
    else
        -- Initialise RankData
        local _RankDataInit, _RankDataStatus = self:InitServerRanksCollection()
        if (not _RankDataInit) then
            return nil, _RankDataStatus
        else
            self['InitServerRanksCollection'] = nil
            return true, _RankDataStatus
        end
    end
end

function mServerRanks:GetRank(findby, terms)
    local ServerRanks = self.ServerRanksData:GetPage('ServerRanks')
    if (not findby) or (not type(findby) == 'string') then
        return nil, 'param [1]string: is required ("id"|"name")'
    elseif (not terms) or (not type(terms) == 'string') then
        return nil, 'param [2]string:terms is required ("searchterms")'
    end
    local foundRank = FindInTable(ServerRanks, findby, terms)
    if (foundRank) then
        return ServerRank(foundRank), 'Success finding Rank -searchtype:' .. findby .. ' -terms:' .. terms
    else
        return nil, 'Failed finding Rank -searchtype:' .. findby .. ' -terms:' .. terms
    end
end

mFramework.ServerRanks = mServerRanks
