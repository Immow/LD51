Enemies = {}
local enemy = require("constructors.enemy")
-- local grid = require("state.game.grid")
Enemies.active = {}

function Enemies:load()
	self.active = {}
	self:generateEnemy()
end

function Enemies:generateEnemy()
	table.insert(self.active, enemy.new({
		x = Settings.boardOffsetX + Settings.cellSize * 9,
		y = Settings.boardOffsetY + Settings.cellSize * 0,
		width = 50,
		height = 50,
		direction = {x = 0, y = 1},
		hp = 10,
		speed = 150,
	})
)
Timer.new(5, function () Enemies:generateEnemy() end)
end

function Enemies:drawEnemies()
	for i = #self.active, 1, -1 do
		self.active[i]:draw()
	end
end

function Enemies:draw()
	self:drawEnemies()
	love.graphics.print(#self.active)
end

function Enemies:update(dt)
	for i = #self.active, 1, -1 do
		self.active[i]:update(dt)
		if self.active[i]:remove() then
			table.remove(self.active, i)
		end
	end
end

function Enemies:mousepressed(x,y,button,istouch,presses)

end

function Enemies:mousereleased(x,y,button,istouch,presses)

end

return Enemies