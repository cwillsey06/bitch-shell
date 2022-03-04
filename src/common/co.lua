local module = {}
local util = require("src/common/util")
local wait = util.get("wait")
module = {
  spawn = function(f,...) coroutine.wrap(f)(...); end;
  delay = function(f,delay,...) module.spawn(function(...) wait(delay or 0.001); f(...) end); end;
}
return module