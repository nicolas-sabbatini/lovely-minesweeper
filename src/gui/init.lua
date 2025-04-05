local top_bar = require("gui.top_bar")
local new_game_modal = require("gui.new_game_modal")

local gui = {}

function gui.update(dt)
	top_bar.update()
	new_game_modal.update()
end

function gui.draw()
	top_bar.draw()
	new_game_modal.draw()
end

return gui
