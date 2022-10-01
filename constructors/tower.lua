local Tower = {}
Tower.__index = Tower

function Tower.new(settings)
	local instance = setmetatable({}, Tower)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.width  = settings.width or 100
	instance.height = settings.height or 50
	return instance
end

function Tower:update(dt)
	
end

function Tower:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Tower