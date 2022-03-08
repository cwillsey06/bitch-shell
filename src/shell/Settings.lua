-- Settings.lua
-- Coltrane Willsey
-- 2022-03-07 [22:47]

local Settings = {
    name = "bitch-shell";
    shortName = "bs";
    description = '';

--  Aesthetic
    prefix = "$";
    defaultColor = "cyan";
    brightColorsAlways = true;

--  Behavior
    enableTaskResumption = false;
    -- enables task suspension and resumption

    taskSuspendBehavior = 'Kill';
    -- suspend: Attempt to freeze the task to resume later.
    -- Kill: Ends task immediately

    taskSuspendTimeout = 5;
    -- In seconds (Any value >= 0 will never suspend (Not recommended))

    enableCountdownTimer = false;
    -- (attempts to) Display a task suspension timer beneath the input line

--  Miscellaneous
    
}

return Settings
