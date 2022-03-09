-- init.lua
-- Coltrane Willsey
-- 2022-03-07 [22:32]

--[[
    -- TODO: Add documentation
--]]

local Settings = require('src/shell/Settings')
local caretaker = require('src/common/caretaker')
local stdin, stdout = require('src/common/stdin'), require('src/common/stdout')

local shell = {}
shell.__index = shell

function shell:invoke(input)
    local command = self.Profile[stdin.getCmd(input)]
    if command then
        xpcall(function()
            stdout.print(command.task:Invoke(self, stdin.getArgs(input)))
        end,
        function(x)
            stdout.encode(("%s: could not execute command: %s"):format(Settings.shortName, x), {color = 'red'})
        end)
    elseif input:match("^%s*$") then
        return
    else
        stdout.encode(("%s: command '%s' not found..."):format(Settings.shortName, input), {color = 'white', dim = true})
        stdout.nl()
    end
end

function shell:addProfile(name)
    table.insert(self.addonProfiles, require('addons/'.. name))
end

function shell:Start()
    self.active = true
    
    stdout.print(Settings.name)

    self._runner = coroutine.create(function()
        while self.active do
            stdout.write(Settings.prefix)
            self:invoke(self, io.read())
        end
    end)

    coroutine.resume(self._runner)
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
