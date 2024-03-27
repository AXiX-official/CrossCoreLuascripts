BuryingPointMgr = {}
local this = BuryingPointMgr

--打点用
function this:BuryingPoint(_eventName, _stepID)
    local uid = PlayerClient:GetUid() or 0
    local infos = FileUtil.LoadByPath("BuryingPoint_" .. uid ..".txt") or {}
    if not infos[_eventName .. "_" .. _stepID] then
        local datas = self:GetDefautDatas() 
        datas.step_id = _stepID
        self:TrackEvents(_eventName, datas)
        FileUtil.SaveToFile("BuryingPoint_" .. uid ..".txt", infos)
    end
end

function this:GetDefautDatas()
    local datas = {}
    datas.account_id = PlayerClient:GetAccount()
    datas.time = TimeUtil:GetTimeStr2(TimeUtil:GetTime(),true)
    datas.ip = LoginProto.ip or 0
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

function this:SetOpenID(_id)
    self.openID = _id
end

--上报事件
function this:TrackEvents(_eventName, _datas, _type, _eventId)
    ThinkingAnalyticsMgr:TrackEvents(_eventName, _datas, _type, _eventId)
end

return this