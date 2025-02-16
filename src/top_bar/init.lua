local p = require("vendors.pizza")
local new_game_btn = require("top_bar.new_game_btn")

local canvas = LETTERBOX.newLetterbox({
	type = "constant",
	position = { x = 0, y = 0 },
	size = {
		width = GAME_WIDTH,
		height = 64,
	},
} --[[@as letterbox.Upscale.Constant]], "top_bar")
canvas:addChildren(new_game_btn.get())
MAIN_SCREEN:addChildren(canvas)

local slice = p.fromRec(GUI, 0, 0, GUI_9_SIZE, GUI_9_SIZE)
slice:resize(GAME_WIDTH, 64)

local top_bar = {}

function top_bar.update(dt)
	new_game_btn.update(dt)
end

function top_bar.draw()
	new_game_btn.draw()

	canvas:drawInsideRig()
	love.graphics.clear()
	slice:render(0, 0)
	canvas:stopDrawInsideRig()
end

return top_bar
