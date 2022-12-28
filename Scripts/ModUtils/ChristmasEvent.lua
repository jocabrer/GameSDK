function FindInTable(tbl, keyname, keyvalue)
	for i,v in ipairs(tbl) do
		if (v[keyname] == keyvalue) then
			return v
		end
	end
end


			Log('>> SeasonalEvents : Loading Christmas Event...')

-- SPAWNERS ---------------------------------------------------------------------------

            -- resources
            local SweaterGreen3 =   { class = "SweaterChristmasGreen"    , contents="RandomTorsoContents", percent = 2 }
            local SweaterGreen23 =  { class = "SweaterChristmasGreen2"   , contents="RandomTorsoContents", percent = 2 }
            local SweaterRed3 =     { class = "SweaterChristmasRed"      , contents="RandomTorsoContents", percent = 2 }
            local SweaterRed23 =    { class = "SweaterChristmasRed2"     , contents="RandomTorsoContents", percent = 2 }
            local Hat2 =            { class = "ChristmasHat"             , percent = 5   }
            local CommonPresent1 =  { class = "ChristmasPresentCommon1"  , percent = 5    }
            local CommonPresent2 =  { class = "ChristmasPresentCommon2"  , percent = 5    }
            local RarePresent =     { class = "ChristmasPresentRare"     , percent = 5   }
            local RarePresent30 =   { class = "ChristmasPresentRare"     , percent = 5   }
            local RndPresent3 =     { category = "RandomChristmasPresent", percent = 5    }
            local RndPresent2 =     { category = "RandomChristmasPresent", percent = 5    }
            local RndPresent1 =     { category = "RandomChristmasPresent", percent = 5   }
            local arbol =           { class = "christmas_tree"           , percent = 7.142}


            -- 0 Part Spart para agregar arbol
            Log('>> SeasonalEvents : Part Spart para agregar arbol...')
            local metalcat =  FindInTable(PartSpawnerManager.categories, "category", "metal_part")
            table.insert(metalcat.classes, arbol)
            
            local classtoilet = FindInTable(metalcat.classes, "class", "toilet_tow_packed")
            classtoilet.percent = classtoilet.percent - 7.142
            
            dump(PartSpawnerManager)

            Log('>> SeasonalEvents : ItemSpawnerManager')
			-- 1 / RandomBruteLoot 		
			local category1 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomBruteLoot")
			table.insert(category1.group, RarePresent30)

			-- 2 / RandomHumanSpiderLoot 		
			local category2 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomHumanSpiderLoot")
			table.insert(category2.group, RarePresent30)

			-- 3 / RandomBackpackContents 		
			local category3 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomBackpackContents")
			table.insert(category3.classes, RndPresent3)

            Log('>> SeasonalEvents : ItemSpawnerManager2')
			-- 4 / RandomSweater 		
			local category4 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomSweater")
			table.insert(category4.classes, SweaterGreen3)
			table.insert(category4.classes, SweaterGreen23)
			table.insert(category4.classes, SweaterRed3)
			table.insert(category4.classes, SweaterRed23)
			local categoryItem41 = FindInTable(category4.classes, "class", "SweaterBlack")
			local categoryItem42 = FindInTable(category4.classes, "class", "SweaterBlue")
			local categoryItem43 = FindInTable(category4.classes, "class", "SweaterGreen")
			local categoryItem44 = FindInTable(category4.classes, "class", "SweaterOrange")
			local categoryItem45 = FindInTable(category4.classes, "class", "SweaterPink")
			local categoryItem46 = FindInTable(category4.classes, "class", "SweaterRed")
			categoryItem41.percent = categoryItem41.percent - 2
			categoryItem42.percent = categoryItem42.percent - 2
			categoryItem43.percent = categoryItem43.percent - 2
			categoryItem44.percent = categoryItem44.percent - 2
			categoryItem45.percent = categoryItem45.percent - 2
			categoryItem46.percent = categoryItem46.percent - 2

            Log('>> SeasonalEvents : ItemSpawnerManager3')
			-- 5 / RandomHat 		
			local category5 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomHat")
			table.insert(category5.classes, Hat2)
			local categoryItem51 = FindInTable(category5.classes, "class", "DorfmanPacific")
			categoryItem51.percent = categoryItem51.percent - Hat2.percent

			-- 6 / RandomClothes
			local category6 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomClothes")
			table.insert(category6.classes, RndPresent2)

			-- 7 / RandomFood 		
			local category7 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomFood")
			table.insert(category7.classes, RndPresent1)

			-- 8 / RandomCrafting 		
			local category8 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomCrafting")
			table.insert(category8.classes, RndPresent2)

            Log('>> SeasonalEvents : ItemSpawnerManager4')
			-- 9 / RandomGnome 		
			local category9 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomGnome")
			table.insert(category9.classes, RndPresent2)

			-- 10 / RandomMilitaryFootlockerContent 		
			local category10 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryFootlockerContent")
			table.insert(category10.classes, RndPresent2)

			-- 11 / RandomMilitaryFootlockerIronSonsContent 		
			local category11 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryFootlockerIronSonsContent")
			table.insert(category11.classes, RndPresent3)


            local category12 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomLivingAreaContent")
			table.insert(category12.classes, CommonPresent1)

            local category13 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomPoliceSedanSlot")
			table.insert(category13.classes, CommonPresent2)

            
            Log('>> SeasonalEvents : ItemSpawnerManager5')