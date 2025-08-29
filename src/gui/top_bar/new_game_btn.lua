local input = require("vendors.simple_keyboard")

local text = love.graphics.newText(FONT_BIG, "NEW GAME")
local tw, th = text:getDimensions()
local padding = 30

local can_click = true

---@type ui_tree?
local tree = nil

---@param self ui_component
local function custom_draw(self)
	if can_click and self.is_hover then
		GUI_LIGHT_SELECTED:render(self.position.x, self.position.y, self.size.width, self.size.height)
	else
		GUI_LIGHT:render(self.position.x, self.position.y, self.size.width, self.size.height)
		love.graphics.setColor(0, 0, 0)
	end
	love.graphics.printf(
		self.text,
		self.font,
		self.position.x + self.padding.left,
		self.position.y + self.padding.top - 2,
		self.size.width - self.padding.right - self.padding.left,
		self.text_align
	)
	love.graphics.setColor(1, 1, 1)
end

---@param self ui_component
local function update(self)
	if can_click and self.is_hover and input.mouse.justPressed(1) then
		CMD_OPEN_NEW_GAME_MODAL()
	end
end

local new_game_btn = {}

function new_game_btn.set_tree(new_tree)
	tree = new_tree
end

function new_game_btn.update()
	if not tree then
		return
	end
	tree:open({ sizing = { width = { t = "grow" }, height = { t = "grow" } } })
	tree:close()

	tree:open({
		layout = "top_bottom",
		sizing = {
			width = { t = "fit_content" },
			height = { t = "grow" },
		},
	})

	tree:open({ sizing = { width = { t = "grow" }, height = { t = "grow" } } })
	tree:close()

	tree:open({
		padding = { left = padding, right = padding, top = padding / 3, bottom = padding / 3 },
		sizing = {
			width = { t = "fixed", size = tw + padding * 2 },
			height = { t = "fixed", size = th + padding / 3 },
		},
		text = "NEW GAME",
		text_align = "center",
		font = FONT_BIG,
		custom_draw = custom_draw,
		update = update,
	})
	tree:close()

	tree:open({ sizing = { width = { t = "grow" }, height = { t = "grow" } } })
	tree:close()

	tree:close()

	tree:open({ sizing = { width = { t = "grow" }, height = { t = "grow" } } })
	tree:close()
end

function new_game_btn.enable()
	can_click = false
end

function new_game_btn.disable()
	can_click = false
end

return new_game_btn
