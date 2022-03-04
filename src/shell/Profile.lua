local Settings = require("src/shell/Settings")
local util = require("src/common/util")
local Enum = util.get("Enum")

local module = {}
module = {
    help = {
    info = "grabs a list of the local 'inbuiltShellSystem' commands";
    invoke = function(self,args)
      local formattedText = ''
      for cmd,data in pairs(module) do
        formattedText = formattedText..("%s\t::\t%s\n"):format(cmd,data.info)
      end
      util.write(formattedText)
    end;
    };
    clear = {
      info = "clears the screen";
      invoke = function(self,args)
        util.write("\027[H\027[2J")
        if not (args[1] == Settings.ArgumentPrefix.. "a") then
          self.init()
          self:Destroy()
        end
        return
      end;
    };
    exit = {
      info = "exits the shell";
      invoke = function(self,args)
        self:Exit(args[1])
      end;
    };
    loadLibrary = {
      info = "Loads a commandLibrary into memory";
      invoke = function(self,args)
        local lib = require("addons/".. args[1])
        table.insert(self._customLibraryCache,lib)
      end;
    };
    date = {
      info = "displays the current date & time";
      invoke = function(self,args)
        local Date = os.date("*t")
        local Hour = ("%0.2i"):format(((Date.hour % 12 == 0) and 12) or (Date.hour % 12))
        local Minute = ("%0.2i"):format(Date.min)
        local Second = ("%0.2i"):format(Date.sec)
        local Meridiem = (Date.hour < 12 and "AM" or "PM")
        
        util.write(("%s:%s:%s %s UTC"):format(Hour,Minute,Second,Meridiem))
      end;
    };
    dir = {
      info = "lists working directory";
      invoke = function(self,args)
        util.write(lfs.currentdir().."://\n")
        for path,_ in lfs.dir(lfs.currentdir()) do
          util.write(path.. "\n")
        end
      end;
    };
    cd = {
      info = "change working directory";
      invoke = function(self,args)
        if (args[1]) then lfs.chdir(lfs.currentdir().."/"..args[1]) end
      end;
    };
    run = {
      info = "runs an application";
      invoke = function(self,args)
        local file = lfs.currentdir().. "/".. args[1]
        dofile(file)
      end;
    };
    loadstring = {
      info = "loadstring imported from lua";
      invoke = function(self,args)
        local str = tostring(unpack(args))
        loadstring(str)()
      end;
    }
}
return module