--随机商品数据
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end

function this:SetData(data,sortIdx)
	if data then
        self.data = data;
        self:SetCfg(data.reward_id,data.id,data.index);
        self.goods=nil; --当前商品的具体配置信息
        self.sortIdx=sortIdx;
        if data.type==RandRewardType.ITEM or data.type==RandRewardType.CARD then --道具
            self.goods=GoodsData();
            self.goods:InitCfg(data.id);
        elseif data.type==RandRewardType.EQUIP then --商品 
            self.goods=EquipData();
            self.goods:InitCfg(data.id);
        end
	end
end

function this:SetCfg(rewardId,itemId,itemIndex)
    local rewardCfg=Cfgs.RewardInfo:GetByID(rewardId);
    self.cfg=nil;
    if rewardCfg then
        self.icon=rewardCfg.icon;
        self.quality=rewardCfg.quality;
        for k,v in ipairs(rewardCfg.item) do
            if v.id==itemId and k==itemIndex then
                self.cfg=v;
                break;
            end
        end
    end
end

function this:GetCfg()
    return self.cfg;
end

function this:SetShopID(shopID)
    self.shopID=shopID;
end

function this:GetShopID()
    return self.shopID or 0;
end

function this:GetID()
    return self.data and self.data.id or nil;
end

function this:GetTabID()
    return nil;
end

function this:GetRewardID()
    return self.data and self.data.reward_id or nil;
end

--配置表数据列index
function this:GetIndex()
    return self.data and self.data.index or nil;
end

function this:GetSort()
    return self.sortIdx or 0;
end

-- function this:GetTIcon()
--     return nil;
-- end

--兑换下标
function this:SetExchangeIndex(index)
    self.exchangeIndex=index;
end

function this:GetExchangeIndex()
    return self.exchangeIndex or 1;
end

function this:GetIcon()
    return self.goods and self.goods:GetIcon() or nil;
end

function this:GetQuality()
    return self.goods and self.goods:GetQuality() or nil;
end

--返回获得物品的数据
function this:GetCommodityList()
    local info ={};
    if self.data then
        info={{data=self.goods,cid=self:GetID(),num=self.cfg.count,type=self.data.type}}
    end
    return info;
end

--返回可兑换次数
function this:GetNum()
    local num=0;
    if self.data.buyLimit==nil then --不限购
        num=-1;--不限制兑换次数
    elseif self.data.had_get and (self.data.buyLimit-self.data.had_get>0) then
        num=self.data.buyLimit-self.data.had_get;
    elseif self.data.had_get==nil and self.data then
        num=self.data.buyLimit;
    end
    return num;
end

--是否售完
function this:IsOver()
	if self:GetNum()~=-1 and self:GetNum()<=0 then
		return true;
	end
	return false;
end

function this:GetPrice()
    local priceInfo = nil;
    if self.cfg and self.cfg.price and self.data then
		priceInfo = {{id=self.cfg.price[1],num=self.cfg.price[2]}};
	end
	return priceInfo;
end

function this:GetNowDiscount()
    return self.data and self.data.dis or 0;
end

function this:GetDesc()
    return self.cfg and self.cfg.desc or nil;
end

--返回购买商品所获得的道具数量
-- function this:GetGoodsNum()
--     return self.data and self.data.num or 0;
-- end

function this:GetName()
    return self.cfg and self.cfg.productName or "";
    -- return self.goods and self.goods:GetName() or nil;
end

function this:GetRealPrice()
    local priceInfo =nil;
    if self.data then
        priceInfo = {{id=self.data.price[1],num=self.data.price[2]}};
    end
    return priceInfo;
end

--返回商品限购描述
function this:GetLimitDesc()
	local str = "";
	local num = self:GetNum();
	if num > 0 then
		str = string.format(LanguageMgr:GetTips(15003), num);
	end
	return str;
end

function this:GetType()
    return self.data and self.data.type or 1;
end

function this:IsPackage()
    return false;
end

function this:GetOnecBuyLimit()
    return self:GetNum();
end

function this:IsLimitTime()
	return false
end

function this:GetResetTips()
    local str = ""
    local str1,str2="","";
    if self:GetNum() >= 0 then
        str1=LanguageMgr:GetByID(18024);
        str2=tostring( self:GetNum());
        str = str1..str2
    end
    return str,str1,str2
end

function this:IsShow()
    return true;
end

function this:GetEndBuyTips()
    return nil;
end

function this:GetShowLimitRet()
    return true
end

--返回解锁描述
function this:GetBuyLimitDesc()
    local str=""
    return str;
end

-- 返回是否满足购买条件 前置购买条件&购买限制都要满足才能购买
function this:GetBuyLimit()
    return true
end

--返回后台商店ID
function this:GetChargeID()
    -- local chargeCfg=Cfgs.CfgRecharge:GetByID(self:GetID());
    -- if chargeCfg then
    --     return chargeCfg.iosID;
    -- end
    return nil;
end

return this;