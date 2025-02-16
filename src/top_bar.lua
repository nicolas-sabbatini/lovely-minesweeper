local p = require("vendors.pizza")

local canvas = LETTERBOX.newLetterbox({
	type = "constant",
	position = { x = 0, y = 0 },
	size = {
		width = GAME_WIDTH,
		height = 64,
	},
} --[[@as letterbox.Upscale.Constant]], "top_bar")
MAIN_SCREEN:addChildren(canvas)

local slice = p.fromRec(GUI, 0, 0, 16 * 3, 16 * 3)
slice:resize(GAME_WIDTH, 64)

local top_bar = {}

function top_bar.draw()
	canvas:drawInsideRig()
	slice:render(0, 0)
	canvas:stopDrawInsideRig()
end

return top_bar
