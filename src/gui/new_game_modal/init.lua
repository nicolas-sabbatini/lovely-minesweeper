local pizza = require("vendors.pizza")

local mines = love.graphics.newText(FONT_BIG, "MINES")
local mw, mh = mines:getDimensions()

local size = love.graphics.newText(FONT_BIG, "SIZE")
local sw, sh = size:getDimensions()

local name = "new_game_modal"

local canvas_width = GAME_WIDTH * 0.5
local canvas_height = GAME_HEIGHT * 0.5
local padding = 15

local is_open = false

local canvas = LETTERBOX.newLetterbox({
	type = "constant",
	position = { x = GAME_WIDTH * 0.25, y = GAME_HEIGHT * 0.25 },
	size = {
		width = canvas_width,
		height = canvas_height,
	},
} --[[@as letterbox.Upscale.Constant]], name)
local slice = pizza.fromRec(GUI, 0, 0, GUI_9_SIZE, GUI_9_SIZE)
slice:resize(canvas_width, canvas_height)

local new_game_modal = {}

function new_game_modal.append()
	is_open = true
	MAIN_SCREEN:addChildren(canvas)
end

function new_game_modal.remove()
	is_open = false
	MAIN_SCREEN:removeChildren(name)
end

function new_game_modal.update()
	if not is_open then
		return
	end
end

function new_game_modal.draw()
	if not is_open then
		return
	end
	canvas:drawInsideRig()
	love.graphics.clear()
	slice:render(0, 0)
	love.graphics.setColor(COLOR_PALETT.BLACK)
	love.graphics.draw(mines, (canvas_width - mw) / 2, padding)
	love.graphics.draw(size, (canvas_width - sw) / 2, padding * 4)
	love.graphics.setColor(COLOR_PALETT.WHITE)
	canvas:stopDrawInsideRig()
end

return new_game_modal
