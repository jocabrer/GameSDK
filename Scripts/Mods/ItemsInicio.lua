-- una sola vez por arranque
APOC_FirstSpawnDone = APOC_FirstSpawnDone or false

function itemPlace()
    if APOC_FirstSpawnDone then return end

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

    APOC_FirstSpawnDone = true
end

function itemSpawn()
    if CryAction.IsDedicatedServer() then
        -- 10s para asegurar que todo cargó; usa _G (no hay 'self' aquí)
        Script.SetTimerForFunction(10000, "itemPlace", _G)
    end
end

-- registra cuando todo está cargado
RegisterCallback(_G, "OnInitAllLoaded", nil, itemSpawn)
