local Grid = {}
local cell = require("constructors.cell")
-- local enemies = require("state.game.enemies")

function Grid:load()
	self:generateGrid(Settings.boardSizeX, Settings.boardSizeY)
end

function Grid:generateGrid(r, c)
	self.cells = {}
	self.x = Settings.boardOffsetX
	self.y = Settings.boardOffsetY
	for i = 1, c do
		self.cells[i] = {}
		for j = 1, r do
			local x = self.x + Settings.cellSize * (j - 1)
			local newCell = cell.new({x = x, y = self.y, width = Settings.cellSize, height = Settings.cellSize, id = 0, position = {y = i, x = j}})
			self.cells[i][j] = newCell
		end
		self.y = self.y + Settings.cellSize
	end
end

function Grid:drawGrid()
	for i = 1, #self.cells do
		for j = 1, #self.cells[i] do
			self.cells[i][j]:draw("empty")
		end
	end
end

function Grid:draw()
	self:drawGrid()
end

function Grid:update(dt)
	for i = 1, #self.cells do
		for j = 1, #self.cells[i] do
			self.cells[i][j]:update(dt)
		end
	end
end

function Grid:mousepressed(x,y,button,istouch,presses)
	for i = 1, #self.cells do
		for j = 1, #self.cells[i] do
			if self.cells[i][j]:containsPoint(x, y) then
				if self.cells[i][j].state == "empty" then
					self.cells[i][j].state = "tower"
				end
			end
		end
	end
end

function Grid:mousereleased(x,y,button,istouch,presses)

end

return Grid