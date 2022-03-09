-- stdin.lua
-- Coltrane Willsey
-- 2022-03-07 [23:23]

local split = require("src/common/split")

local stdin = {}
stdin.__index = stdin

function stdin.getCmd(raw)
    return raw:match("^([%w]+)")
end

function stdin.getArgs(raw)
    return split(raw:gsub("^([%w]+)",""))
end

return stdin
