local const
const = function(self, fieldname)
  local rawnewindex = self.__base.__newindex or rawset
  self.__base.__newindex = function(self, k, v)
    if self["_const_initialized_" .. tostring(fieldname)] and (k == fieldname or k == "_const_initialized_" .. tostring(fieldname)) then
      error("Attempt to Modify Protected Field: '" .. tostring(fieldname) .. "' of " .. tostring(self.__class.__name) .. ".")
    end
    return rawnewindex(self, k, v)
  end
  local rawinit = self.__init
  self.__init = function(self, ...)
    rawinit(self, ...)
    if not self["_const_initialized_" .. tostring(fieldname)] then
      self["_const_initialized_" .. tostring(fieldname)] = true
    end
  end
end
local try
try = function(t)
  local ok, value = pcall(t["do"])
  if ok then
    if t.finally then
      t.finally()
    end
    return value
  else
    local handled, backup_value = pcall(function()
      return t.catch(value)
    end)
    if t.finally then
      t.finally()
    end
    if handled then
      return backup_value
    else
      return error(backup_value, 2)
    end
  end
end
local mTypes = {
  const = const,
  try = try
}

RegisterModule("mFramework.mTypes",mTypes)
