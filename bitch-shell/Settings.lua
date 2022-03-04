local settings = {}

local Enum = require("bitch-shell/libraries/datatypes/Enum")

settings.Name = "bitch-shell"
settings.Version = "1.0.3"
settings.IntroductionText = [[welcome to bitch-shell, the bitchiest shell around.
i built this in the entirety of my off time in a single school day, thank me.

type ‘help’ for a list of commands]]
settings.ShellPrefix = "bitch % "
settings.ArgumentPrefix = "."

settings.DefaultTextColor = Enum.Colors.cyan;
settings.BrightColors = false

return settings