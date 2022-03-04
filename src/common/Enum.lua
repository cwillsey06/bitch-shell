local Enum = {}
Enum.__index = Enum

-- local util = require("bitch-shell/util")
local colors = require("src/common/colors")
Enum.Colors = colors

-- writeTypes
Enum.WriteType = {
  None = Enum.Colors.reset;
  Error = Enum.Colors.red;
  Warning = Enum.Colors.yellow;
  Help = Enum.Colors.blue
}

return Enum