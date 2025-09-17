--[[
  Copyright 2025 HexedRevii

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]


---@class pixelCanvas
---@field w number
---@field h number
---@field clearColour number[]
---@field private __body love.Canvas
local pixelCanvas = {}
pixelCanvas.__index = pixelCanvas

---@param w number
---@param h number
---@param filter 'nearest'|'linear'
---@param clearColour number[]
---@return pixelCanvas
function pixelCanvas.new(w, h, filter, clearColour)
  filter = filter or 'nearest'
  clearColour = clearColour or {0, 0, 0}

  local c = {
    w = w, h = h,
    __body = love.graphics.newCanvas(w, h),

    clearColour = clearColour
  }

  c.__body:setFilter(filter, filter)

  return setmetatable(c, pixelCanvas)
end

---@param sx number?
---@param sy number?
---@return number
function pixelCanvas:getScale(sx, sy)
  local screen_x, screen_y = love.graphics.getDimensions()
  if sx then screen_x = sx end
  if sy then screen_y = sy end

  return math.min(screen_x / self.w, screen_y / self.h)
end

---@param sx number?
---@param sy number?
---@return number, number
function pixelCanvas:getMouseWorld(sx, sy)
  local mx, my = love.mouse.getPosition()

  local scale = self:getScale(sx, sy)
  local screen_x, screen_y = love.graphics.getDimensions()
  if sx then screen_x = sx end
  if sy then screen_y = sy end

  local scale_x,  scale_y  = self.w * scale, self.h * scale
  local x, y = (screen_x - scale_x) * 0.5, (screen_y - scale_y) * 0.5

  -- transform from screen space → canvas space
  local world_x = (mx - x) / scale
  local world_y = (my - y) / scale

  return world_x, world_y
end

function pixelCanvas:set()
  love.graphics.setCanvas(self.__body)
end

---@param sx number?
---@param sy number?
function pixelCanvas:render(sx, sy)
   love.graphics.setCanvas()

  local scale = self:getScale(sx, sy)

  local screen_x, screen_y = love.graphics.getDimensions()
  if sx then screen_x = sx end
  if sy then screen_y = sy end

  local scale_x,  scale_y  = self.w * scale, self.h * scale
  local x, y = (screen_x - scale_x) * 0.5, (screen_y - scale_y) * 0.5

  love.graphics.clear(self.clearColour)
  love.graphics.draw(self.__body, x, y, 0, scale, scale)
end

return pixelCanvas
