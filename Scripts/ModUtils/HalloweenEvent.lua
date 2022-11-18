

RegisterCallback(_G, 
	'OnInitAllLoaded', 
	nil, 
	function()
		if CryAction.IsDedicatedServer() then
			Log('>> SeasonalEvents : Loading Halloween Event...')

-- SPAWNERS ---------------------------------------------------------------------------

			-- resources
			local HalloweenBagBrute30 = { class = "HalloweenBagBrute", percent = 30 }
			local HalloweenBagSpider30 = { class = "HalloweenBagSpider", percent = 30 }
			local halloweenBagCommon3 = { category = "halloweenBagCommon", percent = 3 }
			local halloweenBagCommon2 = { category = "halloweenBagCommon", percent = 2 }
			local halloweenBagCommon1 = { category = "halloweenBagCommon", percent = 1 }


			-- 1 / RandomBruteLoot 		
			local category1 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomBruteLoot")
			table.insert(category1.group, HalloweenBagBrute30)

			-- 2 / RandomHumanSpiderLoot 		
			local category2 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomHumanSpiderLoot")
			table.insert(category2.group, HalloweenBagSpider30)

			-- 3 / RandomBackpackContents 		
			local category3 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomBackpackContents")
			table.insert(category3.classes, halloweenBagCommon3)

			-- 4 / RandomClothes 		
			local category4 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomClothes")
			table.insert(category4.classes, halloweenBagCommon2)

			-- 5 / RandomFood 		
			local category5 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomFood")
			table.insert(category5.classes, halloweenBagCommon1)

			-- 6 / RandomCrafting
			local category6 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomCrafting")
			table.insert(category6.classes, halloweenBagCommon2)
			local categoryItem61 = FindInTable(category6.classes, "class", "Nails")
			categoryItem61.percent = categoryItem61.percent - halloweenBagCommon2.percent

			-- 7 / RandomCrafting 		
			local category7 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomCrafting")
			table.insert(category7.classes, halloweenBagCommon2)

			-- 8 / RandomGnome 		
			local category8 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomGnome")
			table.insert(category8.classes, halloweenBagCommon2)

			-- 9 / RandomMilitaryFootlockerContent 		
			local category9 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryFootlockerContent")
			table.insert(category9.classes, halloweenBagCommon2)

			-- 10 / RandomMilitaryFootlockerContent 		
			local category10 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryFootlockerContent")
			table.insert(category10.classes, halloweenBagCommon2)

			-- 11 / RandomMilitaryFootlockerIronSonsContent 		
			local category11 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryFootlockerIronSonsContent")
			table.insert(category11.classes, halloweenBagCommon3)
			
			-- control
			-- Log('>> SeasonalEvents : Halloween Event : spawners added...')
			-- dump(category1)

-- WOLRD EVENT ---------------------------------------------------------------------------
			
			
			
			-- control
			-- Log('>> SeasonalEvents : Halloween Event : UFO added...')
		end
	end)