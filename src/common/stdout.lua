-- stdout.lua
-- Coltrane Willsey
-- 2022-03-07 [23:07]

local Settings = require('src/shell/Settings')
local colors = require('src/common/colors')

local stdout = {}
stdout.__index = stdout

function stdout.encode(raw, encoding)
    io.write(colors[encoding['color'] or Settings.defaultColor]..
    colors[encoding['bright'] and 'bright' or Settings.brightColorsAlways]..
    raw)
end

function stdout.print(...)
    io.write(colors[Settings.defaultColor]..
    colors[Settings.brightColorsAlways]..
    stdout.write(...).. '/n')
end

function stdout.write(...)
    io.write(colors[Settings.defaultColor]..
    colors[Settings.brightColorsAlways]..
    string.pack('=A'.. #{...}, ...))
end

return stdout