local Gold = {amount = 30, cost = 10, upgrade1 = 25, upgrade2 = 55}


function Gold:buyTower()
	if self.amount >= self.cost then
		self.amount = self.amount - 10
		return true
	end
end

function Gold:buyUpgrade1()
	if self.amount >= self.upgrade1 then
		self.amount = self.amount - self.upgrade1
		return true
	end
end

function Gold:buyUpgrade2()
	if self.amount >= self.upgrade2 then
		self.amount = self.amount - self.upgrade2
		return true
	end
end

function Gold:addGold(n)
	self.amount = self.amount + n
end

function Gold:increaseCost()
	self.cost = self.cost + 5
end

return Gold