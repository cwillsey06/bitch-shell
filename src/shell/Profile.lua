-- Profile.lua
-- Coltrane Willsey
-- 2022-03-07 [22:47]

local stdout = require('src/common/stdout')
local task = require('src/common/task')
local pack = require('src/common/pack')

local sh_profile = {}
sh_profile = {
    help = {
        meta = 'echos all commands or $arg1 meta to console';
        task = task.new(function(self,...)
            local arg1 = {...}[1]
            if arg1 then
                return arg1 .." : ".. sh_profile[arg1].meta
            else
                local t = {}
                local i = 1
                for k, cmd in pairs(sh_profile) do
                    t[i] = ("%s : %s"):format(tostring(i), k) 
                    i = i + 1
                end
                return t
            end
        end)
    };
    echo = {
        meta = 'echos $args to console';
        task = task.new(function(self, ...)
            return pack({...})
        end);
    }
}

return sh_profile