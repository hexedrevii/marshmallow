--[[
  Copyright 2025 HexedRevii

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

---@class input
---@field private __mappings table<string, mapping>
---@field private __pressedKeyboard table<love.KeyConstant, boolean|nil>
---@field private __pressedGamepad  table<love.GamepadButton, boolean|nil>
local input = {}
input.__index = input

---@class mapping
---@field keyboard love.KeyConstant?
---@field gamepad love.GamepadButton?
local _mapping = {}

function input.new()
  local i = {
    __mappings = {},

    __pressedKeyboard  = {},
    __pressedGamepad   = {}
  }

  return setmetatable(i, input)
end

-- @region Love Callbacks
function input:keypressed(key)
  self.__pressedKeyboard[key] = true
end
function input:keyreleased(key)
  self.__pressedKeyboard[key] = nil
end

function input:gamepadpressed(joystick, button)
  self.__pressedGamepad[button] = true
end
function input:gamepadreleased(joystick, button)
  self.__pressedGamepad[button] = nil
end
-- @region Love Callbacks

---@param name string
---@param keyboard love.KeyConstant?
---@param gamepad love.GamepadButton?
function input:pushKeymap(name, keyboard, gamepad)
  self.__mappings[name] = {
    keyboard = keyboard,
    gamepad = gamepad,
  }
end

---Get axis with -1 to 1
---@param negative string The negative mapping name.
---@param positive string The ppsitive mapping name.
---@return integer
function input:getAxis(negative, positive)
  if input:isDown(negative) and input:isDown(positive) then
    return 0
  end

  if input:isDown(negative) then
    return -1
  end

  if input:isDown(positive) then
    return 1
  end

  return 0
end

---@param action string
---@return boolean
function input:isPressed(action)
  local map = self.__mappings[action]
  if not map then return false end

  -- Keyboard check
  local key = map.keyboard
  if key and self.__pressedKeyboard[key] then
    self.__pressedKeyboard[key] = nil
    return true
  end

  -- Gamepad button check
  local button = map.gamepad
  if button and self.__pressedGamepad[button] then
    self.__pressedGamepad[button] = nil
    return true
  end

  return false
end

---@param action string
---@return boolean
function input:isDown(action)
  local map = self.__mappings[action]
  if not map then return false end

  local key = map.keyboard
  if key and self.__pressedKeyboard[key] then
    return true
  end

  local button = map.gamepad
  if button and self.__pressedGamepad[button] then
    return true
  end

  return false
end

return input
