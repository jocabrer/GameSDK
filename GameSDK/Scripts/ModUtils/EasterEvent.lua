

-- OnInitPreLoaded ---------------------------------------------------------------------------

-- CRAFTING RECIPES --------------------------------------------------------------------------

local EasterCraftingRecipes = [[
<recipes>
	<guide name="default" id="0">
		<cats>
			<cat name="Base Building">
				<subcats>
					<subcat name="Easter">
						<items>
							<item class="KatanaBlackWidow" time="10">
								<materials>
									<material class="EggBlue" count="10" />
								</materials>
							</item>
							<item class="BaseballBatHerMajesty" time="10">
								<materials>
									<material class="EggBlue" count="10" />
								</materials>
							</item>
							<item class="AxePatrick" time="10">
								<materials>
									<material class="EggBlue" count="10" />
								</materials>
							</item>
							<item class="T1Micro" time="10">
								<materials>
									<material class="EggBlue" count="10" />
								</materials>
							</item>
							<item class="ReflexSightBow" time="5">
								<materials>
									<material class="EggBlue" count="10" />
								</materials>
							</item>
							<item class="LaserSight" time="10">
								<materials>
									<material class="EggBlue" count="3" />
								</materials>
							</item>
							<item class="LaserSightGreen" time="10">
								<materials>
									<material class="EggBlue" count="3" />
								</materials>
							</item>
							<item class="LaserSightBlue" time="10">
								<materials>
									<material class="EggBlue" count="3" />
								</materials>
							</item>
							<item class="ColtPythonGrimeyRick" time="20">
								<materials>
									<material class="EggGreen" count="10" />
								</materials>
							</item>
							<item class="Mk18Reaver" time="20">
								<materials>
									<material class="EggGreen" count="13" />
								</materials>
							</item>
							<item class="AKMGold" time="20">
								<materials>
									<material class="EggGreen" count="15" />
								</materials>
							</item>
							<item class="ReddotSight" time="20">
								<materials>
									<material class="EggGreen" count="10" />
								</materials>
							</item>
							<item class="PistolSilencer" time="20">
								<materials>
									<material class="EggGreen" count="20" />
								</materials>
							</item>
							<item class="ReflexSight" time="10">
								<materials>
									<material class="EggGreen" count="10" />
								</materials>
							</item>
							<item class="FlashlightMounted" time="10">
								<materials>
									<material class="EggGreen" count="5" />
								</materials>
							</item>
							<item class="VSS" time="30">
								<materials>
									<material class="EggPink" count="20" />
								</materials>
							</item>
							<item class="M16Vietnam" time="30">
								<materials>
									<material class="EggPink" count="20" />
								</materials>
							</item>
							<item class="M4A1" time="30">
								<materials>
									<material class="EggPink" count="17" />
								</materials>
							</item>
							<item class="M4V5" time="30">
								<materials>
									<material class="EggPink" count="30" />
								</materials>
							</item>
							<item class="PSOScope" time="10">
								<materials>
									<material class="EggPink" count="5" />
								</materials>
							</item>
							<item class="OpticScope" time="10">
								<materials>
									<material class="EggPink" count="10" />
								</materials>
							</item>
							<item class="R3Sight" time="10">
								<materials>
									<material class="EggPink" count="5" />
								</materials>
							</item>
							<item class="ext_762x30" time="10">
								<materials>
									<material class="EggPink" count="20" />
								</materials>
							</item>
							<item class="ext_762x75" time="10">
								<materials>
									<material class="EggPink" count="25" />
								</materials>
							</item>
							<item class="ext_556x75" time="10">
								<materials>
									<material class="EggPink" count="25" />
								</materials>
							</item>
							<item class="RifleSilencer" time="10">
								<materials>
									<material class="EggPink" count="35" />
								</materials>
							</item>
						</items>
					</subcat>
				</subcats>
			</cat>
		</cats>
	</guide>
</recipes>
]]



local file = io.open('GameSDK/Scripts/Recipes/mods/AutoEasterEvent.xml', 'w');

if not file then
	os.execute('mkdir GameSDK\\Scripts\\Recipes\\mods')
end

file:write(EasterCraftingRecipes);
file:close();


-- OnInitAllLoaded	-----------------------------------------------------------------------

RegisterCallback(_G, 
	'OnInitAllLoaded', 
	nil, 
	function()
		if CryAction.IsDedicatedServer() then
			Log('>> SeasonalEvents : Loading Easter Event...')

-- SPAWNERS ---------------------------------------------------------------------------

			-- resources
			local RandomEggs10 = { category = "RandomEggs", percent = 10 }
			local RandomEggs25 = {category = "RandomEggs", percent = 25 }
			local RandomEggs3 = { category = "RandomEggs", percent = 3 }
			local RandomEggs2 = { category = "RandomEggs", percent = 2 }
			local RandomEggs05 = { category = "RandomEggs", percent = 0.5 }


			-- 1 / RandomMutantLoot 		
			local category1 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMutantLoot")
			table.insert(category1.group, RandomEggs10)

			-- 2 / RandomBruteLoot 		
			local category2 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomBruteLoot")
			table.insert(category2.group, RandomEggs25)

			-- 3 / RandomHumanSpiderLoot 		
			local category3 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomHumanSpiderLoot")
			table.insert(category3.group, RandomEggs25)

			-- 4 / RandomBackpackContents 		
			local category4 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomBackpackContents")
			table.insert(category4.classes, RandomEggs3)

			-- 5 / RandomClothes 		
			local category5 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomClothes")
			table.insert(category5.classes, RandomEggs2)

			-- 6 / RandomFood
			local category6 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomFood")
			table.insert(category6.classes, RandomEggs05)

			-- 7 / RandomCrafting 		
			local category7 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomCrafting")
			table.insert(category7.classes, RandomEggs2)

			-- 8 / RandomGnome 		
			local category8 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomGnome")
			table.insert(category8.classes, RandomEggs2)

			-- 9 / RandomMilitaryFootlockerContent 		
			local category9 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryFootlockerContent")
			table.insert(category9.classes, RandomEggs2)

			-- 11 / RandomMilitaryFootlockerIronSonsContent 		
			local category11 = FindInTable(ItemSpawnerManager.itemCategories, "category", "RandomMilitaryFootlockerIronSonsContent")
			table.insert(category11.classes, RandomEggs2)
			

-- WOLRD EVENT ---------------------------------------------------------------------------
			
			-- NONE
			
		end
	end)