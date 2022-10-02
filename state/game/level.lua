local Level = {}
local grid = require("state.game.grid")
local direction, x, y

function Level:load()
	-- y, x
	grid.cells[1][10].direction      = "down"
	grid.cells[10][10].direction     = "left"
	grid.cells[10][1].direction      = "up"
	grid.cells[5][1].direction       = "right"
	grid.cells[5][5].direction       = "down"
	grid.cells[8][5].direction       = "right"
	grid.cells[8][7].direction       = "up"
	grid.cells[3][7].direction       = "left"
	grid.cells[3][3].direction       = "up"

	grid.cells[1][10].state = "start"
	grid.cells[1][3].state = "finish"

	direction, x, y = Level.getStart()
	self:generateRoad()
end

function Level.getStart()
	for i = 1, #grid.cells do
		for j = 1, #grid.cells[i] do
			if grid.cells[i][j].state == "start" then
				return grid.cells[i][j].direction, grid.cells[i][j]:getPosition()
			end
		end
	end
end

function Level:moveLeft()
	x = x - 1
	while grid.cells[y][x].direction == nil do
		grid.cells[y][x].state = "roadH"
		x = x - 1
		if grid.cells[y][x].state == "finish" then return grid.cells[y][x].direction, x, y end
		if grid.cells[y][x].direction ~= nil then
			if grid.cells[y][x].direction == "up" then
				grid.cells[y][x].state = "LL"
			else
				grid.cells[y][x].state = "UL"
			end

			return grid.cells[y][x].direction, x, y
		end
	end
end

function Level:moveRight()
	x = x + 1
	while grid.cells[y][x].direction == nil do
		grid.cells[y][x].state = "roadH"
		x = x + 1
		if grid.cells[y][x].state == "finish" then return grid.cells[y][x].direction, x, y end
		if grid.cells[y][x].direction ~= nil then
			if grid.cells[y][x].direction == "up" then
				grid.cells[y][x].state = "LR"
			else
				grid.cells[y][x].state = "UR"
			end

			return grid.cells[y][x].direction, x, y
		end
	end
end

function Level:moveUp()
	y = y - 1
	while grid.cells[y][x].direction == nil do
		grid.cells[y][x].state = "roadV"
		y = y - 1
		if grid.cells[y][x].state == "finish" then return grid.cells[y][x].direction, x, y end
		if grid.cells[y][x].direction ~= nil then
			if grid.cells[y][x].direction == "left" then
				grid.cells[y][x].state = "UR"
			else
				grid.cells[y][x].state = "UL"
			end

			return grid.cells[y][x].direction, x, y
		end
	end
end

function Level:moveDown()
	y = y + 1
	while grid.cells[y][x].direction == nil do
		grid.cells[y][x].state = "roadV"
		y = y + 1
		if grid.cells[y][x].state == "finish" then return grid.cells[y][x].direction, x, y end
		if grid.cells[y][x].direction ~= nil then
			if grid.cells[y][x].direction == "left" then
				grid.cells[y][x].state = "LR"
			else
				grid.cells[y][x].state = "LL"
			end

			return grid.cells[y][x].direction, x, y
		end
	end
end

function Level:generateRoad()
	if grid.cells[y][x].state == "finish" then return end

	if direction == "left" then
		direction, x, y = self:moveLeft()
	end

	if direction == "right" then
		direction, x, y = self:moveRight()
	end

	if direction == "up" then
		direction, x, y = self:moveUp()
	end

	if direction == "down" then
		direction, x, y = self:moveDown()
	end

	self:generateRoad()
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