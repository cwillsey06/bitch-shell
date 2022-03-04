-- filename: util.lua
-- author: mao06
-- summary: requires and caches utilities and arrays

local module = {}
module.__index = module
module._cached = {}

local Settings = require("src/shell/Settings")
local Enum = require("src/common/Enum")

function module.write(writeType, string)
  local bright = ''
  if (Settings.BrightColors) then
    bright = Enum.Colors.bright
  end

  if (string) then
    io.write(bright..writeType..string)
  else
    io.write(bright..Settings.DefaultTextColor..writeType)
  end
end

function module.get(Type, Module)
    local localModule = Module or Type
    if not (module._cached[localModule]) then
      table.insert(module._cached,localModule)
      
      local namespace
      if (Module) then
        namespace = ("src/common/%s"):format(Type.."/")
      else
        namespace = ''
      end

      xpcall(function()
        module._cached[localModule] = require(namespace.. localModule)
      end,
      function(code)
        module.write(Enum.WriteType.Error,code)
        table.remove(module._cached,module._cached[localModule])
      end)

    end

    return module._cached[localModule]
end

return module