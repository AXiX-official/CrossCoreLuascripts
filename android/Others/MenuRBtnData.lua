local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Init(_cfg)
    self.cfg = _cfg
    --
    self.isShow = true
    self.isOpen = true
    self.isRed = false
    self.begTime = nil
    self.endTime = nil
    --
    self:CheckIsShow()
end

-- 是否显示出来
function this:CheckIsShow()
    self.isShow = false
    local curTime = TimeUtil:GetTime()
    if (self.cfg.nType == 1) then
        self.begTime, self.endTime = 0, curTime * 2
    elseif (self.cfg.nType == 2) then
        self.begTime, self.endTime = nil, nil
        if (not CSAPI.IsAppReview()) then
            local curData = MenuBuyMgr:GetCurData()
            if (curData) then
                self.endTime = curData:GetEndTime() or curTime * 2
            end
        end
    elseif (self.cfg.nType == 3) then
        local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
        if (isOpen) then
            self.endTime = ActivityMgr:GetRefreshTime(ActivityListType.SkinRebate)
        end
    elseif (self.cfg.nType == 4) then
        local popupPackTime = PopupPackMgr:GetMinTime()
        if (popupPackTime and popupPackTime > curTime) then
            self.endTime = popupPackTime
        end
    elseif (self.cfg.nType == 5) then
        local curData = CumulativeSpendingMgr:GetFirstData()
        if curData then
            self.begTime = curData:GetStartTimeStamp()
            self.endTime = curData:GetEndTimeStamp()
        end
    end
    if (self.begTime == nil and self.endTime == nil) then
        self.isShow = false
    elseif (not self.isShow and (self.begTime == nil or curTime > self.begTime)) then
        if (self.endTime == nil or curTime < self.endTime) then
            self.isShow = true
        end
    end
    return self.isShow
end

function this:GetCfg()
    return self.cfg
end

function this:IsShow()
    return self.isShow
end

-- 是否已解锁(上锁状态与否)
function this:IsOpen()
    self.isOpen = true
    local str = ""
    if (self.cfg.nType == 1) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ActivityListView")
    elseif (self.cfg.nType == 2) then
        self.isOpen, str = MenuBuyMgr:CheckMenuBuyIsOpen()
    elseif (self.cfg.nType == 3) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "SkinRebate")
    end
    return self.isOpen, str
end

function this:IsRed()
    self.isRed = false
    if (self.isShow and self.isOpen) then
        if (self.cfg.nType == 1) then
            self.isRed = RedPointMgr:GetData(RedPointType.ActivityList1) ~= nil
        elseif (self.cfg.nType == 2) then
            local curData = MenuBuyMgr:GetCurData()
            if (curData and curData:GetRed()) then
                self.isRed = curData:GetRed()
            end
        elseif (self.cfg.nType == 3) then
            local isOpen, id = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
            if (isOpen) then
                self.isRed = ActivityMgr:CheckRed(id)
            end
        elseif (self.cfg.nType == 5) then
            self.isRed = RedPointMgr:GetData(RedPointType.CumulativeSpending) ~= nil
        end
    end
    return self.isRed
end

-- 刷新时间
function this:RefreshTime()
    local time = nil
    if (self.begTime and self.begTime ~= 0) then
        time = self.begTime
    elseif (self.endTime and self.endTime ~= 0) then
        time = self.endTime
    end
    if (time and time <= TimeUtil:GetTime()) then
        time = nil
    end
    return time
end

return this
