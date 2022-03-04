-- filename: shell.lua
-- author: mao06
-- summary: main module to initialize and run the entire shell

local Settings = require("bitch-shell/Settings")
local util = require("bitch-shell/util")

local Enum = util.get("datatypes","Enum")

local co = util.get("functions","co")
local split = util.get("functions","split")
local wait = util.get("functions","wait")

local module = {}
module.__index = module

module._customLibraryCache = {}
module._inbuiltShellSystem = util.get("commandLibraries","builtin")

local function getCommand(raw)
	return raw:match("^([%w]+)")
end

local function getArguments(raw)
	raw = raw:gsub("^([%w]+)","")
	return split(raw)
end

function module:Run(raw)
	local command = self._inbuiltShellSystem[getCommand(raw)]
	if (command) then
		local args = getArguments(raw)
    xpcall(function()
			  command.invoke(self,args)
      end,
      function(err)
        util.write(Enum.WriteType.Error,err)
      end)
	elseif (raw:match("^%s*$")) then
    return
	else
		util.write(Enum.WriteType.Error,"unknown input")
	end
end

function module.init()
	local self = setmetatable({},module)
	self.active = true

	util.write(("%s [%s]\n\n%s\n"):format(Settings.Name,Settings.Version,Settings.IntroductionText))

	self:Return()

	co.spawn(function()
		while (self.active) do
      local status = self:Run(io.read())
      self:Return(status == "successful")
		end
	end)

	return self
end

function module:Return(breakOnce)
  if (breakOnce) then
    util.write(Settings.ShellPrefix)
  else
    util.write("\n".. Settings.ShellPrefix)
  end
end

function module:Exit(code)
	os.exit(code or 69)
end

function module:Destroy()
	self.active = false
	self = nil
end

return module
