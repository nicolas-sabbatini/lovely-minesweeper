GAME_WIDTH = 800
GAME_HEIGHT = 600

-- Tape
require("vendors.tape")
Tape.init("console")

-- Assets
local pizza = require("vendors.pizza")
local image = love.graphics.newImage("assets/16x16-min-ui.png")
local gui_size = 16 * 3
GUI_DARK = pizza.fromRec(image, gui_size * 0, 0, gui_size, gui_size)
GUI_LIGHT = pizza.fromRec(image, gui_size * 1, 0, gui_size, gui_size)
GUI_DARK_SELECTED = pizza.fromRec(image, gui_size * 2, 0, gui_size, gui_size)
GUI_LIGHT_SELECTED = pizza.fromRec(image, gui_size * 3, 0, gui_size, gui_size)

FONT_SMALL = love.graphics.newFont("assets/monogram.ttf", 16, "mono")
FONT_MEDIUM = love.graphics.newFont("assets/monogram.ttf", 24, "mono")
FONT_BIG = love.graphics.newFont("assets/monogram.ttf", 32, "mono")

-- OS types
---@type 'OS X' | 'Windows' | 'Linux' | 'Android' | 'iOS' | "Web"
OS = love.system.getOS()
Tape.log("debug", "Runing on %s", OS)

-- Mouse positions
MOUSE_X = 0
MOUSE_Y = 0

-- Color palett
local rgb = require("vendors.rgb")
COLOR_PALETT = {
	GARY_DARK = rgb.exaToTable(0x596674),
	BLACK = rgb.exaToTable(0),
	WHITE = rgb.exaToTable(0xffffff),
}
