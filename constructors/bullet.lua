local Bullet = {}
Bullet.__index = Bullet
-- local angle = 0
-- local activeBullets = {}
function Bullet.new(settings)
	local instance = setmetatable({}, Bullet)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	-- instance.width  = settings.width or 5
	-- instance.height = settings.height or 5
	instance.targetX = settings.targetX
	instance.targetY = settings.targetY
	instance.radius = 5
	instance.alive = true
	instance.target = settings.target
	-- table.insert(activeBullets, instance)
	Flux.to(instance, 1, {x = settings.targetX, y = settings.targetY})
	return instance
end

function Bullet:detectEnemy(dt)
	-- for i = #Enemies.active, 1, -1 do
		local distanceX = self.x - self.targetX
		local distanceY = self.y - self.targetY
		local enemyRadius = self.target.radius
		local distance = math.sqrt((distanceX * distanceX) + (distanceY * distanceY))
		if distance <= self.radius + enemyRadius then
			self.alive = false
			self.target.hp = self.target.hp - 1
		end
	-- end
end

function Bullet:update(dt)
	self:detectEnemy(dt)
end

function Bullet:draw()
	love.graphics.circle("line", self.x, self.y, self.radius)
end

return Bullet