-- stdin.lua
-- Coltrane Willsey
-- 2022-03-07 [23:23]

local split = require("src/common/split")

local stdin = {}
stdin.__index = stdin

function stdin.getCmd(stdin)
    return stdin:match("^([%w]+)")
end

function stdin.getArgs(stdin)
    return split(stdin:gsub("^([%w]+)",""))
end

return stdin
