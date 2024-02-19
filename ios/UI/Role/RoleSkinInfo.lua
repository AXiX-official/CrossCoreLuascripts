-- 皮肤
local this = {}

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

-- ==============================--
-- desc:
-- time:2019-08-19 11:34:07
-- @_cardId:卡id
-- @_skinid:皮肤id
-- @_minBreakLv:最低可用的突破等级
-- @_type:皮肤类型
-- @_typeNum:0:正常的皮肤， 1：变身的皮肤，2：合体的皮肤
-- @return
-- ==============================--
function this:Set(_cardId, _skinid, _minBreakLv, _type, _typeNum)
    self.cardId = _cardId
    self.skinid = _skinid
    self.minBreakLv = _minBreakLv or 2
    self.type = _type or CardSkinType.Break
    self.typeNum = _typeNum
    self:SetIndex()
end

function this:GetSkinID()
    return self.skinid
end

function this:SetIndex()
    local add = self.type * 10
    self.index = add + self.minBreakLv
end

-- 排序index
function this:GetIndex()
    return self.index
end

-- 某卡牌是否可以使用这个皮肤
-- function this:CheckCanUse(cardData)
function this:CheckCanUse()
    if (self.type == CardSkinType.Break) then
        local cardData = RoleMgr:GetData(self.cardId)
        local lv = cardData and cardData:GetBreakLevel() or 1
        if (self.minBreakLv > 1 and lv < self.minBreakLv) then
            return false
        else
            return true
        end
    else
        return self:GetCanUse()
    end
end

-- 皮肤是否已解锁或获得
function this:CheckCanUseByMaxLV()
    if (self.type == CardSkinType.Break) then
        local cRoleData = CRoleMgr:GetData(self:GetCfg().role_id)
        local lv = cRoleData and cRoleData:GetBreakLevel() or 1
        if (lv >= self.minBreakLv) then
            return true
        end
        return false
    else
        return self:GetCanUse()
    end
end

-- 设置额外皮肤是否可用
function this:SetCanUse(b)
    self.canUse = b
end

function this:GetCanUse()
    return self.canUse or false
end

function this:GetCfg()
    if (not self.cfg) then
        self.cfg = Cfgs.character:GetByID(self:GetSkinID())
    end
    return self.cfg
end

-- function this:GetImg()
-- 	return self.cfg and self.cfg.smallImg or nil
-- end
function this:GetName()
    return self:GetCfg() and self:GetCfg().desc or ""
end

function this:GetEnglishName()
    return self:GetCfg() and self:GetCfg().englishName or ""
end

function this:GetDesc()
    return self:GetCfg() and self:GetCfg().model_desc or ""
end

function this:GetCardId()
    return self.cardId or nil
end

function this:SetRoleId(_id)
    self.roleId = _id
end

function this:GetRoleId()
    return self.roleId
end

function this:GetTypeNum()
    return self.typeNum
end

function this:CheckIsNew()
    if (not self:CheckCanUse()) then
        return false
    end
    local cRoleData = CRoleMgr:GetData(self:GetCfg().role_id)
    if (cRoleData) then
        return cRoleData:CheckSkinIsNew(self:GetSkinID())
    end
    return false
end

-- 突破类型皮肤
function this:CheckIsBreakType()
    return self.type == CardSkinType.Break
end

-- 是否是非突破类型皮肤
function this:CheckIsNotBreakType()
    return self.type ~= CardSkinType.Break
end

-- 非突破类型皮肤，是否出售中
function this:IsInSell()
    if (not self:CheckIsNotBreakType()) then
        return false 
    end
    local shopId = self:GetCfg().shopId
    local cfg = shopId and Cfgs.CfgCommodity:GetByID(shopId) or nil
    if (cfg) then
        local curTime = TimeUtil:GetTime()
        local startTime = cfg.sBuyStart and TimeUtil:GetTimeStampBySplit(cfg.sBuyStart) or nil
        local sBuyEnd = cfg.sBuyEnd and TimeUtil:GetTimeStampBySplit(cfg.sBuyEnd) or nil
        if (startTime and curTime < startTime) then
            return false
        end
        if (sBuyEnd and curTime > sBuyEnd) then
            return false
        end
        return true
    end
    return false
end

--皮肤类型
function this:GetSkinType()
    return self:GetCfg().skinType or 0
end

return this
