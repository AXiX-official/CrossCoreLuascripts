local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:InitData(_cfg)
    self.cfg = _cfg
end

function this:GetID()
    return self:GetCfg().id
end

function this:GetCfg()
    return self.cfg
end

-- 强制弹窗
function this:SetPush(_b)
    local b = true
    if (_b ~= nil) then
        b = _b
    end
    self.push = b
end
function this:GetPush()
    return self.push ~= nil and self.push or false
end

-- 是否有红点
function this:SetRed(b)
    self.red = b
end
function this:GetRed()
    return self.red ~= nil and self.red or false
end

-- 在线期间进入了该id
function this:SetOnlineIn()
    self.isOnlineIn = true
end
function this:GetOnlineIn()
    return self.isOnlineIn
end

-- 任意战斗次数计算
function this:SetFightNum()
    self.fightNum = self.fightNum and self.fightNum + 1 or 1
    if (self.fightNum >= 2) then
        self:SetPush()
    end
end

-- 从商店回来弹出1次
function this:SetShopOpen()
    self.isSetShopOpen = true
end
function this:GetShopOpen()
    return self.isSetShopOpen
end

-- 登录检查一次
function this:LoginCheck()
    if (self:IsInTime() and not self:IsTick()) then
        self.push = true
    end
end

-- 是否不在开放时间或者已结束
function this:IsEnd()
    if (not self:IsInTime()) then
        return true
    end
    local cfg = self:GetCfg()
    if (cfg.nType == 1 or cfg.nType == 2 or cfg.nType == 4) then
        local comm = ShopMgr:GetFixedCommodity(cfg.shopItem)
        if (comm and comm:IsOver()) then
            return true
        end
    elseif (cfg.nType == 3) then
        -- local comm = ShopMgr:GetFixedCommodity(cfg.shopItem)
        -- if (comm and comm:IsOver()) then
        local num = ShopMgr:GetMonthCardDays()
        if (num >= 7) then
            return true
        end
        -- end
    elseif (cfg.nType == 5) then
        local comm = ShopMgr:GetFixedCommodity(cfg.shopItem)
        if (comm and comm:IsOver()) then
            return true -- 已领取 
        end
    elseif (cfg.nType == 6) then
        return self:GetAmount() > 0 -- 期间内充值金额 已领取 
    end
    return false
end

-- 是否已打勾
function this:IsTick()
    local str = PlayerClient:GetUid() .. "MenuBuy_" .. self:GetID()
    local dayRecord = PlayerPrefs.GetString(str, "0") or "0"
    local day = TimeUtil:GetTime3("day")
    if (dayRecord ~= "0" and dayRecord == tostring(day)) then
        return true
    end
    return false
end
function this:SetTick()
    local day = TimeUtil:GetTime3("day")
    local dayStr = self:IsTick() and "0" or tostring(day)
    local str = PlayerClient:GetUid() .. "MenuBuy_" .. self:GetID()
    PlayerPrefs.SetString(str, dayStr)
end

-- 在开放时间内
function this:IsInTime()
    local curTime = TimeUtil:GetTime()
    local startTime = self:GetStartTime()
    if (startTime ~= nil and curTime < startTime) then
        return false
    end
    local endTime = self:GetEndTime()
    if (endTime ~= nil and curTime >= endTime) then
        return false
    end
    return true
end

function this:GetStartTime()
    if (self:GetCfg().startTime ~= nil) then
        return TimeUtil:GetTimeStampBySplit(self:GetCfg().startTime)
    end
    return nil
end

function this:GetEndTime()
    if (self:GetCfg().endTime ~= nil) then
        return TimeUtil:GetTimeStampBySplit(self:GetCfg().endTime)
    end
    return nil
end

-- 充值金额 元
function this:SetAmount(amount)
    self.amount = amount
    if (self.oldAmount) then
        if (self:GetID() == 1 and self.oldAmount == 0 and self.amount > 6) then
            self:SetRed(true)
            self:SetPush(true)
            -- elseif (self:GetID() == 6 and self.oldAmount == 0 and self.amount > 0) then --不需要了 20240801
            --     self:SetRed(true)
            --     self:SetPush(true)
        end
    else
        if (self:GetID() == 1 and not self:IsEnd() and amount >= 6) then
            self:SetRed(true)
        end
    end
    self.oldAmount = self.amount
end

function this:GetAmount()
    return self.amount or 0
end

function this:IsEnough()
    if (self:GetID() == 1) then
        if (self:GetAmount() >= 6) then
            return true
        end
    elseif (self:GetAmount() > 0) then
        return true
    end
    return false
end

return this
