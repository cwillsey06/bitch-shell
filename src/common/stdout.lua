-- stdout.lua
-- Coltrane Willsey
-- 2022-03-07 [23:07]

local stdout = {}
stdout.__index = stdout

function stdout.encode(raw, encoding)
    stdout.write(raw)
end

function stdout.print(...)
    return stdout.write(...).. '/n'
end

function stdout.write(...)
    return string.pack('=A'.. #{...}, ...)
end

return stdout