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

function love.update(dt)
	local x, y = love.mouse.getPosition()

	local rigs_world_positions = MAIN_SCREEN:parentToRigsWorld(x, y)
	MOUSE_WORLD_POSITIONS = {}
	for _, v in pairs(rigs_world_positions) do
		MOUSE_WORLD_POSITIONS[v.name] = v.coordinates
	end

	local rigs_screen_positions = MAIN_SCREEN:parentToRigsScreen(x, y)
	MOUSE_SCREEN_POSITIONS = {}
	for _, v in pairs(rigs_screen_positions) do
		MOUSE_SCREEN_POSITIONS[v.name] = v.coordinates
	end

	top_bar.update(dt)
end

function love.draw()
	top_bar.draw()

	MAIN_SCREEN:drawInsideRig()
	love.graphics.clear(COLOR_PALETT.GARY_DARK)
	MAIN_SCREEN:stopDrawInsideRig()

	MAIN_SCREEN:draw()
end
