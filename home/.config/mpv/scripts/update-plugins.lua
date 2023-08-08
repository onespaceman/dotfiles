local utils = require('mp.utils')
local config_path = mp.command_native({"expand-path", "~~home/"})

local urls = {'https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua',
'https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip'}
local commands = {}

function update_plugins()
	for i=1, #urls, 1 do
		url = urls[i]
		_, filename = utils.split_path(url)
		command = {}

		if url:sub(-string.len('.lua')) == '.lua' then
			table.insert(command, 'Invoke-WebRequest -Uri '..url..'  -OutFile '..config_path..'/scripts/'..filename..';')
		elseif url:sub(-string.len('.zip')) == '.zip' then
			table.insert(command, 'Invoke-WebRequest -Uri '..url..'  -OutFile '..config_path..'/'..filename..';')
			table.insert(command, 'Expand-Archive '..config_path..'/'..filename..' -DestinationPath '..config_path..' -Force;')
			table.insert(command, 'Remove-Item '..config_path..'/'..filename..';')
		end
		
		for i=1, #command, 1 do
			table.insert(commands, command[i])
		end
	end

	os.execute('powershell.exe '..'"'..table.concat(commands)..'"')
	mp.osd_message('Plugins Updated')
end

mp.add_key_binding("Ctrl+Shift+u",'update-plugins', update_plugins)