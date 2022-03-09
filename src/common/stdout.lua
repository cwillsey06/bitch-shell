-- stdout.lua
-- Coltrane Willsey
-- 2022-03-07 [23:07]

local Settings = require('src/shell/Settings')
local colors = require('src/common/colors')
local pack = require('src/common/pack')

local stdout = {}
stdout.__index = stdout

function stdout.encode(raw, encoding)
    io.write(colors[encoding['color'] or Settings.defaultColor]..
    colors[(encoding['bright'] or Settings.brightColorsAlways) and 'bright']..
    (encoding['dim'] and colors.dim or '')..
    raw.. colors.reset)
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

function stdout.nl()
    stdout.print('')
end

return stdout