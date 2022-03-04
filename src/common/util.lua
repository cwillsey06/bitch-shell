-- filename: util.lua
-- author: mao06
-- summary: requires and caches utilities and arrays

local util = {}
util.__index = util
util._cached = {}

local Settings = require("src/shell/Settings")
local Enum = require("src/common/Enum")

function util.write(writeType, string)
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

function util.get(module)
  local _dir = 'src/common/'
  local required = util._cached[module]
  if not required then
    xpcall(function()
        required = require(_dir.. module)
      end,
      function(x)
        module.write(Enum.WriteType.Error, x:lower())
      end)
    
    util._cached[module] = required
  end

  return required
end

return util