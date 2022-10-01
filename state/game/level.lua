local Level = {}
-- local cell = require("constructors.cell")
local s = require("settings")
local grid = require("state.game.grid")

function Level:load()
	grid.cells[10][10].state = "left"
	grid.cells[10][1].state = "up"
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