--- Initialises OpenableCondition Handling this is run automaticaly by mFramework
function mInitCustomOpenableConditions()
    --- global table to store conditions
    g_CustomOpenableConditions = {}


    --- method  to Set an entities OpenableConditions.
    ---@param class table class to apply openable conditions to
    ---@param condition table condition definition
    mSetOpenableCondition = function(class, condition)
        if assert_arg(1, class, 'string') then return false, 'you must pass a class or "global"' end
        if assert_arg(2, condition, 'table') then
            return false, 'didnt provide a condition'
        elseif type(condition['name']) ~= 'string' then
            return false, 'your condition must specify a name (condition.name)'
        elseif type(condition['func']) ~= 'function' then
            return false, 'your condition must specify a function (condition.func)'
        end

        local ConditionList = (g_CustomOpenableConditions[class] or {})
        InsertIntoTable(ConditionList, condition)
        g_CustomOpenableConditions[class] = ConditionList
    end
    --- method  to Check an entities OpenableConditions.
    mGetOpenableCondition = function(entity, ...)
        if (type(entity) ~= 'table') or (type(entity['class']) ~= 'string') then return false, 'Not an Entity' end
        local ConditionList = g_CustomOpenableConditions['global'] or {}
        local ClassConditions = g_CustomOpenableConditions[entity['class']] or {}
        local Openable = true
        local failCondition = 'Conditions Passed'
        for _, condition in ipairs(ConditionList) do
            local ConditionOk = condition['func'](entity, ...)
            if ConditionOk == false then
                failCondition = condition['name']
                Openable = false
                break
            end
        end
        if Openable then
            for _, condition in ipairs(ClassConditions) do
                local ConditionOk = condition['func'](entity, ...)
                if ConditionOk == false then
                    failCondition = condition['name']
                    Openable = false
                    break
                end
            end
        end
        return Openable, failCondition
    end
end

function mCustomisePlayerOpenableConditions()
    if g_CustomOpenableConditions then
        function Player.CheckEntityOpenable(self,target)
            return mGetOpenableCondition(target) or true
        end
    end
end

-- =====test======--
-- mInitCustomOpenableConditions()
-- local ent = {class = 'advBase_mBank_Atm', openable = false}

-- mSetOpenableCondition("global",
--     {
--         name = 'allPass', func =
--         function(entity)
--             print("check condition 1")
--             --do nothing and return true
--             return true
--         end
--     }
-- )
-- mSetOpenableCondition("advBase_mBankAtm",
--     {
--         name = 'allFail', func =
--         function(entity)
--             print("check condition 2")
--             -- do nothing and return false
--             return false
--         end
--     }
-- )

-- print(mGetOpenableCondition(ent,{}))