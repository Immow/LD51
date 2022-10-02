Enemies            = require("state.game.enemies")
local grid         = require("state.game.grid")
local level        = require("state.game.level")
local gold         = require("state.game.gold")

local Game = {}

function Game:load()
	Settings:load()
	Timer:removeAll()
	grid:load()
	level:load()
	Enemies:load()
	gold:load()
end

function Game:draw()
	grid:draw()
	Enemies:draw()
	gold:draw()
end

function Game:update(dt)
	grid:update(dt)
	Enemies:update(dt)
end

function Game:keypressed(key,scancode,isrepeat)

end

function Game:keyreleased(key,scancode)
	-- grid:keyreleased(key,scancode)
end

function Game:mousepressed(x,y,button,istouch,presses)
	grid:mousepressed(x,y,button,istouch,presses)
	level:mousepressed(x,y,button,istouch,presses)
end

function Game:mousereleased(x,y,button,istouch,presses)
	grid:mousereleased(x,y,button,istouch,presses)
	level:mousereleased(x,y,button,istouch,presses)
end

return Game