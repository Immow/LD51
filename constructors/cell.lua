local Cell = {}
Cell.__index = Cell

function Cell.new(settings)
	local instance = setmetatable({}, Cell)
	instance.x                   = settings.x or 0
	instance.y                   = settings.y or 0
	instance.width               = settings.width or 10
	instance.height              = settings.height or 10
	instance.id                  = settings.id or 0
	instance.position            = settings.position
	instance.state               = "empty"
	return instance
end

function Cell:getId()
	return self.id
end

function Cell:containsPoint(x, y)
	return x >= self.x and x <= self.x + self.width and y >= self.y and y <= self.y + self.height
end

function Cell:containsPointX(x)
	return x > self.x and x < self.x + self.width
end

function Cell:containsPointY(y)
	return y > self.y and y < self.y + self.height
end

function Cell:getPosition()
	return self.position.x, self.position.y
end

function Cell:printPosition()
	print("x: "..self.position.x..", y: "..self.position.y)
end

function Cell:update(dt)

end

function Cell:drawState(drawState)
	if self.state == "empty" then
		love.graphics.setColor(Colors.white24)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	else
		love.graphics.setColor(Colors.white24)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	end
end

function Cell:draw(drawState)
	self:drawState(drawState)

	if debug then
		love.graphics.setColor(1,0,0)
		-- love.graphics.print("i: "..self.position.x.." j: "..self.position.y, self.x, self.y+15)
		-- love.graphics.print("id: "..self.id, self.x, self.y)
		love.graphics.print(self.state, self.x, self.y)
	end
end

return Cell