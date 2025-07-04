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
        self.begTime, self.endTime = ActivityMgr:GetActivityTime(2)
    elseif (self.cfg.nType == 3) then
        self.begTime, self.endTime = RegressionMgr:GetResRecoveryTime()
    elseif (self.cfg.nType == 4) then
        self.begTime, self.endTime = ActivityMgr:GetActivityTime(3)
    elseif (self.cfg.nType == 5) then
        self.begTime, self.endTime = RegressionMgr:GetActivityTime()
    elseif (self.cfg.nType == 6) then
        self.begTime, self.endTime = CollaborationMgr:GetActivityTime()
    elseif (self.cfg.nType == 7) then
        self.endTime = nil
        if (CSAPI.IsADV()) then
            local lv = g_ZilongWebBtnLv or 1
            if (PlayerClient:GetLv() >= lv) then
                if (g_ZilongWebBtnOpen) then
                    self.begTime = TimeUtil:GetTimeStampBySplit(g_ZilongWebBtnOpen)
                end
                if (g_ZilongWebBtnClose) then
                    self.endTime = TimeUtil:GetTimeStampBySplit(g_ZilongWebBtnClose)
                end
            end
        end
    elseif (self.cfg.nType==8) then
        local info=ItemPoolActivityMgr:GetCurrPoolInfoByType(ItemPoolExtractType.Control);
        if info then
            self.begTime=info:GetOpenTime() and TimeUtil:GetTimeStampBySplit(info:GetOpenTime()) or nil;
            self.endTime=info:GetCloseTime() and TimeUtil:GetTimeStampBySplit(info:GetCloseTime()) or nil;
        end
    elseif (self.cfg.nType==9) then --拼图
        local cfg=Cfgs.CfgPuzzleBase:GetByID(self:GetCfg().page);
        if cfg then
            self.begTime=cfg.begTime and TimeUtil:GetTimeStampBySplit(cfg.begTime) or nil;
            self.endTime=cfg.endTime and TimeUtil:GetTimeStampBySplit(cfg.endTime) or nil;
        end
    elseif (self.cfg.nType==10) then --端午签到
        local _,id = ActivityMgr:IsOpenByType(ActivityListType.SignInDuanWu)
        local alData = ActivityMgr:GetALData(id)
        if alData then
            self.begTime=alData:GetStartTime()
            self.endTime=alData:GetEndTime()
        end
    elseif (self.cfg.nType==11) then --宠物
        local cfg=Cfgs.CfgActiveEntry:GetByID(16);
        if cfg then
            self.begTime=cfg.begTime and TimeUtil:GetTimeStampBySplit(cfg.begTime) or nil;
            self.endTime=cfg.endTime and TimeUtil:GetTimeStampBySplit(cfg.endTime) or nil;
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

-- 是否已解锁
function this:IsOpen()
    self.isOpen = true
    local str = ""
    if (self.cfg.nType == 1) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ExplorationMain")
        if (self.isOpen) then
            self.isOpen = ExplorationMgr:CanOpenExploration()
            str = LanguageMgr:GetTips(22003)
        end
    elseif (self.cfg.nType == 2 or self.cfg.nType == 4) then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ActivityListView")
    elseif (self.cfg.nType == 6) then  
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "CollaborationMain")
    elseif (self.cfg.nType == 8) then  
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "LuckyGachaMain")
    elseif (self.cfg.nType == 9) then  
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "PuzzleActivity")
    elseif (self.cfg.nType == 10) then  
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "SignInDuanWu")
    elseif (self.cfg.nType == 11)then
        self.isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "PetMain")
    end
    return self.isOpen, str
end

function this:IsRed()
    self.isRed = false
    if (self.isShow and self.isOpen) then
        if (self.cfg.nType == 1) then
            self.isRed = RedPointMgr:GetData(RedPointType.Exploration) ~= nil
        elseif (self.cfg.nType == 2) then
            self.isRed = RedPointMgr:GetData(RedPointType.ActivityList2) ~= nil
        elseif (self.cfg.nType == 3) then
            self.isRed = RedPointMgr:GetData(RedPointType.ResRecovery) ~= nil
        elseif (self.cfg.nType == 4) then
            self.isRed = RedPointMgr:GetData(RedPointType.ActivityList3) ~= nil
        elseif (self.cfg.nType == 5) then
            self.isRed = RedPointMgr:GetData(RedPointType.Regression) ~= nil
        elseif (self.cfg.nType == 6) then
            self.isRed = RedPointMgr:GetData(RedPointType.Collaboration) ~=nil
        elseif (self.cfg.nType == 7) then
            -- IsRed7 要异步
        elseif (self.cfg.nType==8) then
            local info=ItemPoolActivityMgr:GetCurrPoolInfoByType(ItemPoolExtractType.Control);
            if info then
                self.isRed=ItemPoolActivityMgr:CheckPoolHasRedPoint(info:GetID());
            end
        elseif (self.cfg.nType==9) then
            local info=PuzzleMgr:CheckRedInfo(self:GetCfg().page);
            if info then
                self.isRed=info~=nil;
            end
        elseif (self.cfg.nType==10) then
            self.isRed = RedPointMgr:GetData(RedPointType.SignInDuanWu) ~= nil 
        elseif (self.cfg.nType==11) then
            self.isRed = RedPointMgr:GetData(RedPointType.ActiveEntry16) ~=nil
        end
    end
    return self.isRed
end

function this:IsRed7(obj, redPos)
    ShiryuSDK.QueryRedDotState(3, function(isAdd)
        if (obj ~= nil) then
            UIUtil:SetRedPoint(obj, isAdd, redPos[1], redPos[2])
        end
    end)
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
