local Level = {}
-- local cell = require("constructors.cell")
local grid = require("state.game.grid")

function Level:load()
	-- y, x
	grid.cells[10][10].direction = {x = -1, y = 0}
	grid.cells[10][1].direction = {x = 0, y = -1}
	grid.cells[5][1].direction = {x = 1, y = 0}
	grid.cells[5][5].direction = {x = 0, y = -1}
	grid.cells[1][5].state = "finish"

	grid.cells[1][10].state = "roadV"
	grid.cells[2][10].state = "roadV"
	grid.cells[3][10].state = "roadV"
	grid.cells[4][10].state = "roadV"
	grid.cells[5][10].state = "roadV"
	grid.cells[6][10].state = "roadV"
	grid.cells[7][10].state = "roadV"
	grid.cells[8][10].state = "roadV"
	grid.cells[9][10].state = "roadV"

	grid.cells[6][1].state = "roadV"
	grid.cells[7][1].state = "roadV"
	grid.cells[8][1].state = "roadV"
	grid.cells[9][1].state = "roadV"

	grid.cells[2][5].state = "roadV"
	grid.cells[3][5].state = "roadV"
	grid.cells[4][5].state = "roadV"

	grid.cells[10][2].state = "roadH"
	grid.cells[10][3].state = "roadH"
	grid.cells[10][4].state = "roadH"
	grid.cells[10][5].state = "roadH"
	grid.cells[10][6].state = "roadH"
	grid.cells[10][7].state = "roadH"
	grid.cells[10][8].state = "roadH"
	grid.cells[10][9].state = "roadH"
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