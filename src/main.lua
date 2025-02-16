require("globals")
local top_bar = require("top_bar")

love.graphics.setDefaultFilter("nearest", "nearest")

function love.resize()
	-- Si bien esta funcion trae el w, h hay casos en los que se buguea.
	-- ya que calculamos unas cosas en el globals si el systema despues detecta que la config
	-- es más grande que la pantalla se hace un resize pero no resizea de verdad
	local w, h = love.graphics.getDimensions()
	MAIN_SCREEN:parentResizeCallback({ width = w, height = h })
end

function love.load() end

function love.update(dt) end

function love.draw()
	top_bar.draw()

	MAIN_SCREEN:drawInsideRig()
	love.graphics.clear(COLOR_PALETT["c_596674"])
	MAIN_SCREEN:stopDrawInsideRig()

	MAIN_SCREEN:draw()
end
