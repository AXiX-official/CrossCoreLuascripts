BuryingPointMgr = {}
local this = BuryingPointMgr

--打点用
function this:BuryingPoint(_eventName, _stepID)
    local uid = PlayerClient:GetUid() or 0
    local infos = FileUtil.LoadByPath("BuryingPoint.txt", true) or {}
    if not infos[_eventName .. "_" .. _stepID] then
        local datas = {}
        if _eventName ~= "before_login" then
            datas = self:GetDefautDatas() 
        end
        datas.step_id = _stepID
        self:TrackEvents(_eventName, datas,nil,nil,_eventName == "before_login")
        self:SDKTrack(_eventName, datas)
        --Log("打点上报，事件名：" .._eventName .. ",步骤id：" .. _stepID)
        infos[_eventName .. "_" .. _stepID] = 1
        FileUtil.SaveToFile("BuryingPoint.txt", infos, true)
    end
end

function this:GetDefautDatas()
    local datas = {}
    datas.account_id = PlayerClient:GetAccount()
    datas.time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(),true)
    -- datas.ip = LoginProto.ip or ""
    datas.zone_offset = g_TimeZone or 8
    datas.app_id = 0
    datas.device_id = ThinkingAnalyticsMgr:GetpresetProperty("device_id")
    datas.device_model = ThinkingAnalyticsMgr:GetpresetProperty("device_model")
    datas.open_id = self.openID or 0
    datas.user_id = PlayerClient:GetUid()
    local info = GetCurrentServer()
    datas.zone_id = info and info.id or 0
    return datas
end

--其他上报
function this:SDKTrack(_eventName, _stepID)
    if _stepID == nil or _stepID == 0 then
        return
    end
    local cfg =Cfgs.UpdateData:GetByID(_stepID)
    if cfg and cfg.HC_event and cfg.HC_argument and cfg.TE_event == _eventName then
        local data = {}
        data[cfg.HC_argument] = _stepID
        if CSAPI.GetADID() > 0 and ReYunSDK and ReYunSDK.SetCustomEvent then
            ReYunSDK:SetCustomEvent(cfg.HC_event,data);
        end
    end
end

function this:SetOpenID(_id)
    self.openID = _id
end

--上报事件
function this:TrackEvents(_eventName, _datas, _type, _eventId,isNoRefresh)
    ThinkingAnalyticsMgr:TrackEvents(_eventName, _datas, _type, _eventId,isNoRefresh)
end

return this