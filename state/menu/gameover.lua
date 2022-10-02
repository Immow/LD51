local newButton   = require("constructors.button")
local row         = require("constructors.row")
local text        = require("constructors.text")

local GameOver = {}

local function backButton()
	State.setScene("state.menu.menu_main")
end

local buttonList = {
	{name = "Back", func = backButton},
}

local startPosition = 100
local rowWidth = 500
local centerRow = Settings.ww / 2 - rowWidth / 2
local rowHeight = 46
local function get_y_position(position)
	if position == 1 then return startPosition end
	local offset = 4
	local y = position * rowHeight + (offset * (position - 1)) + startPosition - rowHeight
	return y
end

local rows = {
	row.new({x = centerRow, y = get_y_position(1), width = rowWidth, height = rowHeight, color = Colors.black}),
}

local labelSettings = {
	{name = "GAME OVER", font = TitleFont, offset = 0, color = Colors.blue[300]},
}

local labels = {}

local function generateLabels()
	labels = {}
	for i = 1, #rows do
		local r = rows[i]
		local l = labelSettings[i]
		table.insert(labels, text.new({
			x      = r.x,
			y      = r.y,
			height = r.height,
			text   = l.name,
			font   = l.font,
			offset = l.offset,
			color  = l.color
		}))
	end
end

function GameOver:load()
	self:generateButtons()
	generateLabels()
	self:Blaat()
end

function GameOver:generateButtons()
	GameOver.buttons = {}
	local x = Settings.ww - (Settings.button.width + Settings.button.padding)
	local y = Settings.wh - (Settings.button.height + Settings.button.padding)
	for i = 1, #buttonList do
		GameOver.buttons[i] = newButton.new({
			x        = x,
			y        = y,
			width    = Settings.button.width,
			height   = Settings.button.height,
			text     = buttonList[i]["name"],
			func     = buttonList[i]["func"],
			font     = ButtonFont,
			argument = buttonList[i]["argument"],
		})
		y = y + Settings.button.height + Settings.button.padding
	end
end


function GameOver:draw()
	for i = 1, #rows do
		rows[i]:draw()
		labels[i]:draw()
	end

	for i = 1, #GameOver.buttons do
		GameOver.buttons[i]:draw()
	end
end

function GameOver:Blaat()
	Flux.to(labels[1], 5, {x = love.math.random(0, Settings.ww), y =love.math.random(0, Settings.wh)})
	Timer.new(5, function () self:Blaat() end)
end

function GameOver:update(dt)
	for i = 1, #GameOver.buttons do
		GameOver.buttons[i]:update(dt)
	end
end

function GameOver:mousepressed(x,y,button,istouch,presses)
	for i = 1, #GameOver.buttons do
		GameOver.buttons[i]:mousepressed(x,y,button,istouch,presses)
	end
end

function GameOver:mousereleased(x,y,button,istouch,presses)
	for i = 1, #GameOver.buttons do
		GameOver.buttons[i]:mousereleased(x,y,button,istouch,presses)
	end
end

return GameOver