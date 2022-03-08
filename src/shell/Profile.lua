-- Profile.lua
-- Coltrane Willsey
-- 2022-03-07 [22:47]

local task = require('src/common/task')

local sh_profile = {
    echo = {
        meta = 'echos $args to console';
        task = task.new(function()
            return "hello"
        end);
    }
}

return sh_profile