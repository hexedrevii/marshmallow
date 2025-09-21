--[[
  Copyright 2025 HexedRevii

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

---@class spritesheet
---@field private __spriteSheet love.Image
---@field private __quads love.Quad[]
---@field duration number
---@field playOnce boolean
---@field onEnd function
---@field private __time number
---@field private __stopped boolean
local spritesheet = {}
spritesheet.__index = spritesheet

function spritesheet:new(img, w, h, duration)
  local a = {
    __spriteSheet = img,
    __quads = {},

    duration = duration or 1,
    __time = 0,
    __stopped = false,

    playOnce = false,
    onEnd = nil
  }

  for y = 0, a.__spriteSheet:getHeight() - h, h do
    for x = 0, a.__spriteSheet:getWidth() - w, w do
      table.insert(a.__quads, love.graphics.newQuad(x, y, w, h, a.__spriteSheet:getDimensions()))
    end
  end

  return setmetatable(a, spritesheet)
end

function spritesheet:reset()
  self.__time = 0
  self.__stopped = false
end

function spritesheet:update(delta)
  if self.__stopped then return end

  self.__time = self.__time + delta
  if self.__time >= self.duration then
    if self.playOnce then
      self.__stopped = true
      if self.onEnd then
        self.onEnd(self)
      end
    end

    self.__time = 0
  end
end

function spritesheet:draw(x, y)
  local spriteIndex = math.floor(self.__time / self.duration * #self.__quads) + 1
  love.graphics.draw(self.__spriteSheet, self.__quads[spriteIndex], x, y)
end

return spritesheet
