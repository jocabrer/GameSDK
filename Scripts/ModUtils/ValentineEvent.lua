

RegisterCallback(_G, 
	'OnInitAllLoaded', 
	nil, 
	function()
		if CryAction.IsDedicatedServer() then
			Log('>> SeasonalEvents : Loading Valentine Event...')

-- SPAWNERS ---------------------------------------------------------------------------

			-- resources
			local ChocolateBox3 = { class = "ChocolateBox", percent = 3 }
			local Champagne3 = { class = "Champagne", percent = 3 }
			local HeartBalloon3 = { class = "heart_balloon", percent = 3 }
			local HeartBalloon2 = { class = "heart_balloon", percent = 2 }
			local CupidArrow3 = { class = "CupidArrowx8", percent = 3 }
			local CupidArrow2 = { class = "CupidArrowx8", percent = 2.5 }
			local FlowerVase3 = { class = "flower_vase", percent = 3 }
			local Candle3 = { class = "heart_candle", percent = 3 }


			-- 1 / RandomFood 		
			local category1 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomFood")
			table.insert(category1.classes, ChocolateBox3)
			table.insert(category1.classes, Champagne3)
			table.insert(category1.classes, HeartBalloon3)

			-- 2 / RandomCrafting 		
			local category2 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomCrafting")
			table.insert(category2.classes, HeartBalloon3)
			table.insert(category2.classes, FlowerVase3)
			table.insert(category2.classes, Candle3)
			table.insert(category2.classes, HeartBalloon2)
			local categoryItem21 = FindInTable(category2.classes, "class", "EmptyBottle")
			local categoryItem22 = FindInTable(category2.classes, "class", "PropaneHeaterTop")
			local categoryItem23 = FindInTable(category2.classes, "class", "Rope")
			categoryItem21.percent = categoryItem21.percent - 4
			categoryItem22.percent = categoryItem22.percent - 4
			categoryItem23.percent = categoryItem23.percent - 3

			-- 3 / RandomGnome 		
			local category3 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomGnome")
			table.insert(category3.classes, CupidArrow3)
			table.insert(category3.classes, FlowerVase3)
			table.insert(category3.classes, Candle3)
			table.insert(category3.classes, HeartBalloon3)
			local categoryItem31 = FindInTable(category2.classes, "class", "gnome_creep")
			local categoryItem32 = FindInTable(category2.classes, "class", "painting_landscape_01")
			local categoryItem33 = FindInTable(category2.classes, "class", "jerry")
			local categoryItem34 = FindInTable(category2.classes, "class", "painting_map")
			categoryItem31.percent = categoryItem31.percent - 4
			categoryItem32.percent = categoryItem32.percent - 2
			categoryItem33.percent = categoryItem33.percent - 4
			categoryItem34.percent = categoryItem34.percent - 2

			-- 4 / RandomAmmo 		
			local category4 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomAmmo")
			table.insert(category4.classes, CupidArrow2)


			-- 5 / RandomSinkContent 		
			local category5 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomSinkContent")
			table.insert(category5.classes, CupidArrow2)
			local categoryItem51 = FindInTable(category5.classes, "class", "RandomNormalRepairKit")
			categoryItem51.percent = categoryItem51.percent - CupidArrow2.percent

			-- 6 / RandomDeskContent
			local category6 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomDeskContent")
			table.insert(category6.classes, CupidArrow2)
			local categoryItem51 = FindInTable(category5.classes, "class", "RandomFireStarter")
			categoryItem51.percent = categoryItem51.percent - CupidArrow2.percent

			
-- WOLRD EVENT ---------------------------------------------------------------------------
			
			-- NO EVENT
			
		end
	end)