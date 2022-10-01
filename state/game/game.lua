local grid         = require("state.game.grid")
local level        = require("state.game.level")
local enemies        = require("state.game.enemies")

local Game = {}

function Game:load()
	grid:load()
	level:load()
	enemies:load()
end

function WriteSaveData()
	-- local data = {
	-- 	main = Lib.copyCellState(grid.cells),
	-- }
	
	-- Lib.writeData("game_saves/"..Settings.problemNr..".dat", data)
	
	local gameSettings = Lib.saveDataList()
	Lib.writeData("config.cfg", gameSettings)

	-- if Settings.game.state[Settings.problemNr] == "solved" then -- is the puzzle solved
	-- 	Settings.game.state[Settings.problemNr] = "solved"
	-- 	Lib.writeData("game.dat", Settings.game)
	-- else
	-- 	Settings.game.state[Settings.problemNr] = "pending"
	-- 	Lib.writeData("game.dat", Settings.game)
	-- end
end

function Game:draw()
	grid:draw()
	enemies:draw()
end

function Game:update(dt)
	grid:update(dt)
	enemies:update(dt)
end

function Game:keypressed(key,scancode,isrepeat)

end

function Game:keyreleased(key,scancode)
	-- grid:keyreleased(key,scancode)
end

function Game:mousepressed(x,y,button,istouch,presses)
	grid:mousepressed(x,y,button,istouch,presses)
end

function Game:mousereleased(x,y,button,istouch,presses)
	grid:mousereleased(x,y,button,istouch,presses)
	WriteSaveData()
end

return Game