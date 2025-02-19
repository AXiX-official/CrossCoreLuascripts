-- 回归相关 
local this = MgrRegister("RegressionMgr")

function this:Init()
    self:Clear()
    -- 回归信息
    RegressionProto:GetInfo()

end

function this:Clear()
    self.getInfoRetProto = {}
    self.checkReturningPlrProto = {}
    self.closeTime = 0
    self.activityInfos = {}
    self.fundTime = 0
end

-- 回归数据
function this:CheckReturningPlr(proto)
    self.checkReturningPlrProto = proto
    if proto and proto.activity_times and #proto.activity_times > 0 then
        for i, v in ipairs(proto.activity_times) do
            self.activityInfos[v.ty] = {
                id = v.id,
                sTime = v.start_time,
                eTime = v.end_time
            }
        end
    end
    self:CheckRedPointData()
end

-- 资源找回数据
function this:GetInfoRet(proto)
    self.getInfoRetProto = proto
end

-- RegressionActiveType = {}
-- RegressionActiveType.Sign = 1 -- 1、签到
-- RegressionActiveType.DropAdd = 2 -- 2、掉落加成
-- RegressionActiveType.ResourcesRecovery = 3 -- 3、找回资源
-- RegressionActiveType.Fund = 4 -- 4、回归基金
-- RegressionActiveType.Cloth = 5 -- 5、限时时装
-- RegressionActiveType.ItemPool = 6 -- 6、回归道具池

-- 是否开启该活动（表上是否配置）
function this:CheckHadActivity(_type)
    local isHuiGui, type = self:IsHuiGui()
    if (isHuiGui) then
        local cfg = Cfgs.CfgReturningActivity:GetByID(type)
        if (cfg and cfg.infos) then
            for k, v in ipairs(cfg.infos) do
                if (v.type == _type) then
                    return true
                end
            end
        end
    end
    return false
end

------------------------------------------------------------------回归---------------------------------------------------------------------
-- 回归时间戳
function this:GetBackTime()
    if (self.checkReturningPlrProto) then
        return self.checkReturningPlrProto.time
    end
    return nil
end

-- 是不是回归玩家
function this:IsHuiGui()
    if (self.checkReturningPlrProto and self.checkReturningPlrProto.type and self.checkReturningPlrProto.type ~= 0) then
        return true, self.checkReturningPlrProto.type
    else
        return false
    end
end

-- 回归的天数
function this:GetBackDay()
    local num = 0
    if (self:IsHuiGui()) then
        local num = 0 -- 最大30天，直接判断月与日即可 
        local time1 = self.checkReturningPlrProto.time
        local time1Data = TimeUpdate:GetTimeHMS(time1)
        local time2 = TimeUtil:GetTime()
        local time2Data = TimeUpdate:GetTimeHMS(time2)
        if (time1Data.month == time2Data.month) then
            num = time2Data.day - time1Data.day + 1
        else
            -- 月份不等（按只隔了一个月算）
            local num1 = TimeUtil:DaysInMonth(time1Data.year, time1Data.month) - time1Data.day
            local num2 = time1Data.day
            num = num1 + num2 + 1
        end
    end
    return num
end
-- 离开天数
function this:LeaveDay()
    if (self:IsHuiGui()) then
        return self.checkReturningPlrProto.leave or 0
    end
    return 0
end

------------------------------------------------------------------资源---------------------------------------------------------------------

-- 找回资源是否已领取（要判断是否已回归）
function this:CheckResRecoveryIsGain()
    local isGain = false
    if (self.getInfoRetProto and self.getInfoRetProto.resourcesIsGain == 1) then
        isGain = true
    end
    return isGain
end
-- 设置回归资源的领取状态
function this:SetResRecoveryGain(resourcesIsGain)
    self.getInfoRetProto.resourcesIsGain = resourcesIsGain
    RedPointMgr:UpdateData(RedPointType.ResRecovery, nil)
end

-- 是否需要弹出（仅弹出一次）
function this:CheckNeedShow()
    if (not self:CheckHadActivity(RegressionActiveType.ResourcesRecovery) or self:CheckResRecoveryIsGain()) then
        return false
    end
    local key = PlayerClient:GetID() .. "_resrecovery3"
    --
    local time1 = self:GetBackTime()
    -- 
    local time2 = PlayerPrefs.GetInt(key) or 0
    if (time2 == time1) then
        return false
    end
    PlayerPrefs.SetInt(key, time1)
    return true
end

------------------------------------------------------------------回归活动---------------------------------------------------------------------
function this:GetArr(group)
    group = group or 1
    local isRegress, id = self:IsHuiGui()
    local datas = {}
    self.closeTime = self.closeTime or 0
    if isRegress then
        local cfg = Cfgs.CfgReturningActivity:GetByID(id)
        if cfg and cfg.infos and #cfg.infos > 0 then
            for _, info in ipairs(cfg.infos) do
                if info.group and info.group == group and not info.IsHide then -- 有隐藏字段不显示
                    local aInfo = self.activityInfos[info.type]
                    if aInfo and aInfo.sTime and aInfo.eTime and TimeUtil:GetTime() >= aInfo.sTime and
                        TimeUtil:GetTime() < aInfo.eTime then
                        if info.type == RegressionActiveType.Tasks then
                            local missionDatas = MissionMgr:GetActivityDatas(eTaskType.RegressionTask, info.activityId)
                            if missionDatas and #missionDatas > 0 then
                                table.insert(datas, info)
                            end
                        else
                            table.insert(datas, info)
                        end
                        self.closeTime = aInfo.eTime > self.closeTime and aInfo.eTime or self.closeTime
                    end
                end
            end
            if #datas > 0 then
                table.sort(datas, function(a, b)
                    if a.sort == b.sort then
                        return a.index < b.index
                    else
                        return a.sort < b.sort
                    end
                end)
            end
        end
    end
    return datas
end

function this:GetTime()
    if self.closeTime > 0 and self.closeTime > TimeUtil:GetTime() then
        return self.closeTime - TimeUtil:GetTime()
    end
    return 0
end

-- RegressionActiveType    
function this:GetActivityEndTime(type)
    if self.activityInfos and self.activityInfos[type] and self.activityInfos[type].eTime then
        return self.activityInfos[type].eTime
    end
    return 0
end

function this:SetFundTime(proto)
    self.fundTime = proto.validity
    EventMgr.Dispatch(EventType.Regression_Fund_Buy)
end

function this:IsBuyFund()
    if self.fundTime > 0 and self.fundTime > TimeUtil:GetTime() then
        return true
    end
    return false
end

-- 遗落的补给是否显示出来（是回归并且未领取）
function this:GetResRecoveryTime()
    local begTime, endTime = nil, nil
    local resRecoveryEndTime = self:GetActivityEndTime(RegressionActiveType.ResourcesRecovery)
    if (resRecoveryEndTime > TimeUtil:GetTime() and self:CheckHadActivity(RegressionActiveType.ResourcesRecovery) and
        not self:CheckResRecoveryIsGain()) then
        begTime = 0
        endTime = resRecoveryEndTime
    end
    return begTime, endTime
end

--活动关闭时间
function this:GetActivityTime()
    if self:IsHuiGui() and #self:GetArr() > 0 then
        return nil,self.closeTime
    end
    return nil,nil
end

------------------------------------------------------------------红点---------------------------------------------------------------------

function this:CheckRedPointData()
    local isCheck, type = self:IsHuiGui()
    local redData1 = nil
    if isCheck then
        local _cfgs = Cfgs.CfgReturningActivity:GetAll()
        if _cfgs and #_cfgs > 0 then
            local redInfos = FileUtil.LoadByPath("Regression_RedInfo.txt") or {}
            for _, v in ipairs(_cfgs) do
                if v.id == type and v.infos and #v.infos > 0 then
                    for _, _info in ipairs(v.infos) do
                        local aInfo = self.activityInfos[_info.type]
                        if aInfo and aInfo.sTime and aInfo.eTime and TimeUtil:GetTime() >= aInfo.sTime and
                            TimeUtil:GetTime() < aInfo.eTime then
                            if _info.group and self:CheckRed(_info.type, _info.activityId, redInfos, _info) then
                                redData1 = 1
                                break
                            end
                        end
                    end
                end
            end
        end
    end
    RedPointMgr:UpdateData(RedPointType.Regression, redData1)
    -- 遗落的补给
    local _data = nil
    local begTime, endTime = self:GetResRecoveryTime()
    if (endTime ~= nil) then
        _data = self:CheckResRecoveryIsGain() and 1 or nil
    end
    RedPointMgr:UpdateData(RedPointType.ResRecovery, _data)
end

function this:CheckRed(_type, _activityId, redInfos, _info)
    if _type == RegressionActiveType.DropAdd then
        return DungeonUtil.HasMultiNum(_activityId)
    elseif _type == RegressionActiveType.Fund then
        local shopId = (_info and _info.infos and _info.infos[1]) and _info.infos[1].shopId or 0
        local isBuy = self:IsBuyFund()
        local datas = MissionMgr:GetDatas(eTaskType.Regression)
        if #datas > 0 then
            for i, v in ipairs(datas) do
                if (not MissionMgr:CheckIsReset(v) and v:CheckIsOpen() and v:IsFinish() and not v:IsGet()) then
                    if v:GetFundId() then
                        return true
                    else
                        if isBuy then -- 有购买基金
                            return true
                        end
                    end
                end
            end
        end
        return false
    elseif _type == RegressionActiveType.Tasks then
        return MissionMgr:CheckRed2(eTaskType.RegressionTask, _activityId)
    elseif _type == RegressionActiveType.Sign then
        return not SignInMgr:CheckIsDone(_activityId)
    elseif _type == RegressionActiveType.Show then
        return false
    elseif _type == RegressionActiveType.ItemPool then
        return ItemPoolActivityMgr:CheckPoolHasRedPoint(_activityId);
    else
        if redInfos == nil then
            redInfos = FileUtil.LoadByPath("Regression_RedInfo.txt") or {}
        end
        return (redInfos[_type] == nil or redInfos[_type] == 0)
    end
end
return this
