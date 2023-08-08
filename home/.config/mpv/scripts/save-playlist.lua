--local playlist_savepath = (os.getenv('APPDATA') or os.getenv('HOME')..'/.config')..'/mpv/'
local playlist_savepath = mp.get_property('working-directory')

local utils = require('mp.utils')
local msg = require('mp.msg')

local filename = nil

--split path into directories
local function split(delim, str)
	local t = {}
	for substr in string.gmatch(str, '[^'.. delim.. ']*') do
		if substr ~= nil and string.len(substr) > 0 then
			table.insert(t,substr)
		end
	end
	return t
end

--convert absolute path to relative path
local function relpath(path, pwd)
	if path == pwd..'\\' then
		return ''
	end
	
	local result = ''
	local path_split = split('\\', path)
	local pwd_split = split('\\', pwd)
	
	while (next(path_split) ~= nil) and (next(pwd_split) ~= nil) and (path_split[1] == pwd_split[1]) do
		table.remove(path_split, 1)
		table.remove(pwd_split, 1)
	end
	
	for index in pairs(pwd_split) do
		result = result..'../'
	end
	for index, value in ipairs(path_split) do
		result = result..value..'/'
	end
	return result
end

--saves the current playlist into a m3u file
function save_playlist()
	local length = mp.get_property_number('playlist/count')
	if length == 0 then return end
	local savepath = utils.join_path(playlist_savepath, 'playlist.m3u')
	local file, err = io.open(savepath, 'w')
	if not file then
		msg.error('Error in creating playlist file, check permissions and paths: '..(err or ''))
	else
		local i=0
		file:write('#EXTM3U\n')
		while i < length do
			local pwd = mp.get_property('working-directory')
			local filename = {utils.split_path(mp.get_property('playlist/'..i..'/filename'))}
			
			local title = mp.get_property('playlist/'..i..'/title')
			if not title then
				title = filename[2]
			end
			local filepath = relpath(filename[1], pwd)..filename[2]
			file:write('#EXTINF:,', title, '\n', filepath, '\n')
			i=i+1
		end
		msg.info('Playlist written to: '..savepath)
		mp.osd_message('Playlist written to: '..savepath)
		file:close()
	end
end

mp.add_key_binding(nil,'save-playlist', save_playlist)