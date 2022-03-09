-- pack.lua
-- Coltrane Willsey
-- 2022-03-09 [09:26]

function pack(arg, sep)
    return string.format(string.rep('%s'.. (sep or ' '), #arg), unpack(arg))
end

return pack