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
		child_gap = 10,
		custom_draw = custom_draw,
	})
	-- Margin top
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "grow" },
		},
	})
	tree:close()
	-- End
	-- Game size
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
		sizing = {
			width = { t = "grow" },
			height = { t = "fit_content" },
		},
		child_gap = 10,
	})
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "grow" },
		},
	})
	tree:close()
	tree:open({
		text = "SMALL",
		text_align = "center",
		font = FONT_MEDIUM,
		padding = { left = 5, right = 5, top = 5, bottom = 5 },
		sizing = {
			width = { t = "fixed", size = 100 },
			height = { t = "fixed", size = 20 },
		},
	})
	tree:close()
	tree:open({
		text = "MEDIUM",
		text_align = "center",
		font = FONT_MEDIUM,
		padding = { left = 5, right = 5, top = 5, bottom = 5 },
		sizing = {
			width = { t = "fixed", size = 100 },
			height = { t = "fixed", size = 20 },
		},
	})
	tree:close()
	tree:open({
		text = "LARGE",
		text_align = "center",
		font = FONT_MEDIUM,
		padding = { left = 5, right = 5, top = 5, bottom = 5 },
		sizing = {
			width = { t = "fixed", size = 100 },
			height = { t = "fixed", size = 20 },
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
	-- End game size
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "grow" },
		},
	})
	tree:close()
	-- Amount mines
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
			height = { t = "fit_content" },
		},
		child_gap = 10,
	})
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "grow" },
		},
	})
	tree:close()
	tree:open({
		text = "10",
		text_align = "center",
		font = FONT_MEDIUM,
		padding = { left = 5, right = 5, top = 5, bottom = 5 },
		sizing = {
			width = { t = "fixed", size = 100 },
			height = { t = "fixed", size = 20 },
		},
	})
	tree:close()
	tree:open({
		text = "20",
		text_align = "center",
		font = FONT_MEDIUM,
		padding = { left = 5, right = 5, top = 5, bottom = 5 },
		sizing = {
			width = { t = "fixed", size = 100 },
			height = { t = "fixed", size = 20 },
		},
	})
	tree:close()
	tree:open({
		text = "30",
		text_align = "center",
		font = FONT_MEDIUM,
		padding = { left = 5, right = 5, top = 5, bottom = 5 },
		sizing = {
			width = { t = "fixed", size = 100 },
			height = { t = "fixed", size = 20 },
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

	-- End mines
	-- Margin bottom
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "grow" },
		},
	})
	tree:close()
	-- End margin
	tree:open({
		sizing = {
			width = { t = "grow" },
			height = { t = "fixed", size = 30 },
		},
		child_gap = 10,
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
