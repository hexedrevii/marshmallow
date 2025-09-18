--[[
  Copyright 2025 HexedRevii

  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
]]


---@class timer
---@field timeout number
---@field callback function
---@field oneshot boolean
---@field private __time number
---@field private __stopped boolean
local timer = {}
timer.__index = timer

---@param timeout number
---@param callback function
---@param oneshot boolean
---@return timer
function timer.new(timeout, callback, oneshot)
  local t = {
    timeout = timeout,
    callback = callback,
    oneshot = oneshot,

    __time = 0,
    __stopped = false,
  }

  return setmetatable(t, timer)
end

function timer:stop()
  self.__stopped = true
  self.__time = 0
end

function timer:start()
  self.__stopped = false
end

function timer:reset()
  self.__time = 0
end

---@param delta number
function timer:update(delta)
  if self.__stopped then return end

  self.__time = self.__time + delta
  if self.__time >= self.timeout then
    if self.oneshot then
      self.__stopped = true
    end

    self.__time = 0
    self.callback()
  end
end

return timer
