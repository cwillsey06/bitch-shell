 local util = require("bitch-shell/util")
local module = {}
module = {
    ["print"] = {
      info = "prints a line of text";
      invoke = function(self,args)
        util.write(unpack(args))
      end;
    };
}
return module