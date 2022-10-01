local Enemies = {}
local enemy = require("constructors.enemy")
-- local grid = require("state.game.grid")
Enemies.active = {}

function Enemies:load()
	self:generateEnemy()
end

function Enemies:generateEnemy()
	self.active = {}
	table.insert(self.active, enemy.new({
			x = Settings.boardOffsetX + Settings.cellSize * 9,
			y = Settings.boardOffsetY + Settings.cellSize * 0,
			width = 50,
			height = 50,
			direction = {x = 0, y = 1},
		})
	)
end

function Enemies:drawEnemies()
	for i = #self.active, 1, -1 do
		self.active[i]:draw()
	end
end

function Enemies:draw()
	self:drawEnemies()
end

function Enemies:update(dt)
	for i = #self.active, 1, -1 do
		self.active[i]:update(dt)
	end
end

function Enemies:mousepressed(x,y,button,istouch,presses)

end

function Enemies:mousereleased(x,y,button,istouch,presses)

end

return Enemies