-- ===== Debug (opcional) =====
local APCRASH_DEBUG = 1
local function D(fmt, ...)
	if APCRASH_DEBUG == 1 then
		if select('#', ...) > 0 then
			Log(string.format("[APCrash] " .. fmt, ...))
		else
			Log("[APCrash] " .. fmt)
		end
	end
end
D("airplanecrash.lua loaded")

-- ===== Aislamiento por instancia =====
_APCrash = _APCrash or {} -- _APCrash[entityId] = { fn=function(self) ... end, aiDone=false }

-- Registra, para ESTA entidad, la función de IA de su rama (se ejecutará al timer)
function APCrash_RegisterAI(self, fn)
	local id = self.id
	_APCrash[id] = _APCrash[id] or {}
	if _APCrash[id].fn and not _APCrash[id].aiDone then
		D("RegisterAI OVERWRITE id=%s", tostring(id))
	end
	_APCrash[id].fn = fn
	_APCrash[id].aiDone = false
	D("RegisterAI id=%s", tostring(id))
end

-- Dispatcher PROPIO (nombre único: no lo pisa nadie)
function APCrash_SpawnAI(self)
	if CryAction and CryAction.IsServer and not CryAction.IsServer() then return end
	local st = _APCrash and _APCrash[self.id]
	if not st then
		D("APCrash_SpawnAI NO-STATE id=%s", tostring(self.id))
		return
	end
	if st.aiDone then
		D("APCrash_SpawnAI SKIP duplicate id=%s", tostring(self.id))
		return
	end

	st.aiDone = true
	D("APCrash_SpawnAI RUN id=%s", tostring(self.id))
	if st.fn then st.fn(self) else D("APCrash_SpawnAI NO-FN id=%s", tostring(self.id)) end
	D("APCrash_SpawnAI DONE id=%s", tostring(self.id))
	_APCrash[self.id] = nil
end

function SpawnAI(self)
	if _APCrash and _APCrash[self.id] then
		APCrash_SpawnAI(self)
	else
		-- No es un avión nuestro: no hacemos nada para no interferir con otros mods.
	end
end

-- ===== fin aislamiento =====


-- ===== Helpers =====
local function Groundify(pos)
	local z = System.GetTerrainElevation(pos) or pos.z or 0
	return { x = pos.x, y = pos.y, z = z + 0.25 }
end

local function spawnMany(spawnPositions, specs)
	-- specs: { {what="item"/"category", name="...", idx=1}, ... }
	for i = 1, #specs do
		local s = specs[i]
		local pos = spawnPositions[s.idx]
		if s.what == "item" then ISM.SpawnItem(s.name, pos) else ISM.SpawnCategory(s.name, pos) end
	end
end

-- CAP de llamadas a AISM por evento (evita plagas)
local function APCrash_SpawnWithBudget(vSpawnPos, plan, max_calls)
	local calls = 0
	for i = 1, #plan do
		local cat, times = plan[i][1], plan[i][2]
		for n = 1, times do
			if calls >= max_calls then return calls end
			AISM.SpawnCategory(vSpawnPos, cat, true, 2.0, 5.0, 2.0)
			calls = calls + 1
		end
	end
	return calls
end

-- Mantén tus llamadas setAIPlan(...) tal cual; ahora registran IA con CAP por defecto
function setAIPlan(self, direction, worldPos, plan, cap)
	local dir, pos = direction, worldPos
	local max_calls = cap or 10 -- CAP por defecto
	APCrash_RegisterAI(self, function(self)
		local off = { x = 0, y = 0, z = 0 }
		FastScaleVector(off, dir, 0)
		local p = { x = 0, y = 0, z = 0 }
		FastSumVectors(p, off, pos)
		p = Groundify(p)
		local done = APCrash_SpawnWithBudget(p, plan, max_calls)
		D("AI budget id=%s calls=%d cap=%d", tostring(self.id), done, max_calls)
	end)
end

-- ===== fin helpers =====


AirPlaneCrash = {
	type = "AirPlaneCrash",

	Client = {},
	Server = {},

	Properties = {
		mass                   = 8000,

		fileModel              = "Objects/props/misc/vehicles/small_plane/small_plane_a.cgf",
		fileModelCrashed       = "Objects/props/crashed_plane/small_plane_crashed.cgf",

		fTravelHeight          = 1800, -- meters
		fTravelSpeed           = 40, -- m/s

		fStartPercentRange     = 0.8,
		fFinishPercentRange    = 0.8,
		fFadeInOutMultiplier   = 0.1,

		-- lights (no usadas)
		LightLeftWingHelper    = "",
		clrLightLeftColor      = { x = 1, y = 0, z = 0 },
		LightRightWingHelper   = "",
		clrLightRightColor     = { x = 0, y = 1, z = 0 },
		LightRearTailHelper    = "",
		clrLightTailColor      = { x = 1, y = 1, z = 1 },

		ParticleEffectInAir    = "misc.planecrash.smoke",
		ParticleEffectOnGround = "misc.planecrash.plane_crash",

		StartAudioTrigger      = "Play_prop_plane",
		StopAudioTrigger       = "Stop_prop_plane",

		Explosion              = {
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

	Editor = { Icon = "AirPlaneCrash.bmp" },
}

function AirPlaneCrash:OnInit()
	self:OnReset()
end

function AirPlaneCrash:OnPropertyChange()
	self:OnReset()
end

function AirPlaneCrash:OnReset()
end

function AirPlaneCrash:OnShutDown()
end

-- Called when the crash happens on the server (con guard para no programar 2 veces)
function AirPlaneCrash:OnCrashed()
	if not CryAction.IsServer() then return end
	D("OnCrashed id=%s", tostring(self.id))

	if self._ap_aiScheduled then
		D("OnCrashed SKIP duplicate schedule id=%s", tostring(self.id))
		return
	end
	self._ap_aiScheduled = true
	D("schedule loot+AI id=%s (+1000ms / +4000ms)", tostring(self.id))

	-- Timers por nombre (formato original)
	Script.SetTimerForFunction(3000, "SpawnAirPlaneCrashLoot", self)
	Script.SetTimerForFunction(8000, "APCrash_SpawnAI", self)
end

-- Wrapper global requerido por el motor (llama al método)
function SpawnAirPlaneCrashLoot(self)
	if self and self.SpawnAirPlaneCrashLoot then
		self:SpawnAirPlaneCrashLoot()
	end
end

-- ===== Loot balanceado + registro del plan de IA por instancia =====
function AirPlaneCrash:SpawnAirPlaneCrashLoot()
	if not CryAction.IsServer() then return end
	if self._lootDone then
		D("Loot SKIP duplicate id=%s", tostring(self.id))
		return
	end
	self._lootDone = true
	D("Loot START id=%s", tostring(self.id))

	local direction      = self:GetDirectionVector()
	local worldPos       = self:GetWorldPos()

	-- 10 posiciones como tu original
	local offsets        = { -10.0, -20.0, -30.0, -40.0, 10.0, 20.0, 30.0, 40.0, 50.0, 60.0 }
	local spawnPositions = {}
	for i, offset in ipairs(offsets) do
		local vForwardOffset = { x = 0, y = 0, z = 0 }
		FastScaleVector(vForwardOffset, direction, offset)
		local vSpawnPos = { x = 0, y = 0, z = 0 }
		FastSumVectors(vSpawnPos, vForwardOffset, worldPos)
		spawnPositions[i] = Groundify(vSpawnPos) -- ← ajuste a suelo
	end


	local roll = random(1, 100)
	D("Loot roll=%d id=%s", roll, tostring(self.id))


	if roll <= 55 then
		-- STANDARD (55%) – 2 cajas piso + chance 3ra
		spawnMany(spawnPositions, {
			{ what = "item",     name = "AirDropCrate",          idx = 1 },
			{ what = "category", name = "AirPlaneCrashCrate",    idx = 2 },
			{ what = "category", name = "AirPlaneCrashBackpack", idx = 3 },
		})
		ISM.SpawnItem("PlaneCrashCrate", spawnPositions[4]) -- 3ra caja garantizada
		if random(1, 100) <= 10 then ISM.SpawnCategory("RandomEpicWeapon", spawnPositions[5]) end

		-- IA de esta rama (ligera) — registrada por instancia
		local dir, pos = direction, worldPos
		APCrash_RegisterAI(self, function(self)
			local vForwardOffset = { x = 0, y = 0, z = 0 }
			FastScaleVector(vForwardOffset, dir, 0)
			local vSpawnPos = { x = 0, y = 0, z = 0 }
			FastSumVectors(vSpawnPos, vForwardOffset, pos)

			local plan = {
				{ "BruteMutantSingle", random(0, 1) }, -- 0–1
				{ "SpikerSingle",      1 },
				{ "CrazySingle",       1 },
				{ "HumanZombieSolo",   2 },    -- bajamos de 4 a 2
			}
			APCrash_SpawnWithBudget(vSpawnPos, plan, 8) -- CAP: 8 llamadas máx
			-- después de llamar APCrash_SpawnWithBudget(...)
			local spawned = APCrash_SpawnWithBudget(vSpawnPos, plan, 10)
			D("AI budget id=%s calls=%d cap=%d", tostring(self.id), spawned, 10)
		end)
	elseif roll <= 85 then
		-- MILITARY (30%) – 2 cajas piso + chance 3ra militar
		spawnMany(spawnPositions, {
			{ what = "category", name = "AirPlaneCrashCrateMilitary", idx = 1 },
			{ what = "item",     name = "AirDropCrate",               idx = 2 },
			{ what = "category", name = "AirPlaneCrashBackpack",      idx = 3 },
		})
		if random(1, 100) <= 45 then ISM.SpawnCategory("AirPlaneCrashCrateMilitary", spawnPositions[4]) end
		if random(1, 100) <= 12 then ISM.SpawnCategory("RandomEpicWeapon", spawnPositions[5]) end
		if random(1, 100) <= 3 then ISM.SpawnItem("SAPOCBriefcaseClosed", spawnPositions[6]) end

		local dir, pos = direction, worldPos
		APCrash_RegisterAI(self, function(self)
			local vForwardOffset = { x = 0, y = 0, z = 0 }
			FastScaleVector(vForwardOffset, dir, 0)
			local vSpawnPos = { x = 0, y = 0, z = 0 }
			FastSumVectors(vSpawnPos, vForwardOffset, pos)

			local plan = {
				{ "BruteMutantSingle", 1 },
				{ "SpikerSingle",      1 },
				{ "CrazySingle",       1 },
				{ "HumanZombieSolo",   3 },     -- bajamos de 6 a 3
			}
			APCrash_SpawnWithBudget(vSpawnPos, plan, 10) -- CAP: 10 llamadas
		end)
	elseif roll <= 95 then
		-- HAZMAT (10%)
		spawnMany(spawnPositions, {
			{ what = "category", name = "RandomAirDropCrateRadiation", idx = 1 },
			{ what = "item",     name = "AirDropCrate",                idx = 2 },
		})
		if random(1, 100) <= 60 then ISM.SpawnCategory("AirPlaneCrashCrate", spawnPositions[3]) end
		if random(1, 100) <= 8 then ISM.SpawnCategory("RandomEpicWeapon", spawnPositions[4]) end

		local dir, pos = direction, worldPos
		APCrash_RegisterAI(self, function(self)
			local vForwardOffset = { x = 0, y = 0, z = 0 }
			FastScaleVector(vForwardOffset, dir, 0)
			local vSpawnPos = { x = 0, y = 0, z = 0 }
			FastSumVectors(vSpawnPos, vForwardOffset, pos)

			local plan = {
				{ "SpikerSingle",    2 },
				{ "HumanSpider",     1 },
				{ "HumanZombieSolo", 3 },      -- bajamos de 6 a 3
			}
			APCrash_SpawnWithBudget(vSpawnPos, plan, 9) -- CAP: 9 llamadas
		end)
	else
		-- JACKPOT (5%)
		spawnMany(spawnPositions, {
			{ what = "category", name = "AirPlaneCrashCrateMilitary", idx = 1 },
			{ what = "category", name = "AirPlaneCrashCrateMilitary", idx = 2 },
			{ what = "item",     name = "AirDropCrate",               idx = 3 },
		})
		if random(1, 100) <= 25 then ISM.SpawnCategory("RandomEpicWeapon", spawnPositions[4]) end
		if random(1, 100) <= 8 then ISM.SpawnItem("SAPOCBriefcaseClosed", spawnPositions[5]) end
		if random(1, 100) <= 40 then ISM.SpawnCategory("AirPlaneCrashBackpack", spawnPositions[6]) end

		local dir, pos = direction, worldPos
		APCrash_RegisterAI(self, function(self)
			local vForwardOffset = { x = 0, y = 0, z = 0 }
			FastScaleVector(vForwardOffset, dir, 0)
			local vSpawnPos = { x = 0, y = 0, z = 0 }
			FastSumVectors(vSpawnPos, vForwardOffset, pos)

			local plan = {
				{ "BruteMutantArmored", random(0, 1) },
				{ "BruteMutantSingle",  1 },
				{ "HumanSpiderSingle",  1 },
				{ "SpikerSingle",       1 },
				{ "HumanZombieSolo",    4 },    -- bajamos de 8 a 4
			}
			APCrash_SpawnWithBudget(vSpawnPos, plan, 12) -- CAP: 12 llamadas
		end)
	end
	D("Loot DONE id=%s", tostring(self.id))
end
