ChatCommands['!PM'] = function(playerId, command)
    local player = System.GetEntity(playerId)
    local self = mFramework.ChatCommand()
    self.Name = 'mFramwork PlayerManager'
    self.Usage = ' !PM {list|setrank|help} {params}'
    self.AuthorisedRanks = {'Admin'}
    self.command = {
        default = function(self, player, param)
            -- DefaultAction
            self:ShowUsage(player)
        end,
        help = function(self, player, param)
            -- Handle Command Help
            local msg = '!PM command provides basic PlayerManagement\n valid options are list and setrank'
            if param[1] == 'list' then
                msg = ' !PM list [filter] string - list Online Players\n' .. ' optional: filter by name, rank, steamId\n' ..
                          ' example: "!PM list name Player1"  Note:(case sensitive)'
            elseif param[1] == 'setrank' then
                msg = ' !PM setrank [name or steamId] [RankName] - set a players rank\n' ..
                          ' You Can pass a Name or SteamID but it must be an Exact Match'
            end
            g_gameRules.game:SendTextMessage(4, player.id, msg)
        end,
        setrank = function(self, player, param)
            local command = param[0]
            local filterstring = param[1]
            local rankName = param[2]
            if (mF_DEBUG) then
                mFramework.Debug('Command SetRank> Caller: ' .. player:GetName() .. ' - ' .. player.player:GetSteam64Id())
                Log('   - cmd detected: ' .. tostring(param[0]))
                Log('   - params: [1] ' .. tostring(param[1]) .. ' [2]' .. tostring(param[2]))
            end

            -- Ensure only 2 params Exist
            if param[3] then
                mFramework.Debug('   ERROR - Recieved invalid Param Count')
                g_gameRules.game:SendTextMessage(4, player.id, ' Invalid Parameter Count')
                self.ShowUsage(player)
                return
            else
                mFramework.Debug('   - Param Count OK')
                local OnlinePlayers = mPlayerManager:GetOnlinePlayers()
                local targetPlayer = nil
                if (mF_DEBUG) then
                    Log('Online Players:')
                    dump(OnlinePlayers, nil, 0)
                end
                if (OnlinePlayers) then
                    mFramework.Debug('  Using Filter: ' .. tostring(filterstring))
                    for _, v in pairs(OnlinePlayers) do
                        if (v.Name == filterstring) or (v.steamId == filterstring) then
                            mFramework.Debug('  - Filter Matched Player: ' .. v.Name .. ' - ' .. v.steamId)
                            targetPlayer = System.GetEntity(v.playerId)
                        end
                    end
                    if (targetPlayer) then
                        mFramework.Debug('  Validating Provided Rank: ' .. rankName)
                        if (rankName == 'none') then
                            mFramework.Debug('  Clearing rank for player: ' .. filterstring)
                            g_gameRules.game:SendTextMessage(4, player.id, ' Clearing rank for Player: ' .. filterstring)
                            return targetPlayer:mSetPlayerData('ServerRankID', nil)
                        else
                            local newRank = mFramework.ServerRanks:GetRank('Name', rankName)
                            if (not newRank) or (not newRank.ID) then
                                if (mF_DEBUG) then
                                    mFramework.Debug('   - Failed to Find Rank: ' .. tostring(rankName))
                                    Log('newRank is:')
                                    dump(newRank)
                                end
                                g_gameRules.game:SendTextMessage(4, player.id, ' Invalid Rank')
                            else
                                mFramework.Debug('  - Found Rank: ' .. tostring(rankName) .. ' RankID:' .. tostring(newRank.ID))
                                g_gameRules.game:SendTextMessage(
                                    4, player.id, ' Setting Rank for Player: ' .. targetPlayer:GetName() .. ' - ' ..
                                        targetPlayer.player:GetSteam64Id()
                                )

                                mFramework.Debug(
                                    '  trying to Set Player Rank to: ' .. tostring(newRank.Name) .. ' ID: ' ..
                                        tostring(newRank.ID)
                                )
                                return targetPlayer:mSetServerRank(newRank.ID)
                            end
                        end
                    else
                        mFramework.Debug('  Unable to find Player' .. filterstring)
                        g_gameRules.game:SendTextMessage(4, player.id, ' Unable to find Player: ' .. filterstring)
                    end
                end
            end
        end,
        list = function(self, player, param)
            local _command = param[0]
            local filter = param[1]
            local filterstring = param[2]
            if param[3] then
                g_gameRules.game:SendTextMessage(4, player.id, ' Invalid Parameter Count')
                self.ShowUsage(player)
                return
            else
                for k, v in pairs(mPlayerManager:GetOnlinePlayers()) do
                    local foundPlayer = true
                    if filter and filterstring then
                        if (filter == 'name') then
                            if (not string.find(v.Name, filterstring)) then foundPlayer = false end
                        elseif (filter == 'steamId') then
                            if (not string.find(v.steamId, filterstring)) then foundPlayer = false end
                        elseif (filter == 'rank') then
                            if (not string.find(v.ServerRank, filterstring)) then foundPlayer = false end
                        end
                    end
                    if (foundPlayer) then
                        local playerRank = function()
                            if (v.ServerRank) then
                                return v.ServerRank:GetName()
                            else
                                return nil
                            end
                        end
                        local playerInfo =
                            ' [' .. tostring(k) .. ' ] Player: ' .. tostring(v.Name) .. ' (' .. tostring(v.steamId) .. ')'
                        local playerInfo2 = '   -- isOwner: ' .. tostring(v.IsOwner or 'No') .. ' ServerRank: ' ..
                                                tostring(playerRank() or 'None')
                        g_gameRules.game:SendTextMessage(4, player.id, playerInfo .. '\n' .. playerInfo2)
                    end
                end
            end
        end,
    }

    if (player:isPlayerOwner()) or (self:AllowCommand(player)) then
        local action, params = self.getActionParams(command)
        return self:Continue(player, action, params)
    else
        g_gameRules.game:SendTextMessage(0, playerId, ' >> NOT AUTHORISED')
    end
end
