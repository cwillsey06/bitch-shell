local addon = {}
addon.__index = addon

function addon.hello()
    return "hello"
end

function addon.new()
    local self = setmetatable({}, addon)
    return self
end

function addon:Destroy()
    self = nil
end

return addon
