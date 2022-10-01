local Cell = {}
Cell.__index = Cell
-- local enemies = require("state.game.enemies")

function Cell.new(settings)
	local instance = setmetatable({}, Cell)
	instance.x                   = settings.x or 0
	instance.y                   = settings.y or 0
	instance.width               = settings.width or 10
	instance.height              = settings.height or 10
	instance.id                  = settings.id or 0
	instance.position            = settings.position
	instance.state               = "empty"
	instance.direction           = settings.direction or {x = 0, y = 0}
	instance.range               = settings.range or 100
	instance.attack              = false
	return instance
end

function Cell:getId()
	return self.id
end

function Cell:containsPoint(x, y)
	return x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height
end

function Cell:getPosition()
	return self.position.x, self.position.y
end

function Cell:getEnemyPosition()
	for i = 1, #Enemies.active do
		return Enemies.active[i]:getPosition()
	end
end

function Cell:detectCollision()
	-- float distX = c1x - c2x;
	-- float distY = c1y - c2y;
	-- float distance = sqrt( (distX*distX) + (distY*distY) );
  
	-- // if the distance is less than the sum of the circle's
	-- // radii, the circles are touching!
	-- if (distance <= c1r+c2r) {
	--   return true;
	-- }
	-- return false;


end

function Cell:detectEnemy()
	if self.state ~= "tower" then return end
	for i = 1, #Enemies.active do
		-- return Enemies.active[i]:getPosition()
		local distanceX = self.x - Enemies.active[i]:getPosition().x
		local distanceY = self.y - Enemies.active[i]:getPosition().y
		local enemyRadius = Enemies.active[i].radius
		local distance = math.sqrt((distanceX * distanceX) + (distanceY * distanceY))
		if distance <= self.range + enemyRadius then
			self.attack = true
		else
			self.attack = false
		end
	end
end

function Cell:printPosition()
	print("x: "..self.position.x..", y: "..self.position.y)
end

function Cell:update(dt)
	-- self:getEnemyPosition()
	self:detectEnemy()
end

function Cell:drawState(drawState)
	if self.state == "tower" then
		love.graphics.setColor(Colors.purple)
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
		love.graphics.circle("line", self.x + self.width / 2, self.y + self.height / 2, self.range)
		if self.attack then
			love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, self.range)
		end
	else
		love.graphics.setColor(Colors.white24)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	end

	if self.direction.x ~= 0 or self.direction.y ~= 0 then
		love.graphics.setColor(Colors.yellow)
		love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	end
end

function Cell:draw(drawState)
	self:drawState(drawState)

	if debug then
		love.graphics.setColor(1,0,0)
		-- love.graphics.print("i: "..self.position.x.." j: "..self.position.y, self.x, self.y+15)
		-- love.graphics.print("id: "..self.id, self.x, self.y)
		love.graphics.print(self.direction.x.."\n"..self.direction.y, self.x, self.y)
	end
end

return Cell