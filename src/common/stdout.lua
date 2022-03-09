-- stdout.lua
-- Coltrane Willsey
-- 2022-03-07 [23:07]

local Settings = require('src/shell/Settings')
local colors = require('src/common/colors')

function pack(arg, sep)
    return string.format(string.rep('%s'.. (sep or ' '), #arg), unpack(arg))
end

local stdout = {}
stdout.__index = stdout

function stdout.encode(raw, encoding)
    io.write(colors[encoding['color'] or Settings.defaultColor]..
    colors[(encoding['bright'] or Settings.brightColorsAlways) and 'bright']..
    raw)
end

function stdout.print(...)
    io.write(colors[Settings.defaultColor]..
    (Settings.brightColorsAlways and colors.bright or '')..
    pack({...}, '\n'))
end

function stdout.write(...)
    io.write(colors[Settings.defaultColor]..
    (Settings.brightColorsAlways and colors.bright or '')..
    pack({...}))
end

return stdout