--
-- ──────────────────────────────────────────────────────────────────────────────────────────────── I ──────────
--      :::::: mFramework   S E R V E R R A N K S   C L A S S : :  :   :    :     :        :          :
-- ──────────────────────────────────────────────────────────────────────────────────────────────────────────
--
---@class ServerRank
---@field OwnerId userdata
---@field Owner table
---@field ItemCount number
---@field Items table
local Object = require('Object')

---* Describes a Server Rank
---@type ServerRank
local ServerRank = Object:extend()

---? internal function used to validate the options table passed to ServerRank()
local function validateOptions(options)
    local opts = {}
    if options then
        if (options['BUILT_IN'] == true) then
            opts.BUILT_IN = true

        elseif (options['IS_ADMIN'] == true) then
            opts.IS_ADMIN = true
        end
    end
    return opts
end

function ServerRank:new(definition)
    if not definition then return nil end
    if (not definition.ID) or (type(definition.ID) ~= 'number') then
        return nil, 'Invalid Rank ID (must be a number)'
    elseif (not definition.Name) or (type(definition.Name) ~= 'string') then
        return nil, 'Invalid Rank Name (must be a string)'
    elseif (not definition.Description) or (type(definition.Description) ~= 'string') then
        return nil, 'Invalid Rank Description (must be a string)'
    end
    --- ServerRank ID
    ---@type number
    self.ID = definition.ID
    --- ServerRank Properties
    ---@type table
    self.Properties = {
        --- Contains Rank Options
        ---@type table
        [0] = validateOptions(definition[1]),
        --- Rank Name
        ---@type string
        Name = definition.Name,
        --- Rank Description
        ---@type string
        Description = definition.Description,
    }
    -- Bind Getters
    --- Returns this Ranks Options
    ---@type function
    ---@return table Options
    self.Options = bind_getter(self.Properties, 0)
    --- Returns this Ranks Name
    ---@type function
    ---@return string Name
    self.GetName = bind_getter(self.Properties, 'Name')
    --- Returns this Ranks Description
    ---@type function
    ---@return string Description
    self.GetDesc = bind_getter(self.Properties, 'Description')

    -- Bind Setters
    --- Sets this Ranks Name
    ---@type function
    ---@param name string
    self.SetName = bind_setter(self.Properties, 'Name')
    --- Sets this Ranks Description
    ---@type function
    self.SetDesc = bind_setter(self.Properties, 'Description')
end

mFramework.classes.ServerRank = ServerRank
