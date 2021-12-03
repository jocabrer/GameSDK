

local newItem = {
  class = "guide_concrete", 
  percent = 25, 
}

local categoryToAdjust = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomCraftingGuide")
local categoryItemToAdjust1 = FindInTable(categoryToAdjust.classes, "class", "guide_medical_bandages") 

table.insert(categoryToAdjust.classes, newItem)

categoryItemToAdjust1.percent = categoryItemToAdjust1.percent - newItem.percent







