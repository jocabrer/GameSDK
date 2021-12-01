--- @script Common
--- @author Theros   ~ Discord: Theros#7648, Site: https://svaltek.xyz.
-- * Scripts/mFramework/Common.lua ,
-- Various Common Methods used throughout mFramework.
-- Various usefull Methods.
DIR_SEPERATOR = _G['package'].config:sub(1, 1)

if not g_Script_RunOnceCache then g_Script_RunOnceCache = {} end

-- @function OnlyRunOnce
---* Function Wrapper Explicitly ensures the Provided Function Only Runs Once (Does not work with anon funcs)
---@param f function
-- function to run
-- all Further parameters are passed to the Provided Function call.
function OnlyRunOnce(f, ...)
    local found
    for k, v in ipairs(g_Script_RunOnceCache) do if (v == f) then found = true end end
    if not found then
        table.insert(g_Script_RunOnceCache, f)
        return f(...)
    end
end

-- @function ServerOnly
---* Function Wrapper Explicitly ensures the Provided Function Only Runs on Server.
---@param f function
-- function to run
-- all Further parameters are passed to the Provided Function call.
function ServerOnly(f, ...) if System.IsEditor() or CryAction.IsDedicatedServer() then return f(...) end end

-- @function ClientOnly
---* Function Wrapper Explicitly ensures the Provided Function Only Runs on Client.
---@param f function
-- function to run
-- all Further parameters are passed to the Provided Function call.
function ClientOnly(f, ...) if System.IsEditor() or CryAction.IsClient() then return f(...) end end

function ScriptDir() return debug.getinfo(2).source:match('@?(.*/)') end

--- expand a string containing any `${var}` or `$var`.
--- Substitution values should be only numbers or strings.
--- @param s string the string
--- @param subst any either a table or a function (as in `string.gsub`)
--- @return string expanded string
function string_expand(s, subst)
    local res, k = s:gsub('%${([%w_]+)}', subst)
    if k > 0 then return res end
    return (res:gsub('%$([%w_]+)', subst))
end

---* bind an argument to a type and throw an error if the provided param doesnt match at runtime.
-- Note this works in reverse of the normal assert in that it returns nil if the argumens provided are valid
-- if not the it either returns true plus and error message , or if it fails to grab debug info just true.
--- @param idx number
-- positonal index of the param to bind
--- @param val any the param to bind
--- @param tp string the params bound type
--- @usage
-- local test = function(somearg,str,somearg)
-- if assert_arg(2,str,'string') then
--    return
-- end
--
-- test(nil,1,nil) -> Invalid Param in [test()]> Argument:2 Type: number Expected: string
function assert_arg(idx, val, tp)
    if type(val) ~= tp then
        local fn = debug.getinfo(2, 'n')
        local msg = 'Invalid Param in [' .. fn.name .. '()]> ' ..
                        string.format('Argument:%s Type: %q Expected: %q', tostring(idx), type(val), tp)
        local test = function() error(msg, 4) end
        local rStat, cResult = pcall(test)
        if rStat then
            return true
        else
            LogError(cResult)
            return true, cResult
        end
    end
end

local function import_symbol(T, k, v, libname)
    local key = rawget(T, k)
    -- warn about collisions!
    if key and k ~= '_M' and k ~= '_NAME' and k ~= '_PACKAGE' and k ~= '_VERSION' then
        Log('warning: \'%s.%s\' will not override existing symbol\n', libname, k)
        return
    end
    rawset(T, k, v)
end

local function lookup_lib(T, t)
    for k, v in pairs(T) do if v == t then return k end end
    return '?'
end

local already_imported = {}

---* take a table and 'inject' it into the local namespace.
--- @param t table
-- The Table
--- @param T  table
-- An optional destination table (defaults to callers environment)
function import(t, T)
    T = T or _G
    if type(t) == 'string' then t = require(t) end
    local libname = lookup_lib(T, t)
    if already_imported[t] then return end
    already_imported[t] = libname
    for k, v in pairs(t) do import_symbol(T, k, v, libname) end
end

--- Make an Object Callable.
function MakeCallable(obj) return function(...) return obj(unpack(...)) end end

-- @function rDebug
---* You can use this as a debugmode check and enable it via setting you sv_url to `DEBUG` via Rcon
function rDebug()
    if System.GetCVar('sv_url') == 'DEBUG' then
        return true
    else
        return nil
    end
end

--- Used for patching CVars at runtime.
function PatchVars(vars)
    if (vars) then
        for key, value in pairs(vars) do
            local currentVal = System.GetCVar(key)
            if (currentVal ~= value) then
                Log(' - var: ' .. key .. ' Needs Patching')
                Log(' - Current = ' .. tostring(currentVal) .. ' -- New = ' .. tostring(value))
                System.SetCVar(key, value)
            else
                Log(' - var: ' .. key .. ' OK')
                Log(' - Current = ' .. tostring(currentVal) .. ' -- Expected = ' .. tostring(value))
            end
        end
    end
end

-- @function compose
---* Create a function composition from given functions.
-- any further functions as arguments get added to composition in order
--- @param f1 function
-- the outermost function of the composition
--- @param f2 function
-- second outermost function of the composition
--- @return function the composite function
function compose(f1, f2, ...)
    if select('#', ...) > 0 then
        local part = compose(f2, ...)
        return compose(f1, part)
    else
        return function(...) return f1(f2(...)) end
    end
end

-- @function bind
---* Create a function with bound arguments ,
-- The bound function returned will call func() ,
-- with the arguments passed on to its creation .
-- If more arguments are given during its call, they are ,
-- appended to the original ones .
-- `...` the arguments to bind to the function.
--- @param func function
-- the function to create a binding of
--- @return function
-- the bound function
function bind(func, ...)
    local saved_args = {...}
    return function(...)
        local args = {table.unpack(saved_args)}
        for _, arg in ipairs({...}) do table.insert(args, arg) end
        return func(table.unpack(args))
    end
end

-- @function bind_self
---* Create f bound function whose first argument is t ,
--  Particularly useful to pass a method as a function ,
-- Equivalent to bind(t[k], t, ...) ,
-- `...` further arguments to bind to the function.
--- @param t table Binding
-- The table to be accessed
--- @param k any Key
-- The key to be accessed
--- @return function BoundFunc
-- The binding for t[k]
function bind_self(t, k, ...) return bind(t[k], t, ...) end

function Class(base)
    local class = {}
    local class_mt = {
        __type = 'Object',
        __call = function(self, ...)
            self:new(...)
            return self
        end,
    }
    setmetatable(class, class_mt)

    if base then for k, v in pairs(base) do class[k] = v end end

    function class:new() return Class(self) end
    function class:extend()
        local obj = {}
        for k, v in pairs(self) do if k:find('__') == 1 then obj[k] = v end end
        obj.__index = obj
        obj.super = self
        setmetatable(obj, self)
        return obj
    end
    function class:implement(...)
        for _, cls in pairs({...}) do
            for k, v in pairs(cls) do if self[k] == nil and type(v) == 'function' then self[k] = v end end
        end
    end
    return class
end

---* Create a function that returns the value of t[k] ,
-- | The returned function is Bound to the Provided Table,Key.
--- @param t table      table to access
--- @param k any        key to return
--- @return function returned getter function
function bind_getter(t, k)
    return function()
        if (not type(t) == 'table') then
            return nil, 'Bound object is not a table'
        elseif (t == {}) then
            return nil, 'Bound table is Empty'
        elseif (t[k] == nil) then
            return nil, 'Bound Key does not Exist'
        else
            return t[k], 'Fetched Bound Key'
        end
    end
end

---* Create a function that sets the value of t[k] ,
---| The returned function is Bound to the Provided Table,Key ,
---| The argument passed to the returned function is used as the value to set.
--- @param t table       table to access
--- @param k table       key to set
--- @return function     returned setter function
function bind_setter(t, k)
    return function(v)
        if (not type(t) == 'table') then
            return nil, 'Bound object is not a table'
        elseif (t == {}) then
            return nil, 'Bound table is Empty'
        elseif (t[k] == nil) then
            return nil, 'Bound Key does not Exist'
        else
            t[k] = v
            return true, 'Set Bound Key'
        end
    end
end

---* Create a function that returns the value of t[k] ,
---| The argument passed to the returned function is used as the Key.
--- @param t table       table to access
--- @return function     returned getter function
function getter(t)
    if (not type(t) == 'table') then
        return nil, 'Bound object is not a table'
    elseif (t == {}) then
        return nil, 'Bound table is Empty'
    else
        return function(k) return t[k] end
    end
end

---* Create a function that sets the value of t[k] ,
---| The argument passed to the returned function is used as the Key.
--- @param t table       table to access
--- @return function     returned setter function
function setter(t)
    if (not type(t) == 'table') then
        return nil, 'Bound object is not a table'
    elseif (t == {}) then
        return nil, 'Bound table is Empty'
    else
        return function(k, v)
            t[k] = v
            return true
        end
    end
end

---* Check if a file or directory exists in path ,
---| Path is Relative to Server Root.
---@param path string path - the path to a file or directory to test
function Exists(path)
    local ok, err, code = os.rename(path, path)
    if not ok then
        if code == 13 then
            -- Permission denied, but it exists
            return true
        end
    end
    return ok, err
end

function isFile(path)
    local f = io.open(path, 'r')
    if f then
        f:close()
        return true
    end
    return false
end
-- Check if a directory exists path
function isDir(path)
    path = string.gsub(path .. '/', '//', '/')
    local ok, err, code = os.rename(path, path)
    if ok or code == 13 then return true end
    return false
end

function mkDir(path)
    local ok, Result = os.execute('mkdir ' .. path:gsub('/', '\\'))
    if not ok then
        return nil, 'Failed to Create ' .. path .. ' Directory! - ' .. Result
    else
        return true, 'Successfully Created ' .. path .. ' Directory!'
    end
end

---* Write file to Disk
---@param path string       path of file to Write, starts in Server root
---@param data any          File Contents to Write
---@return boolean,string   true,nil and a message
function WriteFile(path, data)
    local thisFile = assert(io.open(path, 'w'))
    if thisFile ~= nil then
        local fWritten = thisFile:write(data)
        thisFile:close()
        if fWritten ~= nil then
            return true, 'Success Writing File: <ServerRoot>/' .. path
        else
            return nil, 'Failed to Write Data to File: <ServerRoot>/' .. path
        end
    else
        return nil, 'Failed to Open file for Writing: <ServerRoot>/' .. path
    end
end

---* Read File from Disk
---@param path string      path of file to Write, starts in Server root
---@return boolean,any     true,nil and file content or message
function ReadFile(path)
    local thisFile, errMsg = io.open(path, 'r')
    if thisFile ~= nil then
        local fContent = thisFile:read('*all')
        thisFile:close()
        if fContent ~= '' or nil then
            return true, fContent
        else
            return nil, 'Failed to Read from File: ' .. path
        end
    else
        return nil, 'Error Opening file: ' .. path .. ' io.open returned:' .. errMsg
    end
end

---* Cleans Eccess quotes from input string
function clean_quotes(inputString)
    local result
    result = inputString:gsub('^"', ''):gsub('"$', '')
    result = result:gsub('^\'', ''):gsub('\'$', '')
    return result
end

function cmdSplit(pString, pPattern)
    local Table = {}
    local fpat = '(.-)' .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
        if s ~= 1 or cap ~= '' then table.insert(Table, cap) end
        last_end = e + 1
        s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
        cap = pString:sub(last_end)
        table.insert(Table, cap)
    end
    return Table
end

function parseArgs(command)
    local cmdLine = cmdSplit(command, ' ')
    local cmdChunks = {}
    local ix = 0
    for iChunk, cmdChunk in pairs(cmdLine) do
        if ix ~= 1 then
            cmdChunks['0'] = cmdChunk
            ix = 1
        else
            local aKey, aValue = cmdChunk:match('([^,]+)=([^,]+)')
            if aValue ~= nil then cmdChunks[aKey] = aValue end
        end
    end
    return cmdChunks
end

function mGetEntityInfo(ent)
    if (not ent) then return nil end
    local this_entity = System.GetEntity(ent)
    if (not this_entity) then return nil, 'Entity Not Found' end
    local ent_name = (this_entity:GetName() or 'Unknown')
    local ent_class = (this_entity.class or 'Unknown')
    local ent_id = tostring(this_entity.id)
    return '[Entity]> Name: ' .. ent_name .. ' { Class = ' .. ent_class .. ' EntityID = ' .. ent_id .. ' }'
end

--- find a player by name or steamId, supports partial matches
---| Case Sensitive,  ALLWAYS Verify correct player found.
---| local player = findPlayer {name = "playerName"}
---| local player = findPlayer {steamId = "29483048203948"}
---@param search string
---@return table|nil player
---@return string errormsg
function findPlayer(search)
    local players = System.GetEntitiesByClass('Player')
    for i, thisPlayer in pairs(players) do
        if search.name ~= nil then if string.find(thisPlayer:GetName(), search.name) then return thisPlayer end end
        if search.steamId ~= nil then
            if string.find(thisPlayer.player:GetSteam64Id(), search.steamId) then return thisPlayer end
        end
    end
    return nil, 'Player not Found'
end

---* rmiTablePayload, used for Serialising tables for use with rmi calls
---@param t any table or stringPayload to Serialise
---@param parse boolean if true then parse the given string to table or dump table to string when false
function rmiTablePayload(t, parse)
    if (not DumpTableAsLuaString) then
        Log(' - Reloading scripts/saveutils.lua')
        Script.ReloadScript('scripts/saveutils.lua', true, true)
    end
    if (not parse) then
        local retStr = tostring(DumpTableAsLuaString(t, 'StrSvPayload', true)):gsub('--Automatically dumped LUA table', '')
        return retStr:gsub('\n', '')
    else
        local thisPayload = loadstring('local ' .. t .. 'return StrSvPayload')
        local Payload = thisPayload()
        return Payload
    end
end

---* Quickly Initialise and Assign CustomActions for a Item Class.
---| Definition table defining your Actions eg `{["ActionName"] = function(self,player,action) --code end}`
---| Optional Set `serverHandler` true to Enable the ServerSide Handler (Callback) for this Item
---@param itemClass string Item Class your Creating Actions For
---@param customActions table
---@param serverHandler boolean
function mCustomizeActions(itemClass, customActions, serverHandler)
    local e_stat, e_reason
    local CustomItem, CustomItemMessage = MakeActionsCustomizable(itemClass)
    if CustomItem then
        Log('- Customizing Actions for Item: %s > %s', itemClass, (CustomItemMessage or 'OK'))
        for actionName, customAction in pairs(customActions) do
            if type(actionName) ~= 'string' then
                return nil, 'Invalid ActionName in customActions'
            elseif type(customAction) ~= 'function' then
                return nil, 'Invalid Handler in CustomAction: ' .. actionName
            end
            local CustomAction, e_mesg_action = RegisterCustomActionForItem(itemClass, actionName, customAction)
            if CustomAction then
                e_stat = true
                Log(
                    '>> Action Created, Result: %s -> %s', tostring(CustomAction or 'No Result'),
                    tostring(e_mesg_action or 'No Message')
                )
            else
                e_stat = false
                e_reason = 'Create Action Failed'
                Log(
                    '>> Failed to Create Action - Result: %s -> %s', tostring(CustomAction or 'No Result'),
                    tostring(e_mesg_action or 'No Message')
                )
            end
        end
        if serverHandler then
            local ServerListener, e_mesg_server = RegisterServerListenerForItem(itemClass)
            if ServerListener then
                e_stat = true
                Log(
                    '>> ServerListener Created, Result: %s -> %s', tostring(ServerListener or 'No Result'),
                    tostring(e_mesg_server or 'No Message')
                )
            else
                e_stat = false
                e_reason = 'Create Server Handler Failed'
                Log(
                    '>> Failed to Create ServerListener - Result: %s -> %s', tostring(ServerListener or 'No Result'),
                    tostring(e_mesg_server or 'No Message')
                )
            end
        end
        return e_stat, tostring(e_reason or 'OK')
    else
        Log(' -- Failed to Initalise mCustomAction for Class: %s', itemClass)
        return nil, 'Failed to Initalise mCustomAction for Class: ' .. itemClass
    end
end

function mRequireFile(filename)
    local oldPackagePath = package.path
    package.path = './' .. filename .. ';' .. package.path
    local obj = require(filename)
    package.path = oldPackagePath
    if obj then
        return obj, 'success loading file from ' .. filename
    else
        return nil, 'Failed to Require file from path ' .. filename
    end
end

---* Evaluate a Lua String
---| evaluates `eval_string` in Protected mode, Does nothing if the provided string ,
---| contains errors or is not a valid lua chunk
---@param eval_string string
---@return boolean success
---@return any result
function mF_eval(eval_string)
    if not type(eval_string) == 'string' then
        return
    else
        local eString = eval_string:gsub('%^%*', ','):gsub('%*%^', ',')
        local eval_func = function(s) return loadstring(s)() end
        return pcall(eval_func, eString)
    end
end

local WaitTimer = 5
_WaitFor_Timer = WaitTimer * 1000
_SvWaitFor_Timer = function(...) _WaitFor(...) end

---* Wait for something to return true
---| Provided a valid `conf` definition will wait for the provided function or lua chunck to return true
---| the provided `conf` table should contain
---|    {
---|        tag = "Give your _waitFor a name/description",
---|        --valid lua code or function call that must return true or nil
---|        check = "function() end",
---|        --a function to run when compleated and true
---|        func = function() end
---|    }
---@param conf table
function _WaitFor(conf)
    local thisClass, _eMsg = loadstring('if (not ' .. tostring(conf.check) .. ') then return nil else return true end')
    if (not thisClass) or (not thisClass()) then
        Log(
            tostring(conf.tag) .. ' > Waiting for: ' .. tostring(conf.check) .. ' timer: ' .. tostring(_WaitFor_Timer / 1000) ..
                's'
        )
        Log(tostring(conf.check) .. ' = ' .. tostring(thisClass() or 'Not Loaded'))
        Log(tostring(_eMsg or 'No Error'))
        return Script.SetTimerForFunction(_WaitFor_Timer, '_SvWaitFor_Timer', conf)
    else
        Log(' - ' .. tostring(conf.tag) .. ' >  No longer waiting for: ' .. tostring(conf.check))
        local _status, _return = pcall(conf.func)
        if (not _status) then
            Log(' - ' .. tostring(conf.tag) .. ' > Call Failed result: ' .. tostring(_return or 'No Return'))
        else
            Log(' - ' .. tostring(conf.tag) .. ' > Call Success result: ' .. tostring(_return or 'No Return'))
            return _return
        end
    end
end

---* Serialise a Table and deseriase back again
---| supports basic functions
---@param t table|string
-- input table or string to serialise or deserialise
---@param parse boolean
-- set to true to Deserialise/Parse the provided string
---@return string|table output
-- serialised table as a string OR deserialised string as a table
function SerialiseTable(t, parse)
    local szt = {}

    local function char(c) return ('\\%3d'):format(c:byte()) end
    local function szstr(s) return ('"%s"'):format(s:gsub('[^ !#-~]', char)) end
    local function szfun(f) return 'loadstring' .. szstr(string.dump(f)) end
    local function szany(...) return szt[type(...)](...) end

    local function sztbl(t, code, var)
        for k, v in pairs(t) do
            local ks = szany(k, code, var)
            local vs = szany(v, code, var)
            code[#code + 1] = ('%s[%s]=%s'):format(var[t], ks, vs)
        end
        return '{}'
    end

    local function memo(sz)
        return function(d, code, var)
            if var[d] == nil then
                var[1] = var[1] + 1
                var[d] = ('_[%d]'):format(var[1])
                local index = #code + 1
                code[index] = '' -- reserve place during recursion
                code[index] = ('%s=%s'):format(var[d], sz(d, code, var))
            end
            return var[d]
        end
    end

    szt['nil'] = tostring
    szt['boolean'] = tostring
    szt['number'] = tostring
    szt['string'] = szstr
    szt['function'] = memo(szfun)
    szt['table'] = memo(sztbl)

    function serialize(d)
        local code = {'local _ = {}'}
        local value = szany(d, code, {0})
        code[#code + 1] = 'return ' .. value
        if #code == 2 then
            return code[2]
        else
            return table.concat(code, '\n')
        end
    end
    if not parse then
        return serialize(t)
    else
        local ret = loadstring(t)
        if ret then return ret() end
    end
end

---* Used for Grabbing Data Logged to Console/Logfile from function `f` ,
-- this only grabs the Data Logged During the provdided function call ,
-- and returns Raw Log output.
---@param f function
-- a function to Rip Log Output from
-- any further parameters are passed to your function `f(...)`
---@return string
-- LogData - A string Containging Raw Captured Log Data
function mF_LogRipper(f, ...)
    local mode = nil
    if System.IsEditor() then
        mode = 0
    elseif (not System.IsEditor()) and (CryAction.IsDedicatedServer()) then
        mode = 1
    elseif (not System.IsEditor()) and (CryAction.IsClient()) then
        mode = 2
    end
    local function getFile(offset)
        local logfile = nil
        if mode == 0 then
            logfile = io.open('editor.log', 'r')
        elseif mode == 1 then
            logfile = io.open('server.log', 'r')
        elseif mode == 2 then
            logfile = io.open('game.log', 'r')
        end
        if logfile then
            if offset then logfile:seek('set', offset) end
            return logfile
        end
    end
    local _logfile = getFile()
    if _logfile then
        local filepos = _logfile:seek('end')
        _logfile:close()
        f(...)
        if filepos then
            local logfile = getFile(filepos)
            if logfile then
                local fileRip = logfile:read('*all')
                logfile:close()
                if fileRip then return fileRip end
            end
        end
        return nil
    end
end

local charset = {}
do -- [0-9a-zA-Z]
    for c = 48, 57 do table.insert(charset, string.char(c)) end
    for c = 65, 90 do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

function strRandom(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock() ^ 5)
    return strRandom(length - 1) .. charset[math.random(1, #charset)]
end

function Dec2Hex(nValue)
    if type(nValue) == 'string' then nValue = tonumber(nValue) end
    local nHexVal = string.format('%X', nValue) -- %X returns uppercase hex, %x gives lowercase letters
    local sHexVal = nHexVal .. ''
    return sHexVal
end

function Hex2Dec(someHexString) return tonumber(someHexString, 16) end

local function Invoker(links, index)
    return function(...)
        local link = links[index]
        if not link then return end
        local continue = Invoker(links, index + 1)
        local returned = link(continue, ...)
        if returned then returned(function(_, ...) continue(...) end) end
    end
end

---* used to chain multiple functions/callbacks
-- Example
-- local function TimedText (seconds, text)
--     return function (go)
--         print(text)
--         millseconds = (seconds or 1) * 1000
--         Script.SetTimerForFunction(millseconds, go)
--     end
-- end
--
-- Chain(
--     TimedText(1, 'fading in'),
--     TimedText(1, 'showing splash screen'),
--     TimedText(1, 'showing title screen'),
--     TimedText(1, 'showing demo')
-- )()
---@return function chain
-- the cretedfunction chain
function Chain(...)
    local links = {...}

    local function chain(...)
        if not (...) then return Invoker(links, 1)(select(2, ...)) end
        local offset = #links
        for index = 1, select('#', ...) do links[offset + index] = select(index, ...) end
        return chain
    end

    return chain
end

-- >> just incase this file gets reloaded multiple times, lets not wipe out any existing cached modules
if not g_mCustomModules then g_mCustomModules = {} end
--
-- ─── CUSTOMLOADER ───────────────────────────────────────────────────────────────
--

--- Internal: loadLuaMod(modulename)
---| Loads the Specified Module by namespace , if found in _G["g_mCustomModules"]
---@param modulename string     module namespace
---@return table|string         either a table returned by this module or a string for error
local function loadLuaMod(modulename)
    local errmsg = 'Failed to Find Module'
    -- Find the Module.
    local LuaMods = _G['g_mCustomModules']
    local this_module = LuaMods[modulename]
    -- basic validation.
    if (type(this_module) == 'function') then
        -- basic test for errors.
        local testOk, testResult = pcall(this_module)
        if testOk then
            return this_module
        else
            return testResult
        end
    end
    return errmsg
end
-- Install the loader so that it's called just before the normal Lua loader
table.insert(package.loaders, 2, loadLuaMod)

-- [Usable Methods]
-- ────────────────────────────────────────────────────────────────────────────────

---* Registers a Module Table with the Custom Loader
---| returns boolean and a message on error
---@param name string Module Name
-- This is the Module Name used to Load the Registered Module
---@param this_module table Module Table
-- This table Defines your Module, same as you would return in a standard module,
---@return boolean success
---@return string errorMsg
function RegisterModule(name, this_module)
    if (type(name) ~= 'string') or (name == ('' or ' ')) then
        return false, 'Invalid Name Passed to RegisterModule, (must be a string and not empty).'
    elseif (type(this_module) ~= 'table') or (this_module == {}) then
        return false, 'Invalid Module Passed to RegisterModule, (must be a table and not empty).'
    end
    local CustomModules = _G['g_mCustomModules']

    -- Wrap the module in a function for the loader to return.
    local ModWrap = function()
        local M = this_module
        return M
    end

    -- Ensure this Module doesnt allready Exist
    if CustomModules[name] then
        return false, 'A Module allready Exists with this Name.'
    else -- all ok, attempt to push the module into package.loaded
        CustomModules[name] = ModWrap
    end

    if (CustomModules[name] == ModWrap) then -- named package matches module.
        return true, 'Module ' .. name .. ' Loaded succesfully'
    else -- somehow named package doesnt match our module, something bad happened.
        return false, 'Something went Wrong, the Loaded module didnt match as Expected.'
    end

    return nil, 'Unknown Error' -- This should never happen.
end

--[[
    Creates a GUID using an improved randomseed function accouning for lua 5.1 vm limitations
        >> Lua 5.1 has a limitation on the bitsize meaning that when using randomseed
        >> numbers over the limit get truncated or set to 1 , destroying all randomness for the run
]] -- Assumed Lua 5.1 maximim bitsize of 32
local bitsize = 32
local initTime = os.time()
function better_randomseed(seed)
    seed = math.floor(math.abs(seed))
    if seed >= (2 ^ bitsize) then
        -- integer overflow, reduce  it to prevent a bad seed.
        seed = seed - math.floor(seed / 2 ^ bitsize) * (2 ^ bitsize)
    end
    math.randomseed(seed - 2 ^ (bitsize - 1))
    return seed
end

uuidSeed = better_randomseed(initTime)

function new_UUID()
    local template = 'xyxxxxxx-xxyx-xxxy-yxxx-xyxxxxxxxxxx'
    return string.gsub(
               template, '[xy]', function(c)
            local v = (c == 'x') and math.random(0, 0xf) or math.random(8, 0xb)
            return string.format('%x', v)
        end
           )
end
