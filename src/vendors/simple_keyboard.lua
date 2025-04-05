--[[
simple_keyboard.lua v4.0.0

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

---@class SimpleKeyboardInstance
---@field private keysPressed {love.KeyConstant: boolean}
---@field private keysJustPressed {love.KeyConstant: boolean}
---@field private keysJustReleased {love.KeyConstant: boolean}
---@field private mousePressed {number: boolean}
---@field private mouseJustPressed {number: boolean}
---@field private mouseJustReleased {number: boolean}
local SimpleKeyboard = {
	_LICENSE = "MIT License - Copyright (c) 2024",
	_URL = "https://github.com/nicolas-sabbatini/lovely-tools",
	_VERSION = "v4.0.0",
}

---Create a new instance of simple keyboard.
---@param keys love.KeyConstant | love.KeyConstant[]
---@return SimpleKeyboardInstance - An instance of SimpleKeyboard
function SimpleKeyboard.createInstance(keys)
	local instance = setmetatable({
		keysPressed = {},
		keysJustPressed = {},
		keysJustReleased = {},
		mousePressed = { false, false, false },
		mouseJustPressed = {},
		mouseJustReleased = {},
	}, { __index = SimpleKeyboard })
	instance:keyBind(keys)
	return instance
end

---Bind a key or a table of keys to the instance.
---@param keys love.KeyConstant | love.KeyConstant[]
function SimpleKeyboard:keyBind(keys)
	if not keys then
		return
	elseif type(keys) ~= "table" then
		---@diagnostic disable-next-line: cast-local-type
		keys = { keys }
	end
	for _, k in pairs(keys) do
		self.keysPressed[k] = false
		self.keysJustReleased[k] = false
		self.keysJustPressed[k] = false
	end
end

---Unbind a key or a table of keys in the instance.
---@param keys love.KeyConstant | love.KeyConstant[]
function SimpleKeyboard:keyUnbind(keys)
	if not keys then
		return
	elseif type(keys) ~= "table" then
		---@diagnostic disable-next-line: cast-local-type
		keys = { keys }
	end
	for _, k in pairs(keys) do
		self.keysPressed[k] = nil
		self.keysJustReleased[k] = nil
		self.keysJustPressed[k] = nil
	end
end

---Update the state of all bound keys.
function SimpleKeyboard:updateInput()
	for k, previus in pairs(self.keysPressed) do
		self.keysPressed[k] = love.keyboard.isDown(k)
		self.keysJustReleased[k] = previus and not self.keysPressed[k]
		self.keysJustPressed[k] = (not previus) and self.keysPressed[k]
	end
	for k, previus in pairs(self.mousePressed) do
		self.mousePressed[k] = love.mouse.isDown(k)
		self.mouseJustReleased[k] = previus and not self.mousePressed[k]
		self.mouseJustPressed[k] = (not previus) and self.mousePressed[k]
	end
end

---Return true if is the first frame the bound key is down.
---@param key love.KeyConstant
---@return boolean — True if the key is down, false if not.
function SimpleKeyboard:justPressed(key)
	return self.keysJustPressed[key]
end

---Return true if a bound key is down.
---@param key love.KeyConstant
---@return boolean — True if the key is down, false if not.
function SimpleKeyboard:isDown(key)
	return self.keysPressed[key]
end

---Return true if is the first frame the bound key is released.
---@param key love.KeyConstant
---@return boolean — True if the key is released, false if not.
function SimpleKeyboard:justReleased(key)
	return self.keysJustReleased[key]
end

---Return true if is the first frame the button is down.
---@param button number
---@return boolean — True if the button is down, false if not.
function SimpleKeyboard:mJustPressed(button)
	return self.mouseJustPressed[button]
end

---Return true if the button is down.
---@param button number
---@return boolean — True if the button is down, false if not.
function SimpleKeyboard:mIsDown(button)
	return self.mousePressed[button]
end

---Return true if is the first frame the button is released.
---@param button number
---@return boolean — True if the button is released, false if not.
function SimpleKeyboard:mJustReleased(button)
	return self.mouseJustReleased[button]
end

return SimpleKeyboard
