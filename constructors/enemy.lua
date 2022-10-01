local Enemy = {}
local grid = require("state.game.grid")
Enemy.__index = Enemy

function Enemy.new(settings)
	local instance = setmetatable({}, Enemy)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.width  = settings.width or 50
	instance.height = settings.height or 50
	instance.direction = settings.direction or {1, 1}
	instance.speed = settings.speed or 100
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

function Enemy:containsPoint(x, y)
	return x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height
end

function Enemy:update(dt)
	self:containsPoint()
	self:movement(dt)
end

function Enemy:draw()
	love.graphics.setColor(Colors.green)
	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end

return Enemy