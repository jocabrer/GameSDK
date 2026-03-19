--
-- ──────────────────────────────────────────────────────────────────────────────────────── I ──────────
--   :::::: mFramework   S T O R A G E   C L A S S : :  :   :    :     :        :          :
-- ──────────────────────────────────────────────────────────────────────────────────────────────────
--
---@class Storage
---@field OwnerId userdata
---@field Owner table
---@field ItemCount number
---@field Items table
local Object = require('Object')

--- Describes a Storage Object
local Storage = Object:extend()

function Storage:new(obj)
    if assert_arg(1, obj, 'table') or (type(obj.GetName) ~= 'function') then
        return nil, 'Must pass a Valid Entity'
    else
        local steamId
        if obj.player then steamId = obj.player:GetSteam64Id() end
        self.OwnerId = obj.id
        self.Owner = {name = (obj:GetName() or 'Unknown'), class = (obj.class or 'Unknown'), steamId = (steamId or 'Unknown')}
        self:RefreshStorageContents()
    end
end

function Storage:RefreshStorageContents()
    local storageContent = (g_gameRules.game:GetStorageContent(self.OwnerId, '') or {})
    self.Items = {}
    for idx, itemId in ipairs(storageContent) do self.Items[idx] = System.GetEntity(itemId) end
    self.ItemCount = (#self.Items or 0)
end

--- internal function used to validate storage contents
local function storageHasItem(storage, itemClass, amount)
    storage:RefreshStorageContents()
    local items = {}
    for idx, item in pairs(storage.Items) do if item.class == itemClass then items[idx] = item end end
    if not ((items == {}) or (table.getn(items) < 1)) then
        if amount then
            local itemTotal = 0
            for _, thisItem in ipairs(items) do itemTotal = itemTotal + (thisItem.item:GetStackCount() or 1) end
            if itemTotal >= amount then return true end
        else
            return true
        end
    end
    return false
end

---* Check if this Storage Contains the Specified Item optionaly checks the amount of all stacks combined
---@param itemClass string
---@param amount number
---@return boolean
function Storage:HasItem(itemClass, amount)
    if assert_arg(1, itemClass, 'string') then return false, 'invalid itemClass' end
    return storageHasItem(self, itemClass, amount)
end

---* Uses ISM to Give an item to This Storage
---@param itemClass string
---@param itemAccessory string
---@param accessorySlot string slot id for accessories
---@return boolean
function Storage:AddItem(itemClass, itemAccessory, accessorySlot)
    local itemId
    if itemClass then
        itemId = ISM.GiveItem(self.OwnerId, itemClass);
        if not itemId then return false, 'Failed to Give Item' end
    end
    local accessoryId
    if itemAccessory then
        accessoryId = ISM.GiveItem(self.OwnerId, itemAccessory, false, itemId, accessorySlot);
        if not accessoryId then return false, 'Failed to Give Item' end
    end
    return true
end

---* Uses ISM to Give an amount of a single item to This Storage
-- returns boolean and remainingCount+Message on error
---@param itemClass string
---@param itemCount number
---@return boolean,number,string
function Storage:AddItemStacked(itemClass, itemCount)
    if assert_arg(1, itemClass, 'string') then
        return false, 'invalid itemClass'
    elseif assert_arg(2, itemCount, 'number') then
        return false, 'invalid itemCount'
    end
    return mSpawnTools:SpawnAsStacks(self.OwnerId, itemClass, itemCount)
end

mFramework.classes.Storage = Storage
