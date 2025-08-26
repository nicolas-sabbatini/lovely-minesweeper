local gui_builder = require("vendors.kiss_ui")
local tree = gui_builder()

local input = require("vendors.simple_keyboard")

local modal_width = GAME_WIDTH * 0.5
local modal_height = GAME_HEIGHT * 0.5
local root_x = GAME_WIDTH * 0.25
local root_y = GAME_HEIGHT * 0.25
local padding = 15

---@param self ui_component
local function custom_draw(self)
	GUI_DARK:render(self.position.x, self.position.y, self.size.width, self.size.height)
end

local is_open = false

local new_game_modal = {}

function new_game_modal.append()
	if is_open then
		return
	end
	is_open = true
end

function new_game_modal.remove()
	is_open = false
end

function new_game_modal.update()
	if not is_open then
		return
	end
	tree:open({
		sizing = {
			width = { t = "fixed", size = modal_width },
			height = { t = "fixed", size = modal_height },
		},
		layout = "top_bottom",
		custom_draw = custom_draw,
	})
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "grow" },
		},
	})
	tree:close()
	tree:open({
		text_align = "center",
		text = { { 0, 0, 0, 1 }, "SIZE" },
		font = FONT_BIG,
		sizing = {
			width = { t = "grow" },
			height = { t = "fit_content" },
		},
	})
	tree:close()
	tree:open({
		text_align = "center",
		text = { { 0, 0, 0, 1 }, "MINES" },
		font = FONT_BIG,
		sizing = {
			width = { t = "grow" },
			height = { t = "fit_content" },
		},
	})
	tree:close()
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "grow" },
		},
	})
	tree:close()
	tree:close()
	tree:calculate_layout(MOUSE_X, MOUSE_Y, root_x, root_y)
end

function new_game_modal.draw()
	if not is_open then
		return
	end
	tree:draw()
end

return new_game_modal
