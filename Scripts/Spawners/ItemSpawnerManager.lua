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
				{ class = "Binoculars"          , percent = 15 },
				{ class = "Cb_radio"            , percent = 20 },
				{ class = "GridMap"             , percent = 15 },
				{ class = "Map"                 , percent = 20 },
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
			category = "RandomEpicWeapon",
			classes =
			{
				{ category = "Mk18ReaverWithMagazines"       , percent = 10   },
				{ category = "AKMGoldWithMagazines"          , percent = 13   },
				{ category = "ColtPythonGrimeyRickWithRounds", percent = 6   },
				{ category = "M4A1WithMagazines"             , percent = 9  },
				{ category = "M16VietnamWithMagazines"       , percent = 11   },
				{ category = "VSSWithMagazines"              , percent = 6   },
				{ category = "RPKWithMagazines"              , percent = 5   },
				{ category = "M4V5WithMagazines"             , percent = 5   },
				{ category = "PeacemakerWithMagazines"       , percent = 4   },
				{ class = "AxePatrick"                       , percent = 2   },
				{ class = "BaseballBatHerMajesty"            , percent = 2   },
				{ class = "KatanaBlackWidow"                 , percent = 2   }, 
				{ class = "Mk18Reaver"                       , percent = 2   },
				{ class = "PlasmaRifle"			        	 , percent = 5   },
				{ class = "SCAR-H"			        	     , percent = 5   },
                { class = "G36C"			        	     , percent = 5   },
				{ class = "RocketLauncherNew"			  	 , percent = 4   },
				{ class = "ACAW"			  	 		     , percent = 4   },
			},
		},
		
		{
			category = "RandomEpicWeaponPure",
			classes =
			{
				{ class = "Mk18Reaver"           , percent = 10 },
				{ class = "M4A1"                 , percent = 4  },
				{ class = "M16Vietnam"           , percent = 10 },
				{ class = "VSS"                  , percent = 10 },
				{ class = "RPK"                  , percent = 5  },
				{ class = "M4V5"                 , percent = 5  },
				{ class = "AKMGold"              , percent = 5  },
				{ class = "ColtPythonGrimeyRick" , percent = 2  },
				{ class = "AxePatrick"           , percent = 13 },
				{ class = "BaseballBatHerMajesty", percent = 15 },
				{ class = "KatanaBlackWidow"     , percent = 10 },
				{ class = "PlasmaRifle"          , percent = 1  },
				{ class = "SCAR-H"			     , percent = 5  },
                { class = "G36C"                , percent = 1 	    },
			},
		},

		{
			category = "RandomFlashlight",
			classes =
			{
				{ class = "Flashlight"       , percent = 1  },
				{ class = "FlashlightPistol" , percent = 14 },
				{ class = "FlashlightMounted", percent = 14 },
				{ class = "FlashlightRifle"  , percent = 14 },
				{ class = "Headlamp"         , percent = 19 },
				{ class = "HeadlampRed"      , percent = 8  },
				{ class = "Maglite"          , percent = 15 },
				{ class = "MagliteSmall"     , percent = 15 },
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
				{category = "Map"                        , percent = 10 },
				{category = "RandomConsumable"           , percent = 15  , min = 1, max = 2 },
				{category = "RandomCraftedTools"         , percent = 15  , min = 1, max = 2 },
				{category = "RandomMedical"              , percent = 25 },
				{category = "RandomCrafting"             , percent = 15 },
				{category = "RandomAccessory"            , percent = 15 },
				{category = "RandomAmmo"            	 , percent = 5 },
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
				{category = "Map"    , percent = 5 },
				{class = "CarBattery", percent = 15 },
				{class = "DriveBelt" , percent = 15 },
				{class = "SparkPlugs", percent = 15 },
			},
		},

		{
			category = "RandomF100TruckContents",
			classes =
			{
				{category = "Map"               , percent = 4 	},
				{category = "RandomAmmo"        , percent = 4 	},
				{category = "RandomCargoPants"  , percent = 4 	},
				{category = "RandomCraftedTools", percent = 2 	},
				{category = "RandomConsumable"  , percent = 10 	},
				{category = "RandomIncapacition", percent = 4 	},
				{category = "RandomRanged"      , percent = 5 	},
				{class = "CarBattery"           , percent = 5  },
				{class = "DriveBelt"            , percent = 10 	},
				{class = "SparkPlugs"           , percent = 10 	},
				{class = "AmcoinLedger"         , percent = 2 	},
				{class = "Oil"                  , percent = 80  },
				{class = "JerryCanDiesel"       , percent = 40  },
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
				{class = "CarBattery"       , percent = 15 },
				{class = "DriveBelt"        , percent = 35 },
				{class = "SparkPlugs"       , percent = 5 },
                {class = "Oil"              , percent = 25 },
                {class = "JerryCanDiesel"   , percent = 5 },
			},
		},

		{
			-- We spawn jetskis as a group so they will have more items because of their 6 hour decay
			category = "RandomJetskiContents",
			group =
			{
				{class = "CarBattery", percent = 30 },
				{class = "SparkPlugs", percent = 40 },
			},
		},

		{
			-- We spawn tractors as a group so they will have more items because of their 6 hour decay
			category = "RandomTractorContents",
			group =
			{
				{class = "CarBattery", percent = 10 },
				{class = "DriveBelt", percent = 10 },
				{class = "SparkPlugs", percent = 50 },
				{class = "TowCable", percent = 80 },
			},
		},


		{
			category = "RandomTruck5TonContents",
			classes =
			{
				{category = "RandomAccessory"    , percent =  3 },
                {category = "RandomAmmo"         , percent =  5 , min = 1, max = 6 },
                {category = "RandomCamoFace"     , percent =  5 },
                {category = "RandomCamoGloves"   , percent =  5 },
                {category = "RandomCamoHats"     , percent =  5 },
                {category = "RandomMilitaryItems", percent =  3 },
                {category = "RandomRanged"       , percent =  5 },
                {class    = "CarBattery"         , percent =  10 } ,
                {class    = "DriveBelt"          , percent =  10 } ,
                {class    = "SparkPlugs"         , percent =  20 },
                {class    = "Wheel"              , percent =  10 , min = 1, max = 6 },
                {class    = "Oil"                , percent =  4  },
                {class    = "JerryCanDiesel"     , percent =   5 },
			},
		},

		{
			category = "RandomPartyBusContents",
			classes =
			{
				{category = "Map"               , percent = 10  },
				{category = "RandomClothes"     , percent = 4   },
				{category = "RandomFlashlight"  , percent = 5   },
				{category = "RandomConsumable"  , percent = 20  },
				{category = "RandomMaintenance" , percent = 11  },
				{category = "RandomMedical"     , percent = 10  },
				{class = "CarBattery"           , percent = 5   },
				{class = "DriveBelt"            , percent = 5   },
				{class = "SparkPlugs"           , percent = 5   },
				{class = "Wheel"                , percent = 15   , min = 1, max = 4 },
				{class = "Oil"                  , percent = 5   },
				{class = "JerryCanDiesel"       , percent = 5   },
			},
		},

		{
			category = "RandomPoliceSedanSlot",
			classes =
			{
				{category = "Map"                       , percent = 5  },
				{category = "RandomFlashlight"          , percent = 5  },
				{category = "RandomConsumable"          , percent = 5  },
				{category = "RandomIncapacition"        , percent = 9  },
				{category = "RandomMedical"             , percent = 5  },
				{category = "RandomPoliceItems"         , percent = 10 },
                { class ="guide_ammunition"			    , percent = 5  },
				{class  ="CarBattery"                   , percent = 5  },
				{class  ="DriveBelt"                    , percent = 5  },
				{class  ="SparkPlugs"                   , percent = 15 },
				{ class ="AmcoinLedger"                 , percent = 6  },
			},
		},

		{
			category = "RandomPoliceSedanContents",
			group =
			{
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 40 },
				{category = "RandomPoliceSedanSlot", percent = 80 },
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
				{ class    = "AmcoinLedger"      , percent = 10  , min = 1, max = 7},
				{ category = "RandomAmmo"        , percent = 40  , min = 1, max = 9 },
				{ category = "RandomConsumable"  , percent = 80  },
				{ category = "RandomMedical"     , percent = 30  },
				{ category = "RandomMelee"       , percent = 15  },
			},
		},

		{
			category = "RandomBearLoot",
			group =
			{
				{ class = "AnimalGut"                               },
				{ class = "AnimalFat"           , min = 4, max = 5  },
				{ class = "BearMeatRaw"         , min = 5, max = 6, },
				{ class = "BearPelt"                                },
				{ class = "AmcoinLedger"        , min = 1, max = 7, },
			},
		},

		{
			category = "RandomBruteLoot",
			group =
			{
				{ category  = "RandomAmmo",             percent = 50   , min = 1, max = 6 },
                { category  = "RandomAmmo",             percent = 50   , min = 1, max = 6 },
                { category  = "RandomAmmo",             percent = 50   , min = 1, max = 6 },
				{ category  = "RandomMushroom",         percent = 50   , min = 1, max = 6 },
				{ class     = "AmcoinLedger",           percent = 30   , min = 1, max = 5},
				{ category  = "RandomSpartaGear",       percent = 1    }, 
				{ category  = "RandomMedical",          percent = 10   },
			},
		},

		{
			category = "RandomDeerLoot",
			group =
			{
				{ class = "AnimalFat"       , min = 2, max = 5  },
				{ class = "AnimalGut"       , min = 1, max = 2  },
				{ class = "DeerMeatSteakRaw", min = 3, max = 4  },
				{ class = "DeerPelt"                            },
			},
		},

		{
			category = "RandomHumanSpiderLoot",
			group =
			{
				{ class = "AmcoinLedger"                , percent = 5       , min = 1, max = 25 },
				{ category = "RandomAccessory"          , percent = 65      },
				{ category = "RandomConsumable"         , percent = 75      },
                { category = "RandomMedical"            , percent = 100     },
				{ category = "RandomAmmo"               , percent = 20      , min = 1, max = 6 },
				{ category  = "RandomBackpackContents"  , percent = 80      }, 
                { category  = "SAPOCBriefcaseClosed"    , percent = 5       }, 
			},
		},

		{
			category = "RandomWolfLoot",
			group =
			{
				{ class = "AnimalFat"       , min = 2, max = 5  },
				{ class = "AnimalGut" 					        },
				{ class = "WolfMeatSteakRaw", min = 2, max = 3  },
				{ class = "WolfPelt" 						    },
                { category = "RandomConsumable" , percent = 50 },
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
				{ category             = "Map"                   , percent = 3   },
				{ category             = "RandomCraftingGuide"   , percent = 2   },
				{ category             = "RandomClothes"         , percent = 10   },
				{ category             = "RandomCrafting"        , percent = 4   },
				{ category             = "RandomFlashlight"      , percent = 10  },
				{ category             = "RandomConsumable"      , percent = 10   , min = 1, max = 3 },
				{ category             = "RandomMaintenance"     , percent = 8 	 },
				{ category             = "RandomMedical"         , percent = 5   },
				{ class                = "AmcoinLedger"          , percent = 5   },
                { category 			   = "RandomAccessory"       , percent = 5   },
                { category 			   = "RandomMXCloth"         , percent = 3   },
				{ category             = "RandomNeck"            , percent = 5   },
			},
		},

		{
			category = "RandomTorsoContents",
			classes =
			{
				{ category = "Map"             , percent = 2 },
				{ category = "RandomConsumable", percent = 30 },
				{ category = "RandomMedical"   , percent = 30 },
                { category = "RandomMXCloth"    , percent = 15 },
			},
		},

		{
			category = "RandomWaistContents",
			classes =
			{
				{ category = "RandomConsumable", percent = 16 },
				{ category = "RandomFlashlight", percent = 1 },
				{ class = "AmcoinLedger", percent = 10 },
                { category = "RandomMXCloth", percent = 5 },
			},
		},

		{
			category = "RandomLegsContents",
			classes =
			{
				{ category = "RandomConsumable", percent = 18 },
				{ category = "RandomFlashlight", percent = 1 },
				{ category = "RandomMedical", percent = 1 },
				{ class    = "AmcoinLedger", percent = 10 },
                { category = "RandomMXCloth", percent = 5 },
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
				{ category = "HandcuffsWithKey"               , percent = 8    },
				{ category = "RandomPoliceClothing"           , percent = 18   },
				{ category = "RandomCraftingGuide"            , percent = 4    },
				{ category = "RandomPoliceWeaponWithMagazines", percent = 20.5 },
				{ category = "RandomPoliceArmor"              , percent = 15   },
				{ category = "RandomAccessory"                , percent = 5    },
				{ class = "Cb_radio"                          , percent = 5    },
				{ class = "MagliteSmall"                      , percent = 4    },
				{ class = "PistolSilencer"                    , percent = 3    },
				{ class = "Megaphone"                         , percent = 2    },
				{ class = "AmcoinLedger"                      , percent = 8    },
				{ category = "RandomTron"				      , percent = 1    },
				{ class = "SCAAMAmalgarmin"					  , percent = 5    },
				{ category  = "RandomPlasma"				  , percent = 1     , min = 3, max = 10 },
			},
		},

		{
			category = "RandomPoliceClothing",
			classes =
			{
				{ category = "RandomPoliceBodyArmor"        , percent = 25  },
				{ class    = "CargoPantsBlack"              , percent = 10  },
				{ class    = "flexcap_policefrontback_black", percent = 1   },
				{ class    = "flexcap_policefrontback_blue" , percent = 1   },
				{ class    = "flexcap_policefrontback_camo1", percent = 1   },
				{ class    = "flexcap_policefrontback_camo2", percent = 1   },
				{ class    = "flexcap_policefrontback_camo3", percent = 1   },
				{ class    = "flexcap_policefrontback_camo4", percent = 1   },
				{ category = "RandomMilitaryHelmet"           , percent = 25  },
				{ class    = "TacticalVestBlack"            , percent = 15  },
				{ class    = "TshirtPoliceBlack"            , percent = 1   },
				{ class    = "TshirtPoliceBlue"             , percent = 1   },
				{ class    = "AmcoinLedger"                 , percent = 1   },
				{ category = "RandomMXCloth"				, percent = 16  },
			},
		},

		{
			category = "RandomPoliceWeaponWithMagazines",
			classes =
			{
				{ category = "G18PistolWithMagazines"         , percent = 5 },
				{ category = "AK74UWithMagazines"             , percent = 7 },
				{ category = "AKMWithMagazines"               , percent = 8 },
				{ category = "AP85WithMagazines"              , percent = 5 },
				{ category = "Shotgun870TacticalWithMagazines", percent = 6 },
				{ category = "PX4WithMagazines"               , percent = 7 },
				{ category = "AA12WithMagazines"              , percent = 7 },
				{ category = "AUMP45WithMagazines"            , percent = 7 },
				{ category = "R90WithMagazines"               , percent = 8 },
				{ category = "Mk18ReaverWithMagazines"        , percent = 5 },
				{ category = "M4A1WithMagazines"              , percent = 7 },
				{ category = "MP5WithMagazines"               , percent = 8 },
				{ category = "MAK10WithRounds"                , percent = 8 },
				{ category = "SAS12WithRounds"                , percent = 5 },
				{ category = "TranquilizerGunWithDarts"       , percent = 3 },
				{ category = "RandomAccessory"                , percent = 4 },
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
				{ category = "RandomAccessory"                   , percent = 5 },
				{ category = "RandomCraftingGuide"               , percent = 8 },
				{ category = "RandomGhillieSuit"                 , percent = 8 },
                { category = "RandomMXCloth"         			 , percent = 8 },
				{ category = "RandomHazmatSuit"                  , percent = 8 },
				{ category = "RandomMilitaryClothing"            , percent = 6 },
				{ category = "RandomMilitaryGrenade"             , percent = 2 },
				{ category = "RandFomMilitaryWeaponWithMagazines", percent = 8 },
				{ category = "RandomPoliceWeaponWithMagazines"   , percent = 8 },
				{ category = "RandomBinoculars"            	     , percent = 3 },
				--{ class = "C4Bricks"                             , percent = 5 },
				{ class = "Cb_radio"                             , percent = 1 },
				{ class = "GasMask"                              , percent = 1 },
				{ class = "FlashlightPistol"                     , percent = 5 },
				{ class = "PistolSilencer"                       , percent = 3 },
				{ class = "Maglite"                              , percent = 2 },
				{ class = "MagliteSmall"                         , percent = 3 },
				{ class = "MilitaryCanteenPlastic"               , percent = 2 },
				{ class = "MilitaryCanteenMetal"                 , percent = 1 },
				{ class = "MRE"                                  , percent = 7 },
				{ class = "SurvivalKnife"                        , percent = 5 },
				{ class = "hesco_barrier"                        , percent = 1 },
			},
		},

		{
			category = "RandomMilitaryClothing",
			classes =
			{
				{ category = "RandomMilitaryBodyArmor"  , percent = 14.2 },
				{ category = "RandomCamoClothes"        , percent = 14.2 },
				{ category = "RandomMilitaryGloves"     , percent = 13.2 },
				{ category = "RandomMilitaryHelmet"     , percent = 13.2 },
				{ category = "RandomMilitaryJacket"     , percent = 13.2 },
				{ category = "RandomMilitaryShoes"      , percent = 13.2 },
                { category = "RandomIronSuite"          , percent = 13.2 },
				{ category = "RandomSpartaGear"         , percent = 5    },
			},
		},

        {
			category = "RandomBinoculars",
			classes =
			{
				{ class     = "Binoculars"                  , percent = 70  },
                { class     = "binoculars_arctic"           , percent = 15  },
                { class     = "binoculars_vision"           , percent = 15  },
			},
		},

		{
			category = "RandomMilitaryWeaponWithMagazines",
			classes =
			{
				{ category = "RandomPoliceWeaponWithMagazines", percent = 5  },
				{ category = "M249WithMagazines"              , percent = 5  },
				{ category = "M1911WithMagazines"             , percent = 10 },
				{ category = "M40A5WithMagazines"             , percent = 10 },
				{ category = "M16WithMagazines"               , percent = 10 },
				{ category = "AT15WithMagazines"              , percent = 10 },
				{ category = "AKMGoldWithMagazines"           , percent = 5  },
				{ category = "M4A1WithMagazines"              , percent = 10 },
				{ category = "AkValWithMagazines"             , percent = 5  },
				{ category = "AK5DWithMagazines"              , percent = 5  },
				{ category = "M97WithRounds"                  , percent = 5  },			
				{ category = "AUMP45WithMagazines"            , percent = 5  },	
				{ category = "R90WithMagazines"               , percent = 5  },	
				{ category = "SAS12WithRounds"                , percent = 5  },	
				{ category = "Shotgun870TacticalWithMagazines", percent = 5  },	

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
				{ category  = "RandomHuntingWeapons"        , percent = 25  },
				{ category  = "RandomHuntingClothing"       , percent = 15  },
				{ category  = "RandomCraftingGuide"         , percent = 23  },
				{ class     = "Cb_radio"                    , percent = 5   },
				{ class     = "Map"                         , percent = 2   },
				{ category  = "RandomBinoculars"            , percent = 10  },
				{ class     = "HuntingScope"                , percent = 10  },
                { class     = "HuntingScopeRealCamo"        , percent = 5   },
                { class     = "HuntingScopeRealCamoDesert"  , percent = 5   },

			},
		},

		-- Civilian Hunting Weapons
		{
			category = "RandomHuntingWeapons",
			classes =
			{
				{ category = "Rem700WithRounds"					, percent = 25 },
				{ category = "RandomPoliceWeaponWithMagazines"	, percent = 25 },
				{ category = "Rem870WithRounds"					, percent = 20 },
				{ category = "Sako85WithRounds"					, percent = 20 },
				{ category = "CrossbowWithMagazines"			, percent = 5  },
				{ class    = "HuntingKnife"						, percent = 5  },
			},
		},

		-- Civilian Hunting Clothing 
		-- camo1 is the duck type camo good for civilian use
		{
			category = "RandomHuntingClothing",
			classes =
			{
				{ class = "CargoPantsCamo1" , percent = 25 },
				{ class = "WoolGlovesCamo1" , percent = 10 },
				{ class = "CottonShirtBrown", percent = 20 },
				{ class = "RuggedPackCamo1" , percent = 20 },
				{ class = "TshirtCamo1"     , percent = 25 },
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
				{ class = "christmas_light_string"        , percent = 4 },
				{ class = "christmas_candle"              , percent = 5 },
				{ class = "christmas_gift_pile"           , percent = 5 },
				{ class = "christmas_rug_01"              , percent = 5 },
				{ class = "christmas_rug_02"              , percent = 5 },
				{ class = "ChristmasHat"                  , percent = 5 },
				{ class = "snowman_small"                 , percent = 5 },
				{ class = "Peacemaker"                    , percent = 5 },
				{ class = "ScavengerShirt"                , percent = 5 },
				{ class = "ScavengerPants"                , percent = 5 },
				{ class = "R90"                           , percent = 7 },
				{ class = "AK74U"                         , percent = 7 },
				{ class = "MP5"                           , percent = 5 },
				{ class = "AUMP45"                        , percent = 6 },
				{ class = "Mk18Reaver"                    , percent = 5 },
				{ class = "AT15"                          , percent = 7 },
				{ class = "Model1873"                     , percent = 6 },
                { category = "RandomIronSuite"			  , percent = 5 },
				{ category = "RandomSpartaGear"           , percent = 2 },
                { class = "AnonMask"                      , percent = 1 },
			},
		},
		
		{
			category = "ChristmasPresentRare",
			classes =
			{
				{ class = "snowman"                 , percent = 2   },
				{ class = "EggNog"                  , percent = 0.5 },
				{ class = "GingerBreadMan"          , percent = 0.5 },
				{ class = "M4A1"                    , percent = 3   },
				{ class = "RPK"                     , percent = 2   },
				{ class = "AKMGold"                 , percent = 2   },
				{ class = "Mk18Reaver"              , percent = 2   },
				{ category = "RandomSpartaGear"     , percent = 3   },
                { class = "SAPOCBriefcaseClosed"    , percent = 8   }, 
                { category = "RandomCargador"       , percent = 67  },
                { category = "RandomSkullGear"      , percent = 3.5 },
                { category = "EventHelmets"         , percent = 3.5 },
                { class = "AnonMask"                , percent = 3   },
			},
		},
		
		{
			category = "RandomBpartPresent",
			classes =
			{
				{ class = "glass_doorway_3m_2m"         , percent = 20 },
				{ class = "glass_doorway_3m_4m"         , percent = 20 },
				{ class = "glass_doorway_3m_4m_v2"      , percent = 10 },
				{ class = "glass_door_2m_1m"            , percent = 20 },
				{ class = "glass_door_3m_2m"            , percent = 20 },
                { class = "door_glass_white"            , percent = 10 },
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
				{ category = "RandomPumpkins"     , percent = 15 },
				{ class = "halloween_light_string", percent = 17 },
				{ class = "halloween_creepy_bunny", percent = 20 },
				{ class = "SkullMask"             , percent = 6  },
				{ class = "SkullMaskSilver"       , percent = 3  },
				{ class = "R90"                   , percent = 4  },
				{ class = "AK74U"                 , percent = 4  },
				{ class = "MP5"                   , percent = 4  },
				{ class = "AUMP45"                , percent = 4  },
				{ class = "Mk18Reaver"            , percent = 4  },
				{ class = "AT15"                  , percent = 4  },
				{ class = "Model1873"             , percent = 2  },
				{ class = "Peacemaker"            , percent = 2  },
				{ class = "ScavengerShirt"        , percent = 4  },
				{ class = "ScavengerPants"        , percent = 4  },
				{ class = "wood_coffin"           , percent = 3  } ,
			},
		},
		
		{
			category = "HalloweenLootUFO",
			classes =
			{
				{ category = "RandomPumpkins"        , percent = 10.5 },
				{ category = "RandomCivilianHelmet"  , percent = 5    },
				{ class = "halloween_light_string"   , percent = 10.5 },
				{ class = "halloween_creepy_bunny"   , percent = 10   },
				{ class = "halloween_creepy_bear"    , percent = 10   },
				{ class = "SkullMask"                , percent = 12.5 },
				{ class = "SkullMaskSilver"          , percent = 12.5 },
				{ class = "SkullMaskGold"            , percent = 12.5 },
				{ class = "wood_coffin"              , percent = 6.5  },
				{ class = "SalazarSkull"             , percent = 1    },
			},
		},
		
		{
			category = "HalloweenBagRare",
			classes =
			{
				{ category = "RandomAmmo"                , percent = 8   , min = 1, max = 6 },
				{ category = "RandomPumpkins"            , percent = 8   },
				{ class = "ConcreteBag"                  , percent = 5   , min = 1, max = 3 },
				{ class = "halloween_candle"             , percent = 15  },
				{ class = "halloween_creepy_bear"        , percent = 20  },
				{ class = "SkullMask"                    , percent = 10  },
				{ class = "SkullMaskGold"                , percent = 7   },
				{ category = "RandomEpicAttachmentTrader", percent = 7   },
				{ class = "AK5D"                         , percent = 7   },
				{ category = "RandomEpicWeaponTrader"    , percent = 3   },
				{ class = "SpaceHelmet"                  , percent = 3   },
				{ class = "wood_coffin"                  , percent = 3   },
			},
		},
		
		{
			category = "EventHelmets",
			classes =
			{
				{ class = "SpaceHelmet"              , percent = 10 },
				{ class = "ScavengerHelmet"          , percent = 10 },
                { class = "SpartanHelmet"            , percent = 10 },
                { class = "IronsuitPinkHelmet"       , percent = 10 },
                { class = "IronsuitWarMachineHelmet" , percent = 10 },
                { class = "daftpunkhelmet2"          , percent = 10 },
                { class = "daftpunkhelmet"           , percent = 10 },
                { class = "ethahelmetgreen"          , percent = 10 },
                { class = "ethahelmet"               , percent = 10 },
                { category = "RandomCivilianHelmet"  , percent = 10 },
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
				{ class = "RuggedPack"          , contents="RandomBackpackContents", percent = 10  },
				{ class = "RuggedPackBlack"     , contents="RandomBackpackContents", percent = 10  },
				{ class = "RuggedPackBrown"     , contents="RandomBackpackContents", percent = 10  },
				{ class = "RuggedPackCamo1"     , contents="RandomBackpackContents", percent = 10  },
				{ class = "RuggedPackCamo2"     , contents="RandomBackpackContents", percent = 5   },
				{ class = "RuggedPackCamo3"     , contents="RandomBackpackContents", percent = 10  },
				{ class = "RuggedPackCamo4"     , contents="RandomBackpackContents", percent = 5   },
				{ class = "RuggedPackGreen"     , contents="RandomBackpackContents", percent = 10  },
				{ class = "RuggedPackGreenCamo1", contents="RandomBackpackContents", percent = 5   },
				{ class = "RuggedPackGreenCamo2", contents="RandomBackpackContents", percent = 10  },
				{ class = "RuggedPackGreenCamo3", contents="RandomBackpackContents", percent = 5   },
				{ class = "RuggedPackGreenCamo4", contents="RandomBackpackContents", percent = 10  },
			},
		},

		{
			category = "RandomRuggedPackAirPlane",
			classes =
			{
				{ class = "RuggedPack"          , contents="RandomBackpackAirPlaneContents", percent = 10  },
				{ class = "RuggedPackBlack"     , contents="RandomBackpackAirPlaneContents", percent = 10  },
				{ class = "RuggedPackBrown"     , contents="RandomBackpackAirPlaneContents", percent = 10  },
				{ class = "RuggedPackCamo1"     , contents="RandomBackpackAirPlaneContents", percent = 10  },
				{ class = "RuggedPackCamo2"     , contents="RandomBackpackAirPlaneContents", percent = 5   },
				{ class = "RuggedPackCamo3"     , contents="RandomBackpackAirPlaneContents", percent = 10  },
				{ class = "RuggedPackCamo4"     , contents="RandomBackpackAirPlaneContents", percent = 5   },
				{ class = "RuggedPackGreen"     , contents="RandomBackpackAirPlaneContents", percent = 10  },
				{ class = "RuggedPackGreenCamo1", contents="RandomBackpackAirPlaneContents", percent = 5   },
				{ class = "RuggedPackGreenCamo2", contents="RandomBackpackAirPlaneContents", percent = 10  },
				{ class = "RuggedPackGreenCamo3", contents="RandomBackpackAirPlaneContents", percent = 5   },
				{ class = "RuggedPackGreenCamo4", contents="RandomBackpackAirPlaneContents", percent = 10  },
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
				{ class = "DuffelBag"          , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagBlack"     , contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagGreen"     , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagGreenCamo1", contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagGreenCamo2", contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagGreenCamo3", contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagGreenCamo4", contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagTanCamo1"  , contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagTanCamo2"  , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagTanCamo3"  , contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagTanCamo4"  , contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagUrbanCamo1", contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagUrbanCamo2", contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagUrbanCamo3", contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagUrbanCamo4", contents="RandomBackpackContents", percent = 5  },
				{ class = "DuffelBagLightBlue" , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagOGreen"    , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagYellow"    , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagBlue"      , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagPurple"    , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagPink"      , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagRed"       , contents="RandomBackpackContents", percent = 4  },
				{ class = "DuffelBagWhite"     , contents="RandomBackpackContents", percent = 4  },

			},
		},

		{
			category = "RandomDuffelBagAirPlane",
			classes =
			{
				{ class = "DuffelBag"          , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagBlack"     , contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagGreen"     , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagGreenCamo1", contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagGreenCamo2", contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagGreenCamo3", contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagGreenCamo4", contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagTanCamo1"  , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagTanCamo2"  , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagTanCamo3"  , contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagTanCamo4"  , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagUrbanCamo1", contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagUrbanCamo2", contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagUrbanCamo3", contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagUrbanCamo4", contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagLightBlue" , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagOGreen"    , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagYellow"    , contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagBlue"      , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagPurple"    , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagPink"      , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
				{ class = "DuffelBagRed"       , contents="RandomBackpackAirPlaneContents"  , percent = 5 },
				{ class = "DuffelBagWhite"     , contents="RandomBackpackAirPlaneContents"  , percent = 4 },
			},
		},

		{
			category = "RandomStowPack",
			classes =
			{
				{ class = "StowPackBlack" , contents="RandomBackpackContents", percent = 10 },
				{ class = "StowPackBlue"  , contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackGreen" , contents="RandomBackpackContents", percent = 10 },
				{ class = "StowPackOrange", contents="RandomBackpackContents", percent = 10 },
				{ class = "StowPackPink"  , contents="RandomBackpackContents", percent = 10 },
				{ class = "StowPackPurple", contents="RandomBackpackContents", percent = 10 },
				{ class = "StowPackRed"   , contents="RandomBackpackContents", percent = 10 },
				{ class = "StowPackWhite" , contents="RandomBackpackContents", percent = 15 },
				{ class = "StowPackYellow", contents="RandomBackpackContents", percent = 10 },
			},
		},

		-- Face
		{
			category = "RandomBandana",
			classes =
			{
				{ class = "BandanaBlack" , percent = 8 },
				{ class = "BandanaBrown" , percent = 8 },
				{ class = "BandanaCamo1" , percent = 8 },
				{ class = "BandanaCamo2" , percent = 8 },
				{ class = "BandanaCamo3" , percent = 8 },
				{ class = "BandanaCamo4" , percent = 9 },
				{ class = "BandanaGray"  , percent = 8 },
				{ class = "BandanaGreen" , percent = 9 },
				{ class = "BandanaKhaki" , percent = 8 },
				{ class = "BandanaOrange", percent = 9 },
				{ class = "BandanaPink"  , percent = 8 },
				{ class = "BandanaRed"   , percent = 9 },
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
				{ class = "CombatBootsTan", percent = 10 },
			},
		},

		{
			category = "RandomHitops",
			classes =
			{
				{ class = "HitopsBlack" , percent = 16 },
				{ class = "HitopsBlue"  , percent = 14 },
				{ class = "HitopsGreen" , percent = 14 },
				{ class = "HitopsPink"  , percent = 14 },
				{ class = "HitopsPurple", percent = 14 },
				{ class = "HitopsRed"   , percent = 14 },
				{ class = "HitopsYellow", percent = 14 },
			},
		},

		{
			category = "RandomSneakers",
			classes =
			{
				{ class = "Sneakers"          , percent = 6.25 },
				{ class = "SneakersBlack"     , percent = 6.25 },
				{ class = "SneakersBlackBlue" , percent = 6.25 },
				{ class = "SneakersBlackGreen", percent = 6.25 },
				{ class = "SneakersBlackPink" , percent = 6.25 },
				{ class = "SneakersBlackRed"  , percent = 6.25 },
				{ class = "SneakersBlueBlack" , percent = 6.25 },
				{ class = "SneakersBrown"     , percent = 6.25 },
				{ class = "SneakersGreenBlack", percent = 6.25 },
				{ class = "SneakersPinkBlack" , percent = 6.25 },
				{ class = "SneakersRedBlack"  , percent = 6.25 },
				{ class = "SneakersSilver"    , percent = 6.25 },
				{ class = "SneakersWhite"     , percent = 6.25 },
				{ class = "SneakersWhiteBlue" , percent = 6.25 },
				{ class = "SneakersWhiteGreen", percent = 6.25 },
				{ class = "SneakersWhitePink" , percent = 6.25 },
			},
		},

		{
			category = "RandomSteeltoedBoots",
			classes =
			{
				{ class = "SteeltoedBootsBlack", percent = 50 },
				{ class = "SteeltoedBootsBrown", percent = 50 },
			},
		},


		-- Hands
		{
			category = "RandomMilitaryGloves",
			classes =
			{
				{ class = "MilitaryGlovesBlack", percent = 25 },
				{ class = "MilitaryGlovesBrown", percent = 25 },
				{ class = "MilitaryGlovesGreen", percent = 25 },
				{ class = "MilitaryGloves"	   , percent = 25 },
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
				{ class = "MilitaryHelmetGreen"      , percent = 8 },
				{ class = "MilitaryHelmetGreenCamo1" , percent = 7 },
				{ class = "MilitaryHelmetGreenCamo2" , percent = 7 },
				{ class = "MilitaryHelmetGreenCamo3" , percent = 7 },
				{ class = "MilitaryHelmetGreenCamo4" , percent = 7 },
				{ class = "MilitaryHelmetTan"        , percent = 8 },
				{ class = "MilitaryHelmetTanCamo1"   , percent = 7 },
				{ class = "MilitaryHelmetTanCamo2"   , percent = 7 },
				{ class = "MilitaryHelmetTanCamo3"   , percent = 7 },
				{ class = "MilitaryHelmetTanCamo4"   , percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo1" , percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo2" , percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo3" , percent = 7 },
				{ class = "MilitaryHelmetUrbanCamo4" , percent = 4 },
                { class = "AssaultHelmet"            , percent = 3 },
                
			},
		},
		
		{
			category = "RandomArmorTier3",
			classes = 
			{
				{ class = "MilitaryHelmetGreen", percent = 6 },
				{ class = "MilitaryHelmetGreenCamo1", percent = 5 },
				{ class = "MilitaryHelmetGreenCamo2", percent = 6 },
				{ class = "MilitaryHelmetGreenCamo3", percent = 5 },
				{ class = "MilitaryHelmetGreenCamo4", percent = 6 },
				{ class = "MilitaryHelmetTan", percent = 6 },
				{ class = "MilitaryHelmetTanCamo1", percent = 5 },
				{ class = "MilitaryHelmetTanCamo2", percent = 6 },
				{ class = "MilitaryHelmetTanCamo3", percent = 6 },
				{ class = "MilitaryHelmetTanCamo4", percent = 5 },
				{ class = "MilitaryHelmetUrbanCamo1", percent = 6 },
				{ class = "MilitaryHelmetUrbanCamo2", percent = 5 },
				{ class = "MilitaryHelmetUrbanCamo3", percent = 6 },
				{ class = "MilitaryHelmetUrbanCamo4", percent = 5 },
				{ class = "FlakVestGreen", percent = 6 },
				{ class = "FlakVestGreenCamo1", percent = 5 },
				{ class = "FlakVestTan", percent = 6 },
				{ class = "FlakVestTanCamo1", percent = 5 },
			},
		},
		
		{
			category = "RandomArmorTier2",
			classes = 
			{
				{ class = "PoliceVestBlack", percent = 33 },
				{ class = "PoliceVestBlue", percent = 33 },
				{ class = "SwatHelmet", percent = 34 },
			},
		},
		
		{
			category = "RandomArmorTier1",
			classes = 
			{
				{ class = "FootballHelmet", percent = 2.5 },
				{ class = "FootballHelmetAmerica", percent = 2.5 },
				{ class = "FootballHelmetBlack", percent = 2.5 },
				{ class = "FootballHelmetBlue", percent = 2.5 },
				{ class = "FootballHelmetFabulous", percent = 2.5 },
				{ class = "FootballHelmetGold", percent = 2.5 },
				{ class = "FootballHelmetGreen", percent = 2.5 },
				{ class = "FootballHelmetRed", percent = 2.5 },
				{ class = "FootballHelmetStripedBlack", percent = 2.5 },
				{ class = "FootballHelmetStripedBlue", percent = 2.5 },
				{ class = "FootballHelmetStripedGreen", percent = 2.5 },
				{ class = "FootballHelmetStripedRed", percent = 2.5 },
				{ class = "FootballHelmetStripedTeal", percent = 2.5 },
				{ class = "FootballHelmetStripedYellow", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedBlack", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedBlue", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedGreen", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedRed", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedTeal", percent = 2.5 },
				{ class = "FootballHelmetWhiteStripedYellow", percent = 2.5 },
				{ class = "FootballHelmetYellow", percent = 2.5 },
				{ class = "MotorcycleHelmetCarbon", percent = 2.5 },
				{ class = "MotorcycleHelmetGold", percent = 2.5 },
				{ class = "MotorcycleHelmetWhite", percent = 2.5 },
				{ class = "FootballPads", percent = 2.5 },
				{ class = "TacticalVestBlack", percent = 2.5 },
				{ class = "TacticalVestGreen", percent = 2.5 },
				{ class = "TacticalVestGreenCamo1", percent = 2.5 },
				{ class = "TacticalVestGreenCamo2", percent = 2.5 },
				{ class = "TacticalVestGreenCamo3", percent = 2.5 },
				{ class = "TacticalVestGreenCamo4", percent = 2.5 },
				{ class = "TacticalVestTan", percent = 2.5 },
				{ class = "TacticalVestTanCamo1", percent = 2.5 },
				{ class = "TacticalVestTanCamo2", percent = 2.5 },
				{ class = "TacticalVestTanCamo3", percent = 2.5 },
				{ class = "TacticalVestTanCamo4", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo1", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo2", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo3", percent = 2.5 },
				{ class = "TacticalVestUrbanCamo4", percent = 2.5 },
			},
		},
		
		{
			category = "RandomCivilianHelmet",
			classes = 
			{
				{ class = "FootballHelmet"                   , percent = 3 },
				{ class = "FootballHelmetAmerica"            , percent = 3 },
				{ class = "FootballHelmetBlack"              , percent = 3 },
				{ class = "FootballHelmetBlue"               , percent = 3 },
				{ class = "FootballHelmetFabulous"           , percent = 3 },
				{ class = "FootballHelmetGold"               , percent = 3 },
				{ class = "FootballHelmetGreen"              , percent = 3 },
				{ class = "FootballHelmetRed"                , percent = 3 },
				{ class = "FootballHelmetStripedBlack"       , percent = 3 },
				{ class = "FootballHelmetStripedBlue"        , percent = 3 },
				{ class = "FootballHelmetStripedGreen"       , percent = 4 },
				{ class = "FootballHelmetStripedRed"         , percent = 3 },
				{ class = "FootballHelmetStripedTeal"        , percent = 3 },
				{ class = "FootballHelmetStripedYellow"      , percent = 3 },
				{ class = "FootballHelmetWhiteStripedBlack"  , percent = 3 },
				{ class = "FootballHelmetWhiteStripedBlue"   , percent = 3 },
				{ class = "FootballHelmetWhiteStripedGreen"  , percent = 3 },
				{ class = "FootballHelmetWhiteStripedRed"    , percent = 3 },
				{ class = "FootballHelmetWhiteStripedTeal"   , percent = 3 },
				{ class = "FootballHelmetWhiteStripedYellow" , percent = 3 },
				{ class = "FootballHelmetYellow"             , percent = 2 },
				{ class = "BikeHelmetBlack"                  , percent = 2 },
				{ class = "BikeHelmetBlue"                   , percent = 2 },
				{ class = "BikeHelmetGreen"                  , percent = 2 },
				{ class = "BikeHelmetPink"                   , percent = 1 },
				{ class = "BikeHelmetPurple"                 , percent = 1 },
				{ class = "BikeHelmetRed"                    , percent = 1 },
				{ class = "BikeHelmetWhite"                  , percent = 1 },
				{ class = "BikeHelmetYellow"                 , percent = 1 },
				{ class = "MotorcycleHelmetCarbon"           , percent = 2 },
				{ class = "MotorcycleHelmetGold"             , percent = 2 },
				{ class = "MotorcycleHelmetWhite"            , percent = 3 },	
                { class = "MotorcycleHelmetBeach"            , percent = 3 },
                { class = "MotorcycleHelmetSynthwave"        , percent = 3 },
                { class = "MotorcycleHelmetSpitfire"         , percent = 3 },
                { class = "MotorcycleHelmetSkull"            , percent = 2 },
                { class = "MotorcycleHelmetChinese"          , percent = 2 },
                { class = "daftpunkhelmet2"                  , percent = 1.5 },
                { class = "daftpunkhelmet"                   , percent = 1.5 },
                { class = "ethahelmetgreen"                  , percent = 1.5 },
                { class = "ethahelmet"                       , percent = 1.5 },
                
				
			},
		},

		-- Legs
		{
			category = "RandomBlueJeans2",
			classes =
			{
				{ class = "BlueJeans"		, contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2"		, contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2Brown"	, contents="RandomLegsContents", percent = 25 },
				{ class = "BlueJeans2Green"	, contents="RandomLegsContents", percent = 25 },
			},
		},

		{
			category = "RandomCargoPants",
			classes =
			{
				{ class = "CargoPantsBlack"     , contents="RandomLegsContents", percent = 5 },
				{ class = "CargoPantsCamo1"     , contents="RandomLegsContents", percent = 6 },
				{ class = "CargoPantsCamo2"     , contents="RandomLegsContents", percent = 6 },
				{ class = "CargoPantsCamo3"     , contents="RandomLegsContents", percent = 6 },
				{ class = "CargoPantsCamo4"     , contents="RandomLegsContents", percent = 5 },
				{ class = "CargoPantsGreen"     , contents="RandomLegsContents", percent = 5 },
				{ class = "CargoPantsGreenCamo1", contents="RandomLegsContents", percent = 8 },
				{ class = "CargoPantsGreenCamo2", contents="RandomLegsContents", percent = 8 },
				{ class = "CargoPantsGreenCamo3", contents="RandomLegsContents", percent = 8 },
				{ class = "CargoPantsGreenCamo4", contents="RandomLegsContents", percent = 8 },
				{ class = "CargoPantsTan"       , contents="RandomLegsContents", percent = 3 },
				{ class = "CargoPantsUrbanCamo1", contents="RandomLegsContents", percent = 8 },
				{ class = "CargoPantsUrbanCamo2", contents="RandomLegsContents", percent = 8 },
				{ class = "CargoPantsUrbanCamo3", contents="RandomLegsContents", percent = 8 },
				{ class = "CargoPantsUrbanCamo4", contents="RandomLegsContents", percent = 8 },
			},
		},

		{
			category = "RandomCargoShorts",
			classes =
			{
				{ class = "CargoShortsBlack"      , contents="RandomLegsContents", percent = 9 },
				{ class = "CargoShortsBlue"       , contents="RandomLegsContents", percent = 9 },
				{ class = "CargoShortsBrightBlue" , contents="RandomLegsContents", percent = 4 },
				{ class = "CargoShortsBrightGreen", contents="RandomLegsContents", percent = 4 },
				{ class = "CargoShortsBrightPink" , contents="RandomLegsContents", percent = 7 },
				{ class = "CargoShortsBrightRed"  , contents="RandomLegsContents", percent = 8 },
				{ class = "CargoShortsBrown"      , contents="RandomLegsContents", percent = 7 },
				{ class = "CargoShortsCamo1"      , contents="RandomLegsContents", percent = 8 },
				{ class = "CargoShortsCamo2"      , contents="RandomLegsContents", percent = 8 },
				{ class = "CargoShortsCamo3"      , contents="RandomLegsContents", percent = 8 },
				{ class = "CargoShortsCamo4"      , contents="RandomLegsContents", percent = 8 },
				{ class = "CargoShortsDarkGrey"   , contents="RandomLegsContents", percent = 8 },
				{ class = "CargoShortsGreen"      , contents="RandomLegsContents", percent = 3 },
				{ class = "CargoShortsGrey"       , contents="RandomLegsContents", percent = 3 },
				{ class = "CargoShortsTan"        , contents="RandomLegsContents", percent = 3 },
				{ class = "CargoShortsYellow"     , contents="RandomLegsContents", percent = 3 },
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
				{ class = "ButtonUpShirtBlack"            , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackChekered"    , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackDots"        , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlackStriped"     , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlue"             , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueChekered"     , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueDots"         , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtBlueHawaiian"     , contents="RandomTorsoContents", percent = 4},
				{ class = "ButtonUpShirtBlueStriped"      , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreenChekered", contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreenStriped" , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGrey"         , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyChekered" , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyDots"     , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtDarkGreyStriped"  , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreen"            , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenChekered"    , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenHawaiian"    , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreenStriped"     , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGrey"             , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreyChekered"     , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtGreyStriped"      , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPink"             , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPinkChekered"     , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPinkStriped"      , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurple"           , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleChekered"   , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleHawaiian"   , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtPurpleStriped"    , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRed"              , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedChekered"      , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedHawaiian"      , contents="RandomTorsoContents", percent = 3},
				{ class = "ButtonUpShirtRedDots"          , contents="RandomTorsoContents", percent = 3},
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
				
				{ category = "RandomAllHazmatSuit"     , percent = 50 },
				{ category = "RandomAllHazmatMask"     , percent = 35 },
				{ category = "RandomAllGasCanisterPack", percent = 15 },
			}	
		},
		
		{
			category = "RandomAllHazmatSuit",
			classes = 
			{
				{ class = "HazmatSuitBlack"       , percent = 9   },
				{ class = "HazmatSuitBlue"        , percent = 9   },
				{ class = "HazmatSuitGreen"       , percent = 9   },
				{ class = "HazmatSuitPink"        , percent = 9.5 },
				{ class = "HazmatSuitOrange"      , percent = 9   },
				{ class = "HazmatSuitRed"         , percent = 9   },
				{ class = "HazmatSuitWhite"       , percent = 9   },
				{ class = "HazmatSuitYellow"      , percent = 9   },
				{ class = "HazmatSuitBrownCamo"   , percent = 9   },
				{ class = "HazmatSuitGreenCamo"   , percent = 9   },
				{ class = "HazmatSuitPurple"      , percent = 9.5 },
			}	
		},
		
		{
			category = "RandomAllHazmatMask",
			classes = 
			{
				{ class = "HazmatMask"      , percent = 12.5 },
				{ class = "HazmatMaskBlack" , percent = 12.5 },
				{ class = "HazmatMaskBlue"  , percent = 12.5 },
				{ class = "HazmatMaskGreen" , percent = 12.5 },
				{ class = "HazmatMaskPink"  , percent = 12.5 },
				{ class = "HazmatMaskOrange", percent = 12.5 },
				{ class = "HazmatMaskWhite" , percent = 12.5 },
				{ class = "HazmatMaskYellow", percent = 12.5 },
			}	
		},
		
		{
			category = "RandomAllGasCanisterPack",
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
				{ category = "RandomAllHazmatSuit", percent = 100 },
				{ category = "RandomAllHazmatMask", percent = 100 },
				{ category = "RandomAllGasCanisterPack", percent = 100 },
			}	
		},
		

		{
			category = "RandomHoodie",
			classes = 
			{
				{class = "Hoodie"                       , contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlackGreyDesign1"       , contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlackWhiteDesign4"      , contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlueBlackDesign4"       , contents="RandomTorsoContents", percent = 4},
				{class = "HoodieBlueDesign2"            , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieBlueWhiteDesign4"       , contents="RandomTorsoContents", percent = 4},
				{class = "HoodieCapitalMunch"           , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieEagle"                  , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreenBlackDesign4"      , contents="RandomTorsoContents", percent = 4},
				{class = "HoodieGreenDesign2"           , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreenWhiteDesign4"      , contents="RandomTorsoContents", percent = 4},
				{class = "HoodieGrey"                   , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieGreyDarkGreyDesign1"    , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieOrangeBlackDesign4"     , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePinkDesign2"            , contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixel"                  , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelBlackGreyDesign5"  , contents="RandomTorsoContents", percent = 4},
				{class = "HoodiePixelBlueBlackDesign5"  , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreenBlackDesign5" , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyBlueDesign5"   , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyDesign5"       , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyGreenDesign5"  , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyOrangeDesign5" , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelGreyRedDesign5"    , contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelOrangeBlackDesign5", contents="RandomTorsoContents", percent = 3},
				{class = "HoodiePixelRedBlackDesign5"   , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedBlackDesign4"        , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieRedDesign2"             , contents="RandomTorsoContents", percent = 2},
				{class = "HoodieRedWhiteDesign4"        , contents="RandomTorsoContents", percent = 3},
				{class = "HoodieSerk"                   , contents="RandomTorsoContents", percent = 3},
                {class = "PoleronWU"                    , contents="RandomTorsoContents", percent = 2},
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
				{ class = "MilitaryJacketBlack", contents="RandomTorsoContents", percent = 5 },
				{ class = "MilitaryJacketGreen", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketGreenCamo1", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketGreenCamo2", contents="RandomTorsoContents", percent = 5 },
				{ class = "MilitaryJacketGreenCamo3", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketGreenCamo4", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketTan", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketTanCamo1", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketTanCamo2", contents="RandomTorsoContents", percent = 5 },
				{ class = "MilitaryJacketTanCamo3", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketTanCamo4", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketUrbanCamo1", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketUrbanCamo2", contents="RandomTorsoContents", percent = 5 },
				{ class = "MilitaryJacketUrbanCamo3", contents="RandomTorsoContents", percent = 2 },
				{ class = "MilitaryJacketUrbanCamo4", contents="RandomTorsoContents", percent = 2 },
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
		
		-- Ghillie Suits

		{
			category = "RandomGhillieSuit",
			classes = 
			{
				{ category = "RandomGhillieSuitParts", percent=99.6 },
				{ category = "GhillieSuit1Full", percent=0.1 },
				{ category = "GhillieSuit2Full", percent=0.1 },
				{ category = "GhillieSuit3Full", percent=0.1 },
				{ category = "GhillieSuit4Full", percent=0.1 },
			},
		},

		{
			category = "RandomGhillieSuitParts",
			classes = 
			{
				{ class = "GhillieSuit1", percent= 12.5 },
				{ class = "GhillieHood1", percent= 12.5 },
				{ class = "GhillieSuit2", percent= 12.5 },
				{ class = "GhillieHood2", percent= 12.5 },
				{ class = "GhillieSuit3", percent= 12.5 },
				{ class = "GhillieHood3", percent= 12.5 },
				{ class = "GhillieSuit4", percent= 12.5 },
				{ class = "GhillieHood4", percent= 12.5 },
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
				{ class = "FlakVestTanCamo1", percent = 25 },
				{ class = "FlakVestGreen", percent = 25 },
				{ class = "FlakVestGreenCamo1", percent = 25 },
				{ class = "FlakVestTan", percent = 25 },
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
				{ class = "TacticalVestBlack", contents="RandomTorsoContents", percent = 2 },
				{ class = "TacticalVestGreen", contents="RandomTorsoContents", percent = 3 },
				{ class = "TacticalVestGreenCamo1",contents="RandomTorsoContents", percent = 2 },
				{ class = "TacticalVestGreenCamo2",contents="RandomTorsoContents", percent = 3 },
				{ class = "TacticalVestGreenCamo3",contents="RandomTorsoContents", percent = 2 },
				{ class = "TacticalVestGreenCamo4",contents="RandomTorsoContents", percent = 3 },
				{ class = "TacticalVestTan", contents="RandomTorsoContents", percent = 2 },
				{ class = "TacticalVestTanCamo1", contents="RandomTorsoContents", percent = 3 },
				{ class = "TacticalVestTanCamo2", contents="RandomTorsoContents", percent = 2 },
				{ class = "TacticalVestTanCamo3", contents="RandomTorsoContents", percent = 3 },
				{ class = "TacticalVestTanCamo4", contents="RandomTorsoContents", percent = 2 },
				{ class = "TacticalVestUrbanCamo1", contents="RandomTorsoContents", percent = 3 },
				{ class = "TacticalVestUrbanCamo2", contents="RandomTorsoContents", percent = 2 },
				{ class = "TacticalVestUrbanCamo3", contents="RandomTorsoContents", percent = 3 },
				{ class = "TacticalVestUrbanCamo4", contents="RandomTorsoContents", percent = 2 },
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
				{ class = "TshirtAmalgamatedBlue", percent = 0.5 },
                { class = "PoleraCC", percent = 0.5 },
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
				-- generic (20)
				{ class = "guide_medical_bandages"              , percent = 7 },
				{ class = "guide_weapons_melee"                 , percent = 7 },
				{ class = "guide_structures_tire_stacks"        , percent = 6 },

				-- basic (34)
				{ class = "guide_structures_wood_bridges_1"     , percent = 3 },
				{ class = "guide_structures_wood_ramps_1"       , percent = 3 },
				{ class = "guide_structures_wood_stairs_1"      , percent = 3 },
				{ class = "guide_structures_wood_traps_1"       , percent = 3 },
				{ class = "guide_structures_wood_walkways_1"    , percent = 3 },
				{ class = "guide_structures_wood_walls_1"       , percent = 3 },
				{ class = "guide_structures_wood_roofs"         , percent = 3 },
				{ class = "guide_powered_parts_1"               , percent = 3 },
				{ class = "guide_traps_1"                       , percent = 3 },
				--{ class = "guide_explosives_1"                  , percent = 3 },
				{ class = "guide_weapons_ranged_1"              , percent = 4 },

				-- advanced (38)
				{ class = "guide_structures_wood_bridges_2"     , percent = 4 },
				{ class = "guide_structures_wood_ramps_2"       , percent = 4 },
				{ class = "guide_structures_wood_stairs_2"      , percent = 3 },
				{ class = "guide_structures_wood_traps_2"       , percent = 4 },
				{ class = "guide_structures_wood_walkways_2"    , percent = 5 },
				{ class = "guide_structures_wood_walls_2"       , percent = 3 },
				{ class = "guide_traps_2"                       , percent = 3 },
				--{ class = "guide_explosives_2"                  , percent = 3 },
				{ class = "guide_weapons_ranged_2"              , percent = 3 },
				{ class = "guide_weapons_ranged_3"              , percent = 3 },
                { class = "guide_buildextra"                    , percent = 2 },

				-- specialized (8)
				{ class = "guide_structures_wood_curves"        , percent = 3 },
				{ class = "guide_structures_wood_gallows"       , percent = 3 },
				{ class = "guide_structures_wood_watchtower"    , percent = 3 },
				{ class = "guide_structures_wood_gatehouse"     , percent = 3 },
				{ class = "guide_concrete"                      , percent = 3 },
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
				{ class = "Matches", percent = 50 },
				{ class = "Lighter", percent = 50 },
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
				{ class = "CarBattery"     , percent = 13  },
				{ class = "TowCable"       , percent = 13  },
				{ class = "DriveBelt"      , percent = 13  },
				{ class = "DuctTape"       , percent = 8   },
				{ class = "ElectricalParts", percent = 8   },
				{ class = "Oil"            , percent = 13  },
				{ class = "SparkPlugs"     , percent = 13  },
				{ class = "WorkLight"      , percent = 9   },
				{ class = "DustMask"	   , percent = 10  },
				
			},
		},

		{
			category = "Wheel",
			classes =
			{
				{ class = "Wheel", percent = 60 },
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
				{ class = "Rope"		, percent = 40 },
				{ class = "Rags"		, percent = 50 },
				{ class = "AmcoinLedger", percent = 10  , min = 1, max = 15 },
			},
		},


		-- Back
		{
			category = "RandomBackpack",
			classes =
			{
				{ category = "BackpackComponents"              , percent = 25 },
				{ category = "RandomDuffelBag"                 , percent = 15 },
				{ category = "RandomStowPack"                  , percent = 20 },
				{ category = "RuggedPack"                      , percent = 15 },
				{ category = "RandomRuckSack"                  , percent = 15 },
				{ category = "RandomAllGasCanisterPack"        , percent = 10 },
				
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
				{ category = "RandomBalaclava"  , percent = 15  },
				{ category = "RandomBandana"    , percent = 33  },
				{ class = "GasMask"             , percent = 5   },
				{ class = "DustMask"            , percent = 15  },
				{ class = "HeadSack"            , percent = 12  },
				{ class = "HockeyMask"          , percent = 13  },
				{ class = "HockeyMaskDp"        , percent = 6   },
                { class = "AnonMask"            , percent = 1   },
			},
		},


		-- Feet
		{
			category = "RandomShoes",
			classes =
			{
				{ category = "RandomCombatBoots", percent = 10 },
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
				{ category = "RandomCombatBoots", percent = 50 },
				{ category = "RandomSteeltoedBoots", percent = 50 },
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
				{ class = "MotorcycleHelmetCarbon", percent = 35 },
				{ class = "MotorcycleHelmetGold", percent = 35 },
				{ class = "MotorcycleHelmetWhite", percent = 5 },
                { class = "MotorcycleHelmetBeach", percent = 5 },
                { class = "MotorcycleHelmetSynthwave", percent = 5 },
                { class = "MotorcycleHelmetSpitfire", percent = 5 },
                { class = "MotorcycleHelmetSkull", percent = 2 },
                { class = "MotorcycleHelmetChinese", percent = 5 },
			},
		},

		{
			category = "RandomHat",
			classes =
			{
				{ category = "RandomBeanie"             , percent = 8   },
				{ category = "RandomBeret"              , percent = 10  },
				{ category = "RandomBikeHelmet"         , percent = 10  },
				{ category = "RandomCowboyHat"          , percent = 9   },
				{ category = "RandomFlexCap"            , percent = 8   },
				{ category = "RandomHeadband"           , percent = 11  },
				{ category = "RandomMotorcycleHelmet"   , percent = 6   },
				{ category = "RandomFootballHelmet"     , percent = 6   },
				{ class = "BandanaHat"                  , percent = 6   },
				{ class = "BaseballCap"                 , percent = 8   },
				{ class = "DorfmanPacific"              , percent = 10  },
				{ class = "WeldersMask"                 , percent = 8   },
			},
		},


		-- Legs
		{
			category = "RandomLegs",
			classes =
			{
				{ category = "RandomBlueJeans2", percent = 10 },
				{ category = "RandomCargoPants", percent = 15 },
				{ category = "RandomCargoShorts", percent = 15 },
				{ category = "RandomTrackPants", percent = 15 },
				{ category = "RandomWandererPants", percent = 25 },
			},
		},


		-- Neck
		{
			category = "RandomNeck",
			classes =
			{
				{ category = "RandomScarf"        , percent = 20 },
				{ class = "NecklaceCrossChrome"   , percent = 20 },
				{ class = "ShoulderPadOneSide"    , percent = 10 },
				{ class = "ShoulderPadOneSideLeft", percent = 10 },
				{ class = "NecklaceCrossGold"     , percent = 10 },
				{ class = "NecklaceCrossSilver"   , percent = 25 },
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
				{ category = "RandomTacticalVest", percent = 5 },
				{ category = "RandomTshirt", percent = 15 },
				{ category = "RandomRainJacket", percent = 5 },
				{ category = "RandomPuffyJacket", percent = 5 },
			},
		},

		-- Waist
		{
			category = "RandomWaist",
			classes =
			{
				{ class = "FannyPackBlack", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackBlueOrange", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackCamo1", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackCamo2", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackCamo3", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackGray", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackGreenGray", contents="RandomWaistContents", percent = 9 },
				{ class = "FannyPackMaroonGray", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackPurplePink", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackRed", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackRedBlue", contents="RandomWaistContents", percent = 8 },
				{ class = "FannyPackYellow", contents="RandomWaistContents", percent = 8 },
			},
		},


		-- Clothes
		{
			category = "RandomClothes",
			classes =
			{
				{ category = "RandomEyes"         , percent = 9    },
				{ category = "RandomFace"         , percent = 9    },
				{ category = "RandomHands"        , percent = 11   },
				{ category = "RandomHat"          , percent = 12   },
				{ category = "RandomLegs"         , percent = 11   },
				{ category = "RandomNeck"         , percent = 11   },
				{ category = "RandomShoes"        , percent = 10   },
				{ category = "RandomTorso"        , percent = 11   },
				{ category = "RandomWaist"        , percent = 8    },
				{ category = "RandomMXCloth"      , percent = 7    },
				{ category = "RandomTron"         , percent = 0.5  },
				{ category = "RandomIronSuite"    , percent = 0.5  },
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
				{ category = "RandomCamoHats", percent = 15 },
				{ category = "RandomCamoPants", percent = 15 },
				{ category = "RandomCamoShirts", percent = 20 },
                { category = "RandomTron", percent = 10 },
			},
		},
		

	
		-- {
		-- 	category = "M50Skins",
		-- 	classes =
		-- 	{
		-- 		{ class = "M50_wood", percent = 10 },
		-- 		{ class = "M50", percent = 90 },
		-- 	},
		-- },


		-- Magazines/Rounds (with varying capacity/type)
		{
			category = "12GaugeAA12Mags",
			classes =
			{
				{ class = "12Gaugex8_Beanbag_AA12", percent = 1 },
				{ class = "12Gaugex8_Pellet_AA12", percent = 49 },
				{ class = "12Gaugex8_Slug_AA12", percent = 50 },
			},
		},

		{
			category = "12GaugeShells",
			classes =
			{
				{ class = "Pile_12GaugePellet", percent = 65 },
				{ class = "Pile_12GaugeSlug", percent = 35 },
			},
		},

		{
			category = "12GaugeShellsPolice",
			classes =
			{
				{ class = "Pile_12GaugeBeanbag", percent = 1 },
				{ class = "Pile_12GaugePellet", percent = 49 },
				{ class = "Pile_12GaugeSlug", percent = 50 },
			},
		},

		{
			category = "9mmMagazine",
			classes =
			{
				{ class = "9mmx10", percent = 33.3 },
				{ class = "9mmx19", percent = 33.3 },
				{ class = "9mmx33", percent = 33.3 },
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
			category = "MAC10WithMagazines",
			group =
			{
				{ class = "MAK10" },
				{ class = "9x19_mac10" },
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
			category = "M4A1WithMagazines",
			group =
			{
				{ class = "M4A1" },
				{ class = "STANAGx30" },
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
				{ class = "GrenadeGasSleepPickup",      percent = 10 },
				{ class = "GrenadeSmokeGreenPickup",    percent = 10 },
				{ class = "GrenadeSmokeMagentaPickup",  percent = 20 },
				{ class = "GrenadeSmokeRedPickup",      percent = 20 },
				{ class = "GrenadeSmokeWhitePickup",    percent = 20 },
				{ class = "GrenadeSmokeYellowPickup",   percent = 20 },
				
			},
		},

		{
			category = "RandomMilitaryGrenade",
			classes =
			{
				{ class = "FlashbangPickup", percent = 30 },
				{ class = "GrenadeGasNervePickup", percent = 10 },
				{ class = "GrenadeGasSleepPickup", percent = 10 },
				{ class = "GrenadeGasTearPickup", percent = 20 },
				--{ class = "GrenadePickup", percent = 20 },
				--{ class = "TrapLandminePacked", percent = 10 },
			},
		},

		-- Consumables
		{
			category = "RandomDrink",
			classes =
			{
				-- To reduce food/water in the world these only add up to 50%
				{ category = "RandomRottenVeggie"   , percent = 1 }, 
				{ category = "RandomSeeds"          , percent = 4 }, 
				{ category = "RandomAlcohol"        , percent = 4 },
				{ class = "WaterPurificationTablets", percent = 3 },
				{ class = "CivCanteen01"            , percent = 7 },
				{ class = "CokeCan"                 , percent = 7 },
				{ class = "DrPepperCan"             , percent = 7 },
				{ class = "EnergyDrinkCan"          , percent = 7 },
				{ class = "MilitaryCanteenPlastic"  , percent = 5 },
				{ class = "MilitaryCanteenMetal"    , percent = 5 },
				{ class = "PepsiCan"                , percent = 7 },
				{ class = "SpriteCan"               , percent = 7 },
				{ class = "TomatoJuiceCan"          , percent = 7 },
				{ class = "WaterBottle"             , percent = 7 },
				{ class = "camping_water_jug"       , percent = 4 },
				
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
				{category = "RandomDrink", percent = 40}, 
				{category = "RandomFood", percent = 40}, 
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
				{ class = "MushroomAntiRad", percent = 8 },
				{ class = "MushroomFood", percent = 25 },
				{ class = "MushroomHeal", percent = 5 },
			},
		},


		-- Medical
		{
			category = "RandomMedical",
			classes =
			{
				{ class = "AdrenalineSyringe", percent = 5 },
				{ class = "AntiradiationPills", percent = 5 },
				{ class = "PotassiumIodidePills", percent = 5 },
				{ class = "Antibiotics", percent = 5 },
				{ class = "Aspirin", percent = 5 },
				{ class = "Bandage", percent = 25 },
				{ class = "HeatPack", percent = 10 },
				{ class = "WaterPurificationTablets", percent = 10 },
				{ class = "Rags", percent = 10 },
				{ class = "RubbingAlcohol", percent = 10 },
				{ class = "Salt", percent = 10 },
                
                
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
				{ category = "RandomIncapacition"    , percent = 5 	},
				{ category = "RandomPaintCan"        , percent = 7 	},
				{ category = "RandomFireStarter"     , percent = 4 	},
				{ class = "Amalgaduino"              , percent = 5 	},
				{ class = "BarbedWireCoil"           , percent = 3  },
				{ class = "CamoNetting"              , percent = 7 	},
				{ class = "DuctTape"                 , percent = 5 	},
				{ class = "ElectricalParts"          , percent = 5  },
				{ class = "EmptyBottle"              , percent = 5  },
				{ class = "Nails"                    , percent = 3  },
                { class = "Pickaxe"      			 , percent = 5  },
                { class = "Hatchet"      			 , percent = 5  },
				{ class = "PipeMetal"                , percent = 4  },
				{ class = "Rags"                     , percent = 5  },
				{ class = "PropaneHeaterTop"         , percent = 4  },
				{ class = "Rope"                     , percent = 2  },
				{ class = "SawBlade"                 , percent = 5  },
				{ class = "TargetPaper"              , percent = 2  },
				{ class = "Tarp"                     , percent = 2  },
				{ class = "WorkLight"                , percent = 5  },
				{ class = "Hacksaw"                  , percent = 5  },
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
				{ class = "JerryCanDiesel", percent = 50 },
				{ class = "PropaneTank", percent = 25 },
				{ class = "small_generator", percent = 10 },
			},
		},


		-- Lubricant
		{
			category = "RandomLubricant",
			classes =
			{
				{ class = "Oil", percent = 60 },
			},
		},


		-- Gnomes
		{
			category = "RandomGnome",
			classes =
			{
				{ class = "gnome_bronze"                    , percent = 4  },
				{ class = "gnome_creep"                     , percent = 10 },
				{ class = "gnome_gold"                      , percent = 3  },
				{ class = "gnome_silver"                    , percent = 3  },
				{ class = "gnome_standard_a"                , percent = 3  },
				{ class = "gnome_standard_b"                , percent = 3  },
				{ class = "gnome_standard_c"                , percent = 3  },
				{ class = "jerry"                           , percent = 6  },
				{ class = "painting_landscape_01"           , percent = 3  },
				{ class = "painting_landscape_02"           , percent = 3  },
				{ class = "painting_landscape_03"           , percent = 3  },
				{ class = "painting_landscape_04"           , percent = 3  },
				{ class = "painting_landscape_05"           , percent = 3  },
				{ class = "painting_landscape_06"           , percent = 3  },
				{ class = "painting_landscape_07"           , percent = 3  },
				{ class = "painting_landscape_08"           , percent = 3  },
				{ class = "painting_landscape_09"           , percent = 3  },
				{ class = "painting_landscape_10"           , percent = 3  },
				{ class = "painting_square_01"              , percent = 4  },
				{ class = "painting_square_02"              , percent = 3  },
				{ class = "painting_vertical_landscape_01"  , percent = 3  },
				{ class = "painting_vertical_landscape_02"  , percent = 3  },
				{ class = "painting_vertical_landscape_03"  , percent = 3  },
				{ class = "painting_vertical_landscape_04"  , percent = 3  },
				{ class = "painting_vertical_landscape_05"  , percent = 3  },
				{ class = "painting_vertical_landscape_06"  , percent = 3  },
				{ class = "painting_map_canyonlands"        , percent = 3  },
				{ class = "poster_vertical_01"              , percent = 3  },
				{ class = "painting_map"                    , percent = 4  },
			}, 
		},
		
		{
			category = "RandomPainting",
			classes =
			{
				{ class = "painting_landscape_01"         , percent = 5 },
				{ class = "painting_landscape_02"         , percent = 5 },
				{ class = "painting_landscape_03"         , percent = 5 },
				{ class = "painting_landscape_04"         , percent = 5 },
				{ class = "painting_landscape_05"         , percent = 5 },
				{ class = "painting_landscape_06"         , percent = 5 },
				{ class = "painting_landscape_07"         , percent = 5 },
				{ class = "painting_landscape_08"         , percent = 5 },
				{ class = "painting_landscape_09"         , percent = 5 },
				{ class = "painting_landscape_10"         , percent = 5 },
				{ class = "painting_square_01"            , percent = 5 },
				{ class = "painting_square_02"            , percent = 5 },
				{ class = "painting_vertical_landscape_01", percent = 5 },
				{ class = "painting_vertical_landscape_02", percent = 5 },
				{ class = "painting_vertical_landscape_03", percent = 5 },
				{ class = "painting_vertical_landscape_04", percent = 5 },
				{ class = "painting_vertical_landscape_05", percent = 5 },
				{ class = "painting_vertical_landscape_06", percent = 4.9 },
				{ class = "painting_map_canyonlands"      , percent = 0.1 },
				{ class = "poster_vertical_01"            , percent = 5 },
				{ class = "painting_map"                  , percent = 5 },
			},
		},

		-- Basebuilding Items
		{
			category = "RandomBPart", 
			classes =
			{
				{ category = "RandomCampingBPart", percent = 98 },
				{ category = "RandomGnome", percent = 2 },
			},
		},

		-- Camping basebuilding Items
		
		{
			category = "RandomCampingBPart", 
			classes =
			{
				{ class = "camping_chair"                     , percent = 3 },
				{ class = "propane_heater"                    , percent = 4 },
				{ category = "RandomLantern"                  , percent = 4 },
				{ class = "HeatPack"                          , percent = 6 },
				{ class = "camping_pop_up_canopy"             , percent = 7 },
				{ class = "camping_table"                     , percent = 5 },
				{ class = "camping_water_jug"                 , percent = 5 },
				{ category = "RandomHuntingItems"             , percent = 7 },
				{ category = "RandomTent"                     , percent = 1 },
                { category = "RandomMelee"                    , percent = 1 },
                { category = "RandomNormalRepairKit"          , percent = 4 },
                { category = "RandomCraftedWeaponPure"        , percent = 1 },
                { category = "Map"                            , percent = 1 },
                { category = "RandomFlashlight"               , percent = 1 },
                { category = "RandomCraftedTools"             , percent = 1 },
                
                
                
                
			},
		},

		{
			category = "RandomLantern", 
			classes =
			{
				{ class = "camping_lantern"                   , percent = 11.1 },
                { class = "camping_lantern_pink"  			  , percent = 11.1 },
                { class = "camping_lantern_red"   			  , percent = 11.1 },
                { class = "camping_lantern_aqua"  			  , percent = 11.1 },
                { class = "camping_lantern_blue"  			  , percent = 11.1 },
                { class = "camping_lantern_green" 			  , percent = 11.1 },
                { class = "camping_lantern_orange"			  , percent = 11.1 },
                { class = "camping_lantern_yellow"			  , percent = 11.1 },
                { class = "camping_lantern_purple"			  , percent = 11.1 },
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
				{ category = "RandomFlashlight"      , percent = 5       },
				{ class = "Axe"                      , percent = 8       },
				{ class = "AxePatrick"               , percent = 3       },
				{ class = "BaseballBat"              , percent = 5       },
				{ class = "BaseballBatNails"         , percent = 3       },
				{ class = "BaseballBatSawBlade"      , percent = 3       },
				{ class = "BaseballBatSawBladeNails" , percent = 3       },
				{ class = "BaseballBatScrapNails"    , percent = 4       },
				{ class = "BaseballBatHerMajesty"    , percent = 3       },
				{ class = "Cleaver"                  , percent = 4       },
				{ class = "Crowbar"                  , percent = 3       },
				{ class = "Guitar"                   , percent = 4       },
				{ class = "Hammer"                   , percent = 5       },
				{ class = "Hatchet"                  , percent = 4       },
				{ class = "HuntingKnife"             , percent = 4       },
				{ class = "Katana"                   , percent = 3       },
				{ class = "KatanaBlackWidow"         , percent = 3       },
				{ class = "LugWrench"                , percent = 3       },
				{ class = "Machete"                  , percent = 4       },
				{ class = "Pickaxe"                  , percent = 3       },
				{ class = "PipeWrench"               , percent = 4       },
				{ class = "SurvivalKnife"            , percent = 4       },
				{ class = "Icepickaxe"               , percent = 0.5     },
				{ class = "SCAAMShovel"              , percent = 1       },
			},
		},

		-- largly based on random ranged weapon, rest from crafted
		{
			category = "RandomWeaponRepairKit",
			classes =
			{
				{ class = "RK_MeleePrimary"         , percent = 5   },
				{ class = "RK_MeleeSecondary"       , percent = 5   },
				{ class = "RK_Icepickaxe"           , percent = 1   },
				{ class = "RK_ClothingHelmet"       , percent = 21  },
				{ class = "RK_FlareGun"             , percent = 5   },
				{ class = "RK_TranquilizerGun"      , percent = 5   },
				{ class = "RK_RecurveBow"           , percent = 5   },
				{ class = "RK_Shotgun870Tactical"   , percent = 9   },
				{ class = "RK_Silencers"            , percent = 14  },
				{ class = "RK_AssaultRifles"        , percent = 13  },
				{ class = "RK_M97"                  , percent = 5   },
				{ class = "RK_PlasmaRifle"          , percent = 1.5 },
				{ class = "RK_RocketLauncher"       , percent = 1.5 },
			},
		},

		{
			category = "RandomNormalRepairKit",
			classes =
			{
				{ class = "RK_Canvas"           , percent = 20 },
				{ class = "RK_Cloth"            , percent = 33 },
				{ class = "RK_ClothingHelmet"   , percent = 10 },
				{ class = "RK_Equipment"        , percent = 10 },
				{ class = "RK_Leather"          , percent = 15 },
				{ class = "RK_Teflon"           , percent = 5  },
                { class = "RK_CarParts"         , percent = 5  },
                
			},
		},

		{
			category = "RandomCraftedWeaponPure",
			classes = 
			{
				{ class = "CraftedBow", percent = 12 },
				{ class = "CraftedPistol", percent = 17 },
				{ class = "CraftedRifleLong", percent = 10 },
				{ class = "CraftedSMG", percent = 5 },
				{ class = "CraftedLongPistol", percent = 12 },
				{ class = "CraftedPistol556", percent = 9 },
				{ class = "CraftedRifle9mm", percent = 5 },
				{ class = "CraftedShortRifle556", percent = 10 },
				{ class = "CraftedShortShotgun", percent = 10 },
				{ class = "CraftedShotgun", percent = 10 },
			},
		},

		{
			category = "RandomRangedPure",
			classes =
			{
				{ class = "AA12"                , percent = 0.5 	},
				{ class = "AK74U"               , percent = 1.5 	},
				{ class = "AKM"                 , percent = 1 		},
				{ class = "AKMGold"             , percent = 0.01 	},
				{ class = "AP85"                , percent = 1 		},
				{ class = "AT15"                , percent = 2 		},
				{ class = "AUMP45"              , percent = 2   	},
				{ class = "Bulldog"             , percent = 1 		},
				{ class = "ColtPython"          , percent = 6.9 	},
				{ class = "ColtPythonGrimeyRick", percent = 0.1 	},
				{ class = "CraftedBow"          , percent = 0.5 	},
				{ class = "CraftedPistol"       , percent = 0.5 	},
				{ class = "CraftedRifleLong"    , percent = 0.5 	},
				{ class = "CraftedSMG"          , percent = 0.5 	},
				{ class = "CraftedLongPistol"   , percent = 1 		},
				{ class = "CraftedPistol556"    , percent = 1 		},
				{ class = "CraftedRifle9mm"     , percent = 1 		},
				{ class = "CraftedShortRifle556", percent = 1 		},
				{ class = "CraftedShortShotgun" , percent = 1 		},
				{ class = "CraftedShotgun"      , percent = 1 		},
				{ class = "Crossbow"            , percent = 3 		},
				{ class = "CX4Storm"            , percent = 1.8 	},
				{ class = "FlareGun"            , percent = 2 		},
				{ class = "G18Pistol"           , percent = 3 		},
				{ class = "hk45"                , percent = 3 		},
				{ class = "KrissV"              , percent = 1 		},
				{ class = "M16"                 , percent = 1.5 	},
				{ class = "m1911a1"             , percent = 2 		},
				{ class = "M249"                , percent = 0.01	},
				{ class = "M40A5"               , percent = 1.48 	},
				{ class = "M9A1"                , percent = 1.9 	},
				{ class = "Makarov"             , percent = 1.5 	},
				{ class = "Mk18"                , percent = 1.48 	},
				{ class = "Mk18Reaver"          , percent = 1.02 	},
				{ class = "Model70"             , percent = 2 		},
				{ class = "MP5"                 , percent = 2 		},
				{ class = "P350"                , percent = 1 		},
				{ class = "PX4"                 , percent = 1 		},
				{ class = "R90"                 , percent = 1.6 	},
				{ class = "RecurveBow"          , percent = 4 		},
				{ class = "Rem700"              , percent = 4.5 	},
				{ class = "Rem870"              , percent = 6 		},
				{ class = "ruger22"             , percent = 5 		},
                { class = "ACAW"                , percent = 1 		},
				{ class = "Sako_85"             , percent = 2 		},
				{ class = "Shotgun870Tactical"  , percent = 4 		},
				{ class = "TranquilizerGun"     , percent = 0.5		},
				{ class = "Wasteland22"         , percent = 2.9 	},
				{ class = "AKVal"               , percent = 3 		},
				{ class = "SAS12"               , percent = 2 		},
				{ class = "MAK10"               , percent = 3 		},
				{ class = "AK5D"                , percent = 3 		},
				{ class = "M97"                 , percent = 0.8 	},
                { class = "SCAR-H"              , percent = 1 	    },
                { class = "G36C"                , percent = 1 	    },
			},
		},
		
		{
			category = "RandomRangedCivilianPure",
			classes =
			{
				{ class = "AT15"              , percent = 6 },
				{ class = "Crossbow"          , percent = 8 },
				{ class = "CX4Storm"          , percent = 8 },
				{ class = "Model70"           , percent = 3 },
				{ class = "RecurveBow"        , percent = 8 },
				{ class = "Rem700"            , percent = 8 },
				{ class = "Rem870"            , percent = 8 },
				{ class = "Sako_85"           , percent = 8 },
				{ class = "Shotgun870Tactical", percent = 8 },
				{ class = "Wasteland22"       , percent = 5 },
				{ class = "AA12"              , percent = 2 },
				{ class = "SAS12"             , percent = 6 },
				{ class = "AK5D"              , percent = 5 },
				{ class = "MAK10"             , percent = 7 },
				{ category = "RandomAccessory", percent = 10 },	
			},
		},
		
		{
		    category = "RandomRangedMilitaryPure",
			classes =
			{
				{ class = "AA12"                , percent = 3 },
				{ class = "ACAW"                , percent = 3 },
				{ class = "AK74U"               , percent = 3 },
				{ class = "AKM"                 , percent = 3 },
				{ class = "AT15"                , percent = 3 },
				{ class = "AUMP45"              , percent = 3 },
				{ class = "Bulldog"             , percent = 3 },
				{ class = "CX4Storm"            , percent = 3 },
				{ class = "KrissV"              , percent = 3 },
				{ class = "M16"                 , percent = 4 },
				{ class = "M249"                , percent = 4 },
				{ class = "M40A5"               , percent = 4 },
				{ class = "Mk18"                , percent = 4 },
				{ class = "MP5"                 , percent = 3 },
				{ class = "R90"                 , percent = 3 },
				{ class = "Shotgun870Tactical"  , percent = 3 },
				{ class = "AKMGold"             , percent = 2 },
				{ class = "ColtPythonGrimeyRick", percent = 1 },
				{ class = "Mk18Reaver"          , percent = 1 },
				{ class = "M4A1"                , percent = 5 },
				{ class = "AKVal"               , percent = 5 },
				{ class = "SAS12"               , percent = 5 },
				{ class = "AK5D"                , percent = 5 },
				{ class = "MAK10"               , percent = 5 },
				{ class = "M97"                 , percent = 1.5 },
				{ class = "M16Vietnam"          , percent = 4.5},
				{ class = "VSS"                 , percent = 4.5 },
				{ class = "M4V5"                , percent = 3 },
				{ class = "RPK"                 , percent = 2 },
				{ category = "RandomAccessory"  , percent = 3.5 },
			},
		},
		
		{
		    category = "RandomRangedPolicePure",
			classes =
			{
				{ class = "AT15"                , percent = 7  },
				{ class = "AUMP45"              , percent = 7  },
				{ class = "CX4Storm"            , percent = 6  },
				{ class = "MP5"                 , percent = 7.5  },
				{ class = "R90"                 , percent = 7.5  },
				{ class = "Shotgun870Tactical"  , percent = 6  },
				{ class = "AKMGold"             , percent = 4  },
				{ class = "AK74U"               , percent = 8  },
				{ class = "ColtPythonGrimeyRick", percent = 7  },
				{ class = "Mk18Reaver"          , percent = 5  },
				{ class = "MAK10"               , percent = 8  },
				{ class = "AKVal"               , percent = 6  },
				{ class = "M4V5"                , percent = 5  },
				{ class = "SAS12"               , percent = 8  },				
				{ class = "AK5D"                , percent = 5  },
				{ class = "M97"                 , percent = 0.5  },
				{ category = "RandomAccessory"  , percent = 2.5  },
			},
		},
		
		{
		    category = "RandomMilitaryArmor",
			classes =
			{
				{ class = "FlakVestGreen"        , percent = 10   },
				{ class = "FlakVestGreenCamo1"   , percent = 10   },
				{ class = "FlakVestTan"          , percent = 10   },
				{ class = "FlakVestTanCamo1"     , percent = 10   },
				{ category = "RandomIronSuite"   , percent = 9    },
				{ category = "RandomSpartaGear"  , percent = 2    },
                
			},
		},
		
		{
		    category = "RandomPoliceArmor",
			classes =
			{
				{ class = "PoliceVestBlack", percent = 20 },
				{ class = "PoliceVestBlue", percent = 20 },
				{ class = "SwatHelmet", percent = 20 },
				{ category = "RandomTron", percent = 10 },
			},
		},

		{
			category = "RandomRanged",
			classes =
			{
				{ category = "RandomRangedPure", percent = 86 },
				{ category = "RandomWeaponRepairKit", percent = 10 },
				{ category = "RandomCamoClothes", percent = 4 },
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
				{ class = "P350", percent = 5 },
				{ class = "AP85", percent = 5 }
			},
		},

        {
			category = "RandomCargador",
			classes =
			{
				{ class = "ext_762x30"             , percent = 9.09  },
				{ class = "ext_556x75"             , percent = 9.09  },
				{ class = "ext_762x75"             , percent = 9.09  },
				{ class = "STANAGx50"              , percent = 9.09  },
				{ class = "akval_drummag_75rnd"	   , percent = 9.09  },
                { class = "762x30"	   			   , percent = 9.09  },
                { class = "STANAGx30"	   		   , percent = 9.09  },
                { class = "545x30"	   			   , percent = 9.09  },
                { class = "57x60"	   			   , percent = 9.09  },
                { class = "g36cx50"	   			   , percent = 9.09  },
                { class = "g36c_mag"   			   , percent = 9.09  },
			},
		},

		{
			category = "RandomAccessory",
			classes =
			{
				{ class = "LaserSight"                 , percent = 5  },
				{ class = "LaserSightGreen"            , percent = 4  },
				{ class = "LaserSightBlue"             , percent = 4  },
				{ class = "OpticScopeBow"              , percent = 2  },
				{ class = "PistolSilencer"             , percent = 4  },
				{ class = "ReflexSight"                , percent = 4  },
				{ class = "T1Micro"                    , percent = 4  },
				{ class = "ReflexSightBow"             , percent = 5  },
				{ class = "ForegripVertical"           , percent = 4  },
				{ class = "BayonetRifle"               , percent = 4  },
				{ class = "IronsightKit"               , percent = 4  },
				{ class = "ReddotSight"                , percent = 5  },
				{ class = "FlashlightMounted"          , percent = 5  },
				{ class = "OPKSight"                   , percent = 4  },
				{ class = "R3Sight"                    , percent = 5  },
				{ class = "PSOScope"                   , percent = 4  },
				{ class = "HuntingScope"		       , percent = 5  },
                { class = "HuntingScopeRealCamo"       , percent = 4  },
                { class = "HuntingScopeRealCamoDesert" , percent = 4  },
				{ class = "OpticScope"		   	       , percent = 5  },
				{ category = "RandomToolRepairKit"     , percent = 5  },
                { category = "RandomCargador"          , percent = 5  },
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
				{ category = "12GaugeAA12Mags"   , percent = 2      },
                { category = "12GaugeShells"     , percent = 2      },
                { category = "9mmMagazine"       , percent = 2      },
                { category = "RandomPlasma"      , percent = 2      , min = 1, max = 5 },
                { category = "RandomRocket"      , percent = 2      , min = 1, max = 3 },
                { class = "9mmx10_makarov"       , percent = 2      },
                { class = "9mmx15_m9a1"          , percent = 2      },
                { class = "9mmx19_ap85"          , percent = 2      },
                { class = "acp_45x20"            , percent = 2      },
                { class = "acp_45x30"            , percent = 3      },
                { class = "10mmx15"              , percent = 3      },
                { class = "10mmx30"              , percent = 3      },
                { class = "acp_45x10_hk"         , percent = 2      },
                { class = "acp_45x7"             , percent = 2      },
                { class = "762x30"               , percent = 2      },
                { class = "Arrowx8"              , percent = 2      },
                { class = "Boltx5_0000"          , percent = 2      },
                { class = "57x60"                , percent = 2      },
                { class = "M40x5"                , percent = 1      },
                { class = "Pile_10mm"            , percent = 3      },
                { class = "Pile_22"              , percent = 3      },
                { class = "Pile_545x39"          , percent = 3      },
                { class = "Pile_57x28"           , percent = 3      },
                { class = "Pile_223"             , percent = 3      },
                { class = "Pile_308"             , percent = 3      },
                { class = "Pile_357"             , percent = 3      },
                { class = "Pile_45ACP"           , percent = 3      },
                { class = "Pile_556x45"          , percent = 2.5    },
                { class = "Pile_762x39"          , percent = 3      },
                { class = "Pile_762x51"          , percent = 3.5    },
                { class = "Pile_9mm"             , percent = 2.5    },
                { class = "Pile_Flare"           , percent = 2      },
                { class = "STANAGx30"            , percent = 3      },
                { class = "STANAGx50"            , percent = 2      },
                { class = "762x40"               , percent = 2      },
                { class = "556x30_ak5d"          , percent = 2      },
                { class = "762x20_Akval"         , percent = 2      },
                { class = "9x19_mac10"           , percent = 1.5    },
                { class = "Pile_40mmGrenade"     , percent = 1      },
                { class = "akval_drummag_75rnd"  , percent = 1      },
                { class = "ext_762x30"           , percent = 1      },
                { class = "ext_556x75"           , percent = 1      },
                { class = "ext_762x75"           , percent = 1      },
                { class = "762x40"               , percent = 2      },
                { class = "556x100"              , percent = 1.5    },
                { class = "556x100"              , percent = 1.5    },

			},
		},
    	{
			category = "RandomWeaponWithMagsPure",
			classes =
			{
				{ category = "AA12WithMagazines"                , percent = 3        },
				{ category = "AK74UWithMagazines"               , percent = 2        },
				{ category = "AKMWithMagazines"                 , percent = 2.5      },
				{ category = "AP85WithMagazines"                , percent = 2.5      },
				{ category = "AT15WithMagazines"                , percent = 2.5      },
				{ category = "BulldogWithMagazines"             , percent = 2.5      },
				{ category = "ColtPytonWithRounds"              , percent = 2        },
				{ category = "CraftedPistolWithMagazines"       , percent = 3        },
				{ category = "CraftedSMGWithMagazines"          , percent = 3.5      },
				{ category = "CraftedBowWithMagazines"          , percent = 3.5      },
				{ category = "CraftedRifleWithMagazines"        , percent = 3.5      },
				{ category = "CrossbowWithMagazines"            , percent = 3.5      },
				{ category = "FlareGunWithRounds"               , percent = 1.5      },
				{ category = "G18PistolWithMagazines"           , percent = 2.5      },
				{ category = "HK45WithMagazines"                , percent = 2.5      },
				{ category = "M16WithMagazines"                 , percent = 2.5      },
				{ category = "M1911WithMagazines"               , percent = 2.5      },
				{ category = "M249WithMagazines"                , percent = 2.5      },
				{ category = "M40A5WithMagazines"               , percent = 3.5      },
				{ category = "Mk18WithMagazines"                , percent = 2.3      },
				{ category = "Model70WithRounds"                , percent = 2.5      },
				{ category = "MP5WithMagazines"                 , percent = 3.5      },
				{ category = "P350WithMagazines"                , percent = 3.5      },
				{ category = "PX4WithMagazines"                 , percent = 3.5      },
				{ category = "RecurveBowWithMagazines"          , percent = 3.5      },
				{ category = "Rem700WithRounds"                 , percent = 3.5      },
				{ category = "Rem870WithRounds"                 , percent = 3.5      },
				{ category = "Ruger22WithMagazines"             , percent = 2.5      },
				{ category = "Sako85WithRounds"                 , percent = 2.5      },
				{ category = "Shotgun870TacticalWithMagazines"  , percent = 3        },
				{ category = "TranquilizerGunWithDarts"         , percent = 0.2      },
				{ category = "Wasteland22WithRounds"            , percent = 2.5      },
				{ category = "M4A1WithMagazines"                , percent = 3        },
				{ category = "AkValWithMagazines"               , percent = 1        },
				{ category = "SAS12WithRounds"                  , percent = 3.5      },
				{ category = "AK5DWithMagazines"                , percent = 1.5      },
				{ category = "MAK10WithRounds"                  , percent = 2.5      },
				{ category = "M97WithRounds"                    , percent = 0.5      },
			},
		},

		{
			category = "RandomAmmoBox",
			classes =
			{
				{ class = "AmmoBox_10mm"    , percent = 10  , min = 10, max = 60 },
				{ class = "AmmoBox_22"      , percent = 10  , min = 10, max = 60 },
				{ class = "AmmoBox_308"     , percent = 10  , min = 10, max = 60 },
				{ class = "AmmoBox_357"     , percent = 5   , min = 10, max = 60 },
				{ class = "AmmoBox_223"     , percent = 5   , min = 10, max = 60 },
				{ class = "AmmoBox_5_45x39" , percent = 8   , min = 10, max = 60 },
				{ class = "AmmoBox_5_56x45" , percent = 8   , min = 10, max = 60 },
				{ class = "AmmoBox_5_70x28" , percent = 8   , min = 10, max = 60 },
				{ class = "AmmoBox_7_62x39" , percent = 8   , min = 10, max = 60 },
				{ class = "AmmoBox_7_62x51" , percent = 8   , min = 10, max = 60 },
				{ class = "AmmoBox_9mm"     , percent = 10  , min = 10, max = 60 },
				{ class = "AmmoBox_acp_45"  , percent = 10  , min = 10, max = 60 },
			},
		},

		{
			category = "RandomWeaponWithMags",
			classes =
			{
				{ category = "RandomWeaponWithMagsPure", percent = 90 },
				{ category = "RandomWeaponRepairKit"   , percent = 10 },
			},
		},

		{
			category = "RandomWeapon",
			classes =
			{
				{ category = "RandomMelee"              , percent = 40 },
				{ category = "RandomRanged"             , percent = 10 },
				{ category = "RandomWeaponWithMags"     , percent = 50 },
			},
		},
		{
			category = "RandomSeeds",
			classes =
			{
				{ class = "SeedsBeets"      , percent = 12 },
				{ class = "SeedsBrushPeas"  , percent = 13 },
				{ class = "SeedsCarrots"    , percent = 12 },
				{ class = "SeedsPotatoes"   , percent = 11 },
				{ class = "SeedsWatermelons", percent = 6  },
				{ class = "SeedsPumpkins"   , percent = 11 },
				{ class = "SeedsRadishes"   , percent = 12 },
				{ class = "SeedsSnapPeas"   , percent = 12 },
				{ class = "SeedsTomatoes"   , percent = 11 },
			},
		},

		-- Actionable contents (note that the actual chance of something being present is controlled in ActionableWorldManager.lua)

		{
			category = "RandomAppleTreeContent",
			classes =
			{
				{ class = "AppleFresh", percent = 85 },
				{ class = "AppleRotten", percent = 15 },
			},
		},
		
		{
			category = "RandomCactiContent",
			classes =
			{
				{ class = "PricklyPear", percent = 60 },
				{ class = "PricklyPearRotten", percent = 40 },
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
				{ class = "AmcoinLedger"                    , percent = 1 , min = 20, max = 35 },
				{ category = "RandomTrashContent"           , percent = 1 },
				{ category = "RandomAccessory"              , percent = 35 },
                { category = "RandomSilencer"   			, percent = 5 , min = 1, max = 1 },
				{ class = "guide_medical_bandages"          , percent = 1 },
                { class = "guide_concrete"      			, percent = 0.5 },
                { class = "guide_buildextra"      			, percent = 0.5 },
                { class = "guide_ammunition"    			, percent = 5 },
				{ class = "guide_weapons_melee"             , percent = 2 },
				{ class = "guide_structures_tire_stacks"    , percent = 2 },
				{ class = "guide_structures_wood_bridges_1" , percent = 1 },
				{ class = "guide_structures_wood_ramps_1"   , percent = 1 },
				{ class = "guide_structures_wood_stairs_1"  , percent = 1 },
				{ class = "guide_structures_wood_traps_1"   , percent = 1 },
				{ class = "guide_structures_wood_walkways_1", percent = 1 },
				{ class = "guide_structures_wood_walls_1"   , percent = 1 },
				{ class = "guide_structures_wood_roofs"     , percent = 1 },
				{ class = "guide_powered_parts_1"           , percent = 3 },
				{ class = "NecklaceCrossGold"               , percent = 3 },
				{ class = "NecklaceCrossChrome"             , percent = 1 },
				{ class = "NecklaceCrossSilver" 		    , percent = 2 },
				{ class = "guide_structures_wood_ramps_2"   , percent = 3 },
				{ class = "guide_structures_wood_stairs_2"  , percent = 3 },
				{ class = "guide_structures_wood_traps_2"   , percent = 2 },
				{ class = "guide_structures_wood_walkways_2", percent = 2 },
				{ class = "guide_structures_wood_walls_2"   , percent = 2 },
				{ class = "guide_traps_2"                   , percent = 2 },
				{ class = "guide_weapons_ranged_2"          , percent = 2 },
				{ class = "guide_weapons_ranged_3"          , percent = 2 },
				{ class = "guide_structures_wood_curves"    , percent = 2 },
				{ class = "guide_structures_wood_gallows"   , percent = 2 },
				{ class = "guide_structures_wood_watchtower", percent = 2 },
				{ class = "guide_structures_wood_gatehouse" , percent = 2 },
                
			},
		},

		{
			category = "MediumHidingPlaceContent",
			classes =
			{
				{ class = "AmcoinLedger"                    , percent = 5 },
				{ category = "RandomAmmo"                   , percent = 2 },
				{ category = "RandomTrashContent"           , percent = 5 },
				{ category = "RandomAccessory"              , percent = 30},
				{ category = "RandomPistol"                 , percent = 2 },
				{ class = "guide_medical_bandages"          , percent = 2 },
                { class = "guide_concrete"      			, percent = 0.5 },
                { class = "guide_buildextra"      			, percent = 0.5 },
				{ class = "guide_weapons_melee"             , percent = 2 },
				{ class = "guide_structures_tire_stacks"    , percent = 2 },
				{ class = "guide_structures_wood_bridges_1" , percent = 2 },
				{ class = "guide_structures_wood_ramps_1"   , percent = 2 },
				{ class = "guide_structures_wood_stairs_1"  , percent = 2 },
				{ class = "guide_structures_wood_traps_1"   , percent = 2 },
				{ class = "guide_structures_wood_walkways_1", percent = 2 },
				{ class = "guide_structures_wood_walls_1"   , percent = 2 },
				{ class = "guide_structures_wood_roofs"     , percent = 2 },
				{ class = "NecklaceCrossGold"               , percent = 2 },
				{ class = "NecklaceCrossChrome"             , percent = 2 },
				{ class = "NecklaceCrossSilver" 		    , percent = 2 },
				{ class = "guide_weapons_ranged_1"          , percent = 2 },
				{ class = "guide_structures_wood_bridges_2" , percent = 2 },
				{ class = "guide_structures_wood_ramps_2"   , percent = 2 },
				{ class = "guide_structures_wood_stairs_2"  , percent = 1 },
				{ class = "guide_structures_wood_traps_2"   , percent = 2 },
				{ class = "guide_structures_wood_walkways_2", percent = 2 },
				{ class = "guide_structures_wood_walls_2"   , percent = 2 },
				{ class = "guide_traps_2"                   , percent = 2 },
				{ class = "guide_weapons_ranged_2"          , percent = 2 },
				{ class = "guide_weapons_ranged_3"          , percent = 1 },
				{ class = "guide_structures_wood_curves"    , percent = 2 },
				{ class = "guide_structures_wood_gallows"   , percent = 2 },
				{ class = "guide_structures_wood_watchtower", percent = 2 },
				{ class = "guide_structures_wood_gatehouse" , percent = 2 },
                { category = "RandomSilencer"   			, percent = 2 , min = 1, max = 1 },
			},
		},

		{
			category = "RandomToolboxContent",
			classes =
			{
				{ category = "RandomToolRepairKit"       , percent = 5   },
				{ class = "Nails"                        , percent = 20  },
			    { class = "DuctTape"                     , percent = 5   },
			    { class = "Hammer"                       , percent = 5   },
			    { class = "LugWrench"                    , percent = 8   },
			    { class = "SparkPlugs"                   , percent = 5   },
			    { class = "DriveBelt"                    , percent = 5   },
				{ class = "Sledgehammer"                 , percent = 1.5 },
				{ class = "RK_Sledgehammer"              , percent = 1   },
                { class = "RK_CarParts"                  , percent = 1   },
				{ class = "Icepickaxe"                   , percent = 0.5 },
                { category = "RandomCraftingGuide" 		 , percent = 5.5 },
                { category = "RandomSilencer"			 , percent = 2   },
			},
		},

		{
			category = "RandomToolRepairKit",
			classes =
			{
				{ class = "RK_MeleePrimary"  , percent = 60 },
				{ class = "RK_MeleeSecondary", percent = 30 },
				{ class = "RK_Icepickaxe"    , percent = 10 },
			},
		},

		{
			category = "RandomDrinkVendingMachineContent",
			classes =
			{
				{ class = "AmcoinLedger"    , percent = 15 },
				{ class = "CokeCan"         , percent = 15 },
				{ class = "DrPepperCan"     , percent = 15 },
				{ class = "EnergyDrinkCan"  , percent = 15 },
				{ class = "PepsiCan"        , percent = 15 },
				{ class = "SpriteCan"       , percent = 15 },
				{ class = "WaterBottle"     , percent = 10 },
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
				{ class = "AmcoinLedger"          , percent = 5  , min = 1, max = 6 },
				{ category = "RandomCraftingGuide", percent = 5  },
				{ category = "RandomRottenVeggie" , percent = 7  },
				{ category = "RandomRottenMeat"   , percent = 4  },
				{ category = "RandomBurnedMeat"   , percent = 4  },
				{ class = "EmptyBottle"           , percent = 4  },
				{ class = "Rags"                  , percent = 5  },
				{ class = "BalaclavaBlack"        , percent = 5  },
				{ class = "Rope"                  , percent = 10 },
				{ class = "DuctTape"              , percent = 5  },
				{ class = "PipeMetal"             , percent = 5  },
				{ category = "RandomSeeds"        , percent = 5  },
				{ category = "RandomChemlight"    , percent = 6  },
			},
		},

		{
			category = "RandomCommercialCrateContent",
			classes =
			{
				{ category             = "RandomMaintenance"        , percent = 9  },
				{ class                = "Amalgaduino"              , percent = 10 },
				{ category             = "RandomSeeds"              , percent = 4  },
				{ category             = "RandomCampingBPart"       , percent = 10 },
				{ category             = "RandomNormalRepairKit"    , percent = 10 },
				{ category             = "RandomWeaponRepairKit"    , percent = 10 },
				{ category             = "RandomFuel"               , percent = 10 },
				{ class                = "small_generator"          , percent = 7  },
				{ class                = "powered_generator_small"  , percent = 6  },
				{ class                = "Wheel"                    , percent = 10 },
				{ class                = "WorkLight"                , percent = 5  },
				{ category             = "RandomTent"               , percent = 1  },
                { category 			   = "RandomTron"				, percent = 8  },
			},
		},

		{
			category = "RandomMilitaryFootlockerContent",
			classes =
			{
				{ category = "RandomRangedPolicePure"  , percent = 4    },
				{ category = "RandomMilitaryClothing"  , percent = 3    },
				{ category = "RandomWeaponRepairKit"   , percent = 0.5  },
				{ category = "RandomMedical"           , percent = 5    },
				{ category = "RandomHospitalBandage"   , percent = 3    },
				{ category = "RandomMilitaryGrenade"   , percent = 5    },
				{ category = "RandomAccessory"         , percent = 10   },
                { category = "RandomCargador "         , percent = 2   },
				{ category = "RandomCraftingGuide"     , percent = 13   },
				{ class = "AmcoinLedger"               , percent = 5    },
				{ class = "Amalgaduino"                , percent = 4    },
				{ class = "MilitaryCanteenPlastic"     , percent = 2    },
				{ class = "GasMask"                    , percent = 1.5  },
				{ class = "MilitaryCanteenMetal"       , percent = 2    },
				{ class = "MagliteSmall"               , percent = 3    },
				{ class = "Maglite"                    , percent = 3    },
				{ class = "MRE"                        , percent = 3    },
				{ class = "Cb_radio"                   , percent = 1    },
                { class = "SCAAMAmalgarmin"			   , percent = 5    }, 
				{ class = "GridMap"                    , percent = 0.5  },
				{ category = "RandomBinoculars"        , percent = 2.5  },
				{ class = "SurvivalKnife"              , percent = 1    },
				{ class = "HeatPack"                   , percent = 1.5  },
				{ class = "WaterPurificationTablets"   , percent = 1.5  },
				{ category = "RandomTent"              , percent = 1    },
				{ class = "Mk18Reaver"                 , percent = 0.5  },
			},
		},

		{
			category = "RandomMilitaryFootlockerIronSonsContent",
			classes =
			{
				{ category  = "RandomMilitaryBodyArmor"         , percent = 14  },
				{ category  = "RandomMilitaryHelmet"            , percent = 13  },
				{ category  = "RandomAmmo"                      , percent = 10  },
				{ category  = "RandomRangedMilitaryPure"        , percent = 17  },
				{ category  = "RandomAmmoBox"                   , percent = 6   },
				{ category  = "RandomAccessory"                 , percent = 10  },
				{ category  = "RandomMilitaryFootlockerContent" , percent = 5   },
				{ category  = "EventHelmets"                     , percent = 2   },
				{ class     = "ScavengerHelmet"                 , percent = 3   },
				{ class     = "Mk18Reaver"                      , percent = 2   },
                { class     = "SCAAMAmalgarmin"                 , percent = 5   }, 
			},
		},

		{
			category = "RandomMilitaryDeskContent",
			classes =
			{
				{ class = "AmcoinLedger"            , percent = 10  , min = 1, max = 6  },
				{ class = "Amalgaduino"             , percent = 2   },
				{ category = "RandomAccessory"      , percent = 15  },
				{ category = "RandomCraftingGuide"  , percent = 20  },
				{ category = "RandomMedical"        , percent = 10  },
				{ category = "RandomHospitalBandage", percent = 5   },
				{ category = "RandomAmmo"           , percent = 19  },
				{ class = "Cb_radio"                , percent = 5   },
				{ class = "MagliteSmall"            , percent = 5   },
				{ class = "GridMap"                 , percent = 2   },
				{ class = "WaterPurificationTablets", percent = 2   },
                { class = "SCAAMAmalgarmin"         , percent = 5   }, 
			},
		},

		{
			category = "RandomSwitchboardContent",
			classes =
			{
				{ category = "RandomElectronicsContent", percent = 15 },
				{ class = "Amalgaduino", percent = 25 },
				{ class = "Cb_radio", percent = 10 },
				{ class = "MagliteSmall", percent = 15 },
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
				{ class = "AmcoinLedger", percent = 2 , min = 1, max = 6 },
				{ category = "RandomClothes", percent = 65 },
				{ category = "RandomFireStarter", percent = 6 },
				{ category = "RandomNormalRepairKit", percent = 5 },
				{ category = "RandomWeaponRepairKit", percent = 2 },
				{ category = "RandomMedical", percent = 5 },
				{ category = "RandomTrashContent", percent = 5 },
				{ category = "RandomPistol", percent = 6 },
				{ class = "WaterPurificationTablets", percent = 2 },
				{ category = "RandomTent", percent = 1 },
                { class = "SCAAMAmalgarmin", percent = 1}, 
			},
		},

		{
			category = "RandomSinkContent",
			classes =
			{
				{ category = "RandomNormalRepairKit"    , percent = 5   },
				{ category = "RandomMedical"            , percent = 15  },
				{ category = "RandomFireStarter"        , percent = 5   },
				{ category = "RandomTrashContent"       , percent = 7   },
				{ class = "PipeMetal"                   , percent = 5   },
				{ category = "RandomCraftingGuide"      , percent = 10  },
				{ category = "RandomFlashlight"         , percent = 5   },
				{ class = "HeatPack"                    , percent = 7   },
				{ class = "Rope"                        , percent = 6   },
				{ class = "RubbingAlcohol"              , percent = 10  },
				{ class = "Oil"                         , percent = 8   },
				{ class = "DuctTape"                    , percent = 10  },
				{ class = "DogFoodCan"                  , percent = 7   },
			},
		},

		{
			category = "RandomDeskContent",
			classes =
			{
				{ class    = "AmcoinLedger"            , percent = 4  , min = 1, max = 6 },
				{ category = "RandomCraftingGuide"     , percent = 25 },
				{ class    = "Amalgaduino"             , percent = 3  },
				{ class    = "HeatPack"                , percent = 5  },
				{ category = "RandomFireStarter"       , percent = 9 },
				{ class    = "AppleRotten"             , percent = 5  },
				{ class    = "HersheysBar"             , percent = 5  },
				{ category = "Map"                     , percent = 1  },
				{ category = "RandomHands"             , percent = 1  },
				{ category = "RandomEyes"              , percent = 1  },
				{ category = "RandomAccessory"         , percent = 5  },
				{ category = "RandomMedical"           , percent = 15 },
				{ category = "RandomAmmo"              , percent = 11 },
				{ category = "RandomSeeds"             , percent = 5  },
				{ class    = "WaterPurificationTablets", percent = 1  },
				{ category = "RandomWeaponRepairKit"   , percent = 1  },				
			},
		},

		{
			category = "RandomKitchenContent",
			classes =
			{
				{ class = "HeatPack"                , percent = 3   },
				{ category = "RandomMedical"        , percent = 1   },
				{ category = "RandomWoolGloves"     , percent = 1   },
				{ category = "BandanaHat"           , percent = 1   },
				{ category = "RandomCraftingGuide"  , percent = 11  },
				{ category = "RandomAmmo"           , percent = 1   },
				{ class = "AmcoinLedger"            , percent = 8   },
				{ category = "RandomFood"           , percent = 29  },
				{ category = "RandomSeeds"          , percent = 5   },
				{ category = "RandomFireStarter"    , percent = 10  },
				{ category = "SaltAndPepper"        , percent = 30  },
			},
		},

		{
			category = "RandomHospitalClothesSmall",
			classes =
			{
				{ category = "RandomAllHazmatMask"         , percent = 6  },
				{ category = "RandomAllGasCanisterPack"    , percent = 6  },
				{ category = "RandomAllHazmatSuit"         , percent = 6  },
				{ class = "DustMask"                       , percent = 9  },
				{ class = "GasMask"                        , percent = 9  },
				{ category = "RandomEyes"                  , percent = 11 },
				{ class = "FannyPackGray"                  , percent = 9  },
				{ class = "FannyPackRed"                   , percent = 9  },
				{ class = "FannyPackRedBlue"               , percent = 9  },
				{ class = "SneakersWhite"                  , percent = 9  },
				{ class = "HitopsBlue"                     , percent = 9  },
				{ class = "WoolGlovesBlue"                 , percent = 4  },
				{ class = "WoolGlovesWhite"                , percent = 4  },
			},
		},

		{
			category = "RandomHospitalClothes",
			classes =
			{
				{ category = "RandomHospitalClothesSmall", percent = 27 },
				{ category = "RandomClothes"             , percent = 14 },
				{ category = "RandomAllHazmatSuit"       , percent = 14 },
				{ category = "RandomAllGasCanisterPack"  , percent = 14 },
				{ class = "RainJacketOrangeBlue"         , percent = 5  },
				{ class = "RainJacketYellow"             , percent = 5  },
				{ class = "RainJacketRed"                , percent = 5  },
				{ class = "ButtonUpShirtBlue"            , percent = 4  },
				{ class = "ButtonUpShirtGrey"            , percent = 4  },
				{ class = "CottonShirtBlue"              , percent = 4  },
				{ class = "CottonShirtTan"               , percent = 4  },	
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
				{ category = "RandomMedical"        , percent = 73  },
				{ category = "RandomHospitalBandage", percent = 20  },
				{ class = "guide_medical_bandages"  , percent = 4   },
			},
		},

		{
			category = "RandomHospitalContentSmall",
			classes =
			{
				{ category = "RandomHospitalMedical"       , percent = 51 },
				{ category = "RandomHospitalClothesSmall"  , percent = 33 },
				{ category = "RandomConsumable"            , percent = 5  },
				{ category = "RandomChemlight"             , percent = 2  },
				{ category = "RandomFireStarter"           , percent = 2  },
				{ class = "Cb_radio"                       , percent = 2  },
				{ class = "MagliteSmall"                   , percent = 2  },
				{ class = "Headlamp"                       , percent = 2  },
				{ class = "HeadlampRed"                    , percent = 1  },
			},
		},

		{
			category = "RandomHospitalContentMedium",
			classes =
			{
				{ category = "RandomHospitalContentSmall"     , percent = 40 },
				{ category = "RandomHospitalClothes"          , percent = 39 },
				{ class = "WaterBottle"                       , percent = 8  },
				{ class = "camping_water_jug"                 , percent = 3  },
				{ class = "Hammer"                            , percent = 3  },
				{ class = "Hatchet"                           , percent = 2  },
				{ class = "SurvivalKnife"                     , percent = 2  },
			}, 
		},

		{
			category = "RandomHospitalContentBig",
			classes =
			{
				{ category = "RandomHospitalContentMedium", percent = 63 },
				{ category = "RandomHospitalClothes", percent = 20 },
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
				{ category = "RandomCraftingGuide", percent = 20 },
				{ category = "RandomClothes", percent = 20 },
				{ category = "RandomNormalRepairKit", percent = 2 },
			},
		},

		{
			category = "RandomOfficeContent",
			classes =
			{
				{ category = "RandomAmmo", percent = 3 },
				{ category = "RandomPistol", percent = 2 },
				{ class = "AmcoinLedger", percent = 3 },
				{ category = "RandomTrashContent", percent = 80 },
                { class = "SCAAMAmalgarmin", percent = 5}, 
			},
		},

		{
			category = "RandomSuitcaseContent",
			classes =
			{
				{ class = "AmcoinLedger", percent = 2 },
				{ category = "RandomEyes", percent = 10 },
				{ category = "RandomTorso", percent = 30 },
				{ category = "RandomLegs", percent = 50 },
                { class = "SCAAMAmalgarmin", percent = 5}, 
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
		
		-- Custom Metal Parts
		{
			category = "RandomMetalParts",
			classes =
			{
                
                { category = "RandomLetra"                           , percent = 5       },
                { category = "RandomPlastered"                       , percent = 12.5    },
                { category = "RandomConcrete"                        , percent = 12      },
                { category = "RandomPrefab"	    		             , percent = 1       },
                { category = "RandomGlassParts"   		             , percent = 12      },
                { category = "RandomTitanium"   		             , percent = 6       },
                { category = "RandomMarmol"       		             , percent = 12      },
                { category = "RandomTent"       		             , percent = 5       },
                { category = "RandomLadrillo"       	             , percent = 12.5    },
                { category = "RandomRocaPiedra"       	             , percent = 12      },
			},
		},

       {
			category = "RandomMarmol",
			classes =
			{
                { class = "marble_foundation_4m_4m_4m"               ,percent = 3.3       },  
                { class = "marble_foundation_black_4m_4m_4m"         ,percent = 3.3       },  
                { class = "marble_foundation_blue_4m_4m_4m"          ,percent = 3.3       },  
                { class = "marble_foundation_green_4m_4m_4m"         ,percent = 3.3       },  
                { class = "marble_wall_3m_2m"                        ,percent = 3.3       },  
                { class = "marble_wall_3m_2m_window"                 ,percent = 3.3       },  
                { class = "marble_wall_3m_4m"                        ,percent = 3.3       },  
                { class = "marble_crenelation"                       ,percent = 3.3       },  
                { class = "marble_wall_black_3m_2m"                  ,percent = 3.3       },  
                { class = "marble_wall_black_3m_4m"                  ,percent = 3.3       },  
                { class = "marble_crenelation_black"                 ,percent = 3.3       },  
                { class = "marble_wall_blue_3m_2m_window"            ,percent = 3.3       },  
                { class = "marble_crenelation_blue"                  ,percent = 3.3       },  
                { class = "marble_platform_3m_4m_4m"                 ,percent = 3.3       },  
                { class = "marble_platform_3m_4m_4m_stairs"          ,percent = 3.3       },  
                { class = "marble_platform_3m_8m_8m"                 ,percent = 3.3       },  
                { class = "marble_platform_blue_3m_4m_4m"            ,percent = 3.3       },  
                { class = "marble_platform_green_3m_8m_8m"           ,percent = 3.3       },  
                { class = "marble_platform_green_3m_4m_4m"           ,percent = 3.3       },  
                { class = "marble_column_3m"                         ,percent = 3.3       },  
                { class = "marble_column_3m_black"                   ,percent = 3.3       },  
                { class = "marble_column_3m_blue"                    ,percent = 3.3       },  
                { class = "marble_column_3m_green"                   ,percent = 3.3       },  
                { class = "marble_angled_roof_3x4x4"                 ,percent = 3.3       },  
                { class = "marble_angled_roof_black_3x4x4"           ,percent = 3.3       },  
                { class = "marble_angled_roof_green_3x4x4"           ,percent = 3.3       },  
                { class = "marble_ceiling_4m_4m_black"               ,percent = 3.3       },  
                { class = "marble_ceiling_8m_8m_blue"                ,percent = 3.3       },  
                { class = "marble_ceiling_8m_8m_green"               ,percent = 3.3       },  
                { class = "marble_ceiling_16m_16m_black"             ,percent = 3.3       },  
            },
		},

        {
			category = "RandomRocaPiedra",
			classes =
			{
                { class = "cobblestone_angled_roof_3x4x4"         ,percent = 3.57  },  
                { class = "cobblestone_ceiling_4m_4m"             ,percent = 3.57  },
                { class = "cobblestone_ceiling_8m_8m"             ,percent = 3.57  },
                { class = "cobblestone_ceiling_16m_16m"           ,percent = 3.57  },
                { class = "cobblestone_column_3m"                 ,percent = 3.57  },
                { class = "cobblestone_crenelation"               ,percent = 3.57  },
                { class = "cobblestone_platform_3m_4m_4m"         ,percent = 3.57  },
                { class = "cobblestone_platform_3m_4m_4m_stairs"  ,percent = 3.57  },
                { class = "cobblestone_platform_3m_8m_8m"         ,percent = 3.57  },
                { class = "cobblestone_wall_3m_2m"                ,percent = 3.57  },
                { class = "cobblestone_wall_3m_2m_window"         ,percent = 3.57  },
                { class = "cobblestone_wall_3m_4m"                ,percent = 3.57  },
                { class = "cobblestone_wall_3m_4m_door"           ,percent = 3.57  },
                { class = "cobblestone_wall_3m_4m_window"         ,percent = 3.57  },
                { class = "rock_doorway_3m_4m"                    ,percent = 3.57  },
                { class = "rock_wall_3m_2m"                       ,percent = 3.57  },
                { class = "rock_wall_3m_4m"                       ,percent = 3.57  },
                { class = "rock_wall_4m_2m"                       ,percent = 3.57  },
                { class = "rock_wall_4m_4m"                       ,percent = 3.57  },
                { class = "rock_wall_window_3m_2m"                ,percent = 3.57  },
                { class = "rock_wall_window_3m_4m"                ,percent = 3.57  },
                { class = "rock_doorway_3m_4m_beamless"           ,percent = 3.57  },
                { class = "rock_wall_3m_2m_beamless"              ,percent = 3.57  },
                { class = "rock_wall_3m_4m_beamless"              ,percent = 3.57  },
                { class = "rock_wall_4m_2m_beamless"              ,percent = 3.57  },
                { class = "rock_wall_4m_4m_beamless"              ,percent = 3.57  },
                { class = "rock_wall_window_3m_2m_beamless"       ,percent = 3.57  },
                { class = "rock_wall_window_3m_4m_beamless"       ,percent = 3.57  },

            },
		},

        {
			category = "RandomTitanium",
			classes =
			{
                { class = "titanium_wall_3m_2m"                 ,percent = 6.6       },  
                { class = "titanium_wall_3m_2m_window"          ,percent = 6.6       },
                { class = "titanium_wall_3m_4m"                 ,percent = 6.6       },
                { class = "titanium_wall_3m_4m_door"            ,percent = 6.6       },
                { class = "titanium_wall_3m_4m_window"          ,percent = 6.6       },
                { class = "titanium_crenelation"                ,percent = 6.6       },
                { class = "titanium_platform_3m_4m_4m"          ,percent = 6.6       },
                { class = "titanium_platform_3m_4m_4m_stairs"   ,percent = 6.6       },
                { class = "titanium_platform_3m_8m_8m"          ,percent = 6.6       },
                { class = "titanium_ceiling_4m_4m"              ,percent = 6.6       },
                { class = "titanium_ceiling_8m_8m"              ,percent = 6.6       },
                { class = "titanium_ceiling_16m_16m"            ,percent = 6.6       },
                { class = "titanium_column_3m"                  ,percent = 6.6       },
                { class = "titanium_angled_roof_3x4x4"          ,percent = 6.6       },
                { class = "door_titanium"                       ,percent = 6.6       },
            },
		},
        {
			category = "RandomGlassParts",
			classes =
			{
				{ class = "glass_doorway_3m_2m"       , percent = 3.12 },
				{ class = "glass_doorway_3m_4m"       , percent = 3.12 },
				{ class = "glass_doorway_3m_4m_side"  , percent = 3.12 },
                { class = "glass_doorway_3m_4m_v2"    , percent = 3.12 },
                { class = "glass_doorway_3m_8m"       , percent = 3.12 },
                { class = "glass_wall_1_3m_2m"        , percent = 3.12 },
                { class = "glass_wall_1_3m_4m"        , percent = 3.12 },
                { class = "glass_wall_1_3m_8m"        , percent = 3.12 },
                { class = "glass_wall_1_3m_12m"       , percent = 3.12 },
                { class = "glass_wall_1_3m_16m"       , percent = 3.12 },
                { class = "glass_wall_2m_2m"          , percent = 3.12 },
                { class = "glass_wall_2m_4m"          , percent = 3.12 },
                { class = "glass_wall_2m_8m"          , percent = 3.12 },
                { class = "glass_wall_2m_12m"         , percent = 3.12 },
                { class = "glass_wall_2m_16m"         , percent = 3.12 },
                { class = "glass_wall_3m_2m"          , percent = 3.12 },
                { class = "glass_wall_3m_4m"          , percent = 3.12 },
                { class = "glass_wall_3m_8m"          , percent = 3.12 },
                { class = "glass_wall_3m_12m"         , percent = 3.12 },
                { class = "glass_wall_3m_16m"         , percent = 3.12 },
                { class = "glass_door_2m_1m"          , percent = 3.12 },
                { class = "glass_door_3m_2m"          , percent = 3.12 },
                { class = "window"                    , percent = 3.12 },
                { class = "door_glass_white"          , percent = 3.12 },
                { class = "Glass_Platform_HMS_3x16x16", percent = 3.12 },
                { class = "Glass_Platform_HMS_3x12x12", percent = 3.12 },
                { class = "Glass_Platform_HMS_3x8x8"  , percent = 3.12 },
                { class = "Glass_Platform_HMS_3x4x4"  , percent = 3.12 },
                { class = "Glass_Platform_HMS_0x16x16", percent = 3.12 },
                { class = "Glass_Platform_HMS_0x12x12", percent = 3.12 },
                { class = "Glass_Platform_HMS_0x8x8"  , percent = 3.12 },
                { class = "Glass_Platform_HMS_0x4x4"  , percent = 3.12 },
			},
		},
        {
			category = "RandomConcrete",
			classes =
			{
                { class = "concrete_wall_3m_2m_white"                ,  percent = 0.8   },
                { class = "Concrete_wall_3x8_gold"                   ,  percent = 0.8   },        
                { class = "concrete_wall_window_3m_4m_white"         ,  percent = 0.8   },
                { class = "Concrete_triangle_roof_3x4x4_02_black"    ,  percent = 0.8   },
                { class = "Concrete_curve_wall_window_3x4x4_02_white",  percent = 0.8   },
                { class = "Concrete_curve_wall_stairs_3x4x4_gold"    ,  percent = 0.8   },    
                { class = "Concrete_curve_wall_3x4x4_grey"           ,  percent = 0.8   },    
                { class = "concrete_gate_z"				             ,  percent = 0.8   },
				{ class = "concrete_platform_16m_16m_black"	         ,  percent = 0.8   },
                { class = "concrete_wall_door_3m_4m_black"           ,  percent = 0.8   },	
                { class = "Concrete_wall_3x12_grey"                  ,  percent = 0.8   },
                { class = "Concrete_wall_3x12_white"                 ,  percent = 0.8   },
                { class = "Concrete_wall_3x12_gold",                    percent = 0.8   },
                { class = "Concrete_wall_3x12_black",                   percent = 0.8   },
                { class = "concrete_halfwall1_2m_white",                percent = 0.8   },
                { class = "concrete_halfwall1_3m_white",                percent = 0.8   },
                { class = "concrete_halfwall1_3x3m_white",              percent = 0.8   },
                { class = "concrete_wall_3m_4m",                        percent = 0.8   },
                { class = "concrete_wall_3m_16m",                       percent = 0.8   },
                { class = "concrete_wall_door_3m_4m",                   percent = 0.8   },
                { class = "concrete_wall_window_3m_4m",                 percent = 0.8   },
                { class = "concrete_halfwall1_2m",                      percent = 0.8   },
                { class = "concrete_halfwall1_3m_black",                percent = 0.8   },
                { class = "concrete_halfwall1_3x3m_black",              percent = 0.8   },
                { class = "concrete_wall_3m_2m_gold",                   percent = 0.8   },
                { class = "concrete_wall_3m_4m_gold",                   percent = 0.8   },
                { class = "concrete_wall_3m_16m_gold",                  percent = 0.8   },
                { class = "concrete_wall_door_3m_4m_gold",              percent = 0.8   },
                { class = "concrete_wall_window_3m_4m_gold",            percent = 0.8   },
                { class = "concrete_halfwall1_2m_gold",                 percent = 0.8   },
                { class = "concrete_halfwall1_3m_gold",                 percent = 0.8   },
                { class = "Concrete_curve_wall_1_5x4x4_black",          percent = 0.8   },
                { class = "Concrete_curve_wall_1_5x4x4_gold",           percent = 0.8   },
                { class = "Concrete_curve_wall_1_5x4x4_grey",           percent = 0.8   },
                { class = "Concrete_curve_wall_1_5x4x4_white",          percent = 0.8   },
                { class = "Concrete_curve_wall_3x4x4_white",            percent = 0.8   },
                { class = "Concrete_curve_wall_stairs_02_3x4x4_black",  percent = 0.8   },
                { class = "Concrete_curve_wall_stairs_02_3x4x4_gold",   percent = 0.8   },
                { class = "Concrete_curve_wall_stairs_3x4x4_black",     percent = 0.8   },
                { class = "concrete_platform_3m_4m_white",              percent = 0.8   },
                { class = "concrete_platform_4m_4m_white",              percent = 0.8   },
                { class = "concrete_platform_16m_16m_white",            percent = 0.8   },
                { class = "concrete_platform_3m_4m_black",              percent = 0.8   },
                { class = "concrete_platform_4m_4m_black",              percent = 0.8   },
                { class = "concrete_platform_3m_4m",                    percent = 0.8   },
                { class = "concrete_platform_4m_4m",                    percent = 0.8   },
                { class = "concrete_platform_16m_16m",                  percent = 0.8   },
                { class = "concrete_platform_3m_4m_gold",               percent = 0.8   },
                { class = "concrete_platform_4m_4m_gold",               percent = 0.8   },
                { class = "concrete_platform_16m_16m_gold",             percent = 0.8   },
                { class = "Concrete_curve_platform_3x4x4_black",        percent = 0.8   },
                { class = "Concrete_curve_platform_3x4x4_gold",         percent = 0.8   },
                { class = "Concrete_curve_platform_3x4x4_grey",         percent = 0.8   },
                { class = "Concrete_curve_platform_3x4x4_white",        percent = 0.8   },
                { class = "Concrete_platform_0x12x12_black",            percent = 0.8   },
                { class = "Concrete_platform_0x12x12_gold",             percent = 0.8   },
                { class = "Concrete_platform_0x12x12_grey",             percent = 0.8   },
                { class = "Concrete_platform_0x12x12_white",            percent = 0.8   },
                { class = "Concrete_platform_0x8x8_black",              percent = 0.8   },
                { class = "Concrete_platform_0x8x8_gold",               percent = 0.8   },
                { class = "Concrete_platform_0x8x8_grey",               percent = 0.8   },
                { class = "Concrete_platform_0x8x8_white",              percent = 0.8   },
                { class = "Concrete_platform_3x12x12_black",            percent = 0.8   },
                { class = "Concrete_platform_3x12x12_gold",             percent = 0.8   },
                { class = "Concrete_platform_3x12x12_grey",             percent = 0.8   },
                { class = "Concrete_platform_3x12x12_white",            percent = 0.8   },
                { class = "Concrete_platform_3x16x16_black",            percent = 0.8   },
                { class = "Concrete_platform_3x16x16_gold",             percent = 0.8   },
                { class = "Concrete_platform_3x16x16_grey",             percent = 0.8   },
                { class = "Concrete_platform_3x16x16_white",            percent = 0.8   },
                { class = "Concrete_platform_3x4x4_black",              percent = 0.8   },
                { class = "Concrete_platform_3x4x4_gold",               percent = 0.8   },
                { class = "Concrete_platform_3x4x4_grey",               percent = 0.8   },
                { class = "Concrete_platform_3x4x4_white",              percent = 0.8   },
                { class = "Concrete_platform_3x8x8_black",              percent = 0.8   },
                { class = "Concrete_platform_3x8x8_gold",               percent = 0.8   },
                { class = "Concrete_platform_3x8x8_grey",               percent = 0.8   },
                { class = "Concrete_platform_3x8x8_white",              percent = 0.8   },
                { class = "round_platform_conctete_0x8_black",          percent = 0.8   },
                { class = "round_platform_conctete_0x8_gold",           percent = 0.8   },
                { class = "round_platform_conctete_0x8_grey",           percent = 0.8   },
                { class = "round_platform_conctete_0x8_white",          percent = 0.8   },
                { class = "concrete_foundation_4m_4m_white",            percent = 0.8   },
                { class = "concrete_foundation_4m_4m_black",            percent = 0.8   },
                { class = "concrete_foundation_4m_4m",                  percent = 0.8   },
                { class = "concrete_foundation_4m_4m_gold",             percent = 0.8   },
                { class = "concrete_column_3m_white",                   percent = 0.8   },
                { class = "concrete_column_3m_black",                   percent = 0.8   },
                { class = "concrete_column_3m",                         percent = 0.8   },
                { class = "concrete_column_3m_gold",                    percent = 0.8   },
                { class = "Concrete_round_column_3m_black",             percent = 0.8   },
                { class = "Concrete_round_column_3m_gold",              percent = 0.8   },
                { class = "Concrete_round_column_3m_grey",              percent = 0.8   },
                { class = "Concrete_round_column_3m_white",             percent = 0.8   },
                { class = "concrete_stairs_1m_3m",                      percent = 0.8   },
                { class = "concrete_stairs_1m_3m_black",                percent = 0.8   },
                { class = "concrete_stairs_1m_3m_white",                percent = 0.8   },
                { class = "concrete_stairs_1m_3m_gold",                 percent = 0.8   },
                { class = "concrete_stairs_2m_1_3m",                    percent = 0.8   },
                { class = "concrete_block_stairs_3m",                   percent = 0.8   },
                { class = "concrete_block_stairs_3m_white",             percent = 0.8   },
                { class = "concrete_block_stairs_3m_gold",              percent = 0.8   },
                { class = "concrete_block_stairs2_3m_black",            percent = 0.8   },
                { class = "concrete_block_stairs2_3m_gold",             percent = 0.8   },
                { class = "concrete_ramp_3x4_black",                    percent = 0.8   },
                { class = "concrete_ramp_3x4_gold",                     percent = 0.8   },
                { class = "concrete_roof",                              percent = 0.8   },
                { class = "concrete_roof_white",                        percent = 0.8   },
                { class = "Concrete_conical_roof_3x4x4_black",          percent = 0.8   },
                { class = "concrete_roof_gold",                         percent = 0.8   },
                { class = "Concrete_conical_roof_3x4x4_grey",           percent = 0.8   },
                { class = "Concrete_triangle_roof_3x4x4_grey",          percent = 0.8   },
                { class = "Concrete_triangle_roof_3x4x4_gold",          percent = 0.8   },
                { class = "concrete_room_c_shape_white",                percent = 0.8   },
                { class = "concrete_room_corner_white",                 percent = 0.8   },
                { class = "concrete_room_column_white",                 percent = 0.8   },
                { class = "concrete_room_c_shape_black",                percent = 0.8   },
                { class = "concrete_room_c_shape",                      percent = 0.8   },
                { class = "concrete_room_column_gold",                  percent = 0.8   },
                { class = "concrete_gatehouse_gate",                    percent = 0.8   },
			},
		},
		{
			category = "RandomLetra",
			classes =
			{
				{ class = "a"        , percent =  2.7   },
				{ class = "b"        , percent =  2.7   },
				{ class = "c"        , percent =  2.7   },
				{ class = "d"        , percent =  2.7   },
				{ class = "e"        , percent =  2.7   },
                { class = "f"        , percent =  2.7   },
                { class = "g"        , percent =  2.7   },
				{ class = "h"        , percent =  2.7   },
				{ class = "i"        , percent =  2.7   },
				{ class = "j"        , percent =  2.7   },
				{ class = "k"        , percent =  2.7   },
				{ class = "l"        , percent =  2.7   },
				{ class = "m"        , percent =  2.7   },
				{ class = "n"        , percent =  2.7   },
                { class = "o"        , percent =  2.7   },
                { class = "p"        , percent =  2.7   },
                { class = "q"        , percent =  2.7   },
                { class = "r"        , percent =  2.7   },
                { class = "s"        , percent =  2.7   },
                { class = "t"        , percent =  2.7   },
                { class = "u"        , percent =  2.7   },
                { class = "v"        , percent =  2.7   },
                { class = "w"        , percent =  2.7   },
                { class = "x"        , percent =  2.7   },
                { class = "y"        , percent =  2.7   },
                { class = "z"        , percent =  2.7   },
                { class = "one"      , percent =  2.7   },
                { class = "two"      , percent =  2.7   },
                { class = "three"    , percent =  2.7   },
                { class = "four"     , percent =  2.7   },
                { class = "five"     , percent =  2.7   },
                { class = "six"      , percent =  2.7   },
                { class = "seven"    , percent =  2.7   },
                { class = "eight"    , percent =  2.7   },
                { class = "nine"     , percent =  2.7   },
                { class = "zero"     , percent =  2.7   },
			},
		},

        {
			category = "RandomPlastered",
			classes =
			{
				{ class = "plastered_wall_purple_3m_4m"                 , percent =  4.7   },
                { class = "plastered_wall_purple_3m_4m_door"            , percent =  4.7   },
                { class = "plastered_wall_purple_3m_2m_window"          , percent =  4.7   },
                { class = "plastered_crenelation_purple"                , percent =  4.7   },
                { class = "plastered_wall_red_3m_2m"                    , percent =  4.7   },
                { class = "plastered_wall_red_3m_4m_door"               , percent =  4.7   },
                { class = "plastered_column_3m"                         , percent =  4.7   },
                { class = "plastered_column_3m_black"                   , percent =  4.7   },
                { class = "plastered_column_3m_blue"                    , percent =  4.7   },
                { class = "plastered_column_3m_green"                   , percent =  4.7   },
                { class = "plastered_column_3m_purple"                  , percent =  4.7   },
                { class = "plastered_platform_3m_4m_4m"                 , percent =  4.7   },
                { class = "plastered_platform_3m_4m_4m_stairs"          , percent =  4.7   },    
                { class = "plastered_platform_black_3m_4m_4m_stairs"    , percent =  4.7   },    
                { class = "plastered_platform_blue_3m_8m_8m"            , percent =  4.7   },
                { class = "plastered_platform_green_3m_4m_4m"           , percent =  4.7   },
                { class = "plastered_wall_black_3m_2m_window"           , percent =  4.7   }, 
				{ class = "plastered_wall_green_3m_4m_door"             , percent =  4.7   },
				{ class = "plastered_wall_red_3m_4m"                    , percent =  4.7   },
				{ class = "plastered_angled_roof_3x4x4"                 , percent =  4.7   },
                { class = "plastered_wall_3m_2m_window"                 , percent =  4.7   },
			},
		},
        
		{
			category = "RandomPrefab",
			classes =
			{
				{ class = "one_story_white"              , percent =  6.5  },
				{ class = "one_story_green"              , percent =  8   },
				{ class = "one_story_red"                , percent =  7.5  },
				{ class = "one_story_black"              , percent =  8    },
				{ class = "cabin_wood_black"             , percent =  7    },
                { class = "cabin_wood_simple"    		 , percent =  7    },
                { class = "cabin_wood_simple_black"      , percent =  5   },
				{ class = "cabin_wood_simple_red"        , percent =  6   },
				{ class = "cabin_wood"                   , percent =  7    },
				{ class = "villa_red"					 , percent =  7   },
				{ class = "villa_black"					 , percent =  7    },
				{ class = "villa_white"					 , percent =  8   },
				{ class = "carliftbase"					 , percent =  2    },
				{ class = "carlift"						 , percent =  2    },
                { class = "6mx6m_corrugated_metal_02"	 , percent =  12    },
			},
		},

        {
			category = "RandomLadrillo",
			classes =
			{
				{ class = "brick_angled_roof_3x4x4"              , percent =  5.5  },
				{ class = "brick_ceiling_4m_4m"                  , percent =  10   },
				{ class = "brick_ceiling_8m_8m"                  , percent =  6.5  },
				{ class = "brick_ceiling_16m_16m"                , percent =  8    },
				{ class = "brick_column_3m"                      , percent =  7    },
                { class = "brick_crenelation"    		         , percent =  7    },
                { class = "brick_platform_3m_4m_4m"              , percent =  10   },
				{ class = "brick_platform_3m_4m_4m_stairs"       , percent =  10   },
				{ class = "brick_platform_3m_8m_8m"              , percent =  7    },
				{ class = "brick_wall_3m_2m"					 , percent =  10   },
				{ class = "brick_wall_3m_2m_window"				 , percent =  7    },
				{ class = "brick_wall_3m_4m"					 , percent =  10   },
				{ class = "brick_wall_3m_4m_door"				 , percent =  1    },
				{ class = "brick_wall_3m_4m_window"				 , percent =  1    },
			},
		},
	
		-- Air Drops
		{
			-- The cargo drop crate has 50 slots
			category = "RandomAirDropCrate",
			classes =
			{
				{ category = "RandomAirDropCratePolice"         , percent = 15  },
				{ category = "RandomAirDropCrateMilitary"       , percent = 15  },
				{ category = "RandomAirDropCrateCivilian"       , percent = 20  },
				{ category = "RandomAirDropCrateExplosives"     , percent = 15  },
				{ category = "RandomAirDropCrateBaseBuilding"   , percent = 20  },
				{ category = "RandomAirDropCrateRadiation"      , percent = 15  },
			},
		},

		{
			category = "AirDropSantaCrate",
			group =
			{
				{ category = "RandomChristmasClothing"       , percent = 100                   },
				{ class = "ChristmasPresentCommon1"          , percent = 100                   },
				{ class = "ChristmasPresentCommon1"          , percent = 100                   },
				{ class = "ChristmasPresentCommon2"          , percent = 100                   },
				{ class = "ChristmasPresentRare"             , percent = 100                   },
				{ class = "ChristmasPresentRare"             , percent = 100                   },
				{ class = "ChristmasPresentRare"             , percent = 100                   },
				{ class = "ChristmasHat"                     , percent = 50                    },
				{ category = "RandomDuffelBag"               , percent = 100                   },
				{ category = "RandomAmmoBox"                 , percent = 100                   },
                { category = "RandomCargador"                , percent = 100                   },
                { category = "RandomCargador"                , percent = 100                   },
				{ category = "RandomAmmoBox"                 , percent = 100                   },
				{ category = "RandomAmmoBox"                 , percent = 100                   },
				{ category = "RandomAccessory"               , percent = 100                   },
				{ category = "RandomAccessory"               , percent = 50.5                  },
				{ category = "RandomIronSuite"               , percent = 20                    },
				{ category = "RandomSpartaGear"           	 , percent = 50					   },
                { category = "RandomMXCloth"			     , percent = 50                    },
				{ category = "RandomMetalParts"              , percent = 80 				   },
				{ category = "RandomMetalParts"              , percent = 80					   },
				{ category = "RandomEpicWeapon"              , percent = 7.5 				   },
                { category = "RandomEpicWeapon"              , percent = 25.5 				   },
				{ class = "StunBaton"                        , percent = 50                    },
				{ class = "StunBaton"                        , percent = 25					   },
				{ class = "Icepickaxe"                       , percent = 25 				   },
				{ category = "RandomRangedMilitaryPure"      , percent = 100 				   },
				{ category = "RandomRangedMilitaryPure"      , percent = 25.5 				   },
				{ category = "RandomRangedMilitaryPure"      , percent = 100 				   },
				{ class = "AmcoinLedger"                     , percent = 1, min = 5, max = 50  },
                { class = "AmcoinLedger"                     , percent = 10, min = 1, max = 30 },
                { category = "RandomTron"                    , percent = 5 					   },
                { category = "RandomMetalParts"              , percent = 15  			       },
                { category = "EventHelmets"                  , percent = 100  			       },
                { category = "RandomRangedPure"              , percent = 15  			       },
                { class = "GingerBreadMan", percent = 100, min = 2, max = 5 },
                { class = "GingerBreadMan", percent = 100, min = 2, max = 5 },
                { class = "wood_coffin"                  , percent = 25   },
				
			},
		},
		
		{
			category = "RandomAirDropCrateMilitary",
			group =
			{
				{ category = "RandomRangedMilitaryPure", percent = 100 },
                { category = "RandomRangedPure"        , percent = 100 },
                { category = "RandomAmmo"              , percent = 100 },
                { category = "RandomAmmo"              , percent = 100 },
                { category = "RandomAmmo"              , percent = 100 },
				{ category = "RandomAmmoBox"           , percent = 100 },
				{ category = "RandomAmmoBox"           , percent = 100 },
				{ category = "RandomAmmoBox"           , percent = 100 },
				{ category = "RandomAccessory"         , percent = 100 },
				{ category = "RandomAccessory"         , percent = 100 },
				{ category = "RandomMilitaryArmor"     , percent = 100 },
                { category = "RandomMelee"             , percent = 100 },
				--{ class = "GrenadePickup"              , percent = 100 , min = 1, max = 5},
				--{ class = "GrenadePickup"              , percent = 100 , min = 1, max = 5},
				{ category = "RandomDuffelBag"         , percent = 100 },
                { category = "RandomBeret"             , percent = 100 },
                { category = "RandomMilitaryClothing"  , percent = 100 },
                { category = "RandomSilencer"          , percent = 100 },
				{ category = "RandomCargador"          , percent = 100 },
                { category = "RandomCargador"          , percent = 100 },
                { category = "RandomCargador"          , percent = 100 },
                { category = "RandomCargador"          , percent = 100 },
                { class = "AmcoinLedger"               , percent = 100 , min = 64, max = 128 },
				{ class = "FlashlightRifle"            , percent = 100 },
				{ class = "Pile_762x39"                , percent = 100 },
                { class = "PlasmaRifle"				   , percent = 4   },
				--{ class = "C4TimedPickup"              , percent = 1    , min = 1, max = 3 },
				--{ class = "C4TimedPickup"              , percent = 5    , min = 1, max = 1 },
				{ class = "M4A1"                       , percent = 15  },
				{ class = "AKM"                        , percent = 50  },
				{ class = "Headlamp"                   , percent = 80  },
				{ class = "AK5D"                       , percent = 25  },
				{ class = "VSS"                        , percent = 10  },
				{ class = "M4V5"                       , percent = 2   },
				{ class = "RPK"                        , percent = 2   },
                { class = "SCAAMAmalgarmin"			   , percent = 50 }, 
                { category = "RandomTron"  			   , percent = 10  },
				{ category = "RandomAllHazmatSuit"     , percent = 70  },
				{ category = "RandomPlasma"			   , percent = 30   , min = 3, max = 40 },
				{ category = "RandomPlasma"			   , percent = 30   , min = 3, max = 40 },
				{ class = "SCAR-H"			           , percent = 20  },
                { class = "G36C"                       , percent = 25 	    },
				{ class = "762x5"			           , percent = 25  },
				{ class = "akval_drummag_75rnd"	       , percent = 50  },
                { class = "SAPOCBriefcaseClosed"       , percent = 5  },
                { class = "STANAGx50"     			   , percent = 50  },

			},
		},
		
		{
			category = "RandomAirDropCrateRadiation",
			group =
			{
				{ category = "RandomRangedMilitaryPure"       , percent = 100 },
				{ category = "RandomAmmo"                     , percent = 100 },
                { category = "RandomAmmo"                     , percent = 100 },
                { category = "RandomAmmo"                     , percent = 100 },
                { category = "RandomAmmo"                     , percent = 100 },
                { category = "RandomCargador"                , percent = 100                   },
                { category = "RandomAccessory"                , percent = 100 },
				{ category = "RandomAllHazmatMask"            , percent = 100 },
				{ category = "RandomAllGasCanisterPack"       , percent = 100 },
				{ class = "AntiradiationPills"                , percent = 100  , min = 3, max = 9  },
				{ class = "AntiradiationPills"                , percent = 100  , min = 3, max = 9  },
				{ class = "MushroomAntiRad"                   , percent = 100  , min = 5, max = 5  },
				{ class = "PotassiumIodidePills"              , percent = 100  , min = 3, max = 3  },
                { category = "RandomMedical"                  , percent = 100 },
				{ class = "AntibioticBandage"                 , percent = 100  , min = 3, max = 9  },
				{ class = "AdvancedBandage"                   , percent = 100  , min = 3, max = 9  },
				{ class = "camping_water_jug"                 , percent = 100 },
				{ class = "MushroomHeal"                      , percent = 100  , min = 3, max = 3  },
				--{ class = "GrenadePickup"                     , percent = 100 },
				{ class = "HeatPack"                          , percent = 100  , min = 3, max = 50 },
                { class = "Pile_762x39"                       , percent = 100 },
                { class = "WaterPurificationTablets"          , percent = 100  , min = 1, max = 25 },
                { category = "EventHelmets"                   , percent = 80 },
                { category = "RandomSkullGear"    			  , percent = 10 },
                { class = "R90"                               , percent = 70 },
				{ class = "57x50"                             , percent = 80 },
				{ class = "WaterPurificationTablets"          , percent = 25, min = 3, max = 3 },
				{ class = "Mk18Reaver"                        , percent = 2 },
				{ category = "RandomMetalParts"               , percent = 15 },
				{ category = "RandomMetalParts"               , percent = 30 },
				{ class = "M4A1"                              , percent = 20 },
				{ category = "RandomAmmo"                     , percent = 60 },
				{ class = "AKMGold"                           , percent = 5 },
				{ class = "Mk18Reaver"                        , percent = 5 },
				{ class = "AmcoinLedger"                      , percent = 1, min = 5, max = 88 },
				{ category = "RandomFlashlight"               , percent = 50 },
				{ class = "AKVal"                             , percent = 30 },
				{ class = "AK5D"                              , percent = 25 },
				{ class = "556x30_ak5d"                       , percent = 50 },
				{ class = "762x20_Akval"                      , percent = 80 },
				{ class = "OPKSight"                          , percent = 60 },
				{ class = "R3Sight"                           , percent = 70 },
				{ class = "PSOScope"                          , percent = 40 },
				{ category = "RandomTent"                     , percent = 5 },
				{ class = "ext_762x75"                        , percent = 16 },
				{ class = "ext_556x75"                        , percent = 17 },
                { category = "RandomAllHazmatSuit"			  , percent = 50 },
                { category = "RandomAllHazmatMask"			  , percent = 80 },
                { category = "RandomTron"         			  , percent = 5 },
				{ class = "762x5"			           		  , percent = 25  },
			},
		},
		
		{
			category = "RandomAirDropCrateBaseBuilding",
			group =
			{
                { class = "Amalgaduino"                    , percent = 100, min = 1 , max = 20 },
                { class = "Rags"                           , percent = 100, min = 10, max = 30 },
                { class = "SheetMetal"                     , percent = 100, min = 12, max = 48 },
				{ class = "SheetMetal"                     , percent = 100, min = 12, max = 48 },
                { class = "SheetMetal"                     , percent = 5,   min = 12, max = 48 },
				{ class = "Lumber"                         , percent = 80,  min = 12, max = 48 },
                { class = "Lumber"                         , percent = 50,  min = 12, max = 48 },
				{ class = "Lumber"                         , percent = 100, min = 12, max = 48 },
                { class = "Lumber"                         , percent = 100, min = 12, max = 48 },
                { class = "IronIngot"                      , percent = 50,  min = 12, max = 36 },
                { class = "IronIngot"                      , percent = 100, min = 12, max = 36 },
				{ class = "Charcoal"                       , percent = 100, min = 12, max = 36 },
                { class = "IronOre"                        , percent = 100, min = 12, max = 36 },
				{ class = "WoodPile"                       , percent = 50,  min = 12, max = 36 },
				{ class = "Pyrite"                         , percent = 25,  min = 12, max = 36 },
				{ class = "Rocks"                          , percent = 10,  min = 12, max = 36 },
				{ class = "Nails"                          , percent = 80,  min = 12, max = 36 },
				{ class = "Charcoal"                       , percent = 70,  min = 12, max = 36 },
                { class = "ScrapMetal"         			   , percent = 50,  min = 1 , max = 20 },
				{ class = "ScrapMetal"         			   , percent = 30,  min = 1 , max = 20 },
                { class = "ScrapMetal"         			   , percent = 100, min = 1 , max = 20 },
				{ category = "RandomMetalParts"			   , percent = 100 },
                { category = "RandomMetalParts"			   , percent = 100 },
				{ category = "RandomMetalParts"            , percent = 100 },
				{ category = "RandomMetalParts"            , percent = 100 },
                { category = "RandomMetalParts"            , percent = 100 },
                { category = "RandomMetalParts"            , percent = 50  },
				{ class = "ConcreteBag"                    , percent = 100  , min = 1, max = 5 },
                { class = "ConcreteBag"       			   , percent = 100  , min = 1, max = 5 },
                { class = "ConcreteBag"       			   , percent = 50   , min = 1, max = 5 },
				{ category = "RandomPaintCan"              , percent = 80  },
                { category = "RandomGlassParts"            , percent = 90  },
                { class = "UFOStorage_Crate_packed"        , percent = 10   },
                { class = "epic_gold_crate_packed"         , percent = 5   },
                { category = "RandomMonumento"             , percent = 0.5 },
                { class = "SCAAMCCTVCamera"                , percent = 20  },
				{ class = "WorkLight"                      , percent = 50   ,min = 1, max = 5 },                
				{ class = "CamoNetting"                    , percent = 30   , min = 5, max = 10 },
				{ class = "guide_concrete"                 , percent = 50  },
                { class = "guide_buildextra"               , percent = 5   },
                { category = "RandomMetalParts"            , percent = 75  },
				{ category = "RandomMetalParts"            , percent = 75  },
				{ category = "RandomMetalParts"            , percent = 75  },
				{ category = "RandomMetalParts"            , percent = 75  },
				{ class = "Icepickaxe"                     , percent = 2   },
                { class = "Pickaxe"                        , percent = 25  },
                { class = "Hammer"                         , percent = 25  },
                { class = "Hammer"                         , percent = 25  },
				{ class = "ElectricalParts"                , percent = 50   , min = 1, max = 5},
                { class = "DuctTape"                       , percent = 50   , min = 5, max = 15},
                { class = "AmcoinLedger"                   , percent = 100  , min = 1, max = 128 },
                { class = "AmcoinLedger"                   , percent = 100  , min = 1, max = 128 },
                { category = "RandomMedical"	           , percent = 100  , min = 1, max = 10    },
                { class = "AnonMask"                      , percent = 1   },
			},
		},
		
		{
			category = "RandomAirDropCratePolice",
			group =
			{
                { category = "RandomMedical"	       , percent = 100  , min = 1, max = 10    },
                { category = "RandomAmmo"              , percent = 100 },
				{ category = "RandomAmmo"              , percent = 100 },
				{ category = "RandomRangedPolicePure"  , percent = 100 },
                { category = "RandomRangedPolicePure"  , percent = 100 },
				{ category = "RandomAccessory"         , percent = 100 },
                { category = "RandomCargador"          , percent = 100 },
                { category = "RandomMilitaryWeaponWithMagazines"  , percent = 100 },
				{ class = "Pile_12GaugePellet"         , percent = 100 },
				{ class = "Pile_12GaugeSlug"           , percent = 100 },
				{ class = "Pile_762x39"                , percent = 80  , min = 20, max = 100},
                { class = "Pile_556x45"                , percent = 100 , min = 20, max = 100},
                { class = "Pile_762x39"                , percent = 100 , min = 20, max = 100},
                { class = "Pile_556x45"                , percent = 100 , min = 20, max = 100},
				{ category = "RandomPistol"            , percent = 100 },
				{ class = "acp_45x10_hk"               , percent = 100 },
				{ category = "RandomCargador"          , percent = 100 },
                { category = "RandomCargador"                , percent = 100                   },
                { class = "57x60"                      , percent = 100 },
                { category = "RandomAmmoBox"           , percent = 100 },
				{ category = "RandomAmmoBox"           , percent = 100 },
                { category = "RandomSilencer"          , percent = 50   , min = 1, max = 1 },
                { category = "RandomEpicWeaponPure"    , percent = 50  },
                --{ class = "GrenadePickup"              , percent = 50  },
                { class = "SwatHelmet"                 , percent = 50  },
                { class = "SawedShotgun"               , percent = 50  },
                { class = "ForegripVertical"           , percent = 40  },
                { class = "AT15"                       , percent = 60  },
				{ category = "RandomAllHazmatSuit"     , percent = 50  },
                { class = "daftpunkhelmet2"            , percent = 20  },
                { class = "daftpunkhelmet"             , percent = 20  },
                { category = "RandomSpartaGear"        , percent = 50  },
				{ category = "RandomPoliceArmor"       , percent = 50  },
				{ category = "RandomMilitaryHelmet"    , percent = 50  },
				{ class = "Mk18Reaver"                 , percent = 35  },
				{ class = "Mk18Reaver"                 , percent = 10  },
				{ class = "M4A1"                       , percent = 20  },
				{ class = "AmcoinLedger"               , percent = 50   , min = 10, max = 58 },
				{ category = "RandomAmmo"              , percent = 60  },
                { category = "RandomCargador"          , percent = 60  },
                { category = "RandomCargador"          , percent = 60  },
				{ class = "SAS12"                      , percent = 55  },
				{ class = "MAK10"                      , percent = 70  },
				{ class = "ReddotSight"                , percent = 80  },
				{ class = "9x19_mac10"                 , percent = 70  },
                { class = "SCAAMAmalgarmin"			   , percent = 5   }, 
				{ class = "PlasmaRifle"		   		   , percent = 20  },
				{ category = "RandomPlasma"			   , percent = 60  },
				{ class = "SCAR-H"			           , percent = 50  },
                { class = "G36C"                       , percent = 30  },
                { category = "RandomTron"              , percent = 50  },
				
			},
		},
		
		{
			category = "RandomAirDropCrateCivilian",
			group =
			{
                { category = "RandomCargador"                , percent = 100 },
                { category = "RandomCargador"                , percent = 100 },
				{ category = "RandomRangedCivilianPure"      , percent = 100 },
                { category = "RandomCargador"                , percent = 100                   },
				{ category = "RandomHuntingWeapons"          , percent = 100 },
                { category = "RandomHuntingWeapons"          , percent = 100 },
                { class = "Pile_556x45"                      , percent = 100  , min = 20, max = 100 },
                { class = "Pile_556x45"                      , percent = 100  , min = 20, max = 100},
 				{ category = "RandomAccessory"               , percent = 100 },
				{ class = "SheetMetal"                       , percent = 20  , min = 12, max = 48 },
				{ class = "SheetMetal"                       , percent = 20  , min = 12, max = 48 },
				{ class = "Bandage"                          , percent = 100  , min = 5, max = 25 },
				{ class = "Lumber"                           , percent = 100  , min = 12, max = 36 },
                { category = "RandomMetalParts"              , percent = 100 },
				{ category = "RandomLantern"                 , percent = 20 },
                { class = "ScrapMetal"     			         , percent = 100  , min = 10, max = 40 },
                { category = "RandomAmmoBox"                 , percent = 100 },
                { class = "SCAAMAmalgarmin"                  , percent = 100 },
                { category = "RandomCivilianHelmet"          , percent = 100 },
                { category = "RandomMetalParts"              , percent = 100 },
                { class = "SAPOCBriefcaseClosed"             , percent = 5   },
                { class = "SAPOCBriefcaseClosed"             , percent = 5   },
				{ class = "Pile_308"                         , percent = 50  },
                { class = "Mk18Reaver"                       , percent = 2   },
				{ category = "RandomMetalParts"              , percent = 3   },
				{ class = "AmcoinLedger"                     , percent = 50   , min = 50, max = 100 },
				{ category = "RandomLantern"                 , percent = 20  },
				{ class = "CarBattery"                       , percent = 50  },
				{ class = "DriveBelt"                        , percent = 50  },
				{ class = "SparkPlugs"                       , percent = 50  },
				{ class = "Wheel"                            , percent = 50   , min = 1, max = 4 },
				{ category = "RandomTent"                    , percent = 2   },
                { class = "STANAGx50"      			         , percent = 50  },
				{ class = "akval_drummag_75rnd"              , percent = 50  },
                { class = "57x60"                            , percent = 80  },
                { class = "SCAAMAmalgarmin"			         , percent = 5   }, 
				{ category = "RandomAllHazmatSuit"           , percent = 35   },
                { category = "RandomGlassParts"              , percent = 35   },
                { category = "RandomMXCloth"                 , percent = 10  },
                { class = "SpartanHelmet"                    , percent = 10  },
                { category = "RandomTron"                    , percent = 10  },
                { category = "RandomAllGasCanisterPack"      , percent = 50  },
                { class = "Headlamp"                         , percent = 80  },
                { category = "RandomBinoculars"            	 , percent = 53 },
                { class = "SCAAMShovel"                      , percent = 50  },    
                { category = "RandomMedical"	             , percent = 100  , min = 1, max = 10    },            
			},
		},
		
		{
			category = "RandomAirDropCrateExplosives",
			group =
			{
                
                { class = "Gunpowder"                   , percent = 100  , min = 25, max = 125  },
                { class = "Rags"                        , percent = 100  , min = 30,max = 128   },
                { class = "Matches"                     , percent = 100  , min = 1, max = 50    },
				{ class = "Lighter"                     , percent = 100  , min = 1, max = 50    },
                { class = "FireDrill"                   , percent = 100  , min = 1, max = 3     },
                { category = "RandomRocket"             , percent = 100  , min = 3, max = 10    },
                { category = "RandomPlasma"             , percent = 80  , min = 3, max = 10    },
                { category = "RandomAmmo"               , percent = 100  },
                { category = "RandomAmmo"               , percent = 100  },
                { category = "RandomAmmo"               , percent = 100  },
                { category = "RandomAmmo"               , percent = 100  },
                { category = "RandomEpicWeapon"         , percent = 90   },
                { category = "RandomFlashlight"         , percent = 90   },
                { category = "RandomAmmoBox"            , percent = 100  },
                { category = "RandomAmmoBox"            , percent = 100  },
                { category = "RandomMetalParts"         , percent = 100  },
                { category = "RandomMetalParts"         , percent = 100  },
                { category = "RandomMetalParts"         , percent = 100  },
                { category = "RandomMetalParts"         , percent = 100  },
                { category = "RandomSmokeGrenade"       , percent = 100  , min = 1, max = 5     },
                { category = "RandomSilencer"	        , percent = 100  , min = 1, max = 1     },
                { category = "RandomSilencer"	        , percent = 100  , min = 1, max = 1     },
                { category = "RandomSilencer"	        , percent = 100  , min = 1, max = 1     },
                { category = "RandomMedical"	        , percent = 100  , min = 1, max = 10    },
                { category = "RandomMedical"	        , percent = 100  , min = 1, max = 10    },
                { category = "CrossbowWithMagazines"	, percent = 15   },
				{ class = "Amalgaduino"                 , percent = 50   , min = 1, max = 10    },
				{ class = "ElectricalParts"             , percent = 50   , min = 1, max = 25    },
                { class = "Gunpowder"                   , percent = 80   , min = 25, max = 125  },
                { class = "EmptyBottle"                 , percent = 80   , min = 1, max = 5     },
                { class = "Amalgaduino"                 , percent = 60   , min = 1, max = 15    },
                { class = "Pile_40mmGrenade"            , percent = 20   , min = 1, max = 5     },
                { class = "PipebombPickup"              , percent = 80   , min = 1, max = 5     },
                { class = "PipebombPickup"              , percent = 60   , min = 1, max = 5     },
				{ class = "M97"                         , percent = 15  },
				{ class = "PlasmaRifle"                 , percent = 15  },
				{ class = "RocketLauncherNew"           , percent = 15  },
                { class = "SAPOCBriefcaseClosed"        , percent = 5   },
                { class = "SAPOCBriefcaseClosed"        , percent = 5   },
                { class = "GasMask"                     , percent = 45  },
                { category = "RandomAllHazmatMask"      , percent = 45  },
                { category = "map"                      , percent = 45  },
                { category  = "RandomPlasma"            , percent = 35   , min = 2, max = 40 },
				{ category  = "RandomPlasma"            , percent = 15   , min = 2, max = 40 },
				{ category  = "RandomPlasma"            , percent = 50   , min = 2, max = 40 },
				{ category = "RandomRocket"             , percent = 5    , min = 1, max = 40 },
				{ category = "RandomRocket"             , percent = 5    , min = 1, max = 50 },
                { category = "RandomIronSuite"          , percent = 5   },
                { category = "RandomAllHazmatMask"      , percent = 5   },
                { category = "RandomCraftingGuide"      , percent = 5   },
                { class ="guide_ammunition"		        , percent = 25  },
                { class ="guide_buildextra"		        , percent = 5  },

			},
		},
		
		-- Air Plane Crash
		{
			category = "AirPlaneCrashBackpack",
			classes =
			{
				-- no stowpacks - only better backpacks
				{ category = "RandomRuggedPackAirPlane", percent = 39 },
				{ category = "RandomDuffelBagAirPlane", percent = 30 },
				{ category = "RandomRuckSackAirPlane", percent = 30 },
                { class = "guide_buildextra", percent = 1 },
                
			},
		},

        {
			category = "AirPlaneCrashCrateMilitary",
			classes =
			{
				{ class = "WoodCrate", contents="RandomCrateAirPlaneContents", percent = 100 },
			},
		},

		{
			category  = "RandomPlasma",
			classes =
			{
				{ class = "Pile_Plasma", percent = 40 },
				{ class = "Pile_Plasma_green", percent = 25 },
				{ class = "Pile_Plasma_yellow", percent = 20 },
				{ class = "Pile_Plasma_red", percent = 15 },
			},
		}, 

		{
			category = "RandomRocket",
			classes =
			{
				{ class = "Pile_Rocket_AP", percent = 50 }, --250 damage
				{ class = "Pile_Rocket_HE", percent = 15 }, --350 damage
				{ class = "Pile_Rocket"   , percent = 35 }, --300 damage 
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
				{ category = "RandomFlashlight"           , percent = 100 },
				{ category = "RandomConsumable"           , percent = 100 },
				{ category = "RandomMedical"              , percent = 100 },
				{ category = "RandomFood"                 , percent = 100 },
				{ category = "RandomCraftingGuide"        , percent = 100 },
				{ category = "RandomClothes"              , percent = 100 },
				{ category = "RandomMaintenance"          , percent = 100 },
				{ category = "RandomAccessory"            , percent = 60 },
				{ category = "RandomAmmo"                 , percent = 100 },
				{ category = "RandomAmmoBox"              , percent = 9 },
				{ category = "RandomRangedCivilianPure"   , percent = 24 },
				{ category = "RandomRangedMilitaryPure"   , percent = 7 },
                { category = "RandomIronSuite"			  , percent = 5 },
				{ category = "RandomSpartaGear"           , percent = 5 },
                { category = "RandomTron"     			  , percent = 15 },
				{ category = "RandomMXCloth"    		  , percent = 25 },
                { class = "SCAAMAmalgarmin"               , percent = 5}, 
			},
		},

		{
			category = "RandomCrateAirPlaneContents",
			group =
			{
				-- Only 50 slots in the crate - all military focused
				{ category = "RandomRangedMilitaryPure"   , percent = 100 },
				{ category = "RandomRangedMilitaryPure"   , percent = 100 },
				{ category = "RandomAmmoBox"              , percent = 100 },
				{ category = "RandomAmmoBox"              , percent = 100 },
				{ category = "RandomAccessory"            , percent = 100 },
				{ category = "RandomMilitaryClothing"     , percent = 100 },
				{ category = "RandomMilitaryClothing"     , percent = 100 },
				{ category = "RandomMilitaryClothing"     , percent = 100 },
				{ class = "SheetMetal"                    , percent = 10  , min = 12, max = 48 },
				{ category = "RandomMetalParts"           , percent = 6   },
				{ category = "RandomMetalParts"           , percent = 3   },
				--{ class = "GrenadePickup"                 , percent = 100 },
				--{ class = "GrenadePickup"                 , percent = 100 },
				{ category = "RandomAmmo"                 , percent = 60  },
				{ category = "RandomAmmo"                 , percent = 60  },
				{ category = "EventHelmets"               , percent = 5   },
				-- { class = "ArmoredGhillieSuit"            , percent = 10  },
				--{ class = "ArmoredGhillieHood"            , percent = 10  },
				{ class = "AmcoinLedger"                  , percent = 1    , min = 5, max = 25 },
				{ class = "FlashbangPickup"               , percent = 5   },
				{ category = "RandomMilitaryBodyArmor"    , percent = 80  },
				{ category = "RandomMilitaryBodyArmor"    , percent = 80  },
				{ class = "HockeyMask"                    , percent = 35  },
				{ class = "HockeyMaskDp"                  , percent = 30  },
                { class = "AnonMask"                      , percent = 1   },
				--{ class = "C4TimedPickup"                 , percent = 2    , min = 1, max = 3 },
				{ class = "M97"                           , percent = 5   },
				{ class = "Pile_40mmGrenade"              , percent = 10   , min = 1, max = 3 },
				{ class = "Sledgehammer"                  , percent = 4   },
				{ class = "AKVal"                         , percent = 40  },
				{ class = "AK5D"                          , percent = 70  },
				{ class = "SAS12"                         , percent = 85  },
				{ class = "MAK10"                         , percent = 90  },
                { category = "RandomIronSuite"            , percent = 20  },
				{ category = "RandomSpartaGear"           , percent = 15  },
                { class = "SCAAMAmalgarmin"               , percent = 5   }, 
                { category = "RandomTron"                 , percent = 45  },
                { category = "RandomSilencer"             , percent = 100 , min = 1, max = 1 },
                { class = "SCAAMAmalgarmin"               , percent = 10  }, 
				{ class     = "OpticScope"			      , percent = 35  	}, 
				{ category = "RandomRangedMilitaryPure"   , percent = 100 				   },
                { category = "RandomCargador"             , percent = 100 				   },
			},            
		},
		
		{
            category = "RandomUFOContents",
            group =
            {
                -- 30 slots in the crate - EVENT BASED
                { category = "RandomRangedMilitaryPure"         , percent = 100  },
    			{ category = "RandomDuffelBag"         		    , percent = 100  },
				{ category = "RandomMilitaryArmor"              , percent = 100  },
                { category = "RandomAmmoBox"                    , percent = 100  },
				{ class 	= "AmcoinLedger"                    , percent = 100   , min = 20, max = 50  },
                { class 	= "AmcoinLedger"                    , percent = 100   , min = 20, max = 50  },
                { category = "RandomAmmoBox"  				    , percent = 100  },
                { category = "RandomSilencer" 				    , percent = 100  },
                { category = "RandomAmmoBox"  				    , percent = 100  },
                { category = "RandomAmmoBox"  				    , percent = 100  },
                { category = "RandomAmmoBox"  				    , percent = 100  },
                { category = "RandomAmmoBox"  				    , percent = 100  },
                { category = "RandomRangedMilitaryPure"         , percent = 100  },
                { category = "RandomRangedCivilianPure"         , percent = 100  },  
				{ category = "RandomRangedPolicePure"           , percent = 100  },  
				{ category = "RandomAmmoBox"                    , percent = 100  },
                { category = "RandomAmmoBox"                    , percent = 100  },
                { category = "RandomAmmoBox"                    , percent = 100  },
                { category = "RandomMetalParts"                 , percent = 100  },
                { category = "RandomEpicWeaponPure"             , percent = 100  },
                { category = "RandomRangedPolicePure"           , percent = 100  },
                { category = "RandomRangedCivilianPure"         , percent = 100  },
                { category = "RandomSilencer"	                , percent = 20   },
				{ category = "RandomCargador"                   , percent = 100	 },
                { category = "RandomRocket"			   		    , percent = 20    , min = 10, max = 40 },
				{ category = "RandomRocket"		   	   		    , percent = 20	  , min = 3, max = 5 },
				{ category = "RandomEpicWeapon"                 , percent = 20   },
				{ category = "RandomSpartaGear"           	    , percent = 10 	 },
                { category = "RandomAmmoBox"  				    , percent = 9 	 },
                { category = "RandomAmmoBox"  				    , percent = 9 	 },
                { category = "RandomAmmoBox"  				    , percent = 9 	 },
                { class = "SCAAMAmalgarmin"   				    , percent = 25	 }, 
				{ class     = "OpticScope"					    , percent = 25   }, 
                { category = "RandomIronSuite"				    , percent = 15   },
                { category = "RandomTron"     				    , percent = 15 	 },
				{ category  = "RandomPlasma"			   		, percent = 10 	  , min = 3, max = 40 },
				{ category  = "RandomPlasma"			   		, percent = 10 	  , min = 3, max = 40 },
				{ class = "PlasmaRifle"			   		        , percent = 10 	 },
				{ class = "PlasmaRifle"			   		        , percent = 5 	 },
				{ class = "RocketLauncherNew"			        , percent = 15 	 },
                { class = "SAPOCBriefcaseClosed"                , percent = 3    },
                { class = "SAPOCBriefcaseClosed"                , percent = 3    },
                { category = "EventHelmets"                     , percent = 5    },
                { class = "AssaultHelmet"       			    , percent = 5 	 },
                { category = "RandomSkullGear"    			    , percent = 10 	 },
                { class = "SalazarSkull"                        , percent = 30   },
                { class = "wood_coffin"                         , percent = 6.5  },
                { category = "RandomEpicAttachmentTrader"       , percent = 7    },
                { category = "HalloweenBagRare"                 , percent = 5    },
                { category = "RandomSkullGear"                  , percent = 1    },
                { category = "EventHelmets"                     , percent = 5    },
                { category = "EventHelmets"                     , percent = 5    },
                { class = "Pile_40mmGrenade"                    , percent = 20    , min = 1, max = 5  },
                { category = "RandomMonumento"                  , percent = 0.5 },
                
            },
        },
		
		-- Trader Inventory
		{
			-- Will select a random themed inventory from the array.
			category = "RandomVendorInventory",
			classes =
			{
				{ category = "VendorAKM"    , percent = 20 },
				{ category = "VendorAR"     , percent = 20 },
				{ category = "VendorSniper" , percent = 20 },
				{ category = "VendorShotgun", percent = 20 },
				{ category = "VendorSMG"    , percent = 20 },
			},	
		},
		
		{
			-- Will select a random themed inventory from the array.
			category = "RandomVendorClothing",
			classes =
			{
				{ category = "VendorClothingMilitary", percent = 10 },
				{ category = "VendorClothingCivilian", percent = 90 },
			},	
		},
		
		{
			category = "VendorClothingMilitary",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ category = "RandomVendorMilitaryJacket", percent = 100 },
				{ category = "RandomVendorMilitaryJacket", percent = 100 },
				{ category = "RandomVendorMilitaryJacket", percent = 100 },
				{ category = "RandomCamoGloves", percent = 100 },
				{ category = "RandomCamoFace", percent = 100 },
				{ category = "RandomCamoFace", percent = 100 },
				{ category = "RandomVendorCargoPants", percent = 100 },
				{ category = "RandomVendorCargoPants", percent = 100 },
				{ category = "RandomMilitaryShoes", percent = 100 },
				{ category = "RandomMilitaryHelmet", percent = 20 },
				{ category = "RandomMilitaryHelmet", percent = 20 },
				{ category = "RandomMilitaryArmor", percent = 20 },
				{ category = "RandomMilitaryArmor", percent = 20 },
				{ category = "RandomPoliceBodyArmor", percent = 20 },
				{ category = "RandomTacticalVestPure", percent = 20 },
				{ category = "RandomVendorBackpackMilitary", percent = 20 },
				{ class = "SwatHelmet", percent = 20 },
				{ category = "RandomTron", percent = 60 },
				{ category = "RandomAllHazmatSuit", percent = 80 },
				{ category = "RandomIronSuite", percent = 80 },
				{ category = "RandomMXCloth", percent = 100 },
				{ category = "RandomSpartaGear", percent = 100 },
			},
		},
		
		{
			category = "VendorClothingCivilian",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ category = "RandomVendorCargoShorts", percent = 100 },
				{ category = "RandomVendorCargoShorts", percent = 100 },
				{ category = "RandomVendorWandererPants", percent = 100 },
				{ category = "RandomVendorWandererPants", percent = 100 },
				{ category = "RandomVendorRainJacket", percent = 100 },
				{ category = "RandomVendorRainJacket", percent = 100 },
				{ category = "RandomVendorPuffyJacket", percent = 100 },
				{ category = "RandomVendorPuffyJacket", percent = 100 },
				{ category = "RandomVendorShoes", percent = 100 },
				{ category = "RandomVendorShoes", percent = 100 },
				{ category = "RandomVendorLeatherJacket", percent = 100 },
				{ category = "RandomVendorFace", percent = 100 },
				{ category = "RandomVendorFace", percent = 100 },
				{ category = "RandomVendorGloves", percent = 100 },
				{ category = "RandomVendorGloves", percent = 100 },
				{ category = "RandomBeanie", percent = 100 },
				{ category = "RandomBeret", percent = 100 },
				{ category = "RandomBeret", percent = 100 },
				{ category = "RandomBikeHelmet", percent = 70 },
				{ category = "RandomCowboyHat", percent = 100 },
				{ category = "RandomFlexCap", percent = 100 },
				{ category = "RandomFlexCap", percent = 100 },
				{ category = "RandomMotorcycleHelmet", percent = 50 },
				{ category = "RandomFootballHelmet", percent = 50 },
				{ class = "DorfmanPacific", percent = 100 },
				{ class = "WeldersMask", percent = 50 },
				{ category = "RandomVendorWaist", percent = 100 },
				{ category = "RandomVendorWaist", percent = 100 },
				{ category = "RandomVendorSweater", percent = 100 },
				{ category = "RandomVendorSweater", percent = 100 },
				{ category = "RandomVendorHoodie", percent = 100 },
				{ category = "RandomVendorHoodie", percent = 100 },
				{ category = "RandomFootballPads", percent = 70 },
				{ category = "RandomVendorBackpack", percent = 60 },
				{ category = "RandomTron", percent = 60 },
				{ category = "RandomAllHazmatSuit", percent = 60 },
				{ category = "RandomIronSuite", percent = 60 },
				{ category = "RandomMXCloth", percent = 100 },
				
			},
		},

		{
			category = "VendorAKM",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "AKM"                      , percent = 100 },
				{ class = "762x30"                   , percent = 100 },
				{ class = "AK74U"                    , percent = 100 },
				{ class = "545x30"                   , percent = 100 },
				{ class = "Pile_762x39"              , percent = 100 },
				{ class = "Pile_545x39"              , percent = 100 },
				{ class = "AmmoBox_7_62x39"          , percent = 75  },
				{ class = "AmmoBox_5_45x39"          , percent = 75  },
                { category = "RandomAmmoBox"         , percent = 75  },
				{ category = "RandomAccessoryTrader" , percent = 75  },
				{ category = "RandomEquipmentTrader" , percent = 50  },
				{ category = "RandomMilitaryHelmet"  , percent = 10  },
				{ category = "RandomMilitaryArmor"   , percent = 10  },
				{ category = "RandomPoliceBodyArmor" , percent = 10  },
				{ category = "RandomTacticalVestPure", percent = 10  },
				{ category = "RandomRangedPure"		 , percent = 25  },
			},
		},

		{
			category = "VendorSMG",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "R90"                      , percent = 100 },
				{ class = "57x50"                    , percent = 100 },
				{ class = "MP5"                      , percent = 100 },
				{ class = "10mmx30"                  , percent = 100 },
				{ class = "KrissV"                   , percent = 100 },
				{ class = "10mmx15"                  , percent = 100 },
				{ class = "AUMP45"                   , percent = 100 },
				{ class = "acp_45x30"                , percent = 100 },
				{ class = "MAK10"                    , percent = 100 },
				{ class = "9x19_mac10"               , percent = 100 },
				{ class = "Pile_10mm"                , percent = 100 },
				{ class = "Pile_9mm"                 , percent = 100 },
				{ class = "Pile_57x28"               , percent = 100 },
				{ class = "Pile_45ACP"               , percent = 100 },
				{ class = "AmmoBox_10mm"             , percent = 100 },
				{ class = "AmmoBox_acp_45"           , percent = 100 },
				{ class = "AmmoBox_9mm"              , percent = 100 },
				{ class = "AmmoBox_5_70x28"          , percent = 100 },
				{ category = "RandomAccessoryTrader" , percent = 100 },
				{ category = "RandomEquipmentTrader" , percent = 50 },
				{ category = "RandomMilitaryHelmet"  , percent = 10 },
				{ category = "RandomMilitaryArmor"   , percent = 10 },
				{ category = "RandomPoliceBodyArmor" , percent = 10 },
				{ category = "RandomTacticalVestPure", percent = 10 },
				{ category = "RandomCivilianHelmet"  , percent = 30 },
				{ class = "PlasmaRifle"			     , percent = 50 },
                { category = "RandomPlasma"	         , percent = 50 },

			},
		},

		{
			category = "VendorAR",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "AT15"                     , percent = 100 },
				{ class = "AK5D"                     , percent = 10  },
				{ class = "Bulldog"                  , percent = 100 },
				{ class = "M16"                      , percent = 100 },
				{ class = "Mk18"                     , percent = 100 },
                { class = "STANAGx50"                , percent = 50  },
				{ class = "Pile_556x45"              , percent = 100 },
                { class = "ext_762x30"               , percent = 35  },
                { class = "ext_556x75"               , percent = 25  },
                { class = "ext_762x75"               , percent = 15  },
                { class = "akval_drummag_75rnd"      , percent = 15  },
				{ class = "AmmoBox_5_56x45"          , percent = 75  },
				{ class = "IronsightKit"             , percent = 100 },
				{ category = "RandomAccessoryTrader" , percent = 75  },
				{ category = "RandomEquipmentTrader" , percent = 50  },
				{ category = "RandomMilitaryHelmet"  , percent = 10  },
				{ category = "RandomMilitaryArmor"   , percent = 10  },
				{ category = "RandomPoliceBodyArmor" , percent = 50  },
				{ category = "RandomTacticalVestPure", percent = 10  },
				{ category = "RandomCivilianHelmet"  , percent = 30  },
			},
		},

		{
			category = "VendorSniper",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "M40A5"                      , percent = 100 },
				{ class = "M40x5"                      , percent = 100 },
				{ class = "ACAW"                       , percent = 100 },
				{ class = "762x5"                      , percent = 100 },
				{ class = "Pile_762x51"                , percent = 100 },
				{ class = "Rem700"                     , percent = 100 },
				{ class = "Pile_308"                   , percent = 100 },
				{ class = "Sako_85"                    , percent = 100 },
				{ class = "Model70"                    , percent = 100 },
				{ class = "Pile_223"                   , percent = 100 },
				{ class = "AmmoBox_223"                , percent = 75 },
				{ class = "AmmoBox_308"                , percent = 75 },
				{ class = "AmmoBox_7_62x51"            , percent = 75 },
				{ class = "GhillieHood1"               , percent = 70 },
				{ class = "GhillieSuit1"               , percent = 70 },
				{ class = "GhillieHood2"               , percent = 70 },
				{ class = "GhillieSuit2"               , percent = 70 },
				{ class = "GhillieHood3"               , percent = 70 },
				{ class = "GhillieSuit3"               , percent = 70 },
				{ class = "GhillieHood4"               , percent = 70 },
				{ class = "GhillieSuit4"               , percent = 70 },
				{ class = "HuntingScope"               , percent = 100 },
                { class = "HuntingScopeRealCamo"       , percent = 25  },
                { class = "HuntingScopeRealCamoDesert" , percent = 25  },
				{ category = "RandomAccessoryTrader"   , percent = 75 },
				{ category = "RandomEquipmentTrader"   , percent = 50 },
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
				{ category = "RandomEpicWeaponTrader"    , percent = 25 },
				{ category = "RandomEpicAttachmentTrader", percent = 25 },
				{ category = "RandomEquipmentTrader"     , percent = 100 },
				{ category = "RandomMilitaryHelmet"      , percent = 50 },
				{ category = "RandomMilitaryArmor"       , percent = 50 },
				{ category = "RandomPoliceBodyArmor"     , percent = 75 },
				{ category = "RandomTacticalVestPure"    , percent = 100 },
				{ class = "AKVal"                        , percent = 100 },
				{ class = "762x20_Akval"                 , percent = 100 },
				{ class = "AK5D"                         , percent = 100 },
				{ class = "556x30_ak5d"                  , percent = 100 },
				{ class = "SAS12"                        , percent = 100 },
				{ class = "Pile_12GaugePellet"           , percent = 100 },
				{ class = "Pile_12GaugeSlug"             , percent = 100 },
				{ class = "Pile_12GaugeBeanbag"          , percent = 100 },
				{ class = "Pile_556x45"                  , percent = 100 },
				{ class = "Pile_762x39"                  , percent = 100 },
				{ class = "Pile_545x39"                  , percent = 100 },
				{ class = "556x100"                      , percent = 100 },
                { class = "STANAGx50"        			 , percent = 50 },
                { class = "akval_drummag_75rnd"    	     , percent = 50 },
				{ category = "RandomAccessoryTrader"     , percent = 100 },
				{ category = "RandomAmmo"   			 , percent = 100 },
				{ class = "M249"                         , percent = 5 },
				{ class = "M97"                          , percent = 5 },
				{ category  = "RandomPlasma"             , percent = 5 },
				{ category = "RandomRocket"              , percent = 5 },
				{ category = "RandomSpartaGear"          , percent = 5 },
				{ class = "PlasmaRifle"  	             , percent = 5 },
				{ class = "RocketLauncherNew"  	         , percent = 5 },
			},
		},

		{
			category = "PaintVendorInventory",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "PaintCan_Aqua", percent = 50 },
				{ class = "PaintCan_Black", percent = 50 },
				{ class = "PaintCan_Blue", percent = 50 },
				{ class = "PaintCan_Brown", percent = 80 },
				{ class = "PaintCan_Gold", percent = 50 },
				{ class = "PaintCan_Green", percent = 80 },
				{ class = "PaintCan_Orange", percent = 90 },
				{ class = "PaintCan_Pink", percent = 90 },
				{ class = "PaintCan_Purple", percent = 90 },
				{ class = "PaintCan_Red", percent = 60 },
				{ class = "PaintCan_Silver", percent = 70 },
				{ class = "PaintCan_White", percent = 85 },
				{ class = "PaintCan_Yellow", percent = 75 },
				{ category = "RandomPainting", percent = 25 },
				{ category = "RandomPainting", percent = 25 },
				{ category = "RandomPainting", percent = 25 },
				{ category = "RandomPainting", percent = 25 },
				{ class = "camping_lantern", percent = 20 },
			},
		},

		{
			category = "CraftingVendorInventory",
			group =
			{
				-- If you use a category it must only spawn 1 item from it
				-- For example, it can't spawn a weapon and ammo
				{ class = "RK_AA12", percent = 100 },
				{ class = "RK_ACAW", percent = 100 },
				{ class = "RK_AK74U", percent = 100 },
				{ class = "RK_AKM", percent = 100 },
				{ class = "RK_AP85", percent = 100 },
				{ class = "RK_AT15", percent = 100 },
				{ class = "RK_AUMP45", percent = 100 },
				{ class = "RK_Bulldog", percent = 100 },
				{ class = "RK_ColtPython", percent = 100 },
				{ class = "RK_Crossbow", percent = 100 },
				{ class = "RK_CX4Storm", percent = 100 },
				{ class = "RK_FlareGun", percent = 100 },
				{ class = "RK_G18Pistol", percent = 100 },
				{ class = "RK_hk45", percent = 100 },
				{ class = "RK_KrissV", percent = 100 },
				{ class = "RK_M16", percent = 100 },
				{ class = "RK_m1911a1", percent = 100 },
				{ class = "RK_M249", percent = 100 },
				{ class = "RK_M40A5", percent = 100 },
				{ class = "RK_M9A1", percent = 100 },
				{ class = "RK_Makarov", percent = 100 },
				{ class = "RK_MeleePrimary", percent = 100 },
				{ class = "RK_MeleeSecondary", percent = 100 },
				{ class = "RK_Mk18", percent = 100 },
				{ class = "RK_Model70", percent = 100 },
				{ class = "RK_MP5", percent = 100 },
				{ class = "RK_P350", percent = 100 },
				{ class = "RK_PX4", percent = 100 },
				{ class = "RK_R90", percent = 100 },
				{ class = "RK_RecurveBow", percent = 100 },
				{ class = "RK_Rem700", percent = 100 },
				{ class = "RK_Rem870", percent = 100 },
				{ class = "RK_ruger22", percent = 100 },
				{ class = "RK_Sako_85", percent = 100 },
				{ class = "RK_Shotgun870Tactical", percent = 100 },
				{ class = "RK_TranquilizerGun", percent = 100 },
				{ class = "RK_Wasteland22", percent = 100 },
				{ class = "RK_ClothingHelmetBallistic", percent = 100 },
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
				{ class = "MRE", percent = 100 },
				{ class = "Bread", percent = 100 },
			},
		},
		
		{
			category = "RandomVendorCargoShorts",
			classes =
			{
				{ class = "CargoShortsBlack", percent = 6 },
				{ class = "CargoShortsBlue", percent = 6 },
				{ class = "CargoShortsBrightBlue", percent = 6 },
				{ class = "CargoShortsBrightGreen", percent = 6 },
				{ class = "CargoShortsBrightPink", percent = 6 },
				{ class = "CargoShortsBrightRed", percent = 6 },
				{ class = "CargoShortsBrown", percent = 6 },
				{ class = "CargoShortsCamo1", percent = 7 },
				{ class = "CargoShortsCamo2", percent = 7 },
				{ class = "CargoShortsCamo3", percent = 6 },
				{ class = "CargoShortsCamo4", percent = 7 },
				{ class = "CargoShortsDarkGrey", percent = 6 },
				{ class = "CargoShortsGreen", percent = 6 },
				{ class = "CargoShortsGrey", percent = 7 },
				{ class = "CargoShortsTan", percent = 6 },
				{ class = "CargoShortsYellow", percent = 6 },
			},
		},
		
		{
			category = "RandomVendorHoodie",
			classes = 
			{
				{class = "Hoodie", percent = 4},
				{class = "HoodieBlackGreyDesign1", percent = 4},
				{class = "HoodieBlackWhiteDesign4", percent = 4},
				{class = "HoodieBlueBlackDesign4", percent = 4},
				{class = "HoodieBlueDesign2", percent = 3},
				{class = "HoodieBlueWhiteDesign4", percent = 4},
				{class = "HoodieCapitalMunch", percent = 3},
				{class = "HoodieEagle", percent = 3},
				{class = "HoodieGreenBlackDesign4", percent = 4},
				{class = "HoodieGreenDesign2", percent = 3},
				{class = "HoodieGreenWhiteDesign4", percent = 4},
				{class = "HoodieGrey", percent = 3},
				{class = "HoodieGreyDarkGreyDesign1", percent = 3},
				{class = "HoodieOrangeBlackDesign4", percent = 3},
				{class = "HoodiePinkDesign2", percent = 4},
				{class = "HoodiePixel", percent = 3},
				{class = "HoodiePixelBlackGreyDesign5", percent = 4},
				{class = "HoodiePixelBlueBlackDesign5", percent = 3},
				{class = "HoodiePixelGreenBlackDesign5", percent = 3},
				{class = "HoodiePixelGreyBlueDesign5", percent = 3},
				{class = "HoodiePixelGreyDesign5", percent = 4},
				{class = "HoodiePixelGreyGreenDesign5", percent = 3},
				{class = "HoodiePixelGreyOrangeDesign5", percent = 3},
				{class = "HoodiePixelGreyRedDesign5", percent = 3},
				{class = "HoodiePixelOrangeBlackDesign5", percent = 3},
				{class = "HoodiePixelRedBlackDesign5", percent = 3},
				{class = "HoodieRedBlackDesign4", percent = 3},
				{class = "HoodieRedDesign2", percent = 3},
				{class = "HoodieRedWhiteDesign4", percent = 3},
				{class = "HoodieSerk", percent = 3},
			},
		},
		
		{
			category = "RandomVendorFace",
			classes =
			{
				{ class = "GasMask", percent = 4.5 },
				{ class = "DustMask", percent = 4.5 },
				{ class = "HeadSack", percent = 4.5 },
				{ class = "HockeyMask", percent = 4.5 },
				{ class = "HockeyMaskDp", percent = 4.5 },
				{ class = "BalaclavaBlack", percent = 4.5 },
				{ class = "BalaclavaGray", percent = 4.5 },
				{ class = "BalaclavaGreen", percent = 4.5 },
				{ class = "BalaclavaPink", percent = 4.5 },
				{ class = "BalaclavaYellow", percent = 4.5 },
				{ class = "BandanaBlack", percent = 4.5 },
				{ class = "BandanaBrown", percent = 4.5 },
				{ class = "BandanaCamo1", percent = 4.5 },
				{ class = "BandanaCamo2", percent = 4.5 },
				{ class = "BandanaCamo3", percent = 4.5 },
				{ class = "BandanaCamo4", percent = 4.5 },
				{ class = "BandanaGray", percent = 4.5 },
				{ class = "BandanaGreen", percent = 4.5 },
				{ class = "BandanaKhaki", percent = 4.5 },
				{ class = "BandanaOrange", percent = 4.5 },
				{ class = "BandanaPink", percent = 4.5 },
				{ class = "BandanaRed", percent = 5.5 },
			},
		},
		
		{
			category = "RandomVendorSweater",
			classes = 
			{
				{ class = "Sweater", percent = 10 },
				{ class = "SweaterBlack", percent = 15 },
				{ class = "SweaterBlue", percent = 15 },
				{ class = "SweaterGreen", percent = 15 },
				{ class = "SweaterOrange", percent = 15 },
				{ class = "SweaterPink", percent = 15 },
				{ class = "SweaterRed", percent = 15 },
			}
		},
		
		{
			category = "RandomVendorGloves",
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
		
		{
			category = "RandomVendorBackpack",
			classes =
			{
				{ class = "RuggedPack", percent = 5.5 },
				{ class = "RuggedPackBlack", percent = 4.5 },
				{ class = "RuggedPackBrown", percent = 4.5 },
				{ class = "RuggedPackCamo1", percent = 4.5 },
				{ class = "RuggedPackCamo2", percent = 4.5 },
				{ class = "RuggedPackCamo3", percent = 4.5 },
				{ class = "RuggedPackCamo4", percent = 4.5 },
				{ class = "RuggedPackGreen", percent = 4.5 },
				{ class = "RuggedPackGreenCamo1", percent = 4.5 },
				{ class = "RuggedPackGreenCamo2", percent = 4.5 },
				{ class = "RuggedPackGreenCamo3", percent = 4.5 },
				{ class = "RuggedPackGreenCamo4", percent = 4.5 },
				{ class = "StowPackBlack", percent = 4.5 },
				{ class = "StowPackBlue", percent = 4.5 },
				{ class = "StowPackGreen", percent = 4.5 },
				{ class = "StowPackOrange", percent = 4.5 },
				{ class = "StowPackPink", percent = 4.5 },
				{ class = "StowPackPurple", percent = 4.5 },
				{ class = "StowPackRed", percent = 4.5 },
				{ class = "StowPackWhite", percent = 4.5 },
				{ class = "StowPackYellow", percent = 4.5 },
				{ class = "RuckSack", percent = 4.5 },
			},
		},
		
		{
			category = "RandomVendorBackpackMilitary",
			classes =
			{
				{ class = "DuffelBag"		   , percent = 4 },
				{ class = "DuffelBagBlack"     , percent = 5 },
				{ class = "DuffelBagGreen"     , percent = 4 },
				{ class = "DuffelBagGreenCamo1", percent = 5 },
				{ class = "DuffelBagGreenCamo2", percent = 4 },
				{ class = "DuffelBagGreenCamo3", percent = 4 },
				{ class = "DuffelBagGreenCamo4", percent = 4 },
				{ class = "DuffelBagTanCamo1"  , percent = 5 },
				{ class = "DuffelBagTanCamo2"  , percent = 4 },
				{ class = "DuffelBagTanCamo3"  , percent = 4 },
				{ class = "DuffelBagTanCamo4"  , percent = 5 },
				{ class = "DuffelBagUrbanCamo1", percent = 4 },
				{ class = "DuffelBagUrbanCamo2", percent = 5 },
				{ class = "DuffelBagUrbanCamo3", percent = 4 },
				{ class = "DuffelBagUrbanCamo4", percent = 5 },
				{ class = "DuffelBagLightBlue" , percent = 4 },
				{ class = "DuffelBagOGreen"    , percent = 4 },
				{ class = "DuffelBagYellow"    , percent = 4 },
				{ class = "DuffelBagBlue"      , percent = 5 },
				{ class = "DuffelBagPurple"    , percent = 4 },
				{ class = "DuffelBagPink"      , percent = 4 },
				{ class = "DuffelBagRed"       , percent = 5 },
				{ class = "DuffelBagWhite"     , percent = 4 },
			},
		},
		
		{
			category = "RandomVendorWaist",
			classes =
			{
				{ class = "FannyPackBlack", percent = 9 },
				{ class = "FannyPackBlueOrange", percent = 9 },
				{ class = "FannyPackCamo1", percent = 8 },
				{ class = "FannyPackCamo2", percent = 8 },
				{ class = "FannyPackCamo3", percent = 8 },
				{ class = "FannyPackGray", percent = 9 },
				{ class = "FannyPackGreenGray", percent = 9 },
				{ class = "FannyPackMaroonGray", percent = 8 },
				{ class = "FannyPackPurplePink", percent = 8 },
				{ class = "FannyPackRed", percent = 8 },
				{ class = "FannyPackRedBlue", percent = 8 },
				{ class = "FannyPackYellow", percent = 8 },
			},
		},
		
		{
			category = "RandomVendorLeatherJacket",
			classes =
			{
				{ class = "LeatherJacketBrown", percent = 25},
				{ class = "LeatherJacketBlack", percent = 25},
				{ class = "LeatherJacketYellow", percent = 25},
				{ class = "LeatherJacketRed", percent = 25},
			},
		},
		
		{
			category = "RandomVendorPuffyJacket",
			classes =
			{
				--{ class = "PuffyJacketEaster", percent = 0.5 },
				{ class = "PuffyJacketGold", percent = 1.0 },
				{ class = "PuffyJacketSilver", percent = 1 },
				{ class = "PuffyJacketAmerica", percent = 1 },
				{ class = "PuffyJacketCanada", percent = 1 },
				{ class = "PuffyJacketCamo1", percent = 4 },
				{ class = "PuffyJacketCamo2", percent = 4 },
				{ class = "PuffyJacketCamo3", percent = 4 },
				{ class = "PuffyJacketWhiteCamo1", percent = 4 },
				{ class = "PuffyJacketBlack", percent = 4.5 },
				{ class = "PuffyJacketBlueWhite", percent = 5 },
				{ class = "PuffyJacketGreenWhite", percent = 5 },
				{ class = "PuffyJacketGrey", percent = 5 },
				{ class = "PuffyJacketGreyBlack", percent = 5 },
				{ class = "PuffyJacketGreyBlack2", percent = 5 },
				{ class = "PuffyJacketKaki", percent = 5 },
				{ class = "PuffyJacketOrangeGreen", percent = 5 },
				{ class = "PuffyJacketOrangeTeal", percent = 5 },
				{ class = "PuffyJacketOrangeWhite", percent = 5 },
				{ class = "PuffyJacketPinkWhite", percent = 6 },
				{ class = "PuffyJacketPurpleFushia", percent = 6 },
				{ class = "PuffyJacketRedBlue", percent = 6 },
				{ class = "PuffyJacketRedWhite", percent = 6 },
				{ class = "PuffyJacketWhite", percent = 6 },
			},
		},
		
		{
			category = "RandomVendorWandererPants",
			classes =
			{
				{ class = "WandererPantsBlack", percent = 17 },
				{ class = "WandererPantsBlue", percent = 17 },
				{ class = "WandererPantsBrown", percent = 17 },
				{ class = "WandererPantsGreen", percent = 17 },
				{ class = "WandererPantsRed", percent = 16 },
				{ class = "WandererPantsTan", percent = 16 },
			},
		},
		
		{
			category = "RandomVendorShoes",
			classes =
			{
				{ class = "HitopsBlack", percent = 5 },
				{ class = "HitopsBlue", percent = 5 },
				{ class = "HitopsGreen", percent = 5 },
				{ class = "HitopsPink", percent = 5 },
				{ class = "HitopsPurple", percent = 5 },
				{ class = "HitopsRed", percent = 5 },
				{ class = "HitopsYellow", percent = 5 },
				{ class = "Sneakers", percent = 5 },
				{ class = "SneakersBlack", percent = 4 },
				{ class = "SneakersBlackBlue", percent = 4 },
				{ class = "SneakersBlackGreen", percent = 4 },
				{ class = "SneakersBlackPink", percent = 4 },
				{ class = "SneakersBlackRed", percent = 4 },
				{ class = "SneakersBlueBlack", percent = 4 },
				{ class = "SneakersBrown", percent = 4 },
				{ class = "SneakersGreenBlack", percent = 4 },
				{ class = "SneakersPinkBlack", percent = 4 },
				{ class = "SneakersRedBlack", percent = 4 },
				{ class = "SneakersSilver", percent = 4 },
				{ class = "SneakersWhite", percent = 4 },
				{ class = "SneakersWhiteBlue", percent = 4 },
				{ class = "SneakersWhiteGreen", percent = 4 },
				{ class = "SneakersWhitePink", percent = 4 },
			},
		},
		
		{
			category = "RandomVendorCargoPants",
			classes =
			{
				{ class = "CargoPantsBlack", percent = 7 },
				{ class = "CargoPantsCamo1", percent = 7 },
				{ class = "CargoPantsCamo2", percent = 7 },
				{ class = "CargoPantsCamo3", percent = 7 },
				{ class = "CargoPantsCamo4", percent = 6 },
				{ class = "CargoPantsGreen", percent = 7 },
				{ class = "CargoPantsGreenCamo1", percent = 7 },
				{ class = "CargoPantsGreenCamo2", percent = 7 },
				{ class = "CargoPantsGreenCamo3", percent = 7 },
				{ class = "CargoPantsGreenCamo4", percent = 6 },
				{ class = "CargoPantsTan", percent = 7 },
				{ class = "CargoPantsUrbanCamo1", percent = 6 },
				{ class = "CargoPantsUrbanCamo2", percent = 6 },
				{ class = "CargoPantsUrbanCamo3", percent = 7 },
				{ class = "CargoPantsUrbanCamo4",percent = 6 },
			},
		},
		
		{
			category = "RandomVendorRainJacket",
			classes =
			{
				{ class = "RainJacketBlack", percent = 5},
				{ class = "RainJacketBlue", percent = 5},
				{ class = "RainJacketBlueGrey", percent = 5},
				{ class = "RainJacketCamo1", percent = 5},
				{ class = "RainJacketCamo2", percent = 5},
				{ class = "RainJacketCamo3", percent = 5},
				{ class = "RainJacketDarkGrey", percent = 5},
				{ class = "RainJacketGreen", percent = 5},
				{ class = "RainJacketGreenGrey", percent = 5},
				{ class = "RainJacketGrey", percent = 5},
				{ class = "RainJacketGreyBlack", percent = 5},
				{ class = "RainJacketKaki", percent = 5},
				{ class = "RainJacketLightDarkGrey", percent = 5},
				{ class = "RainJacketMarine", percent = 5},
				{ class = "RainJacketOrangeBlue", percent = 5},
				{ class = "RainJacketPinkPurple", percent = 5},
				{ class = "RainJacketRed", percent = 5},
				{ class = "RainJacketRedBlue", percent = 5},
				{ class = "RainJacketRedGrey", percent = 5},
				{ class = "RainJacketYellow", percent = 5},
				
			},
		},
		
		{
			category = "RandomVendorMilitaryJacket",
			classes = 
			{
				{ class = "MilitaryJacketBlack", percent = 6 },
				{ class = "MilitaryJacketGreen", percent = 7 },
				{ class = "MilitaryJacketGreenCamo1", percent = 6 },
				{ class = "MilitaryJacketGreenCamo2", percent = 6 },
				{ class = "MilitaryJacketGreenCamo3", percent = 6 },
				{ class = "MilitaryJacketGreenCamo4", percent = 6 },
				{ class = "MilitaryJacketTan", percent = 7 },
				{ class = "MilitaryJacketTanCamo1", percent = 7 },
				{ class = "MilitaryJacketTanCamo2", percent = 7 },
				{ class = "MilitaryJacketTanCamo3", percent = 7 },
				{ class = "MilitaryJacketTanCamo4", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo1", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo2", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo3", percent = 7 },
				{ class = "MilitaryJacketUrbanCamo4", percent = 7 },
			},
		},
		
		{
			category = "RandomMXCloth",
			classes =
			{
				{ class = "MxShirtsBlue", percent = 2 },
                { class = "MxPantsBlue", percent = 2 },
                { class = "MxBootsBlue", percent = 2 },
                { class = "MxGlovesBlue", percent = 2 },
                { class = "MxShirtsRed", percent = 2 },
                { class = "MxPantsRed", percent = 2 },
                { class = "MxBootsRed", percent = 2 },
                { class = "MxGlovesRed", percent = 2 },
                { class = "MxShirtsGreen", percent = 2 },
                { class = "MxPantsGreen", percent = 2 },
                { class = "MxBootsGreen", percent = 3 },
                { class = "MxGlovesGreen", percent = 2 },
                { class = "MxShirtsOrange", percent = 2 },
                { class = "MxPantsOrange", percent = 5 },
                { class = "MxBootsOrange", percent = 5 },
                { class = "MxGlovesOrange", percent = 2 },
                { class = "MxShirtsYellow", percent = 5 },
                { class = "MxPantsYellow", percent = 2 },
                { class = "MxBootsYellow", percent = 2 },
                { class = "MxGlovesYellow", percent = 2 },
                { class = "MxShirtsPink", percent = 2 },
                { class = "MxPantsPink", percent = 2 },
                { class = "MxBootsPink", percent = 2 },
                { class = "MxGlovesPink", percent = 2 },
                { class = "MxShirtsWhite", percent = 2 },
                { class = "MxPantsWhite", percent = 2 },
                { class = "MxBootsWhite", percent = 2 },
                { class = "MxGlovesWhite", percent = 2 },
                { class = "MotorcycleHelmetBeach", percent = 2 },
                { class = "MotorcycleHelmetSynthwave", percent = 2 },
                { class = "MotorcycleHelmetSpitfire", percent = 2 },
                { class = "MotorcycleHelmetSkull", percent = 2 },
                { class = "MotorcycleHelmetChinese", percent = 2 },

			},
		},

        {
			category = "RandomTron",
			classes =
			{
				{ class = "TronSuitBlue", percent = 9.3 },
				{ class = "TronSuitGreen", percent = 9.3 },
				{ class = "TronSuitOrange", percent = 9.3 },
				{ class = "TronSuitPurple", percent = 9.3 },
				{ class = "TronSuitRed", percent = 9.3 },
				{ class = "TronSuitYellow", percent = 9.3 },
				{ class = "TronHelmetBlue", percent = 9.3 },
				{ class = "TronHelmetGreen", percent = 9.3 },
                { class = "TronHelmetPurple", percent = 8.6 },
                { class = "TronHelmetRed", percent = 8.3 },
                { class = "TronHelmetYellow", percent = 8.3 },
			},
		},

        {
			category = "RandomIronSuite",
			classes =
			{
                { class = "IronsuitWarMachineBoots" , percent  = 15 },
				{ class = "IronsuitWarMachineChest" , percent  = 20 },
				{ class = "IronsuitWarMachineGloves", percent  = 10 },
				{ class = "IronsuitWarMachineHelmet", percent  = 10 },
				{ class = "IronsuitWarMachinePants" , percent  = 10 },
				{ class = "IronsuitPinkHelmet"		, percent  = 6 },
				{ class = "IronsuitPinkChest"       , percent  = 6 },
				{ class = "IronsuitPinkPants"		, percent  = 8 },
				{ class = "IronsuitPinkGloves"		, percent  = 7 },
				{ class = "IronsuitPinkBoots"		, percent  = 8 },
				
			},
		},

		{
			category = "RandomSpartaGear",
			classes =
			{
                { class = "SpartanArmor"	, percent  = 70 },
				{ class = "SpartanBackpack"	, percent  = 25 },
				{ class = "SpartanHelmet"	, percent  = 5  },
			},
		},
        {
			category = "RandomSkullGear",
			classes =
			{
                { class = "SkeletonChest"	, percent  = 30 },
				{ class = "SkeletonFeet"	, percent  = 15 },
				{ class = "SkeletonHands"	, percent  = 15  },
                { class = "SkeletonLegs"	, percent  = 30  },
                { class = "SkullHead"	    , percent  = 10  },
			},  
		},

		{
			category = "RandomEpicWeaponTrader",
			classes =
			{
				{ class = "Mk18Reaver"                      , percent = 10.5  },
				{ class = "M4A1"                            , percent = 10.5  },
				{ class = "M16Vietnam"                      , percent = 12.5  },
				{ class = "VSS"                             , percent = 13    },
				{ class = "RPK"                             , percent = 10    },
				{ class = "M4V5"                            , percent = 10.5  },
				{ class = "AKMGold"                         , percent = 10.5  },
				{ class = "ColtPythonGrimeyRick"            , percent = 8.5   },
                { class = "ColtPythonGrimeyRick"			, percent = 6     },
				{ class = "PlasmaRifle"			            , percent = 2.5   },
                { class = "SCAR-H"	    		            , percent = 2.5   },
                { class = "G36C"                            , percent = 2 	    },
                { class = "AKVal"	    		            , percent = 2.5   },
			},
		},

		{
			category = "RandomTraderCraftingGuides",
			classes =
			{
				{ class = "guide_medical_bandages"           , percent = 4 },
                { class = "guide_ammunition"     			 , percent = 4 },
				{ class = "guide_weapons_melee"              , percent = 4 },
				{ class = "guide_structures_tire_stacks"     , percent = 4 },
				{ class = "guide_structures_wood_bridges_1"  , percent = 4 },
				{ class = "guide_structures_wood_ramps_1"    , percent = 4 },
				{ class = "guide_structures_wood_stairs_1"   , percent = 4 },
				{ class = "guide_structures_wood_traps_2"    , percent = 4 },
				{ class = "guide_structures_wood_walkways_1" , percent = 4 },
				{ class = "guide_structures_wood_walls_1"    , percent = 4 },
				{ class = "guide_structures_wood_roofs"      , percent = 4 },
				{ class = "guide_powered_parts_1"            , percent = 4 },
				{ class = "guide_traps_1"                    , percent = 4 },
				{ class = "guide_structures_wood_bridges_2"  , percent = 4 },
				{ class = "guide_structures_wood_ramps_2"    , percent = 4 },
				{ class = "guide_structures_wood_stairs_2"   , percent = 2 },
				{ class = "guide_structures_wood_traps_1"    , percent = 4 },
				{ class = "guide_structures_wood_walkways_2" , percent = 3 },
				{ class = "guide_structures_wood_walls_2"    , percent = 3 },
				{ class = "guide_traps_2"                    , percent = 3 },
				{ class = "guide_structures_wood_curves"     , percent = 3 },
				{ class = "guide_structures_wood_gallows"    , percent = 3 },
				{ class = "guide_structures_wood_watchtower" , percent = 3 },
				{ class = "guide_structures_wood_gatehouse"  , percent = 3 },
				{ class = "guide_weapons_ranged_1"           , percent = 3 },
				{ class = "guide_weapons_ranged_2"           , percent = 3 },
				{ class = "guide_weapons_ranged_3"           , percent = 3 },
			},
		},

		{
			category = "RandomEpicAttachmentTrader",
			classes =
			{
				{ class = "OPKSight"            , percent = 17 },
				{ class = "R3Sight"             , percent = 10 },
				{ class = "PSOScope"            , percent = 17 },
				{ class = "ext_762x30"          , percent = 13 },
				{ class = "ext_762x75"          , percent = 13 },
				{ class = "ext_556x75"          , percent = 12 },
				{ class = "STANAGx50"           , percent = 12 },
                { class = "akval_drummag_75rnd" , percent = 6  },
                
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
				{ class = "GingerBreadMan", percent = 10 },
                
			},
		},

		{
			category = "RandomAccessoryTrader",
			classes =
			{
				{ class = "LaserSight"          , percent = 9 },
				{ class = "LaserSightGreen"     , percent = 8 },
				{ class = "LaserSightBlue"      , percent = 9 },
				{ class = "ReflexSight"         , percent = 8 },
				{ class = "T1Micro"             , percent = 9 },
				{ class = "ForegripVertical"    , percent = 8 },
				{ class = "OpticScope"          , percent = 12 },
				{ class = "ReddotSight"         , percent = 8 },
				{ class = "FlashlightMounted"   , percent = 9 },
                { category = "RandomSilencer"   , percent = 8 },
                
			},
		},

        {
			category = "RandomSilencer",
			classes =
			{
				{ class = "RifleSilencer"               , percent = 10 },
				{ class = "PistolSilencer"              , percent = 35 },
				{ class = "RifleSilencerRealCamo"       , percent = 10 },
				{ class = "RifleSilencerRealCamoDesert" , percent = 10 },
                { class = "CraftedSilencer"             , percent = 20 },
                { class = "CraftedPistolSilencer"       , percent = 15 },

			},
		},

        {
			category = "RandomMonumento",
			classes =
			{
				{ class = "2B_HMS"              , percent = 20 },
				{ class = "Batman_HMS"          , percent = 20 },
				{ class = "IronMan_HMS"         , percent = 20 },
				{ class = "Star_HMS"            , percent = 20 },
                { class = "statue"              , percent = 20 },
			},
		},

        {
			category = "RandomTowableParts",
			classes =
			{
				

				{ class = "office_desk_tow_packed"                , percent = 7   },
				{ class = "umbrella_open_tow_packed"              , percent = 6   }, 
				{ class = "mapsign_tow_packed"                    , percent = 6   },
				{ class = "green_tent_tow_packed"                 , percent = 6   },
				{ class = "electric_stove_storage_packed"         , percent = 6   },
				{ class = "gnome_giant_c"                         , percent = 6.8   },
				{ class = "arcade_cabinet"                        , percent = 6   },
                { class = "fridge_modern_tow_packed"			  , percent = 6   }, 
				{ class = "oil_rack_storage_packed"				  , percent = 6   },
				{ class = "toilet_tow_packed"   				  , percent = 6   },
				{ class = "icemachine_tow_packed"				  , percent = 7   },
				{ class = "vendingmachine_2_tow_packed"	  	      , percent = 6   },
				{ class = "vendingmachine_1_tow_packed"			  , percent = 6   },
				{ class = "mailbox_storage_packed"   			  , percent = 7   },
				{ class = "whiteboard_tow_packed"   			  , percent = 4.5   },
				{ class = "payphone_tow_packed"   			      , percent = 4.5   },
				{ class = "metal_door_lockable_1m_2m"             , percent = 0.6   },
				{ class = "metal_aframe_3m_4m"                    , percent = 0.2   },
				{ class = "metal_wall_1_3m_2m"                    , percent = 0.2   },
				{ class = "metal_wall_1_3m_4m"                    , percent = 0.2   }, 
				{ class = "metal_wall_2m_2m"                      , percent = 0.2   },
				{ class = "metal_wall_2m_4m"                      , percent = 0.2   },
				{ class = "metal_wall_3m_2m"                      , percent = 0.2   },
				{ class = "metal_wall_3m_4m"                      , percent = 0.2   },
				{ class = "metal_platform_3m_4m_4m"               , percent = 0.2   },
				{ class = "metal_wall_door_3m_4m"                 , percent = 0.2   }, 
				{ class = "metal_wall_window_3m_2m"               , percent = 0.2   },
				{ class = "metal_wall_window_3m_4m"               , percent = 0.2   },
				{ class = "metal_gatehouse_4m_8m"                 , percent = 0.2   },
				{ class = "metal_gate_lockable_3m_5_4m"           , percent = 0.2   },
				
				--{ class = "christmas_tree", percent = 15 }, 
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
            category = "WoodsAndStick",
            classes =
            {
                { class = "WoodPile", percent = 95 },
                { class = "StickPile", percent = 5 },
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




