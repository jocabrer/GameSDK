local function isFile(path)
    local f = io.open(path, "r")
    if f then
        f:close()
        return true
    end
    return false
end

local function isDir(path)
    path = string.gsub(path .. "/", "//", "/")
    local ok, err, code = os.rename(path, path)
    if ok or code == 13 then
        return true
    end
    return false
end

local function mkDir(path)
    local ok, Result = os.execute("mkdir " .. path:gsub("/", "\\"))
    if not ok then
        return nil, "Failed to Create " .. path .. " Directory! - " .. Result
    else
        return true, "Successfully Created " .. path .. " Directory!"
    end
end

local function dumpTable(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. dumpTable(v) .. ","
        end
        return s .. "} "
    else
        if type(o) == "string" then
            return '"' .. tostring(o) .. '"'
        else
            if type(o) == "function" then
                return '"' .. string.dump(o) .. '"'
            else
                return tostring(o)
            end
        end
    end
end

MisDB.Utils = {
    mkDir = mkDir,
    isDir = isDir,
    isFile = isFile,
    dumpTable = dumpTable
}
