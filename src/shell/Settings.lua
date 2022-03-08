-- Settings.lua
-- Coltrane Willsey
-- 2022-03-07 [22:47]

local Settings = {
    Name = "Source-Controlled Lua Shell";
    shortName = "sclush";

--  Aesthetic
    Prefix = "$";
    DefaultColor = "white";
    BrightColorsAlways = true;

--  Behavior
    EnableTaskResumption = false;
    -- enables task suspension and resumption

    TaskSuspendBehavior = 'Kill';
    -- suspend: Attempt to freeze the task to resume later.
    -- Kill: Ends task immediately

    TaskSuspendTimeout = 5;
    -- In seconds (Any value >= 0 will never suspend (Not recommended))

    EnableCountdownTimer = false;
    -- (attempts to) Display a task suspension timer beneath the input line

--  Miscellaneous
    
}

return Settings
