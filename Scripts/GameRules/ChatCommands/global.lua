ChatCommands["!say"] = function(playerId, command)
    Log(">> !say- %s", command)

    local player = System.GetEntity(playerId)
    local playerName = player:GetName()
    g_gameRules.game:SendTextMessage(4, 0, playerName.." "..command);

end

--ChatCommands["!DumpStorage"] = function(playerId)
--    local player = System.GetEntity(playerId)
--    -- the second param in GetStorageContent is required and acts to filter by item class set it to "" for all items
--    local PlayerInventory = g_gameRules.game:GetStorageContent(playerId,"AmcoinLedger")
--    -- check we dont have an empty storage
--    if PlayerInventory == (nil or {}) then
--        g_gameRules.game:SendTextMessage(4,playerId,"player has no Items")
--        return
--    end
--    -- Storage is Returned as a list of entityId, fetch the entity and display the Item
--    for idx,itemId in ipairs(PlayerInventory) do
--        local item = System.GetEntity(itemId)   
--        Log(item.item:GetStackCount());
--        Log("Item: " .. tostring(idx) .. " - "..tostring(item:GetName() or item.class))
--    end
--end



-- Teleport to safe zone 4850 4787 
ChatCommands['!zona'] = function(playerId)
    Log('>> !zona ');
    local player = System.GetEntity(playerId);

    if (cobrarAmcoin(playerId, 20)) then
    
        local rnd = random(1, 10)

        if rnd <= 1 then
            player.player:TeleportTo('4937 4715 142.8');
        elseif rnd <= 2 then
            player.player:TeleportTo('4928 4721 142.8');
        elseif rnd <= 3 then
            player.player:TeleportTo('4950 4705 142.8');
        elseif rnd <= 4 then
            player.player:TeleportTo('4915 4663 142.8');
        elseif rnd <= 5 then
            player.player:TeleportTo('4910 4685 142.8');
        elseif rnd <= 6 then
            player.player:TeleportTo('4892 4683 141.8');
        elseif rnd <= 7 then
            player.player:TeleportTo('4907 4712 142.8');
        elseif rnd <= 8 then
            player.player:TeleportTo('4895 4737 142.8');
        elseif rnd <= 9 then
            player.player:TeleportTo('4912 4718 142.8');
        elseif rnd <= 10 then
            player.player:TeleportTo('4960 4727 142.8');
        end

    end
end
--
---- Teleport to safe zone 
ChatCommands['!zone'] = function(playerId, command)
    Log('>> !zone - %s', command);
    local player = System.GetEntity(playerId);

    if (cobrarAmcoin(playerId, 20)) then
    
        local rnd = random(1, 10)

        if rnd <= 1 then
            player.player:TeleportTo('4937 4715 142.8');
        elseif rnd <= 2 then
            player.player:TeleportTo('4928 4721 142.8');
        elseif rnd <= 3 then
            player.player:TeleportTo('4950 4705 142.8');
        elseif rnd <= 4 then
            player.player:TeleportTo('4915 4663 142.8');
        elseif rnd <= 5 then
            player.player:TeleportTo('4910 4685 142.8');
        elseif rnd <= 6 then
            player.player:TeleportTo('4892 4683 141.8');
        elseif rnd <= 7 then
            player.player:TeleportTo('4907 4712 142.8');
        elseif rnd <= 8 then
            player.player:TeleportTo('4895 4737 142.8');
        elseif rnd <= 9 then
            player.player:TeleportTo('4912 4718 142.8');
        elseif rnd <= 10 then
            player.player:TeleportTo('4960 4727 142.8');
        end
    end

    
end



function cobrarAmcoin(playerId, costo)
    local itemsIds = g_gameRules.game:GetStorageContent(playerId,"AmcoinLedger")

    -- Recorro los itemIds para ver si todos los stack suman la cantidad requerida
    local total = 0;
    for idx,itemId in pairs(itemsIds) do 
        local item = System.GetEntity(itemId);
        Log(item.item:GetStackCount());
        total = total + item.item:GetStackCount();
    end
    -- Si tiene crédito para saldar
    if (total >= costo ) then
        Log('Tiene saldo');
        -- a descontar
        for key,itemId in pairs(itemsIds) do
            local item = System.GetEntity(itemId);

            if (item.item:GetStackCount() - costo > 0) then
                Log('Se descuenta de 1 montón');
                item.item:SetStackCount(item.item:GetStackCount() - costo);
                break;
            else
                costo = costo - item.item:GetStackCount();
                System.RemoveEntity(itemId);

                if (costo <= 0) then
                    break;
                end
            end
        end

        Log('Todo saldado');
        return true;
    else
        Log('NO tiene crédito')
        g_gameRules.game:SendTextMessage(4, playerId, "Se necesitan " .. costo ..  " AmcoinLedger." );
        return false;
    end    
end