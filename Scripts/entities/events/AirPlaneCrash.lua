AirPlaneCrash = {
	type = "AirPlaneCrash",

	Client = {},
	Server = {},

	Properties = {
		mass = 8000,

		fileModel = "Objects/props/misc/vehicles/small_plane/small_plane_a.cgf",
		fileModelCrashed = "Objects/props/crashed_plane/small_plane_crashed.cgf",

		fTravelHeight = 1800, -- meters
		fTravelSpeed= 40, -- m/s

		fStartPercentRange = 0.8, -- middle percent of map plane can start in
		fFinishPercentRange = 0.8, -- middle percent of map plane can finish at
		fFadeInOutMultiplier = 0.1,  -- percent of map size plane appears before entering/after leaving the map

		 -- lights not used currently - need helpers on the airplane
		LightLeftWingHelper = "",
		clrLightLeftColor = { x=1,y=0,z=0 },

		LightRightWingHelper = "",
		clrLightRightColor = { x=0,y=1,z=0 },

		LightRearTailHelper = "",
		clrLightTailColor = { x=1,y=1,z=1 },

		ParticleEffectInAir = "misc.planecrash.smoke",
		ParticleEffectOnGround = "misc.planecrash.plane_crash",

		StartAudioTrigger = "Play_prop_plane",
		StopAudioTrigger = "Stop_prop_plane",

		Explosion = {
			damage = 500,
			pressure = 2000,
			min_radius = 4,
			max_radius = 40,
			min_phys_radius = 4,
			max_phys_radius = 20,
			sound_radius = 600,
			radialblurdist = 450,
			effect_name = "explosions.jerrycan_diesel.burning",
			effect_scale = 15,
			hit_type = "explosion",
		}
	},
	
	Editor={
		--Model="Editor/Objects/T.cgf",
		Icon="AirPlaneCrash.bmp",
	},
}

function AirPlaneCrash:OnInit()
	self:OnReset();
end

function AirPlaneCrash:OnPropertyChange()
	self:OnReset();
end

function AirPlaneCrash:OnReset()
end

function AirPlaneCrash:OnShutDown()
end

-- Called when the crash happens on the server
function AirPlaneCrash:OnCrashed()
	--Log("AirPlaneCrash - OnCrashed")

	-- spawn the loot after 1 second, so the explosion doesn't damage it
	Script.SetTimerForFunction(1000, "SpawnAirPlaneCrashLoot", self)
	Script.SetTimerForFunction(4000, "SpawnAI", self)
end

-- Spawn the loot
SpawnAirPlaneCrashLoot = function(self)

	local direction = self:GetDirectionVector()
	local worldPos = self:GetWorldPos()

	local offsets = {-10.0, -20.0, -30.0, -40.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0}
	local spawnPositions = {}

	-- Calculate spawn positions
	for i, offset in ipairs(offsets) do
		local vForwardOffset = {x=0, y=0, z=0}
		FastScaleVector(vForwardOffset, direction, offset)
		local vSpawnPos = {x=0, y=0, z=0}
		FastSumVectors(vSpawnPos, vForwardOffset, worldPos)
		table.insert(spawnPositions, vSpawnPos)
	end



	---------------

	local rnd = random(1,30)	
	if rnd <= 12 then
        ISM.SpawnItem("PlaneCrashCrate", spawnPositions[1])
		ISM.SpawnItem("AirDropCrate", spawnPositions[2])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[3])
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[4])
		ISM.SpawnCategory("AirPlaneCrashCrateCivilian", spawnPositions[5])
		ISM.SpawnCategory("AirPlaneCrashCrateCivilian", spawnPositions[6])

        SpawnAI = function(self)

			local vForwardOffset = {x=0, y=0, z=0}
			FastScaleVector(vForwardOffset, direction, 0)
			local vSpawnPos = {x=0, y=0, z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, worldPos)

			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
		end	
	elseif rnd <= 20 then
        ISM.SpawnItem("AirDropCrate", spawnPositions[1])
		ISM.SpawnItem("AirDropCrate", spawnPositions[2])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[3])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[4])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[5])

        
		SpawnAI = function(self)

			local vForwardOffset = {x=0, y=0, z=0}
			FastScaleVector(vForwardOffset, direction, 0)
			local vSpawnPos = {x=0, y=0, z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, worldPos)

			AISM.SpawnCategory(vSpawnPos, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
		end	
	elseif rnd <= 25 then
        ISM.SpawnItem("PlaneCrashCrate", spawnPositions[1])
		ISM.SpawnItem("AirDropCrate", spawnPositions[2])
		ISM.SpawnItem("AirDropCrate", spawnPositions[3])
		ISM.SpawnItem("AirDropCrate", spawnPositions[4])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[5])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[6])
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[7])
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[8])

		SpawnAI = function(self)

			local vForwardOffset = {x=0, y=0, z=0}
			FastScaleVector(vForwardOffset, direction, 0)
			local vSpawnPos = {x=0, y=0, z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, worldPos)

			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
		end	
    elseif rnd <= 28 then
        ISM.SpawnItem("PlaneCrashCrate", spawnPositions[1])
		ISM.SpawnItem("PlaneCrashCrate", spawnPositions[2])
		ISM.SpawnItem("AirDropCrate", spawnPositions[3])
		ISM.SpawnItem("AirDropCrate", spawnPositions[4])
		ISM.SpawnItem("AirDropCrate", spawnPositions[5])
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[6])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[7])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[8])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[9])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[10])
		ISM.SpawnCategory("RandomTowableParts", spawnPositions[10])

		SpawnAI = function(self)

			local vForwardOffset = {x=0, y=0, z=0}
			FastScaleVector(vForwardOffset, direction, 0)
			local vSpawnPos = {x=0, y=0, z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, worldPos)

			AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)

			AISM.SpawnCategory(vSpawnPos, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
			
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
		end	
    elseif rnd <= 30 then 

		ISM.SpawnItem("PlaneCrashCrate", spawnPositions[1])
		ISM.SpawnItem("PlaneCrashCrate", spawnPositions[2])
		ISM.SpawnItem("PlaneCrashCrate", spawnPositions[3])
		ISM.SpawnItem("PlaneCrashCrate", spawnPositions[4])
		ISM.SpawnItem("AirDropCrate", spawnPositions[5])
		ISM.SpawnItem("AirDropCrate", spawnPositions[6])
		ISM.SpawnItem("AirDropCrate", spawnPositions[7])
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[8])
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[9])
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[10])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[10])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[1])
		ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[2])
		ISM.SpawnCategory("RandomTowableParts", spawnPositions[10])
	
        SpawnAI = function(self)

			local vForwardOffset = {x=0, y=0, z=0}
			FastScaleVector(vForwardOffset, direction, 0)
			local vSpawnPos = {x=0, y=0, z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, worldPos)

			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
			AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
            AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
		end
	end
end

