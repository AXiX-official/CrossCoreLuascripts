-- 策划
local winIndex = nil -- 胜利动画,填下标
local loseIndex = nil -- 失败动画,填下标
local clickIndex = nil -- 点击动画,填下标
local startNum = 0 -- 初始值 （100是满了）
local holdTime = 3 -- 无动作多长时间（秒）会开始掉进度
local downTime = 1 -- 降低百分1需要的秒数
local addNum = 5 -- 每次点击增加多少 （100是满了）
-- local showtime = 1000 -- 事件触发后多长时间显示UI,不能改，要特效改
local hideTime = 500 -- 触发胜利失败动画多长时间后隐藏UI
local lerpNum = 2 -- 每帧增加多少

-- 程序
local CardLive2DItem
local isOver = nil
local timer = 0
local slider_min = -170
local slider_max = 200
local height = 0
local _height = 0
local len = 0
local isUp = true
local firstHeight = 0
local isCan = false

function Refresh(_CardLive2DItem)
    CardLive2DItem = _CardLive2DItem
    -- 初始化
    len = slider_max - slider_min
    _height = slider_min + startNum * (len / 100)
    firstHeight = _height
    height = slider_min
    timer = holdTime
    -- 显示ui
    FuncUtil:Call(function()
        isOver = false
    end, nil, 1500)
end

function Update()
    if (isOver == nil) then
        return
    end
    if (_height ~= height) then
        SetSoftMaskHeight()
    end
    if (isOver) then
        if (CardLive2DItem.IsIdle()) then
            local index = winIndex
            if (height >= slider_max) then -- 胜利
                index = loseIndex
            end
            CardLive2DItem.PlayByIndex(index)
            isOver = nil
            -- 隐藏ui
            FuncUtil:Call(function()
                if (effect ~= nil) then
                    CSAPI.SetGOActive(effect, false)
                end
            end, nil, hideTime)
        end
    elseif (isCan) then
        timer = timer - Time.deltaTime
        if (timer <= 0) then
            local decreaseAmount = Time.deltaTime / downTime
            _height = _height - decreaseAmount * (len / 100)
            isUp = false
        end
    end
end

function SetSoftMaskHeight()
    local x, y = CSAPI.GetAnchor(softMask)
    if (isUp) then
        height = (y + lerpNum) >= _height and _height or (y + lerpNum)
        height = height <= slider_max and height or slider_max
        if (not isCan and height >= firstHeight) then
            isCan = true
        end
    else
        height = (y - lerpNum) <= _height and _height or (y - lerpNum)
        height = height >= slider_min and height or slider_min
    end
    if (height >= slider_max or height <= slider_min) then
        isOver = true
    end
    CSAPI.SetAnchor(softMask, -472.3, height, 0)
end

function OnClickMask()
    if (isOver == nil or not isCan) then
        return
    end
    if (not isOver) then
        if (clickIndex ~= nil and CardLive2DItem.IsIdle()) then
            CardLive2DItem.PlayByIndex(clickIndex)
        end
        timer = holdTime
        _height = _height + addNum * (len / 100)
        isUp = true
    end
end
