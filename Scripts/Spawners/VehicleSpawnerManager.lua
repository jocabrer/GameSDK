VehicleSpawnerManager = {

--[[
	Property descriptions:
	initialMinVehicles - the minimum number of vehicles from this category that will exist on system startup
	abandonedTimer -- how long until an abandoned vehicle will be removed from gameplay (in seconds)
	abandonedRespawnTimer -- how long until an abandoned vehicle will respawn (in seconds)
	destroyedTimer -- how long until an destroyed vehicle will be removed from gameplay (in seconds)
	destroyedRespawnTimer -- how long until a destroyed vehicle will respawn (in seconds)
]]--

	vehicleCategories =
	{
		-- ====================================================================
		-- BASIC CATEGORIES
		-- ====================================================================

		------------------------------------------------
		------------------------------------------------ PORSHE
		{
			category = "armored_truck_army",
			classes =
			{
				{ class = "placeholder9", contents = "RandomPoliceSedanContents" },
			},
			initialMinVehicles    = 4,
			abandonedTimer        = 172800,  -- two days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer        = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ SUBARU BRZ
		{
			category = "armored_truck_police",
            classes =
            {
                { 
                    class = "placeholder12", contents = "RandomPoliceSedanContents",
                    skins =
                    {
                        { name = "placeholder12"		, percent = 10 },
                        { name = "placeholder12_black"	, percent = 20 },
                        { name = "placeholder12_blue"	, percent = 20 },
                        { name = "placeholder12_camo2"	, percent = 10 },
                        { name = "placeholder12_green"	, percent = 20 },
                        { name = "placeholder12_red"	, percent = 20 },
                    },
                },
            },
            initialMinVehicles = 4,
            abandonedTimer = 172800,  -- two days
            abandonedRespawnTimer = 3600, -- one hour
            destroyedTimer = 120,
            destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		

		------------------------------------------------
		------------------------------------------------
		{
			category = "bicycle",
			classes =
			{
				{
					class = "beetle", contents = "RandomF100TruckContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "Beetle_Black", percent = 11.0 },
						{ name = "Beetle_Blue", percent = 11.0 },
						{ name = "Beetle_Green", percent = 11.0 },
						{ name = "Beetle_Orange", percent = 12.0 }, -- Default
						{ name = "Beetle_Pink", percent = 11.0 },
						{ name = "Beetle_Purple", percent = 11.0 },
						{ name = "Beetle_Red", percent = 11.0 },
						{ name = "Beetle_White", percent = 11.0 },
						{ name = "Beetle_Yellow", percent = 11.0 },
					},
				},
                {
					class = "truck_semi", contents = "RandomTruck5TonContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "TruckSemi_Black", percent = 11.0 },
						{ name = "TruckSemi_Blue", percent = 11.0 },
						{ name = "TruckSemi_Green", percent = 11.0 },
						{ name = "TruckSemi_Orange", percent = 11.0 },
						{ name = "TruckSemi_Pink", percent = 11.0 },
						{ name = "TruckSemi_Purple", percent = 11.0 },
						{ name = "TruckSemi_Red", percent = 11.0 },
						{ name = "TruckSemi_White", percent = 12.0 }, -- Default
						{ name = "TruckSemi_Yellow", percent = 11.0 },
					},
				},
                { class = "sedan_taxi_blix", contents = "RandomF100TruckContents" },
                { class = "sedan_taxi_engoa", contents = "RandomF100TruckContents" },
                { class = "sedan_taxi_fullout", contents = "RandomF100TruckContents" },
                { class = "towcar", contents = "RandomTowcarContents" },
                {
					class = "dune_buggy", contents = "RandomF100TruckContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "DuneBuggy_Black", percent = 11.0 },
						{ name = "DuneBuggy_Blue", percent = 11.0 },
						{ name = "DuneBuggy_Green", percent = 11.0 },
						{ name = "DuneBuggy_Orange", percent = 12.0 }, -- Default
						{ name = "DuneBuggy_Pink", percent = 11.0 },
						{ name = "DuneBuggy_Purple", percent = 11.0 },
						{ name = "DuneBuggy_Red", percent = 11.0 },
						{ name = "DuneBuggy_White", percent = 11.0 },
						{ name = "DuneBuggy_Yellow", percent = 11.0 },
					},
				},
        
			},
			initialMinVehicles = 15,
			abandonedTimer = 345600,  -- 4 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "dirtbike",
			classes =
			{
				{
					-- All dirtbike spawners now just spawn a quadbike
					class = "quadbike", contents = "RandomQuadBikeContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "Quadbike_Black", percent = 11.0 },
						{ name = "Quadbike_Blue", percent = 11.0 },
						{ name = "Quadbike_Green", percent = 11.0 },
						{ name = "Quadbike_Orange", percent = 12.0 }, -- Default??
						{ name = "Quadbike_Pink", percent = 11.0 },
						{ name = "Quadbike_Purple", percent = 11.0 },
						{ name = "Quadbike_Red", percent = 11.0 },
						{ name = "Quadbike_White", percent = 11.0 },
						{ name = "Quadbike_Yellow", percent = 11.0 },
					},
				},
			},
			initialMinVehicles = 10,
			abandonedTimer = 21600,  -- six hours
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ Audi r4
		{
			category = "dune_buggy",
            classes =
            {
                { 
                    class = "placeholder7", contents = "RandomF100TruckContents",
                    skins =
                    {
                        { name = "placeholder7_black", percent = 18 },
                        { name = "placeholder7_blue", percent = 18 },
                        { name = "placeholder7_green", percent = 18 },
                        { name = "placeholder7_red", percent = 18 },
                        { name = "placeholder7_brown", percent = 18 },
                        { name = "placeholder7_chrome", percent = 10 },
                        
                    },
                },
            },
            initialMinVehicles = 4,
            abandonedTimer = 172800,  -- 5 days
            abandonedRespawnTimer = 3600, -- one hour
            destroyedTimer = 120,
            destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ BMW-F420 PATRIOT
		{
			category = "f100truck",
			classes =
			{
				{ class = "placeholder1", contents = "RandomF100TruckContents" 
            
            
                },
			},
			initialMinVehicles = 4,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "fishing_boat",
			classes =
			{
				{
					class = "fishing_boat", contents = "RandomFishingBoatContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "FishingBoat_Black", percent = 11.0 },
						{ name = "FishingBoat_Blue", percent = 11.0 },
						{ name = "FishingBoat_Green", percent = 11.0 },
						{ name = "FishingBoat_Orange", percent = 12.0 },
						{ name = "FishingBoat_Pink", percent = 11.0 },
						{ name = "FishingBoat_Purple", percent = 11.0 },
						{ name = "FishingBoat_Red", percent = 11.0 },
						{ name = "FishingBoat_White", percent = 11.0 }, -- Default
						{ name = "FishingBoat_Yellow", percent = 11.0 },
					},
				},
			},
			initialMinVehicles = 5,
			abandonedTimer = 172800,  -- two days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "jetski",
			classes =
			{
				{ class = "jetski", contents = "RandomJetskiContents" },
			},
			initialMinVehicles = 7,
			abandonedTimer = 21600,  -- six hours
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ Mercedes vito 
		{
			category = "party_bus",
			classes =
			{
				{ class = "party_bus", contents = "RandomPartyBusContents" },
			},
			initialMinVehicles = 4,
			abandonedTimer = 172800,  -- two days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "quadbike",
			classes =
			{
				{
					class = "quadbike", contents = "RandomQuadBikeContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "Quadbike_Black", percent = 11.0 },
						{ name = "Quadbike_Blue", percent = 11.0 },
						{ name = "Quadbike_Green", percent = 11.0 },
						{ name = "Quadbike_Orange", percent = 12.0 }, -- Default??
						{ name = "Quadbike_Pink", percent = 11.0 },
						{ name = "Quadbike_Purple", percent = 11.0 },
						{ name = "Quadbike_Red", percent = 11.0 },
						{ name = "Quadbike_White", percent = 11.0 },
						{ name = "Quadbike_Yellow", percent = 11.0 },
					},
				},
			},
            initialMinVehicles = 15,
			abandonedTimer = 21600,  -- six hours
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "sedan_base",
			classes =
			{
				{
					class = "sedan_base", contents = "RandomF100TruckContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "SedanBase_Black", percent = 11.0 },
						{ name = "SedanBase_Blue", percent = 11.0 },
						{ name = "SedanBase_Green", percent = 11.0 },
						{ name = "SedanBase_Orange", percent = 11.0 },
						{ name = "SedanBase_Pink", percent = 11.0 },
						{ name = "SedanBase_Purple", percent = 11.0 },
						{ name = "SedanBase_Red", percent = 11.0 },
						{ name = "SedanBase_White", percent = 12.0 }, -- Default
						{ name = "SedanBase_Yellow", percent = 11.0 },
					},
				},
			},
			initialMinVehicles = 4,
			abandonedTimer = 172800, -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "sedan_police",
			classes =
			{
				{ class = "sedan_police", contents = "RandomPoliceSedanContents" },
                { class = "suv_police", contents = "RandomPoliceSedanContents" },
			},
			initialMinVehicles = 4,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ camion blindado mod
		{
			category = "sedan_taxi",
			classes =
			{
				{ class = "placeholder11", contents = "RandomF100TruckContents" },
			},
			initialMinVehicles = 4,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "suv_basic",
			classes =
			{
				{
					class = "suv_basic", contents = "RandomF100TruckContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "SUVBasic_Black", percent = 11.0 },
						{ name = "SUVBasic_Blue", percent = 11.0 },
						{ name = "SUVBasic_Green", percent = 11.0 },
						{ name = "SUVBasic_Orange", percent = 12.0 },
						{ name = "SUVBasic_Pink", percent = 11.0 },
						{ name = "SUVBasic_Purple", percent = 11.0 },
						{ name = "SUVBasic_Red", percent = 11.0 },
						{ name = "SUVBasic_White", percent = 11.0 }, -- Default
						{ name = "SUVBasic_Yellow", percent = 11.0 },
					},
				},
				{ 
                    -- Shelby gt500
					class = "placeholder3", contents = "RandomF100TruckContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "placeholder3_black", percent = 14 },
						{ name = "placeholder3_green", percent = 14 },
						{ name = "placeholder3_yellow", percent = 15 },
						{ name = "placeholder3_white", percent = 14 },
						{ name = "placeholder3_red", percent = 15 },
						{ name = "placeholder3_grey", percent = 14 },
						{ name = "placeholder3_blue", percent = 14 },
					},
				},
			},
			initialMinVehicles = 8,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "suv_police",
			classes =
			{
				{ class = "suv_police", contents = "RandomPoliceSedanContents" },
			},
			initialMinVehicles = 10,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ --chevrolet corvette c6
		{
			category = "towcar",
			classes =
			{
				{ 
					class = "placeholder8", contents = "RandomTowcarContents",
					skins =
					{
						{ name = "placeholder8_black", percent = 20 },
						{ name = "placeholder8_blue", percent = 20 },
						{ name = "placeholder8_green", percent = 20 },
						{ name = "placeholder8_red", percent = 20 },
						{ name = "placeholder8_yellow", percent = 20 },
						
					},
					
				},
			},
			initialMinVehicles = 4,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------
		{
			category = "tractor",
			classes =
			{
				{ class = "tractor", contents = "RandomTractorContents" },
			},
			initialMinVehicles = 8,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ HMMWV o Humvee 
		{
			category = "truck_5ton",  
			classes =
			{
				{ 
					class = "placeholder5", contents = "RandomF100TruckContents",
					skins =
					{
						-- If the total doesn't equal 100% then the remainder will spawn with the default skin
						{ name = "placeholder5_Black", percent = 13 },
						{ name = "placeholder5_Green", percent = 14 },
						{ name = "placeholder5_Yellow", percent = 14 },
						{ name = "placeholder5_Brown", percent = 9 },
						{ name = "placeholder5_Camo7", percent = 9 },
						{ name = "placeholder5_Camo5", percent = 9 },
						{ name = "placeholder5_Gray", percent = 9 },
						{ name = "placeholder5_Pink", percent = 8 },
						{ name = "placeholder5_White", percent = 8 },
						{ name = "placeholder5_Leopard", percent = 7 },
					},
				},
			},
			initialMinVehicles = 4,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

		------------------------------------------------
		------------------------------------------------ BMW clasico 
		{
			category = "truck_semi", 
			classes =
			{
				{ 
					class = "placeholder4", contents = "RandomTruck5TonContents",
					skins =
					{
						{ name = "placeholder4_black", percent = 20 },
						{ name = "placeholder4_blue", percent = 20 },
						{ name = "placeholder4_brown", percent = 20 },
						{ name = "placeholder4_green", percent = 20 },
						{ name = "placeholder4_red", percent = 20 },
					},
				},
			},
			initialMinVehicles = 8,
			abandonedTimer = 172800,  -- 2 days
			abandonedRespawnTimer = 3600, -- one hour
			destroyedTimer = 120,
			destroyedRespawnTimer = 7200, -- two hours
		},

	},
}

--------------------------------------------------------------------------
-- Functions called from C++
--------------------------------------------------------------------------
function VehicleSpawnerManager:OnInit()
	--Log("VehicleSpawnerManager:OnInit");

	self:OnReset();
end

------------------------------------------------------------------------------------------------------
-- OnPropertyChange called only by the editor.
------------------------------------------------------------------------------------------------------
function VehicleSpawnerManager:OnPropertyChange()
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnReset called only by the editor.
------------------------------------------------------------------------------------------------------
function VehicleSpawnerManager:OnReset()
	--Log("VehicleSpawnerManager:OnReset");
	self:Reset();
end

------------------------------------------------------------------------------------------------------
-- OnSpawn called Editor/Game.
------------------------------------------------------------------------------------------------------
function VehicleSpawnerManager:OnSpawn()
	self:Reset();
end

function VehicleSpawnerManager:Reset()
	--Log("VehicleSpawnerManager:Reset");
end

-- Load mods
Script.LoadScriptFolder("scripts/spawners/vsm_mods", true, true)