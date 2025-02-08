UFOCrash = {
	type = "UFOCrash",

	Client = {},
	Server = {},

	Properties = {
		mass = 4000,

		fileModel = "Objects/props/ufo_event/ufo.cgf",
		fileModelCrashed = "Objects/props/ufo_event/ufo.cgf",

		fTravelHeight = 450, -- meters
		fTravelSpeed= 25, -- m/s

		fStartPercentRange = 0.4, -- middle percent of map plane can start in
		fFinishPercentRange = 0.8, -- middle percent of map plane can finish at
		fFadeInOutMultiplier = 1.0,  -- percent of map size plane appears before entering/after leaving the map

		-- lights not used currently - need helpers on the airplane
		LightLeftWingHelper = "",
		clrLightLeftColor = { x=1,y=0,z=0 },

		LightRightWingHelper = "",
		clrLightRightColor = { x=0,y=1,z=0 },

		LightRearTailHelper = "",
		clrLightTailColor = { x=1,y=1,z=1 },

		ParticleEffectInAir = "misc.UFOCrash.UFOcrash",
		ParticleEffectOnGround = "misc.UFOCrash.crashed_smoke",

		StartAudioTrigger = "Play_airdrop_plane",
		StopAudioTrigger = "Stop_airdrop_plane",

		Explosion = {
			damage = 500,
			pressure = 5000,
			min_radius = 10,
			max_radius = 45,
			min_phys_radius = 10,
			max_phys_radius = 35,
			sound_radius = 750,
			radialblurdist = 100,
			effect_name = "explosions.jerrycan_diesel.burning",
			effect_scale = 1,
			hit_type = "explosion",
		}
	},
	
	Editor={
		--Model="Editor/Objects/T.cgf",
		Icon="UFOCrash.bmp",
	},
}

function UFOCrash:OnInit()
	self:OnReset();

end

function UFOCrash:OnPropertyChange()
	self:OnReset();
end

function UFOCrash:OnReset()
end

function UFOCrash:OnShutDown()
end

-- Called when the crash happens on the server
function UFOCrash:OnCrashed()
    Log("UFOCrash - OnCrashed")

    -- spawn the loot after 1 second, so the explosion doesn't damage it
    Script.SetTimerForFunction(1000, "SpawnUFOCrashLoot", self)
    Script.SetTimerForFunction(4000, "SpawnAI", self)
end

-- Spawn the loot
SpawnUFOCrashLoot = function(self)
    Log("UFOCrash - SpawnUFOCrashLoot")

    -- Two meters behind the direction vector
    local vForwardOffset = {x=0,y=0,z=0}
    FastScaleVector(vForwardOffset, self:GetDirectionVector(), -2.0)

    -- Offset by the entity location
    local vSpawnPos = {x=0,y=0,z=0}
    FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())

    -- Move up by 2 meters
    FastSumVectors(vSpawnPos, vSpawnPos, {x=0,y=0,z=2})

    -- Items that spawn in when the plane crashes
    ISM.SpawnCategory("UFOCrashCrate", vSpawnPos)
    ISM.SpawnCategory("UFOCrashCrate", vSpawnPos)
    ISM.SpawnCategory("UFOCrashCrate", vSpawnPos)
	ISM.SpawnCategory("UFOCrashCrate", vSpawnPos)
end

SpawnAI = function(self)

	local vForwardOffset = {x=0,y=0,z=0}
	FastScaleVector(vForwardOffset, self:GetDirectionVector(), 0)
	local vForwardOffset1 = {x=5,y=5,z=2}
	FastScaleVector(vForwardOffset1, self:GetDirectionVector(), -5.0)
    local vForwardOffset2 = {x=5,y=5,z=4}
	FastScaleVector(vForwardOffset1, self:GetDirectionVector(), -5.0)
    local vForwardOffset3 = {x=5,y=5,z=5}
	FastScaleVector(vForwardOffset1, self:GetDirectionVector(), -5.0)
    local vForwardOffset4 = {x=5,y=5,z=8}
	FastScaleVector(vForwardOffset1, self:GetDirectionVector(), -5.0)

	local vSpawnPos = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos, vForwardOffset, self:GetWorldPos())
	
	local vSpawnPos1 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos1, vForwardOffset1, self:GetWorldPos())

	local vSpawnPos2 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos2, vForwardOffset2, self:GetWorldPos())

	local vSpawnPos3 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos3, vForwardOffset3, self:GetWorldPos())

	local vSpawnPos4 = {x=0,y=0,z=0}
	FastSumVectors(vSpawnPos4, vForwardOffset4, self:GetWorldPos())


	AISM.SpawnCategory(vSpawnPos1, "HumanSpider", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanSpider", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos2, "HumanSpider", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos2, "HumanSpider", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos1, "HumanSpider", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos1, "HumanSpider", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos2, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos2, "BruteMutantArmored", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos3, "BruteMutantSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "CrazySingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos4, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos4, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos4, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos4, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos4, "SpikerSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos4, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos4, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
	AISM.SpawnCategory(vSpawnPos1, "HumanZombieSingle", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos4, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos3, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
    AISM.SpawnCategory(vSpawnPos2, "twoheaddog_invasion", true, 2.0, 5.0, 2.0)
end