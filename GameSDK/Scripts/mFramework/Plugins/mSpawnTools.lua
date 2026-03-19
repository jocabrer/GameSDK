local Object = require('Object')
local table_size = (require('mFramework.table_utils')).table_size

local SpawnTools = Object:extend()

function SpawnTools:SetCorrectStackSizes(SpawnedItems, AmountToSpawn)
    local lastStack = #SpawnedItems
    local CurrentStack = 1
    local AmountRemain = AmountToSpawn
    Log('   -> Spawning Items - Total %s in %s Stacks', tostring(AmountToSpawn), tostring(lastStack))
    for idx, item in ipairs(SpawnedItems) do
        if (item and item.item) then
            if CurrentStack ~= lastStack then
                item.item:SetStackCount(item.item:GetMaxStackSize())
                AmountRemain = (AmountRemain - item.item:GetStackCount())
            else
                item.item:SetStackCount(AmountRemain)
                AmountRemain = (AmountRemain - item.item:GetStackCount())
            end
            Log('Proccessed Stack: %s', tostring(CurrentStack))
            Log('Remaining: %s', tostring(AmountRemain))
            CurrentStack = CurrentStack + 1
        else
            Log('Invalid Item in SpawnedItems')
            return nil, 0, 'Invalid Item in SpawnedItems'
        end
    end
    return AmountRemain, 'Success Setting Item Stacks'
end

function SpawnTools:CalculateStacks(item, amount)
    local StacksRequired
    local MaxStackCount = item.item:GetMaxStackSize()
    if MaxStackCount >= amount then
        StacksRequired = 1
    else
        StacksRequired = math.ceil(amount / MaxStackCount)
    end
    return StacksRequired
end

function SpawnTools:SpawnAsStacks(playerId, itemClass, count, ...)
    local SpawnedItems = {}
    local MaxStackCount
    local AllSpawned
    local idx = 0
    local firstStack = true
    while not AllSpawned and idx <= count do
        idx = idx + 1
        local ItemSpawned = ISM.GiveItem(playerId, itemClass, ...)
        if ItemSpawned then
            if firstStack then
                Log('   -> FirstStack...')
                firstStack = false
                MaxStackCount = self:CalculateStacks(ItemSpawned, count)
                Log('   -> Calculated StackCount = %s', tostring(MaxStackCount))
            end
            InsertIntoTable(SpawnedItems, ItemSpawned)
            if idx >= MaxStackCount then
                Log('   -> AllSpawned')
                AllSpawned = true
            end
        else
            return nil, idx, 'Failed to Spawn Item'
        end
    end
    local Unstacked, StackError = self:SetCorrectStackSizes(SpawnedItems, count)
    if Unstacked ~= 0 then
        return nil, Unstacked, (StackError or 'Some Items couldnt Be Stacked')
    else
        return true, Unstacked, (StackError or 'Success Spawning Stacked Items')
    end
end

function SpawnTools:SetItemHealth(thisItem, Health)
    Log(' Checking if Item: ' .. thisItem.class .. ' is Destroyable')
    if type(thisItem.item.IsDestroyable) == 'function' then
        if thisItem.item:IsDestroyable() then
            local itemHealth = function(maxHP, percentHP)
                local n = maxHP * percentHP / 100
                return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
            end
            Log('Item: ' .. thisItem.class .. ' is Destroyable... Setting Max Health')
            thisItem.item:SetHealth(itemHealth(thisItem.item:GetMaxHealth(), Health))
        end
    else
        Log('Item: ' .. thisItem.class .. ' is NOT Destroyable')
    end
end

-- Known Stackables for Spawning Items
SpawnTools.KnownStackables = {['Bandage'] = {IsMagazine = nil, StackSize = 5}}

-- Check if an item is Stackable, fallback to KnownStackables when isStackable() unavailable
function SpawnTools:isStackable(thisItem)
    local itemStackable = nil
    local itemInfo = {Name = thisItem.class, IsMagazine = nil, StackSize = 1}
    if (type(thisItem.item.isStackable) == 'function') and thisItem.item:isStackable() then itemStackable = true end
    if (type(thisItem.item.IsMagazine) == 'function') and thisItem.item:IsMagazine() then
        itemStackable = true
        itemInfo.IsMagazine = true
    end
    if (type(thisItem.item.GetMaxStackSize) == 'function') and thisItem.item.GetMaxStackSize() ~= nil then
        itemInfo.StackSize = thisItem.item.GetMaxStackSize()
    end
    if self.KnownStackables[itemInfo.Name] ~= nil then
        itemStackable = true
        itemInfo.IsMagazine = self.KnownStackables[itemInfo.Name].IsMagazine
        itemInfo.StackSize = self.KnownStackables[itemInfo.Name].StackSize
    end
    Log(
        'Item: ' .. itemInfo.Name .. ' Stackable: ' .. (tostring(itemStackable)) .. ' MaxStack: ' .. itemInfo.StackSize ..
            ' Magazine: ' .. (tostring(itemInfo.IsMagazine))
    )
    return itemStackable, itemInfo
end

-- Known Slots for spawning SubItems
SpawnTools.SlotType = {
    ['10mmx15'] = 'mag_10mmx1500',
    ['10mmx30'] = '10mm_mag00',
    ['12Gaugex8_Beanbag_AA12'] = '12gauge_mag00',
    ['12Gaugex8_Pellet_AA12'] = '12gauge_mag00',
    ['12Gaugex8_Slug_AA12'] = '12gauge_mag00',
    ['357x14'] = '357_mag00',
    ['545x30'] = '545_mag00',
    ['57x50'] = '57_mag00',
    ['762x30'] = '762_mag00',
    ['9mmx10_makarov'] = '9mm_mak_mag00',
    ['9mmx15_m9a1'] = '9mm_m9a1_mag00',
    ['9mmx19_ap85'] = '9mm_ap85_mag00',
    ['acp_45_hk'] = 'acp_45_hk_mag00',
    ['acp_45x20'] = 'acp_45x20_mag00',
    ['acp_45x30'] = 'acp_45x30_mag00',
}

function SpawnTools:GiveItem(playerId, Item, stackSize, itemParent)
    if not stackSize then stackSize = 1 end
    Log(' Processing Item ' .. Item .. ' Requested Stack size: ' .. tostring(stackSize))
    local player = System.GetEntity(playerId)
    local thisItem = nil
    if itemParent and self.SlotType[Item] then
        Log(
            'Item:' .. Item .. ' Has Known slot: ' .. self.SlotType[Item] .. ' attempting to Place item in Parent: ' ..
                itemParent.class
        )
        thisItem = ISM.GiveItem(playerId, Item, false, itemParent.id, self.SlotType[Item])
    else
        thisItem = ISM.GiveItem(playerId, Item, false)
    end
    if thisItem then -- Item Given ok
        self:SetItemHealth(thisItem, 100)
        if stackSize >= 2 then
            Log('Give Stacked item Requested:' .. Item .. ' x' .. stackSize .. ' Checking Stackable item')
            -- Check if the item is Stackable
            local itemStackable, itemInfo = self:isStackable(thisItem)
            if itemStackable then
                if stackSize > (itemInfo.StackSize) then
                    Log(
                        'stackCount for item: ' .. Item .. ' to High.. Adjusting -> ' .. tostring(stackSize) .. ' > ' ..
                            tostring(itemInfo.StackSize)
                    )
                    stackSize = itemInfo.StackSize
                end
                if type(thisItem.item.SetStackCount) == 'function' then
                    Log('Setting StackSize for Item: ' .. itemInfo.Name .. ' > ' .. stackSize)
                    thisItem.item:SetStackCount(stackSize)
                else
                    Log(
                        'couldnt find method SetStackSize for Item: ' .. itemInfo.Name .. ' Spawning as single Stacks > ' ..
                            stackSize .. ' left'
                    )
                    local sCount = stackSize
                    while sCount > 1 do
                        local sItem = ISM.GiveItem(playerId, itemInfo.Name, false)
                        if not sItem then
                            Log(' Failed to give Item: ' .. itemInfo.Name)
                            return nil, ' Failed to give Item: ' .. itemInfo.Name
                        end
                        self:SetItemHealth(sItem, 100)
                        sCount = sCount - 1
                        Log('Gave Item: ' .. itemInfo.Name .. ' Remaining > ' .. tostring(sCount))
                    end
                end
            else
                Log('Item: ' .. Item .. ' is NOT Stackable')
            end
        end
        Log(
            ' ---> Gave Item: ' .. Item .. ' x' .. stackSize .. ' to Player: ' .. player:GetName() .. '[' ..
                player.player:GetSteam64Id() .. ']'
        )
        g_gameRules.game:SendTextMessage(4, playerId, ' Se te ha dado: ' .. Item .. ' x' .. tostring((stackSize)))
        return true, thisItem
    else
        -- Couldnt give item
        Log(
            'No se pudo entregar el artículo: ' .. Item .. ' x' .. stackSize .. ' to Player: ' .. player:GetName() .. '[' ..
                player.player:GetSteam64Id() .. ']'
        )
        return nil, 'Fallo al entregar el artículo'
    end
end

-- Gives a Player sets of items - @param items:string eg items="AK74U|5.45x39;DuffelBag|5.45x39|AmmoBox_5_45x39|GridMap|Bandage|DuctTape"
function SpawnTools:GiveItemSet(playerId, items)
    local itemList = {}
    -- seperate the items list at ";" seperator
    for item in (items .. ';'):gmatch('([^;]*);') do table.insert(itemList, item) end

    local itemSetList = {}
    -- Parse the itemlist into sets based on "," seperator
    for _, thisItem in pairs(itemList) do
        local ix = 0
        local itemKey = nil
        for subItem in (thisItem .. '|'):gmatch('([^|]*)|') do
            if ix ~= 1 then
                itemKey = subItem
                itemSetList[itemKey] = {}
                ix = 1
            else
                table.insert(itemSetList[itemKey], subItem)
            end
        end
    end
    -- Process ItemSets
    for Item, SubItems in pairs(itemSetList) do
        -- parse out the Item Name and Count from chuncks containing a *
        local itemCount = string.match(Item, '[*](%d+)')
        if itemCount ~= nil then
            itemCount = string.gsub(itemCount, '*', '')
            Item = string.gsub(Item, '*' .. itemCount, '')
        end
        -- Set iCount to itemCount to spawn
        local iCount = (tonumber(itemCount) or 1)
        Log(' Item: [' .. Item .. '] x' .. iCount)
        local itemGiven, itemParent = self:GiveItem(playerId, Item, iCount)
        if not itemGiven then
            Log('GiveItemSet Failed while Processing SubItems')
            return nil, 'failed while processing SubItems'
        end
        if not (table_size(SubItems) <= 0) then
            for _, thisItem in pairs(SubItems) do
                local subItemCount = string.match(thisItem, '[*](%d+)')
                if subItemCount ~= nil then
                    subItemCount = string.gsub(subItemCount, '*', '')
                    thisItem = string.gsub(thisItem, '*' .. subItemCount, '')
                end

                local siCount = (tonumber(subItemCount) or 1)
                Log('Sub Item -> [' .. thisItem .. '] x' .. siCount)
                local SubItemGiven, _ = self:GiveItem(playerId, thisItem, siCount, itemParent)
                if not SubItemGiven then
                    Log('GiveItemSet Failed while Processing SubItem: ' .. thisItem)
                    return nil, 'failed while processing SubItems'
                end
            end
        end
    end
end

function SpawnTools:GetSpawnPos(player, offset)
    local vForwardOffset = {x = 0, y = 0, z = 0}
    FastScaleVector(vForwardOffset, player:GetDirectionVector(), offset)
    local vSpawnPos = {x = 0, y = 0, z = 0}
    FastSumVectors(vSpawnPos, vForwardOffset, player:GetWorldPos())
    return vSpawnPos
end

_G['mSpawnTools'] = SpawnTools
