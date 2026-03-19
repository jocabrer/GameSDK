--
-- ────────────────────────────────────────────────────────────────────────── I ──────────
--   :::::: M F R A M E W O R K   L O A D E R : :  :   :    :     :        :          :
-- ────────────────────────────────────────────────────────────────────────────────────
--
-- >> Load Common Scripts.
Script.ReloadScript('scripts/mFramework/Common.lua')

local function initFramework()
    --- Call mFramework:init
    Script.ReloadScript('scripts/mFramework/init.lua')
    if mFramework then mFramework:init() end
end

local function initCustomEntity()
    -- >> Reload CustomEntity Scripts.
    Script.ReloadScript('scripts/mFramework/mCustomized.lua')
    Script.LoadScriptFolder('scripts/mFramework/CustomEntities', true, true)
    -- >> Run the ReExpose Cycle to Expose all Cached CustomEntities at once.
    ReExposeAllRegistered()
end

local function initCustomAction()
    -- >> Create Methods needed for CustomActions to Function.
    mInitCustomActions()
    -- >> Reload CustomAction Scripts.
    Script.LoadScriptFolder('scripts/mFramework/CustomActions')
end

local function initCustomOpenableConditions()
    -- >> Reload CustomOpenableCondition Scripts.
    Script.ReloadScript('scripts/mFramework/mOpenableConditions.lua')
    -- >> Create Methods needed for CustomOpenableConditions to Function.
    mInitCustomOpenableConditions()
    mCustomisePlayerOpenableConditions()
end

RegisterCallback(
    _G, 'OnInitPreLoaded', nil, function()
        -- ! Make sure These only Get Called once
        -- >> stops weird things happening in editor.
        OnlyRunOnce(initFramework)
        OnlyRunOnce(initCustomEntity)
        ClientOnly(initCustomOpenableConditions)
    end
)

local function InitAsyncTasks() if DynamicServer then DynamicServer:Start() end end

RegisterCallback(
    _G, 'OnInitAllLoaded', nil, function()
        -- ! Its important this only Ever gets called Once
        -- >> we dont want multiple AsyncTask threads running at the same time. Re: performance.
        OnlyRunOnce(initCustomAction)
        OnlyRunOnce(InitAsyncTasks)
        ServerOnly(
            function()
                System.RemoveCCommand('map')
                System.AddCCommand('map', 'mF_eval(%1)', '')
            end
        )
    end
)
