local newButton   = require("constructors.button")
local row         = require("constructors.row")
local text        = require("constructors.text")
local slider      = require("constructors.slider")

local MenuSettings = {}

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
	row.new({x = centerRow, y = get_y_position(2), width = rowWidth, height = rowHeight}),
	row.new({x = centerRow, y = get_y_position(3), width = rowWidth, height = rowHeight}),
}

local labelSettings = {
	{name = "Audio", font = TitleFont, offset = 0, color = Colors.blue[300]},
	{name = "SFX", font = SettingsFont},
	{name = "Music", font = SettingsFont},
}

local labels = {}
local sliders = {
	slider.new({x = rows[2].x, y = rows[2].y, parrent_height = rowHeight, parrent_width = rowWidth, id = "sfxVolume"}),
	slider.new({x = rows[3].x, y = rows[3].y, parrent_height = rowHeight, parrent_width = rowWidth, id = "musicVolume"}),
}

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

function MenuSettings:load()
	self:generateButtons()
	generateLabels()
end

function MenuSettings:generateButtons()
	MenuSettings.buttons = {}
	local x = Settings.ww - (Settings.button.width + Settings.button.padding)
	local y = Settings.wh - (Settings.button.height + Settings.button.padding)
	for i = 1, #buttonList do
		MenuSettings.buttons[i] = newButton.new({
			x        = x,
			y        = y, width                  = Settings.button.width,
			height   = Settings.button.height,
			text     = buttonList[i]["name"],
			func     = buttonList[i]["func"],
			font     = ButtonFont,
			argument = buttonList[i]["argument"],
		})
		y = y + Settings.button.height + Settings.button.padding
	end
end


function MenuSettings:draw()
	for i = 1, #rows do
		rows[i]:draw()
		labels[i]:draw()
	end

	for i = 1, #MenuSettings.buttons do
		MenuSettings.buttons[i]:draw()
	end

	for i = 1, #sliders do
		sliders[i]:draw()
	end
end

function MenuSettings:update(dt)
	for i = 1, #MenuSettings.buttons do
		MenuSettings.buttons[i]:update(dt)
	end

	for i = 1, #sliders do
		sliders[i]:update(dt)
	end
end

function MenuSettings:mousepressed(x,y,button,istouch,presses)
	for i = 1, #MenuSettings.buttons do
		MenuSettings.buttons[i]:mousepressed(x,y,button,istouch,presses)
	end
end

function MenuSettings:mousereleased(x,y,button,istouch,presses)
	for i = 1, #MenuSettings.buttons do
		MenuSettings.buttons[i]:mousereleased(x,y,button,istouch,presses)
	end
end

return MenuSettings