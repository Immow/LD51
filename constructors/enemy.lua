local Enemy = {}
local grid = require("state.game.grid")
Enemy.__index = Enemy
local id = 1

function Enemy.new(settings)
	local instance = setmetatable({}, Enemy)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.width  = settings.width or 50
	instance.height = settings.height or 50
	instance.radius = settings.width / 2 - 10
	instance.direction = settings.direction or {x = 1, y = 1}
	instance.speed = settings.speed or 10
	instance.health = settings.health or 100
	instance.id = id
	id = id + 1
	return instance
end

function Enemy:movement(dt)
	if self.direction.x ~= 0 then
		self.x = self.x + (self.direction.x * self.speed * dt)
	end

	if self.direction.y ~= 0 then
		self.y = self.y + (self.direction.y * self.speed * dt)
	end
end

function Enemy:getPosition()
	return {x = self.x, y = self.y}
end

function Enemy:containsPoint()
	-- local x = 0
	-- local y = 0
	for i = 1, #grid.cells do
		for j = 1, #grid.cells[i] do
			local cell = grid.cells[i][j]
			-- if cell.x >= self.x and cell.x <= self.x + self.width and cell.y >= self.y and cell.y <= self.y + self.height then
			if cell.x >= self.x - 0.5 and cell.x <= self.x + 0.5 and cell.y >= self.y - 0.5 and cell.y <= self.y + 0.5 then
				return cell
			end
		end
	end

end

function Enemy:update(dt)
	if self:containsPoint() then
		if self:containsPoint().direction.x ~= 0 or self:containsPoint().direction.y ~= 0 then
			print(self:containsPoint().direction.x)
			self.direction = self:containsPoint().direction
		end
	end
	self:movement(dt)
end

function Enemy:draw()
	love.graphics.setColor(Colors.green)
	-- love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, self.radius)
end

return Enemy