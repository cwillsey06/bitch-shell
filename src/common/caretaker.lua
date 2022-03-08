-- caretaker.lua
-- Coltrane Willsey
-- 2022-03-03 [14:15]

--[[
    similar to maid, janitor, trove classes for use on roblox
--]]

local DEFAULT_CLEANUP_METHOD = "Destroy"

local caretaker = {}
caretaker.__index = caretaker

function caretaker.new()
    local self = setmetatable({}, caretaker)
    self._objects = {}

    return self
end

function caretaker:Extend()
    return self:Add(caretaker.new())
end

--

function caretaker:_cleanupObject(object, cleanupMethod, index)
    if not cleanupMethod and index then
        index, object, cleanupMethod = caretaker:_findObject(object)
    end
    object[cleanupMethod](object)
    self._objects[index] = nil
end

function caretaker:_findObject(object)
    for i, v in ipairs(self._objects) do
        if v[1] == object then
            return i, v[1], v[2]
        end
    end
end

function caretaker:Add(object, cleanupMethod)
    table.insert(self._objects, {object, cleanupMethod or DEFAULT_CLEANUP_METHOD})
    return object
end

function caretaker:Remove(object, doCleanup)
    if doCleanup then
        self:_cleanupObject(object)
    else
        local index = self:_findObject()
        self._objects[index] = nil
    end
end

--

function caretaker:Cleanup()
    for i, v in ipairs(self._objects) do
        self:_cleanupObject(v[1], v[2], i)
    end
end

function caretaker:Destroy()
    self:Cleanup()
    self = nil
end

return caretaker
