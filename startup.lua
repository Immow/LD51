if love.filesystem.getInfo("config.cfg") then
	local data = Lib.readData("config.cfg")
	if data ~= nil and data.version < Settings.version then
		Lib.writeData("config.cfg", Lib.saveDataList())
	else
		for key, value in pairs(data) do
			Settings[key] = value
		end
	end
else
	Lib.writeData("config.cfg", Lib.saveDataList())
end