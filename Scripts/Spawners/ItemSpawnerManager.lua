ItemSpawnerManager =
{

--[[

Each item category below can either have a "classes" or a "group" table in it.
If it contains a "group", then the spawner will process ALL of the items in the group and attempt to spawn all of them.
Using a group allows you to spawn a group of items at once (like a weapon and ammo for it).
If it contains a "classes" then it will radomly pick just ONE of them to attempt to spawn.

Example:

	category = "RandomAttachments",
	group = -- tries to spawn ALL items below
	{
		{ class = "M40x5", percent = 25.0 }, -- 25% chance this item will be spawned
		{ class = "HuntingScope", percent = 5.0 }, -- 5% chance this item will be spawned
	},

{ class = "SchoolPackGreen", percent = 100 },

The percent can be accurate to 4 decimal places (.001) to make for rare item spawns (one in 1,000), but the categories can be nested,
so you can have for example a 1 in 1,000 chance for a category that has a 1 in 1,000 chance of an item so 1 in 1,000,000 in that case for a really rare spawn

Item Categories can be nested to allow for a great amount of variety when spawning items.

--------------

Item Contents:

To add contents to the storage space for an item when it is spawned you need to tell the storage
category that it has "contents", like this:

	{ class = "RuggedPack", contents="RandomBackpackContents", percent = 25 },

Then, when you define the contents category you can use the optional percent, min, and max attributes like so:

	category = "RandomBackpackContents",
	classes =
	{
		{category = "RandomFood", percent = 15, min = 1, max = 4 },
	},

What the above does is if a "RuggedPack" is spawned then there is a 15% chance that it will spawn with between
1 and 4 "RandomFood" items. A first item is always guaranteed to be spawned, but each successive item's percent is
reduced to 25% of the prior item's, like so:

1st item = 100% to spawn
2nd item = 25% to spawn (if first item spawned)
3rd item = 6.25% to spawn (if second item spawned)
4th item = 1.5625% to spawn (if third item spawned)
...

The level_specific flag only works on a cateogory
If it is set to 1, then it will try and match to the specified category name appended with an underscore and the current level name.
For example, if the current level is islands and the category name is fred, then it would try and find a catgory named fred_islands.
If fred_islands does not exist, then it will use fred_default instead. This allows you to override categoriers at a map level, if desired.

--]]


	itemCategories =
	{
		-- ====================================================================
		-- BASIC CATEGORIES
		-- ====================================================================

		-- --------------------------------------------------------------------
		-- Static Spawners
		-- These are currently placed on the level to only spawn these items
		-- by the level designers
		-- --------------------------------------------------------------------

		-- --------------------------------------------------------------------
		-- FOR INTERNAL TESTING - DONT USE
		-- --------------------------------------------------------------------

		{
			category = "SpawnTest",
			classes =
			{
				{ class = "G18Pistol", contents="RandomM40A5Attachments", percent = 100 },
			},
		},

		{
			category = "RandomM40A5Attachments",
			group =
			{
				{ class = "9mmx10", percent = 100.0 },
			},
		},

		-- --------------------------------------------------------------------
		-- WEAPONS
		-- --------------------------------------------------------------------

		{
			category = "Map",
			classes =
			{
				{ category = "RandomFireStarter", percent = 30 },
				{ class = "Binoculars", percent = 15 },
				{ class = "Cb_radio", percent = 35 },
				{ class = "GridMap", percent = 15 },
				{ class = "Map", percent = 20 },
			},
		},
		
		{
			category = "GridMap",
			classes =
			{
				{ category = "GridMap", percent = 100, level_specific=1 },
			},
		},

		{
			category = "Map_default",
			classes =
			{
				{ class = "Map", percent = 100 },
			},
		},

		{
			category = "Map_canyonlands",
			classes =
			{
				{ class = "Map_canyonlands", percent = 100 },
			},
		},

		{
			category = "GridMap_default",
			classes =
			{
				{ class = "GridMap", percent = 100 },
			},
		},

		{
			category = "GridMap_canyonlands",
			classes =
			{
				{ class = "GridMap_canyonlands", percent = 100 },
			},
		},

		-- A random epic spawn for hard to reach areas. Use sparingly.
		{
			category = "RandomLegendaryWeapon",
			classes =
			{
				{ category = "M50Skins", percent = 1 },
				{ class = "ArmoredGhillieHood", percent = 7 },
				{ class = "ArmoredGhillieSuit", percent = 7 },
				{ class = "L1AR", percent = 10 },
				{ class = "Deagle", percent = 10 },
				{ class = "Subjugator", percent = 5 },
				{ class = "SCAR-H", percent = 15 },
				{ class = "Model1873", percent = 12 },
				{ class = "Peacemaker", percent = 10 },
				{ class = "Jackal", percent = 10 },
				{ class = "RocketLauncherNew", percent = 1 },
				{ class = "Mk18Reaver", percent = 1 },
				{ class = "GoldenCudgel1", percent = 10 }, 
			},
		},
		
		{
			category = "RandomEpicWeapon",
			classes =
			{
				{ category = "Mk18ReaverWithMagazines", percent = 50 },
				{ category = "SubjugatorWithMagazines", percent = 2 },
				{ category = "L1ARWithMagazines", percent = 10 },
				{ category = "AKMGoldWithMagazines", percent = 30 },
				{ category = "ColtPythonGrimeyRickWithRounds", percent = 25 },
				{ category = "M4A1WithMagazines", percent = 15 },
				{ category = "M16VietnamWithMagazines", percent = 5 },
				{ category = "VSSWithMagazines", percent = 5 },
				{ category = "RPKWithMagazines", percent = 5 },
				{ category = "M4V5WithMagazines", percent = 5 },
				{ category = "G36CWithMagazines", percent = 20 },
				{ category = "HK416WithRounds", percent = 20 },
				{ category = "SCARWithMagazines", percent = 20 },
				{ category = "PeacemakerWithMagazines", percent = 3 },
				{ category = "Model1873WithMagazines", percent = 3 },
				{ category = "M50WithMagazines", percent = 2 },
				{ class = "AxePatrick", percent = 25 },
				{ class = "BaseballBatHerMajesty", percent = 15 },
				{ class = "KatanaBlackWidow", percent = 15 },
				{ class = "Mk18Reaver", percent = 2 },
			},
		},
		
		{
			category = "RandomEpicWeaponPure",
			classes =
			{
				{ class = "Mk18Reaver", percent = 6 },
				{ class = "M4A1", percent = 6 },
				{ class = "M16Vietnam", percent = 6 },
				{ class = "VSS", percent = 6 },
				{ class = "RPK", percent = 6 },
				{ class = "M4V5", percent = 6 },
				{ class = "AKMGold", percent = 9 },
				{ class = "ColtPythonGrimeyRick", percent = 10 },
				{ class = "AxePatrick", percent = 15 },
				{ class = "BaseballBatHerMajesty", percent = 15 },
				{ class = "KatanaBlackWidow", percent = 15 },
			},
		},

		{
			category = "RandomFlashlight",
			classes =
			{
				{ class = "Flashlight", percent = 1 },
				{ class = "FlashlightPistol", percent = 14 },
				{ class = "FlashlightMounted", percent = 14 },
				{ class = "FlashlightRifle", percent = 14 },
				{ class = "Headlamp", percent = 19 },
				{ class = "HeadlampRed", percent = 5 },
				{ class = "Maglite", percent = 18 },
				{ class = "MagliteSmall", percent = 18 },
			},
		},
		
		{
			category = "RandomCraftedTools",
			classes =
			{
				{ class = "CraftedHammer", percent = 33 },
				{ class = "CraftedHatchet", percent = 34 },
				{ class = "CraftedPickaxe", percent = 33 },
			},
		},

		{
			category = "RandomCraftedWeapons",
			classes =
			{
				{ category = "CraftedBowWithMagazines", percent = 1 },
				{ class = "CraftedPistol", percent = 1 },
				{ class = "CraftedRifleLong", percent = 1 },
				{ class = "CraftedSMG", percent = 1 },
				{ class = "CraftedLongPistol", percent = 1 },
				{ class = "CraftedPistol556", percent = 1 },
				{ class = "CraftedRifle9mm", percent = 1 },
				{ class = "CraftedShortRifle556", percent = 1 },
				{ class = "CraftedShortShotgun", percent = 1 },
				{ class = "CraftedShotgun", percent = 1 },
			},
		},

		-- --------------------------------------------------------------------
		-- ATTACHMENTS
		-- --------------------------------------------------------------------

		-- --------------------------------------------------------------------
		-- THROWABLES
		-- --------------------------------------------------------------------

		-- --------------------------------------------------------------------
		-- TENT CONTENTS
		-- See tent's XML item file - loot_item_category
		-- --------------------------------------------------------------------

		{
			category = "RandomTentContents",
			classes =
			{
				-- Can add all kinds of stuff to this category - clothes/weapons/etc
				{category = "Map", percent = 9 },
				{category = "RandomConsumable", percent = 74, min = 1, max = 2 },
				{category = "RandomCraftedTools", percent = 11, min = 1, max = 2 },
				{category = "RandomMedical", percent = 2 },
				{category = "RandomCrafting", percent = 1 },
				{category = "RandomAccessory", percent = 3 },
			},
		},

		-- --------------------------------------------------------------------
		-- VEHICLE CONTENTS
		-- See VehicleSpawnerManager.lua
		-- --------------------------------------------------------------------

		{
			category = "RandomTowcarContents",
			classes =
			{
				{category = "Map", percent = 1 },
				{class = "CarBattery", percent = 100 },
				{class = "DriveBelt", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
				{class = "Wheel", percent = 100, min = 1, max = 4 },
			},
		},

		{
			category = "RandomF100TruckContents",
			classes =
			{
				{category = "Map", percent = 4 },
				{category = "RandomAmmo", percent = 4 },
				{category = "RandomCargoPants", percent = 4 },
				{category = "RandomCraftedTools", percent = 2 },
				{category = "RandomConsumable", percent = 10 },
				{category = "RandomIncapacition", percent = 4 },
				{category = "RandomRanged", percent = 5 },
				{class = "CarBattery", percent = 100 },
				{class = "DriveBelt", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
				{class = "Wheel", percent = 100, min = 4, max = 4 },
				{class = "AmcoinLedger", percent = 2 },
				{class = "Oil", percent = 100 },
				{class = "JerryCanDiesel", percent = 100 },
				
			},
		},

		{
			category = "RandomFishingBoatContents",
			classes =
			{
				{category = "RandomAlcohol", percent = 25, min = 1, max = 3 },
				{category = "RandomClothes", percent = 25 },
				{category = "RandomFlashlight", percent = 25 },
				{category = "RandomHat", percent = 25 },
			},
		},

		{
			-- We spawn quadbikes as a group so they will have more items because of their 6 hour decay
			category = "RandomQuadBikeContents",
			group =
			{
				{class = "CarBattery", percent = 100 },
				{class = "DriveBelt", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
				{class = "Wheel", percent = 100, min = 1, max = 4 },
			},
		},

		{
			-- We spawn jetskis as a group so they will have more items because of their 6 hour decay
			category = "RandomJetskiContents",
			group =
			{
				{class = "CarBattery", percent = 100 },
				{class = "SparkPlugs", percent = 100 },
			},
		},

		{
			-- We spawn tractors as a group so they will have more items because of their 6 hour decay
			category = "RandomTractorContents",
			group =
			{
				{class = "CarBattery", percent = 50 },
				{class = "DriveBelt", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
				{class = "Wheel", percent = 100, min = 1, max = 4 },
				{class = "TowCable", percent = 50 },
			},
		},

		{
			category = "RandomTruck5TonContents",
			classes =
			{
				{category = "RandomAccessory", percent = 3 },
				{category = "RandomAmmo", percent = 5 },
				{category = "RandomCamoFace", percent = 5 },
				{category = "RandomCamoGloves", percent = 5 },
				{category = "RandomCamoHats", percent = 5 },
				{category = "RandomMilitaryItems", percent = 3 },
				{category = "RandomRanged", percent = 5 },
				{class = "CarBattery", percent = 100 },
				{class = "DriveBelt", percent = 50 },
				{class = "SparkPlugs", percent = 50 },
				{class = "Wheel", percent = 100, min = 6, max = 6 },
				{class = "Oil", percent = 100 },
				{class = "JerryCanDiesel", percent = 100 },
			},
		},

		{
			category = "RandomPartyBusContents",
			classes =
			{
				{category = "Map", percent = 10 },
				{category = "RandomClothes", percent = 3 },
				{category = "RandomFlashlight", percent = 5 },
				{category = "RandomConsumable", percent = 20 },
				{category = "RandomMaintenance", percent = 1 },
				{category = "RandomMedical", percent = 10 },
				{class = "CarBattery", percent = 10 },
				{class = "DriveBelt", percent = 10 },
				{class = "SparkPlugs", percent = 10 },
				{class = "Wheel", percent = 15, min = 1, max = 4 },
				{class = "Oil", percent = 100 },
				{class = "JerryCanDiesel", percent = 100 },
			},
		},

		{
			category = "RandomPoliceSedanSlot",
			classes =
			{
				{category = "Map", percent = 5 },
				{category = "RandomFlashlight", percent = 5 },
				{category = "RandomConsumable", percent = 14 },
				{category = "RandomIncapacition", percent = 9 },
				{category = "RandomMedical", percent = 10 },
				{category = "RandomPoliceItems", percent = 20 },
				{class = "CarBattery", percent = 100 },
				{class = "DriveBelt", percent = 75 },
				{class = "SparkPlugs", percent = 75 },
				{class = "Wheel", percent = 100 },
				{ class = "AmcoinLedger", percent = 2 },
			},
		},

		{
			category = "RandomPoliceSedanContents",
			group =
			{
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
			},
		},

		-- --------------------------------------------------------------------
		-- AI CONTENTS/LOOT
		-- See AI's XX_x.lua files - esLootItemCategory property
		-- --------------------------------------------------------------------

		-- Animals
		{
			category = "RandomChickenLoot",
			group =
			{
				{ class = "ChickenRaw" },
				{ class = "AnimalFat", percent = 25 },
				{ class = "AnimalGut", percent = 25 },
			},
		},

		{
			category = "RandomPigLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "HamRaw", min = 2, max = 4 },
			},
		},

		-- AI
		{
			category = "RandomMutantLoot",
			group =
			{
				--{ category = "RandomEggs", percent = 10 }, --easter event
				{ class = "AmcoinLedger", percent = 25, min = 1, max = 5},
				{ category = "RandomAmmo", percent = 100 },
				{ category = "RandomConsumable", percent = 100 },
				{ category = "RandomMedical", percent = 15 },
				{ category = "RandomMelee", percent = 15 },
				{ category = "RandomAccessory", percent = 25 },
				{ category = "RandomZombieGuide", percent = 15 },
				{ category = "RandomZombieGuide", percent = 5 },
			},
		},

		{
			category = "RandomBearLoot",
			group =
			{
				{ class = "AnimalGut" },
				{ class = "AnimalFat", min = 4, max = 5 },
				{ class = "BearMeatRaw", min = 5, max = 6, },
				{ class = "BearPelt" },
				{ class = "AmcoinLedger", min = 1, max = 3, },
			},
		},

		{
			category = "RandomBruteLoot",
			group =
			{
				{ category = "RandomAmmo", percent = 100 },
				{ category = "RandomAmmo", percent = 100 },
				{ category = "RandomMushroom", percent = 50 },
				{ category = "RandomAccessory", percent = 40 },
				{ category = "RandomZombieGuide", percent = 20 },
				{ category = "RandomZombieGuide", percent = 15 },
				{ category = "RandomZombieGuide", percent = 10 },
				{ class = "AmcoinLedger", percent = 5, min = 1, max = 5},
				--{ class = "SAPOCBriefcaseClosed", percent = 1 },
				--{ category = "RandomEggs", percent = 25 }, -- Easter event
				{ class = "GoldenCudgel2", percent = 25 }, 
				--{ class = "HalloweenBagBrute", percent = 30 }, -- Halloween event.
				{ class = "ChristmasPresentRare", percent = 30 }, -- Christmas event
			},
		},

		{
			category = "RandomDeerLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut", min = 1, max = 2 },
				{ class = "DeerMeatSteakRaw", min = 3, max = 4 },
				{ class = "DeerPelt" },
				{ class = "AmcoinLedger", min = 1, max = 3, },
			},
		},

		{
			category = "RandomHumanSpiderLoot",
			group =
			{
				{ class = "AmcoinLedger", percent = 5, min = 1, max = 5 },
				--{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ category = "RandomAccessory", percent = 65 },
				{ category = "RandomConsumable", percent = 100 },
				{ category = "RandomAmmo", percent = 100 },
				{ category = "RandomAmmo", percent = 100 },
				{ category = "RandomZombieGuide", percent = 20 },
				{ category = "RandomZombieGuide", percent = 15 },
				{ category = "RandomZombieGuide", percent = 10 },
				--{ category = "RandomEggs", percent = 40 }, -- Easter event
				--{ class = "HalloweenBagSpider", percent = 30 }, -- Halloween event
				{ class = "ChristmasPresentRare", percent = 30 }, -- Christmas event
				{ class = "guide_hazmat", percent = 1 },
				{ class = "guide_military", percent = 1 },
				{ class = "guide_special", percent = 1 },
			},
		},

		{
			category = "RandomWolfLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "WolfMeatSteakRaw", min = 2, max = 3 },
				{ class = "WolfPelt" },
			},
		},
		
		{
			category = "RandomRamLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "RamMeatSteakRaw", min = 2, max = 3 },
			},
		},
		
		{
			category = "RandomDonkeyLoot",
			group =
			{
				{ class = "AnimalFat", min = 2, max = 5 },
				{ class = "AnimalGut" },
				{ class = "DonkeyMeatSteakRaw", min = 2, max = 3 },
			},
		},
		{
			category = "RandomGiantScorpionLoot",
			group =
			{
				{ class = "AnimalFat" },
				{ class = "AnimalGut" },
				{ class = "ScorpionMeatSteakRaw", min = 1, max = 2 },
			},
		},

		-- --------------------------------------------------------------------
		-- ITEM CONTENTS
		-- --------------------------------------------------------------------

		{
			category = "RandomBackpackContents",
			classes =
			{
				--{ category = "RandomEggs", percent = 3 }, -- Easter event
				{ category = "RandomChristmasPresent", percent = 3 }, -- Christmas event
				--{ category = "halloweenBagCommon", percent = 3 }, -- Halloween event
				{ category = "Map", percent = 2 },
				{ category = "RandomCraftingGuide", percent = 2 },
				{ category = "RandomClothes", percent = 3 },
				{ category = "RandomCrafting", percent = 1 },
				{ category = "RandomFlashlight", percent = 1 },
				{ category = "RandomConsumable", percent = 8, min = 1, max = 2 },
				{ category = "RandomMaintenance", percent = 4 },
				{ category = "RandomMedical", percent = 2 },
				{ class = "AmcoinLedger", percent = 3 },
			},
		},

		{
			category = "RandomTorsoContents",
			classes =
			{
				{ category = "Map", percent = 2 },
				{ category = "RandomConsumable", percent = 5 },
				{ category = "RandomMedical", percent = 3 },
			},
		},

		{
			category = "RandomWaistContents",
			classes =
			{
				{ category = "RandomConsumable", percent = 6 },
				{ category = "RandomFlashlight", percent = 1 },
				{ class = "AmcoinLedger", percent = 3 },
			},
		},

		{
			category = "RandomLegsContents",
			classes =
			{
				{ category = "RandomConsumable", percent = 8 },
				{ category = "RandomFlashlight", percent = 1 },
				{ category = "RandomMedical", percent = 1 },
				{ class = "AmcoinLedger", percent = 3 },
			},
		},

		-- --------------------------------------------------------------------
		-- POLICE SECTION
		-- --------------------------------------------------------------------
		-- Special Police Spawner
		{
			category = "RandomPoliceItems", 
			classes =
			{
				{ category = "HandcuffsWithKey", percent = 2 },
				{ category = "RandomPoliceClothing", percent = 1 },
				{ category = "RandomCraftingGuide", percent = 4 },
				{ category = "RandomPoliceWeaponWithMagazines", percent = 50 },
				{ category = "RandomPoliceArmor", percent = 5 },
				{ category = "RandomAccessory", percent = 5 },
				{ class = "Cb_radio", percent = 1 },
				{ class = "FlashbangPickup", percent = 1 },
				{ class = "GrenadeGasTearPickup", percent = 1 },
				{ class = "GrenadeGasSleepPickup", percent = 1 },
				{ class = "MagliteSmall", percent = 5 },
				{ class = "PistolSilencer", percent = 3 },
				{ category = "CamoSilencer", percent = 2 },
				{ class = "Megaphone", percent = 2 },
				{ class = "PoliceBaton", percent = 1 },
				{ class = "StunBaton", percent = 1 },
				{ class = "AmcoinLedger", percent = 5 },
				{ class = "guide_police", percent = 5 },
			},
		},

		{
			category = "RandomPoliceClothing",
			classes =
			{
				{ category = "RandomPoliceBodyArmor", percent = 30 },
				{ class = "CargoPantsBlack", percent = 10 },
				{ class = "flexcap_policefrontback_black", percent = 1 },
				{ class = "flexcap_policefrontback_blue", percent = 1 },
				{ class = "flexcap_policefrontback_camo1", percent = 1 },
				{ class = "flexcap_policefrontback_camo2", percent = 1 },
				{ class = "flexcap_policefrontback_camo3", percent = 1 },
				{ class = "flexcap_policefrontback_camo4", percent = 1 },
				{ category = "RandomPoliceHelmet", percent = 30 },
				{ class = "guide_police", percent = 1 },
				{ class = "TacticalVestBlack", percent = 20 },
				{ class = "TshirtPoliceBlack", percent = 1 },
				{ class = "TshirtPoliceBlue", percent = 1 },
				{ class = "AmcoinLedger", percent = 1 },
			},
		},

		{
			category = "RandomPoliceWeaponWithMagazines",
			classes =
			{
				{ category = "G18PistolWithMagazines", percent = 40 },
				{ category = "AK74UWithMagazines", percent = 60 },
				{ category = "AKMWithMagazines", percent = 60 },
				{ category = "AP85WithMagazines", percent = 40 },
				{ category = "Shotgun870TacticalWithMagazines", percent = 8 },
				{ category = "PX4WithMagazines", percent = 5 },
				{ category = "AA12WithMagazines", percent = 10 },
				{ category = "AUMP45WithMagazines", percent = 55 },
				{ category = "R90WithMagazines", percent = 45 },
				{ category = "Mk18ReaverWithMagazines", percent = 50 },
				{ category = "M4A1WithMagazines", percent = 30 },
				{ category = "MP5WithMagazines", percent = 30 },
				{ category = "SCARWithMagazines", percent = 3 },
				{ category = "G36CWithMagazines", percent = 9 },
				{ category = "ScorpionWithMagazines", percent = 11 },
				--{ category = "MAC10WithMagazines", percent = 20 }, -- Disabled for new MAK10
				{ category = "UZIWithMagazines", percent = 11 },
				{ category = "MAK10WithRounds", percent = 20 },
				{ category = "SAS12WithRounds", percent = 10 },
				{ category = "TranquilizerGunWithDarts", percent = 5 },
				{ category = "TazerWithMagazines", percent = 6 },
				{ category = "RandomAccessory", percent = 5 },
			},
		},

		-- --------------------------------------------------------------------
		-- MILITARY SECTION
		-- --------------------------------------------------------------------
		-- Special Military Spawner
		{
			category = "RandomMilitaryItems", 
			classes =
			{
				{ category = "RandomAccessory", percent = 10 },
				{ category = "RandomCraftingGuide", percent = 35 },
				{ category = "RandomGhillieSuit", percent = 7 },
				{ category = "RandomHazmatSuit", percent = 4 },
				{ category = "RandomMilitaryClothing", percent = 43 },
				{ category = "RandomMilitaryGrenade", percent = 40 },
				{ category = "RandomMilitaryWeaponWithMagazines", percent = 100 },
				{ category = "RandomPoliceWeaponWithMagazines", percent = 50 },
				{ class = "guide_military", percent = 1 },
				{ class = "Binoculars", percent = 1 },
				{ class = "C4Bricks", percent = 10 },
				{ class = "Cb_radio", percent = 1 },
				{ class = "GasMask", percent = 1 },
				{ class = "FlashlightPistol", percent = 30 },
				{ class = "PistolSilencer", percent = 3 },
				{ category = "CamoSilencer", percent = 2 },
				{ class = "Maglite", percent = 2 },
				{ class = "MagliteSmall", percent = 3 },
				{ class = "MilitaryCanteenPlastic", percent = 4 },
				{ class = "MilitaryCanteenMetal", percent = 1 },
				{ class = "MRE", percent = 30 },
				{ class = "SurvivalKnife", percent = 2 },
				{ class = "hesco_barrier", percent = 1 },
			},
		},

		{
			category = "RandomMilitaryClothing",
			classes =
			{
				{ category = "RandomMilitaryBodyArmor", percent = 80 },
				{ category = "RandomCamoClothes", percent = 30 },
				{ category = "RandomMilitaryGloves", percent = 30 },
				{ category = "RandomMilitaryHelmet", percent = 30 },
				{ category = "RandomMilitaryJacket", percent = 30 },
				{ category = "RandomMilitaryShoes", percent = 5 },
			},
		},

		{
			category = "RandomMilitaryWeaponWithMagazines",
			classes =
			{
				{ category = "RandomPoliceWeaponWithMagazines", percent = 45 },
				{ category = "M249WithMagazines", percent = 30 },
				{ category = "KrissVWithMagazines", percent = 20 },
				{ category = "M1911WithMagazines", percent = 30 },
				{ category = "M40A5WithMagazines", percent = 50 },
				{ category = "M16WithMagazines", percent = 80 },
				{ category = "AT15WithMagazines", percent = 80},
				{ category = "AKMGoldWithMagazines", percent = 30 },
				{ category = "M4A1WithMagazines", percent = 15 },
				{ category = "SCARWithMagazines", percent = 15 },
				{ category = "G36CWithMagazines", percent = 12 },
				{ category = "AkValWithMagazines", percent = 15 },
				{ category = "AK5DWithMagazines", percent = 15 },
				{ category = "M97WithRounds", percent = 2 },			
			},
		},

		-- --------------------------------------------------------------------
		-- HUNTING SECTION
		-- --------------------------------------------------------------------
		-- Civilian Hunting Items Spawner
		{
			category = "RandomHuntingItems",
			classes =
			{
				{ category = "RandomHuntingWeapons", percent = 40 },
				{ category = "RandomHuntingClothing", percent = 39 },
				{ category = "RandomCraftingGuide", percent = 60 },
				{ class = "Cb_radio", percent = 1 },
				{ class = "Map", percent = 1 },
				{ class = "Binoculars", percent = 2 },
				{ category = "CamoHuntingScope", percent = 20 },
			},
		},

		-- Civilian Hunting Weapons
		{
			category = "RandomHuntingWeapons",
			classes =
			{
				{ category = "Rem700WithRounds", percent = 40 },
				{ category = "RandomPoliceWeaponWithMagazines", percent = 60 },
				{ category = "Rem870WithRounds", percent = 32 },
				{ category = "Sako85WithRounds", percent = 35 },
				{ category = "M14WithRounds", percent = 20 },
				{ category = "CrossbowWithMagazines", percent = 1 },
				{ class = "HuntingKnife", percent = 1 },
			},
		},

		-- Civilian Hunting Clothing 
		-- camo1 is the duck type camo good for civilian use
		{
			category = "RandomHuntingClothing",
			classes =
			{
				{ class = "CargoPantsCamo1", percent = 25 },
				{ class = "WoolGlovesCamo1", percent = 10 },
				{ class = "CottonShirtBrown", percent = 20 },
				{ class = "RuggedPackCamo1", percent = 20 },
				{ class = "TshirtCamo1", percent = 25 },
			},
		},

		-- --------------------------------------------------------------------
		-- HOLIDAY/SEASONAL
		-- --------------------------------------------------------------------

		{
			category = "RandomChristmasPresent",
			classes =
			{
				{ class = "ChristmasPresentCommon1", percent = 50 },
				{ class = "ChristmasPresentCommon2", percent = 50 },
			},
		},
		
		{
			category = "halloweenBagCommon",
			classes =
			{
				{ class = "HalloweenBagMonster", percent = 50 },
				{ class = "HalloweenBagPumpkin", percent = 50 },
			},
		},

		-- BASE PARTS
		-- Used in presents and easter eggs
		{
			category = "ChristmasPresentCommon",
			classes =
			{
				{ class = "christmas_light_string", percent = 12 },
				{ class = "christmas_candle", percent = 8 },
				{ class = "christmas_gift_pile", percent = 12 },
				{ class = "christmas_rug_01", percent = 7 },
				{ class = "christmas_rug_02", percent = 7 },
				{ class = "SweaterChristmasGreen", percent = 7 },
				{ class = "SweaterChristmasRed", percent = 7 },
				{ class = "ChristmasHat", percent = 5 },
				{ class = "snowman_small", percent = 6 },
				{ class = "Peacemaker", percent = 2 },
				{ class = "ScavengerShirt", percent = 3 },
				{ class = "ScavengerPants", percent = 3 },
				{ class = "R90", percent = 2 },
				{ class = "AK74U", percent = 2 },
				{ class = "MP5", percent = 2 },
				{ class = "AUMP45", percent = 2 },
				{ class = "Mk18Reaver", percent = 2 },
				{ class = "AT15", percent = 2 },
				{ class = "Model1873", percent = 2 },
			},
		},
		
		{
			category = "ChristmasPresentRare",
			classes =
			{
				{ class = "snowman", percent = 20 },
				{ class = "christmas_rug_03", percent = 15 },
				{ class = "SweaterChristmasGreen2", percent = 10 },
				{ class = "SweaterChristmasRed2", percent = 10 },
				{ class = "christmas_wreath", percent = 12 },
				{ class = "christmas_stocking", percent = 10 },
				{ class = "christmas_snowglobe", percent = 5 },
				{ class = "ScavengerHelmet", percent = 2 },
				{ class = "EggNog", percent = 0.5 },
				{ class = "GingerBreadMan", percent = 0.5 },
				{ class = "M4A1", percent = 2 },
				{ class = "L1AR", percent = 2 },
				{ class = "L1AR", percent = 2 },
				{ class = "RPK", percent = 2 },
				{ class = "AKMGold", percent = 2 },
				{ class = "MK18Reaver", percent = 2 },
				{ class = "SpaceHelmet", percent = 3 },
			},
		},
		
		{
			category = "RandomBpartPresent",
			classes =
			{
				{ class = "plated_bridge_3m_12m", percent = 1 },
				{ class = "plated_bridge_3m_6m", percent = 1 },
				{ class = "plated_bridge_6m_12m", percent = 1 },
				{ class = "plated_bridge_6m_6m", percent = 1 },
				{ class = "plated_bridge_9m_12m", percent = 1 },
				{ class = "plated_bridge_9m_6m", percent = 1 },
				{ class = "plated_wall_drawbridge_3m_4m", percent = 1 },
				{ class = "plated_draw_bridge", percent = 1 },
				{ class = "plated_walkroof_3m_4m_4m", percent = 1 },
				{ class = "plated_watchtower", percent = 1 },
				{ class = "plated_watchtower_big", percent = 1 },
				{ class = "plated_watchtower_tire", percent = 1 },
				{ class = "plated_watchtower_tire_big", percent = 1 },
				{ class = "plated_foundation_2m_2m_4m", percent = 1 },
				{ class = "plated_foundation_4m_4m_4m", percent = 5 },
				{ class = "plated_walkway_3m_4m_4m", percent = 5 },
				{ class = "plated_walkway_3m_4m_4m_02", percent = 5 },
				{ class = "plated_stairs_3m_4m_4m_02", percent = 5 },
				{ class = "plated_walkstairs_3m_4m_4m", percent = 5 },
				{ class = "plated_roof_4m_4m", percent = 5 },
				{ class = "plated_door_lockable_02", percent = 5 },
				{ class = "plated_door_lockable_1m_2m", percent = 5 },
				{ class = "plated_wall_3m_4m", percent = 5 },
				{ class = "plated_wall_3m_4m_02", percent = 5 },
				{ class = "plated_wall_door_3m_4m", percent = 5 },
				{ class = "plated_wall_door_3m_4m_02", percent = 5 },
				{ class = "plated_wall_window_3m_4m", percent = 5 },
				{ class = "plated_wall_window_3m_4m_02", percent = 5 },
				{ class = "plated_gate_lockable_3m_4m", percent = 4 },
				{ class = "plated_gatehouse", percent = 4 },
				{ class = "plated_wall_garage_large", percent = 4 },
				{ class = "garage_door_large", percent = 4 },
			},
		},

		{
			category = "RandomChristmasClothing",
			classes =
			{
				{ class = "ChristmasHat", percent = 20 },
				{ class = "SweaterChristmasGreen", percent = 20 },
				{ class = "SweaterChristmasGreen2", percent = 20 },
				{ class = "SweaterChristmasRed", percent = 20 },
				{ class = "SweaterChristmasRed2", percent = 20 },
			},
		},
		
		{
			category = "HalloweenBagCommonLoot",
			classes =
			{
				{ category = "RandomPumpkins", percent = 15 },
				{ class = "halloween_light_string", percent = 20 },
				{ class = "halloween_creepy_bunny", percent = 20 },
				{ class = "SkullMask", percent = 6 },
				{ class = "SkullMaskSilver", percent = 3 },
				{ class = "R90", percent = 4 },
				{ class = "AK74U", percent = 4 },
				{ class = "MP5", percent = 4 },
				{ class = "AUMP45", percent = 4 },
				{ class = "Mk18Reaver", percent = 4 },
				{ class = "AT15", percent = 4 },
				{ class = "Model1873", percent = 2 },
				{ class = "Peacemaker", percent = 2 },
				{ class = "ScavengerShirt", percent = 4 },
				{ class = "ScavengerPants", percent = 4 },
			},
		},
		
		{
			category = "HalloweenLootUFO",
			classes =
			{
				{ category = "RandomPumpkins", percent = 12.5 },
				{ class = "halloween_light_string", percent = 12.5 },
				{ class = "halloween_creepy_bunny", percent = 12.5 },
				{ class = "halloween_creepy_bear", percent = 12.5 },
				{ class = "SkullMask", percent = 12.5 },
				{ class = "SkullMaskSilver", percent = 12.5 },
				{ class = "SkullMaskGold", percent = 12.5 },
				{ class = "wood_coffin", percent = 12.5 },
			},
		},
		
		{
			category = "HalloweenBagRare",
			classes =
			{
				{ category = "RandomPumpkins", percent = 15 },
				{ class = "halloween_candle", percent = 20 },
				{ class = "halloween_creepy_bear", percent = 20 },
				{ class = "SkullMask", percent = 10 },
				{ class = "SkullMaskGold", percent = 5 },
				{ class = "M4A1", percent = 4 },
				{ class = "L1AR", percent = 4 },
				{ class = "L1AR", percent = 4 },
				{ class = "RPK", percent = 2 },
				{ class = "AKMGold", percent = 2 },
				{ class = "MK18Reaver", percent = 2 },
				{ class = "SpaceHelmet", percent = 3 },
				{ class = "wood_coffin", percent = 9 },
			},
		},
		
		{
			category = "RandomPumpkins",
			classes =
			{
				{ class = "pumpkin_1", percent = 14.3 },
				{ class = "pumpkin_2", percent = 14.3 },
				{ class = "pumpkin_3", percent = 14.3 },
				{ class = "pumpkin_4", percent = 14.3 },
				{ class = "pumpkin_5", percent = 14.3 },
				{ class = "pumpkin_6", percent = 14.3 },
				{ class = "jack_o_lantern", percent = 14.2 },
			},
		},

		-- --------------------------------------------------------------------
		-- CLOTHING
		-- --------------------------------------------------------------------

		-- Back
		{
			category = "RuggedPack",
			classes =
			{
				{ class = "RuggedPack", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackBlack", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackBrown", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackCamo1", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackCamo2", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackCamo3", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackCamo4", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackGreen", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackGreenCamo1", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackGreenCamo2", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackGreenCamo3", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackGreenCamo4", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackBlue", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackOGreen", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackPink", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackPurple", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackRed", contents="RandomBackpackContents", percent = 20 },
				{ class = "RuggedPackYellow", contents="RandomBackpackContents", percent = 20 },
			},
		},

		{
			category = "RandomRuggedPackAirPlane",
			classes =
			{
				{ class = "RuggedPack", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackBlack", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackBrown", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackCamo1", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackCamo2", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackCamo3", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackCamo4", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackGreen", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackGreenCamo1", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackGreenCamo2", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackGreenCamo3", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackGreenCamo4", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "RuggedPackBlue", contents="RandomBackpackContents", percent = 15 },
				{ class = "RuggedPackOGreen", contents="RandomBackpackContents", percent = 15 },
				{ class = "RuggedPackPink", contents="RandomBackpackContents", percent = 15 },
				{ class = "RuggedPackPurple", contents="RandomBackpackContents", percent = 15 },
				{ class = "RuggedPackRed", contents="RandomBackpackContents", percent = 15 },
				{ class = "RuggedPackYellow", contents="RandomBackpackContents", percent = 15 },
			},
		},

		{
			category = "RandomRuckSack",
			classes =
			{
				{ class = "RuckSack", contents="RandomBackpackContents", percent = 100 },
			},
		},

		{
			category = "RandomRuckSackAirPlane",
			classes =
			{
				{ class = "RuckSack", contents="RandomBackpackAirPlaneContents", percent = 100 },
			},
		},

		{
			category = "RandomDuffelBag",
			classes =
			{
				{ class = "DuffelBag", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagBlack", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagGreen", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagGreenCamo1", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagGreenCamo2", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagGreenCamo3", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagGreenCamo4", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagTanCamo1", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagTanCamo2", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagTanCamo3", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagTanCamo4", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo1", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo2", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo3", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo4", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagBlue", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagLightBlue", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagOGreen", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagPink", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagPurple", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagRed", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagWhite", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagYellow", contents="RandomBackpackContents", percent = 15 },
			},
		},

		{
			category = "RandomDuffelBagAirPlane",
			classes =
			{
				{ class = "DuffelBag", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagBlack", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagGreen", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagGreenCamo1", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagGreenCamo2", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagGreenCamo3", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagGreenCamo4", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagTanCamo1", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagTanCamo2", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagTanCamo3", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagTanCamo4", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo1", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo2", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo3", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagUrbanCamo4", contents="RandomBackpackAirPlaneContents", percent = 15 },
				{ class = "DuffelBagBlue", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagLightBlue", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagOGreen", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagPink", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagPurple", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagRed", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagWhite", contents="RandomBackpackContents", percent = 15 },
				{ class = "DuffelBagYellow", contents="RandomBackpackContents", percent = 15 },
			},
		},

		{
			category = "RandomStowPack",
			classes =
			{
				{ class = "StowPackBlack", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackBlue", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackGreen", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackOrange", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackPink", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackPurple", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackRed", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackWhite", contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackYellow", contents="RandomBackpackContents", percent = 15 },
			},
		},

		-- Face
		{
			category = "RandomBandana",
			classes =
			{
				{ class = "BandanaBlack", percent = 7 },
				{ class = "BandanaBrown", percent = 6 },
				{ class = "BandanaCamo1", percent = 7 },
				{ class = "BandanaCamo2", percent = 7 },
				{ class = "BandanaCamo3", percent = 7 },
				{ class = "BandanaCamo4", percent = 7 },
				{ class = "BandanaGray", percent = 7 },
				{ class = "BandanaGreen", percent = 7 },
				{ class = "BandanaKhaki", percent = 7 },
				{ class = "BandanaOrange", percent = 6 },
				{ class = "BandanaPink", percent = 7 },
				{ class = "BandanaRed", percent = 6 },
				{ class = "BandanaPurple", percent = 7 },
				{ class = "BandanaYellow", percent = 6 },
				{ class = "BandanaYellowHex", percent = 6 },
			},
		},

		{
			category = "RandomBalaclava",
			classes =
			{
				{ class = "BalaclavaBlack", percent = 20 },
				{ class = "BalaclavaGray", percent = 20 },
				{ class = "BalaclavaGreen", percent = 20 },
				{ class = "BalaclavaPink", percent = 20 },
				{ class = "BalaclavaYellow", percent = 20 },
			},
		},


		-- Feet
		{
			category = "RandomCombatBoots",
			classes =
			{
				{ class = "CombatBootsBlack", percent = 45 },
				{ class = "CombatBootsCamo", percent = 45 },
				{ class = "CombatBootsTan", percent = 45 },
			},
		},

		{
			category = "RandomHitops",
			classes =
			{
				{ class = "HitopsBlack", percent = 16 },
				{ class = "HitopsBlue", percent = 14 },
				{ class = "HitopsGreen", percent = 14 },
				{ class = "HitopsPink", percent = 14 },
				{ class = "HitopsPurple", percent = 14 },
				{ class = "HitopsRed", percent = 14 },
				{ class = "HitopsYellow", percent = 14 },
			},
		},

		{
			category = "RandomSneakers",
			classes =
			{
				{ class = "Sneakers", percent = 6.25 },
				{ class = "SneakersBlack", percent = 6.25 },
				{ class = "SneakersBlackBlue", percent = 6.25 },
				{ class = "SneakersBlackGreen", percent = 6.25 },
				{ class = "SneakersBlackPink", percent = 6.25 },
				{ class = "SneakersBlackRed", percent = 6.25 },
				{ class = "SneakersBlueBlack", percent = 6.25 },
				{ class = "SneakersBrown", percent = 6.25 },
				{ class = "SneakersGreenBlack", percent = 6.25 },
				{ class = "SneakersPinkBlack", percent = 6.25 },
				{ class = "SneakersRedBlack", percent = 6.25 },
				{ class = "SneakersSilver", percent = 6.25 },
				{ class = "SneakersWhite", percent = 6.25 },
				{ class = "SneakersWhiteBlue", percent = 6.25 },
				{ class = "SneakersWhiteGreen", percent = 6.25 },
				{ class = "SneakersWhitePink", percent = 6.25 },
			},
		},

		{
			category = "RandomSteeltoedBoots",
			classes =
			{
				{ class = "SteeltoedBootsBlack", percent = 65 },
				{ class = "SteeltoedBootsBrown", percent = 65 },
			},
		},


		-- Hands
		{
			category = "RandomMilitaryGloves",
			classes =
			{
				{ class = "MilitaryGlovesBlack", percent = 35 },
				{ class = "MilitaryGlovesBrown", percent = 35 },
				{ class = "MilitaryGlovesGreen", percent = 35 },
				{ class = "MilitaryGloves", percent = 35 },
			},
		},

		{
			category = "RandomWoolGloves",
			classes =
			{
				{ class = "WoolGlovesBlack", percent = 15 },
				{ class = "WoolGlovesBlue", percent = 20 },
				{ class = "WoolGlovesBrown", percent = 20 },
				{ class = "WoolGlovesGreen", percent = 10 },
				{ class = "WoolGlovesCamo1", percent = 5 },
				{ class = "WoolGlovesCamo2", percent = 5 },
				{ class = "WoolGlovesCamo3", percent = 5 },
				{ class = "WoolGlovesCamo4", percent = 5 },
				{ class = "WoolGlovesWhite", percent = 15 },
			},
		},


		-- Hat
		{
			category = "BandanaHat",
			classes =
			{
				{ class = "BandanaHat", percent = 20 },
				{ class = "BandanaHatCamo1", percent = 20 },
				{ class = "BandanaHatCamo2", percent = 20 },
				{ class = "BandanaHatCamo3", percent = 20 },
				{ class = "BandanaHatCamo4", percent = 20 },
			},
		},

		{
			category = "RandomCowboyHat",
			classes =
			{
				{ class = "CowboyHat", percent = 34 },
				{ class = "CowboyHatLeather", percent = 33 },
				{ class = "CowboyHatStraw", percent = 33 },
			},
		},

		{
			category = "RandomMilitaryHelmet",
			classes = 
			{
				{ class = "MilitaryHelmetGreen", percent = 20 },
				{ class = "MilitaryHelmetGreenCamo1", percent = 20 },
				{ class = "MilitaryHelmetGreenCamo2", percent = 20 },
				{ class = "MilitaryHelmetGreenCamo3", percent = 20 },
				{ class = "MilitaryHelmetGreenCamo4", percent = 20 },
				{ class = "MilitaryHelmetTan", percent = 20 },
				{ class = "MilitaryHelmetTanCamo1", percent = 20 },
				{ class = "MilitaryHelmetTanCamo2", percent = 20 },
				{ class = "MilitaryHelmetTanCamo3", percent = 20 },
				{ class = "MilitaryHelmetTanCamo4", percent = 20 },
				{ class = "MilitaryHelmetUrbanCamo1", percent = 20 },
				{ class = "MilitaryHelmetUrbanCamo2", percent = 20 },
				{ class = "MilitaryHelmetUrbanCamo3", percent = 20 },
				{ class = "MilitaryHelmetUrbanCamo4", percent = 20 },
				{ class = "MilitaryHelmetBlack", percent = 20 },
				{ class = "MilitaryHelmetBlue", percent = 20 },
				{ class = "MilitaryHelmetOGreen", percent = 20 },
				{ class = "MilitaryHelmetPink", percent = 20 },
				{ class = "MilitaryHelmetPurple", percent = 20 },
				{ class = "MilitaryHelmetRed", percent = 20 },
				{ class = "MilitaryHelmetWhite", percent = 20 },
				{ class = "MilitaryHelmetYellow", percent = 20 },
			},
		},
		
		{
			category = "RandomCivilianHelmet",
			classes = 
			{
				{ class = "FootballHelmet", percent = 3 },
				{ class = "FootballHelmetAmerica", percent = 3 },
				{ class = "FootballHelmetBlack", percent = 3 },
				{ class = "FootballHelmetBlue", percent = 4 },
				{ class = "FootballHelmetFabulous", percent = 3 },
				{ class = "FootballHelmetGold", percent = 3 },
				{ class = "FootballHelmetGreen", percent = 4 },
				{ class = "FootballHelmetRed", percent = 3 },
				{ class = "FootballHelmetStripedBlack", percent = 3 },
				{ class = "FootballHelmetStripedBlue", percent = 3 },
				{ class = "FootballHelmetStripedGreen", percent = 4 },
				{ class = "FootballHelmetStripedRed", percent = 3 },
				{ class = "FootballHelmetStripedTeal", percent = 3 },
				{ class = "FootballHelmetStripedYellow", percent = 4 },
				{ class = "FootballHelmetWhiteStripedBlack", percent = 3 },
				{ class = "FootballHelmetWhiteStripedBlue", percent = 3 },
				{ class = "FootballHelmetWhiteStripedGreen", percent = 3 },
				{ class = "FootballHelmetWhiteStripedRed", percent = 3 },
				{ class = "FootballHelmetWhiteStripedTeal", percent = 3 },
				{ class = "FootballHelmetWhiteStripedYellow", percent = 3 },
				{ class = "FootballHelmetYellow", percent = 3 },
				{ class = "BikeHelmetBlack", percent = 3 },
				{ class = "BikeHelmetBlue", percent = 3 },
				{ class = "BikeHelmetGreen", percent = 3 },
				{ class = "BikeHelmetPink", percent = 3 },
				{ class = "BikeHelmetPurple", percent = 3 },
				{ class = "BikeHelmetRed", percent = 3 },
				{ class = "BikeHelmetWhite", percent = 3 },
				{ class = "BikeHelmetYellow", percent = 3 },
				{ class = "MotorcycleHelmetCarbon", percent = 20 },
				{ class = "MotorcycleHelmetGold", percent = 20 },
				{ class = "MotorcycleHelmetWhite", percent = 20 },	
			},
		},

		-- Legs
		{
			category = "RandomBlueJeans2",
			classes =
			{
				{ class = "BlueJeans", contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2", contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2Brown", contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2Green", contents="RandomLegsContents", percent = 25 },
			},
		},

		{
			category = "RandomCargoPants",
			classes =
			{
				{ class = "CargoPantsBlack", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoPantsCamo1", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsCamo2", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsCamo3", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsCamo4", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsGreen", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsGreenCamo1", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoPantsGreenCamo2", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoPantsGreenCamo3", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoPantsGreenCamo4", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoPantsTan", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsUrbanCamo1", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsUrbanCamo2", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsUrbanCamo3", contents="RandomLegsContents", percent = 10 },
				{ class = "CargoPantsUrbanCamo4", contents="RandomLegsContents", percent = 10 },
			},
		},

		{
			category = "RandomCargoShorts",
			classes =
			{
				{ class = "CargoShortsBlack", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsBlue", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsBrightBlue", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsBrightGreen", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsBrightPink", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsBrightRed", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsBrown", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsCamo1", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsCamo2", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsCamo3", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsCamo4", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsDarkGrey", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsGreen", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsGrey", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsTan", contents="RandomLegsContents", percent = 20 },
				{ class = "CargoShortsYellow", contents="RandomLegsContents", percent = 20 },
			},
		},

		{
			category = "RandomTrackPants",
			classes =
			{
				{ class = "TrackPantsBlack", percent = 20 },
				{ class = "TrackPantsBlue", percent = 20 },
				{ class = "TrackPantsGreen", percent = 20 },
				{ class = "TrackPantsOrange", percent = 20 },
				{ class = "TrackPantsPink", percent = 10 },
				{ class = "TrackPantsYellow", percent = 10 },
			},
		},

		{
			category = "RandomWandererPants",
			classes =
			{
				{ class = "WandererPantsBlack", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsBlue", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsBrown", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsGreen", contents="RandomLegsContents", percent = 17 },
				{ class = "WandererPantsRed", contents="RandomLegsContents", percent = 16 },
				{ class = "WandererPantsTan", contents="RandomLegsContents", percent = 16 },
			},
		},


		-- Torso
		{
			category = "RandomButtonUpShirt",
			classes = 
			{
				{ class = "ButtonUpShirtBlack", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackDots", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlue", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueDots", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueHawaiian", contents="RandomTorsoContents", percent = 4},
				{ class = "ButtonUpShirtBlueStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreenChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreenStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGrey", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyDots", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreen", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenHawaiian", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGrey", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreyChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreyStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPink", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPinkChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPinkStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurple", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleHawaiian", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleStriped", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRed", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedHawaiian", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedDots", contents="RandomTorsoContents", percent = 3},
			},
		},

		{
			category = "RandomCottonShirt",
			classes =
			{
				{ class = "CottonShirtBlue", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtBrown", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtGreen", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtGrey", contents="RandomTorsoContents", percent = 17 },
				{ class = "CottonShirtRed", contents="RandomTorsoContents", percent = 16 },
				{ class = "CottonShirtTan", contents="RandomTorsoContents", percent = 16 },
			},
		},

		{
			category = "RandomHazmatSuit",
			classes = 
			{
				{ class = "HazmatSuitBrownCamo", percent = 6.0 },
				{ class = "HazmatSuitGreenCamo", percent = 6.0 },
				{ class = "HazmatSuitPurple", percent = 8.0 },
				{ class = "HazmatSuitRed", percent = 8.0 },
				{ category = "RandomHazmatSuitColored", percent = 24.0 },
				{ category = "RandomHazmatMaskColored", percent = 24.0 },
				{ category = "RandomGasCanisterPackColored", percent = 24.0 },
			}	
		},
		
		{
			category = "RandomHazmatSuitColored",
			classes = 
			{
				{ class = "HazmatSuitBlack", percent = 13 },
				{ class = "HazmatSuitBlue", percent = 13 },
				{ class = "HazmatSuitGreen", percent = 13 },
				{ class = "HazmatSuitPink", percent = 12 },
				{ class = "HazmatSuitOrange", percent = 12 },
				{ class = "HazmatSuitRed", percent = 12 },
				{ class = "HazmatSuitWhite", percent = 13 },
				{ class = "HazmatSuitYellow", percent = 12 },
			}	
		},
		
		{
			category = "RandomHazmatMaskColored",
			classes = 
			{
				{ class = "HazmatMask", percent = 17.0 },
				{ class = "HazmatMaskBlack", percent = 12.5 },
				{ class = "HazmatMaskBlue", percent = 12.5 },
				{ class = "HazmatMaskGreen", percent = 12.5 },
				{ class = "HazmatMaskPink", percent = 12.5 },
				{ class = "HazmatMaskOrange", percent = 12.5 },
				{ class = "HazmatMaskWhite", percent = 12.5 },
				{ class = "HazmatMaskYellow", percent = 12.5 },
			}	
		},
		
		{
			category = "RandomGasCanisterPackColored",
			classes = 
			{
				{ class = "GasCanisterPack", percent = 12.5 },
				{ class = "GasCanisterPackBlack", percent = 12.5 },
				{ class = "GasCanisterPackBlue", percent = 12.5 },
				{ class = "GasCanisterPackGreen", percent = 12.5 },
				{ class = "GasCanisterPackPink", percent = 12.5 },
				{ class = "GasCanisterPackOrange", percent = 12.5 },
				{ class = "GasCanisterPackWhite", percent = 12.5 },
				{ class = "GasCanisterPackYellow", percent = 12.5 },
			}	
		},
		
		{
			category = "RandomFullHazmatSet",
			group = 
			{
				{ category = "RandomHazmatSuitColored", percent = 100 },
				{ category = "RandomHazmatMaskColored", percent = 100 },
				{ category = "RandomGasCanisterPackColored", percent = 100 },
			}	
		},
		

		{
			category = "RandomHoodie",
			classes = 
			{
				{class = "Hoodie", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlackGreyDesign1", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlackWhiteDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlueBlackDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlueDesign2", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieBlueWhiteDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieCapitalMunch", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieEagle", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreenBlackDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieGreenDesign2", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreenWhiteDesign4", contents="RandomTorsoContents", percent = 4},
				{class = "HoodieGrey", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreyDarkGreyDesign1", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieOrangeBlackDesign4", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePinkDesign2", contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixel", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelBlackGreyDesign5", contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixelBlueBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreenBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyBlueDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyDesign5", contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixelGreyGreenDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyOrangeDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyRedDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelOrangeBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelRedBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedBlackDesign4", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedDesign2", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedWhiteDesign4", contents="RandomTorsoContents", percent = 3},
				{class = "HoodieSerk", contents="RandomTorsoContents", percent = 3},
			},
		},

		{
			category = "RandomLeatherJacket",
			classes =
			{
				{ class = "LeatherJacketBrown", contents="RandomTorsoContents", percent = 25},
				{ class = "LeatherJacketBlack", contents="RandomTorsoContents", percent = 25},
				{ class = "LeatherJacketYellow", contents="RandomTorsoContents", percent = 25},
				{ class = "LeatherJacketRed", contents="RandomTorsoContents", percent = 25},
			},
		},

		{
			category = "RandomMilitaryJacket",
			classes = 
			{
				{ class = "MilitaryJacketBlack", contents="RandomTorsoContents", percent = 20 },
				{ class = "MilitaryJacketGreen", contents="RandomTorsoContents", percent = 20 },
				{ class = "MilitaryJacketGreenCamo1", contents="RandomTorsoContents", percent = 20 },
				{ class = "MilitaryJacketGreenCamo2", contents="RandomTorsoContents", percent = 20 },
				{ class = "MilitaryJacketGreenCamo3", contents="RandomTorsoContents", percent = 20 },
				{ class = "MilitaryJacketGreenCamo4", contents="RandomTorsoContents", percent = 20 },
				{ class = "MilitaryJacketTan", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketTanCamo1", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketTanCamo2", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketTanCamo3", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketTanCamo4", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketUrbanCamo1", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketUrbanCamo2", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketUrbanCamo3", contents="RandomTorsoContents", percent = 10 },
				{ class = "MilitaryJacketUrbanCamo4", contents="RandomTorsoContents", percent = 10 },
			},
		},

		{
			category = "RandomPuffyJacket",
			classes =
			{
				{ class = "PuffyJacketEaster", contents="RandomTorsoContents", percent = 0.5 },
				{ class = "PuffyJacketGold", contents="RandomTorsoContents", percent = 1.0 },
				{ class = "PuffyJacketSilver", contents="RandomTorsoContents", percent = 1 },
				{ class = "PuffyJacketAmerica", contents="RandomTorsoContents", percent = 1 },
				{ class = "PuffyJacketCanada", contents="RandomTorsoContents", percent = 1 },
				{ class = "PuffyJacketCamo1", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketCamo2", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketCamo3", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketWhiteCamo1", contents="RandomTorsoContents", percent = 4 },
				{ class = "PuffyJacketBlack", contents="RandomTorsoContents", percent = 4.5 },
				{ class = "PuffyJacketBlueWhite", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGreenWhite", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGrey", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGreyBlack", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketGreyBlack2", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketKaki", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketOrangeGreen", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketOrangeTeal", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketOrangeWhite", contents="RandomTorsoContents", percent = 5 },
				{ class = "PuffyJacketPinkWhite", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketPurpleFushia", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketRedBlue", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketRedWhite", contents="RandomTorsoContents", percent = 6 },
				{ class = "PuffyJacketWhite", contents="RandomTorsoContents", percent = 6 },
			},
		},

		{
			category = "RandomRainJacket",
			classes =
			{
				{ class = "RainJacketBlack", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketBlue", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketBlueGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo1", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo2", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo3", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketDarkGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreen", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreenGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreyBlack", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketKaki", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketLightDarkGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketMarine", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketOrangeBlue", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketPinkPurple", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRed", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRedBlue", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRedGrey", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketYellow", contents="RandomTorsoContents", percent = 5},
				
			},
		},
		
		{
			category = "RandomRainJacketHood",
			classes =
			{
				{ class = "RainJacketBlackUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketBlueUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketBlueGreyUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo1Up", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo2Up", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketCamo3Up", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketDarkGreyUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreenUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreenGreyUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreyUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketGreyBlackUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketKakiUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketLightDarkGreyUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketMarineUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketOrangeBlueUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketPinkPurpleUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRedUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRedBlueUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketRedGreyUp", contents="RandomTorsoContents", percent = 5},
				{ class = "RainJacketYellowUp", contents="RandomTorsoContents", percent = 5},
			},
		},

		-- Ghillie Suits

		{
			category = "RandomGhillieSuit",
			classes = 
			{
				{ category = "RandomGhillieSuitParts", percent= 60 },
				{ category = "GhillieSuit1Full", percent= 8 },
				{ category = "GhillieSuit2Full", percent= 8 },
				{ category = "GhillieSuit3Full", percent= 8 },
				{ category = "GhillieSuit4Full", percent= 8 },
				{ category = "RandomGhillieSuitColored", percent= 4 },
				{ category = "RandomGhillieHoodColored", percent= 4 },
			},
		},

		{
			category = "RandomGhillieSuitParts",
			classes = 
			{
				{ class = "GhillieSuit1", percent= 20.5 },
				{ class = "GhillieHood1", percent= 20.5 },
				{ class = "GhillieSuit2", percent= 20.5 },
				{ class = "GhillieHood2", percent= 20.5 },
				{ class = "GhillieSuit3", percent= 20.5 },
				{ class = "GhillieHood3", percent= 20.5 },
				{ class = "GhillieSuit4", percent= 20.5 },
				{ class = "GhillieHood4", percent= 20.5 },
			},
		},
		
		{
			category = "RandomGhillieSuitColored",
			classes = 
			{
				{ class = "GhillieSuitBlack", percent= 12 },
				{ class = "GhillieSuitBlue", percent= 11 },
				{ class = "GhillieSuitGreen", percent= 11 },
				{ class = "GhillieSuitLightBlue", percent= 11 },
				{ class = "GhillieSuitPink", percent= 11 },
				{ class = "GhillieSuitPurple", percent= 11 },
				{ class = "GhillieSuitRed", percent= 11 },
				{ class = "GhillieSuitWhite", percent= 11 },
				{ class = "GhillieSuitYellow", percent= 11 },
			},
		},

		{
			category = "RandomGhillieHoodColored",
			classes = 
			{
				{ class = "GhillieHoodBlack", percent= 12 },
				{ class = "GhillieHoodBlue", percent= 11 },
				{ class = "GhillieHoodGreen", percent= 11 },
				{ class = "GhillieHoodLightBlue", percent= 11 },
				{ class = "GhillieHoodPink", percent= 11 },
				{ class = "GhillieHoodPurple", percent= 11 },
				{ class = "GhillieHoodRed", percent= 11 },
				{ class = "GhillieHoodWhite", percent= 11 },
				{ class = "GhillieHoodYellow", percent= 11 },
			},
		},

		{
			category = "GhillieSuit1Full",
			group =
			{
				{ class = "GhillieSuit1" },
				{ class = "GhillieHood1" },
			},
		},

		{
			category = "GhillieSuit2Full",
			group =
			{
				{ class = "GhillieSuit2" },
				{ class = "GhillieHood2" },
			},
		},

		{
			category = "GhillieSuit3Full",
			group =
			{
				{ class = "GhillieSuit3" },
				{ class = "GhillieHood3" },
			},
		},

		{
			category = "GhillieSuit4Full",
			group =
			{
				{ class = "GhillieSuit4" },
				{ class = "GhillieHood4" },
			},
		},

		{
			category = "RandomMilitaryBodyArmor",
			classes = 
			{
				{ class = "FlakVestTanCamo1", percent = 15 },
				{ class = "FlakVestGreen", percent = 55 },
				{ class = "FlakVestGreenCamo1", percent = 35 },
				{ class = "FlakVestTan", percent = 15 },
				{ class = "FlakVestBlack", percent = 5 },
				{ class = "FlakVestBlackWhite", percent = 5 },
				{ class = "FlakVestBlue", percent = 5 },
				{ class = "FlakVestLightBlue", percent = 5 },
				{ class = "FlakVestOGreen", percent = 5 },
				{ class = "FlakVestPink", percent = 5 },
				{ class = "FlakVestPurple", percent = 5 },
				{ class = "FlakVestRed", percent = 5 },
				{ class = "FlakVestWhite", percent = 5 },
				{ class = "FlakVestWhiteBlack", percent = 5 },
				{ class = "FlakVestYellow", percent = 5 },
			},
		},

		{
			category = "RandomPoliceBodyArmor",
			classes = 
			{
				{ class = "PoliceVestBlack", percent = 50 },
				{ class = "PoliceVestBlue", percent = 50 },
			},
		},

		{
			category = "RandomPoliceHelmet",
			classes = 
			{
				{ class = "SwatHelmet", percent = 12 },
				{ class = "SwatHelmetBlue", percent = 11 },
				{ class = "SwatHelmetGreen", percent = 11 },
				{ class = "SwatHelmetLightBlue", percent = 11 },
				{ class = "SwatHelmetPink", percent = 11 },
				{ class = "SwatHelmetPurple", percent = 11 },
				{ class = "SwatHelmetRed", percent = 11 },
				{ class = "SwatHelmetWhite", percent = 11 },
				{ class = "SwatHelmetYellow", percent = 11 },
			},
		},


		{
			category = "RandomNoSleevesVest",
			classes = 
			{
				{ class = "NoSleevesVestBlack", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestBlue", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestBrown", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestGreen", contents="RandomTorsoContents", percent = 17 },
				{ class = "NoSleevesVestRed", contents="RandomTorsoContents", percent = 16 },
				{ class = "NoSleevesVestTan", contents="RandomTorsoContents", percent = 16 },
			},
		},

		{
			category = "RandomSweater",
			classes = 
			{
				{ class = "Sweater", contents="RandomTorsoContents", percent = 10 },
				{ class = "SweaterBlack", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterBlue", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterChristmasGreen", contents="RandomTorsoContents", percent = 3 }, -- Christmas event
				{ class = "SweaterChristmasGreen2", contents="RandomTorsoContents", percent = 3 }, -- Christmas event
				{ class = "SweaterChristmasRed", contents="RandomTorsoContents", percent = 3 }, -- Christmas event
				{ class = "SweaterChristmasRed2", contents="RandomTorsoContents", percent = 3 }, -- Christmas event
				{ class = "SweaterGreen", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterOrange", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterPink", contents="RandomTorsoContents", percent = 15 },
				{ class = "SweaterRed", contents="RandomTorsoContents", percent = 15 },
			}

		},

		{
			category = "RandomTacticalVest",
			classes = 
			{
				{ class = "TacticalVestBlack", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestGreen", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestGreenCamo1",contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestGreenCamo2",contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestGreenCamo3",contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestGreenCamo4",contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestTan", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestTanCamo1", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestTanCamo2", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestTanCamo3", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestTanCamo4", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestUrbanCamo1", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestUrbanCamo2", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestUrbanCamo3", contents="RandomTorsoContents", percent = 20 },
				{ class = "TacticalVestUrbanCamo4", contents="RandomTorsoContents", percent = 20 },
			},
		},
		
		{
			category = "RandomTacticalVestPure",
			classes = 
			{
				{ class = "TacticalVestBlack", percent = 6 },
				{ class = "TacticalVestGreen", percent = 6 },
				{ class = "TacticalVestGreenCamo1", percent = 6 },
				{ class = "TacticalVestGreenCamo2", percent = 6 },
				{ class = "TacticalVestGreenCamo3", percent = 6 },
				{ class = "TacticalVestGreenCamo4", percent = 7 },
				{ class = "TacticalVestTan", percent = 7 },
				{ class = "TacticalVestTanCamo1", percent = 7 },
				{ class = "TacticalVestTanCamo2", percent = 7 },
				{ class = "TacticalVestTanCamo3", percent = 7 },
				{ class = "TacticalVestTanCamo4", percent = 7 },
				{ class = "TacticalVestUrbanCamo1", percent = 7 },
				{ class = "TacticalVestUrbanCamo2", percent = 7 },
				{ class = "TacticalVestUrbanCamo3", percent = 7 },
				{ class = "TacticalVestUrbanCamo4", percent = 7 },
			},
		},

		{
			category = "RandomTshirt",
			classes =
			{
				{ class = "TshirtAmalgamatedGreen", percent = 1 },
				{ class = "TshirtAmalgamatedGrey", percent = 1 },
				{ class = "TshirtAmalgamatedPink", percent = 1 },
				{ class = "TshirtAmalgamatedRed", percent = 1 },
				{ class = "TshirtBBGBlack", percent = 1 },
				{ class = "TshirtBBGBlue", percent = 1 },
				{ class = "TshirtBBGGreen", percent = 1 },
				{ class = "TshirtBBGGrey", percent = 1 },
				{ class = "TshirtBBGPink", percent = 1 },
				{ class = "TshirtBBGRed", percent = 1 },
				{ class = "TshirtCamo1", percent = 1 },
				{ class = "TshirtCamo2", percent = 2 },
				{ class = "TshirtCamo3", percent = 1 },
				{ class = "TshirtCamo4", percent = 1 },
				{ class = "TshirtCatBlack", percent = 1 },
				{ class = "TshirtCatBlue", percent = 1 },
				{ class = "TshirtCatGreen", percent = 1 },
				{ class = "TshirtCatGrey", percent = 1 },
				{ class = "TshirtCatPink", percent = 1 },
				{ class = "TshirtCatRed", percent = 1 },
				{ class = "TshirtCryengineBlack", percent = 1 },
				{ class = "TshirtCryengineBlue", percent = 1 },
				{ class = "TshirtCryengineGreen", percent = 1 },
				{ class = "TshirtCryengineGrey", percent = 1 },
				{ class = "TshirtCryenginePink", percent = 1 },
				{ class = "TshirtCryengineRed", percent = 1 },
				{ class = "TshirtEntradaBlack", percent = 1 },
				{ class = "TshirtEntradaBlue", percent = 1 },
				{ class = "TshirtEntradaGreen", percent = 1 },
				{ class = "TshirtEntradaGrey", percent = 1 },
				{ class = "TshirtEntradaPink", percent = 1 },
				{ class = "TshirtEntradaRed", percent = 1 },
				{ class = "TshirtFirefighterBlack", percent = 1 },
				{ class = "TshirtFirefighterBlue", percent = 1 },
				{ class = "TshirtFlipflopBlack", percent = 1 },
				{ class = "TshirtFlipflopBlue", percent = 1 },
				{ class = "TshirtFlipflopGreen", percent = 1 },
				{ class = "TshirtFlipflopGrey", percent = 1 },
				{ class = "TshirtFlipflopPink", percent = 1 },
				{ class = "TshirtFlipflopRed", percent = 1 },
				{ class = "TshirtKstarBlack", percent = 1 },
				{ class = "TshirtKstarBlue", percent = 1 },
				{ class = "TshirtKstarGreen", percent = 1 },
				{ class = "TshirtKstarGrey", percent = 1 },
				{ class = "TshirtKstarPink", percent = 1 },
				{ class = "TshirtKstarRed", percent = 1 },
				{ class = "TshirtMaskBlack", percent = 1 },
				{ class = "TshirtMaskBlue", percent = 1 },
				{ class = "TshirtMaskGreen", percent = 1 },
				{ class = "TshirtMaskGrey", percent = 1 },
				{ class = "TshirtMaskPink", percent = 1 },
				{ class = "TshirtMaskRed", percent = 1 },
				{ class = "TshirtNoImageBlack", percent = 1 },
				{ class = "TshirtNoImageBlue", percent = 1 },
				{ class = "TshirtNoImageGreen", percent = 1 },
				{ class = "TshirtNoImageGrey", percent = 1 },
				{ class = "TshirtNoImagePink", percent = 1 },
				{ class = "TshirtNoImageRed", percent = 1 },
				{ class = "TshirtNuclearBlack", percent = 1 },
				{ class = "TshirtNuclearBlue", percent = 1 },
				{ class = "TshirtNuclearGreen", percent = 1 },
				{ class = "TshirtNuclearGrey", percent = 1 },
				{ class = "TshirtNuclearPink", percent = 1 },
				{ class = "TshirtNuclearRed", percent = 1 },
				{ class = "TshirtPlebsiBlack", percent = 1 },
				{ class = "TshirtPlebsiBlue", percent = 1 },
				{ class = "TshirtPlebsiGreen", percent = 1 },
				{ class = "TshirtPlebsiGrey", percent = 1 },
				{ class = "TshirtPlebsiPink", percent = 1 },
				{ class = "TshirtPlebsiRed", percent = 1 },
				{ class = "TshirtPoliceBlack", percent = 1 },
				{ class = "TshirtPoliceBlue", percent = 1 },
				{ class = "TshirtPolycountBlack", percent = 1 },
				{ class = "TshirtPolycountBlue", percent = 1 },
				{ class = "TshirtPolycountGreen", percent = 1 },
				{ class = "TshirtPolycountGrey", percent = 2 },
				{ class = "TshirtPolycountPink", percent = 1 },
				{ class = "TshirtPolycountRed", percent = 1 },
				{ class = "TshirtSecurityBlack", percent = 1 },
				{ class = "TshirtSecurityBlue", percent = 1 },
				{ class = "TshirtSuckersBlack", percent = 1 },
				{ class = "TshirtSuckersBlue", percent = 1 },
				{ class = "TshirtSuckersGreen", percent = 1 },
				{ class = "TshirtSuckersGrey", percent = 1 },
				{ class = "TshirtSuckersPink", percent = 1 },
				{ class = "TshirtSuckersRed", percent = 1 },
				{ class = "TshirtTargetBlack", percent = 2 },
				{ class = "TshirtTargetBlue", percent = 2 },
				{ class = "TshirtTargetGreen", percent = 2 },
				{ class = "TshirtTargetGrey", percent = 2 },
				{ class = "TshirtTargetPink", percent = 1 },
				{ class = "TshirtTargetRed", percent = 1 },
				{ class = "TshirtAmalgamatedBlack", percent = 1 },
				{ class = "TshirtAmalgamatedBlue", percent = 1 },
			}
		},

		-- Neck
		{
			category = "RandomScarf",
			classes =
			{
				{ class = "ScarfBlack", percent = 10 },
				{ class = "ScarfCamo1", percent = 15 },
				{ class = "ScarfCamo2", percent = 10 },
				{ class = "ScarfCamo3", percent = 10 },
				{ class = "ScarfCamo4", percent = 10 },
				{ class = "ScarfGray", percent = 10 },
				{ class = "ScarfOrange", percent = 10 },
				{ class = "ScarfRed", percent = 10 },
				{ class = "ScarfShemagh", percent = 15 },
			}
		},

		-- --------------------------------------------------------------------
		-- RECIPE GUIDES
		-- --------------------------------------------------------------------

		{
			category = "RandomCraftingGuide",
			classes =
			{
				{ class = "guide_medical_bandages", percent = 5 },
				{ class = "guide_weapons_melee", percent = 5 },
				{ class = "guide_structures_tire_stacks", percent = 5 },
				{ class = "guide_structures_wood_bridges_1", percent = 4 },
				{ class = "guide_structures_wood_ramps_1", percent = 4 },
				{ class = "guide_structures_wood_stairs_1", percent = 4 },
				{ class = "guide_structures_wood_traps_2", percent = 4 },
				{ class = "guide_structures_wood_walkways_1", percent = 4 },
				{ class = "guide_structures_wood_walls_1", percent = 4 },
				{ class = "guide_structures_wood_roofs", percent = 4 },
				{ class = "guide_powered_parts_1", percent = 5 },
				{ class = "guide_traps_1", percent = 4 },
				{ class = "guide_structures_wood_bridges_2", percent = 4 },
				{ class = "guide_structures_wood_ramps_2", percent = 4 },
				{ class = "guide_structures_wood_stairs_2", percent = 4 },
				{ class = "guide_structures_wood_traps_1", percent = 4 },
				{ class = "guide_structures_wood_walkways_2", percent = 4 },
				{ class = "guide_structures_wood_walls_2", percent = 4 },
				{ class = "guide_traps_2", percent = 4 },
				{ class = "guide_structures_wood_curves", percent = 4 },
				{ class = "guide_structures_wood_gallows", percent = 4 },
				{ class = "guide_structures_wood_watchtower", percent = 4 },
				{ class = "guide_structures_wood_gatehouse", percent = 4 },
				{ class = "guide_weapons_ranged_1", percent = 4 },
				{ class = "guide_weapons_ranged_2", percent = 4 },
				{ class = "guide_weapons_ranged_3", percent = 4 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ class = "guide_ammo_1", percent = 5 },
				{ class = "guide_ammo_2", percent = 3 },
				{ class = "guide_ammo_3", percent = 1 },
				{ class = "guide_civilian", percent = 5 },
				{ class = "guide_police", percent = 4 },
				{ class = "guide_military", percent = 3 },
				{ class = "guide_hazmat", percent = 2 },
				{ class = "guide_special", percent = 1 },
				{ class = "guide_games", percent = 3 },
			},
		},
		
		{
			category = "RandomZombieGuide",
			classes =
			{
				{ class = "guide_medical_bandages", percent = 5 },
				{ class = "guide_weapons_melee", percent = 5 },
				{ class = "guide_structures_tire_stacks", percent = 5 },
				{ class = "guide_structures_wood_bridges_1", percent = 4 },
				{ class = "guide_structures_wood_ramps_1", percent = 4 },
				{ class = "guide_structures_wood_stairs_1", percent = 4 },
				{ class = "guide_structures_wood_traps_2", percent = 4 },
				{ class = "guide_structures_wood_walkways_1", percent = 4 },
				{ class = "guide_structures_wood_walls_1", percent = 4 },
				{ class = "guide_structures_wood_roofs", percent = 4 },
				{ class = "guide_powered_parts_1", percent = 5 },
				{ class = "guide_traps_1", percent = 4 },
				{ class = "guide_structures_wood_bridges_2", percent = 4 },
				{ class = "guide_structures_wood_ramps_2", percent = 4 },
				{ class = "guide_structures_wood_stairs_2", percent = 4 },
				{ class = "guide_structures_wood_traps_1", percent = 4 },
				{ class = "guide_structures_wood_walkways_2", percent = 4 },
				{ class = "guide_structures_wood_walls_2", percent = 4 },
				{ class = "guide_traps_2", percent = 4 },
				{ class = "guide_structures_wood_curves", percent = 4 },
				{ class = "guide_structures_wood_gallows", percent = 4 },
				{ class = "guide_structures_wood_watchtower", percent = 4 },
				{ class = "guide_structures_wood_gatehouse", percent = 4 },
				{ class = "guide_weapons_ranged_1", percent = 4 },
				{ class = "guide_weapons_ranged_2", percent = 4 },
				{ class = "guide_weapons_ranged_3", percent = 4 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ class = "guide_ammo_1", percent = 5 },
				{ class = "guide_ammo_2", percent = 3 },
				{ class = "guide_ammo_3", percent = 1 },
				{ class = "guide_civilian", percent = 4 },
				{ class = "guide_police", percent = 3 },
				{ class = "guide_military", percent = 2 },
				{ class = "guide_hazmat", percent = 2 },
				{ class = "guide_special", percent = 1 },
				{ class = "guide_games", percent = 2 },
			},
		},

		-- --------------------------------------------------------------------
		-- CONSUMABLES
		-- --------------------------------------------------------------------

		-- Refillables

		-- Drinks

		-- Food
		{
			category = "Egg",
			classes =
			{
				{ class = "EggChicken", percent = 100 },
			},
		},

		{
			category = "SaltAndPepper", -- basically cooking ingredients
			classes =
			{
				-- only salt for now pepper has no use
				-- Add more smaller spices and stuff like ketchup etc here

				{ class = "Salt", percent = 100 },
				-- { class = "Pepper", percent = 1 },
			},
		},

		-- --------------------------------------------------------------------
		-- CRAFTING
		-- --------------------------------------------------------------------
         
		-- --------------------------------------------------------------------
		-- EQUIPMENT
		-- --------------------------------------------------------------------

		{
			category = "RandomFireStarter",
			classes =
			{
				{ class = "Matches", percent = 90 },
				{ class = "Lighter", percent = 90 },
			},
		},

		{
			category = "StickPileOrThatch",
			classes =
			{
				{ class = "StickPile", percent = 30 },
				{ class = "Thatch", percent = 70 },
			},
		},

		{
			category = "RandomMaintenance",
			classes =
			{
				{ class = "CarBattery", percent = 35 },
				{ class = "TowCable", percent = 20 },
				{ class = "DriveBelt", percent = 35 },
				{ class = "DuctTape", percent = 20 },
				{ class = "ElectricalParts", percent = 12 },
				{ class = "Oil", percent = 20 },
				{ class = "SparkPlugs", percent = 35 },
				{ class = "WorkLight", percent = 11 },
			},
		},

		{
			category = "Wheel",
			classes =
			{
				{ class = "Wheel", percent = 100 },
			},
		},

		-- --------------------------------------------------------------------
		-- MEDICAL
		-- --------------------------------------------------------------------

		-- ====================================================================
		-- ADVANCED CATEGORIES
		-- ====================================================================

		-- contains all the parts needed to craft a backpack
		{
			category = "BackpackComponents",
			classes =
			{
				{ class = "Rope", percent = 50 },
				{ class = "Rags", percent = 65 },
			},
		},


		-- Back
		{
			category = "RandomBackpack",
			classes =
			{
				{ category = "BackpackComponents", percent = 40 },
				{ category = "RandomDuffelBag", percent = 15 },
				{ category = "RandomStowPack", percent = 50 },
				{ category = "RuggedPack", percent = 35 },
				{ category = "RandomRuckSack", percent = 30 },
			},
		},


		-- Eyes
		{
			category = "RandomEyes",
			classes =
			{
				{ class = "Aviators", percent = 15 },
				{ class = "EyepatchLeft", percent = 15 },
				{ class = "EyepatchRight", percent = 15 },
				{ class = "SunglassesABlack", percent = 7 },
				{ class = "SunglassesAGold", percent = 12 },
				{ class = "SunglassesASilver", percent = 7 },
				{ class = "SunglassesBBlack", percent = 15 },
				{ class = "SunglassesBMaroon", percent = 7 },
				{ class = "SunglassesBSilver", percent = 7 },
			},
		},


		-- Face
		{
			category = "RandomFace",
			classes =
			{
				{ category = "RandomBalaclava", percent = 16 },
				{ category = "RandomBandana", percent = 34 },
				{ class = "GasMask", percent = 4 },
				{ class = "DustMask", percent = 20 },
				{ class = "HeadSack", percent = 12 },
				{ class = "HockeyMask", percent = 20 },
				{ class = "HockeyMaskDp", percent = 15 },
				{ class = "HockeyMaskBlue", percent = 5 },
				{ class = "HockeyMaskBluePink", percent = 5 },
				{ class = "HockeyMaskGold", percent = 5 },
				{ class = "HockeyMaskGreen", percent = 5 },
				{ class = "HockeyMaskPurplePink", percent = 5 },
				{ class = "HockeyMaskSilver", percent = 5 },
			},
		},


		-- Feet
		{
			category = "RandomShoes",
			classes =
			{
				{ category = "RandomCombatBoots", percent = 40 },
				{ category = "RandomHitops", percent = 15 },
				{ category = "RandomSneakers", percent = 15 },
				{ category = "RandomSteeltoedBoots", percent = 35 },
				{ class = "CanvasShoes", percent = 5 },
				{ class = "FlipFlops", percent = 5 },
				{ class = "TennisShoes", percent = 5 },
			},
		},

		{
			category = "RandomMilitaryShoes",
			classes =
			{
				{ category = "RandomCombatBoots", percent = 65 },
				{ category = "RandomSteeltoedBoots", percent = 65 },
			},
		},

		{
			category = "RandomFeet",
			classes =
			{
				{ category = "RandomShoes", percent = 100 },
			},
		},


		-- Hands
		{
			category = "RandomHands",
			classes =
			{
				{ category = "RandomCamoGloves", percent = 20 },
				{ category = "RandomWoolGloves", percent = 80 },
			},
		},


		-- Hat
		{
			category = "RandomBeanie",
			classes =
			{
				{ class = "BeanieBrown", percent = 5 },
				{ class = "BeanieBrownWhite", percent = 20 },
				{ class = "BeanieGreenGreen", percent = 25 },
				{ class = "BeanieOrangeYellow", percent = 25 },
				{ class = "BeaniePinkPink", percent = 5 },
				{ class = "BeanieWhite", percent = 20 },
			},
		},

		{
			category = "RandomBeret",
			classes =
			{
				{ class = "BeretBlack", percent = 4 },
				{ class = "BeretBlackFlagAu", percent = 1 },
				{ class = "BeretBlackFlagBelgium", percent = 1 },
				{ class = "BeretBlackFlagCanada", percent = 2 },
				{ class = "BeretBlackFlagGermany", percent = 1 },
				{ class = "BeretBlackFlagIsrael", percent = 1 },
				{ class = "BeretBlackFlagUk", percent = 1 },
				{ class = "BeretBlackFlagUsa", percent = 2 },
				{ class = "BeretBlue", percent = 4 },
				{ class = "BeretBlueFlagAu", percent = 1 },
				{ class = "BeretBlueFlagBelgium", percent = 1 },
				{ class = "BeretBlueFlagCanada", percent = 1 },
				{ class = "BeretBlueFlagGermany", percent = 1 },
				{ class = "BeretBlueFlagIsrael", percent = 1 },
				{ class = "BeretBlueFlagUk", percent = 1 },
				{ class = "BeretBlueFlagUsa", percent = 1 },
				{ class = "BeretBrown", percent = 4 },
				{ class = "BeretBrownFlagAu", percent = 1 },
				{ class = "BeretBrownFlagBelgium", percent = 1 },
				{ class = "BeretBrownFlagCanada", percent = 1 },
				{ class = "BeretBrownFlagGermany", percent = 1 },
				{ class = "BeretBrownFlagIsrael", percent = 1 },
				{ class = "BeretBrownFlagUk", percent = 1 },
				{ class = "BeretBrownFlagUsa", percent = 1 },
				{ class = "BeretGreen", percent = 4 },
				{ class = "BeretGreenFlagAu", percent = 1 },
				{ class = "BeretGreenFlagBelgium", percent = 1 },
				{ class = "BeretGreenFlagCanada", percent = 1 },
				{ class = "BeretGreenFlagGermany", percent = 1 },
				{ class = "BeretGreenFlagIsrael", percent = 1 },
				{ class = "BeretGreenFlagUk", percent = 1 },
				{ class = "BeretGreenFlagUsa", percent = 1 },
				{ class = "BeretRed", percent = 4 },
				{ class = "BeretRedFlagAu", percent = 1 },
				{ class = "BeretRedFlagBelgium", percent = 1 },
				{ class = "BeretRedFlagCanada", percent = 1 },
				{ class = "BeretRedFlagGermany", percent = 1 },
				{ class = "BeretRedFlagIsrael", percent = 1 },
				{ class = "BeretRedFlagUk", percent = 1 },
				{ class = "BeretRedFlagUsa", percent = 1 },
				{ class = "BeretSkyBlue", percent = 4 },
				{ class = "BeretSkyBlueFlagAu", percent = 1 },
				{ class = "BeretSkyBlueFlagBelgium", percent = 1 },
				{ class = "BeretSkyBlueFlagCanada", percent = 1 },
				{ class = "BeretSkyBlueFlagGermany", percent = 1 },
				{ class = "BeretSkyBlueFlagIsrael", percent = 1 },
				{ class = "BeretSkyBlueFlagUk", percent = 1 },
				{ class = "BeretSkyBlueFlagUsa", percent = 1 },
				{ class = "BeretLightBlue", percent = 4 },
				{ class = "BeretOBlue", percent = 4 },
				{ class = "BeretOGreen", percent = 4 },
				{ class = "BeretORed", percent = 4 },
				{ class = "BeretPink", percent = 4 },
				{ class = "BeretPurple", percent = 4 },
				{ class = "BeretWhite", percent = 4 },
				{ class = "BeretYellow", percent = 4 },
			},
		},


		{
			category = "RandomBikeHelmet",
			classes =
			{
				{ class = "BikeHelmetBlack", percent = 10 },
				{ class = "BikeHelmetBlue", percent = 10 },
				{ class = "BikeHelmetGreen", percent = 10 },
				{ class = "BikeHelmetPink", percent = 10 },
				{ class = "BikeHelmetPurple", percent = 10 },
				{ class = "BikeHelmetRed", percent = 10 },
				{ class = "BikeHelmetWhite", percent = 20 },
				{ class = "BikeHelmetYellow", percent = 20 },
			},
		},

		{
			category = "RandomFlexCap",
			classes =
			{
				{ class = "flexcap_acfrontback_black", percent = 2 },
				{ class = "flexcap_acfrontback_blue", percent = 2 },
				{ class = "flexcap_acfrontback_camo1", percent = 2 },
				{ class = "flexcap_acfrontback_camo2", percent = 2 },
				{ class = "flexcap_acfrontback_camo3", percent = 2 },
				{ class = "flexcap_acfrontback_camo4", percent = 2 },
				{ class = "flexcap_aclogofrontacback_black", percent = 1 },
				{ class = "flexcap_aclogofrontacback_blue", percent = 2 },
				{ class = "flexcap_aclogofrontacback_camo1", percent = 1 },
				{ class = "flexcap_aclogofrontacback_camo2", percent = 1 },
				{ class = "flexcap_aclogofrontacback_camo3", percent = 1 },
				{ class = "flexcap_aclogofrontacback_camo4", percent = 1 },
				{ class = "flexcap_crytekfront_black", percent = 2 },
				{ class = "flexcap_crytekfront_brown", percent = 2 },
				{ class = "flexcap_crytekfront_camo1", percent = 1 },
				{ class = "flexcap_crytekfront_camo2", percent = 1 },
				{ class = "flexcap_crytekfront_camo3", percent = 1 },
				{ class = "flexcap_crytekfront_camo4", percent = 1 },
				{ class = "flexcap_dopefishfront_black", percent = 2 },
				{ class = "flexcap_dopefishfront_blue", percent = 2 },
				{ class = "flexcap_dopefishfront_green", percent = 2 },
				{ class = "flexcap_dopefishfront_orange", percent = 2 },
				{ class = "flexcap_dopefishfront_pink", percent = 2 },
				{ class = "flexcap_dopefishfront_red", percent = 2 },
				{ class = "flexcap_eilogo_black", percent = 2 },
				{ class = "flexcap_eilogo_blue", percent = 2 },
				{ class = "flexcap_eilogo_khaki", percent = 2 },
				{ class = "flexcap_eilogo_pink", percent = 2 },
				{ class = "flexcap_firefrontback_black", percent = 1 },
				{ class = "flexcap_firefrontback_blue", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo1", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo2", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo3", percent = 2 },
				{ class = "flexcap_flagfrontback_pink_camo4", percent = 2 },
				{ class = "flexcap_nobranding_black", percent = 2 },
				{ class = "flexcap_nobranding_blue", percent = 2 },
				{ class = "flexcap_nobranding_green", percent = 2 },
				{ class = "flexcap_nobranding_orange", percent = 2 },
				{ class = "flexcap_nobranding_pink", percent = 2 },
				{ class = "flexcap_nobranding_red", percent = 2 },
				{ class = "flexcap_policefrontback_black", percent = 2 },
				{ class = "flexcap_policefrontback_blue", percent = 2 },
				{ class = "flexcap_policefrontback_camo1", percent = 2 },
				{ class = "flexcap_policefrontback_camo2", percent = 2 },
				{ class = "flexcap_policefrontback_camo3", percent = 2 },
				{ class = "flexcap_policefrontback_camo4", percent = 2 },
				{ class = "flexcap_polycountfront_black", percent = 2 },
				{ class = "flexcap_polycountfront_blue", percent = 2 },
				{ class = "flexcap_polycountfront_pink", percent = 1 },
				{ class = "flexcap_usfrontback_black", percent = 1 },
				{ class = "flexcap_usfrontback_blue", percent = 1 },
				{ class = "flexcap_usfrontback_green", percent = 1 },
				{ class = "flexcap_usfrontback_orange", percent = 1 },
				{ class = "flexcap_usfrontback_pink", percent = 1 },
				{ class = "flexcap_usfrontback_red", percent = 1 },
				{ class = "flexcap_ausfront_camo4", percent = 1 },
				{ class = "flexcap_usfront_camo4", percent = 1 },
				{ class = "flexcap_gerfront_camo4", percent = 1 },
				{ class = "flexcap_belfront_camo4", percent = 1 },
				{ class = "flexcap_isrealfront_camo4", percent = 1 },
				{ class = "flexcap_canadafront_camo4", percent = 1 },
				{ class = "flexcap_gbfront_camo4", percent = 1 },
			 },
		},

		{
			category = "RandomFootballHelmet",
			classes =
			{
				{ class = "FootballHelmetFabulous", percent = 0.25 },
				{ class = "FootballHelmetAmerica", percent = 0.25 },
				{ class = "FootballHelmetGold", percent = 2 },
				{ class = "FootballHelmet", percent = 2 },
				{ class = "FootballHelmetBlack", percent = 7.5 },
				{ class = "FootballHelmetBlue", percent = 5 },
				{ class = "FootballHelmetRed", percent = 5 },
				{ class = "FootballHelmetStripedBlack", percent = 5 },
				{ class = "FootballHelmetStripedBlue", percent = 5 },
				{ class = "FootballHelmetStripedGreen", percent = 5 },
				{ class = "FootballHelmetStripedRed", percent = 5 },
				{ class = "FootballHelmetStripedTeal", percent = 5 },
				{ class = "FootballHelmetStripedYellow", percent = 5 },
				{ class = "FootballHelmetTeal", percent = 5 },
				{ class = "FootballHelmetWhiteStripedBlack", percent = 5 },
				{ class = "FootballHelmetWhiteStripedBlue", percent = 5 },
				{ class = "FootballHelmetWhiteStripedGreen", percent = 5 },
				{ class = "FootballHelmetWhiteStripedRed", percent = 5 },
				{ class = "FootballHelmetWhiteStripedTeal", percent = 5 },
				{ class = "FootballHelmetWhiteStripedYellow", percent = 5 },
				{ class = "FootballHelmetYellow", percent = 5 },
				{ class = "FootballHelmetGreen", percent = 8 },
			},
		},

		{
			category = "RandomFootballPads",
			classes =
			{
				{ class = "FootballPads", percent = 100 },
			},
		},

		{
			category = "RandomHeadband",
			classes =
			{
				{ class = "HeadbandBlack", percent = 34 },
				{ class = "HeadbandRed", percent = 33 },
				{ class = "HeadbandWhite", percent = 33 },
			},
		},

		{
			category = "RandomMotorcycleHelmet",
			classes =
			{
				{ class = "MotorcycleHelmetCarbon", percent = 45 },
				{ class = "MotorcycleHelmetGold", percent = 45 },
				{ class = "MotorcycleHelmetWhite", percent = 10 },
			},
		},

		{
			category = "RandomHat",
			classes =
			{
				{ category = "RandomBeanie", percent = 8 },
				{ category = "RandomBeret", percent = 10 },
				{ category = "RandomBikeHelmet", percent = 10 },
				{ category = "RandomCowboyHat", percent = 11 },
				{ category = "RandomFlexCap", percent = 8 },
				{ category = "RandomHeadband", percent = 11 },
				{ category = "RandomMotorcycleHelmet", percent = 6 },
				{ category = "RandomFootballHelmet", percent = 6 },
				{ class = "BandanaHat", percent = 6 },
				{ class = "BaseballCap", percent = 7 },
				{ class = "ChristmasHat", percent = 2 }, -- Christmas event
				{ class = "DorfmanPacific", percent = 10 },
				{ class = "WeldersMask", percent = 7 },
			},
		},


		-- Legs
		{
			category = "RandomLegs",
			classes =
			{
				{ category = "RandomBlueJeans2", percent = 10 },
				{ category = "RandomCargoPants", percent = 35 },
				{ category = "RandomCargoShorts", percent = 35 },
				{ category = "RandomTrackPants", percent = 15 },
				{ category = "RandomWandererPants", percent = 25 },
			},
		},


		-- Neck
		{
			category = "RandomNeck",
			classes =
			{
				{ category = "RandomScarf", percent = 45 },
				{ class = "NecklaceCrossChrome", percent = 10 },
				{ class = "ShoulderPadOneSide", percent = 10 },
				{ class = "ShoulderPadOneSideLeft", percent = 10 },
				{ class = "NecklaceCrossGold", percent = 10 },
				{ class = "NecklaceCrossSilver", percent = 15 },
				{ class = "GoldenCudgel2", percent = 10 }, 
			},
		},


		-- Torso
		{
			category = "RandomTorso",
			classes =
			{
				{ category = "RandomButtonUpShirt", percent = 8 },
				{ category = "RandomSweater", percent = 7 },
				{ category = "RandomCottonShirt", percent = 10 },
				{ category = "RandomHoodie", percent = 15 },
				{ category = "RandomFootballPads", percent = 5 },
				{ category = "RandomLeatherJacket", percent = 15 },
				{ category = "RandomNoSleevesVest", percent = 10 },
				{ category = "RandomTacticalVest", percent = 25 },
				{ category = "RandomTshirt", percent = 15 },
				{ category = "RandomRainJacket", percent = 5 },
				{ category = "RandomRainJacket", percent = 5 },
				{ category = "RandomPuffyJacket", percent = 5 },
			},
		},

		-- Waist
		{
			category = "RandomWaist",
			classes =
			{
				{ class = "FannyPackBlack", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackBlueOrange", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackCamo1", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackCamo2", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackCamo3", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackGray", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackGreenGray", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackMaroonGray", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackPurplePink", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackRed", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackRedBlue", contents="RandomWaistContents", percent = 20 },
				{ class = "FannyPackYellow", contents="RandomWaistContents", percent = 20 },
			},
		},


		-- Clothes
		{
			category = "RandomClothes",
			classes =
			{
				{ category = "RandomCraftingGuide", percent = 60 },
				{ category = "RandomChristmasPresent", percent = 2 }, -- Christmas event
				--{ category = "halloweenBagCommon", percent = 2 }, -- Halloween event
				--{ category = "RandomEggs", percent = 2 }, -- Easter event
				{ category = "RandomEyes", percent = 7 },
				{ category = "RandomFace", percent = 7 },
				{ category = "RandomHands", percent = 12 },
				{ category = "RandomHat", percent = 12 },
				{ category = "RandomLegs", percent = 15 },
				{ category = "RandomNeck", percent = 7 },
				{ category = "RandomShoes", percent = 10 },
				{ category = "RandomTorso", percent = 15 },
				{ category = "RandomWaist", percent = 4 },
			},
		},

		{
			category = "RandomCamoFace",
			classes =
			{
				{ class = "BandanaCamo1", percent = 25 },
				{ class = "BandanaCamo2", percent = 25 },
				{ class = "BandanaCamo3", percent = 25 },
				{ class = "BandanaCamo4", percent = 25 },
			},
		},

		{
			category = "RandomCamoHats",
			classes =
			{
				{ class = "BandanaHatCamo1", percent = 25 },
				{ class = "BandanaHatCamo2", percent = 25 },
				{ class = "BandanaHatCamo3", percent = 25 },
				{ class = "BandanaHatCamo4", percent = 25 },
			},
		},

		{
			category = "RandomCamoPants",
			classes =
			{
				{ class = "CargoPantsCamo1", contents="RandomLegsContents", percent = 25 },
				{ class = "CargoPantsCamo2", contents="RandomLegsContents", percent = 25 },
				{ class = "CargoPantsCamo3", contents="RandomLegsContents", percent = 25 },
				{ class = "CargoPantsCamo4", contents="RandomLegsContents", percent = 25 },
			},
		},

		{
			category = "RandomCamoShirts",
			classes =
			{
				{ class = "MilitaryJacketTanCamo1", contents="RandomTorsoContents", percent = 15 },
				{ class = "MilitaryJacketTanCamo2", contents="RandomTorsoContents", percent = 15 },
				{ class = "MilitaryJacketTanCamo3", contents="RandomTorsoContents", percent = 15 },
				{ class = "MilitaryJacketTanCamo4", contents="RandomTorsoContents", percent = 15 },
				{ class = "TshirtCamo1", percent = 15 },
				{ class = "TshirtCamo2", percent = 15 },
				{ class = "TshirtCamo3", percent = 5 },
				{ class = "TshirtCamo4", percent = 5 },
			},
		},

		{
			category = "RandomCamoGloves",
			classes =
			{
				{ class = "WoolGlovesCamo1", percent = 25 },
				{ class = "WoolGlovesCamo2", percent = 25 },
				{ class = "WoolGlovesCamo3", percent = 25 },
				{ class = "WoolGlovesCamo4", percent = 25 },
			},
		},

		{
			category = "RandomCamoClothes",
			classes =
			{
				{ category = "RandomCamoFace", percent = 20 },
				{ category = "RandomCamoGloves", percent = 20 },
				{ category = "RandomCamoHats", percent = 20 },
				{ category = "RandomCamoPants", percent = 20 },
				{ category = "RandomCamoShirts", percent = 20 },
			},
		},
		

		-- Skinned Weapons
		{
			category = "ACAWSkins",
			classes =
			{
				{ class = "ACAW_Ghillie", percent = 10 },
				{ class = "ACAW", percent = 90 },
			},
		},
		
		{
			category = "M50Skins",
			classes =
			{
				{ class = "M50_wood", percent = 10 },
				{ class = "M50", percent = 90 },
			},
		},


		-- Magazines/Rounds (with varying capacity/type)
		{
			category = "12GaugeAA12Mags",
			classes =
			{
				{ class = "12Gaugex8_Beanbag_AA12", percent = 1 },
				{ class = "12Gaugex8_Pellet_AA12", percent = 65 },
				{ class = "12Gaugex8_Slug_AA12", percent = 60 },
			},
		},

		{
			category = "12GaugeShells",
			classes =
			{
				{ class = "Pile_12GaugePellet", percent = 75 },
				{ class = "Pile_12GaugeSlug", percent = 65 },
			},
		},

		{
			category = "12GaugeShellsPolice",
			classes =
			{
				{ class = "Pile_12GaugeBeanbag", percent = 1 },
				{ class = "Pile_12GaugePellet", percent = 55 },
				{ class = "Pile_12GaugeSlug", percent = 50 },
			},
		},

		{
			category = "9mmMagazine",
			classes =
			{
				{ class = "9mmx10", percent = 89 },
				{ class = "9mmx19", percent = 75 },
				{ class = "9mmx33", percent = 65 },
			},
		},


		-- Weapons with Magazines/Rounds
		{
			category = "AA12WithMagazines",
			group =
			{
				{ category = "12GaugeAA12Mags" },
				{ class = "AA12" },
			},
		},
		
		{
			category = "AK74UWithMagazines",
			group =
			{
				{ class = "AK74U" },
				{ class = "545x30" },
			},
		},

		{
			category = "AKMWithMagazines",
			group =
			{
				{ class = "AKM" },
				{ class = "762x30" },
			},
		},

		{
			category = "AKMGoldWithMagazines",
			group =
			{
				{ class = "AKMGold" },
				{ class = "762x30" },
			},
		},

		{
			category = "AP85WithMagazines",
			group =
			{
				{ class = "AP85" },
				{ class = "9mmx19_ap85" },
			},
		},

		{
			category = "AT15WithMagazines",
			group =
			{
				{ class = "AT15" },
				{ class = "STANAGx30" },
				{ class = "IronsightKit" },
			},
		},

		{
			category = "BulldogWithMagazines",
			group =
			{
				{ class = "Bulldog" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "ColtPytonWithRounds",
			group =
			{
				{ class = "ColtPython" },
				{ class = "Pile_357" },
			},
		},

		{
			category = "ColtPythonGrimeyRickWithRounds",
			group =
			{
				{ class = "ColtPythonGrimeyRick" },
				{ class = "Pile_357" },
			},
		},

		{
			category = "CraftedBowWithMagazines",
			group =
			{
				{ class = "CraftedBow" },
				{ class = "Arrowx8" },
			},
		},

		{
			category = "CraftedPistolWithMagazines",
			group =
			{
				{ category = "9mmMagazine" },
				{ class = "CraftedPistol" },
			},
		},

		{
			category = "CraftedSMGWithMagazines",
			group =
			{
				{ category = "9mmMagazine" },
				{ class = "CraftedSMG" },
			},
		},

		{
			category = "CraftedRifleWithMagazines",
			group =
			{
				{ class = "CraftedRifleLong" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "CrossbowWithMagazines",
			group =
			{
				{ class = "Crossbow" },
				{ class = "Boltx5_0000" },
			},
		},

		{
			category = "FlareGunWithRounds",
			group =
			{
				{ class = "FlareGun" },
				{ class = "Pile_Flare" },
			},
		},

		{
			category = "G18PistolWithMagazines",
			group =
			{
				{ category = "9mmMagazine" },
				{ class = "G18Pistol" },
			},
		},

		{
			category = "HK45WithMagazines",
			group =
			{
				{ class = "hk45" },
				{ class = "acp_45x10_hk" },
			},
		},

		{
			category = "M16WithMagazines",
			group =
			{
				{ class = "M16" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "M1911WithMagazines",
			group =
			{
				{ class = "m1911a1" },
				{ class = "acp_45x7" },
			},
		},

		{
			category = "M40A5WithMagazines",
			group =
			{
				{ class = "M40A5" },
				{ class = "M40x5" },
			},
		},

		{
			category = "Mk18WithMagazines",
			group =
			{
				{ class = "Mk18" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "Mk18ReaverWithMagazines",
			group =
			{
				{ class = "Mk18Reaver" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "Model70WithRounds",
			group =
			{
				{ class = "Model70" },
				{ class = "Pile_223" },
			},
		},

		{
			category = "P350WithMagazines",
			group =
			{
				{ class = "P350" },
				{ class = "357x14" },
			},
		},

		{
			category = "PX4WithMagazines",
			group =
			{
				{ class = "PX4" },
				{ class = "acp_45x10_hk" },
			},
		},

		{
			category = "R90WithMagazines",
			group =
			{
				{ class = "R90" },
				{ class = "57x50" },
			},
		},

		{
			category = "CX4StormWithMagazines",
			group =
			{
				{ class = "CX4Storm" },
				{ class = "acp_45x20" },
			},
		},

		{
			category = "AUMP45WithMagazines",
			group =
			{
				{ class = "AUMP45" },
				{ class = "acp_45x30" },
			},
		},

		{
			category = "AkValWithMagazines",
			group =
			{
				{ class = "AKVal" },
				{ class = "762x20_Akval" },
			},
		},

		{
			category = "AK5DWithMagazines",
			group =
			{
				{ class = "AK5D" },
				{ class = "556x30_ak5d" },
			},
		},

		{
			category = "SAS12WithRounds",
			group =
			{
				{ class = "SAS12" },
				{ class = "Pile_12GaugePellet" },
			},
		},

		{
			category = "MAK10WithRounds",
			group =
			{
				{ class = "MAK10" },
				{ class = "9x19_mac10" },
			},
		},

		{
			category = "M97WithRounds",
			group =
			{
				{ class = "M97" },
				{ class = "Pile_40mmGrenade" },
			},
		},

		{
			category = "RecurveBowWithMagazines",
			group =
			{
				{ class = "RecurveBow" },
				{ class = "Arrowx8" },
			},
		},

		{
			category = "Rem700WithRounds",
			group =
			{
				{ class = "Rem700" },
				{ class = "Pile_308" },
			},
		},

		{
			category = "Rem870WithRounds",
			group =
			{
				{ category = "12GaugeShells" },
				{ class = "Rem870" },
			},
		},

		{
			category = "Ruger22WithMagazines",
			group =
			{
				{ class = "ruger22" },
				{ class = "22x10_ruger" },
			},
		},

		{
			category = "Sako85WithRounds",
			group =
			{
				{ class = "Sako_85" },
				{ class = "Pile_308" },
			},
		},

		{
			category = "Shotgun870TacticalWithMagazines",
			group =
			{
				{ category = "12GaugeShellsPolice" },
				{ class = "Shotgun870Tactical" },
				{ class = "IronsightKit" },
			},
		},

		{
			category = "Wasteland22WithRounds",
			group =
			{
				{ class = "Wasteland22" },
				{ class = "Pile_22" },
			},
		},

		{
			category = "TranquilizerGunWithDarts",
			group =
			{
				{ class = "TranquilizerGun" },
				{ class = "Pile_TranquilizerDart" },
			},
		},
		
		{
			category = "TazerWithMagazines",
			group =
			{
				{ class = "Tazer" },
				{ class = "Pile_Tazer" },
			},
		},

		{
			category = "M249WithMagazines",
			group =
			{
				{ class = "M249" },
				{ class = "556x100" },
			},
		},

		{
			category = "MP5WithMagazines",
			group =
			{
				{ class = "MP5" },
				{ class = "10mmx30" },
			},
		},

		{
			category = "KrissVWithMagazines",
			group =
			{
				{ class = "KrissV" },
				{ class = "10mmx15" },
			},
		},
		
		{
			category = "M14WithMagazines",
			group =
			{
				{ class = "m14" },
				{ class = "mag_m14" },
			},
		},
		
		{
			category = "MAC10WithMagazines",
			group =
			{
				{ class = "mac10" },
				{ class = "mac10_mag" },
			},
		},
		
		{
			category = "UZIWithMagazines",
			group =
			{
				{ class = "uzi" },
				{ class = "uzi_mag" },
			},
		},
		
		{
			category = "ScorpionWithMagazines",
			group =
			{
				{ class = "scorpion" },
				{ class = "scorpion_mag" },
			},
		},
		
		{
			category = "G36CWithMagazines",
			group =
			{
				{ class = "G36C" },
				{ class = "g36c_mag" },
			},
		},
		
		{
			category = "PeacemakerWithMagazines",
			group =
			{
				{ class = "Peacemaker" },
				{ class = "Pile_357" },
			},
		},
		
		{
			category = "Model1873WithMagazines",
			group =
			{
				{ class = "Model1873" },
				{ class = "Pile_357" },
			},
		},
				
		{
			category = "L1ARWithMagazines",
			group =
			{
				{ class = "L1AR" },
				{ class = "l1ar_mag" },
			},
		},
		
		{
			category = "SubjugatorWithMagazines",
			group =
			{
				{ class = "Subjugator" },
				{ class = "mag_m14" },
			},
		},
		
		{
			category = "DeagleWithMagazines",
			group =
			{
				{ class = "Deagle" },
				{ class = "deagle_mag" },
			},
		},
		
		{
			category = "JackalWithMagazines",
			group =
			{
				{ class = "Jackal" },
				{ class = "T1MicroJackal" },
				{ class = "9mmx33" },
			},
		},
		
		{
			category = "SCARWithMagazines",
			group =
			{
				{ class = "SCAR-H" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "M4A1WithMagazines",
			group =
			{
				{ class = "M4A1" },
				{ class = "STANAGx30" },
			},
		},
		
		{
			category = "M50WithMagazines",
			group =
			{
				{ category = "M50Skins" },
				{ class = "50calx7" },
			},
		},
		
		{
			category = "M16VietnamWithMagazines",
			group =
			{
				{ class = "M16Vietnam" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "VSSWithMagazines",
			group =
			{
				{ class = "VSS" },
				{ class = "762x20_Akval" },
			},
		},
		
		{
			category = "M4V5WithMagazines",
			group =
			{
				{ class = "M4V5" },
				{ class = "STANAGx30" },
			},
		},

		{
			category = "RPKWithMagazines",
			group =
			{
				{ class = "RPK" },
				{ class = "762x30" },
			},
		},
		
		{
			category = "HK416WithMagazines",
			group =
			{
				{ class = "HK416" },
				{ class = "STANAGx30" },
			},
		},
		
		-- Throwables
		{
			category = "RandomChemlight",
			classes =
			{
				{ class = "ChemlightBluePickup", percent = 20 },
				{ class = "ChemlightGreenPickup", percent = 20 },
				{ class = "ChemlightRedPickup", percent = 20 },
				{ class = "ChemlightWhitePickup", percent = 20 },
				{ class = "ChemlightYellowPickup", percent = 20 },
			},
		},

		{
			category = "RandomSmokeGrenade",
			classes =
			{
				{ class = "GrenadeGasSleepPickup", percent = 20 },
				{ class = "GrenadeSmokeGreenPickup", percent = 20 },
				{ class = "GrenadeSmokeMagentaPickup", percent = 20 },
				{ class = "GrenadeSmokeRedPickup", percent = 20 },
				{ class = "GrenadeSmokeWhitePickup", percent = 30 },
				{ class = "GrenadeSmokeYellowPickup", percent = 15 },
				
			},
		},

		{
			category = "RandomMilitaryGrenade",
			classes =
			{
				{ class = "FlashbangPickup", percent = 30 },
				{ class = "GrenadeGasNervePickup", percent = 20 },
				{ class = "GrenadeGasSleepPickup", percent = 20 },
				{ class = "GrenadeGasTearPickup", percent = 20 },
				{ class = "GrenadePickup", percent = 20 },
				{ class = "TrapLandminePacked", percent = 10 },
			},
		},

		-- Consumables
		{
			category = "RandomDrink",
			classes =
			{
				-- To reduce food/water in the world these only add up to 50%
				{ category = "RandomRottenVeggie", percent = 1 }, 
				{ category = "RandomSeeds", percent = 2 }, 
				{ category = "RandomAlcohol", percent = 2},
				{ class = "WaterPurificationTablets", percent = 6 },
				{ class = "CivCanteen01", percent = 4 },
				{ class = "CokeCan", percent = 7 },
				{ class = "DrPepperCan", percent = 7 },
				{ class = "EnergyDrinkCan", percent = 7 },
				{ class = "MilitaryCanteenPlastic", percent = 5 },
				{ class = "MilitaryCanteenMetal", percent = 5 },
				{ class = "PepsiCan", percent = 7 },
				{ class = "SpriteCan", percent = 7 },
				{ class = "TomatoJuiceCan", percent = 7 },
				{ class = "WaterBottle", percent = 10 },
			},
		},

		{
			category = "RandomAlcohol",
			classes =
			{
				{ class = "BeerCan", percent = 25 },
				{ class = "MiniBottleGin", percent = 25 },
				{ class = "MiniBottleVodka", percent = 25 },
				{ class = "MiniBottleWhiskey", percent = 25 },
			},
		},

		{
			category = "RandomFood",
			classes =
			{
				-- To reduce food/water in the world these only add up to 50%
				{ category = "RandomRottenVeggie", percent = 2 }, 
				{ category = "RandomSeeds", percent = 3 }, 
				{ category = "SaltAndPepper", percent = 2 },
				{ class = "BeefStew", percent = 2 },
				{ class = "CannedMeat", percent = 2 },
				{ class = "CerealBox", percent = 2 },
				{ class = "CornCan", percent = 2 },
				{ class = "DogFoodCan", percent = 3 },
				{ class = "HersheysBar", percent = 2 },
				{ class = "MRE", percent = 30 },
				{ class = "NutSpread", percent = 1 },
				{ class = "PeachesCan", percent = 3 },
				{ class = "PearsCan", percent = 2 },
				{ class = "PeasCan", percent = 3 },
				{ class = "RavioliCan", percent = 3 },
				{ class = "SoupCan", percent = 2 },
				{ class = "TunaCan", percent = 2 },
				--{ category = "RandomEggs", percent = 3 }, -- Easter event event
				--{ class = "ChocolateBox", percent = 3 }, -- Valentines event
				--{ class = "Champagne", percent = 3 }, -- Valentines event
				--{ class = "heart_balloon", percent = 3 }, -- Valentines event
				--{ category = "halloweenBagCommon", percent = 1 }, -- Halloween event
				{ category = "RandomChristmasPresent", percent = 1 }, -- Christmas event
			},
		},

		{
			category = "RandomVeggie",
			classes =
			{
				{ class = "Beets", percent = 1 },
				{ class = "BrushPeas", percent = 8 },
				{ class = "Pumpkin", percent = 16 },
				{ class = "Carrots", percent = 8 },
				{ class = "Potatoes", percent = 16 },
				{ class = "Radishes", percent = 19 },
				{ class = "SnapPeas", percent = 16 },
				{ class = "Tomatoes", percent = 16 },
			},
		},

		{
			category = "RandomRottenVeggie", 
			classes = 
			{
				{class = "BeetsRotten", percent = 6}, 
				{class = "AppleRotten", percent = 6}, 
				{class = "PumpkinRotten", percent = 13},
				{class = "BrushPeasRotten", percent = 13}, 
				{class = "CarrotsRotten", percent = 12}, 
				{class = "PotatoesRotten", percent = 12}, 
				{class = "RadishesRotten", percent = 13}, 
				{class = "SnapPeasRotten", percent = 13}, 
				{class = "TomatoesRotten", percent = 12}, 
			}, 
		}, 

		{
			category = "RandomConsumable", 
			classes = 
			{
				{category = "RandomDrink", percent = 50}, 
				{category = "RandomFood", percent = 50}, 
				{category = "RandomRottenVeggie", percent = 1}, 
				{category = "RandomVeggie", percent = 10},
				{category = "RandomSeeds", percent = 7}, 
			}, 
		}, 

		{
			category = "RandomRottenMeat", 
			classes = 
			{
				{class = "BearMeatRotten", percent = 10}, 
				{class = "ChickenRotten", percent = 40},
				{class = "DeerMeatSteakRotten", percent = 20}, 
				{class = "HamRotten", percent = 20}, 
				{class = "WolfMeatSteakRotten", percent = 10}, 
			}, 
		}, 

		{
			category = "RandomBurnedMeat", 
			classes = 
			{
				{class = "BearMeatBurned", percent = 10}, 
				{class = "ChickenBurned", percent = 40},
				{class = "DeerMeatSteakBurned", percent = 20}, 
				{class = "HamBurned", percent = 20}, 
				{class = "WolfMeatSteakBurned", percent = 10}, 
			}, 
		}, 


		-- Random Mushrooms in Caves
		{
			category = "RandomMushroom",
			classes =
			{
				{ class = "MushroomAntiRad", percent = 45 },
				{ class = "MushroomFood", percent = 45 },
				{ class = "MushroomHeal", percent = 45 },
			},
		},


		-- Medical
		{
			category = "RandomMedical",
			classes =
			{
				{ class = "AdrenalineSyringe", percent = 1 },
				{ class = "AntiradiationPills", percent = 20 },
				{ class = "PotassiumIodidePills", percent = 20 },
				{ class = "Antibiotics", percent = 20 },
				{ class = "Aspirin", percent = 1 },
				{ class = "Bandage", percent = 45 },
				{ class = "HeatPack", percent = 10 },
				{ class = "WaterPurificationTablets", percent = 1 },
				{ class = "Rags", percent = 10 },
				{ class = "RubbingAlcohol", percent = 1 },
				{ class = "Salt", percent = 1 },
			},
		},


		-- Tents
		{
			category = "RandomTent",
			classes =
			{
				{ category = "RandomEasyCampTent", percent = 30 },
				{ category = "RandomPupTent", percent = 30 },			
				{ category = "RandomTwoPersonTent", percent = 20 },
				{ category = "RandomTrekkingTent", percent = 15 },
				{ category = "RandomCampingTent", percent = 5 },
			},
		},

		{
			category = "RandomPupTent",
			classes =
			{
				{ class = "PackedPupTentBlue", percent = 15 },
				{ class = "PackedPupTentBrown", percent = 25 },
				{ class = "PackedPupTentGreen", percent = 25 },
				{ class = "PackedPupTentRed", percent = 10 },
				{ class = "PackedPupTentTan", percent = 25 },
			},
		},

		{
			category = "RandomCampingTent",
			classes =
			{
				{ class = "PackedCampingTentBlue", percent = 14 },
				{ class = "PackedCampingTentBrown", percent = 14 },
				{ class = "PackedCampingTentGreen", percent = 14 },
				{ class = "PackedCampingTentOrange", percent = 14 },
				{ class = "PackedCampingTentPurple", percent = 14 },
				{ class = "PackedCampingTentRed", percent = 15 },
				{ class = "PackedCampingTentYellow", percent = 15 },
			},
		},

		{
			category = "RandomEasyCampTent",
			classes =
			{
				{ class = "PackedEasyCampTentBlue", percent = 15 },
				{ class = "PackedEasyCampTentBrown", percent = 15 },
				{ class = "PackedEasyCampTentGreen", percent = 14 },
				{ class = "PackedEasyCampTentOrange", percent = 14 },
				{ class = "PackedEasyCampTentPurple", percent = 14 },
				{ class = "PackedEasyCampTentRed", percent = 14 },
				{ class = "PackedEasyCampTentYellow", percent = 14 },
			},
		},

		{
			category = "RandomTrekkingTent",
			classes =
			{
				{ class = "PackedTrekkingTentBlue", percent = 14 },
				{ class = "PackedTrekkingTentBrown", percent = 14 },
				{ class = "PackedTrekkingTentGreen", percent = 14 },
				{ class = "PackedTrekkingTentOrange", percent = 14 },
				{ class = "PackedTrekkingTentPurple", percent = 14 },
				{ class = "PackedTrekkingTentRed", percent = 15 },
				{ class = "PackedTrekkingTentYellow", percent = 15 },
			},
		},

		{
			category = "RandomTwoPersonTent",
			classes =
			{
				{ class = "PackedTwoPersonTentBlue", percent = 14 },
				{ class = "PackedTwoPersonTentBrown", percent = 14 },
				{ class = "PackedTwoPersonTentGreen", percent = 14 },
				{ class = "PackedTwoPersonTentOrange", percent = 14 },
				{ class = "PackedTwoPersonTentPurple", percent = 14 },
				{ class = "PackedTwoPersonTentRed", percent = 15 },
				{ class = "PackedTwoPersonTentYellow", percent = 15 },
			},
		},


		-- Incapacitation
		{
			category = "HandcuffsWithKey",
			group =
			{
				{ class = "PoliceHandcuffs" },
				{ class = "PoliceHandcuffKey" },
			},
		},

		{
			category = "RandomIncapacition",
			classes =
			{
				{ category = "HandcuffsWithKey", percent = 34 },
				{ class = "DuctTape", percent = 33 },
				{ class = "Rope", percent = 20 },
				{ class = "HeadSack", percent = 13 },
			},
		},


		-- Crafting
		{
			category = "RandomCrafting",
			classes =
			{
				--{ class = "CupidArrowx8", percent = 3 }, -- Valentines event
				--{ class = "flower_vase", percent = 3 }, -- Valentines event
				--{ class = "heart_candle", percent = 3 }, -- Valentines event
				--{ class = "heart_balloon", percent = 2 }, -- Valentines event
				{ category = "RandomChristmasPresent", percent = 2 }, -- Christmas event
				--{ category = "halloweenBagCommon", percent = 2 }, -- Halloween event
				--{ category = "RandomEggs", percent = 2 }, -- Easter event
				{ category = "RandomIncapacition", percent = 5 },
				{ category = "RandomPaintCan", percent = 4 },
				{ category = "RandomFireStarter", percent = 4 },
				{ class = "Amalgaduino", percent = 5 },
				{ class = "BarbedWireCoil", percent = 10 },
				{ class = "CamoNetting", percent = 7 },
				{ class = "DuctTape", percent = 6.9 },
				{ class = "ElectricalParts", percent = 25 },
				{ class = "EmptyBottle", percent = 6 },
				{ class = "Nails", percent = 20 },
				{ class = "PipeMetal", percent = 5 },
				{ class = "Rags", percent = 30 },
				{ class = "PropaneHeaterTop", percent = 7 },
				{ class = "Rope", percent = 15 },
				{ class = "SawBlade", percent = 15 },
				-- Waiting on https://entrada.atlassian.net/browse/MIS-3150
				-- { class = "SolarPanelPiece", percent = 4 },
				{ class = "TargetPaper", percent = 3 },
				{ class = "Tarp", percent = 15 },
				{ class = "WorkLight", percent = 15 },
				{ class = "Hacksaw", percent = 15 },
				{ class = "guide_civilian", percent = 3 },
			},
		},

		{
			category = "RandomPaintCan",
			classes =
			{
				{ class = "PaintCan_Aqua", percent = 8 },
				{ class = "PaintCan_Black", percent = 8 },
				{ class = "PaintCan_Blue", percent = 8 },
				{ class = "PaintCan_Brown", percent = 8 },
				{ class = "PaintCan_Gold", percent = 6 },
				{ class = "PaintCan_Green", percent = 8 },
				{ class = "PaintCan_Orange", percent = 8 },
				{ class = "PaintCan_Pink", percent = 8 },
				{ class = "PaintCan_Purple", percent = 8 },
				{ class = "PaintCan_Red", percent = 8 },
				{ class = "PaintCan_Silver", percent = 6 },
				{ class = "PaintCan_White", percent = 8 },
				{ class = "PaintCan_Yellow", percent = 8 },
			},
		},


		-- Forest stuff (that isnt actionable, so no sticks/rocks as those are now handled through awm)
		{
			category = "RandomForest",
			classes =
			{
				{ category = "RandomMushroom", percent = 100 },
			},
		},


		-- Fuel
		{
			category = "RandomFuel",
			classes =
			{
				{ class = "JerryCanDiesel", percent = 95 },
				{ class = "PropaneTank", percent = 25 },
				{ class = "small_generator", percent = 10 },
			},
		},


		-- Lubricant
		{
			category = "RandomLubricant",
			classes =
			{
				{ class = "Oil", percent = 100 },
			},
		},


		-- Gnomes
		{
			category = "RandomGnome",
			classes =
			{
				{ class = "guide_special", percent = 1 },
				{ class = "gnome_bronze", percent = 2 },
				{ class = "gnome_creep", percent = 19 },
				{ class = "gnome_gold", percent = 1 },
				{ class = "gnome_silver", percent = 2 },
				{ class = "gnome_standard_a", percent = 4 },
				{ class = "gnome_standard_b", percent = 4 },
				{ class = "gnome_standard_c", percent = 4 },
				{ class = "jerry", percent = 6 },
				{ class = "painting_landscape_01", percent = 4 },
				{ class = "painting_landscape_02", percent = 3 },
				{ class = "painting_landscape_03", percent = 3 },
				{ class = "painting_landscape_04", percent = 3 },
				{ class = "painting_landscape_05", percent = 3 },
				{ class = "painting_landscape_06", percent = 3 },
				{ class = "painting_landscape_07", percent = 3 },
				{ class = "painting_landscape_08", percent = 3 },
				{ class = "painting_landscape_09", percent = 3 },
				{ class = "painting_landscape_10", percent = 3 },
				{ class = "painting_square_01", percent = 4 },
				{ class = "painting_square_02", percent = 3 },
				{ class = "painting_vertical_landscape_01", percent = 3 },
				{ class = "painting_vertical_landscape_02", percent = 3 },
				{ class = "painting_vertical_landscape_03", percent = 3 },
				{ class = "painting_vertical_landscape_04", percent = 3 },
				{ class = "painting_vertical_landscape_05", percent = 3 },
				{ class = "painting_vertical_landscape_06", percent = 3 },
				{ class = "painting_map_canyonlands", percent = 3 },
				{ class = "poster_vertical_01", percent = 3 },
				{ class = "painting_map", percent = 5 },
				--{ category = "RandomEggs", percent = 3 }, -- Easter event 
				--{ class = "CupidArrowx8", percent = 3 }, -- Valentines event
				--{ class = "flower_vase", percent = 3 }, -- Valentines event
				--{ class = "heart_candle", percent = 3 }, -- Valentines event
				--{ class = "heart_balloon", percent = 3 }, -- Valentines event
				--{ category = "halloweenBagCommon", percent = 2 }, -- Halloween event
				{ category = "RandomChristmasPresent", percent = 2 }, -- Christmas event
			},
		},
		
		{
			category = "RandomPainting",
			classes =
			{
				{ class = "painting_landscape_01", percent = 5 },
				{ class = "painting_landscape_02", percent = 5 },
				{ class = "painting_landscape_03", percent = 5 },
				{ class = "painting_landscape_04", percent = 5 },
				{ class = "painting_landscape_05", percent = 5 },
				{ class = "painting_landscape_06", percent = 5 },
				{ class = "painting_landscape_07", percent = 5 },
				{ class = "painting_landscape_08", percent = 5 },
				{ class = "painting_landscape_09", percent = 5 },
				{ class = "painting_landscape_10", percent = 5 },
				{ class = "painting_square_01", percent = 5 },
				{ class = "painting_square_02", percent = 5 },
				{ class = "painting_vertical_landscape_01", percent = 5 },
				{ class = "painting_vertical_landscape_02", percent = 5 },
				{ class = "painting_vertical_landscape_03", percent = 5 },
				{ class = "painting_vertical_landscape_04", percent = 5 },
				{ class = "painting_vertical_landscape_05", percent = 5 },
				{ class = "painting_vertical_landscape_06", percent = 5 },
				{ class = "painting_map_canyonlands", percent = 5 },
				{ class = "poster_vertical_01", percent = 5 },
				{ class = "painting_map", percent = 5 },
			},
		},

		-- Basebuilding Items
		{
			category = "RandomBPart", 
			classes =
			{
				{ category = "RandomCampingBPart", percent = 99 },
				{ category = "RandomGnome", percent = 1 },
			},
		},

		-- Camping basebuilding Items
		
		{
			category = "RandomCampingBPart", 
			classes =
			{
				{ class = "camping_chair", percent = 20 },
				{ class = "propane_heater", percent = 20 },
				{ class = "camping_lantern", percent = 30 },
				{ class = "HeatPack", percent = 20 },
				{ class = "camping_pop_up_canopy", percent = 15 },
				{ class = "camping_table", percent = 15 },
				{ class = "camping_water_jug", percent = 14 },
				{ category = "RandomTent", percent = 1 },
			},
		},

		-- ====================================================================
		-- MORE ADVANCED CATEGORIES
		-- ====================================================================

		{
			category = "RandomExplosiveBarrel",
			classes =
			{
				{ class = "ExplosiveOilBarrel", percent = 100 },
			},
		},

		{
			category = "RandomExplosivePropaneTank",
			classes =
			{
				{ class = "PropaneTank", percent = 100 },
			},
		},

		{
			category = "RandomMelee",
			classes =
			{
				{ category = "RandomCamoClothes", percent = 6 },
				{ category = "RandomFlashlight", percent = 5 },
				{ class = "Axe", percent = 30 },
				{ class = "AxePatrick", percent = 10 },
				{ class = "BaseballBat", percent = 10 },
				{ class = "BaseballBatNails", percent = 7 },
				{ class = "BaseballBatSawBlade", percent = 5 },
				{ class = "BaseballBatSawBladeNails", percent = 5 },
				{ class = "BaseballBatScrapNails", percent = 5 },
				{ class = "BaseballBatHerMajesty", percent = 5 },
				{ class = "Cleaver", percent = 7 },
				{ class = "Crowbar", percent = 7 },
				{ class = "Guitar", percent = 10 },
				{ class = "Hammer", percent = 15 },
				{ class = "Hatchet", percent = 30 },
				{ class = "HuntingKnife", percent = 10 },
				{ class = "Katana", percent = 7 },
				{ class = "KatanaBlackWidow", percent = 3 },
				{ class = "LugWrench", percent = 8 },
				{ class = "Machete", percent = 10 },
				{ class = "StunBaton", percent = 10 },
				{ class = "MannequinArm", percent = 1 },
				{ class = "Pickaxe", percent = 30 },
				{ class = "PipeWrench", percent = 1 },
				{ class = "PoliceBaton", percent = 10 },
				{ class = "SurvivalKnife", percent = 10 },
				{ class = "TrapBearTrapPacked", percent = 5 },
				{ class = "Icepickaxe", percent = 4 },
			},
		},

		{
			category = "RandomSqueegee",
			classes =
			{
				{ class = "Squeegee", percent = 100 },
			},
		},

		-- largly based on random ranged weapon, rest from crafted
		{
			category = "RandomWeaponRepairKit",
			classes =
			{
				{ class = "RK_MeleePrimary", percent = 75 },
				{ class = "RK_MeleeSecondary", percent = 75 },
				{ class = "RK_Icepickace", percent = 33 },
				{ class = "RK_ClothingHelmet", percent = 20 },
				{ class = "RK_FlareGun", percent = 10 },
				{ class = "RK_TranquilizerGun", percent = 5 },
				{ class = "RK_Bows", percent = 5 },
				{ class = "RK_Handguns", percent = 80 },
				{ class = "RK_Shotguns", percent = 60 },
				{ class = "RK_SubMachineguns", percent = 40 },
				{ class = "RK_AssaultRifles", percent = 20 },
				{ class = "RK_LightMachineguns", percent = 15 },
				{ class = "RK_MarksmanRifles", percent = 10 },
				{ class = "RK_SniperRifles", percent = 5 },
				{ class = "RK_Kevlar", percent = 20 },
				{ class = "RK_M50", percent = 0.5 },
				{ class = "RK_RocketLauncher", percent = 0.5 },
				{ class = "RK_M97", percent = 0.5 },
			},
		},

		{
			category = "RandomNormalRepairKit",
			classes =
			{
				{ class = "RK_Canvas", percent = 20 },
				{ class = "RK_Cloth", percent = 38 },
				{ class = "RK_ClothingHelmet", percent = 10 },
				--{ class = "RK_ClothingHelmetBallistic", percent = 2 }, --Disabled due to Kevlar Repair Kit.
				{ class = "RK_Equipment", percent = 10 },
				{ class = "RK_Leather", percent = 15 },
				{ class = "RK_Teflon", percent = 5 },
			},
		},

		{
			category = "RandomCraftedWeaponPure",
			classes = 
			{
				{ class = "CraftedBow", percent = 17 },
				{ class = "CraftedPistol", percent = 17 },
				{ class = "CraftedRifleLong", percent = 10 },
				{ class = "CraftedSMG", percent = 5 },
				{ class = "CraftedLongPistol", percent = 12 },
				{ class = "CraftedPistol556", percent = 9 },
				{ class = "CraftedRifle9mm", percent = 5 },
				{ class = "CraftedShortRifle556", percent = 5 },
				{ class = "CraftedShortShotgun", percent = 10 },
				{ class = "CraftedShotgun", percent = 10 },
			},
		},

		{
			category = "RandomRangedPure",
			classes =
			{
				-- { category = "RandomCraftedWeaponPure", percent= 8 },
				{ category = "ACAWSkins", percent = 0.5 },
				{ class = "AA12", percent = 0.1 },
				{ class = "AK74U", percent = 1.5 },
				{ class = "AKM", percent = 1 },
				{ class = "AKMGold", percent = 0.01 },
				{ class = "AP85", percent = 1 },
				{ class = "AT15", percent = 2 },
				{ class = "AUMP45", percent = 0.9 },
				{ class = "Bulldog", percent = 1 },
				{ class = "ColtPython", percent = 6.9 },
				{ class = "ColtPythonGrimeyRick", percent = 0.1 },
				{ class = "CraftedBow", percent = 0.5 },
				{ class = "CraftedPistol", percent = 0.5 },
				{ class = "CraftedRifleLong", percent = 0.5 },
				{ class = "CraftedSMG", percent = 0.5 },
				{ class = "CraftedLongPistol", percent = 1 },
				{ class = "CraftedPistol556", percent = 1 },
				{ class = "CraftedRifle9mm", percent = 1 },
				{ class = "CraftedShortRifle556", percent = 1 },
				{ class = "CraftedShortShotgun", percent = 1 },
				{ class = "CraftedShotgun", percent = 1 },
				{ class = "Crossbow", percent = 3 },
				{ class = "CX4Storm", percent = 0.8 },
				{ class = "FlareGun", percent = 2 },
				{ class = "G18Pistol", percent = 4 },
				{ class = "hk45", percent = 4 },
				{ class = "KrissV", percent = 1 },
				{ class = "M16", percent = 1.5 },
				{ class = "m1911a1", percent = 6 },
				{ class = "M249", percent = 0.01 },
				{ class = "M40A5", percent = 0.48 },
				{ class = "M9A1", percent = 0.5 },
				{ class = "Makarov", percent = 0.5 },
				{ class = "Mk18", percent = 1.48 },
				{ class = "Mk18Reaver", percent = 0.02 },
				{ class = "Model70", percent = 1 },
				{ class = "MP5", percent = 2 },
				{ class = "P350", percent = 1 },
				{ class = "PX4", percent = 1 },
				{ class = "R90", percent = 0.6 },
				{ class = "RecurveBow", percent = 4 },
				{ class = "Rem700", percent = 4.5 },
				{ class = "Rem870", percent = 6 },
				{ class = "ruger22", percent = 5 },
				{ class = "Sako_85", percent = 2 },
				{ class = "Shotgun870Tactical", percent = 4 },
				{ class = "TranquilizerGun", percent = 3 },
				{ class = "Wasteland22", percent = 3.9 },
				{ class = "AKVal", percent = 3 },
				{ class = "SAS12", percent = 3 },
				{ class = "MAK10", percent = 3 },
				{ class = "AK5D", percent = 3 },
				{ class = "M97", percent = 0.8 },
			},
		},
		
		{
			category = "RandomRangedCivilianPure",
			classes =
			{
				{ class = "AT15", percent = 7 },
				{ class = "Crossbow", percent = 6 },
				{ class = "CX4Storm", percent = 6 },
				{ class = "Model70", percent = 1 },
				{ class = "RecurveBow", percent = 6 },
				{ class = "Rem700", percent = 7 },
				{ class = "Rem870", percent = 6 },
				{ class = "Sako_85", percent = 7 },
				{ class = "m14", percent = 7 },
				{ class = "Shotgun870Tactical", percent = 7 },
				{ class = "Wasteland22", percent = 1 },
				{ class = "AA12", percent = 2 },
				{ class = "SAS12", percent = 5 },
				{ class = "AK5D", percent = 5 },
				{ class = "MAK10", percent = 3 },
				{ category = "RandomAccessory", percent = 6 },	
			},
		},
		
		{
		    category = "RandomRangedMilitaryPure",
			classes =
			{
				{ category = "ACAWSkins", percent = 3 },
				{ class = "AA12", percent = 3 },
				{ class = "AK74U", percent = 3 },
				{ class = "AKM", percent = 3 },
				{ class = "AT15", percent = 4 },
				{ class = "AUMP45", percent = 3 },
				{ class = "Bulldog", percent = 3 },
				{ class = "CX4Storm", percent = 3 },
				{ class = "KrissV", percent = 3 },
				{ class = "M16", percent = 4 },
				{ class = "M249", percent = 5 },
				{ class = "M40A5", percent = 4 },
				{ class = "Mk18", percent = 4 },
				{ class = "MP5", percent = 3 },
				{ class = "R90", percent = 3 },
				{ class = "Shotgun870Tactical", percent = 3 },
				{ class = "AKMGold", percent = 1 },
				{ class = "ColtPythonGrimeyRick", percent = 1 },
				{ class = "Mk18Reaver", percent = 1 },
				{ class = "M4A1", percent = 6 },
				{ class = "SCAR-H", percent = 4 },
				{ class = "G36C", percent = 6 },
				{ class = "AKVal", percent = 5 },
				{ class = "SAS12", percent = 5 },
				{ class = "AK5D", percent = 5 },
				{ class = "MAK10", percent = 5 },
				{ class = "M97", percent = 2 },
				{ class = "M16Vietnam", percent = 4 },
				{ class = "VSS", percent = 4 },
				{ class = "M4V5", percent = 3 },
				{ class = "RPK", percent = 3 },
				{ class = "HK416", percent = 4 },
				{ category = "RandomAccessory", percent = 3 },
				{ class = "RocketLauncherNew", percent = 1 },
			},
		},
		
		{
		    category = "RandomRangedPolicePure",
			classes =
			{
				{ category = "ACAWSkins", percent = 8 },
				{ class = "AT15", percent = 8 },
				{ class = "AUMP45", percent = 8 },
				{ class = "CX4Storm", percent = 4 },
				{ class = "MP5", percent = 6 },
				{ class = "R90", percent = 6 },
				{ class = "Shotgun870Tactical", percent = 6 },
				{ class = "AKMGold", percent = 3 },
				{ class = "AK74U", percent = 5 },
				{ class = "ColtPythonGrimeyRick", percent = 5 },
				{ class = "Mk18Reaver", percent = 5 },
				{ class = "G36C", percent = 2 },
				--{ class = "mac10", percent = 6 }, -- Disabled for new MAK10
				{ class = "uzi", percent = 7 },
				{ class = "MAK10", percent = 6 },
				{ class = "scorpion", percent = 6 },
				{ class = "AKVal", percent = 6 },
				{ class = "M4V5", percent = 2 },
				{ class = "SAS12", percent = 6 },				
				{ class = "AK5D", percent = 5 },
				{ class = "M97", percent = 1 },
				{ class = "HK416", percent = 2 },
				{ category = "RandomAccessory", percent = 3 },
			},
		},
		
		{
		    category = "RandomMilitaryArmor",
			classes =
			{
				{ class = "FlakVestGreen", percent = 35 },
				{ class = "FlakVestGreenCamo1", percent = 35 },
				{ class = "FlakVestTan", percent = 35 },
				{ class = "FlakVestTanCamo1", percent = 35 },
				{ class = "ArmoredGhillieSuit", percent = 1.5 },
				{ class = "ArmoredGhillieHood", percent = 1.5 },
			},
		},
		
		{
		    category = "RandomPoliceArmor",
			classes =
			{
				{ class = "PoliceVestBlack", percent = 50 },
				{ class = "PoliceVestBlue", percent = 50 },
			},
		},

		{
			category = "RandomRanged",
			classes =
			{
				{ category = "RandomRangedPure", percent = 90 },
				--{ category = "RandomWeaponRepairKit", percent = 10 },
				{ category = "RandomCamoClothes", percent = 10 },
			},
		},

		{
			category = "RandomPistol",
			classes =
			{
				{ class = "ColtPython", percent = 8 },
				{ class = "ColtPythonGrimeyRick", percent = 1 },
				{ class = "FlareGun", percent = 6 },
				{ class = "G18Pistol", percent = 8 },
				{ class = "hk45", percent = 9 },
				{ class = "ruger22", percent = 8 },
				{ class = "Makarov", percent = 9 },
				{ class = "M9A1", percent = 9 },
				{ class = "m1911a1", percent = 9 },
				{ class = "PX4", percent = 9 },
				{ class = "P350", percent = 9 },
				{ class = "AP85", percent = 9 },
				{ category = "JackalWithMagazines", percent = 2 },
				{ category = "DeagleWithMagazines", percent = 1 },
				
			},
		},

		{
			category = "RandomAccessory",
			classes =
			{
				{ category = "CamoHuntingScope", percent = 4 },
				{ class = "LaserSight", percent = 9 },
				{ class = "LaserSightGreen", percent = 5 },
				{ class = "LaserSightBlue", percent = 5 },
				{ category = "CamoOpticScope", percent = 9 },
				{ class = "OpticScopeBow", percent = 5 },
				{ class = "PistolSilencer", percent = 3 },
				{ class = "ReflexSight", percent = 9 },
				{ class = "T1Micro", percent = 9 },
				{ class = "ReflexSightBow", percent = 4 },
				{ category = "CamoSilencer", percent = 2 },
				{ class = "ForegripVertical", percent = 4 },
				{ class = "BayonetRifle", percent = 6 },
				{ class = "IronsightKit", percent = 6 },
				{ class = "ReddotSight", percent = 10 },
				{ class = "FlashlightMounted", percent = 7 },
				{ class = "OPKSight", percent = 3 },
				{ class = "R3Sight", percent = 3 },
				{ class = "PSOScope", percent = 2 },
				{ class = "ext_762x30", percent = 3 },
				{ class = "ext_556x75", percent = 1 },
				{ class = "ext_762x75", percent = 1 },
				{ class = "akval_drummag_75rnd", percent = 1 },
				{ class = "g36c_drummag_100rnd", percent = 2 },
				{ class = "l1ar_drummag_50rnd", percent = 2 },
				{ class = "m14_drummag_50rnd", percent = 1 },
			},
		},
		
		{
			category = "RandomEggs",
			classes =
			{
				{ class = "EggBlue", percent = 43, min = 1, max = 5 },
				{ class = "EggGreen", percent = 33, min = 1, max = 5 },
				{ class = "EggPink", percent = 24, min = 1, max = 5 },
			},
		},

		{
			category = "RandomAmmo",
			classes =
			{
				{ category = "12GaugeAA12Mags", percent = 10 },
				{ category = "12GaugeShells", percent = 10 },
				{ category = "9mmMagazine", percent = 15 },
				{ category = "RandomAccessory", percent = 10 },
				{ category = "RandomChemlight", percent = 1 },
				{ category = "RandomSmokeGrenade", percent = 5 },
				{ category = "RandomRockets", percent = 3 },
				{ class = "545x30", percent = 7 },
				{ class = "57x50", percent = 4 },
				{ class = "762x5", percent = 7 },
				{ class = "9mmx10_makarov", percent = 2 },
				{ class = "9mmx15_m9a1", percent = 2 },
				{ class = "9mmx19_ap85", percent = 2 },
				{ class = "acp_45x20", percent = 1 },
				{ class = "acp_45x30", percent = 7 },
				{ class = "10mmx15", percent = 40 },
				{ class = "10mmx30", percent = 40 },
				{ class = "22x10_ruger", percent = 1 },
				{ class = "acp_45x10_hk", percent = 2 },
				{ class = "acp_45x7", percent = 2 },
				{ class = "762x30", percent = 60 },
				{ class = "Arrowx8", percent = 8 },
				-- { class = "CupidArrowx8", percent = 2.5 }, -- valentines
				{ class = "Boltx5_0000", percent = 3 },
				{ class = "M40x5", percent = 7 },
				{ class = "556x150", percent = 15 },
				{ class = "Pile_10mm", percent = 7 },
				{ class = "Pile_22", percent = 2 },
				{ class = "Pile_545x39", percent = 2 },
				{ class = "Pile_57x28", percent = 7 },
				{ class = "Pile_223", percent = 2 },
				{ class = "Pile_308", percent = 7 },
				{ class = "Pile_357", percent = 7 },
				{ class = "Pile_45ACP", percent = 10 },
				{ class = "Pile_556x45", percent = 60 },
				{ class = "Pile_762x39", percent = 60 },
				{ class = "Pile_762x51", percent = 20 },
				{ class = "Pile_9mm", percent = 30 },
				{ class = "Pile_Flare", percent = 1 },
				{ class = "Pile_TranquilizerDart", percent = 5 },
				{ class = "STANAGx30", percent = 40 },
				{ class = "STANAGx40", percent = 60 },
				{ class = "50calx7", percent = 3 },
				{ class = "l1ar_mag", percent = 12 },
				{ class = "g36c_mag", percent = 10 },
				{ class = "Pile_50cal", percent = 3 },
				{ class = "mag_m14", percent = 8 },
				{ class = "762x40", percent = 60 },
				{ class = "GrenadePickup", percent = 10 },
				{ class = "guide_ammo_1", percent = 2 },
				{ class = "guide_ammo_2", percent = 2 },
				{ class = "guide_ammo_3", percent = 2 },
				{ class = "guide_explosives_1", percent = 1 },
				{ class = "guide_explosives_2", percent = 1 },
				{ class = "C4TimedPickup", percent = 0.75, min = 1, max = 1 },
				{ class = "BioFuel", percent = 7, min = 20, max = 40 },
				{ class = "556x30_ak5d", percent = 15 },
				{ class = "762x20_Akval", percent = 15 },
				{ class = "9x19_mac10", percent = 15 },
				{ class = "Pile_40mmGrenade", percent = 0.75, min = 1, max = 1 },
				{ class = "Pile_40mmIncendiaryGrenade", percent = 0.75, min = 1, max = 1 },
				{ category = "Random40mmTacticalGrenades", percent = 1.5, min = 1, max = 1 },
				{ category = "Random40mmSmokeGrenades", percent = 2, min = 1, max = 1 },
				{ class = "l1ar_mag_30rnd", percent = 6 },
				{ class = "mag_m14_30rnd", percent = 4 },
				{ class = "g36c_mag_40rnd", percent = 4 },
				{ class = "556x40_ak5d", percent = 7 },
				{ class = "762x30_Akval", percent = 2 },
				{ class = "9x19_mac10_40rnd", percent = 10 },
				{ class = "ext_762x30", percent = 3 },
				{ class = "ext_556x75", percent = 2 },
				{ class = "ext_762x75", percent = 2 },
				{ class = "akval_drummag_75rnd", percent = 3 },
				{ class = "g36c_drummag_100rnd", percent = 2 },
				{ class = "l1ar_drummag_50rnd", percent = 2 },
				{ class = "m14_drummag_50rnd", percent = 2 },
				{ class = "Mk18Reaver", percent = 2 },
				{ class = "SalazarSkull", percent = 1 },
				{ class = "SniperScope32", percent = 2 },
				{ class = "3xScope", percent = 3 },
				{ class = "Pile_Tazer", percent = 5 },
			},
		},

		{
			category = "RandomRockets",
			classes =
			{
				{ class = "Pile_Rocket", percent = 50 },
				{ class = "Pile_Rocket_HE", percent = 15 },
				{ class = "Pile_Rocket_AP", percent = 35 },
			},
		},
		
		{
			category = "Random40mmSmokeGrenades",
			classes =
			{
				{ class = "Pile_40mmSmokeGrenadeGreen", percent = 20 },
				{ class = "Pile_40mmSmokeGrenadeMagenta", percent = 20 },
				{ class = "Pile_40mmSmokeGrenadeRed", percent = 20 },
				{ class = "Pile_40mmSmokeGrenadeWhite", percent = 20 },
				{ class = "Pile_40mmSmokeGrenadeYellow", percent = 20 },
			},
		},
		
		{
			category = "Random40mmTacticalGrenades",
			classes =
			{
				{ class = "Pile_40mmNerveGrenade", percent = 20 },
				{ class = "Pile_40mmSleepGrenade", percent = 25 },
				{ class = "Pile_40mmTearGrenade", percent = 40 },
				{ class = "Pile_40mmFlashBangGrenade", percent = 15 },
			},
		},

		{
			category = "RandomWeaponWithMagsPure",
			classes =
			{
				{ category = "AA12WithMagazines", percent = 5},
				{ category = "AK74UWithMagazines", percent = 30 },
				{ category = "AKMWithMagazines", percent = 25 },
				{ category = "AP85WithMagazines", percent = 5 },
				{ category = "AT15WithMagazines", percent = 15 },
				{ category = "BulldogWithMagazines", percent = 5 },
				{ category = "ColtPytonWithRounds", percent = 5 },
				{ category = "CraftedPistolWithMagazines", percent = 5 },
				{ category = "CraftedSMGWithMagazines", percent = 7 },
				{ category = "CraftedBowWithMagazines", percent = 5 },
				{ category = "CraftedRifleWithMagazines", percent = 7 },
				{ category = "CrossbowWithMagazines", percent = 4 },
				{ category = "FlareGunWithRounds", percent = 3 },
				{ category = "G18PistolWithMagazines", percent = 8 },
				{ category = "HK45WithMagazines", percent = 8 },
				{ category = "KrissVWithMagazines", percent = 8 },
				{ category = "M16WithMagazines", percent = 8 },
				{ category = "M1911WithMagazines", percent = 6 },
				{ category = "M249WithMagazines", percent = 3 },
				{ category = "M40A5WithMagazines", percent = 5 },
				{ category = "Mk18WithMagazines", percent = 7 },
				{ category = "Model70WithRounds", percent = 7 },
				{ category = "MP5WithMagazines", percent = 5 },
				{ category = "P350WithMagazines", percent = 7 },
				{ category = "PX4WithMagazines", percent = 7 },
				{ category = "RecurveBowWithMagazines", percent = 7 },
				{ category = "Rem700WithRounds", percent = 7 },
				{ category = "Rem870WithRounds", percent = 7 },
				{ category = "Ruger22WithMagazines", percent = 7 },
				{ category = "Sako85WithRounds", percent = 5 },
				{ category = "M14WithRounds", percent = 2 },
				{ category = "Shotgun870TacticalWithMagazines", percent = 5 },
				{ category = "TranquilizerGunWithDarts", percent = 2 },
				{ category = "TazerWithMagazines", percent = 2 },
				{ category = "Wasteland22WithRounds", percent = 6 },
				{ category = "M4A1WithMagazines", percent = 8 },
				{ category = "SCARWithMagazines", percent = 8 },
				{ category = "G36CWithMagazines", percent = 6 },
				{ category = "L1ARWithMagazines", percent = 8 },
				{ category = "AkValWithMagazines", percent = 5 },
				{ category = "SAS12WithRounds", percent = 5 },
				{ category = "AK5DWithMagazines", percent = 5 },
				{ category = "MAK10WithRounds", percent = 4 },
				{ category = "HK416WithRounds", percent = 4 },
				{ category = "M97WithRounds", percent = 1 },
			},
		},

		{
			category = "RandomAmmoBox",
			classes =
			{
				{ class = "AmmoBox_10mm", percent = 15, min = 50, max = 100 },
				{ class = "AmmoBox_22", percent = 15, min = 50, max = 100 },
				{ class = "AmmoBox_308", percent = 13, min = 50, max = 100 },
				{ class = "AmmoBox_357", percent = 4, min = 50, max = 100 },
				{ class = "AmmoBox_223", percent = 4, min = 50, max = 100 },
				{ class = "AmmoBox_5_45x39", percent = 15, min = 50, max = 100 },
				{ class = "AmmoBox_5_56x45", percent = 30, min = 50, max = 100 },
				{ class = "AmmoBox_5_70x28", percent = 15, min = 50, max = 100 },
				{ class = "AmmoBox_7_62x39", percent = 30, min = 50, max = 100 },
				{ class = "AmmoBox_7_62x51", percent = 15, min = 50, max = 100 },
				{ class = "AmmoBox_9mm", percent = 30, min = 50, max = 100 },
				{ class = "AmmoBox_acp_45", percent = 15, min = 50, max = 100 },
				{ class = "AmmoBox_50cal", percent = 1, min = 5, max = 15 },
			},
		},

		{
			category = "RandomWeaponWithMags",
			classes =
			{
				{ category = "RandomWeaponWithMagsPure", percent = 100 },
				--{ category = "RandomWeaponRepairKit", percent = 10 },
			},
		},

		{
			category = "RandomWeapon",
			classes =
			{
				{ category = "RandomMelee", percent = 40 },
				{ category = "RandomRanged", percent = 10 },
				{ category = "RandomWeaponWithMags", percent = 60 },
			},
		},

		{
			category = "RandomSeeds",
			classes =
			{
				{ class = "SeedsBeets", percent = 12 },
				{ class = "SeedsBrushPeas", percent = 13 },
				{ class = "SeedsCarrots", percent = 12 },
				{ class = "SeedsPotatoes", percent = 11 },
				{ class = "SeedsWatermelons", percent = 6 },
				{ class = "SeedsPumpkins", percent = 11 },
				{ class = "SeedsRadishes", percent = 12 },
				{ class = "SeedsSnapPeas", percent = 12 },
				{ class = "SeedsTomatoes", percent = 11 },
			},
		},

		-- Actionable contents (note that the actual chance of something being present is controlled in ActionableWorldManager.lua)

		{
			category = "RandomAppleTreeContent",
			classes =
			{
				{ class = "AppleFresh", percent = 100 },
				{ class = "AppleRotten", percent = 15 },
			},
		},

		{
			category = "RandomBeehiveContent",
			classes =
			{
				{ class = "Honeycomb", percent = 100 },
				-- { class = "QueenBee", percent = 5 },
			},
		},

		{
			category = "RandomCouchContent",
			classes =
			{
				{ class = "guide_civilian", percent = 8 },	
				{ class = "AmcoinLedger", percent = 5 },
				{ category = "RandomAmmo", percent = 45 },
				{ category = "RandomMedical", percent = 20 },
				{ class = "Rags", percent = 15 },
				{ class = "HersheysBar", percent = 14 },
				{ class = "MagliteSmall", percent = 1 },
			},
		},

		{
			category = "CheckoutContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 100 },
			},
		},

		{
			category = "SmallHidingPlaceContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 1 },
				{ category = "RandomTrashContent", percent = 1 },
				{ category = "RandomAccessory", percent = 25 },
				{ class = "guide_medical_bandages", percent = 25 },
				{ class = "guide_weapons_melee", percent = 25 },
				{ class = "guide_structures_tire_stacks", percent = 25 },
				--{ class = "guide_structures_wood_storage", percent = 25 },
				{ class = "guide_structures_wood_bridges_1", percent = 25 },
				{ class = "guide_structures_wood_ramps_1", percent = 25 },
				{ class = "guide_structures_wood_stairs_1", percent = 25 },
				{ class = "guide_structures_wood_traps_1", percent = 25 },
				{ class = "guide_structures_wood_walkways_1", percent = 25 },
				{ class = "guide_structures_wood_walls_1", percent = 25 },
				{ class = "guide_structures_wood_roofs", percent = 25 },
				{ class = "guide_powered_parts_1", percent = 25 },
				{ class = "guide_traps_1", percent = 25 },
				{ class = "guide_weapons_ranged_1", percent = 25 },
				{ class = "guide_structures_wood_bridges_2", percent = 20 },
				{ class = "guide_structures_wood_ramps_2", percent = 20 },
				{ class = "guide_structures_wood_stairs_2", percent = 20 },
				{ class = "guide_structures_wood_traps_2", percent = 20 },
				{ class = "guide_structures_wood_walkways_2", percent = 20 },
				{ class = "guide_structures_wood_walls_2", percent = 20 },
				{ class = "guide_traps_2", percent = 20 },
				{ class = "guide_weapons_ranged_2", percent = 20 },
				{ class = "guide_weapons_ranged_3", percent = 20 },
				{ class = "guide_structures_wood_curves", percent = 15 },
				{ class = "guide_structures_wood_gallows", percent = 15 },
				{ class = "guide_structures_wood_watchtower", percent = 15 },
				{ class = "guide_structures_wood_gatehouse", percent = 15 },
			},
		},

		{
			category = "MediumHidingPlaceContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 1 },
				{ category = "RandomAmmo", percent = 70 },
				{ category = "RandomTrashContent", percent = 1 },
				{ category = "RandomAccessory", percent = 25 },
				{ category = "RandomPistol", percent = 10 },
				{ class = "guide_medical_bandages", percent = 25 },
				{ class = "guide_weapons_melee", percent = 25 },
				{ class = "guide_structures_tire_stacks", percent = 25 },
				--{ class = "guide_structures_wood_storage", percent = 25 },
				{ class = "guide_structures_wood_bridges_1", percent = 25 },
				{ class = "guide_structures_wood_ramps_1", percent = 25 },
				{ class = "guide_structures_wood_stairs_1", percent = 25 },
				{ class = "guide_structures_wood_traps_1", percent = 25 },
				{ class = "guide_structures_wood_walkways_1", percent = 25 },
				{ class = "guide_structures_wood_walls_1", percent = 25 },
				{ class = "guide_structures_wood_roofs", percent = 25 },
				{ class = "guide_powered_parts_1", percent = 25 },
				{ class = "guide_traps_1", percent = 25 },
				{ class = "guide_weapons_ranged_1", percent = 25 },
				{ class = "guide_structures_wood_bridges_2", percent = 20 },
				{ class = "guide_structures_wood_ramps_2", percent = 20 },
				{ class = "guide_structures_wood_stairs_2", percent = 20 },
				{ class = "guide_structures_wood_traps_2", percent = 20 },
				{ class = "guide_structures_wood_walkways_2", percent = 20 },
				{ class = "guide_structures_wood_walls_2", percent = 20 },
				{ class = "guide_traps_2", percent = 20 },
				{ class = "guide_weapons_ranged_2", percent = 20 },
				{ class = "guide_weapons_ranged_3", percent = 20 },
				{ class = "guide_structures_wood_curves", percent = 15 },
				{ class = "guide_structures_wood_gallows", percent = 15 },
				{ class = "guide_structures_wood_watchtower", percent = 15 },
				{ class = "guide_structures_wood_gatehouse", percent = 15 },
			},
		},

		{
			category = "RandomToolboxContent",
			classes =
			{
				{ category = "RandomToolRepairKit", percent = 6 },
				{ class = "Nails", percent = 33.5 },
				{ class = "DuctTape", percent = 10 },
				{ class = "PipeMetal", percent = 5 },
				{ class = "Hammer", percent = 10 },
				{ class = "LugWrench", percent = 9 },
				{ class = "SparkPlugs", percent = 6 },
				{ class = "DriveBelt", percent = 6 },
				{ class = "Sledgehammer", percent = 1.5 },
				{ class = "RK_Sledgehammer", percent = 1 },
				{ class = "guide_civilian", percent = 5 },
				{ class = "Icepickaxe", percent = 3 },
			},
		},

		{
			category = "RandomToolRepairKit",
			classes =
			{
				{ class = "RK_MeleePrimary", percent = 50 },
				{ class = "RK_MeleeSecondary", percent = 50 },
			},
		},

		{
			category = "RandomDrinkVendingMachineContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ class = "CokeCan", percent = 28 },
				{ class = "DrPepperCan", percent = 25 },
				{ class = "EnergyDrinkCan", percent = 25 },
				{ class = "PepsiCan", percent = 25 },
				{ class = "SpriteCan", percent = 30 },
				{ class = "WaterBottle", percent = 35 },
			},
		},

		{
			category = "RandomStoveContent",
			classes =
			{
				{ category = "RandomRottenMeat", percent = 50 },
				{ category = "RandomBurnedMeat", percent = 50 },
			},
		},

		{
			category = "RandomFridgeContent",
			classes =
			{
				{ category = "RandomConsumable", percent = 40 },
				{ category = "RandomRottenVeggie", percent = 20 },
				{ category = "RandomRottenMeat", percent = 40 },
			},
		},

		{
			category = "RandomTrashContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomCraftingGuide", percent = 37 },
				{ category = "RandomRottenVeggie", percent = 6 },
				{ category = "RandomRottenMeat", percent = 1 },
				{ category = "RandomBurnedMeat", percent = 1 },
				{ class = "EmptyBottle", percent = 1 },
				{ class = "Rags", percent = 5 },
				{ class = "BalaclavaBlack", percent = 5 },
				{ class = "Rope", percent = 10 },
				{ class = "DuctTape", percent = 17 },
				{ class = "PipeMetal", percent = 5 },
				{ category = "RandomSeeds", percent = 10 },
			},
		},

		{
			category = "RandomCommercialCrateContent",
			classes =
			{
				{ category = "RandomMaintenance", percent = 10 },
				{ class = "Amalgaduino", percent = 7 },
				{ category = "RandomSeeds", percent = 6 },
				{ category = "RandomCampingBPart", percent = 15 },
				{ category = "RandomNormalRepairKit", percent = 3 },
				{ category = "RandomWeaponRepairKit", percent = 1 },
				{ category = "RandomFuel", percent = 21 },
				{ class = "small_generator", percent = 8 },
				{ class = "powered_generator_small", percent = 2 },
				{ class = "Wheel", percent = 20 },
				{ class = "WorkLight", percent = 6 },
				{ category = "RandomTent", percent = 2 },
			},
		},

		{
			category = "RandomMilitaryFootlockerContent",
			classes =
			{
				{ category = "RandomChristmasPresent", percent = 2 }, -- Christmas event
				--{ category = "halloweenBagCommon", percent = 2 }, -- Halloween event
				--{ category = "RandomEggs", percent = 2 }, -- Easter event
				{ category = "RandomRangedPolicePure", percent = 10 },
				{ category = "RandomMilitaryClothing", percent = 10 },
				{ category = "RandomWeaponRepairKit", percent = 3 },
				{ category = "RandomMedical", percent = 10 },
				{ category = "RandomHospitalBandage", percent = 25 },
				{ category = "RandomMilitaryGrenade", percent = 13 },
				{ category = "RandomAccessory", percent = 7 },
				{ category = "RandomCraftingGuide", percent = 30 },
				{ class = "AmcoinLedger", percent = 3 },
				{ class = "Amalgaduino", percent = 2 },
				{ class = "MilitaryCanteenPlastic", percent = 4 },
				{ class = "GasMask", percent = 2 },
				{ class = "MilitaryCanteenMetal", percent = 2 },
				{ class = "MagliteSmall", percent = 2 },
				{ class = "Maglite", percent = 2 },
				{ class = "MRE", percent = 10 },
				{ class = "Cb_radio", percent = 1 },
				{ class = "GridMap", percent = 1 },
				{ class = "Binoculars", percent = 2 },
				{ class = "SurvivalKnife", percent = 1 },
				{ class = "HeatPack", percent = 2 },
				{ class = "WaterPurificationTablets", percent = 2 },
				{ class = "guide_ammo_1", percent = 12 },
				{ class = "guide_ammo_2", percent = 8 },
				{ class = "guide_ammo_3", percent = 4 },
				{ class = "guide_special", percent = 1 },
				{ class = "guide_military", percent = 6 },
				{ category = "RandomTent", percent = 1 },
				{ class = "Mk18Reaver", percent = 2 },
			},
		},

		{
			category = "RandomMilitaryFootlockerIronSonsContent",
			classes =
			{
				{ category = "RandomMilitaryBodyArmor", percent = 14 },
				{ category = "RandomMilitaryHelmet", percent = 13 },
				{ category = "RandomAmmo", percent = 20 },
				{ category = "RandomChristmasPresent", percent = 3 }, -- Christmas event
				--{ category = "halloweenBagCommon", percent = 3 }, -- Halloween event
				--{ category = "RandomEggs", percent = 2 }, -- Easter event
				{ category = "RandomRangedMilitaryPure", percent = 27 },
				{ category = "RandomAmmoBox", percent = 6 },
				{ category = "RandomAccessory", percent = 10 },
				{ category = "RandomMilitaryFootlockerContent", percent = 10 },
				{ class = "ArmoredGhillieSuit", percent = 1.5 },
				{ class = "ArmoredGhillieHood", percent = 1.5 },
				{ class = "SpaceHelmet", percent = 2 },
				{ class = "ScavengerHelmet", percent = 3 },
				{ class = "guide_special", percent = 1 },
				{ class = "RocketLauncherNew", percent = 1 },
				{ class = "Mk18Reaver", percent = 2 },
			},
		},

		{
			category = "RandomMilitaryDeskContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 3 },
				{ class = "Amalgaduino", percent = 2 },
				{ category = "RandomAccessory", percent = 25 },
				{ category = "RandomCraftingGuide", percent = 32 },
				{ category = "RandomMedical", percent = 10 },
				{ category = "RandomHospitalBandage", percent = 1 },
				{ category = "RandomAmmo", percent = 19 },
				{ class = "Cb_radio", percent = 1 },
				{ class = "MagliteSmall", percent = 5 },
				{ class = "GridMap", percent = 1 },
				{ class = "WaterPurificationTablets", percent = 1 },
				{ class = "guide_military", percent = 3 },
			},
		},

		{
			category = "RandomSwitchboardContent",
			classes =
			{
				{ category = "RandomElectronicsContent", percent = 15 },
				{ class = "Amalgaduino", percent = 25 },
				{ class = "Cb_radio", percent = 10 },
				{ class = "MagliteSmall", percent = 20 },
				{ class = "DuctTape", percent = 10 },
				{ class = "PipeMetal", percent = 5 },
				{ category = "RandomEyes", percent = 5 },
				{ category = "RandomTrashContent", percent = 15 },
			},
		},

		{
			category = "RandomLockerContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomClothes", percent = 75 },
				{ category = "RandomFireStarter", percent = 6 },
				{ category = "RandomNormalRepairKit", percent = 5 },
				{ category = "RandomWeaponRepairKit", percent = 2 },
				{ category = "RandomMedical", percent = 5 },
				{ category = "RandomTrashContent", percent = 5 },
				{ category = "RandomPistol", percent = 6 },
				{ class = "WaterPurificationTablets", percent = 2 },
				{ class = "guide_ammo_1", percent = 12 },
				{ class = "guide_ammo_2", percent = 8 },
				{ class = "guide_ammo_3", percent = 4 },
				{ category = "RandomTent", percent = 1 },
			},
		},

		{
			category = "RandomSinkContent",
			classes =
			{
				{ category = "RandomNormalRepairKit", percent = 5 },
				{ category = "RandomMedical", percent = 15 },
				{ category = "RandomFireStarter", percent = 5 },
				{ category = "RandomTrashContent", percent = 5 },
				{ class = "PipeMetal", percent = 5 },
				{ category = "RandomCraftingGuide", percent = 23 },
				{ category = "RandomFlashlight", percent = 5 },
				{ class = "HeatPack", percent = 7 },
				{ class = "Rope", percent = 5 },
				{ class = "RubbingAlcohol", percent = 10 },
				{ class = "Oil", percent = 7.5 },
				{ class = "DuctTape", percent = 10 },
				{ class = "DogFoodCan", percent = 5 },
				--{ class = "CupidArrowx8", percent = 2.5 }, -- Valentines event
			},
		},

		{
			category = "RandomDeskContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 4 },
				{ category = "RandomCraftingGuide", percent = 29 },
				{ class = "Amalgaduino", percent = 1 },
				{ class = "HeatPack", percent = 5 },
				{ category = "RandomFireStarter", percent = 10 },
				{ class = "AppleRotten", percent = 5 },
				{ class = "HersheysBar", percent = 5 },
				{ category = "Map", percent = 1 },
				{ category = "RandomHands", percent = 1 },
				{ category = "RandomEyes", percent = 1 },
				{ category = "RandomAccessory", percent = 5 },
				{ category = "RandomMedical", percent = 15 },
				{ category = "RandomAmmo", percent = 14 },
				{ category = "RandomSeeds", percent = 5 },
				{ class = "WaterPurificationTablets", percent = 1 },
				--{ class = "CupidArrowx8", percent = 2 }, -- Valentines event
				{ class = "guide_civilian", percent = 5 },
				{ category = "RandomWeaponRepairKit", percent = 1 },				
			},
		},

		{
			category = "RandomKitchenContent",
			classes =
			{
				{ class = "HeatPack", percent = 8 },
				{ category = "RandomMedical", percent = 1 },
				{ category = "RandomWoolGloves", percent = 5 },
				{ category = "BandanaHat", percent = 1 },
				{ category = "RandomCraftingGuide", percent = 11 },
				{ category = "RandomAmmo", percent = 1 },
				{ class = "AmcoinLedger", percent = 1 },
				{ category = "RandomFood", percent = 12 },
				{ category = "RandomSeeds", percent = 10 },
				{ category = "RandomFireStarter", percent = 25 },
				{ category = "SaltAndPepper", percent = 25 },
			},
		},

		{
			category = "RandomHospitalClothesSmall",
			classes =
			{
				{ category = "RandomHazmatSuit", percent = 6 },
				{ category = "RandomHazmatMaskColored", percent = 6 },
				{ category = "RandomHazmatSuitColored", percent = 6 },
				{ category = "RandomGasCanisterPackColored", percent = 6 },
				{ category = "RandomFullHazmatSet", percent = 1 },
				{ class = "guide_hazmat", percent = 5 },
				{ class = "DustMask", percent = 15 },
				{ class = "HazmatMask", percent = 10 },
				{ class = "GasMask", percent = 5 },
				{ category = "RandomEyes", percent = 5 },
				{ class = "FannyPackGray", percent = 5 },
				{ class = "FannyPackRed", percent = 5 },
				{ class = "FannyPackRedBlue", percent = 5 },
				{ class = "SneakersWhite", percent = 5 },
				{ class = "HitopsBlue", percent = 5 },
				{ class = "WoolGlovesBlue", percent = 5 },
				{ class = "WoolGlovesWhite", percent = 5 },
			},
		},

		{
			category = "RandomHospitalClothes",
			classes =
			{
				{ category = "RandomHospitalClothesSmall", percent = 22 },
				{ category = "RandomClothes", percent = 14 },
				{ category = "RandomHazmatSuitColored", percent = 14 },
				{ category = "RandomGasCanisterPackColored", percent = 14 },
				{ class = "RainJacketOrangeBlue", percent = 5 },
				{ class = "RainJacketYellow", percent = 5 },
				{ class = "RainJacketRed", percent = 5 },
				{ class = "ButtonUpShirtBlue", percent = 4 },
				{ class = "ButtonUpShirtGrey", percent = 4 },
				{ class = "CottonShirtBlue", percent = 4 },
				{ class = "CottonShirtTan", percent = 4 },	
				{ class = "guide_hazmat", percent = 5 },
			},
		},

		{
			category = "RandomHospitalBandage",
			classes =
			{
				{ class = "Bandage", percent = 20 },
				{ class = "AntibioticBandage", percent = 30 },
				{ class = "AdvancedBandage", percent = 50 },
			},
		},

		{
			category = "RandomHospitalMedical",
			classes =
			{
				{ category = "RandomMedical", percent = 75 },
				{ category = "RandomHospitalBandage", percent = 20 },
				{ class = "guide_medical_bandages", percent = 2 },
				{ class = "guide_hazmat", percent = 3 },
			},
		},

		{
			category = "RandomHospitalContentSmall",
			classes =
			{
				{ category = "RandomHospitalMedical", percent = 51 },
				{ category = "RandomHospitalClothesSmall", percent = 30 },
				{ category = "RandomConsumable", percent = 5 },
				{ category = "RandomChemlight", percent = 2 },
				{ category = "RandomFireStarter", percent = 2 },
				{ class = "guide_hazmat", percent = 3 },
				{ class = "Cb_radio", percent = 2 },
				{ class = "MagliteSmall", percent = 2 },
				{ class = "Headlamp", percent = 2 },
				{ class = "HeadlampRed", percent = 1 },
			},
		},

		{
			category = "RandomHospitalContentMedium",
			classes =
			{
				{ category = "RandomHospitalContentSmall", percent = 50 },
				{ category = "RandomHospitalClothes", percent = 25 },
				{ class = "guide_hazmat", percent = 2 },
				{ class = "WaterBottle", percent = 8 },
				{ class = "camping_lantern", percent = 2 },
				{ class = "camping_water_jug", percent = 3 },
				{ class = "Hammer", percent = 3 },
				{ class = "Hatchet", percent = 2 },
				{ class = "StunBaton", percent = 3 },
				{ class = "SurvivalKnife", percent = 2 },
			},
		},

		{
			category = "RandomHospitalContentBig",
			classes =
			{
				{ category = "RandomHospitalContentMedium", percent = 63 },
				{ category = "RandomHospitalClothes", percent = 20 },
				{ class = "guide_hazmat", percent = 2 },
				{ class = "JerryCanDiesel", percent = 5 },
				{ class = "PropaneTank", percent = 5 },
				{ class = "WorkLight", percent = 3 },
				{ class = "small_generator", percent = 1.75 },
				{ class = "powered_generator_small", percent = 0.25 },
			},
		},

		{
			category = "RandomLivingAreaContent",
			classes =
			{
				{ category = "RandomAmmo", percent = 13 },
				{ category = "RandomPistol", percent = 2 },
				{ class = "AmcoinLedger", percent = 1 },
				{ class = "guide_civilian", percent = 3 },
				{ category = "RandomCraftingGuide", percent = 59 },
				{ category = "RandomClothes", percent = 20 },
				{ category = "RandomNormalRepairKit", percent = 2 },
			},
		},

		{
			category = "RandomOfficeContent",
			classes =
			{
				{ category = "RandomAmmo", percent = 2 },
				{ category = "RandomPistol", percent = 2 },
				{ class = "AmcoinLedger", percent = 1 },
				{ class = "guide_civilian", percent = 3 },
				{ category = "RandomTrashContent", percent = 92 },
			},
		},

		{
			category = "RandomSuitcaseContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomEyes", percent = 10 },
				{ category = "RandomTorso", percent = 35 },
				{ category = "RandomLegs", percent = 50 },
				{ class = "guide_civilian", percent = 3 },
			},
		},

		{
			category = "RandomWashingContent",
			classes =
			{
				{ category = "RandomTorso", percent = 50 },
				{ category = "RandomLegs", percent = 50 },
			},
		},

		{
			category = "RandomFoodBoxContent",
			classes =
			{
				{ category = "RandomConsumable", percent = 100 },
			},
		},

		{
			category = "RandomElectronicsContent",
			classes =
			{
				{ class = "ElectricalParts", percent = 75 },
				{ class = "Amalgaduino", percent = 23 },
				{ class = "AmcoinLedger", percent = 2 },

			},
		},
		
		{
			category = "RandomSilencer",
			classes =
			{
				{ class = "RifleSilencer", percent = 10 },
				{ class = "PistolSilencer", percent = 90 },
			},
		},
		
		{
			category = "CamoSilencer",
			classes =
			{
				{ class = "RifleSilencer", percent = 80 },
				{ class = "RifleSilencerRealCamo", percent = 10 },
				{ class = "RifleSilencerRealCamoDesert", percent = 10 },
			},
		},
		
		{
			category = "CamoOpticScope",
			classes =
			{
				{ class = "OpticScope", percent = 34 },
				{ class = "OpticScopeRealCamo", percent = 33 },
				{ class = "OpticScopeRealCamoDesert", percent = 33 },
			},
		},
		
		{
			category = "CamoHuntingScope",
			classes =
			{
				{ class = "HuntingScope", percent = 34 },
				{ class = "HuntingScopeRealCamo", percent = 33 },
				{ class = "HuntingScopeRealCamoDesert", percent = 33 },
			},
		},
		
		-- Custom Metal Parts
		{
			category = "RandomMetalParts",
			classes =
			{
				-- doors (10)
				{ class = "brick_angled_roof_3x4x4", percent = 10 },
				-- walls (20)
				{ class = "cobblestone_wall_3m_4m", percent = 2 },
				{ class = "cobblestone_ceiling_8m_8m", percent = 1 },
				{ class = "classic_platform_3m_4m_4m", percent = 1 }, 
				{ class = "classic_platform_3m_4m_4m_stairs", percent = 2 },
				{ class = "classic_platform_3m_4m_4m", percent = 2 },
				{ class = "cobblestone_column_3m", percent = 2 },
				{ class = "cobblestone_wall_3m_4m", percent = 10 },
				-- special walls (10)
				{ class = "classic_platform_3m_4m_4m", percent = 6 }, 
				{ class = "classic_platform_3m_4m_4m", percent = 1 },
				{ class = "classic_platform_3m_4m_4m", percent = 3 },
				-- special (20)
				{ class = "classic_platform_3m_4m_4m", percent = 5 },
				{ class = "classic_platform_3m_4m_4m", percent = 5 },
				{ class = "classic_platform_3m_4m_4m", percent = 5 },
				{ class = "classic_platform_3m_4m_4m", percent = 1 },
				{ class = "classic_platform_3m_4m_4m", percent = 1 },
				{ class = "classic_platform_3m_4m_4m", percent = 3 },
				-- gatehouse (20)
				{ class = "cobblestone_wall_3m_4m", percent = 7 },
				{ class = "cobblestone_wall_3m_4m", percent = 7 },
				{ class = "cobblestone_wall_3m_4m", percent = 3 },
				{ class = "cobblestone_wall_3m_4m", percent = 3 },
				-- misc (20)
				{ class = "brick_wall_3m_4m", percent = 10 },
				{ class = "brick_wall_3m_4m", percent = 5 },
				{ class = "brick_wall_3m_4m", percent = 5 },
			},
		},

		-- Custom Event Drops
		{
			category = "CustomEventCrate",
			classes =
			{
				{ class = "EventCrate", contents="RandomCrateEventContents", percent = 100 },
			},
		},
		
		{
			category = "RandomCrateEventContents",
			group =
			{
				{ class = "PredatorBackPack", percent = 100 },
				{ class = "IronsuitWarMachineBoots", percent = 15 },
				{ class = "IronsuitWarMachineChest", percent = 15 },
				{ class = "IronsuitWarMachineGloves", percent = 15 },
				{ class = "IronsuitWarMachineHelmet", percent = 15 },
				{ class = "IronsuitWarMachinePants", percent = 15 },
				{ class = "BlastMask", percent = 45 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ class = "metal_gate_lockable_6m_5_4m", percent = 20 },
				{ class = "metal_gatehouse_8m_8m", percent = 20 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ category = "RandomMetalParts", percent = 10 },
				{ category = "RandomMetalParts", percent = 5 },
				{ category = "RandomLegendaryWeapon", percent = 15 },
				{ category = "RandomLegendaryWeapon", percent = 7.5 },
				{ category = "RandomEpicWeapon", percent = 70 },
				{ category = "RandomEpicWeapon", percent = 50 },
				{ category = "RandomEpicWeapon", percent = 30 },
				{ category = "RandomEpicWeapon", percent = 10 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ class = "M50Skins", percent = 1 },
				{ class = "50calx7", percent = 45 },
                { class = "SAPOCBriefcaseClosed", percent = 1 },
				{ class = "m14_drummag_50rnd", percent = 60 },
				{ class = "Deagle", percent = 60 },
				{ class = "deagle_mag", percent = 50 },
				{ class = "RPK", percent = 45 },
				{ class = "ext_762x75", percent = 75 },
                { category = "Crafted_AmmoBox_44M_Venom", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ class = "RocketLauncherNew", percent = 5 },
				{ category = "RandomRockets", percent = 7 },
				{ category = "RandomRockets", percent = 5 },
				{ class = "M97", percent = 5 },
				{ class = "Pile_40mmGrenade", percent = 5, min = 1, max = 3 },
				{ class = "Pile_40mmIncendiaryGrenade", percent = 5, min = 1, max = 3 },
				{ category = "Random40mmTacticalGrenades", percent = 5, min = 1, max = 3 },
				{ category = "Random40mmSmokeGrenades", percent = 5, min = 1, max = 3 },
				{ class = "guide_explosives_1", percent = 100 },
				{ class = "guide_explosives_2", percent = 100 },
				{ class = "GrenadePickup", percent = 100, min = 1, max = 3 },
				{ class = "C4TimedPickup", percent = 1, min = 1, max = 3 },
				{ class = "C4TimedPickup", percent = 1, min = 1, max = 3 },
				{ class = "Icepickaxe", percent = 65 },
				{ class = "Sledgehammer", percent = 7 },
				{ class = "Mk18Reaver", percent = 1 },
			},
		},
		
		{
			category = "CustomSpecialCrate",
			classes =
			{
				{ class = "SpecialCrate", contents="RandomCrateSpecialContents", percent = 100 },
			},
		},
		
		{
			category = "RandomCrateSpecialContents",
			group =
			{
				{ class = "RealCamoBag", percent = 50 },
				{ class = "RealCamoBoots", percent = 15 },
				{ class = "RealCamoFlakVest", percent = 15 },
				{ class = "RealCamoheavyshoulder", percent = 15 },
				{ class = "RealCamoHornetHelmet", percent = 15 },
				{ class = "galil", percent = 10 },
				{ class = "RealCamoMilitaryJacket", percent = 15 },
				{ class = "RealCamoPants", percent = 15 },
				{ class = "RealCamoScarf", percent = 15 },
				{ class = "RealCamoSpaceHelmet", percent = 15 },
				{ class = "BlastMask", percent = 15 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ class = "rpg", percent = 1 },
				{ category = "aug", percent = 10 },
				{ category = "RandomMetalParts", percent = 5 },
				{ category = "RandomLegendaryWeapon", percent = 20 },
				{ category = "RandomLegendaryWeapon", percent = 15 },
				{ category = "RandomLegendaryWeapon", percent = 10 },
				{ category = "RandomEpicWeapon", percent = 20 },
				{ category = "RandomEpicWeapon", percent = 15 },
				{ category = "RandomEpicWeapon", percent = 10 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomRangedMilitaryPure", percent = 75 },
				{ category = "RandomRangedMilitaryPure", percent = 50 },
				{ category = "Kripton", percent = 25 },
				{ category = "RandomRangedPolicePure", percent = 100 },
				{ category = "RandomRangedPolicePure", percent = 75 },
				{ category = "RandomRangedPolicePure", percent = 50 },
				{ category = "GrimReaper", percent = 25 },
				{ category = "RandomMilitaryArmor", percent = 50 },
				{ category = "RandomMilitaryArmor", percent = 25 },
				{ category = "RandomPoliceArmor", percent = 50 },
				{ category = "Subjugator", percent = 25 },
				{ category = "RandomGhillieSuit", percent = 50 },
				{ category = "RandomGhillieSuit", percent = 25 },
				{ class = "Mk18Reaver", percent = 2 },
				{ category = "RandomAccessory", percent = 25 },
				{ category = "RandomAccessory", percent = 25 },
				{ category = "svd", percent = 25 },
                { category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 75 },
				{ category = "RandomAmmoBox", percent = 50 },
				{ category = "RandomAmmoBox", percent = 25 },
				{ category = "RandomAmmoBox", percent = 25 },
				{ category = "RocketLauncherNew", percent = 25 },
				{ category = "RandomAmmo", percent = 20 },
				{ category = "RandomAmmo", percent = 20 },
				{ category = "RandomAmmo", percent = 15 },
				{ category = "RandomAmmo", percent = 15 },
				{ category = "RandomAmmo", percent = 15 },
				{ category = "RandomAmmo", percent = 15 },
			},
		},
		
		{
			category = "CustomSupplyCrate",
			classes =
			{
				{ class = "SupplyCrate", contents="RandomCrateSupplyContents", percent = 100 },
			},
		},
		
		{
			category = "RandomCrateSupplyContents",
			group =
			{
				{ class = "762x30Venom", percent = 10 },
				{ class = "762x30_DragonsBreath", percent = 10 },
				{ class = "762x30_Uranium", percent = 10 },
				{ class = "10mmx15_DragonsBreath", percent = 2 },
				{ class = "10mmx15_Uranium", percent = 10 },
				{ class = "10mmx15_Venom", percent = 10 },
				{ class = "10mmx30_DragonsBreath", percent = 10 },
				{ class = "10mmx30_Uranium", percent = 10 },
				{ class = "10mmx30_Venom", percent = 10 },
				{ class = "57x50_DragonsBreath", percent = 10 },
				{ class = "57x50_Uranium", percent = 10 },
				{ class = "57x50_Venom", percent = 10 },
				{ class = "556x100_DragonsBreath", percent = 15 },
				{ class = "556x100_Uranium", percent = 10 },
				{ class = "556x100_Venom", percent = 10 },	
				{ class = "762x10_DragonsBreath", percent = 10 },
				{ class = "762x10_Uranium", percent = 25 },
				{ category = "762x10_Venom", percent = 10 },
				{ category = "M40x5_DragonsBreath", percent = 5 },
				{ category = "M40x5_Uranium", percent = 20 },
				{ category = "M40x5_Venom", percent = 15 },
				{ category = "STANAGx30_Uranium", percent = 10 },
				{ category = "STANAGx30_DragonsBreath", percent = 20 },
				{ category = "STANAGx30_Incendiary", percent = 15 },
				{ category = "STANAGx30_Venom", percent = 10 },
				{ category = "545x30_DragonsBreath", percent = 20 },
				{ category = "545x30_Uranium", percent = 20 },
				{ category = "545x30_Venom", percent = 15 },
				{ category = "9mmx10_DragonsBreath", percent = 15 },
				{ category = "9mmx10_Venom", percent = 20 },
				{ category = "9mmx19_DragonsBreath", percent = 20 },
				{ category = "9mmx19_Venom", percent = 15 },
				{ category = "9mmx33_DragonsBreath", percent = 15 },
				{ class = "9mmx33_Venom", percent = 10 },
				{ class = "12Gaugex8_NerveGas_AA12", percent = 10 },
				{ class = "12Gaugex8_Concussion_AA12", percent = 5 },
				{ class = "12Gaugex8_Incendiary_AA12", percent = 5 },
				{ class = "12Gaugex8_Venom_AA12", percent = 10 },
				{ class = "12Gaugex8_FRAG12_AA12", percent = 10 },
				{ class = "12Gaugex8_DragonsBreath_AA12", percent = 10 },
				{ class = "10mmx30V_Venom", percent = 10 },
				{ class = "10mmx30V_Uranium", percent = 10 },
				{ class = "10mmx30V_DragonsBreath", percent = 10 },
			
			},
		},
		
		-- Custom Air Drops
		{
			category = "CustomGuideCrate",
			classes =
			{
				{ class = "GuideCrate", contents="RandomCrateGuideContents", percent = 100 },
			},
		},
		
		{
			category = "RandomCrateGuideContents",
			group =
			{
				{ class = "guide_medical_bandages", percent = 100 },
				{ class = "guide_weapons_melee", percent = 100 },
				{ class = "guide_structures_tire_stacks", percent = 100 },
				--{ class = "guide_structures_wood_storage", percent = 100 },
				{ class = "guide_structures_wood_bridges_1", percent = 100 },
				{ class = "guide_structures_wood_ramps_1", percent = 100 },
				{ class = "guide_structures_wood_stairs_1", percent = 100 },
				{ class = "guide_structures_wood_traps_2", percent = 100 },
				{ class = "guide_structures_wood_walkways_1", percent = 100 },
				{ class = "guide_structures_wood_walls_1", percent = 100 },
				{ class = "guide_structures_wood_roofs", percent = 100 },
				{ class = "guide_powered_parts_1", percent = 100 },
				{ class = "guide_traps_1", percent = 100 },
				{ class = "guide_structures_wood_bridges_2", percent = 100 },
				{ class = "guide_structures_wood_ramps_2", percent = 100 },
				{ class = "guide_structures_wood_stairs_2", percent = 100 },
				{ class = "guide_structures_wood_traps_1", percent = 100 },
				{ class = "guide_structures_wood_walkways_2", percent = 100 },
				{ class = "guide_structures_wood_walls_2", percent = 100 },
				{ class = "guide_traps_2", percent = 100 },
				{ class = "guide_structures_wood_curves", percent = 100 },
				{ class = "guide_structures_wood_gallows", percent = 100 },
				{ class = "guide_structures_wood_watchtower", percent = 100 },
				{ class = "guide_structures_wood_gatehouse", percent = 100 },
				{ class = "guide_weapons_ranged_1", percent = 100 },
				{ class = "guide_weapons_ranged_2", percent = 100 },
				{ class = "guide_weapons_ranged_3", percent = 100 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ class = "guide_ammo_1", percent = 5 },
				{ class = "guide_ammo_2", percent = 3 },
				{ class = "guide_ammo_3", percent = 1 },
				{ class = "guide_civilian", percent = 5 },
				{ class = "guide_police", percent = 4 },
				{ class = "guide_military", percent = 3 },
				{ class = "guide_hazmat", percent = 2 },
				{ class = "guide_special", percent = 1 },
				{ class = "guide_games", percent = 3 },
				--{ class = "guide_structures_wood_storage_2", percent = 4 }, -- Disabled
			},
		},
		
		-- Custom Air Drops
		{
			category = "CustomUFOAirDropCrate",
			classes =
			{
				{ class = "UFOAirDropCrate", contents="RandomUFOAirDropCrateContents", percent = 100 },
			},
		},
		
		{
			category = "RandomUFOAirDropCrateContents",
			group =
			{
                -- 40 slots in the crate - EVENT BASED
                { category = "RandomRangedMilitaryPure", percent = 100 },
                { class = "Subjugator", percent = 5 },
                { class = "50calx7", percent = 25 },
                { category = "RandomLegendaryWeapon", percent = 25 },
                { class = "SpaceHelmet", percent = 100 },
                { class = "BlastMask", percent = 13 },
                { class= "Deagle", percent = 10 },
				{ class= "deagle_mag", percent = 10 },
				{ class = "M50Skins", percent = 1 },
                { class = "mag_m14", percent = 35 },
				{ category = "RandomDuffelBag", percent = 100 },
				{ class = "C4TimedPickup", percent = 1, min = 1, max = 3 },
				{ class = "metal_gate_lockable_6m_5_4m", percent = 7 },
				{ class = "metal_gatehouse_8m_8m", percent = 7 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "Mk18Reaver", percent = 2 },
				{ category = "RandomMilitaryArmor", percent = 100 },
				{ category = "RandomEpicWeapon", percent = 30 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ class= "PredatorBackPack", percent = 10 },
				{ class= "IronsuitPredatorBoots", percent = 10 },
				{ class= "IronsuitPredatorChest", percent = 10 },
				{ class= "IronsuitPredatorGloves", percent = 10 },
				{ class= "IronsuitPredatorHelmet", percent = 10 },
				{ class= "IronsuitPredatorPants", percent = 10 },
				{ category = "RandomRockets", percent = 2 },
				{ category = "RandomRockets", percent = 2 },
				{ class = "RocketLauncherNew", percent = 1 },
				{ class = "RealCamoDesertHornetHelmet", percent = 10 },
				{ class = "RealCamoHornetHelmet", percent = 10 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				--{ category  = "HalloweenLootUFO", percent = 100 }, -- Halloween event
            },
		},

		-- Air Drops
		{
			-- The cargo drop crate has 50 slots
			category = "RandomAirDropCrate",
			classes =
			{
				{ category = "RandomAirDropCratePolice", percent = 22 },
				{ category = "RandomAirDropCrateMilitary", percent = 23 },
				{ category = "RandomAirDropCrateCivilian", percent = 15 },
				{ category = "RandomAirDropCrateExplosives", percent = 2 },
				{ category = "RandomAirDropCrateBaseBuilding", percent = 15 },
				{ category = "RandomAirDropCrateRadiation", percent = 18 },
				{ category = "AirDropSantaCrate", percent = 2 },
			},
		},

		{
			category = "AirDropSantaCrate",
			group =
			{
				{ category = "RandomChristmasClothing", percent = 100 },
				{ class = "ChristmasPresentCommon1", percent = 100 },
				{ class = "ChristmasPresentCommon1", percent = 100 },
				{ class = "ChristmasPresentCommon2", percent = 100 },
				{ class = "ChristmasPresentCommon2", percent = 100 },
				{ class = "ChristmasPresentRare", percent = 100 },
				{ class = "ChristmasPresentRare", percent = 100 },
				{ class = "ChristmasHat", percent = 100 },
				{ class = "AmmoBox_357", percent = 100 },
				{ category = "RandomDuffelBag", percent = 100 },
				{ class = "ScavengerHelmet", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ class = "PredatorBackPack", percent = 15 },
				{ class = "IronsuitWarMachineBoots", percent = 5 },
				{ class = "IronsuitWarMachineChest", percent = 5 },
				{ class = "IronsuitWarMachineGloves", percent = 5 },
				{ class = "IronsuitWarMachineHelmet", percent = 5 },
				{ class = "IronsuitWarMachinePants", percent = 5 },
				{ class = "Peacemaker", percent = 100 },
				{ class = "SpaceHelmet", percent = 100 },
				{ class = "EggNog", percent = 100 },
				{ class = "EggNog", percent = 100 },
				{ class = "GingerBreadMan", percent = 100, min = 2, max = 5 },
				{ class = "GingerBreadMan", percent = 100, min = 2, max = 5 },
				{ class = "metal_gate_lockable_6m_5_4m", percent = 7 },
				{ class = "metal_gatehouse_8m_8m", percent = 7 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "ArmoredGhillieSuit", percent = 5 },
				{ class = "ArmoredGhillieHood", percent = 5 },
				{ category = "RandomLegendaryWeapon", percent = 7.5 },
				{ category = "RandomEpicWeapon", percent = 7.5 },
				{ class = "C4TimedPickup", percent = 1, min = 1, max = 3 },
				{ class = "Sledgehammer", percent = 3 },
				{ class = "Icepickaxe", percent = 15 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ category = "RandomRockets", percent = 2 },
				{ class = "RocketLauncherNew", percent = 1 },
			},
		},
		
		{
			category = "RandomAirDropCrateMilitary",
			group =
			{
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ class = "guide_military", percent = 50 },
				{ class = "M16", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ category = "M50Skins", percent = 2 },
				{ class = "50calx7", percent = 15 },
				{ class = "50calx7", percent = 15 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ category = "RandomMilitaryArmor", percent = 100 },
				{ category = "RandomMilitaryHelmet", percent = 100 },
				{ category = "RandomMilitaryJacket", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "GrenadeGasSleepPickup", percent = 100 },
				{ class = "ArmoredGhillieSuit", percent = 5 },
				{ class = "ArmoredGhillieHood", percent = 5 },
				{ class = "C4TimedPickup", percent = 1, min = 1, max = 3 },
				{ class = "C4TimedPickup", percent = 5, min = 1, max = 1 },
				{ class = "DuffelBagGreen", percent = 100 },
				{ class = "556x100", percent = 100 },
				{ class = "556x100", percent = 100 },
				{ class = "M4A1", percent = 15 },
				{ class = "Mk18Reaver", percent = 2 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "SCAR-H", percent = 15 },
				{ category = "ACAWSkins", percent = 50 },
				{ class = "AKM", percent = 50 },
				{ class = "762x40", percent = 100 },
				{ class = "762x40", percent = 100 },
				{ class = "MilitaryJacketGreen", percent = 100 },
				{ class = "CargoPantsGreen", percent = 100 },
				{ class = "Headlamp", percent = 100 },
				{ class = "AmcoinLedger", percent = 100, min = 64, max = 128 },
				{ class = "FlashlightRifle", percent = 100 },
				{ class = "MRE", percent = 100 },
				{ class = "MRE", percent = 100 },
				{ class = "Pile_762x39", percent = 100 },
				{ class = "AKVal", percent = 10 },
				{ class = "AK5D", percent = 25 },
				{ class = "556x30_ak5d", percent = 70 },
				{ class = "762x20_Akval", percent = 55 },
				{ class = "ReddotSight", percent = 100 },
				{ category = "RandomRockets", percent = 2 },
				{ category = "RandomRockets", percent = 2 },
				{ class = "RocketLauncherNew", percent = 1 },
				{ class = "VSS", percent = 2 },
				{ class = "M4V5", percent = 2 },
				{ class = "RPK", percent = 2 },
				--{ class = "EggBlue", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggGreen", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggPink", percent = 100, min = 1, max = 5 }, -- Easter event
			},
		},
		
		{
			category = "RandomAirDropCrateRadiation",
			group =
			{
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ class = "guide_hazmat", percent = 50 },
				{ class = "R90", percent = 100 },
				{ class = "57x50", percent = 100 },
				{ class = "57x50", percent = 100 },
				{ class = "Pile_57x28", percent = 100, min = 30, max = 30 },
				{ class = "Pile_57x28", percent = 100, min = 30, max = 30 },
				{ category = "RandomHazmatMaskColored", percent = 100 },
				{ category = "RandomHazmatMaskColored", percent = 100 },
				{ category = "RandomHazmatSuitColored", percent = 100 },
				{ class = "Pile_762x51", percent = 100 },
				{ category = "RandomGasCanisterPackColored", percent = 100 },
				{ category = "RandomGasCanisterPackColored", percent = 100 },
				{ class = "AntiradiationPills", percent = 100, min = 3, max = 3 },
				{ class = "AntiradiationPills", percent = 100, min = 3, max = 3 },
				{ class = "Pile_762x51", percent = 100 },
				{ class = "MushroomAntiRad", percent = 100, min = 5, max = 5 },
				{ class = "PotassiumIodidePills", percent = 100, min = 3, max = 3 },
				{ class = "WaterPurificationTablets", percent = 100, min = 3, max = 3 },
				{ class = "SCAR-H", percent = 15 },
				{ class = "Mk18Reaver", percent = 2 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "M4A1", percent = 20 },
				{ class = "MRE", percent = 100 },
				{ class = "SpaceHelmet", percent = 5 },
				{ class = "SCAAMAmalgarmin", percent = 15 },
				{ category = "RandomMedical", percent = 100 },
				{ class = "AntibioticBandage", percent = 100, min = 3, max = 3 },
				{ class = "AdvancedBandage", percent = 100, min = 3, max = 3 },
				{ class = "camping_water_jug", percent = 100 },
				{ class = "MushroomHeal", percent = 100, min = 3, max = 3 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "HeatPack", percent = 100, min = 3, max = 3 },
				{ class = "SCAAMAmalgamatedNotebook", percent = 15 },
				{ category = "RandomAmmo", percent = 60 },
				{ class = "AKMGold", percent = 5 },
				{ class = "Mk18Reaver", percent = 5 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ class = "GrenadeGasTearPickup", percent = 50 },
				{ category = "RandomFlashlight", percent = 100 },
				{ class = "Pile_762x39", percent = 100 },
				{ class = "AKVal", percent = 10 },
				{ class = "AK5D", percent = 25 },
				{ class = "556x30_ak5d", percent = 70 },
				{ class = "762x20_Akval", percent = 55 },
				{ class = "ReddotSight", percent = 100 },
				{ class = "OPKSight", percent = 60 },
				{ class = "R3Sight", percent = 70 },
				{ class = "PSOScope", percent = 40 },
				{ category = "RandomTent", percent = 10 },
				{ class = "ext_762x75", percent = 16 },
				{ class = "ext_556x75", percent = 17 },
				{ class = "RK_Sledgehammer", percent = 3 },
				--{ class = "EggBlue", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggGreen", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggPink", percent = 100, min = 1, max = 5 }, -- Easter event
			},
		},
		
		{
			category = "RandomAirDropCrateBaseBuilding",
			group =
			{
				{ class = "SheetMetal", percent = 100, min = 64, max = 128 },
				{ class = "Lumber", percent = 100, min = 64, max = 128 },
				{ class = "SheetMetal", percent = 100, min = 64, max = 128 },
				{ class = "Lumber", percent = 100, min = 64, max = 128 },
				{ class = "Lumber", percent = 100, min = 64, max = 128 },
				{ class = "Lumber", percent = 100, min = 64, max = 128 },
				{ class = "Lumber", percent = 100, min = 64, max = 128 },
				{ class = "WoodPile", percent = 100, min = 64, max = 128 },
				{ class = "WoodPile", percent = 100, min = 64, max = 128 },
				{ class = "Rocks", percent = 100, min = 64, max = 128 },
				{ class = "Rocks", percent = 100, min = 64, max = 128 },
				{ class = "Nails", percent = 100, min = 64, max = 64 },
				{ class = "Nails", percent = 100, min = 64, max = 64 },
				{ class = "sandbag_crafted_1_3m_3m", percent = 100, },
				{ class = "sandbag_crafted_1_3m_3m", percent = 100, },
				{ class = "ScrapMetal", percent = 100, min = 10, max = 40 },
				{ class = "ScrapMetal", percent = 100, min = 10, max = 40 },
				{ class = "plated_wall_3m_4m_02", percent = 100, min = 5, max = 5 },
				{ class = "plated_wall_3m_4m_02", percent = 100, min = 5, max = 5 },
				{ class = "plated_wall_window_3m_4m_02", percent = 50, min = 1, max = 5 },
				{ class = "wood_wall_3m_4m_02", percent = 100, min = 5, max = 5 },
				{ class = "wood_watchtower_big", percent = 100, min = 1, max = 2 },
				{ class = "SCAAMAmalgarmin", percent = 15 },
				{ class = "SCAAMAmalgamatedNotebook", percent = 15 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "plated_walkway_3m_4m_4m_02", percent = 100, min = 5, max = 5 },
				{ class = "plated_walkway_3m_4m_4m_02", percent = 100, min = 5, max = 5 },
				{ class = "plated_door_lockable_1m_2m", percent = 100, min = 2, max = 5 },
				{ class = "plated_wall_door_3m_4m", percent = 100, min = 2, max = 5 },
				{ class = "plated_gate_lockable_3m_4m", percent = 100, min = 5, max = 5 },
				{ class = "plated_gatehouse", percent = 100 },
				{ class = "RuggedPack", percent = 100 },
				{ class = "guide_structures_wood_watchtower", percent = 100 },
				{ class = "guide_structures_wood_walls_2", percent = 100 },
				{ class = "guide_structures_wood_walkways_2", percent = 100 },
				{ class = "guide_structures_wood_bridges_2", percent = 100 },
				{ class = "CamoNetting", percent = 100, min = 5, max = 10 },
				{ class = "Rope", percent = 100, min = 5, max = 25 },
				{ class = "Pickaxe", percent = 100 },
				{ class = "Icepickaxe", percent = 25 },
				{ class = "Hammer", percent = 100 },
				{ class = "Icepickaxe", percent = 25 },
				{ category = "RandomTent", percent = 10 },
				--{ class = "guide_structures_wood_storage_2", percent = 100 },
			},
		},
		
		{
			category = "RandomAirDropCratePolice",
			group =
			{
				{ category = "RandomEpicWeaponPure", percent = 100 },
				{ category = "RandomRangedPolicePure", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ class = "guide_police", percent = 50 },
				{ class = "AT15", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "PX4", percent = 100 },
				{ class = "acp_45x10_hk", percent = 100 },
				{ class = "Pile_9mm", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomSilencer", percent = 100 },
				{ category = "RandomPoliceArmor", percent = 100 },
				{ category = "RandomPoliceHelmet", percent = 100 },
				{ class = "Mk18Reaver", percent = 30 },
				{ class = "CargoPantsBlack", percent = 100 },
				{ class = "CargoPantsBlack", percent = 100 },
				{ class = "MilitaryJacketBlack", percent = 100 },
				{ class = "MilitaryJacketBlack", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "MRE", percent = 100 },
				{ class = "MRE", percent = 100 },
				{ class = "Mk18Reaver", percent = 2 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "DuffelBagBlack", percent = 100 },
				{ class = "DuffelBagBlack", percent = 100 },
				{ class = "SCAR-H", percent = 15 },
				{ class = "M4A1", percent = 20 },
				{ class = "Subjugator", percent = 5 },
				{ class = "AmcoinLedger", percent = 50, min = 10, max = 58 },
				{ class = "mag_m14", percent = 50 },
				{ class = "mag_m14", percent = 50 },
				{ category = "RandomAmmo", percent = 60 },
				{ category = "RandomAmmo", percent = 60 },
				{ category = "RandomAmmo", percent = 60 },
				{ category = "CamoOpticScope", percent = 100 },
				{ class = "ForegripVertical", percent = 100 },
				{ class = "Pile_12GaugePellet", percent = 100 },
				{ class = "Pile_12GaugeSlug", percent = 100 },
				{ class = "SawedShotgun", percent = 100 },
				{ class = "C4Bricks", percent = 1, min = 1, max = 10 },
				{ class = "C4Bricks", percent = 1, min = 1, max = 10 },
				{ class = "Pile_762x39", percent = 100 },
				{ class = "WolfMeatSteakCooked", percent = 100, min = 10, max = 25 },
				{ class = "SAS12", percent = 55 },
				{ class = "MAK10", percent = 70 },
				{ class = "ReddotSight", percent = 80 },
				{ class = "9x19_mac10", percent = 70 },
				{ class = "ext_762x75", percent = 16 },
				{ class = "ext_556x75", percent = 17 },
				--{ class = "EggBlue", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggGreen", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggPink", percent = 100, min = 1, max = 5 }, -- Easter event
			},
		},
		
		{
			category = "RandomAirDropCrateCivilian",
			group =
			{
				{ category = "RandomRangedCivilianPure", percent = 100 },
				{ class = "guide_civilian", percent = 50 },
				{ class = "Rem700", percent = 100 },
				{ class = "Pile_308", percent = 100 },
				{ class = "Pile_308", percent = 100 },
				{ class = "BioFuel", percent = 100, min = 40, max = 128 },
				{ class = "AnimalFat", percent = 100, min = 20, max = 64 },
				{ class = "m14", percent = 50 },
				{ class = "m14", percent = 50 },
				{ category = "RandomAccessory", percent = 100 },
				{ class = "Headlamp", percent = 100 },
				{ class = "SheetMetal", percent = 100, min = 64, max = 64 },
				{ class = "SheetMetal", percent = 100, min = 64, max = 64 },
				{ class = "RuckSack", percent = 100 },
				{ category = "CamoHuntingScope", percent = 30 },
				{ class = "AppleFresh", percent = 100, min = 5, max = 5 },
				{ class = "Bandage", percent = 100, min = 5, max = 25 },
				{ class = "ScavengerPants", percent = 100 },
				{ class = "AppleFresh", percent = 100, min = 5, max = 25 },
				{ class = "ShoulderPadOneSide", percent = 100 },
				{ class = "ShoulderPadOneSideLeft", percent = 100 },
				{ class = "SCAAMAmalgamatedNotebook", percent = 100 },
				{ class = "Lumber", percent = 100, min = 64, max = 128 },
				{ class = "Lumber", percent = 100, min = 64, max = 128 },
				{ class = "Pyrite", percent = 100, min = 64, max = 128 },
				{ class = "Pyrite", percent = 100, min = 64, max = 128 },
				{ class = "Mk18Reaver", percent = 2 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ class = "WoodPile", percent = 100, min = 64, max = 128 },
				{ class = "WoodPile", percent = 100, min = 64, max = 128 },
				{ class = "SCAAMAmalgarmin", percent = 100 },
				{ class = "camping_water_jug", percent = 100 },
				{ class = "camping_water_jug", percent = 100 },
				{ class = "camping_lantern_red", percent = 10 },
				{ class = "camping_lantern_blue", percent = 10 },
				{ class = "camping_lantern_aqua", percent = 10 },
				{ class = "camping_lantern_green", percent = 10 },
				{ class = "camping_lantern_orange", percent = 10 },
				{ class = "camping_lantern_pink", percent = 10 },
				{ class = "camping_lantern_purple", percent = 10 },
				{ class = "camping_lantern_yellow", percent = 10 },
				{ class = "CarBattery", percent = 50 },
				{ class = "DriveBelt", percent = 50 },
				{ class = "SparkPlugs", percent = 50 },
				{ class = "Wheel", percent = 50, min = 1, max = 4 },
				{ class = "JerryCanDiesel", percent = 100 },
				{ class = "JerryCanDiesel", percent = 100 },
				{ class = "WolfMeatSteakCooked", percent = 100, min = 10, max = 25 },	
				{ class = "Sledgehammer", percent = 4 },
				{ class = "RK_Sledgehammer", percent = 4 },
				{ class = "ReddotSight", percent = 100 },
				{ class = "OPKSight", percent = 60 },
				{ class = "R3Sight", percent = 70 },
				{ category = "RandomTent", percent = 10 },
				--{ class = "EggBlue", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggGreen", percent = 100, min = 1, max = 5 }, -- Easter event
				--{ class = "EggPink", percent = 100, min = 1, max = 5 }, -- Easter event
			},
		},
		
		{
			category = "RandomAirDropCrateExplosives",
			group =
			{
				{ class = "C4Bricks", percent = 1, min = 5, max = 10 },
				{ class = "C4Bricks", percent = 1, min = 5, max = 10 },
				{ class = "C4Bricks", percent = 1, min = 5, max = 10 },
				{ class = "Sulphur", percent = 100, min = 64, max = 128 },
				{ class = "Sulphur", percent = 100, min = 64, max = 128 },
				{ class = "Sulphur", percent = 100, min = 64, max = 128 },
				{ class = "GrenadeMolotovPickup", percent = 100 },
				{ class = "GrenadeMolotovPickup", percent = 100 },
				{ class = "GrenadeMolotovPickup", percent = 100 },
				{ class = "Sulphur", percent = 100, min = 64, max = 128 },
				{ class = "Amalgaduino", percent = 100, min = 1, max = 15 },
				{ class = "Amalgaduino", percent = 50, min = 1, max = 10 },
				{ class = "guide_explosives_1", percent = 100 },
				{ class = "guide_explosives_2", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "GrenadePickup", percent = 90 },
				{ class = "GrenadePickup", percent = 80 },
				{ class = "Pile_40mmGrenade", percent = 5, min = 10, max = 3 },
				{ class = "Pile_40mmIncendiaryGrenade", percent = 10, min = 1, max = 3 },
				{ category = "Random40mmTacticalGrenades", percent = 10, min = 1, max = 3 },
				{ category = "Random40mmSmokeGrenades", percent = 10, min = 1, max = 3 },
				{ class = "guide_explosives_1", percent = 50 },
				{ class = "guide_explosives_2", percent = 50 },
				{ class = "PipebombPickup", percent = 1, min = 1, max = 3 },
				{ class = "C4TimedPickup", percent = 1, min = 1, max = 3 },
				{ class = "C4TimedPickup", percent = 25, min = 1, max = 3 },
				{ class = "C4TimedPickup", percent = 15, min = 1, max = 1 },
				{ class = "Gunpowder", percent = 100, min = 32, max = 128 },
				{ class = "Gunpowder", percent = 100, min = 32, max = 128 },
				{ class = "BioFuel", percent = 100, min = 40, max = 128 },
				{ class = "BioFuel", percent = 100, min = 40, max = 128 },
				{ class = "TrapLandminePacked", percent = 50 },
				{ class = "TrapLandminePacked", percent = 50 },
				{ class = "M97", percent = 2 },
				{ class = "Pile_Rocket", percent = 2 },
				{ class = "Pile_Rocket_AP", percent = 4 },
				{ class = "Pile_Rocket_HE", percent = 1 },
				{ class = "RocketLauncherNew", percent = 2 },
			},
		},
		
		-- Air Plane Crash
		{
			category = "AirPlaneCrashBackpack",
			classes =
			{
				-- no stowpacks - only better backpacks
				{ category = "RandomRuggedPackAirPlane", percent = 40 },
				{ category = "RandomDuffelBagAirPlane", percent = 30 },
				{ category = "RandomRuckSackAirPlane", percent = 30 },
			},
		},

		{
			category = "AirPlaneCrashCrate",
			classes =
			{
				{ class = "PlaneCrashCrate", contents="RandomCrateAirPlaneContents", percent = 100 },
			},
		},

		{
			category = "UFOCrashCrate",
			classes =
			{
				{ class = "UFOCrate", contents="RandomUFOContents", percent = 100 },
			},
		},

		{
			category = "RandomBackpackAirPlaneContents",
			group =
			{
				-- Only up to 15 slots - civilian focused, no primary weapons
				{ category = "RandomFlashlight", percent = 100 },
				{ category = "RandomConsumable", percent = 100 },
				{ category = "RandomMedical", percent = 100 },
				{ category = "RandomFood", percent = 100 },
				{ category = "RandomCraftingGuide", percent = 100 },
				{ category = "RandomClothes", percent = 100 },
				{ category = "RandomCrafting", percent = 100 },
				{ category = "RandomMaintenance", percent = 100 },
				{ category = "RandomAccessory", percent = 60 },
				{ category = "RandomAmmo", percent = 100 },
				{ category = "RandomAmmoBox", percent = 9 },
				{ category = "RandomRangedCivilianPure", percent = 24 },
				{ category = "RandomRangedMilitaryPure", percent = 7 },
				{ category = "RandomLegendaryWeapon", percent = 4 },
			},
		},

		{
			category = "RandomCrateAirPlaneContents",
			group =
			{
				-- Only 50 slots in the crate - all military focused
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomRangedMilitaryPure", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ category = "RandomAccessory", percent = 100 },
				{ class = "SCAR-H", percent = 15 },
				{ category = "RandomMilitaryClothing", percent = 100 },
				{ category = "RandomMilitaryClothing", percent = 100 },
				{ category = "RandomMilitaryClothing", percent = 100 },
				{ category = "M50Skins", percent = 2 },
				{ class = "G36C", percent = 20 },
				{ class = "M4A1", percent = 20 },
				{ class = "L1AR", percent = 20 },
				{ class = "l1ar_mag", percent = 20 },
				{ class = "T1MicroJackal", percent = 20 },
				{ class = "Jackal", percent = 20 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ class = "Deagle", percent = 35 },
				{ class = "deagle_mag", percent = 35 },
				{ class = "50calx7", percent = 50 },
				{ class = "50calx7", percent = 50 },
				{ class = "mag_m14", percent = 35 },
				{ class = "mag_m14", percent = 35 },
				{ class = "SheetMetal", percent = 100, min = 64, max = 128 },
				{ class = "BioFuel", percent = 100, min = 20, max = 128 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ class = "GrenadePickup", percent = 100 },
				{ class = "GrenadePickup", percent = 100 },
				{ category = "CamoHuntingScope", percent = 30 },
				{ category = "RandomAmmo", percent = 60 },
				{ category = "RandomAmmo", percent = 60 },
				{ class = "SpaceHelmet", percent = 5 },
				{ class = "BlastMask", percent = 13 },
				{ class = "ArmoredGhillieSuit", percent = 10 },
				{ class = "ArmoredGhillieHood", percent = 10 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				{ category = "CamoOpticScope", percent = 30 },
				{ class = "FlashbangPickup", percent = 100 },
				{ category = "RandomMilitaryBodyArmor", percent = 80 },
				{ category = "RandomMilitaryBodyArmor", percent = 80 },
				{ class = "HockeyMask", percent = 35 },
				{ class = "HockeyMaskDp", percent = 30 },
				{ class = "C4TimedPickup", percent = 7, min = 1, max = 3 },
				{ class = "M97", percent = 2 },
				{ class = "Pile_40mmGrenade", percent = 10, min = 1, max = 3 },
				{ class = "Pile_40mmIncendiaryGrenade", percent = 10, min = 1, max = 3 },
				{ category = "Random40mmTacticalGrenades", percent = 10, min = 1, max = 3 },
				{ category = "Random40mmSmokeGrenades", percent = 10, min = 1, max = 3 },
				{ class = "RocketLauncherNew", percent = 2 },
				{ category = "RandomRockets", percent = 8 },
				{ class = "Sledgehammer", percent = 4 },
				{ class = "AKVal", percent = 40 },
				{ class = "AK5D", percent = 70 },
				{ class = "SAS12", percent = 85 },
				{ class = "MAK10", percent = 90 },
			},
		},
		
		{
            category = "RandomUFOContents",
            group =
            {
                -- 30 slots in the crate - EVENT BASED
                { category = "RandomRangedMilitaryPure", percent = 100 },
                { class = "SAPOCBriefcaseClosed", percent = 5 },
                { class = "50calx7", percent = 25 },
                { category = "RandomLegendaryWeapon", percent = 25 },
                { class = "SpaceHelmet", percent = 100 },
                { class = "BlastMask", percent = 13 },
                { class= "Deagle", percent = 10 },
				{ class= "deagle_mag", percent = 10 },
				{ class = "M50Skins", percent = 2 },
                { class = "mag_m14", percent = 35 },
				{ category = "RandomDuffelBag", percent = 100 },
				{ class = "C4TimedPickup", percent = 1, min = 1, max = 3 },
				{ class = "metal_gate_lockable_6m_5_4m", percent = 7 },
				{ class = "metal_gatehouse_8m_8m", percent = 7 },
				{ category = "RandomMetalParts", percent = 6 },
				{ category = "RandomMetalParts", percent = 3 },
				{ category = "RandomMilitaryArmor", percent = 100 },
				{ category = "RandomEpicWeapon", percent = 30 },
				{ category = "RandomAmmoBox", percent = 100 },
				{ class = "AmcoinLedger", percent = 100, min = 10, max = 32 },
				{ class= "PredatorBackPack", percent = 10 },
				{ class= "IronsuitPredatorBoots", percent = 10 },
				{ class= "IronsuitPredatorChest", percent = 10 },
				{ class= "IronsuitPredatorGloves", percent = 10 },
				{ class= "IronsuitPredatorHelmet", percent = 10 },
				{ class= "IronsuitPredatorPants", percent = 10 },
				{ category = "RandomRockets", percent = 2 },
				{ category = "RandomRockets", percent = 2 },
				{ class = "RocketLauncherNew", percent = 1 },
				{ class = "RealCamoDesertHornetHelmet", percent = 10 },
				{ class = "RealCamoHornetHelmet", percent = 10 },
				{ class = "AmcoinLedger", percent = 1, min = 5, max = 25 },
				--{ category  = "HalloweenLootUFO", percent = 100 }, -- Halloween event
				-- { class= "PredatorPants", percent = 10 },
				-- { class= "PredatorBoots", percent = 10 },
				-- { class= "PredatorDuffelBag", percent = 10 },
				-- { class= "PredatorArmor", percent = 10 },
				-- { class= "PredatorGloves", percent = 10 },
				-- { class= "PredatorJacket", percent = 10 },
				-- { class= "PredatorScarf", percent = 10 },
				-- { class= "PredatorHelmet", percent = 10 },
				-- { class= "PredatorFlakVest", percent = 10 },
				-- { class= "PredatorSuitHelmet", percent = 10 },
				-- { class= "PredatorSuitGloves", percent = 10 },
				-- { class= "PredatorSuit", percent = 10 },
            },
        },
		
		-- Trader Inventory
		{
			-- Will select a random themed inventory from the array.
			category = "RandomVendorInventory",
			classes =
			{
				{ category = "VendorAKM", percent = 20 },
				{ category = "VendorAR", percent = 20 },
				{ category = "VendorSniper", percent = 20 },
				{ category = "VendorShotgun", percent = 20 },
				{ category = "VendorSMG", percent = 20 },
			},	
		},

		{
			category = "VendorAKM",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "AKM", percent = 100 },
				{ class = "762x30", percent = 100 },
				{ class = "AK74U", percent = 100 },
				{ class = "545x30", percent = 100 },
				{ class = "Pile_762x39", percent = 100 },
				{ class = "Pile_545x39", percent = 100 },
				{ class = "AmmoBox_7_62x39", percent = 75 },
				{ class = "AmmoBox_5_45x39", percent = 75 },
				{ category = "RandomAccessoryTrader", percent = 75 },
				{ category = "RandomEquipmentTrader", percent = 50 },
				{ category = "RandomMilitaryHelmet", percent = 10 },
				{ category = "RandomMilitaryArmor", percent = 10 },
				{ category = "RandomPoliceBodyArmor", percent = 10 },
				{ category = "RandomTacticalVestPure", percent = 10 },
				{ class = "SwatHelmet", percent = 10 },
			},
		},

		{
			category = "VendorSMG",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "R90", percent = 100 },
				{ class = "57x50", percent = 100 },
				{ class = "MP5", percent = 100 },
				{ class = "10mmx30", percent = 100 },
				{ class = "KrissV", percent = 100 },
				{ class = "10mmx15", percent = 100 },
				{ class = "AUMP45", percent = 100 },
				{ class = "acp_45x30", percent = 100 },
				{ class = "MAK10", percent = 100 },
				{ class = "9x19_mac10", percent = 100 },
				{ class = "uzi", percent = 100 },
				{ class = "uzi_mag", percent = 100 },
				{ class = "scorpion", percent = 100 },
				{ class = "scorpion_mag", percent = 100 },
				{ class = "Pile_10mm", percent = 100 },
				{ class = "Pile_9mm", percent = 100 },
				{ class = "Pile_57x28", percent = 100 },
				{ class = "Pile_45ACP", percent = 100 },
				{ class = "AmmoBox_10mm", percent = 75 },
				{ class = "AmmoBox_acp_45", percent = 75 },
				{ class = "AmmoBox_9mm", percent = 75 },
				{ class = "AmmoBox_5_70x28", percent = 75 },
				{ category = "RandomAccessoryTrader", percent = 75 },
				{ category = "RandomEquipmentTrader", percent = 50 },
				{ category = "RandomMilitaryHelmet", percent = 10 },
				{ category = "RandomMilitaryArmor", percent = 10 },
				{ category = "RandomPoliceBodyArmor", percent = 10 },
				{ category = "RandomTacticalVestPure", percent = 10 },
				{ class = "SwatHelmet", percent = 10 },
			},
		},

		{
			category = "VendorAR",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "AT15", percent = 100 },
				{ class = "AK5D", percent = 10 },
				{ class = "Bulldog", percent = 100 },
				{ class = "M16", percent = 100 },
				{ class = "Mk18", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ class = "Pile_556x45", percent = 100 },
				{ class = "AmmoBox_5_56x45", percent = 75 },
				{ class = "IronsightKit", percent = 100 },
				{ category = "RandomAccessoryTrader", percent = 75 },
				{ category = "RandomEquipmentTrader", percent = 50 },
				{ category = "RandomMilitaryHelmet", percent = 10 },
				{ category = "RandomMilitaryArmor", percent = 10 },
				{ category = "RandomPoliceBodyArmor", percent = 10 },
				{ category = "RandomTacticalVestPure", percent = 10 },
				{ class = "SwatHelmet", percent = 10 },
			},
		},

		{
			category = "VendorSniper",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "M40A5", percent = 100 },
				{ class = "M40x5", percent = 100 },
				{ class = "ACAW", percent = 100 },
				{ class = "762x5", percent = 100 },
				{ class = "Pile_762x51", percent = 100 },
				{ class = "Rem700", percent = 100 },
				{ class = "Pile_308", percent = 100 },
				{ class = "Sako_85", percent = 100 },
				{ class = "Model70", percent = 100 },
				{ class = "Pile_223", percent = 100 },
				{ class = "AmmoBox_223", percent = 75 },
				{ class = "AmmoBox_308", percent = 75 },
				{ class = "AmmoBox_7_62x51", percent = 75 },
				{ class = "GhillieHood1", percent = 70 },
				{ class = "GhillieSuit1", percent = 70 },
				{ class = "GhillieHood2", percent = 70 },
				{ class = "GhillieSuit2", percent = 70 },
				{ class = "GhillieHood3", percent = 70 },
				{ class = "GhillieSuit3", percent = 70 },
				{ class = "GhillieHood4", percent = 70 },
				{ class = "GhillieSuit4", percent = 70 },
				{ category = "CamoHuntingScope", percent = 70 },
				{ category = "RandomAccessoryTrader", percent = 75 },
				{ category = "RandomEquipmentTrader", percent = 50 },
			},
		},

		{
			category = "VendorShotgun",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "SAS12", percent = 10 },
				{ class = "Shotgun870Tactical", percent = 100 },
				{ class = "AA12", percent = 100 },
				{ class = "Rem870", percent = 100 },
				{ class = "SawedShotgun", percent = 100 },
				{ class = "12Gaugex8_Pellet_AA12", percent = 100 },
				{ class = "12Gaugex8_Slug_AA12", percent = 100 },
				{ class = "12Gaugex8_Beanbag_AA12", percent = 100 },
				{ class = "Pile_12GaugePellet", percent = 100 },
				{ class = "Pile_12GaugeSlug", percent = 100 },
				{ class = "Pile_12GaugeBeanbag", percent = 100 },
				{ class = "AmmoBox_12Gauge_Pellet", percent = 75 },
				{ class = "AmmoBox_12Gauge_Slug", percent = 75 },
				{ class = "AmmoBox_12Gauge_Beanbag", percent = 75 },
				{ class = "IronsightKit", percent = 100 },
				{ category = "RandomAccessoryTrader", percent = 75 },
				{ category = "RandomEquipmentTrader", percent = 50 },
				{ category = "RandomMilitaryHelmet", percent = 10 },
				{ category = "RandomMilitaryArmor", percent = 10 },
				{ category = "RandomPoliceBodyArmor", percent = 10 },
				{ category = "RandomTacticalVestPure", percent = 10 },
				{ class = "SwatHelmet", percent = 10 },
			},
		},

		{
			category = "ShadyVendorInventory",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ category = "RandomEpicWeaponTrader", percent = 25 },
				{ category = "RandomEpicAttachmentTrader", percent = 25 },
				{ category = "RandomEquipmentTrader", percent = 100 },
				{ category = "RandomMilitaryHelmet", percent = 50 },
				{ category = "RandomMilitaryArmor", percent = 50 },
				{ category = "RandomPoliceBodyArmor", percent = 75 },
				{ category = "RandomTacticalVestPure", percent = 100 },
				{ class = "AKVal", percent = 100 },
				{ class = "762x20_Akval", percent = 100 },
				{ class = "AK5D", percent = 100 },
				{ class = "556x30_ak5d", percent = 100 },
				{ class = "SAS12", percent = 100 },
				{ class = "Pile_12GaugePellet", percent = 100 },
				{ class = "Pile_12GaugeSlug", percent = 100 },
				{ class = "Pile_12GaugeBeanbag", percent = 100 },
				{ class = "SwatHelmet", percent = 75 },
				{ class = "Pile_556x45", percent = 100 },
				{ class = "Pile_762x39", percent = 100 },
				{ class = "Pile_545x39", percent = 100 },
				{ class = "556x100", percent = 100 },
				{ class = "STANAGx30", percent = 100 },
				{ category = "RandomAccessoryTrader", percent = 75 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ category = "RandomMetalParts", percent = 100 },
				{ category = "RandomMetalParts", percent = 50 },
				{ category = "RandomMetalParts", percent = 15 },
				{ category = "RandomMetalParts", percent = 10 },
				{ category = "RandomMetalParts", percent = 5 },
				{ class = "M249", percent = 5 },
			},
		},

		{
			category = "PaintVendorInventory",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "PaintCan_Aqua", percent = 80 },
				{ class = "PaintCan_Black", percent = 80 },
				{ class = "PaintCan_Blue", percent = 80 },
				{ class = "PaintCan_Brown", percent = 80 },
				{ class = "PaintCan_Gold", percent = 80 },
				{ class = "PaintCan_Green", percent = 80 },
				{ class = "PaintCan_Orange", percent = 80 },
				{ class = "PaintCan_Pink", percent = 80 },
				{ class = "PaintCan_Purple", percent = 80 },
				{ class = "PaintCan_Red", percent = 80 },
				{ class = "PaintCan_Silver", percent = 80 },
				{ class = "PaintCan_White", percent = 80 },
				{ class = "PaintCan_Yellow", percent = 80 },
				{ category = "RandomPainting", percent = 100 },
			},
		},

		{
			category = "CraftingVendorInventory",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "RK_MeleePrimary", percent = 75 },
				{ class = "RK_MeleeSecondary", percent = 75 },
				{ class = "RK_Icepickaxe", percent = 75 },
				{ class = "RK_ClothingHelmet", percent = 75 },
				{ class = "RK_FlareGun", percent = 75 },
				{ class = "RK_TranquilizerGun", percent = 75 },
				{ class = "RK_Bows", percent = 75 },
				{ class = "RK_Handguns", percent = 100 },
				{ class = "RK_Shotguns", percent = 80 },
				{ class = "RK_SubMachineguns", percent = 60 },
				{ class = "RK_AssaultRifles", percent = 40 },
				{ class = "RK_LightMachineguns", percent = 25 },
				{ class = "RK_MarksmanRifles", percent = 25 },
				{ class = "RK_SniperRifles", percent = 20 },
				{ class = "RK_Kevlar", percent = 50 },
				{ class = "RK_M50", percent = 2 },
				{ class = "RK_RocketLauncher", percent = 2 },
				{ class = "RK_M97", percent = 2 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ category = "RandomMetalParts", percent = 100 },
				{ category = "RandomMetalParts", percent = 15 },
				{ category = "RandomMetalParts", percent = 10 },
				{ category = "RandomMetalParts", percent = 5 },
				{ category = "RandomMetalParts", percent = 2.5 },
				{ category = "RandomTraderCraftingGuides", percent = 100 },
				{ category = "RandomTraderCraftingGuides", percent = 100 },
				{ category = "RandomTraderCraftingGuides", percent = 100 },
				{ category = "RandomTraderCraftingGuides", percent = 15 },
				{ category = "RandomTraderCraftingGuides", percent = 10 },
				{ category = "RandomTraderCraftingGuides", percent = 5 },
			},
		},

		{
			category = "FoodVendorInventory",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "SeedsBeets", percent = 100 },
				{ class = "SeedsBrushPeas", percent = 100 },
				{ class = "SeedsCarrots", percent = 100 },
				{ class = "SeedsPotatoes", percent = 100 },
				{ class = "SeedsWatermelons", percent = 100 },
				{ class = "SeedsPumpkins", percent = 100 },
				{ class = "SeedsRadishes", percent = 100 },
				{ class = "SeedsSnapPeas", percent = 100 },
				{ class = "SeedsTomatoes", percent = 100 },
				{ class = "guide_cooking_1", percent = 100 },
				{ class = "guide_cooking_2", percent = 100 },
				{ class = "guide_cooking_3", percent = 100 },
				{ class = "PeanutButter", percent = 100 },
				{ class = "Jelly", percent = 100 },
				{ class = "CoffeeBag", percent = 100 },
				{ class = "Bread", percent = 100 },
				{ class = "MRE", percent = 50 },
			},
		},

		{
			category = "RandomEpicWeaponTrader",
			classes =
			{
				{ class = "Mk18Reaver", percent = 10 },
				{ class = "M4A1", percent = 10 },
				{ class = "M16Vietnam", percent = 10 },
				{ class = "VSS", percent = 10 },
				{ class = "RPK", percent = 10 },
				{ class = "M4V5", percent = 10 },
				{ class = "AKMGold", percent = 10 },
				{ class = "G36C", percent = 10 },
				{ class = "SCAR-H", percent = 10 },
				{ class = "L1AR", percent = 10 },
			},
		},

		{
			category = "RandomTraderCraftingGuides",
			classes =
			{
				{ class = "guide_medical_bandages", percent = 5 },
				{ class = "guide_weapons_melee", percent = 5 },
				{ class = "guide_structures_tire_stacks", percent = 5 },
				--{ class = "guide_structures_wood_storage", percent = 4 }, -- Disabled
				{ class = "guide_structures_wood_bridges_1", percent = 4 },
				{ class = "guide_structures_wood_ramps_1", percent = 4 },
				{ class = "guide_structures_wood_stairs_1", percent = 4 },
				{ class = "guide_structures_wood_traps_2", percent = 4 },
				{ class = "guide_structures_wood_walkways_1", percent = 4 },
				{ class = "guide_structures_wood_walls_1", percent = 4 },
				{ class = "guide_structures_wood_roofs", percent = 4 },
				{ class = "guide_powered_parts_1", percent = 5 },
				{ class = "guide_traps_1", percent = 4 },
				--{ class = "guide_structures_wood_storage_2", percent = 4 }, -- Disabled
				{ class = "guide_structures_wood_bridges_2", percent = 4 },
				{ class = "guide_structures_wood_ramps_2", percent = 4 },
				{ class = "guide_structures_wood_stairs_2", percent = 4 },
				{ class = "guide_structures_wood_traps_1", percent = 4 },
				{ class = "guide_structures_wood_walkways_2", percent = 4 },
				{ class = "guide_structures_wood_walls_2", percent = 4 },
				{ class = "guide_traps_2", percent = 4 },
				{ class = "guide_structures_wood_curves", percent = 4 },
				{ class = "guide_structures_wood_gallows", percent = 4 },
				{ class = "guide_structures_wood_watchtower", percent = 4 },
				{ class = "guide_structures_wood_gatehouse", percent = 4 },
				{ class = "guide_weapons_ranged_1", percent = 4 },
				{ class = "guide_weapons_ranged_2", percent = 4 },
				{ class = "guide_weapons_ranged_3", percent = 4 },
				{ class = "SAPOCBriefcaseClosed", percent = 1 },
				{ class = "guide_ammo_1", percent = 5 },
				{ class = "guide_ammo_2", percent = 3 },
				{ class = "guide_ammo_3", percent = 1 },
				{ class = "guide_civilian", percent = 5 },
				{ class = "guide_police", percent = 4 },
				{ class = "guide_military", percent = 3 },
				{ class = "guide_hazmat", percent = 2 },
				{ class = "guide_special", percent = 1 },
				{ class = "guide_games", percent = 3 },
			},
		},

		{
			category = "RandomEpicAttachmentTrader",
			classes =
			{
				{ class = "OPKSight", percent = 17 },
				{ class = "R3Sight", percent = 17 },
				{ class = "PSOScope", percent = 17 },
				{ class = "ext_762x30", percent = 16 },
				{ class = "ext_762x75", percent = 16 },
				{ class = "ext_556x75", percent = 17 },
			},
		},

		{
			category = "RandomEquipmentTrader",
			classes =
			{
				{ class = "AntiradiationPills", percent = 5 },
				{ class = "Antibiotics", percent = 10 },
				{ class = "PotassiumIodidePills", percent = 5 },
				{ class = "WaterPurificationTablets", percent = 10 },
				{ class = "Champagne", percent = 10 },
				{ class = "ChocolateBox", percent = 10 },
				{ class = "GingerBreadMan", percent = 10 },
			},
		},

		{
			category = "RandomAccessoryTrader",
			classes =
			{
				{ class = "LaserSight", percent = 9 },
				{ class = "LaserSightGreen", percent = 8 },
				{ class = "LaserSightBlue", percent = 9 },
				{ category = "CamoOpticScope", percent = 8 },
				{ category = "CamoHuntingScope", percent = 8 },
				{ class = "PistolSilencer", percent = 8 },
				{ class = "ReflexSight", percent = 8 },
				{ class = "T1Micro", percent = 9 },
				{ class = "ForegripVertical", percent = 8 },
				{ category = "CamoSilencer", percent = 8 },
				{ class = "ReddotSight", percent = 8 },
				{ class = "FlashlightMounted", percent = 9 },
			},
		},
		
		-- recursion testing (start at Rec3 and work back to Rec1)
		{
			category = "Rec1",
			classes =
			{
				{ class = "HersheysBar", percent = 20 }, -- this is an *extremely* rare candy bar!!
				{ class = "PepsiCan", percent = 80 },
			},
		},
		
		{
            category = "RocksAndPyrite",
            classes =
            {
                { class = "Rocks", percent = 100 },
            },
        },
		
		{
            category = "IronAndRocks",
            classes =
            {
                { class = "Rocks", percent = 5 },
                { class = "IronOre", percent = 95 },
            },
        },
		
		{
            category = "CoalAndRocks",
            classes =
            {
                { class = "Rocks", percent = 5 },
                { class = "Charcoal", percent = 95 },
            },
        },
		
		{
            category = "PyriteAndRocks",
            classes =
            {
                { class = "Rocks", percent = 10 },
                { class = "Pyrite", percent = 90 },
            },
        },
		
		{
			category = "Rec2",
			classes =
			{
				{ category = "Rec1", percent = 100 },
			},
		},
		{
			category = "Rec3",
			classes =
			{
				{ category = "Rec2", percent = 100 },
			},
		},

		-- really rare testing (start at Rare3 and work back to Rare1)
		{
			category = "Rare1",
			classes =
			{
				{ class = "HersheysBar", percent = 0.001 }, -- this is an *extremely* rare candy bar (1 in 1,000,000,000)!! Golden ticket inside?
			},
		},
		{
			category = "Rare2",
			classes =
			{
				{ category = "Rare1", percent = 0.001 }, -- 1 in 1,000
			},
		},
		{
			category = "Rare3",
			classes =
			{
				{ category = "Rare2", percent = 0.001 }, -- 1 in 1,000
			},
		},
	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function ItemSpawnerManager:OnInit()
	--Log("ItemSpawnerManager:OnInit");
	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function ItemSpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function ItemSpawnerManager:OnReset()
	--Log("ItemSpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function ItemSpawnerManager:OnSpawn()
	self:Reset();
end

function ItemSpawnerManager:Reset()
	--Log("ItemSpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/ism_mods", true, true)