Enemies = {}
local enemy = require("constructors.enemy")
local gold = require("state.game.gold")
Enemies.active = {}

function Enemies:load()
	self.active = nil
	self.active = {}
	Settings.game.running = true
	self:generateEnemy()
	self:gameTick()
end

function Enemies:gameTick()
	Timer.new(10,  function () Enemies:gameTick() end)
	if Settings.game.wave % 5 == 0 then
		table.insert(self.active, enemy.new({
				x = Settings.boardOffsetX + Settings.cellSize * 9,
				y = Settings.boardOffsetY + Settings.cellSize * 0,
				width = 50,
				height = 50,
				direction = {x = 0, y = 1},
				hp = Settings.game.enemyHP * 2,
				speed = 50,
				id = "boss"
			})
		)
		if Settings.game.spawnRate > 2 then
			Settings.game.spawnRate = Settings.game.spawnRate - 1
		end
	end

	if Settings.game.wave % 5 == 0 then
		gold:increaseCost()
	end

	if Settings.game.enemySpeed < 200 then
		Settings.game.enemySpeed = Settings.game.enemySpeed + 1
	end

	Settings.game.enemyHP = Settings.game.enemyHP + 1
	Settings.game.wave = Settings.game.wave + 1
	print(Settings.game.wave, gold.cost)
end

function Enemies:generateEnemy()
	table.insert(self.active, enemy.new({
			x = Settings.boardOffsetX + Settings.cellSize * 9,
			y = Settings.boardOffsetY + Settings.cellSize * 0,
			width = 50,
			height = 50,
			direction = {x = 0, y = 1},
			hp = Settings.game.enemyHP,
			speed = Settings.game.enemySpeed,
		})
	)
	Timer.new(Settings.game.spawnRate, function () Enemies:generateEnemy() end)
	-- print(Settings.game.spawnRate)
end

function Enemies:drawEnemies()
	for i = #self.active, 1, -1 do
		self.active[i]:draw()
	end
end

function Enemies:draw()
	self:drawEnemies()
	-- love.graphics.print(#self.active)
end

function Enemies:update(dt)
	if Settings.game.running then
		for i = #self.active, 1, -1 do
			self.active[i]:update(dt)
			if self.active[i]:remove() then
				gold:addGold(5)
				table.remove(self.active, i)
			end
		end
	end
end

function Enemies:mousepressed(x,y,button,istouch,presses)

end

function Enemies:mousereleased(x,y,button,istouch,presses)

end

return Enemies