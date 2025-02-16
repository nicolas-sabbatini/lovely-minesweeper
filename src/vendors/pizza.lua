---@class pizza.slice
---@field package w number
---@field package h number
---@field package cw number
---@field package ch number
---@field package minW number
---@field package minH number
---@field package source love.Image
---@field package quads love.Quad[]
---@field render fun(self: pizza.slice, x: number, y: number)
---@field resize fun(self: pizza.slice, w: number | nil, h: number | nil): string | nil

--[[
1 2 3
4 5 6
7 8 9
--]]

local slice = {
	render = function(self, x, y)
		local sx = self.w / self.cw
		local sy = self.h / self.ch
		local ex = x + self.w - self.cw
		local ey = y + self.h - self.ch
		-- Back
		love.graphics.draw(self.source, self.quads[5], x, y, 0, sx, sy)
		-- Side
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
	resize = function(self, w, h)
		self.w = w or self.w
		self.h = h or self.h
		if w < self.minW or h < self.minH then
			return "The new dimensions are to small some errors on render are going to hapend"
		end
	end,
}

---@class pizza
local pizza = {}

---Creates a new slice
function pizza.new() end

---Creates a new slice
---@param texture love.Image
---@return pizza.slice
function pizza.fromTexture(texture)
	local w, h = texture:getDimensions()
	local cw = (w / 3)
	local ch = (h / 3)
	local minW = cw * 2
	local minH = ch * 2
	local quads = {}
	for y = 0, 2, 1 do
		for x = 0, 2, 1 do
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

---Creates a new slice
---@param texture love.Image
---@param tx number
---@param ty number
---@param tw number
---@param th number
---@return pizza.slice
function pizza.fromRec(texture, tx, ty, tw, th)
	local w, h = tw, th
	local cw = (w / 3)
	local ch = (h / 3)
	local minW = cw * 2
	local minH = ch * 2
	local quads = {}
	for y = 0, 2, 1 do
		for x = 0, 2, 1 do
			table.insert(quads, love.graphics.newQuad(tx + x * cw, ty + y * ch, cw, ch, texture))
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

return pizza
