-- spawn periódico
APOC_SpawnEveryMs = APOC_SpawnEveryMs or (30 * 60 * 1000) -- 30 minutos
APOC_SpawnTimerId = APOC_SpawnTimerId or nil

function itemPlace()
    local spawnPos = { x = 4912, y = 4717, z = 142 } -- tu posición base
    -- alinea a terreno (barato y seguro)
    local te = System.GetTerrainElevation(spawnPos)
    if te and te > -1000 then
        spawnPos.z = te + 0.7
    end

    local ent = ISM.SpawnItem("AirDropCrate", spawnPos)
    Log(string.format("[MOD] AirDropCrate @ (%.1f, %.1f, %.1f) id=%s",
        spawnPos.x, spawnPos.y, spawnPos.z, tostring(ent and ent.id)))

    -- mensaje opcional, corto (pantalla chica)
    -- g_gameRules.game:SendTextMessage(4, 0, "Airdrop listo ✓")
end

function itemLoop()
    if not CryAction.IsDedicatedServer() then return end

    itemPlace()
    APOC_SpawnTimerId = Script.SetTimerForFunction(APOC_SpawnEveryMs, "itemLoop", _G)
end

function itemSpawn()
    if CryAction.IsDedicatedServer() then
        if APOC_SpawnTimerId then
            Script.KillTimer(APOC_SpawnTimerId)
            APOC_SpawnTimerId = nil
        end

        -- 10s para asegurar que todo cargó; usa _G (no hay 'self' aquí)
        APOC_SpawnTimerId = Script.SetTimerForFunction(10000, "itemLoop", _G)
    end
end

-- registra cuando todo está cargado
RegisterCallback(_G, "OnInitAllLoaded", nil, itemSpawn)
