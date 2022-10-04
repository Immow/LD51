local Gold = {amount = 30, cost = 10, upgrade1 = 15, upgrade2 = 45}

function Gold:load()
	self.amount = 30
	self.cost = 10
	self.upgrade1 = 15
	self.upgrade2 = 45
end

function Gold:buyTower()
	if self.amount >= self.cost then
		self.amount = self.amount + self.cost
		return true
	end
end

function Gold:buyUpgrade1()
	if self.amount >= self.upgrade1 + self.cost then
		self.amount = self.amount - (self.upgrade1 + self.cost)
		return true
	end
end

function Gold:buyUpgrade2()
	if self.amount >= self.upgrade2 + self.cost then
		self.amount = self.amount - (self.upgrade2 + self.cost)
		return true
	end
end

function Gold:addGold(n)
	self.amount = self.amount + n
end

function Gold:increaseCost()
	self.cost = self.cost + 5
end

function Gold:draw()
	love.graphics.setFont(TitleFont)
	love.graphics.print("Gold: "..self.amount..
		"\nTower Cost: "..self.cost..
		"\nUpgrade 1 Cost: "..self.cost + self.upgrade1..
		"\nUpgrade 2 Cost: "..self.cost + self.upgrade2,
	Settings.ww - 280)
	love.graphics.setFont(Default)
end

return Gold