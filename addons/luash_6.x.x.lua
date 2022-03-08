local luash = {}
clr = "\027[H\027[2J"
cr = '> '
_VERSION = '6.0'

function wait(a) 
    local sec = tonumber(os.clock() + a); 
    while (os.clock() < sec) do end 
end

function info(a)
  if a == 'lua' then
    print("Welcome to luash ".._VERSION)
		print(" type 'help' for a list of commands.")
    print()
  elseif a == 'info' then
    print("+ libary prototype for luash6")
  end
end

function pfunc()
  io.write('Input new prefix: ')
  cr = io.read()
  io.write(clr)
  info('lua')
end

function tableHas(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
    end
  end
  	return false
end

function runApp(app)
	dofile(app..'.lua')
end

function luash.run(a)
  _CMD = {'help','clear','exit','dir','time','run'}
  if a == _CMD[1] then
    for i,v in pairs(_CMD) do
      print(v)
    end
  elseif a == _CMD[1]..' /v' then
    print(_VERSION)
	elseif a == _CMD[1]..' /i' then info('info')
  elseif a == _CMD[1]..' /lu' then info('lua')
	elseif a == _CMD[2] then
		io.write(clr)
		info('lua')
  elseif a == _CMD[2]..' /a' then io.write(clr)
	elseif a == _CMD[3] then
		print('Are you sure you want to exit? (y / n)')
		repeat
    io.write(cr)
    io.flush()
    a=io.read()
		if a == 'y' then
			io.write(clr)
      io.write(nil)
			luash = false
		else break end
		until a == 'n'
			io.write(clr)
			info('lua')
    luash = false
  elseif a == _CMD[3]..' /n' then
		io.write(clr)
    info('lua')
  elseif a == _CMD[3]..' /y' then
    io.write(clr)
    io.write(nil)
    luash = false
  elseif a == _CMD[4]..' /c' then
		print('What do you want to name this file?')
    localfile = io.read()
		print('What is the file extension?')
		extension = io.read()
		fullFile = localfile..'.'..extension
		print('Name this file '.."'"..fullFile.."? (y / n)")
		if io.read() == 'y' then
			table.insert(FILETABLE,fullFile)
      table.insert(TYPETABLE,'FILE')
			table.insert(DATETABLE,os.date('%I:%M%P %Z'))
		else io.write(clr); info('lua'); return end
		localfile = nil
	elseif a == _CMD[4]..' /d' then
    print('Clear directory? (y / n)')
    zz=io.read()
    if zz == 'y' then
      for i = 1,#FILETABLE do
        table.remove(FILETABLE)
      end
      for i = 1,#DATETABLE do
        table.remove(DATETABLE)
      end
			for i = 1,#TYPETABLE do
        table.remove(TYPETABLE)
      end
      else io.write(clr); info('lua') end
	elseif a == _CMD[4] then
		if #FILETABLE >= 1 then
			print()
			for i = 1,#FILETABLE do
				print(i..'	'..FILETABLE[i]..'	'..TYPETABLE[i]..'     '..DATETABLE[i])
			end
			print()
		else print('Nothing found in directory.') end
	elseif a == _CMD[4]..' /qs' then
		vv = io.read()
    if tonumber(vv) >= 1000 then
      print('Inputting large values may cause the the console to hang.')
      print('Continue? (y / n)')
      if io.read() == 'y' then
        print('ctrl+C to force-quit')
        for i = 1,vv do
          table.insert(FILETABLE,'easter.egg')
          table.insert(TYPETABLE,'FILE')
          table.insert(DATETABLE,os.date('%I:%M %P %Z'))
		    end
      else
				io.write(clr)
				info('lua')
      end
    else
		  for i = 1,vv do
			  table.insert(FILETABLE,'easter.egg')
        table.insert(TYPETABLE,'FILE')
			  table.insert(DATETABLE,os.date('%I:%M %P %Z'))
		  end
    end
			io.write(clr)
			info('lua')
  elseif a == _CMD[5] then
    tim = '%I:%M%P %Z'
    dat = '%m/%d/%Y'
    day = '%A'
    print(os.date(day..' / '..tim..' / '..dat))
    elseif a == '' then
			io.flush()
	elseif a:match(_CMD[6]) then
		fi = a:gsub('run ','')
			io.write(clr)
			print("Warning! luash6 does not fully support luash5 extensions! Do not expect external commands to work in virtual environments.")
			print()
			print("Starting ".."'"..fi:sub(1,-5).."'")
			wait(2.5)
			io.write(clr)
			if tableHas(FILETABLE,fi) then
				print(fi:sub(1,-5))
				runApp(fi:sub(1,-5))
			else
			print('application not found')
			end
	else
		print('invalid command or argument')
  end
end

FILETABLE = {}
TYPETABLE = {}
DATETABLE = {}

table.insert(FILETABLE,'luash2.uex')
table.insert(TYPETABLE,'UnixExecutable')
table.insert(DATETABLE,'NaN')

table.insert(FILETABLE,'crosh.x16')
table.insert(TYPETABLE,'16-bit application')
table.insert(DATETABLE,'NaN')

io.write(clr)
info('lua')

-- joint file for loading

while true do
	io.write('> ')
	ans = io.read()
	luash.run(ans)
end