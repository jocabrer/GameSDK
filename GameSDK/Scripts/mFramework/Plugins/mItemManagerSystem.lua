local function GetEntityHealth(ent)
    local health
    if ent.item then
        health = ent.item:GetHealth()
    elseif ent.player then
        health = ent.player:GetHealth()
    else
        if ent.GetHealth then
            health = ent:GetHealth()
        elseif ent.health then
            health = ent.health
        end
    end
    return health or 0
end
local Object = require('Object')
local ItemManager = Object:extend()

function ItemManager:SyncItemsInRange()
    self.ItemsInRange = {}
    local ItemsInRange
    if not self.ByClass then
        ItemsInRange = System.GetEntitiesInSphere(self.WorldPos, self.validRange)
    else
        ItemsInRange = System.GetEntitiesInSphereByClass(self.WorldPos, self.validRange, self.ByClass)
    end

    for idx, item in ipairs(ItemsInRange) do
        thisItem = {
            name = (item:GetName() or 'Unknown'),
            health = GetEntityHealth(item),
            class = (item.class or 'Unknown'),
            itemid = (item.id),
            distance = (DistanceSqVectors(item:GetPos(), self.WorldPos)),
        } -- TODO: Add more Item Info
        InsertIntoTable(self.ItemsInRange, thisItem)
    end
end

function ItemManager:Items(QueryType, Query)
    local items = {}
    if QueryType and Query then
        for idx, item in ipairs(self.ItemsInRange) do if FindInTable(item, QueryType, Query) then InsertIntoTable(items, item) end end
    else
        items = self.ItemsInRange
    end
    return items, (#items or 0)
end

function ItemManager:new(WorldPos, Range, ByClass)
    if not WorldPos then
        return
    elseif (Range) and (type(Range) ~= 'number') then
        return
    elseif (ByClass) and (type(ByClass) == 'string') then
        self.ByClass = ByClass
    end

    self.validRange = Range
    self.WorldPos = WorldPos
    self:SyncItemsInRange()
end

_G['mF_ItemManager'] = ItemManager

function mF_FindItemsAtPos(WorldPos, MaxRange, ByClass)
    local mItemManager = mF_ItemManager(WorldPos, MaxRange, ByClass)
    if mItemManager then return mItemManager end
end

function mF_FindItemsNearPlayer(Player, MaxRange, ByClass)
    local WorldPos = Player:GetPos()
    local mItemManager = mF_ItemManager(WorldPos, MaxRange, ByClass)
    if mItemManager then return mItemManager end
end
