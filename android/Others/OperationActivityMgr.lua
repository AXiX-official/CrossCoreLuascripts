OperationActivityMgr = MgrRegister("OperationActivityMgr")
local this = OperationActivityMgr;

function this:Init()
    self:Clear()
    OperateActiveProto:GetSkinRebateInfo()
    ShopProto:GetSkinRebateRecord()
    OperateActiveProto:GetDragonBoatFestivalInfo() --端午签到
end

function this:Clear()
    self.skinRebateInfos = {}
    self.finishRecords = {}
    self.getRecords = {}
    self.duanWuInfos ={}
    self.duanWuSelType = nil
    self.duanWuRewardIndex = 0
end

---------------------------------------------皮肤返利---------------------------------------------
function this:SetSkinRebateInfos(proto)
    if proto and proto.skinIdList and #proto.skinIdList > 0 then
        for i, v in ipairs(proto.skinIdList) do
            self.skinRebateInfos[v.skinId] = {
                id = v.skinId,
                time = v.nEndTime
            }
        end
    end
    if MenuMgr.isInit then --等待主界面初始化
        EventMgr.Dispatch(EventType.Activity_SkinRebate_Refresh)
    end
end

function this:GetSkinRebateInfo(id)
    return self.skinRebateInfos[id]
end

--获取皮肤返利主界面按钮状态
function this:GetSkinRebateState()
    local _,id = ActivityMgr:IsOpenByType(ActivityListType.SkinRebate)
    local alData = ActivityMgr:GetALData(id)
    if not alData or not alData:GetInfo() or not alData:GetInfo().skinId then
        return
    end
    local type = SkinRebateType.Normal
    local eTime = alData:GetEndTime()
    local rTime = 0
    if eTime > 0 then
        local timeTab = TimeUtil:GetTimeTab(eTime - TimeUtil:GetTime())
        if timeTab[1] < 3 then
            type = SkinRebateType.LimitTime
        else
            rTime = eTime - 259200 --减去三天
        end
    end
    local info = self.skinRebateInfos[alData:GetInfo().skinId]
    if not info or TimeUtil:GetTime() > info.time then
        type = SkinRebateType.Lock
    end
    return type,eTime,rTime
end

--记录可领取奖励
function this:SetSkinRebateFinishRecords(proto)
    if proto and proto.skinRebateRecordList then
        for i, v in ipairs(proto.skinRebateRecordList) do
            self.finishRecords[v.skinId] = self.finishRecords[v.skinId] or {}
            if v.infos and #v.infos > 0 then
                for k, m in ipairs(v.infos) do
                    self.finishRecords[v.skinId][m] = 1
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.Shop_SkinRebate_Finish_Record)
    EventMgr.Dispatch(EventType.Activity_SkinRebate_Refresh)
end

function this:IsSkinRebateFinish(skinId,shopId)
    if self:IsSkinRebateGet(skinId,shopId) then
        return false  
    end
    return self.finishRecords and self.finishRecords[skinId] and self.finishRecords[skinId][shopId] ~= nil
end

--记录已完成奖励
function this:SetSkinRebateGetRecords(proto)
    if proto and proto.skinRebateRecordList then
        for i, v in ipairs(proto.skinRebateRecordList) do
            self.getRecords[v.skinId] = self.getRecords[v.skinId] or {}
            if v.infos and #v.infos > 0 then
                for k, m in ipairs(v.infos) do
                    self.getRecords[v.skinId][m] = 1
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.Shop_SkinRebate_Get_Record)
end

function this:IsSkinRebateGet(skinId,shopId)
    return self.getRecords and self.getRecords[skinId] and self.getRecords[skinId][shopId] ~= nil
end
---------------------------------------------端午签到---------------------------------------------
function this:SetDuanWuInfos(proto)
    if proto then
        if proto.infos and #proto.infos > 0 then
            for i, v in ipairs(proto.infos) do
                self.duanWuInfos[v.type] = v
            end
        end
        self.duanWuSelType = proto.type
        self.duanWuRewardIndex = proto.isTake
    end
    self:CheckRedDuanWuPointData()
    EventMgr.Dispatch(EventType.Activity_DuanWu_Refresh)
end

function this:GetDuanWuInfo(type)
    return self.duanWuInfos[type]
end

function this:GetDuanWuCurSel()
    return self.duanWuSelType
end

--已领取的端午奖励，1-甜 2-咸 
function this:GetDuanWuRewardIndex()
    return self.duanWuRewardIndex
end

function this:CheckRedDuanWuPointData()
    local isOpen,id = ActivityMgr:IsOpenByType(ActivityListType.SignInDuanWu)
    if isOpen then
        local key = SignInMgr:GetDataKeyById(id)
        local signInfo = SignInMgr:GetDataByKey(key)
        local redData = (signInfo and not signInfo:CheckIsDone()) and 1 or nil
        RedPointMgr:UpdateData(RedPointType.SignInDuanWu,redData)
    end
end

return this