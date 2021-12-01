local function cmdSplit(pString, pPattern)
    local Table = {}
    local fpat = '(.-)' .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= '' then table.insert(Table, cap) end
        last_end = e + 1
        s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
        cap = pString:sub(last_end)
        table.insert(Table, cap)
    end
    return Table
end

---@class mChatCommand
---@field Name string
-- the ChatCommands name
---@field Usage string
-- Helptext to Show for this ChatCommand
---@field command table|function
-- a Function OR Table Containing functions to act as this Commands Actions
---@field Properties table
-- Properties assosiated with this ChatCommand
local mChatCommand = {Name = '', Usage = '', command = nil, Properties = {RespondPlayer = true, LogAuthSucces = false}}

function mChatCommand.getActionParams(command)
    if (command) then
        local args = cmdSplit(command, ' ')
        local action = tostring(args[1])
        local cleancommand = tostring(command):gsub(action, '')
        local cleanparams = cmdSplit(cleancommand, ' ')
        cleanparams[0] = command
        return action, cleanparams
    end
    return nil
end
---* Show this Commands Usage info (helptext)
---@param player userdata
-- players entityId as userdata
function mChatCommand:ShowUsage(player)
    if (self.Usage) then
        if (g_gameRules) then
            g_gameRules.game:SendTextMessage(4, player.id, 'Usage for Command: ' .. self.Name .. ' \n ' .. self.Usage)
        else
            -- DEBUG
            g_gameRules.game:SendTextMessage(4, player.id, 'No Registered Helptext for Command: ' .. self.Name)
        end
    end
end

function mChatCommand:AllowCommand(player)
    local isAuthorised = function(AllowedRanks)
        if (not player) or (not player.mGetServerRank) then
            --->[[ somthing broke our player class ]]
            return nil
        end
        local PlayerRank = player:mGetServerRank()
        if (not PlayerRank) or (not PlayerRank.ID) then
            --->[[ Player has No Rank (or its invalid) ]]
            return nil
        else
            local AuthorisedRanks = table.concat(AllowedRanks, ', ')
            --->[[ match for both RankID and RankName as some might use both ]]
            local rankName = PlayerRank:GetName() -- needed as GetName returns both the rankname and a message
            if (string.find(AuthorisedRanks, PlayerRank.ID)) or (string.find(AuthorisedRanks, rankName)) then
                --->[[ Auth Success ]]
                return true
            else
                --->[[ Auth Success ]]
                return nil
            end
        end
    end
    return isAuthorised(self.AuthorisedRanks)
end

---* Continue to Process this Command
-- passing an action is optional as we can just assign self.command as a function for command without params
---@param player userdata
-- the Players EntityId as userdata
---@param action string
-- optional, calls the chatcommands function with the same name as the action
---@param params table
-- optional parameters to send this command
---@return boolean,string
-- returns nil and a message if it fails
function mChatCommand:Continue(player, action, params)

    if (type(self.command) == 'table') then
        if action then
            -- >> if a table then we have a command with params
            if (type(self.command[action]) == 'function') then
                -- > Call this Action if it exists
                return self.command[action](self, player, params)
            else
                -- >> allow for fallback to a "default" action to be when no params are provided
                -- >> if no "fallback" exists then we show usage or do nothing
                if (type(self.command['default']) == 'function') then
                    return self.command['default'](self, player, params)
                else
                    return self:ShowUsage(player)
                end
            end
        end
    elseif (type(self.command) == 'function') then
        -- >>its a function so we probably have a command without params
        -- >> Call it
        return self.command(self, player, action)
    end
    return nil, 'self.command is invalid or conatins invalid actions'
end

---@return mChatCommand ChatCommand
local function CreateChatCommand()
    local self = {}
    for k, v in pairs(mChatCommand) do self[k] = v end
    return self
end

--
-- ───────────────────────────────────────────────────────────── EXPORT CLASS ─────
--

mFramework.ChatCommand = CreateChatCommand
