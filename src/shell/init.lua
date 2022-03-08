-- init.lua
-- Coltrane Willsey
-- 2022-03-07 [22:32]

--[[
    -- TODO: Add documentation
--]]

local common = require('src/common/init')
local caretaker = require(common.caretaker)

local shell = {}
shell.__index = shell

function shell:invoke(stdin)

end

function shell.new()
    local self = setmetatable({}, shell)
    self._caretaker = caretaker.new()
    self._task_caretaker = self._caretaker:Extend()
    
    return self
end

function shell:Destroy()
    self._caretaker:Destroy()
    self = nil
end

return shell
