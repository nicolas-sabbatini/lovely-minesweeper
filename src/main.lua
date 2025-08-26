-- Load global variables
require("globals")
require("commands")

-- Load vendors
local letterbox = require("vendors.letterbox")
local input = require("vendors.simple_keyboard")

-- Load game
local gui = require("gui")

love.graphics.setDefaultFilter("nearest", "nearest")

function love.resize(w, h)
	letterbox.resize(w, h)
end

function love.load()
	letterbox.init(GAME_WIDTH, GAME_HEIGHT)
end

function love.update(dt)
	-- Update globals
	local x, y = love.mouse.getPosition()
	MOUSE_X, MOUSE_Y = letterbox.to_game(x, y)
	input.updateInput()
	-- Update components
	gui.update(dt)
end

function love.draw()
	letterbox.start()
	love.graphics.clear(COLOR_PALETT.GARY_DARK)
	gui.draw()
	letterbox.finish()
	letterbox.present()
end
