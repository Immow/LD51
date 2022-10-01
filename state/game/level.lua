local Level = {}
-- local cell = require("constructors.cell")
local s = require("settings")
local grid = require("state.game.grid")

function Level:load()
	-- y, x
	grid.cells[10][10].direction = {x = -1, y = 0}
	grid.cells[10][1].direction = {x = 0, y = -1}
	grid.cells[5][1].direction = {x = 1, y = 0}
	grid.cells[5][5].direction = {x = 0, y = -1}
end

function Level:drawLevel()

end

function Level:draw()
end

function Level:update(dt)

end

function Level:mousepressed(x,y,button,istouch,presses)

end

function Level:mousereleased(x,y,button,istouch,presses)

end

return Level