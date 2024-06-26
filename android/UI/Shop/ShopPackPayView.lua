--商店礼包购买窗口
local currNum=1; --当前选择数量
local currPrice=0;--当前总价格
local currPriceType=nil;
local currMoneyName="";

local layout=nil;

local isShowCard=false;
local addBuffs=nil;
local commodity=nil;
local commodityType=nil;
function Awake()
	layout = ComUtil.GetCom(vsv, "UISV")
	layout:Init("UIs/Shop/ShopPackItem",LayoutCallBack,true)
	InitListener();
end

function InitListener()
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.RewardPanel_Close,ShowBuffTips);
	eventMgr:AddListener(EventType.SDK_Pay_Result,OnSDKResult);
	eventMgr:AddListener(EventType.Shop_MonthCard_DaysChange,OnMonthCardDaysChange)
	eventMgr:AddListener(EventType.SDK_QRPay_Over,OnQROver)
	eventMgr:AddListener(EventType.Shop_OpenTime_Ret,OnShopRefresh)
end

function OnDestroy()
    eventMgr:ClearListener();
	ReleaseCSComRefs();
end

function OnShopRefresh()
	Close()
end

function OnMonthCardDaysChange(days)
    if commodity and commodity:GetType()==CommodityItemType.MonthCard then--月卡，显示剩余天数
        SetDays(days);--刷新剩余时间
    end
end

function OnOpen()
	commodity=data.commodity;
	pageData=data.pageData;
	commodityType=data.pageData:GetCommodityType();
	payCallBack=data.callBack;
	-- 根据当前物品数量进行初始化
	if commodity then
		local onceMax=commodity:GetOnecBuyLimit() == - 1 and 99 or commodity:GetOnecBuyLimit(); --单次购买上限
		local normalPrice=commodity:GetPrice();
		--其余价格显示
		if normalPrice==nil then --免费
			CSAPI.SetGOActive(txt_free,true);
			CSAPI.SetGOActive(txt_nPrice,false);
			CSAPI.SetGOActive(hPrice,false);
			CSAPI.SetGOActive(discountObj,false);
		else
			CSAPI.SetGOActive(txt_free,false);
			CSAPI.SetGOActive(txt_nPrice,true);
			local discount=commodity:GetNowDiscount();
			if discount~=1 then
				local realPrice=commodity:GetRealPrice();
				SetPrice(normalPrice[1].id,normalPrice[1].num,hPriceIcon,txt_hPrice);
				SetPrice(realPrice[1].id,realPrice[1].num,nPriceIcon,txt_nPrice);
				CSAPI.SetGOActive(hPrice,true)
				CSAPI.SetGOActive(discountObj,true);
				local dis=math.floor((1-discount)*100);
				CSAPI.SetText(txt_discount,"-"..dis.."%");
			else
				SetPrice(normalPrice[1].id,normalPrice[1].num,nPriceIcon,txt_nPrice);
				CSAPI.SetGOActive(hPrice,false)
				CSAPI.SetGOActive(discountObj,false);
			end
		end
		
		--当前剩余数量
		local num=commodity:GetNum();
		-- CSAPI.SetGOActive(txt_limit,num~=-1)
		if num~=-1 then
			CSAPI.SetText(txt_limit,LanguageMgr:GetByID(38005,num))
		else
			CSAPI.SetText(txt_limit,LanguageMgr:GetByID(38009))
		end
		--显示剩余天数
		local tips=commodity:GetEndBuyTips();
		if tips~=nil then
			CSAPI.SetGOActive(limitTimeObj,true);
			CSAPI.SetText(txt_limitTime,tips)
		else
			CSAPI.SetGOActive(limitTimeObj,false);
		end
		local showNum=true;
		if (commodityType==1 and commodity:GetType()==CommodityItemType.Item) then --固定配置
			local item=commodity:GetCommodityList()[1];
			local bagNum=BagMgr:GetCount(item.cid);
			SetHasNum(bagNum)
		elseif commodityType==1 and  commodity:GetType()==CommodityItemType.MonthCard then--月卡，显示剩余天数
			SetHasNum(0)
			showNum=false;
			SetDays(ShopMgr:GetMonthCardDays());
		elseif (commodityType==2 and commodity:GetType()==RandRewardType.ITEM) then --随机配置
			local bagNum=BagMgr:GetCount(commodity:GetID());
			SetHasNum(bagNum)
			SetDays(0);
		elseif commodityType==1 and  commodity:GetType()==CommodityItemType.Package then
			SetHasNum(0)
			SetDays(0);
			showNum=false;
		else
			SetHasNum(0)
			SetDays(0);
		end
		CSAPI.SetGOActive(hasNumObj,showNum);
		CSAPI.SetText(txt_name,commodity:GetName());
		CSAPI.SetText(txt_desc,commodity:GetDesc());
		ShopCommFunc.SetIconBorder(commodity,commodityType,border,icon,nil,nil,2);
		UIUtil:ShowAction(childNode,InitSV,UIUtil.active2);
        -- InitSV();
	    -- RefreshPrice();
		-- if currPrice>0 then
        -- 	CSAPI.SetText(txt_payTips,LanguageMgr:GetTips(15107,currPrice,currMoneyName,commodity:GetName()));
		-- else
		-- 	CSAPI.SetText(txt_payTips,LanguageMgr:GetTips(15106,commodity:GetName()));
		-- end
		-- Log(string.format(LanguageMgr:GetByID(18014),currPrice,currMoneyName,commodity:GetName()));
	else
		UIUtil:ShowAction(childNode,nil,UIUtil.active2);
	end
end

function SetDays(days)
    days =days or 0;
    CSAPI.SetGOActive(daysObj,days>0);
    if days>0 then
        CSAPI.SetText(txt_days,LanguageMgr:GetByID(18084,days));
    end
end

function SetHasNum(num)
	-- if(num >= 100000) then
	-- 	CSAPI.SetText(txt_hasNum, math.floor(num / 10000) .. "W")
	-- else
		CSAPI.SetText(txt_hasNum, num .. "")
	-- end
	-- CSAPI.SetGOActive(hasNumObj,num>0);
end

function SetPrice(id, num,pIcon,pText)
	if id==-1 then --SDK支付
		CSAPI.SetText(pText, LanguageMgr:GetByID(18013)..tostring(num));
		CSAPI.SetGOActive(pIcon,false);
		return;
	end
	CSAPI.SetGOActive(pIcon,true);
	if id == ITEM_ID.GOLD then --金币
		ResUtil.IconGoods:Load(pIcon, tostring(ITEM_ID.GOLD).."_1");
		CSAPI.SetImgColorByCode(pIcon,"ffffff")
	elseif id == ITEM_ID.DIAMOND then --钻石
		ResUtil.IconGoods:Load(pIcon, tostring(ITEM_ID.DIAMOND).."_1");
		CSAPI.SetImgColorByCode(pIcon,"ffc146")
	else
		local cfg = Cfgs.ItemInfo:GetByID(id);
		if cfg and cfg.icon then
			ResUtil.IconGoods:Load(pIcon, cfg.icon.."_1");
		end
		CSAPI.SetImgColorByCode(pIcon,"ffffff")
	end
	CSAPI.SetText(pText, tostring(math.floor(num+0.5)));
end

--创建物品列表
function InitSV()
    --显示礼包中的所有数据
	curDatas={};
    for k, v in ipairs(commodity:GetCommodityList()) do
        if v.data:GetType()==ITEM_TYPE.PROP and v.data:GetDyVal1()==PROP_TYPE.MemberReward then
            for key,val in ipairs(v.data:GetCfg().dy_tb) do
				local itemData=GridUtil.RandRewardConvertToGridObjectData({id=val[1],num = val[2],type=val[3]});
				table.insert(curDatas,{itemData=itemData,desc=LanguageMgr:GetByID(24021)});
            end
        else
			local itemData=GridUtil.RandRewardConvertToGridObjectData({id=v.cid,num = v.num,type=v.type});
			table.insert(curDatas,{itemData=itemData,desc=LanguageMgr:GetByID(24020)});
        end
    end
	layout:IEShowList(#curDatas);
end

-- function RefreshPrice()
	-- local priceInfo=commodity:GetRealPrice();
	-- if priceInfo then
	-- 	currPrice=priceInfo[1].num*currNum;
	-- 	currPriceType=priceInfo[1].id;
		-- local num = 0;
		-- SetPrice(priceInfo[1].id, currPrice);
		-- local cfg = Cfgs.ItemInfo:GetByID(priceInfo[1].id);
		-- if cfg then
		-- 	currMoneyName=cfg.name;
		-- end
		-- if priceInfo[1].id == ITEM_ID.GOLD then
		-- 	num = PlayerClient:GetGold();
		-- elseif priceInfo[1].id == ITEM_ID.DIAMOND then
		-- 	num = PlayerClient:GetDiamond();
		-- else
		-- 	num = BagMgr:GetCount(priceInfo[1].id);
		-- end
	-- end
-- end

function LayoutCallBack(index)
	local _data = curDatas[index]
	local item=layout:GetItemLua(index);
	item.Refresh(_data.itemData,_data.desc,true);
	-- item.SetDesc(_data.desc);
	-- item.ShowDesc(false);
end

function Close()
	UIUtil:HideAction(childNode, function()
		if not IsNil(view) and view.Close then
			view:Close();
            view = nil;
		end
	end, UIUtil.active4);
end

function OnClickAnyWay()
	Close();
end

--点击购买
function OnClickPay()
	ShopCommFunc.HandlePayLogic(commodity,currNum,commodityType,OnSuccess);
	-- Close();
	-- local priceInfo=commodity:GetRealPrice();
	-- local channelType=CSAPI.GetChannelType();
	-- if priceInfo and priceInfo[1].id==-1 and (channelType==ChannelType.Normal or channelType==ChannelType.TapTap) then
	-- 	 CSAPI.OpenView("SDKPaySelect",commodity);
	-- else
	-- 	if commodityType==1 then --购买道具
	-- 		ShopCommFunc.BuyCommodity(commodity,currNum,OnSuccess);
	-- 	elseif commodityType==2 then  --兑换随机物品
	-- 		ShopCommFunc.ExchangeCommodity(commodity,currNum,OnSuccess);
	-- 	end
	-- end
	-- if commodityType==1 then --购买道具
	-- 	ShopCommFunc.BuyCommodity(commodity,currNum,OnSuccess);
	-- elseif commodityType==2 then  --兑换随机物品
	-- 	currNum=1;
	-- 	ShopCommFunc.ExchangeCommodity(commodity,1,OnSuccess);
	-- end
end

--购买成功
function OnSuccess(proto)
	Close();
	if proto then
		if payCallBack then
			payCallBack(proto);
		end
		if isShowCard==false then	
			addBuffs=proto.add_bufs;
			if next(proto.gets) then
				UIUtil:OpenReward( {proto.gets})
			else
				ShowBuffTips();
			end
		end
	end
end

--SDK支付结果
function OnSDKResult(_d)
	if _d~=nil and _d.Code==200 then
		--判定是否能再次购买
		-- if commodityType==1 then
		-- 	commodity=ShopMgr:GetFixedCommodity(commodity:GetID());
		-- 	local num=commodity:GetNum();
		-- 	if num<=0 and num~=-1 then
		-- 		Close();
		-- 	end
		-- else
			Close();
		-- end
	end
end

function OnQROver()
	Close();
end

function ShowBuffTips()
	if addBuffs and next(addBuffs) then
		for k,v in ipairs(addBuffs) do
			local itemCfg=Cfgs.ItemInfo:GetByID(v.id);
			if itemCfg then
				Tips.ShowTips(itemCfg.describe);
			end
		end
	end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
childNode=nil;
bg=nil;
txt_title=nil;
txt_titleTips=nil;
gridNode=nil;
border=nil;
icon=nil;
txt_name=nil;
giftLayout=nil;
txt_desc=nil;
line=nil;
line=nil;
svTitle=nil;
vsv=nil;
-- txt_payTips=nil;
btn_pay=nil;
view=nil;
end
----#End#----