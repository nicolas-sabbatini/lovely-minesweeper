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
	love.window.setMode(start_width, start_height, flags)
end

LETTERBOX = require("vendors.letterbox")
MAIN_SCREEN = LETTERBOX.newLetterbox({
	type = "normal",
	width = start_width,
	height = start_height,
} --[[@as letterbox.Upscale.Normal]], {
	width = GAME_WIDTH,
	height = GAME_HEIGHT,
})

-- OS
---@type 'OS X' | 'Windows' | 'Linux' | 'Android' | 'iOS' | "Web"
OS = love.system.getOS()
Tape.log("debug", "Runing on %s", OS)
