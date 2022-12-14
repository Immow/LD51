local newButton = require("constructors.button")

local MenuMain = {}

local buttonList = {
	{name = "Play "   , func = State.setScene, argument = "state.game.game"},
	{name = "Settings", func = State.setScene, argument = "state.menu.menu_settings"},
	{name = "Credits" , func = State.setScene, argument = "state.menu.menu_credits"},
	{name = "Quit"    , func = love.event.quit},
}

local logo = {}
-- logo.img = love.graphics.newImage("assets/logo/logo.png")
-- logo.imgWidth = logo.img:getWidth()

function MenuMain:load()
	self:generateButtons()
end

function MenuMain:generateButtons()
	local x = Settings.ww / 2 - Settings.button.width / 2
	local y = Settings.wh / 2 - (Settings.button.padding * (#buttonList - 1) + #buttonList * Settings.button.height) / 2
	MenuMain.buttons = {}
	for i = 1, #buttonList do
		MenuMain.buttons[i] = newButton.new({
			x        = x,
			y        = y,
			width    = Settings.button.width,
			height   = Settings.button.height,
			text     = buttonList[i]["name"],
			func     = buttonList[i]["func"],
			font     = ButtonFont,
			argument = buttonList[i]["argument"]
		})
		y = y + Settings.button.height + Settings.button.padding
	end
end

function MenuMain:draw()
	for i = 1, #MenuMain.buttons do
		MenuMain.buttons[i]:draw()
	end

	love.graphics.setFont(Default)
	love.graphics.setColor(Colors.setColorAndAlpha({color = Colors.white, alpha = 0.5}))
	love.graphics.print("v "..Settings.version, 5, 5)
	love.graphics.setColor(1,1,1)
	-- love.graphics.draw(logo.img, Settings.ww / 2 - logo.imgWidth / 2, 20)
end

function MenuMain:update(dt)
	for i = 1, #MenuMain.buttons do
		MenuMain.buttons[i]:update(dt)
	end
end

function MenuMain:mousepressed(x,y,button,istouch,presses)
	for i = 1, #MenuMain.buttons do
		MenuMain.buttons[i]:mousepressed(x,y,button,istouch,presses)
	end
end

function MenuMain:mousereleased(x,y,button,istouch,presses)
	for i = 1, #MenuMain.buttons do
		MenuMain.buttons[i]:mousereleased(x,y,button,istouch,presses)
	end
end

return MenuMain