local SignInInfo = require "SignInInfo" -- 某活动数据
local SignInfDayInfo = require "SignInfDayInfo" -- 某活动日数据
local this = MgrRegister("SignInMgr")

local allKeys = {} -- 是否已接收完所有记录

function this:Init()
    self.datas = {}
    self.cacheRecord = {} -- 打开记录
    -- 获取所有数据
    ClientProto:GetSignInfo(0)
end

-- 获取所有数据
function this:Clear()
    self.datas = {}
    self.cacheRecord = {}
end

-- 封装数据key值
function this:GetDataKey(id, index)
    return string.format("%s_%s", id, index)
end

-- 当天日期（当天到明天的g_ActivityDiffDayTime点均为当天）
function this:GetCurDay(timer)
    timer = timer == nil and TimeUtil:GetBJTime() or timer
    local curDay = 0
    local d = tonumber(TimeUtil:GetTime3("day", timer))
    local h = tonumber(TimeUtil:GetTime3("hour", timer))

    if (h >= g_ActivityDiffDayTime) then
        curDay = d
    else
        curDay = curDay - 1
        if (curDay < 0) then
            -- 上一天
            -- 可能是上个月最后一天，亦有可能是上一年
            -- 通过时间戳来换算
            local time = TimeUtil:GetBJTime() - 86400
            curDay = tonumber(TimeUtil:GetTime3("day", time))
        end
    end
    return curDay
end

-- 获取数据回调
function this:GetSignInfoRet(proto)
    if (proto.id ~= 0) then
        local key = self:GetDataKey(proto.id, proto.index)
        local _data = self.datas[key]
        if (_data) then
            _data:InitData(key, proto)
        else
            local info = SignInInfo.New()
            info:InitData(key, proto)
            self.datas[key] = info
        end
    end
    -- 收完数据推送一次
    if (proto.is_end) then
        EventMgr.Dispatch(EventType.Activity_Get_SignIn)
    end
end

function this:GetArr()
    local arr = {}
    for i, v in pairs(self.datas) do
        table.insert(arr, v)
    end
    if (#arr > 1) then
        table.sort(arr, function(a, b)
            return a:GetSortIndex() > b:GetSortIndex()
        end)
    end
    return arr
end

function this:GetSignInContinueData()
    local arr = self:GetArr()
    for i, v in ipairs(arr) do
        if v:GetType() == RewardActivityType.Continuous then
            local activityType = v:GetCfg().activityID
            if activityType and activityType == ActivityListType.SignInContinue then
                return v
            end
        end
    end
    return nil
end

-- 获取每日签到的key
function this:GetDataDayKey()
    for i, v in pairs(self.datas) do
        if (v:GetType() == RewardActivityType.DateDay) then
            return v:GetKey()
        end
    end
end

-- 获取指定类型的key
function this:GetDataKeyByType(_type)
    for i, v in pairs(self.datas) do
        if (v:GetType() == _type) then
            return v:GetKey()
        end
    end
end

--获取指定类型的key列表
function this:GetDataKeysByType(_type)
    local keys = {}
    for i, v in pairs(self.datas) do
        if (v:GetType() == _type) then
            local activityID = v:GetActivityID() or 0
            keys[activityID] = v:GetKey()
        end
    end
    return keys
end

-- 获取单个活动的数据
function this:GetData(id, index)
    local key = self:GetDataKey(id, index)
    return self.datas[key]
end

function this:GetDataByKey(key)
    return self.datas[key]
end

-- 某个活动的每日数据   临时封装(用完即删)
function this:GetDayInfos(key)
    local data = self:GetDataByKey(key)
    if (data == nil or not data:CheckInTime()) then
        -- 数据为空或者不在活动时间段内
        return
    end
    local infos = {}
    local rewardCfgs = data:GetRewardCfg()
    local curDay = self:GetCurDay() -- 当天
    if (data:GetType() == RewardActivityType.Continuous) then -- 连续签到
        curDay = data:GetRealDay()
    end
    if (rewardCfgs) then
        local id = data:GetID()
        for i, v in ipairs(rewardCfgs.infos) do
            local info = SignInfDayInfo.New()
            info:InitData(id, v)
            local isDone = data:CheckIndexIsDone(i) -- 是否已签
            local isEnd = (curDay - i) > 0 -- 是否已过期
            if (data:GetType() == RewardActivityType.Continuous) then
                isEnd = false -- 连续签到不会过期
            end
            local isCurDay = curDay == i -- 是否是当天
            local isNextDay = i - 1 == curDay

            info:SetInfos(isDone, isEnd, isCurDay,isNextDay)
            table.insert(infos, info)
        end
    end
    return infos
end

-- 签到回调
function this:AddSignRet(proto)
    if (proto.isOk) then
        local data = self:GetData(proto.id, proto.index)
        if (data) then
            data:SetRewardsInfos(proto.rewardsInfos)
        end
    end
    EventMgr.Dispatch(EventType.Activity_SignIn, proto)
end

-------------------------------------------------签到检测------------------------------------------------------
function this:OpenSignIn(_type, _key)
    local isOpen, str = self:SignInIsOpen()
    if (isOpen) then
        ActivityMgr:OpenListView(_type, {
            key = _key
        })
    else
        Tips.ShowTips(str)
    end
end

-- 签到系统是否已开启
function this:SignInIsOpen()
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ActivityListView")
    return isOpen, str
end

-- 签到系统是否已开启
function this:CheckNeedSignIn()
    if (not self:SignInIsOpen()) then
        return false
    end

    local b = false
    local arr = self:GetArr()
    for i, v in ipairs(arr) do
        if (not v:CheckIsDone()) then
            if (v:GetType() == RewardActivityType.DateDay) then
                return true
            elseif (v:GetType() == RewardActivityType.Continuous) then
                return true
            elseif (v:GetType() == RewardActivityType.DateMonth) then
                -- 日签到 todo
                return false
            end
        end
    end
end

-- 检测签到
function this:CheckAll()
    -- 有引导
    if (GuideMgr:HasGuide() or GuideMgr:IsGuiding()) then
        return false
    end

    if (not self:SignInIsOpen()) then
        return false
    end

    if not self.datas then
        return false
    end

    local arr = self:GetArr()
    local isOpen = false
    for i, v in ipairs(arr) do
        if (not v:CheckIsDone()) then
            local _key = v:GetKey()
            local _data = {key = _key, isSingIn = true}
            -- self:AddCacheRecord(_key)
            if (v:GetType() == RewardActivityType.DateDay) then
                -- 月签到
                if ActivityMgr:PanelCanJump(ActivityListType.SignIn) then
                    isOpen = true
                    ActivityMgr:AddNextOpen(ActivityListType.SignIn, _data)
                end
            elseif (v:GetType() == RewardActivityType.Continuous) then
                -- 连续签到 todo
                local activityType = v:GetCfg().activityID
                if ActivityMgr:PanelCanJump(activityType) and ActivityMgr:CheckIsOpen(activityType) then
                    isOpen = true
                    ActivityMgr:AddNextOpen(activityType, _data)
                end
            elseif (v:GetType() == RewardActivityType.DateMonth) then
                -- 日签到 todo
            end
        end
    end
    if (isOpen) then
        CSAPI.OpenView("ActivityListView")
    end
    return isOpen
end

-- 当次登录是否已弹出过，是就不继续弹出签到保证只弹1次
function this:CurDayIsOpen(_key)
    local curDay = self:GetCurDay() -- 当天
    local key = string.format("%s_%s", _key, curDay)
    if (self.cacheRecord and self.cacheRecord[key] == 1) then
        return true
    end
    return false
end
function this:AddCacheRecord(_key)
    self.cacheRecord = self.cacheRecord == nil and self.cacheRecord or self.cacheRecord
    local curDay = self:GetCurDay() -- 当天
    local key = string.format("%s_%s", _key, curDay)
    self.cacheRecord[key] = 1
end

function this:GetNewTimeData()
    local newTimeData = nil
    local time = TimeUtil:GetBJTime()
    local newTimeData = TimeUtil:GetTimeHMS(time, "*t")
    local day = newTimeData.day or 1
    if (newTimeData.hour < g_ActivityDiffDayTime) then
        time = time - 86400
        newTimeData = TimeUtil:GetTimeHMS(time, "*t")
    end
    return newTimeData
end

return this
