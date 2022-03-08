-- task.lua
-- Coltrane Willsey
-- 2022-03-07 [22:50]

--[[
    -- TODO: Add documentation
--]]

local task = {}
task.__index = task

local common = require('src/common/init')
local caretaker = require(common.caretaker)

function task:Invoke()
    return select(2, coroutine.resume(self.funct))
end

function task.new(f)
    local self = setmetatable({}, task)
    self._caretaker = caretaker.new()
    self._caretaker:Add(self)
    self.funct = coroutine.create(f)
    
    return self
end

function task:Destroy()
    self._caretaker:Destroy(self)
    self = nil
end

return task
