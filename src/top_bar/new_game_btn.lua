local p = require("vendors.pizza")

local btn_name = "new_game_btn"

local text = love.graphics.newText(FONT_MEDIUM, "NEW GAME")
local tw, th = text:getDimensions()
local padding = 30
local btn_w, btn_h = tw + padding, th + padding

local selected = false

local canvas = LETTERBOX.newLetterbox({
	type = "constant",
	position = { x = (GAME_WIDTH - btn_w) / 2, y = (64 - btn_h) / 2 },
	size = {
		width = btn_w,
		height = btn_h,
	},
} --[[@as letterbox.Upscale.Constant]], btn_name)
-- Position 1
local base = p.fromRec(GUI, GUI_9_SIZE, 0, GUI_9_SIZE, GUI_9_SIZE)
base:resize(btn_w, btn_h)
-- Position 2
local acent = p.fromRec(GUI, GUI_9_SIZE * 2, 0, GUI_9_SIZE, GUI_9_SIZE)
acent:resize(btn_w, btn_h)

local new_game_btn = {}

function new_game_btn.get()
	return canvas
end

function new_game_btn.update(dt)
	if MOUSE_SCREEN_POSITIONS[btn_name] then
		selected = true
	else
		selected = false
	end

	if selected and INPUT.mouse.justPressed(1) then
		Tape.log("debug", "click")
	end
end

function new_game_btn.draw()
	canvas:drawInsideRig()
	love.graphics.clear()
	base:render(0, 0)
	if selected then
		love.graphics.draw(text, padding / 2, padding / 2)
		acent:render(0, 0)
	else
		love.graphics.setColor(0, 0, 0)
		love.graphics.draw(text, padding / 2, padding / 2)
		love.graphics.setColor(1, 1, 1)
	end
	canvas:stopDrawInsideRig()
end

return new_game_btn
