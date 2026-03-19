ChatCommands = ChatCommands or {}

-- ============ SAY (broadcast compacto) ============
local function _say(playerId, command)
    Log(string.format(">> !say - %s", tostring(command)))
    local player = System.GetEntity(playerId)
    local name = (player and player.GetName and player:GetName()) or "Player"
    local msg = tostring(command or ""):gsub("^%s+", "")
    if msg == "" then
        g_gameRules.game:SendTextMessage(4, playerId, "Uso: !say <texto>")
        return
    end
    if #msg > 120 then msg = msg:sub(1, 120) .. "…" end
    g_gameRules.game:SendTextMessage(4, 0, "[ALL] " .. name .. ": " .. msg)
end

ChatCommands["!say"] = _say
ChatCommands["/say"] = _say
ChatCommands["say"]  = _say

-- ============ ZONA / ZONE (TP aleatorio, -20 AMC) ============
local SAFEZONE       = {
    '4937 4715 142.8', '4928 4721 142.8', '4950 4705 142.8', '4915 4663 142.8', '4910 4685 142.8',
    '4892 4683 141.8', '4907 4712 142.8', '4895 4737 142.8', '4912 4718 142.8', '4960 4727 142.8'
}

local function _zone(playerId, command)
    Log(string.format(">> !zone - %s", tostring(command)))
    local player = System.GetEntity(playerId)
    if not player or not player.player then
        g_gameRules.game:SendTextMessage(4, playerId, "No disponible ahora")
        return
    end

    if not cobrarAmcoin(playerId, 20) then
        -- cobrarAmcoin ya envía mensaje; aquí solo reforzamos breve
        g_gameRules.game:SendTextMessage(4, playerId, "Necesitas 20 AMC")
        return
    end

    local idx = math.random(1, #SAFEZONE)
    player.player:TeleportTo(SAFEZONE[idx])
    g_gameRules.game:SendTextMessage(4, playerId, "TP Zona Segura OK (-20 AMC)")
end

ChatCommands['!zona'] = _zone
ChatCommands['/zona'] = _zone
ChatCommands['zona']  = _zone
ChatCommands['!zone'] = _zone
ChatCommands['/zone'] = _zone
ChatCommands['zone']  = _zone

-- ============ Cobro de Amcoin (robusto + mensajes cortos) ============
function cobrarAmcoin(playerId, costo)
    local cobro = tonumber(costo) or 0
    if cobro <= 0 then return true end

    local itemsIds = g_gameRules.game:GetStorageContent(playerId, "AmcoinLedger") or {}
    local total = 0

    -- suma de stacks (tolerante a nil)
    for i = 1, #itemsIds do
        local item = System.GetEntity(itemsIds[i])
        local stack = (item and item.item and item.item.GetStackCount and item.item:GetStackCount()) or 0
        total = total + stack
    end

    if total < cobro then
        Log(string.format("Amcoin: saldo insuficiente total=%d requerido=%d", total, cobro))
        g_gameRules.game:SendTextMessage(4, playerId, "Saldo insuficiente: " .. total .. "/" .. cobro .. " AMC")
        return false
    end

    -- descuento
    local restante = cobro
    for i = 1, #itemsIds do
        local id = itemsIds[i]
        local it = System.GetEntity(id)
        local stack = (it and it.item and it.item:GetStackCount()) or 0

        if stack > restante then
            it.item:SetStackCount(stack - restante)
            restante = 0
            break
        else
            restante = restante - stack
            if id then System.RemoveEntity(id) end
            if restante <= 0 then break end
        end
    end

    Log(string.format("Amcoin: cobro OK %d AMC", cobro))
    g_gameRules.game:SendTextMessage(4, playerId, "Pago OK: " .. cobro .. " AMC")
    return true
end
