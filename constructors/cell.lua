local Cell = {}
local bullet = require("constructors.bullet")

Cell.__index = Cell

local activeBullets = {}
local roadV = love.graphics.newImage("assets/road/v1.png")
local roadH = love.graphics.newImage("assets/road/h1.png")
local UL = love.graphics.newImage("assets/road/UL.png")
local UR = love.graphics.newImage("assets/road/UR.png")
local LR = love.graphics.newImage("assets/road/LR.png")
local LL = love.graphics.newImage("assets/road/LL.png")
local t1 = love.graphics.newImage("assets/tower/1.png")
local t2 = love.graphics.newImage("assets/tower/2.png")
local t3 = love.graphics.newImage("assets/tower/3.png")
local start = love.graphics.newImage("assets/start/start.png")
local finish = love.graphics.newImage("assets/finish/finish.png")

function Cell.new(settings)
	local instance = setmetatable({}, Cell)
	instance.x                   = settings.x or 0
	instance.y                   = settings.y or 0
	instance.width               = settings.width or 10
	instance.height              = settings.height or 10
	instance.id                  = settings.id or 0
	instance.position            = settings.position
	instance.state               = "empty"
	instance.direction           = settings.direction or nil
	instance.range               = settings.range or 100
	instance.attack              = false
	instance.taget               = nil
	instance.targetObject        = nil
	instance.time                = 1
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

function Cell:detectEnemy(dt)
	if self.state == "tower" or self.state == "tower1" or self.state == "tower2" then
		self.time = self.time - 1 * dt
		for i = #Enemies.active, 1, -1 do
			local distanceX = self.x - Enemies.active[i]:getPosition().x
			local distanceY = self.y - Enemies.active[i]:getPosition().y
			local enemyRadius = Enemies.active[i].radius
			local distance = math.sqrt((distanceX * distanceX) + (distanceY * distanceY))
			if distance <= self.range + enemyRadius then
				self:shoot(Enemies.active[i], dt)
			end
		end
	end
end

function Cell:shoot(target, dt)
	local dmg = 1
	if self.state == "tower1" then
		dmg = 5
	end
	if self.state == "tower2" then
		dmg = 10
	end
	if self.time < 0 then
		self.attack = false
		self.time = 1
	end
	if self.time == 1 and not self.attack then
		self.attack = true
		table.insert(activeBullets, bullet.new({
			x = self.x + self.width / 2,
			y = self.y + self.height / 2,
			targetX = target.x + self.width / 2,
			targetY = target.y + self.height / 2,
			target = target,
			speed = 0.1,
			dmg = dmg,
			})
		)
	end
end

function Cell:printPosition()
	print("x: "..self.position.x..", y: "..self.position.y)
end

function Cell:update(dt)
	self:detectEnemy(dt)
	for i = #activeBullets, 1, -1 do
		activeBullets[i]:update(dt)
		if activeBullets[i].alive == false then
			table.remove(activeBullets, i)
		end
	end
end

function Cell:drawState()
	love.graphics.setColor(Colors.green[800])
	love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
	if self.state == "tower" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(t1, self.x, self.y)
	elseif self.state == "tower1" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(t2, self.x, self.y)
	elseif self.state == "tower2" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(t3, self.x, self.y)
	elseif self.state == "finish" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(finish, self.x, self.y)
		-- love.graphics.setColor(Colors.blue)
		-- love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	elseif self.state == "start" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(start, self.x, self.y)
		-- love.graphics.setColor(Colors.teal)
		-- love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	elseif self.state == "roadV" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(roadV, self.x, self.y)
	elseif self.state == "roadH" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(roadH, self.x, self.y)
	elseif self.state == "UL" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(UL, self.x, self.y)
	elseif self.state == "UR" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(UR, self.x, self.y)
	elseif self.state == "LR" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(LR, self.x, self.y)
	elseif self.state == "LL" then
		love.graphics.setColor(1,1,1)
		love.graphics.draw(LL, self.x, self.y)
	else
		love.graphics.setColor(Colors.white24)
		love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	end

		-- love.graphics.circle("line", self.x + self.width / 2, self.y + self.height / 2, self.range)
		-- if self.attack then
			-- love.graphics.circle("fill", self.x + self.width / 2, self.y + self.height / 2, self.range)
		-- end

	-- if self.direction.x ~= 0 or self.direction.y ~= 0 then
	-- 	love.graphics.setColor(Colors.yellow)
	-- 	love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
	-- end
end

function Cell:drawBullets()
	for i = #activeBullets, 1, -1 do
		activeBullets[i]:draw()
	end
	-- love.graphics.print("\n"..#activeBullets)
end

function Cell:draw()
	self:drawState()
	self:drawBullets()
	if debug then
		-- love.graphics.setColor(1,0,0)
		-- love.graphics.print("i: "..self.position.x.." j: "..self.position.y, self.x, self.y+15)
		-- love.graphics.print("id: "..self.id, self.x, self.y)
		-- love.graphics.print(self.direction.x.."\n"..self.direction.y, self.x, self.y)
	end
end

return Cell