-- colors.lua
-- Coltrane Willsey
-- 2022-03-03 [14:16]

local _color_enums = {
    -- attributes
    reset = 0,
    clear = 0,
    bright = 1,
    dim = 2,
    underscore = 4,
    blink = 5,
    reverse = 7,
    hidden = 8,

    -- foreground
    black = 30,
    red = 31,
    green = 32,
    yellow = 33,
    blue = 34,
    magenta = 35,
    cyan = 36,
    white = 37,

    -- background
    onblack = 40,
    onred = 41,
    ongreen = 42,
    onyellow = 43,
    onblue = 44,
    onmagenta = 45,
    oncyan = 46,
    onwhite = 47,
}

local class = {}
class.__index = class

function mkcolor(value)
    return setmetatable({ value = string.char(27) .. '[' .. tostring(value) .. 'm' }, class)
end

function class:__tostring()
    return self.value
end

function class:__concat(other)
    return tostring(self) .. tostring(other)
end

function class:__call(s)
    return self .. s .. class.reset
end

for c, v in pairs(_color_enums) do
    class[c] = mkcolor(v)
end

return class