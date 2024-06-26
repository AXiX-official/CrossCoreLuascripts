-- 回归相关 
local this = MgrRegister("RegressionMgr")

function this:Init()
    self:Clear()
    -- 回归信息
    --RegressionProto:GetInfo()
end

function this:Clear()
    self.getInfoRetProto = {}
    self.checkReturningPlrProto = {}
end

-- 回归数据
function this:CheckReturningPlr(proto)
    self.checkReturningPlrProto = proto
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

return this
