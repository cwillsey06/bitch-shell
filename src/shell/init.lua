-- init.lua
-- Coltrane Willsey
-- 2022-03-07 [22:32]

--[[
    -- TODO: Add documentation
--]]

local Settings = require('src/shell/Settings')

local common = require('src/common/init')
local caretaker = require(common.caretaker)
local stdin, stdout = require(common.stdin), require(common.stdout)

local shell = {}
shell.__index = shell

function shell:invoke(input)
    local command = self.Profile[stdin.getCmd(input)]
    if command then
        xpcall(function()
            stdout.print(command.task:Invoke(self, stdin.getArgs(input)))
        end,
        function(x)
            stdout.encode(("could not execute command: %s"):format(x), 'red')
        end)
    elseif input:match("^%s*$") then
        return
    else
        stdout.write(Settings.shortName, input, "command not found...")
    end
end

function shell:addProfile(name)
    table.insert(self.addonProfiles, require('addons/'.. name))
end

function shell:Start()
    self.active = true
    
    stdout.write(Settings.Name)

    while self.active do
        stdout.write(Settings.prefix)
        self:invoke(io.read())
    end
end

function shell.new()
    local self = setmetatable({}, shell)
    self._caretaker = caretaker.new()
    self._task_caretaker = self._caretaker:Extend()

    self.active = false

    self.Profile = require('src/shell/Profile')
    self.addonProfiles = setmetatable({}, self.Profile)
    
    return self
end

function shell:Destroy()
    self._caretaker:Destroy()
    self = nil
end

return shell
