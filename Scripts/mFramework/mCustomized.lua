--- @script mCustomized
--- @author Theros   ~ Discord: Theros#7648, Site: https://svaltek.xyz.
-- * Scripts/mFramework/mCustomized.lua ,
-- Provides Methods used for Custom Entity/Action Support.
if not g_mReExposeIndex then g_mReExposeIndex = {} end

function ReExposeAllRegistered()
    for k, v in pairs(g_mReExposeIndex) do
        Log('ReExposing: ' .. tostring(k))
        _G[k] = mergef(_G[k], v.methods, true)
        ---Expose
        local e = v.expose
        Net.Expose {
            Class = _G[k],
            ServerProperties = e.ServerProperties,
            ServerMethods = e.ServerMethods,
            ClientMethods = e.ClientMethods,
        }
    end
end

local function RegisterForReExpose(exposeData)
    -- ReExpose Data
    local classToExpose = exposeData['class']
    local thisEntity = new(_G[classToExpose])

    -- Fetch any existing cached ReExpose for this class and merge
    local ReExposeCache = (g_mReExposeIndex[classToExpose] or {methods = {}, expose = {}})
    thisEntry = {
        methods = mergef(ReExposeCache.methods, exposeData['methods'], true),
        expose = mergef(ReExposeCache.expose, exposeData['expose'], true),
    }
    g_mReExposeIndex[classToExpose] = mergef(thisEntity, thisEntry, true)
    return true, 'Registered'
end

--- mReExpose: Merges new Methods and ReExposes the Provided Class
---@param c string   Class to ReExpose
---@param m table   Your Method Table
---@param e table   Your Expose Table
function mReExpose(c, m, e)
    if (not type(c) == 'string') or (not _G[c]) then
        return nil, 'Invalid Class or None provided'
    elseif (not type(m) == 'table') then
        return nil, 'Invalid Method table or None Provided'
    elseif (not type(e) == 'table') then
        return nil, 'Invalid Expose table or None Provided'
    else
        if (not e.ServerMethods) then
            return nil, 'Your Expose Table MUST Contain the ServerMethods table'
        elseif (not e.ClientMethods) then
            return nil, 'Your Expose Table MUST Contain the ClientMethods table'
        elseif (not e.ServerProperties) then
            return nil, 'Your Expose Table MUST Contain the ServerProperties table'
        else
            Log('Class: %s registered for ReExpose.', tostring(c))
            return RegisterForReExpose {class = c, methods = m, expose = e}
        end
    end
end

--- @section Main
-- Various usefull Methods.

local function clone_function(fn)
    local dumped = string.dump(fn)
    local cloned = loadstring(dumped)
    local i = 1
    while true do
        local name, value = debug.getupvalue(fn, i)
        if not name then break end
        debug.setupvalue(fn, i, value)
        i = i + 1
    end
    return cloned
end

function mInitCustomActions()
    -- ─── mCustomItem ────────────────────────────────────────────────────────────────
    --	    Allows for Mods to Create and Handle CustomActions
    -- ─────────────────────────────────────────────────────────────────── Theros ────
    if (Item) then
        if (not Item.OnActionPerformed) then
            Item.OnActionPerformed = function(itemId, playerId, action)
                if (rDebug) then
                    Log('Item.OnActionPerformed() > ' .. ((System.GetEntity(itemId)):GetName() or 'Unknown'))
                    Log('Player: ' .. ((System.GetEntity(playerId)):GetName() or 'Unknown'))
                    Log('Action: ' .. tostring(action or 'None'))
                end
                return
            end
        end
        if (not MakeActionsCustomizable) then
            --- sets up CustomAction support for an item, this needs to bedone first
            ---@param classname string  name of class - same as global table eg 'AKM' 'AppleFresh'
            ---@param disableVanilla boolean if true will prevent the default vanilla actions from being show ingame
            function MakeActionsCustomizable(classname, disableVanilla)
                if (not type(classname) == 'string') then return nil end
                local item = _G[classname]
                if (not item) or (not item.GetActions) then
                    Log('$3 - Item: ' .. classname .. 'not Actionable or ItemTable not found')
                    return nil
                end
                Log('')
                Log(' ======= Initialising CustomActions for Item: ' .. tostring(classname) .. ' =======')
                if disableVanilla then Log('   - Vanilla Actions are being disabled for this item.!') end

                -- ────────────────────────────────────────────────────────────────────────────────
                -- ? CustomAction Support
                -- >> the `CustomActions` table is used to store Mod Registered
                -- >> Actions for each item
                if (not item.CustomActions) then
                    item.CustomActions = {}
                    -- disableVanillaAction support
                    -- Set disableVanillaActions var in Item.Properties
                    if disableVanilla then item.Properties['disableVanillaActions'] = true end
                end
                item.GetCustomActions = function(self)
                    local actions = {}
                    for k, _ in pairs(self.CustomActions) do table.insert(actions, k) end
                    return actions
                end
                item.GetActions = function(self, user)
                    local actions = {}
                    -- disableVanillaAction support
                    -- Check VanillaActions havent been disabled for this item
                    if (not item.Properties.disableVanillaActions) then
                        actions = {}
                        if self.item and type(self.item.GetActions) == 'function' then
                            actions = self.item:GetActions(user.id, actions)
                        else
                            actions = (g_gameRules.game:GetActions(user.id, self.id, actions) or {})
                        end

                        if table.getn(actions) < 1 then
                            if (type(self.Properties.UseMessage) == 'string') then
                                table.insert(actions, self.Properties.UseMessage)
                            end
                        end
                    end
                    -- >> Get Actions Registered by Mods
                    local CustomActions = self:GetCustomActions()
                    if (CustomActions) then for _, v in pairs(CustomActions) do table.insert(actions, v) end end
                    return actions
                end
                local rememberOrg = clone_function(item.PerformAction)
                item.PerformAction = function(self, user, action)
                    local CustomAction = self.CustomActions[action]
                    if (type(CustomAction) == 'function') then
                        return CustomAction(self, user, action)
                    else
                        if rememberOrg and type(rememberOrg) == 'function' then
                            return rememberOrg(self, user, action)
                        else
                            return g_gameRules.game:PerformActionAction(user.id, self.id, action)
                        end
                    end
                end

                return item
            end
        end
        if (not RegisterCustomActionForItem) then
            ---* Registers a CustomAction for the Specified Item (name)
            ---@param classname string name/key of items global itemTable - eg: "AKM" for AKM (itemTable _G["AKM"])
            ---@param action string the name of the action to be displayed in actionMenu
            ---@param func any the Function assigned to this ActionHandler
            --[[
                example:
                    RegisterCustomActionForItem("AKM","GetInfo",function(self,player,action)
                        Log("Player " .. player:GetName() .. " Requested ItemInfo for: " .. self:GetName())
                        dump(self)
                    end)
            ]]
            function RegisterCustomActionForItem(classname, action, func)
                if (not type(classname) == 'string') then return nil end
                local item = _G[classname]
                if (not item) or (not item.GetActions) then
                    Log('$3 - Item: ' .. classname .. 'not Actionable or ItemTable not found')
                    return nil
                end
                Log('> Registering CustomAction: ' .. action .. ' for Item: ' .. classname)

                -- if MakeActionsCustomizable was not run for this Item this will fail
                if (not item.CustomActions) then return nil, 'Item Actions not Customizable or Item not Exist' end
                -- add this action
                item.CustomActions[tostring(action)] = func
                return true, 'Action Registered'
            end
        end
        if (not RegisterServerListenerForItem) then
            function RegisterServerListenerForItem(classname)
                if (not type(classname) == 'string') then return nil end
                local item = _G[classname]
                if (not item) or (not item.GetActions) then
                    Log('$3 - Item: ' .. classname .. 'not Actionable or ItemTable not found')
                    return nil, 'Class not Found: ' .. classname
                end

                Log('> Registering ServerListener for Item: ' .. classname)

                if (not item.Server.OnClActionPerformed) then
                    item.Server.OnClActionPerformed = function(self, itemId, userId, action)
                        return _G['Item'].OnActionPerformed(itemId, userId, action)
                    end
                    item.Expose = function(self)
                        return Net.Expose {
                            Class = self,
                            ClientMethods = {},
                            ServerMethods = {OnClActionPerformed = {RELIABLE_ORDERED, POST_ATTACH, ENTITYID, ENTITYID, STRING}},
                            ServerProperties = {},
                        }
                    end
                end

                if (CryAction.IsClient()) then
                    RegisterCallbackReturnAware(
                        item, 'PerformAction', nil, function(self, ret, user, action)
                            self.server:OnClActionPerformed(self.id, user.id, action)
                            return ret
                        end
                    )
                end
                return item:Expose()
            end
        end
    end
end