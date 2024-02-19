--商店分页数据
local this = {}

function this.New()
	this.__index = this.__index or this;
	local tab = {};
	setmetatable(tab, this);
	return tab
end


function this:SetCfg(cfgId)
	if(cfgId == nil) then
		LogError("初始化商店分页数据失败！无效配置id");		
	end
	if(self.cfg == nil) then		
		self.cfg = Cfgs.CfgShopPage:GetByID(cfgId);
		if(self.cfg == nil) then		
			LogError("找不到商店分页数据！id = " .. cfgId);	
		end
	end
end

--返回商店名多语言ID
function this:GetNameID()
	return self.cfg and self.cfg.nameID or nil;
end

function this:GetName()
	return self.cfg and self.cfg.sName or nil;
end

function this:GetIcon()
	return self.cfg and self.cfg.icon or nil;
end

function this:GetIsHot()
	return self.cfg and self.cfg.isHot==1 or nil;
end

--返回ID
function this:GetID()
	return self.cfg and self.cfg.id or nil;
end

--是否默认打开
function this:IsDefaultOpen()
	return self.cfg and self.cfg.nDefault == 1 or false;
end

--返回页面商品类型
function this:GetCommodityType()
	return self.cfg and self.cfg.commodityType or nil;
end

function this:GetTips()
	return self.cfg and self.cfg.tips or nil;
end

function this:GetOpenTime()
	local time = nil;
	if self.cfg and self.cfg.openTime ~= "" and self.cfg.openTime ~= nil then
		time = self.cfg.openTime;
	end
	return time;
end

function this:GetCloseTime()
	local time = nil;
	if self.cfg and self.cfg.closeTime ~= "" and self.cfg.closeTime ~= nil then
		time = self.cfg.closeTime;
	end
	return time;
end

--返回开始时间秒数
function this:GetOpenTimeData()
	local time = self:GetOpenTime();
	if time ~= nil then
		time = TimeUtil:GetTimeStampBySplit(time);
	else
		time = 0;
	end
	return time;
end

--返回关闭时间秒数
function this:GetCloseTimeData()
	local time = self:GetCloseTime();
	if time ~= nil then
		time = TimeUtil:GetTimeStampBySplit(time);
	else
		time = 0;
	end
	return time;
end


--是否在开启时间内
function this:IsOpen()
	local isOpen = false;
	local currentTime = TimeUtil:GetTime();
	local openTime = self:GetOpenTimeData();
	local closeTime = self:GetCloseTimeData()
	if openTime == 0 and closeTime == 0 then
		isOpen = true;
	elseif (openTime==0 or currentTime >= openTime) and (closeTime==0 or currentTime < closeTime) then
		isOpen = true;
	end
	return isOpen;
end

--返回商品展示的类型
function this:GetShowType()
	return self.cfg and self.cfg.showType or 1;
end

function this:GetBG()
	return self.cfg and self.cfg.bg or "bg_27";
end

--特殊货币类型
function this:GetGoldType()
	return self.cfg.goldInfo;
end

--返回固定类型中需要检测刷新的数据列表
function this:GetRefreshInfos()
	local itemDatas = {};
	if self:GetCommodityType()==CommodityType.Normal then
		--固定道具
		local cfgs=Cfgs.CfgCommodity:GetGroup(self:GetID());
		if cfgs then
			local nowTime=TimeUtil:GetTime();
			for k, v in ipairs(cfgs) do
				local itemData = CommodityData.New();
				itemData:SetCfg(v.id);
				local records=ShopMgr:GetRecordInfos(v.id);
				itemData:SetData(records);
				local beginTime=itemData:GetBuyStartTime();
				local endTime=itemData:GetBuyEndTime();
				if itemData:GetResetType()~=0 or (beginTime~=nil and nowTime<=beginTime) or (endTime~=nil and nowTime<=endTime) then 
					table.insert(itemDatas, itemData);
				end
			end
		end
	end
	return itemDatas;
end

--返回该页面中的商品信息 isLimit:是否剔除不满足显示条件的数据 topTabID:筛选出对应topTab的数据
function this:GetCommodityInfos(isLimit,topTabID)
	local itemDatas = {};
	local tabCfg=topTabID==nil and nil or Cfgs.CfgShopTab:GetByID(topTabID);
	if self:GetCommodityType()==CommodityType.Normal then
		--固定道具
		local cfgs=Cfgs.CfgCommodity:GetGroup(self:GetID());
		if cfgs then
			for k, v in ipairs(cfgs) do
				local itemData = ShopMgr:GetFixedCommodity(v.id);
				local canAdd=true;
				if (tabCfg and tabCfg.isAll~=1 and itemData:GetTabID()~=topTabID) then
					canAdd=false;
				end
				if (itemData:IsOver() and itemData:ShowOnSoldOut()~=true) or itemData:IsShow()~=true then--售罄时不显示的数据
					canAdd=false;
				end
				if isLimit then
					-- if itemData:GetType()==CommodityItemType.Skin then
					-- 	if itemData:GetID()==50003 or itemData:GetID()==50005 then
					-- 		LogError(itemData:GetName().."\t"..tostring(itemData:GetShowLimitRet()).."\t"..tostring(itemData:GetNowTimeCanBuy()).."\t"..tostring(canAdd))
					-- 	end
					-- end
					if itemData:GetShowLimitRet() and itemData:GetNowTimeCanBuy() and canAdd==true then --满足显示条件和购买开始时间则可以显示
						table.insert(itemDatas, itemData);
					end
				elseif canAdd then
					table.insert(itemDatas, itemData);
				end
			end
		end
	elseif self:GetCommodityType()==CommodityType.Rand then
		--随机道具 读取奖励表
		local cfg = Cfgs.CfgRandCommodity:GetGroup(self:GetID())[1]
		local randInfo=nil;
		if cfg then
			randInfo=ShopMgr:GetExchangeData(cfg.id);
		end
		if randInfo then
			local nRewardID=cfg.nRewardId;--商店掉落池ID
			local rewardCfg=Cfgs.RewardInfo:GetByID(nRewardID);
			for k,v in ipairs(randInfo.infos) do
				local sortIdx=v.index;
				if nRewardID~=v.reward_id then --根据当前掉落池ID获取index
					for _, c in ipairs(rewardCfg.item) do
						if c.id==v.reward_id then
							sortIdx=c.index;
						end
					end
				end
				local itemData=RandCommodityData.New();
				itemData:SetData(v,sortIdx);
				itemData:SetShopID(cfg.id);
				itemData:SetExchangeIndex(k);
				table.insert(itemDatas,itemData);
			end
		end
	end
	return itemDatas;
end

--投资方晶用
function this:GetCommodityInfos2()
	local itemDatas = {};
	local cfgs=Cfgs.CfgCommodity:GetGroup(self:GetID());
	if cfgs then
		for k, v in ipairs(cfgs) do
			local itemData = ShopMgr:GetFixedCommodity(v.id);
			local canAdd=true;
			if itemData:IsOver() and itemData:ShowOnSoldOut()~=true then--售罄时不显示的数据
				canAdd=false;
			end
			if canAdd then
				table.insert(itemDatas, itemData);
			end
		end
	end
	return itemDatas
end

function this:ShowExchange()
	if self.cfg and self.cfg.fragmentExchange==1 then
		return true;		
	end
	return false;
end

function this:GetSort()
	return self.cfg and self.cfg.sort or 10000;
end

function this:GetUpdateTime()
	return self.cfg and self.cfg.updateTime or ShopFixedUpdateType.None;
end

--返回二级菜单 isFitler:为true时去掉不在显示时间内的数据
function this:GetTopTabs(isFitler)
	local list=nil;
	if self.cfg and self.cfg.topGroup then
		local cfgs=Cfgs.CfgShopTab:GetGroup(self.cfg.topGroup);
		if isFitler then
			for k,v in ipairs(cfgs) do
				local isOpen=false;
				if v.startTime == nil and v.endTime == nil then
					isOpen = true;
				else
					isOpen = ShopCommFunc.TimeIsBetween(v.startTime,v.endTime);
				end
				if isOpen then
					list=list or {};
					table.insert(list,v)
				end
			end
		else
			list=cfgs;
		end
		if list then
			table.sort(list,function(a,b)
				return a.index<b.index;
			end);
		end
	end
	return list;
end

--返回刷新/新出现的物品ids topTabID:二级页签ID
function this:GetRefreshCommIds(topTabID)
	local ids=nil;
	local list=self:GetCommodityInfos(true,topTabID);
	if self:GetCommodityType()==CommodityType.Normal then
		--检查每个商品是否有记录，记录时间是否小于当前重置时间，小于则判定为新物品
		for k, v in ipairs(list) do
			local record=ShopMgr:GetCommResetRecord(self:GetID(),topTabID,v:GetID());
			local currResetTime=0;
			if v:GetResetTime()>0 then --下一次的重置时间大于0
				currResetTime=v:GetResetTime();
			elseif v:GetBuyStartTime()>0 and v:GetNowTimeCanBuy() then --存在能购买的时间切目前可以购买
				currResetTime=v:GetBuyStartTime();
			end
			-- Log(record)
			-- Log(tostring(record).."\t"..tostring(currResetTime))
			-- if record==nil or (record and record~=0 and currResetTime>=record) then
			if record==nil or (record and currResetTime~=record) then
				ids = ids or {};
				table.insert(ids,v:GetID());
			end
		end
	end
	return ids;
end

--返回当前的商品的刷新时间
function this:GetCommRefreshInfos(topTabID)
	--有重置则使用每次重置的事件，没有重置则使用购买开始的时间
	local infos=nil;
	local list=self:GetCommodityInfos(true,topTabID);
	if self:GetCommodityType()==CommodityType.Normal then
		for k, v in ipairs(list) do
			local currResetTime=0;
			if v:GetResetTime()>0 then --下一次的重置时间大于0
				currResetTime=v:GetResetTime();
			elseif v:GetBuyStartTime()>0 and v:GetNowTimeCanBuy() then --存在能购买的时间切目前可以购买
				currResetTime=v:GetBuyStartTime();
			end
			if currResetTime then
				infos = infos or {};
				infos[v:GetID()]=currResetTime;
			end
		end
	end
	return infos;
end

return this; 