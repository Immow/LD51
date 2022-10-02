local Bullet = {}
Bullet.__index = Bullet

function Bullet.new(settings)
	Sound:play("shoot", "shoot", Settings.sfxVolume, 1)
	local instance = setmetatable({}, Bullet)
	instance.x      = settings.x or 0
	instance.y      = settings.y or 0
	instance.targetX = settings.targetX
	instance.targetY = settings.targetY
	instance.radius = 5
	instance.alive = true
	instance.target = settings.target
	instance.dmg = settings.dmg or 1
	Flux.to(instance, settings.speed, {x = settings.targetX, y = settings.targetY})
	return instance
end

function Bullet:detectEnemy(dt)
	local distanceX = self.x - self.targetX
	local distanceY = self.y - self.targetY
	local enemyRadius = self.target.radius
	local distance = math.sqrt((distanceX * distanceX) + (distanceY * distanceY))
	if distance <= self.radius + enemyRadius then
		self.alive = false
		self.target.hp = self.target.hp - self.dmg
	end
end

function Bullet:update(dt)
	self:detectEnemy(dt)
end

function Bullet:draw()
	love.graphics.circle("line", self.x, self.y, self.radius)
end

return Bullet