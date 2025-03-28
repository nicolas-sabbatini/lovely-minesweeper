GAME_WIDTH = 800
GAME_HEIGHT = 600

-- Tape
require("vendors.tape")
Tape.init("console")

-- Camera
local _, _, flags = love.window.getMode()
local monitor_width, monitor_height = love.window.getDesktopDimensions(flags.display)
local start_width, start_height = love.graphics.getDimensions()
if start_width > monitor_width or start_height > monitor_height then
	local ratio = math.min(monitor_width / start_width, monitor_height / start_height)
	ratio = math.max(ratio, 0.5)
	start_width = start_width * ratio
	start_height = start_height * ratio
	---@diagnostic disable-next-line: param-type-mismatch
	love.window.setMode(start_width, start_height, flags)
end

LETTERBOX = require("vendors.letterbox")
---@type letterbox.Rig.Normal
---@diagnostic disable-next-line: assign-type-mismatch
MAIN_SCREEN = LETTERBOX.newLetterbox({
	type = "normal",
	parent = {
		width = start_width,
		height = start_height,
	},
	size = {
		width = GAME_WIDTH,
		height = GAME_HEIGHT,
	},
} --[[@as letterbox.Upscale.Normal]])

-- GUI
GUI = love.graphics.newImage("assets/16x16-min-ui.png")
GUI_9_SIZE = 16 * 3

FONT_SMALL = love.graphics.newFont("assets/monogram.ttf", 15, "mono")
FONT_MEDIUM = love.graphics.newFont("assets/monogram.ttf", 25, "mono")
FONT_BIG = love.graphics.newFont("assets/monogram.ttf", 35, "mono")

-- OS
---@type 'OS X' | 'Windows' | 'Linux' | 'Android' | 'iOS' | "Web"
OS = love.system.getOS()
Tape.log("debug", "Runing on %s", OS)

-- Mouse positions
MOUSE_WORLD_POSITIONS = {}
MOUSE_SCREEN_POSITIONS = {}

-- Color palett
local rgb = require("vendors.rgb")
COLOR_PALETT = {
	GARY_DARK = rgb.exaToTable(0x596674),
	BLACK = rgb.exaToTable(0),
}
