local Settings = {}

Settings.ww, Settings.wh = love.graphics.getDimensions()
Settings.focused = true

Settings.button = {}
Settings.button.width = 120
Settings.button.height = 50
Settings.button.padding = 5

Settings.cellSize = 50
Settings.boardOffsetX = 10
Settings.boardOffsetY = 10
Settings.boardSizeX = 10
Settings.boardSizeY = 10

Settings.game = {
	spawnRate = 5,
	enemySpeed = 100,
	enemyHP = 10,
	wave = 1,
	running = false,
}

-- stuff we save in config.cfg
Settings.problemNr = 1
Settings.markAndCross = true
Settings.hints = true
Settings.validation = true
Settings.displayTime = true
Settings.sfxVolume = 0.5
Settings.musicVolume = 0.5
Settings.displayTouch = true
Settings.version = 0.01

-- stuff we save in game.dat
-- Settings.game = {state = {}, time = {}, size = {}, displayWinAnimation = {}}

return Settings