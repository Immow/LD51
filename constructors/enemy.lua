local Enemy = {}
local grid = require("state.game.grid")
Enemy.__index = Enemy
local id = 1

function Enemy.new(settings)
	local instance = setmetatable({}, Enemy)
	instance.x         = settings.x or 0
	instance.y         = settings.y or 0
	instance.width     = settings.width or 50
	instance.height    = settings.height or 50
	instance.radius    = settings.width / 2 - 10
	instance.direction = settings.direction or "down"
	instance.vec2      = {x = 0, y = -1}
	instance.speed     = settings.speed or 10
	instance.hp        = settings.hp or 100
	return instance
end

function Enemy:movement(dt)
	if self.vec2.x ~= 0 then
		self.x = self.x + (self.vec2.x * self.speed * dt)
	end

	if self.vec2.y ~= 0 then
		self.y = self.y + (self.vec2.y * self.speed * dt)
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
			if cell.x >= self.x - 0.5 and
				cell.x <= self.x + 0.5 and
				cell.y >= self.y - 0.5 and
				cell.y <= self.y + 0.5
			then
				return cell
			end
		end
	end
end

function Enemy:remove()
	if self.hp <= 0 then
		return true
	end
end

function Enemy:update(dt)
	if self:containsPoint() then
		local cell = self:containsPoint()
		if cell.direction == "up" then
			self.vec2 = {x = 0, y = -1}
		elseif cell.direction == "down" then
			self.vec2 = {x = 0, y = 1}
		elseif cell.direction == "left" then
			self.vec2 = {x = -1, y = 0}
		elseif cell.direction == "right" then
			self.vec2 = {x = 1, y = 0}
		elseif self:containsPoint().state == "finish" then
			self.hp = 0
		end
	end
	self:movement(dt)
end

function Enemy:draw()
	love.graphics.setColor(Colors.green)
	-- love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, self.radius)
	love.graphics.setColor(Colors.white)
	love.graphics.print(self.hp, self.x + self.width / 2, self.y + self.height / 2)
end

return Enemy