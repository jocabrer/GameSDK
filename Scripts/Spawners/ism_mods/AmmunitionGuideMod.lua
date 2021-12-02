local function RemoveItemFromTable(tbl, keyname, keyvalue)
    local item = {};
    for i, v in ipairs(tbl) do
        if (v[keyname] == keyvalue) then
            item = v;
            table.remove(tbl, i);
            break
        end
    end
    return item;
end

-- RandomCraftingGuide
local RandomCraftingGuide = RemoveItemFromTable(ItemSpawnerManager.itemCategories, "category", "RandomCraftingGuide");
table.insert(RandomCraftingGuide.classes, { class = "guide_ammunition", percent = 1 });

local GuideStructuresTireStacks = RemoveItemFromTable(RandomCraftingGuide.classes, "class", "guide_structures_tire_stacks");
GuideStructuresTireStacks.percent = GuideStructuresTireStacks.percent - 1;
table.insert(RandomCraftingGuide.classes, GuideStructuresTireStacks);

table.insert(ItemSpawnerManager.itemCategories, RandomCraftingGuide);