local clr = "\027[H\027[2J"
local cr = 'crosh> '

_CMD = {'help','reset','exit','info','prefix','dir','date'}
Ext = {'cmdtoggle','guestexit','uninstall','reinstall','detach'}

luash_VERSION = '2.0'
extensionsActive = false
guestActive = true
attached = true

function wait(a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do 
    end 
end

function info(a)
  if a == 'crosh' then
    io.write(clr)
    print("[Pro Tip] Use 'Open as Window' or 'Full Screen' to prevent Ctrl-W from closing your terminal!")
    print("[Pro Tip] See [crosh] for more information.")
    print()
    print("Welcome to crosh, the Chrome OS developer shell.")
    print()
    print("If you got here by mistake, don't panic! Just close this tab and carry on.")
    print()
    print("Type 'help' for a list of commands.") 
    print()
    print("If you want to customize the look/behavior, you can use the options page.")
    print("Load it by using the Ctrl+Shift+P heyboard shortcut.")
    print()
  elseif a == 'dir' then
    io.write(clr)
    print('DIRECTORY EDITOR')
    print()
  elseif a == 'info' then
    print("crosh script simplification")
  end
end

function pfunc()
  io.write('Input new prefix: ')
  cr = io.read()
  io.write(clr)
  info('crosh')
end

function crosh(a)
  _VERSION = '5.7'
  if a == _CMD[1] then
		print()
		print('crosh:')
    for i,v in pairs(_CMD) do
      print(v)
    end
		print()
		if extensionsActive == true then
			print('luash:')
			for i,v in pairs(Ext) do
				print(v)
			end
		end
  elseif a == _CMD[1]..' -v' then
		print('crosh:')
    print(_VERSION)
		print('luash:')
		print(luash_VERSION)
	elseif a == _CMD[2] then
		info('crosh')
  elseif a == _CMD[2]..' -a' then io.write(clr)
	elseif a == _CMD[3] then
		print('Are you sure you want to exit? (y / n)')
		repeat
    io.write(cr)
    io.flush()
    a=io.read()
		if a == 'y' then
			io.write(clr)
      io.write(nil)
			return
		else break end
		until a == 'n'
    info('crosh')
    return
  elseif a == _CMD[3]..' -n' then
    info('crosh')
  elseif a == _CMD[3]..' -y' then
    io.write(clr)
    io.write(nil)
    return
	elseif a == _CMD[4] then info('info')
  elseif a == _CMD[4]..' -c' then info('crosh')
  elseif a == _CMD[5] then
    if pcall(pfunc) then
      return
    else
      print('Invalid prefix')
    end
  elseif a == _CMD[6]..' -c' then
    info('dir')
		print('What do you want to name this file?')
    localfile = io.read()
		print('What is the file extension?')
		extension = io.read()
		print('Name this file '.."'"..localfile.."."..extension.."'".."? (y / n)")
		fullFile = localfile..'.'..extension
		if io.read() == 'y' then
			table.insert(FILETABLE,fullFile)
      table.insert(TYPETABLE,'FILE')
			table.insert(DATETABLE,os.date('%I:%M%P %Z'))
      io.write(clr)
      info('crosh')
		else io.write(clr); info('crosh'); return end
		localfile = nil
	elseif a == _CMD[6]..' -d' then
    info('dir')
    print('Clear directory? (y / n)')
    zz=io.read()
    if zz == 'y' then
      for i = 1,#FILETABLE do
        table.remove(FILETABLE)
      end
      for i = 1,#DATETABLE do
        table.remove(DATETABLE)
      end
      info('crosh')
      elseif zz == 'crosh' then 
        while true do
          io.write(string.char(math.random(31,127)))
        end
      else info('crosh') end
	elseif a == _CMD[6] then
		if #FILETABLE >= 1 then
			print()
			print('#	NAME		TYPE     DATE')
			for i = 1,#FILETABLE do
				print(i..'	'..FILETABLE[i]..'	'..TYPETABLE[i]..'     '..DATETABLE[i])
			end
			print()
		else print('Nothing found in directory.') end
	elseif a == _CMD[6]..' -qs' then
    info('dir')
		vv = io.read()
    if tonumber(vv) >= 1000 then
      print('Inputting large values may cause the the console to hang.')
      print('Continue? (y / n)')
      if io.read() == 'y' then
        print('ctrl+C to force-exit the console')
        for i = 1,vv do
          table.insert(FILETABLE,'easter.egg')
          table.insert(TYPETABLE,'FILE')
          table.insert(DATETABLE,os.date('%I:%M %P %Z'))
		    end
      else
        info('crosh')
      end
    else
		  for i = 1,vv do
			  table.insert(FILETABLE,'easter.egg')
        table.insert(TYPETABLE,'FILE')
			  table.insert(DATETABLE,os.date('%I:%M %P %Z'))
		  end
    end
    info('crosh')
  elseif a == _CMD[7] then
    tim = '%I:%M%P %Z'
    dat = '%m/%d/%Y'
    day = '%A'
    print(os.date(day..' - '..tim..' - '..dat))
    elseif a == '' then
		io.flush()
  else
    print('command not found')
  end
end

function luExt(a)
	if extensionsActive == true then
		if a == Ext[1] then
			if cmdT == false then
				_CMD[2] = 'reset'
				_CMD[4] = 'info'
				_CMD[7] = 'date'
				print('CMD: crosh mode')
				cmdT = true
			else
				_CMD[2] = 'clear'
				_CMD[4] = 'help /i'
				_CMD[7] = 'time'
				print('CMD: luash mode')
				cmdT = false
			end
		elseif a == Ext[2] then
			if attached then
				print('Exit to Host OS? (y / n)')
				if io.read() == 'y' then
					guestActive = false
				else return end
			else
				print('Are you sure you want to exit? (y / n)')
				repeat
				io.write(cr)
				io.flush()
				a=io.read()
				if a == 'y' then
					io.write(clr)
					io.write(nil)
					return
				else break end
				until a == 'n'
				info('crosh')
				return
			end
		elseif a == Ext[3] then
			extensionsActive = false
			Ext = {}
			print("luash: uninstall successful")
		elseif a == Ext[4] then
			print("luash: reinstalling...")
			wait(1.25)
			dofile('crosh.lua')
		elseif a == Ext[5] then
			attached = false
			print("luash: detach")
		else
		end
	end
end

info('crosh')

FILETABLE = {}
TYPETABLE = {}
DATETABLE = {}

wait(1)
extensionsActive = true
print('luash extensions installed.')


while guestActive == true do
	io.write(cr)
	io.flush()
	local ans
	ans = io.read()
	luExt(ans)
	crosh(ans)
end
wait(1.75)
dofile('main.lua')