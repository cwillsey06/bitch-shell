local clr = "\027[H\027[2J"
local ver = '2.0'
local pfix = 'dev> '

local updatetbl = {'Commands:','+ help','+ info','+ reset', '+ exit','+ prefix','New features:',"'reset /a' clears entire screen","'exit /t' exits terminal-mode","pressing enter on a blank line no longer displays 'command not found' error.",'Miscellaneous:',"Version number changed to a 'x.x' value"}

print('Welcome to lua Terminal v'.. ver)
print(' --Latest updates')
for i,v in pairs(updatetbl) do
  print('     '..v)
end
print('')

function terminal()
  local ans
while true do
  io.write(pfix)
  io.flush()
  ans=io.read()
  if ans == 'help' then
    local cmdtable = {'help','reset','exit','pfix'}
    for i,v in pairs(cmdtable) do
      print(v)
    end
  elseif ans == 'info' then
    local info = 'lua-terminal / created by scrawlmin :: This version of lua-terminal is not yet complete, therefore there may be bugs and incomplete features.'
    print(info)
  elseif ans == 'test' then
    print('lua-terminal-functiontest.scrawlmin.repl.run')
  elseif ans == 'reset' then
    io.write(clr)
    print('Welcome to lua Terminal v'.. ver)
    print(' --Latest updates')
    for i,v in pairs(updatetbl) do
    print('     '..v)
    end
    print('')
  elseif ans == 'reset /a' then
    io.write(clr)
  elseif ans == 'exit' then
    print('Are you sure you want to exit? (y/n)')
    repeat
    io.write("dev> ")
    io.flush()
    answer=io.read()
    if answer == 'y' then
      io.write(clr)
      return
    else break end
    until ans == 'n'
      io.write(clr)
      print('Welcome to lua-terminal v'..ver)
      print(' --Latest updates')
      for i,v in pairs(updatetbl) do
      print('     '..v)
      end
      print('')
    elseif ans == 'exit /t' then
      print("Are you sure you want to enter script-mode? (note: this does not work in 'lua-terminal.scrawlmin.repl.run' ) (y/n)")
      repeat
      io.write("dev> ")
      io.flush()
      answer=io.read()
      if answer == 'y' then
        return
      else break end
      until ans == 'n'
        io.write(clr)
        print('Welcome to lua Terminal v'..ver)
        print(' --Latest updates')
        for i,v in pairs(updatetbl) do
        print('     '..v)
        end
        print('')
    elseif ans == '' then
      io.flush()
  else
    print('command not found')
  end
end
end

terminal()