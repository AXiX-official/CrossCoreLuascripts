-- 固定商品数据
local this = {}

function this.New()
    this.__index = this.__index or this
    local tab = {}
    setmetatable(tab, this)
    return tab
end

function this:SetCfg(cfgId)
    if (cfgId == nil) then
        LogError("初始化商品数据失败！无效配置id")
    end
    if (self.cfg == nil) then
        self.cfg = Cfgs.CfgCommodity:GetByID(cfgId)
        if (self.cfg == nil) then
            LogError("找不到商品数据！id = " .. cfgId)
        end
    end
end

function this:GetCfg()
    return self.cfg;
end

function this:SetData(data) 
    if data then 
        self.data = data 
    end 
end

function this:GetData()
    return self.data;
end

function this:HasData()
    return self:GetData()~=nil and true or false
end

function this:GetShopID()
    if self.cfg then return self.cfg.group end
    return nil
end

function this:GetTabID()
    return self.cfg and self.cfg.tabID or nil;
end

function this:GetCfgID() return self.cfg and self.cfg.id or nil end

function this:GetID() return self.cfg and self.cfg.id or nil end

-- 返回类型
function this:GetType() return self.cfg and self.cfg.nType or 1 end

-- 返回ICON
function this:GetIcon() return self.cfg and self.cfg.sIcon or "" end

-- 返回ICON2
function this:GetIcon2() return self.cfg and self.cfg.sIcon_2 or nil end

-- 格子图标
function this:GetGirdIcon() return self.cfg and self.cfg.sGridIcon or "" end

-- 格子品质
function this:GetQuality() return self.cfg and self.cfg.packageQuality or 1 end

-- 返回商品名称
function this:GetName() return self.cfg and self.cfg.sName or "" end

-- 返回商品说明
function this:GetDesc() return self.cfg and self.cfg.sDesc or "" end

--售罄的时候是否显示
function this:ShowOnSoldOut()
    local isShow=true;
    if self.cfg and self.cfg.ShowOnSoldOut==1  then
        isShow=false;
    end
    return isShow;
end

-- 返回当前折扣
function this:GetNowDiscount()
    local num = 1
    if self.cfg then
        local nowTime = TimeUtil:GetTime()
        -- TimeUtil:GetTimeStampBySplit:将字符串转成时间
        local begin = self:GetDiscountStartTime()
        local endTime = self:GetDiscountEndTime()
        if nowTime >= begin and (endTime == 0 or nowTime <= endTime) then -- 折扣时间内则有效
            -- num = self.cfg.fDiscount ~= 0 and self.cfg.fDiscount or num
            if self.data and self.data.shop_config and self.data.shop_config.fDiscount then
                num=self.data.shop_config.fDiscount
            end
        end
    end
    return num
end

--显示优先级，值越小越先显示
function this:GetSort()
    return self.cfg and self.cfg.sort or 9999;
end

-- function this:GetTIcon()
--     return self.cfg and self.cfg.tIcon or nil;
-- end

--返回商店分页ID
function this:GetShopID()
    return self.cfg and self.cfg.group or nil;
end

function this:GetPackageIcon()
    return self.cfg and self.cfg.packageIcon or nil
end

-- 返回折扣开始时间字符串
function this:GetDiscountStart()
    local time = self:GetDiscountStartTime();
    if time>0 then
        return TimeUtil:GetTimeStr2(time)
    else
        return nil
    end
    return time
end

-- 返回折扣结束时间字符串
function this:GetDiscountEnd()
    local time = self:GetDiscountEndTime();
    if time>0 then
        return TimeUtil:GetTimeStr2(time)
    else
        return nil
    end
end

-- 返回折扣开始时间秒数
function this:GetDiscountStartTime()
    local time = 0
    if self.data and self.data.shop_config and self.data.shop_config.nDiscountStart then
        time = self.data.shop_config.nDiscountStart;
    end
    return time
end

-- 返回折扣结束时间秒数
function this:GetDiscountEndTime()
    local time = 0
    if self.data and self.data.shop_config and self.data.shop_config.nDiscountEnd then
        time = self.data.shop_config.nDiscountEnd;
    end
    return time
end

-- 单次购买上限
function this:GetOnecBuyLimit()
    --  return self.cfg and self.cfg.nOnecBuyLimit or 0
    if self.data and self.data.shop_config and self.data.shop_config.nOnecBuyLimit then
        return self.data.shop_config.nOnecBuyLimit  
    end
    return 0
end

-- 总购买上限
function this:GetSumBuyLimit()
    --  return self.cfg and self.cfg.nSumBuyLimit or 0 
    if self.data and self.data.shop_config and self.data.shop_config.nSumBuyLimit then
        return self.data.shop_config.nSumBuyLimit   
    end
    return 0
end

-- 重置类型
function this:GetResetType()
    --  return self.cfg and self.cfg.nResetType or 0 
    if self.data and self.data.shop_config and self.data.shop_config.nResetType then
        return self.data.shop_config.nResetType   
    end
    return 0
end

-- 重置值
function this:GetResetValue() 
    -- return self.cfg and self.cfg.nResetValue or 0 
    if self.data and self.data.shop_config and self.data.shop_config.nResetValue then
        return self.data.shop_config.nResetValue   
    end
    return 0
end

function this:GetResetTips()
    local str = ""
    local str1,str2="","";
    local time = GCalHelp:GetCycleResetTime(self:GetResetType(),
                                            self:GetResetValue(),
                                            TimeUtil:GetTime())
    if time > 0 then
        local type=self:GetResetType();
        local id=18022;
        if type==1 then
            id=18022;
        elseif type==2 then
            id=18003;
        elseif type==3 then
            id=18023;
        end
        str1=LanguageMgr:GetByID(id);
        local numStr=self:GetNum()==-1 and LanguageMgr:GetByID(18078) or tostring(self:GetNum())
        str2=numStr;
        str =string.format(str1, str2)
        -- local t = TimeUtil:GetDiffHMS(time, TimeUtil:GetTime())
        -- local month = math.floor(t.day / 28 + 0.5)
        -- local week = math.floor(t.day / 7 + 0.5)
        -- local day = t.hour > 0 and t.day + 1 or t.day
        -- if month > 0 then
        --     str =
        --         string.format(LanguageMgr:GetByID(18023), self:GetNum(), month)
        -- elseif week > 0 then
        --     str = string.format(LanguageMgr:GetByID(18003), self:GetNum(), week)
        -- else
        --     str = string.format(LanguageMgr:GetByID(18022), self:GetNum(), day)
        -- end
    elseif self:GetNum() >= 0 then
        str1=LanguageMgr:GetByID(18024);
        str2=tostring(self:GetNum());
        str = str1..str2;
    end
    return str,str1,str2;
end

-- 返回购买条件类型
function this:GetBuyLimitType() return self.cfg and self.cfg.nBuyLimitType or 0 end

-- 返回购买条件参数
function this:GetBuyLimitVal() return self.cfg and self.cfg.nBuyLimitVal or 0 end

-- 返回购买开始时间字符串
function this:GetBuyStart()
    local time = self:GetBuyStartTime();
    if time>0 then
        return TimeUtil:GetTimeStr2(time)
    else
        return nil
    end    
end

-- 返回购买开始时间秒数
function this:GetBuyStartTime()
    local time = 0
    if self.data and self.data.open_time then
        time = self.data.open_time;
    end
    return time
end

-- 返回购买结束时间
function this:GetBuyEnd()
    local time = self:GetBuyEndTime()
    if time>0 then
        return TimeUtil:GetTimeStr2(time)
    else
        return nil
    end        
end

-- 返回购买结束时间秒数
function this:GetBuyEndTime()
    local time = 0
    if self.data and self.data.close_time then      
        time = self.data.close_time
    end
    return time
end

-- 是否限时
function this:IsLimitTime()    
    if self:GetBuyEnd()~=nil and self:GetBuyStart()~=nil then
        return true
    end
    return false
end

--解锁前置显示商品ID
function this:GetPreShowID()
    if self.cfg and self.cfg.predisplayID then
        return self.cfg.predisplayID;
    end
end

--显示条件类型
function this:GetShowLimitType()
    if self.cfg and self.cfg.nShowLimitType then
        return self.cfg.nShowLimitType;
    end
end

--显示条件值
function this:GetShowLimitVal()
    if self.cfg and self.cfg.nShowLimitVal then
        return self.cfg.nShowLimitVal;
    end
end

--显示解锁购买前置商品ID
function this:GetPreLimitID()
    if self.cfg and self.cfg.prerequisiteID then
        return self.cfg.prerequisiteID;
    end
end

--返回是否满足显示条件
function this:GetShowLimitRet()
    local preLimit=self:GetPreShowID();
    local type = self:GetShowLimitType()
    local val = self:GetShowLimitVal()
    local canShow = false
    if preLimit and ShopMgr:HasBuyRecord(preLimit)~=true then
        return canShow;
    end
    if type == CommodityShowLimitType.Null or type==nil then
        canShow = true
    elseif type == CommodityShowLimitType.Day then
        local max = PlayerClient:GetCreateTime() + val * 86400
        if TimeUtil:GetTime() < max then 
            canShow = true 
        end
    elseif type==CommodityShowLimitType.PlayLv then
        canShow=PlayerClient:GetLv()>=val;
    elseif type==CommodityShowLimitType.Dungeon then
        local dungeonInfo=DungeonMgr:GetDungeonData(val);
        if dungeonInfo then
            canShow=dungeonInfo:IsPass();
        end
    end
    return canShow
end

--返回解锁描述
function this:GetBuyLimitDesc()
    local str=""
    local preComm=self:GetPreLimitID();--前置购买ID
    local type = self:GetBuyLimitType()
    local val = self:GetBuyLimitVal()
    if preComm and ShopMgr:HasBuyRecord(preComm)~=true then
        local comm=CommodityData.New();
        comm:SetCfg(preComm);
        str= LanguageMgr:GetByID(18080,comm:GetName());
        return str;
    end
    if type == CommodityLimitType.Null then
    elseif type == CommodityLimitType.Day then
        local max = PlayerClient:GetCreateTime() + val * 86400
        local days=0;
        if TimeUtil:GetTime() < max  then
            days=math.floor((max-TimeUtil:GetTime())/86400+0.5)
        end
        str=LanguageMgr:GetByID(18082,days);
    elseif type==CommodityLimitType.PlayLv then
        str=LanguageMgr:GetByID(1033)..val;
    elseif type==CommodityLimitType.Dungeon then
        local dungeonInfo=DungeonMgr:GetDungeonData(val);
        if dungeonInfo then
            str= LanguageMgr:GetByID(18079,dungeonInfo:GetCfg().name)
        end
    end
    return str;
end

-- 返回是否满足购买条件 前置购买条件&购买限制都要满足才能购买
function this:GetBuyLimit()
    local preComm=self:GetPreLimitID();--前置购买ID
    local type = self:GetBuyLimitType()
    local val = self:GetBuyLimitVal()
    local canBuy = false
    if preComm and ShopMgr:HasBuyRecord(preComm)~=true then
        return canBuy;
    end
    if type == CommodityLimitType.Null or type==nil then
        canBuy = true
    elseif type == CommodityLimitType.Day then
        local max = PlayerClient:GetCreateTime() + val * 86400
        if TimeUtil:GetTime() < max then canBuy = true end
    elseif type==CommodityLimitType.PlayLv then
        canBuy=PlayerClient:GetLv()>=val;
    elseif type==CommodityLimitType.Dungeon then
        local dungeonInfo=DungeonMgr:GetDungeonData(val);
        if dungeonInfo then
            canBuy=dungeonInfo:IsPass();
        end
    end
    return canBuy
end

-- 返回未打折的价格
function this:GetPrice()
    local priceInfo = nil
    local jCosts=nil;
    if self.data and self.data.shop_config then
        jCosts=self.data.shop_config.jCosts;
    elseif self.cfg then
        jCosts=self.cfg.jCosts;
    end
    if jCosts then
        priceInfo = {}
        for k, v in ipairs(jCosts) do
            local info = {}
            info.id = v[1]
            info.num = v[2]
            table.insert(priceInfo, info)
        end
    end
    return priceInfo
end

-- 返回打折的价格
function this:GetRealPrice()
    local infos = nil
    local priceInfo = self:GetPrice()
    local discount = self:GetNowDiscount()
    if priceInfo then
        infos = {}
        for k, v in ipairs(priceInfo) do
            local num = discount == 1 and v.num or
                            math.modf(tonumber(v.num) * discount)
            table.insert(infos, {id = v.id, num = num})
        end
    end
    return infos
end

-- 返回获得物品数据
function this:GetCommodityList()
    local info = nil
    local jGets=nil;
    if self.data and self.data.shop_config and self.data.shop_config.jGets then
        jGets=self.data.shop_config.jGets;
    end
    if jGets then
        info = {}
        for k, v in ipairs(jGets) do
            local type = v[3]
            local data = nil
            if type == RandRewardType.ITEM then
                data = GoodsData()
                data:InitCfg(v[1])
            elseif type == RandRewardType.CARD then
                data = CharacterCardsData()
                data:InitCfg(v[1])
            elseif type == RandRewardType.EQUIP then
                data = EquipData()
                data:InitCfg(v[1])
            end
            table.insert(info,
                         {data = data, cid = v[1], num = v[2], type = type})
        end
    end
    return info
end

-- 返回当前额外获得的东西
function this:GetExCommodityList()
    local jExGets=self:GetExGets();
    if jExGets then
        local infos = nil
        local num = self:GetBuyCount()
        local val = nil
        for k,v in ipairs(jExGets) do
			if v[1]==num+1 then
				val = v[2]
			end
		end
		if (val==nil and jExGets[1][1] == 0) then -- self.cfg.jExGets[1][1]==0表示默认赠送物品，不管购买多少次，如果没有对应的购买次数赠送的额外物品，那就取这个
            val = jExGets[1][2]
        end
        if val then
            infos = {}
            -- for _, val in ipairs(list) do
                local type = val[3]
                local data = nil
                if type == RandRewardType.ITEM then
                    data = GoodsData()
                    data:InitCfg(val[1])
                elseif type == RandRewardType.CARD then
                    data = CharacterCardsData()
                    data:InitCfg(val[1])
                elseif type == RandRewardType.EQUIP then
                    data = EquipData()
                    data:InitCfg(val[1])
                end
                table.insert(infos, {
                    data = data,
                    cid = val[1],
                    num = val[2],
                    type = type
                })
            -- end
        end
        return infos
    end
    return nil
end

-- 返回额外获得配置
function this:GetExGets()
    --  return self.cfg and self.cfg.jExGets or nil 
    local jExGets=nil;
    if self.data and self.data.shop_config and self.data.shop_config.jExGets then
        jExGets=self.data.shop_config.jExGets
    end
    return jExGets;
end

-- 返回商品剩余数量
function this:GetNum()
    local num = 0
    if self.data and self:GetSumBuyLimit() ~= -1 then
        num = self.data.can_buy_cnt -- 当物品剩余数量没有限制的时候，返回-1。
    elseif self.data == nil and self:GetSumBuyLimit() ~= -1 then
        num = self:GetSumBuyLimit()
    elseif self:GetSumBuyLimit() == -1 then
        num = -1
    end
    if num~=-1 and (self:GetType()==CommodityItemType.THEME or self:GetType()==CommodityItemType.FORNITURE) then --家具的可剩余购买次数需要减去持有数
        local list=self:GetCommodityList();
        if list then
            -- if list[1].data==nil then
            --     LogError(self:GetID())
            --     LogError(list[1])
            -- end
            local dyVal1=list[1].data:GetDyVal1();
            --查询宿舍表
            local buyCount=num; --持有上限值
            if dyVal1 then
                local cfg = Cfgs.CfgFurniture:GetByID(dyVal1);  
                --判断是否超过持有数，超过持有数不能购买
                if self:GetType()==CommodityItemType.FORNITURE then --家具
                    buyCount=cfg.buyNumLimit-DormMgr:GetBuyCount(dyVal1);
                else--主题
                    local themeData = DormMgr:GetThemesByID(ThemeType.Sys, dyVal1)
                    local cfg2=Cfgs.CfgFurnitureTheme:GetByID(dyVal1);
                    local num2=cfg2.comfort;
                    buyCount=themeData~=nil and 0 or num;
                end
            end
            num=num>=buyCount and buyCount or num; --真正的购买上限
        end
    end
    return num
end

-- 是否售完
function this:IsOver()
    if self:HasData()~=true then --未开放购买
        return true;
    end
    if self:GetType() == CommodityItemType.Skin then
        local skinInfo =ShopCommFunc.GetSkinInfo(self);
        if skinInfo==nil then
            return true;
        end
        local curModelCfg=skinInfo:GetModelCfg();
        local rSkinInfo=RoleSkinMgr:GetRoleSkinInfo(curModelCfg.role_id,curModelCfg.id);
        if rSkinInfo and rSkinInfo:CheckCanUse() then
            return true;
        elseif self:GetNum() ~= -1 and self:GetNum() <= 0 then
            return true;
        end
    elseif self:GetType() == CommodityItemType.THEME then
        local good=self:GetCommodityList()[1];
        local dyVal1=good.data:GetDyVal1();
        if self:GetNum() ~= -1 and self:GetNum() <= 0 then 
            return true 
        elseif dyVal1 then
           return ShopCommFunc.GetThemeInfo(dyVal1);
        end
    elseif self:GetNum() ~= -1 and self:GetNum() <= 0 then 
        return true 
    end
    return false
end

-- 返回商品重置时间
function this:GetResetTime() return self.data and self.data.reset_time or 0 end

-- 返回商品限购描述
function this:GetLimitDesc(colorCode)
    local str = ""
    local resetType = self:GetResetType()
    local sumBuyLimit = self:GetSumBuyLimit()
    local num = self:GetNum()
    if sumBuyLimit > 0 and num>=0 then
		if colorCode~=nil then
			str = string.format(LanguageMgr:GetTips(15003), string.format("<color=#%s>%s</color>",colorCode,num))
		else
        	str = string.format(LanguageMgr:GetTips(15003), num)
		end
    end
    return str
end

-- 返回当期已经购买的次数
function this:GetBuyCount()
    if self.data and self.data.cnt then return self.data.cnt end
    return 0
end

--是否显示在列表
function this:IsShow()
    local isShow=true;
    if  self:HasData()~=true or (self.data and self.data.shop_config and self.data.shop_config.isShow and self.data.shop_config.isShow==1) then
        isShow=false;
    end
    return isShow;
end

-- 返回当前时间段该商品是否可以购买
function this:GetNowTimeCanBuy()
    local canBuy = true
    if self:GetData()==nil then
        canBuy=false;
    end
    local currTime = TimeUtil:GetTime()
    local beginTime = self:GetBuyStartTime()
    local endTime = self:GetBuyEndTime()
    if (beginTime ~= 0 and currTime < beginTime) or
        (endTime ~= 0 and currTime >= endTime) then canBuy = false end
    return canBuy
end

-- 返回当前时间与购买结束时间的差值
function this:GetEndBuyTime()
    local currTime = TimeUtil:GetTime()
    local endTime = self:GetBuyEndTime()
    local time = endTime - currTime
    return time > 0 and time or 0
end

--返回当前时间与购买结束时间的提示
function this:GetEndBuyTips()
    local time=self:GetBuyEnd();   
	if time~=nil then
        local buyEndTime = self:GetBuyEndTime();
      
		local count=TimeUtil:GetDiffHMS(buyEndTime,TimeUtil.GetTime());

        if self:GetType()==CommodityItemType.Regression then      
            if count.day>0 then
                return LanguageMgr:GetByID(60005,count.day)
            elseif count.hour>0 then
                return LanguageMgr:GetByID(60009,count.hour)
            else
                if count.minute>=1 then
                    return LanguageMgr:GetByID(60010,count.minute)
                else
                    return LanguageMgr:GetByID(60010,"0")
                end
            end   
            return
        end
--        if self:GetType()==CommodityItemType.Skin then            
            -- if self:GetID()==50007 then
            --    LogError("Before:"..tostring(self:GetBuyEndTime())) 
            --    local time = self:GetBuyEnd()
            --    LogError("End:"..tostring(TimeUtil:GetTime()).."\t"..tostring(TimeUtil:GetTimeStampBySplit(time)));
            -- end
            if count.day>0 then
                return LanguageMgr:GetByID(18035,count.day)
            elseif count.hour>0 then
                return LanguageMgr:GetByID(18087,count.hour)
            else
                if count.minute>=1 then
                    return LanguageMgr:GetByID(18088,count.minute)
                else
                    return LanguageMgr:GetByID(18097)
                end
            end
--        else
--            LogError(count);
--            return count.day>0 and LanguageMgr:GetByID(18035,count.day) or LanguageMgr:GetByID(18035,1);
        --end
	end
	return nil;
end

-- 返回是否是礼包
function this:IsPackage()
    local isPackage = false
    if self:GetType() == CommodityItemType.Package or self:GetType() ==
        CommodityItemType.MonthCard then -- 月卡也当做礼包处理
        isPackage = true
    end
    return isPackage
end

function this:HasDiscountTag()
    local has=false
    if self.cfg and self.cfg.hasDiscountTag then
        has=self.cfg.hasDiscountTag==1;
    end
    return has
end

--返回后台商店ID
function this:GetChargeID()
    -- return self:GetType()==CommodityItemType.MonthCard and "PayMonthly_30001" or "PayRecharge_40001"
    local chargeCfg=Cfgs.CfgRecharge:GetByID(self:GetID());
    if chargeCfg then
        return chargeCfg.iosID;
    end
    return nil;
end

--是否使用商店特殊插图
function this:IsShowImg()
    if self.cfg and self.cfg.isShowImg then
        return self.cfg.isShowImg==1;
    end
    return false;
end

--是否可以使用的折扣券类型
function this:CanUseVoucher(type)
    if self.cfg and self.cfg.canUseVoucher and type then
        for k,v in ipairs(self.cfg.canUseVoucher) do
            if v==type then
                return true;
            end
        end
    end    
    return false;
end

function this:GetUseVoucherTypes()
    return self.cfg and self.cfg.canUseVoucher or nil;
end

return this
