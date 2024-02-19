--商店推荐页配置
local this = {}

function this.New()
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    return tab
end

function this:SetCfg(cfgId)
    if (cfgId == nil) then
        LogError("初始化商品推荐数据失败！无效配置id")
    end
    if (self.cfg == nil) then
        self.cfg = Cfgs.CfgShopReCommend:GetByID(cfgId)
        if (self.cfg == nil) then
            LogError("找不到商品推荐数据！id = " .. cfgId)
        end
    end
end

function this:GetCfgID() return self.cfg and self.cfg.id or nil end

-- 返回类型
function this:GetType() return self.cfg and self.cfg.type or 1 end

--返回关联UI物体名
function this:GetResName()
    return self.cfg and self.cfg.resName or "ShopPromote/PromoteItem";
end

function this:GetImg()
    return self.cfg and self.cfg.img or nil;
end

function this:GetJumpID()
    return self.cfg and self.cfg.sJumpID or nil;
end

function this:GetTabID()
    return self.cfg and self.cfg.group or nil;
end

function this:HasAssistant()
    return self.cfg and self.cfg.hasAssistant==1 or false;
end

function this:GetModelID()
    return self.cfg and self.cfg.modelID or nil;
end

function this:GetCRoleID()
    return self.cfg and self.cfg.cRoleID or nil;
end

function this:GetVoiceType()
    return self.cfg and self.cfg.voiceType or nil;
end

function this:GetStartTime()
    local time = nil;
	if self.cfg and self.cfg.startTime ~= "" and self.cfg.startTime ~= nil then
		time = self.cfg.startTime;
	end
	return time;
end

function this:GetEndTime()
    local time = nil;
	if self.cfg and self.cfg.endTime ~= "" and self.cfg.endTime ~= nil then
		time = self.cfg.endTime;
	end
	return time;
end

--是否显示红点
function this:HasRed()
    local currState=ShopMgr:PromoteIsRed(self:GetCfgID());
    return currState;
end

function this:SetRed(isRed)
    local currState=ShopMgr:PromoteIsRed(self:GetCfgID());
    if currState~=isRed then
        ShopMgr:SavePromoteState(self:GetCfgID(),isRed);
    end
end

return this