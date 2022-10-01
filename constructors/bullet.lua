local Bullet = {}
Bullet.__index = Bullet
-- local angle = 0
-- local activeBullets = {}
function Bullet.new(settings)
	local instance = setmetatable({}, Bullet)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.width  = settings.width or 100
	instance.height = settings.height or 50
	instance.alive = true
	instance.speed = 20
	-- table.insert(activeBullets, instance)
	Flux.to(instance, 1, {x = settings.targetX, y = settings.targetY})
	return instance
end

function Bullet:getAngle()

end

function Bullet:update(dt)

end

function Bullet:draw()
	love.graphics.circle("line", self.x, self.y, 5)
end

return Bullet