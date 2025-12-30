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

-- 返回显示类型
function this:GetShowType() return self.cfg and self.cfg.showType or 1 end


function this:GetImg()
    return self.cfg and self.cfg.img or nil;
end

function this:GetJumpID()
    return self.cfg and self.cfg.sJumpID or nil;
end

function this:GetTabID()
    return self.cfg and self.cfg.group or nil;
end

function this:GetStartTime()
    local time = 0;
	if self.cfg and self.cfg.startTime ~= "" and self.cfg.startTime ~= nil then
		time = TimeUtil:GetTimeStampBySplit(self.cfg.startTime)
	end
	return time;
end

function this:GetEndTime()
    local time = 0;
	if self.cfg and self.cfg.endTime ~= "" and self.cfg.endTime ~= nil then
		time = TimeUtil:GetTimeStampBySplit(self.cfg.endTime)
	end
	return time;
end

function this:GetSort()
    return self.cfg and self.cfg.sort or 1000;
end

--返回当前推荐商品是否已经购买过
function this:IsBuy()
    local isBuy=false;
    local commId=self.cfg and self.cfg.commID or nil;
    if commId then
        local comm=ShopMgr:GetFixedCommodity(commId);
        if comm and comm:GetBuyCount()>0 then
            isBuy=true;
        end
    end
    return isBuy;
end

-- 返回当前时间段该商品是否可以购买
function this:GetNowTimeCanShow()
    local canShow = true
    local currTime = TimeUtil:GetTime()
    local beginTime = self:GetStartTime()
    local endTime = self:GetEndTime()
    if (beginTime ~= 0 and currTime < beginTime) or
        (endTime ~= 0 and currTime >= endTime) then canShow = false end
    return canShow
end

--返回跳转信息
function this:GetJumpInfo()
    local jumpInfo=nil;
    local jumpId=self:GetJumpID();
    if jumpId~=nil then
        local jumpCfg=Cfgs.CfgJump:GetByID(jumpId);
        if jumpCfg==nil then
            LogError("读取跳转表错误！未找到跳转ID："..tostring(jumpId).."对应的数据！");
            do return end
        end
        if jumpCfg.val1 and jumpCfg.val1 ~= 0 and jumpCfg.val2 == nil and jumpCfg.val3 == nil then -- 打开单个商店
            jumpInfo={
                id=self.cfg.sJumpID,
                commId=self.cfg.commID,
                shopId=jumpCfg.val1,
            }
        else
            jumpInfo={
                id=self.cfg.sJumpID,
                commId=self.cfg.commID,
                shopId=jumpCfg.val2,
                topId=jumpCfg.val3,--二级页签ID
            }
        end
    else --根据商品ID进行跳转
        local commId=self.cfg and self.cfg.commID or nil;
        if commId then
            local comm=ShopMgr:GetFixedCommodity(commId);
            if comm and comm:GetNowTimeCanBuy() then
                if comm:IsOver() then
                    LanguageMgr:ShowTips(15125);
                else
                    jumpInfo={
                        commId=self.cfg.commID,
                        shopId=comm:GetShopID(),
                        topId=comm:GetTabID(),--二级页签ID
                    }
                end
            else
                LanguageMgr:ShowTips(15007);
            end
        end
    end
    return jumpInfo;
end

--返回自动换页时间
function this:GetChangeTime()
    return  self.cfg and self.cfg.changeTimer or 5;
end

return this