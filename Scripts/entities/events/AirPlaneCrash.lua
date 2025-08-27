AirPlaneCrash = {
	type = "AirPlaneCrash",

	Client = {},
	Server = {},

	Properties = {
		mass = 8000,

		fileModel = "Objects/props/misc/vehicles/small_plane/small_plane_a.cgf",
		fileModelCrashed = "Objects/props/crashed_plane/small_plane_crashed.cgf",

		fTravelHeight = 1800, -- meters
		fTravelSpeed = 40,    -- m/s

		fStartPercentRange = 0.8, -- middle percent of map plane can start in
		fFinishPercentRange = 0.8, -- middle percent of map plane can finish at
		fFadeInOutMultiplier = 0.1, -- percent of map size plane appears before entering/after leaving the map

		-- lights not used currently - need helpers on the airplane
		LightLeftWingHelper = "",
		clrLightLeftColor = { x = 1, y = 0, z = 0 },

		LightRightWingHelper = "",
		clrLightRightColor = { x = 0, y = 1, z = 0 },

		LightRearTailHelper = "",
		clrLightTailColor = { x = 1, y = 1, z = 1 },

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

	Editor = {
		--Model="Editor/Objects/T.cgf",
		Icon = "AirPlaneCrash.bmp",
	},
}

-- ======================================================
-- Helpers
-- ======================================================

-- Genera posiciones cercanas aleatorias
local function GenerateOffsets(basePos, count, radius)
	local positions = {}
	for i = 1, count do
		local offset = { x = random(-radius, radius), y = random(-radius, radius), z = 0 }
		positions[i] = { x = basePos.x + offset.x, y = basePos.y + offset.y, z = basePos.z }
	end
	return positions
end

-- Spawnea loot de una categoría o clase
local function SpawnLoot(pos, lootTable)
	for _, entry in ipairs(lootTable) do
		if random(1, 100) <= (entry.percent or 100) then
			if entry.category then
				ISM.SpawnCategory(entry.category, pos)
			elseif entry.class then
				ISM.SpawnItem(entry.class, pos)
			end
		end
	end
end

-- Spawnea AI en posiciones cercanas
local function SpawnAIGroup(pos, groups)
	for _, g in ipairs(groups) do
		if random(1, 100) <= (g.percent or 100) then
			AISM.SpawnCategory(pos, g.category, true, g.minDist or 2.0, g.maxDist or 5.0, g.delay or 2.0)
		end
	end
end

-- ======================================================
-- Evento principal
-- ======================================================

function AirPlaneCrash:OnInit()
	Log(">> AirPlaneCrash:OnInit")
	Script.SetTimerForFunction(3000, "AirPlaneCrash.OnCrashed", self)
end

function AirPlaneCrash:OnPropertyChange()
	self:OnReset();
end

function AirPlaneCrash:OnReset()
end

function AirPlaneCrash:OnShutDown()
end

-- Called when the crash happens on the server
function AirPlaneCrash.OnCrashed(self)
	Log(">> AirPlaneCrash:OnCrashed")

	local pos = self:GetWorldPos()
	local offsets = GenerateOffsets(pos, 10, 15)

	-- Decide qué escenario usar
	local rnd = random(1, 100)

	if rnd <= 20 then
		-- Escenario 1: Loot abundante + poca AI
		for i = 1, 3 do
			SpawnLoot(offsets[i], {
				{ category = "RandomAirDropCrate", percent = 100 },
				{ category = "RandomEpicWeapon",   percent = 20 },
			})
		end
		SpawnAIGroup(offsets[5], {
			{ category = "HumanZombieSingle", percent = 50 },
			{ category = "Spiker",            percent = 30 },
		})
	elseif rnd <= 40 then
		-- Escenario 2: Más AI, loot moderado
		for i = 1, 2 do
			SpawnLoot(offsets[i], {
				{ category = "RandomAirDropCrateMilitary", percent = 100 },
			})
		end
		SpawnAIGroup(offsets[6], {
			{ category = "HumanZombieSingle", percent = 70 },
			{ category = "BruteMutantSingle", percent = 20 },
		})
	elseif rnd <= 65 then
		-- Escenario 3: Crash civil (loot random + civiles zombis)
		SpawnLoot(offsets[1], {
			{ category = "RandomAirDropCrateCivilian", percent = 100 },
			{ category = "RandomConsumable",           percent = 50 },
		})
		SpawnAIGroup(offsets[7], {
			{ category = "HumanZombieSingle", percent = 80 },
		})
	elseif rnd <= 85 then
		-- Escenario 4: Crash contaminado
		SpawnLoot(offsets[2], {
			{ category = "RandomAirDropCrateRadiation", percent = 100 },
		})
		SpawnAIGroup(offsets[8], {
			{ category = "Spiker",      percent = 50 },
			{ category = "HumanSpider", percent = 10 },
		})
	else
		-- Escenario 5: Evento raro (loot épico + boss)
		SpawnLoot(offsets[3], {
			{ category = "RandomAirDropCrate", percent = 100 },
			{ category = "RandomEpicWeapon",   percent = 50 },
			{ class = "SAPOCBriefcaseClosed",  percent = 5 },
		})
		SpawnAIGroup(offsets[9], {
			{ category = "BruteMutantSingle", percent = 100 },
			{ category = "HumanSpider",       percent = 30 },
		})
	end

	-- Despues de loot/AI, eliminamos el evento
	Script.SetTimerForFunction(10000, "AirPlaneCrash.OnFinished", self)
end

-- Spawn the loot
function AirPlaneCrash.OnFinished(self)
	Log(">> AirPlaneCrash finished")
	System.RemoveEntity(self.id)
end
