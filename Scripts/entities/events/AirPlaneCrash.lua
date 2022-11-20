AirPlaneCrash = {
	type = "AirPlaneCrash",

	Client = {},
	Server = {},

	Properties = {
		mass = 8000,

		fileModel = "Objects/props/misc/vehicles/small_plane/small_plane_a.cgf",
		fileModelCrashed = "Objects/props/crashed_plane/small_plane_crashed.cgf",

		fTravelHeight = 1800, -- meters
		fTravelSpeed= 45, -- m/s

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
	--Log("AirPlaneCrash - SpawnAirPlaneCrashLoot")

	local vForwardOffset = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0.0)

	local vForwardOffset1 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset1, self:GetDirectionVector(), -2.0)

	local vForwardOffset2 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset2, self:GetDirectionVector(), -6.0)

	local vForwardOffset3 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset3, self:GetDirectionVector(), -10.0)

	local vForwardOffset4 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset4, self:GetDirectionVector(), -14.0)

	local vForwardOffset5 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset5, self:GetDirectionVector(), 2.0)

	local vForwardOffset6 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset6, self:GetDirectionVector(), 6.0)

	local vForwardOffset7 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset7, self:GetDirectionVector(), 10.0)

	local vForwardOffset8 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset8, self:GetDirectionVector(), 14.0)

	local vForwardOffset9 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset9, self:GetDirectionVector(), 20.0)

	local vForwardOffset10 = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset10, self:GetDirectionVector(), 22.0)

	local vSpawnPos = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())
	-- FastSumVectors(vSpawnPos, vSpawnPos, {x=0,y=0,z=2})
	
    -- FastSumvecto Copies the componentwise addition of vector b and vector a to vector dest.
	local vSpawnPos1 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos1, vForwardOffset1, self:GetWorldPos())

	local vSpawnPos2 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos2, vForwardOffset2, self:GetWorldPos())

	local vSpawnPos3 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos3, vForwardOffset3, self:GetWorldPos())
	-- FastSumVectors(vSpawnPos3, vSpawnPos3, {x=0,y=0,z=-5})

	local vSpawnPos4 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos4, vForwardOffset4, self:GetWorldPos())

	local vSpawnPos5 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos5, vForwardOffset5, self:GetWorldPos())

	local vSpawnPos6 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos6, vForwardOffset6, self:GetWorldPos())

	local vSpawnPos7 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos7, vForwardOffset7, self:GetWorldPos())

	local vSpawnPos8 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos8, vForwardOffset8, self:GetWorldPos())

	local vSpawnPos9 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos9, vForwardOffset9, self:GetWorldPos())

	local vSpawnPos10 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos10, vForwardOffset10, self:GetWorldPos())



	---------------

	local rnd = random(1,30)	
	if rnd <= 12 then
        ISM.SpawnItem("PlaneCrashCrate"          , vSpawnPos1)
		ISM.SpawnItem("AirDropCrate"             , vSpawnPos2)
        ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos3)
        ISM.SpawnCategory("AirPlaneCrashCrateMilitary", vSpawnPos4)

		ISM.SpawnItem("debris_01"                , vSpawnPos5)
        ISM.SpawnItem("debris_01"                , vSpawnPos6)
        ISM.SpawnItem("planecrash_engine"        , vSpawnPos7)
        ISM.SpawnItem("planecrash_gear"          , vSpawnPos8)
		
        SpawnAI = function(self)

			local vForwardOffset = {x=0,y=0,z=0}
			FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
			local vSpawnPos = {x=0,y=0,z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

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
        ISM.SpawnItem("AirDropCrate"          , vSpawnPos1)
		ISM.SpawnItem("AirDropCrate"          , vSpawnPos2)
		ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos3)
        ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos4)
        ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos5)

        ISM.SpawnItem("debris_01"                , vSpawnPos6)
        ISM.SpawnItem("debris_01"                , vSpawnPos7)
        ISM.SpawnItem("planecrash_engine"        , vSpawnPos8)
        ISM.SpawnItem("planecrash_engine"        , vSpawnPos9)
        ISM.SpawnItem("planecrash_gear"          , vSpawnPos10)
        
		SpawnAI = function(self)

			local vForwardOffset = {x=0,y=0,z=0}
			FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
			local vSpawnPos = {x=0,y=0,z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

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
        ISM.SpawnItem("PlaneCrashCrate", vSpawnPos1)
		ISM.SpawnItem("AirDropCrate", vSpawnPos2)
        ISM.SpawnItem("AirDropCrate", vSpawnPos3)
		ISM.SpawnItem("AirDropCrate", vSpawnPos4)
		ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos5)
        ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos6)
        ISM.SpawnCategory("AirPlaneCrashCrateMilitary", vSpawnPos7)
        ISM.SpawnCategory("AirPlaneCrashCrateMilitary", vSpawnPos8)

        ISM.SpawnItem("debris_01", vSpawnPos9)
        ISM.SpawnItem("debris_01", vSpawnPos10)
        ISM.SpawnItem("planecrash_engine", vSpawnPos7)
        ISM.SpawnItem("planecrash_engine", vSpawnPos8)
        ISM.SpawnItem("planecrash_gear", vSpawnPos6)
        
		SpawnAI = function(self)

			local vForwardOffset = {x=0,y=0,z=0}
			FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
			local vSpawnPos = {x=0,y=0,z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

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
        ISM.SpawnItem("PlaneCrashCrate"          , vSpawnPos1)
		ISM.SpawnItem("PlaneCrashCrate"          , vSpawnPos2)
        ISM.SpawnItem("AirDropCrate"             , vSpawnPos3)
		ISM.SpawnItem("AirDropCrate"             , vSpawnPos4)
		ISM.SpawnItem("AirDropCrate"             , vSpawnPos5)
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", vSpawnPos6)
        ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos7)
        ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos8)
        ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos9)
		ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos10)
        
		ISM.SpawnItem("debris_01"			, vSpawnPos)
        ISM.SpawnItem("debris_01"			, vSpawnPos8)
        ISM.SpawnItem("planecrash_engine"	, vSpawnPos9)
        ISM.SpawnItem("planecrash_engine"	, vSpawnPos10)
        ISM.SpawnItem("planecrash_gear"		, vSpawnPos7)
                
        ISM.SpawnCategory("RandomTowableParts"           , vSpawnPos)

		SpawnAI = function(self)

			local vForwardOffset = {x=0,y=0,z=0}
			FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
			local vSpawnPos = {x=0,y=0,z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

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

		ISM.SpawnItem("PlaneCrashCrate"          , vSpawnPos)
		ISM.SpawnItem("PlaneCrashCrate"          , vSpawnPos1)
		ISM.SpawnItem("PlaneCrashCrate"          , vSpawnPos2)
		ISM.SpawnItem("PlaneCrashCrate"          , vSpawnPos3)
		ISM.SpawnItem("AirDropCrate"             , vSpawnPos4)
		ISM.SpawnItem("AirDropCrate"             , vSpawnPos5)
		ISM.SpawnItem("AirDropCrate"             , vSpawnPos6)
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", vSpawnPos7)
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", vSpawnPos8)
		ISM.SpawnCategory("AirPlaneCrashCrateMilitary", vSpawnPos9)
		ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos10)
		ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos)
		ISM.SpawnCategory("AirPlaneCrashBackpack", vSpawnPos1)
        ISM.SpawnCategory("RandomTowableParts"           , vSpawnPos)

		ISM.SpawnItem("debris_01", vSpawnPos9)
		ISM.SpawnItem("debris_01", vSpawnPos10)
		ISM.SpawnItem("planecrash_engine", vSpawnPos7)
		ISM.SpawnItem("planecrash_engine", vSpawnPos8)
		ISM.SpawnItem("planecrash_gear", vSpawnPos10)
	
        SpawnAI = function(self)

			local vForwardOffset = {x=0,y=0,z=0}
			FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
			local vSpawnPos = {x=0,y=0,z=0}
			FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

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

--SpawnAI = function(self)
	--local vForwardOffset = {x=0,y=0,z=0}
	--FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
	--local vSpawnPos = {x=0,y=0,z=0}
	--FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())
	--AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanSpider", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "CrazySingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "SpikerSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnCategory(vSpawnPos, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	--AISM.SpawnHorde(vSpawnPos, "horde")
	--AISM.SpawnHorde(vSpawnPos, "mutant_invasion")
	--AISM.SpawnHorde(vSpawnPos, "horde")
	--AISM.SpawnHorde(vSpawnPos, "mutant_invasion")
--end