local module = {}
local util = require("bitch-shell/util")
local wait = util.get("functions","wait")
module = {
  spawn = function(f,...) coroutine.wrap(f)(...); end;
  delay = function(f,delay,...) module.spawn(function(...) wait(delay or 0.001); f(...) end); end;
}
return module