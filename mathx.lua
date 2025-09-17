--[[
  Copyright 2025 HexedRevii

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]

local mathx = {}

---@param from number
---@param to number
---@param delta number
---@return number
function mathx.moveTowards(from, to, delta)
  if math.abs(to - from) <= delta then
    return to
  end

  return from + mathx.sign(to - from) * delta
end

---@param x number
function mathx.sign(x)
  if x < 0 then
    return -1
  elseif x > 0 then
    return 1
  else
    return 0
  end
end

---@param rect1 {x: number, y: number, w: number, h: number}
---@param rect2 {x: number, y: number, w: number, h: number}
---@return boolean
function mathx.colRect(rect1, rect2)
  return rect1.x < rect2.x + rect2.w and
    rect1.x + rect1.w > rect2.x and
    rect1.y < rect2.y + rect2.h and
    rect1.y + rect1.h > rect2.y
end

---@param rx number
---@param ry number
---@param rw number
---@param rh number
---@param sx number
---@param sy number
---@param sw number
---@param sh number
---@return boolean
function mathx.colRectR(rx, ry, rw, rh, sx, sy, sw, sh)
  return rx < sx + sw and
    rx + rw > sx and
    ry < sy + sh and
    ry + rh > sy
end

return mathx
