if (not MisDB) then Script.ReloadScript('scripts/MisDB/MisDB.lua') end

mF_DEBUG = false

local doLog = function(tag, message) Log('[%s]> %s', tag, tostring(message)) end
if (not mFramework) then
    mFramework = {
        BaseDir = 'mFramework/',
        StorageDir = 'PersistantStorage',
        Config = {},
        classes = {},
        plugins = {},
        modules = {},
        --- mFramework Log
        ---@param message string
        Log = function(message) doLog('mFramework', message) end,
        --- mFramework DEBUGLOG if mF_DEBUG = true
        ---@param message string
        Debug = function(message) if (mF_DEBUG == true) then doLog('mFramework:DEBUG', message) end end,
    }
end

if (not g_mEventHandlers) then g_mEventHandlers = {} end

Script.ReloadScript('scripts/mFramework/Common.lua')
Script.LoadScriptFolder('scripts/mFramework/Modules', true, true)
mFramework.Events = require('mFramework.Events')
mFramework.Callbacks = {}
_G['mTypes'] = require('mFramework.mTypes')
_G['mConsole'] = require('mFramework.ConsoleHelper')

function mFramework:init()
    ServerOnly(
        function()
            local function LoadServer()
                local fs = require('mFramework.FS')
                local configReader = require('mFramework.configReader')
                Script.LoadScriptFolder('scripts/mFramework/classes')
                local BASEDIR = './mFramework'
                local cfgFile = fs.joinpath(BASEDIR, 'settings.cfg')
                if Exists(cfgFile) then
                    local configFile = configReader.read(cfgFile)
                    local mFrameworkConfig = {}
                    for k, v in pairs(configFile) do
                        local value = v
                        if type(v) == 'string' then
                            value = clean_quotes(v) -- Clean any Exccess quotes from configReader
                        elseif type(v) == 'table' then
                            for subK, subV in pairs(v) do
                                value[subK] = clean_quotes(subV)
                            end
                        end
                        mFrameworkConfig[k] = value
                    end

                    if mFrameworkConfig ~= ({} or nil) then
                        if mFramework.Config ~= ({} or nil) then
                            mFramework.Config = mergef(mFramework.Config, mFrameworkConfig, true)
                        end
                    end
                end
                if (not mFramework.PersistantStorage) then
                    Log('======= mFramework Initialising PersistantStorage =======')
                    mFramework.PersistantStorage = MisDB:Create(mFramework.BaseDir, mFramework.StorageDir)
                    if (not mFramework.PersistantStorage) then
                        Log('$3 ERROR -- mFramework Failed to Init PersistantStorage')
                    else
                        Log('$4 SUCCESS -- mFramework Initialised PersistantStorage')
                    end
                end
                ServerOnly(
                    function()
                        --- Start Server Manager
                        Script.LoadScriptFolder('scripts/mFramework/Plugins/ServerRanks')
                        mFramework.ServerRanks:InitServerRanks()
                        --- Start PlayerManager
                        Script.LoadScriptFolder('scripts/mFramework/Plugins/PlayerManager')
                        mPlayerManager:InitPlayerManager()
                        --- Start AuthManger
                        Script.LoadScriptFolder('scripts/mFramework/Plugins/AuthManager')
                        --- Init DiscordIntegration
                        Script.LoadScriptFolder('scripts/mFramework/Plugins/DiscordIntegration')
                    end
                )
                Script.LoadScriptFolder('scripts/mFramework/Plugins', true, true)

            end
            OnlyRunOnce(LoadServer)
        end
    )
    Script.LoadScriptFolder('scripts/mFramework/EventHandlers', true, true)
end
