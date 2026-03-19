local ServerRanks = mFramework.ServerRanks

local AuthManager = {}

function AuthManager:Authorise(player, allowedRanks)
    -- ? Sanity.
    if not (player or player.player) then return nil, 'Error: You must pass a player to authorise' end
    if (not allowedRanks) or (not type(allowedRanks) == 'table') then return nil, 'Error: You must pass a list of allowedRanks' end

    local authorised
    local playerRank = player:mGetServerRank()
    -- ? Actual authorisation checks
    for idx, rank in ipairs(allowedRanks) do
        -- ? Try to find this rank
        local thisRank = ServerRanks:GetRank('Name', rank)
        if thisRank then -- we have a valid rank
            -- ? Does this match our players rank (we'll check using the id)
            if (playerRank.ID == thisRank.ID) then authorised = true end
        end
    end
    -- ? Return authorisation status
    if (authorised == true) then
        return true, 'player authorised'
    else
        return false, 'player unauthorised'
    end
    return nil, 'error occured: function didnt complete'
end

--- Update a Players ServerRank
---@param player userdata
---@param Rank string|number
function AuthManager:UpdatePlayerRank(player, Rank)
    if not (player and player.player) then return nil, 'Error: You must pass a valid player' end

    local new_rank
    if type(Rank) == 'number' then
        new_rank = ServerRanks:GetRank('ID', tostring(Rank))
    elseif type(Rank) == 'string' then
        new_rank = ServerRanks:GetRank('Name', tostring(Rank))
    end

    --- rank found
    if (type(new_rank) == 'table') and (new_rank.ID) then
        local curr_rank = player:mGetServerRank()
        if (curr_rank.ID == new_rank.ID) then return end
        player:mSetServerRank(new_rank.ID)
    end
end

function AuthManager:RemovePlayerRank(player)
    if not (player and player.player) then return nil, 'Error: You must pass a valid player' end
    local curr_rank = player:mGetServerRank()
    if curr_rank then
        --- admin/unranked protection
        if curr_rank <= 100 then return false, 'you cannot remove this players rank. Change it First.' end
        player:mSetServerRank(0)
    end
end

mFramework.AuthManager = AuthManager
Script.LoadScriptFolder('scripts/mFramework/Plugins/AuthManager/ChatCommands')