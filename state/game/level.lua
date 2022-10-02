local Level = {}
-- local cell = require("constructors.cell")
local grid = require("state.game.grid")

function Level:load()
	-- y, x
	grid.cells[1][10].state      = "down"
	grid.cells[10][10].state     = "left"
	grid.cells[10][1].state      = "up"
	grid.cells[5][1].state       = "right"
	grid.cells[5][5].state       = "up"

	grid.cells[1][10].state = "start"
	grid.cells[1][5].state = "finish"

	self:generateRoad()
end

function Level.getStart()
	for i = 1, #grid.cells do
		for j = 1, #grid.cells[i] do
			if grid.cells[i][j].state == "start" then
				return grid.cells[i][j]:getPosition()
			end
		end
	end
end

function Level:moveDown()
end

function Level:generateRoad()
	local x, y = self.getStart()
	print(x, y)
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