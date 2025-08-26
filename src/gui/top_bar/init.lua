local gui_builder = require("vendors.kiss_ui")
local tree = gui_builder()

local new_game_btn = require("gui.top_bar.new_game_btn")
new_game_btn.set_tree(tree)

local top_bar = {}

function top_bar.update()
	tree:open({
		sizing = {
			width = { t = "fixed", size = GAME_WIDTH },
			height = { t = "fixed", size = 64 },
		},
		custom_draw = function(self)
			GUI_DARK:render(self.position.x, self.position.y, self.size.width, self.size.height)
		end,
	})
	new_game_btn.update()
	tree:close()

	tree:calculate_layout(MOUSE_X, MOUSE_Y)
end

function top_bar.draw()
	tree:draw()
end

return top_bar
