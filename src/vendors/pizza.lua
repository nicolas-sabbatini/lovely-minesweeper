--[[
pizza.lua v0.0.1

The MIT License (MIT)

Copyright (c) 2024 Nicolás Sabbatini

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
--]]

---@class pizza.slice
---@field w number Width of the slice.
---@field h number Height of the slice.
---@field cw number Width of a single cell.
---@field ch number Height of a single cell.
---@field minW number Minimum allowed width.
---@field minH number Minimum allowed height.
---@field source love.Image The image source for rendering.
---@field quads love.Quad[] Array of quads used for rendering.
---@field render fun(self: pizza.slice, x: number, y: number) Renders the slice at the given position.
---@field resize fun(self: pizza.slice, w: number | nil, h: number | nil): string | nil Resizes the slice, returning a warning if dimensions are too small.

local slice = {
	---Renders the slice at the specified position.
	---@param x number X-coordinate.
	---@param y number Y-coordinate.
	render = function(self, x, y)
		local sx = self.w / self.cw
		local sy = self.h / self.ch
		local ex = x + self.w - self.cw
		local ey = y + self.h - self.ch

		-- Background
		love.graphics.draw(self.source, self.quads[5], x, y, 0, sx, sy)
		-- Sides
		love.graphics.draw(self.source, self.quads[2], x, y, 0, sx, 1)
		love.graphics.draw(self.source, self.quads[4], x, y, 0, 1, sy)
		love.graphics.draw(self.source, self.quads[6], ex, y, 0, 1, sy)
		love.graphics.draw(self.source, self.quads[8], x, ey, 0, sx, 1)
		-- Corners
		love.graphics.draw(self.source, self.quads[1], x, y)
		love.graphics.draw(self.source, self.quads[3], ex, y)
		love.graphics.draw(self.source, self.quads[7], x, ey)
		love.graphics.draw(self.source, self.quads[9], ex, ey)
	end,

	---Resizes the slice, returning a warning if dimensions are too small.
	---@param w number|nil New width (optional).
	---@param h number|nil New height (optional).
	---@return string|nil Warning message if new dimensions are too small.
	resize = function(self, w, h)
		self.w = w or self.w
		self.h = h or self.h
		if self.w < self.minW or self.h < self.minH then
			return "The new dimensions are too small; rendering issues may occur."
		end
	end,
}

---@class pizza
local pizza = {}

---Creates a new slice.
function pizza.new() end

---Creates a slice from a texture.
---@param texture love.Image Source image.
---@return pizza.slice New slice object.
function pizza.fromTexture(texture)
	local w, h = texture:getDimensions()
	local cw, ch = w / 3, h / 3
	local minW, minH = cw * 2, ch * 2
	local quads = {}
	for y = 0, 2 do
		for x = 0, 2 do
			table.insert(quads, love.graphics.newQuad(x * cw, y * ch, cw, ch, texture))
		end
	end

	local newSlice = {
		w = w,
		h = h,
		cw = cw,
		ch = ch,
		minW = minW,
		minH = minH,
		source = texture,
		quads = quads,
	}
	return setmetatable(newSlice, { __index = slice })
end

---Creates a slice from a specific rectangular area of a texture.
---@param texture love.Image Source image.
---@param tx number X position in the texture.
---@param ty number Y position in the texture.
---@param tw number Width of the section.
---@param th number Height of the section.
---@return pizza.slice New slice object.
function pizza.fromRec(texture, tx, ty, tw, th)
	local cw, ch = tw / 3, th / 3
	local minW, minH = cw * 2, ch * 2
	local quads = {}
	for y = 0, 2 do
		for x = 0, 2 do
			table.insert(quads, love.graphics.newQuad(tx + x * cw, ty + y * ch, cw, ch, texture))
		end
	end

	local newSlice = {
		w = tw,
		h = th,
		cw = cw,
		ch = ch,
		minW = minW,
		minH = minH,
		source = texture,
		quads = quads,
	}
	return setmetatable(newSlice, { __index = slice })
end

return pizza
