local new_game_btn = require("gui.top_bar.new_game_btn")
local new_game_modal = require("gui.new_game_modal")

function CMD_ENABLE_NEW_GAME_BTN()
	new_game_btn.enable()
end

function CMD_OPEN_NEW_GAME_MODAL()
	new_game_btn.disable()
	new_game_modal.append()
end

function CMD_CLOSE_NEW_GAME_MODAL()
	new_game_modal.remove()
end
