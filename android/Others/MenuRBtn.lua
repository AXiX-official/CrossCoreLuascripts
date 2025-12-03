local redPos = {65, 60}
local downTime = nil
local timer = nil

function Update()
    if (timer and Time.time < timer) then
        return
    end
    timer = Time.time + 1
    if (downTime) then
        local needTime = downTime - TimeUtil:GetTime()
        local txt = data:IsOpen() and txtTime or txtTime2
        if (needTime >= 86400) then
            CSAPI.SetText(txt, TimeUtil:GetTimeStr(needTime <= 0 and 0 or needTime))
            LanguageMgr:SetText(txt, 18035, math.ceil(needTime / 86400))
        else
            CSAPI.SetText(txt, TimeUtil:GetTimeStr(needTime <= 0 and 0 or needTime))
        end
        if (needTime <= 0) then
            downTime = nil
            Refresh(data)
        end
    end
end

function Refresh(_data)
    data = _data
    --
    SetIcon()
    -- name
    SetName()
    -- lock
    CSAPI.SetGOActive(lock, not data:IsOpen())
    -- red
    UIUtil:SetRedPoint(clickNode, data:IsRed(), redPos[1], redPos[2])
    -- time
    SetTime()
end

function SetName()
    if (data:GetCfg().nType == 2) then
        local curData = MenuBuyMgr:GetCurData()
        CSAPI.SetText(txtName, curData:GetCfg().sName)
    else
        CSAPI.SetText(txtName, data:GetCfg().sName)
    end
end

function SetIcon()
    local iconName = data:GetCfg().icon
    if (data:GetCfg().nType == 2) then
        local curData = MenuBuyMgr:GetCurData()
        iconName = curData:GetCfg().img
    end
    CSAPI.LoadImg(icon, "UIs/Menu/" .. iconName .. ".png", true, nil, true)
end

function SetTime()
    timer = nil
    downTime = nil
    local b = data:IsOpen()
    if (not b) then
        CSAPI.SetGOActive(timeObj2, false)
        CSAPI.SetGOActive(timeObj, false)
        return --未开启
    end
    local str = ""
    if (data:GetCfg().nType == 2) then
        local curData = MenuBuyMgr:GetCurData()
        if (curData:GetID() == 3) then
            local num = ShopMgr:GetMonthCardDays()
            if (num > 0 and num <= 7) then
                str = LanguageMgr:GetByID(18035, num) -- 18082
            end
        else
            downTime = curData:GetEndTime()
            if (downTime) then
                timer = Time.time
            end
        end
    elseif (data:GetCfg().nType == 3) then
        downTime = ActivityMgr:GetRefreshTime(ActivityListType.SkinRebate)
        timer = Time.time
    elseif (data:GetCfg().nType == 4) then
        downTime = nil
        local popupPackTime = PopupPackMgr:GetMinTime()
        if (popupPackTime ~= nil and popupPackTime > TimeUtil:GetTime()) then
            local needTime = popupPackTime - TimeUtil:GetTime()
            downTime = popupPackTime
            timer = Time.time
        end
    end
    if (data:IsOpen()) then
        CSAPI.SetGOActive(timeObj, timer ~= nil or str~="")
        CSAPI.SetText(txtTime, str)
    else
        CSAPI.SetGOActive(timeObj, false)
    end
end

function OnClick()
    local isOpen, str = data:IsOpen()
    if (not isOpen) then
        if (str and str ~= "") then
            Tips.ShowTips(str)
        end
        return
    end
    if (data:GetCfg().nType == 4) then
        PopupPackMgr:ToshowView("点击入口")
    else
        CSAPI.OpenView(data:GetCfg().openView, nil, data:GetCfg().page)
    end
end
