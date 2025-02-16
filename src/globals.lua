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

-- Img
GUI = love.graphics.newImage("assets/16x16-min-ui.png")

-- OS
---@type 'OS X' | 'Windows' | 'Linux' | 'Android' | 'iOS' | "Web"
OS = love.system.getOS()
Tape.log("debug", "Runing on %s", OS)

-- Color palett
local rgb = require("vendors.rgb")
COLOR_PALETT = {
	c_e8d5ae = rgb.exaToTable(0xe8d5ae),
	c_e1c074 = rgb.exaToTable(0xe1c074),
	c_d49d56 = rgb.exaToTable(0xd49d56),
	c_b58057 = rgb.exaToTable(0xb58057),
	c_925a3e = rgb.exaToTable(0x925a3e),
	c_ff8a27 = rgb.exaToTable(0xff8a27),
	c_ffffff = rgb.exaToTable(0xffffff),
	c_e1c4a4 = rgb.exaToTable(0xe1c4a4),
	c_e7af85 = rgb.exaToTable(0xe7af85),
	c_df9a71 = rgb.exaToTable(0xdf9a71),
	c_da815a = rgb.exaToTable(0xda815a),
	c_d06a49 = rgb.exaToTable(0xd06a49),
	c_ac634a = rgb.exaToTable(0xac634a),
	c_9c483b = rgb.exaToTable(0x9c483b),
	c_844d45 = rgb.exaToTable(0x844d45),
	c_c66e6e = rgb.exaToTable(0xc66e6e),
	c_b9a3a0 = rgb.exaToTable(0xb9a3a0),
	c_7b665b = rgb.exaToTable(0x7b665b),
	c_6e5747 = rgb.exaToTable(0x6e5747),
	c_695247 = rgb.exaToTable(0x695247),
	c_684b45 = rgb.exaToTable(0x684b45),
	c_5c4e4e = rgb.exaToTable(0x5c4e4e),
	c_d8cfb2 = rgb.exaToTable(0xd8cfb2),
	c_bdbc69 = rgb.exaToTable(0xbdbc69),
	c_999c50 = rgb.exaToTable(0x999c50),
	c_699254 = rgb.exaToTable(0x699254),
	c_467f53 = rgb.exaToTable(0x467f53),
	c_5a5f51 = rgb.exaToTable(0x5a5f51),
	c_c4b398 = rgb.exaToTable(0xc4b398),
	c_b2a472 = rgb.exaToTable(0xb2a472),
	c_868c65 = rgb.exaToTable(0x868c65),
	c_cee6e8 = rgb.exaToTable(0xcee6e8),
	c_7faec6 = rgb.exaToTable(0x7faec6),
	c_3d94c0 = rgb.exaToTable(0x3d94c0),
	c_49617d = rgb.exaToTable(0x49617d),
	c_93cad0 = rgb.exaToTable(0x93cad0),
	c_8eb3ba = rgb.exaToTable(0x8eb3ba),
	c_829693 = rgb.exaToTable(0x829693),
	c_b6bab9 = rgb.exaToTable(0xb6bab9),
	c_929a9c = rgb.exaToTable(0x929a9c),
	c_6f7d85 = rgb.exaToTable(0x6f7d85),
	c_596674 = rgb.exaToTable(0x596674),
	c_000000 = rgb.exaToTable(0),
}
