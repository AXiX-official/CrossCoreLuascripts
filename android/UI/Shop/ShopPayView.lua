--商城购买界面
--328/420  -9.81 -79.7 / -161.18
local currNum=1; --当前选择数量
local currPrice=0;--当前总价格
local currPriceType=nil;--消耗道具类型
local currentMaxCount=1; --当前最多购买次数

local okBtn = nil;
local addBtn = nil;
local removeBtn = nil;
local minBtn=nil;
local maxBtn=nil;

local enableColor = {255, 193, 70, 255};
local disableColor = {77, 77, 77, 255};

local isShowCard=false;
local addBuffs=nil;
local voucherList=nil;
local realPrice=nil;
local eventMgr=nil;
local voucherItem=nil
local onceMax=0;
local rmbIcon=nil;

-- local slider=nil;
function Awake()
	okBtn = ComUtil.GetCom(btn_pay, "Button");
	addBtn = ComUtil.GetCom(btn_add, "Button");
	removeBtn = ComUtil.GetCom(btn_remove, "Button");
	-- slider=ComUtil.GetCom(numSlider,"Slider");
	-- CSAPI.AddSliderCallBack(numSlider, OnSliderChange)
	maxBtn = ComUtil.GetCom(btn_max, "Button");
	minBtn = ComUtil.GetCom(btn_min, "Button");
	local go= ResUtil:CreateUIGO("Shop/VoucherDropItem",vObj.transform);
    voucherItem=ComUtil.GetLuaTable(go);
	-- SetText();
	InitListener();
end


function InitListener()
    eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.RewardPanel_Close,ShowBuffTips);
	eventMgr:AddListener(EventType.SDK_Pay_Result,OnSDKResult);
	eventMgr:AddListener(EventType.SDK_QRPay_Over,OnQROver)
	eventMgr:AddListener(EventType.Shop_OpenTime_Ret,OnShopRefresh)
	eventMgr:AddListener(EventType.Shop_PayVoucher_Change, OnVoucherChange);
end

function OnDestroy()
	-- CSAPI.RemoveSliderCallBack(numSlider, OnSliderChange);
    eventMgr:ClearListener();
	ReleaseCSComRefs();
end

function OnShopRefresh()
	Close()
end

function OnOpen()
	UIUtil:ShowAction(childNode,nil,UIUtil.active2);
	commodity=data.commodity;
	pageData=data.pageData;
	commodityType=data.pageData:GetCommodityType();
	payCallBack=data.callBack;
	Refresh();
end

function Refresh()
	local isPackage=false;
	-- 根据当前物品数量进行初始化
	if commodity then
		rmbIcon=commodity:GetCurrencySymbols();
		onceMax=commodity:GetOnecBuyLimit() == - 1 and 99 or commodity:GetOnecBuyLimit(); --单次购买上限
		if commodity:GetType()==CommodityItemType.ChoiceCard then  --自选，特殊处理
			local getInfo=commodity:GetCommodityList();
			if getInfo then
				CSAPI.SetText(txt_name,getInfo[1].data:GetName());
				CSAPI.SetText(txt_desc,getInfo[1].data:GetDesc());
			else
				CSAPI.SetText(txt_name,commodity:GetName());
				LogError("未得到对应兑换信息！"..table.tostring(commodity));
			end
		else
			CSAPI.SetText(txt_name,commodity:GetName());
			CSAPI.SetText(txt_desc,commodity:GetDesc());
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
		if (commodityType==1 and commodity:GetType()==CommodityItemType.Item) then --固定配置
			local item=commodity:GetCommodityList()[1];
			local bagNum=0;
			if item and item.data and item.data:GetCfg().type==ITEM_TYPE.EQUIP_MATERIAL and item.data:GetCfg().dy_value1~=nil then
				local equip=EquipMgr:GetEquipByCfgID(item.data:GetCfg().dy_value1)
				if equip~=nil then
					bagNum=equip:GetCount();
				end
			else
				bagNum=BagMgr:GetCount(item.cid)
			end
			SetHasNum(bagNum)
		elseif (commodityType==2 and commodity:GetType()==RandRewardType.ITEM) then --随机配置
			local bagNum=BagMgr:GetCount(commodity:GetID());
			SetHasNum(bagNum)
		else
			SetHasNum(0)
		end
		if onceMax>1 then
			InitType1();
		else
			InitType2();
		end
		-- RefreshPrice();
		RefreshVoucherItem();
	end
end

function RefreshVoucherItem()
	local isShow=false;
    if voucherItem~=nil and commodity and commodity:GetUseVoucherTypes()~=nil then
        voucherItem.Init(commodity,currNum,true);
        if voucherItem.GetOptionsLength()>0 then
            isShow=true;
        end
    end
	SetVoucherItem(isShow)
end

function SetVoucherItem(isShow)
    if isShow then
        CSAPI.SetAnchor(content,311,122);
        CSAPI.SetGOActive(vObj,isShow);
    else
		CSAPI.SetAnchor(content,311,202);
        CSAPI.SetGOActive(vObj,isShow);
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

function SetBuyContent()
	local getInfo=commodity:GetCommodityList();
	CSAPI.SetText(txt_contentName,getInfo[1].data:GetName());
	CSAPI.SetText(txt_contentNum,"X"..tostring(getInfo[1].num*currNum));
end

--多选
function InitType1()
	InitCommodityInfo();
	CSAPI.SetText(txt_num, tostring(currNum));
	SetMaxNum();
	RefreshPrice();
	SetBuyContent();
	-- SetBtnState(removeBtn,removeImg, false);
	-- SetBtnState(addBtn,addImg, currNum < currentMaxCount);
	SetLayout(1);
	-- SetBtnState(maxBtn,maxImg, currNum < currentMaxCount);
end

--单选
function InitType2()
	InitCommodityInfo();
	CSAPI.SetText(txt_num, tostring(currNum));
	SetMaxNum();
	RefreshPrice();
	SetLayout(2);
	SetBuyContent();
end

function SetLayout(type)
	CSAPI.SetGOActive(numObj,type==1);
	CSAPI.SetGOActive(priceObj,type==1);
	CSAPI.SetRectSize(black,777.8,type==1 and 569 or 634);
end

function InitCommodityInfo()
	CSAPI.SetGOActive(tIcon,false);
	CSAPI.SetGOActive(btnDetails,false);
	local isSmall=false;
	local getList=commodity:GetCommodityList();
	if getList then
		local good=getList[1];
		if good.data:GetType()==ITEM_TYPE.CARD_CORE_ELEM or good.data:GetType()==ITEM_TYPE.CARD then
			CSAPI.SetGOActive(tIcon,true);
		elseif good.data:GetType()==ITEM_TYPE.EQUIP or good.data:GetType()==ITEM_TYPE.EQUIP_MATERIAL then
			CSAPI.SetGOActive(tIcon,true);
			isSmall=true;
		elseif good.data:GetType()==ITEM_TYPE.PANEL_IMG then--多人插图
			CSAPI.SetGOActive(btnDetails,true);
		elseif good.data:GetType()==ITEM_TYPE.BG_ITEM then--背景道具
			CSAPI.SetGOActive(btnDetails,true);
		elseif good.data:GetType()==ITEM_TYPE.LIMITED_TIME_SKIN or good.data:GetType()==ITEM_TYPE.SKIN then --皮肤
			CSAPI.SetGOActive(btnDetails,true);
		end
		SetDayObj(good.data:GetIconDayTips());
		if isSmall~=true then
			CSAPI.SetScale(dayObj,1.3,1.3,1.3);
		else
			CSAPI.SetScale(dayObj,1,1,1);
		end
	end
	ShopCommFunc.SetIconBorder(commodity,commodityType,border,icon,tIcon,tBorder,2,isSmall);
end

--设置有效天数
function SetDayObj(txt)
	CSAPI.SetGOActive(dayObj,txt~=nil)
	CSAPI.SetText(txt_day,txt);
end

--刷新价格
function RefreshPrice()
	if commodity==nil then
		do return end;
	end
	local normalPrice=commodity:GetPrice();
	if normalPrice==nil or (normalPrice and normalPrice[1].num==0) then --免费
		CSAPI.SetGOActive(txt_free,true);
		CSAPI.SetGOActive(nPriceObj,false);
		CSAPI.SetGOActive(hPrice,false);
	else
		CSAPI.SetGOActive(txt_free,false);
		CSAPI.SetGOActive(nPriceObj,true);
		local priceInfo=commodity:GetRealPrice();
		local orgInfo=commodity:GetOrgCostsByCostKey();
		local disPrice=normalPrice[1].num*currNum;--折扣前价格
		local curPrice=priceInfo[1].num*currNum;--当前价格
		local curPID=priceInfo[1].id;
		if voucherList then
			if orgInfo then
				disPrice=orgInfo[2]*currNum;
			else
				disPrice=priceInfo[1].num*currNum;
			end
			curPrice=realPrice;
		elseif orgInfo~=nil then
			disPrice=orgInfo[2]*currNum
		end
		local discount=commodity:GetNowDiscount();
		CSAPI.SetGOActive(discountObj,discount~=1);
		local isShowHPrice=false;
		if discount~=1 then
			local dis=math.floor((1-discount)*100);
			CSAPI.SetText(txt_discount,"-"..dis.."%");
		end
		if discount~=1 or voucherList~=nil or (commodity:GetOrgCosts()) then
			isShowHPrice=true;
		end
		if isShowHPrice then
			if onceMax>1 then
				if normalPrice[1].num==priceInfo[1].num then
					SetPrice(curPID,priceInfo[1].num,nPriceIcon,txt_nPrice,txt_rmb);
				else
					SetPrice(curPID,normalPrice[1].num,hPriceIcon,txt_hPrice,txt_hRmb);
					SetPrice(curPID,priceInfo[1].num,nPriceIcon,txt_nPrice,txt_rmb);
				end
				SetPrice(curPID,disPrice,hPriceIcon2,txt_hPrice2,txt_hRmb2);
				SetPrice(curPID,curPrice,priceIcon,txt_price,txt_rmb2);
			else
				SetPrice(curPID,disPrice,hPriceIcon,txt_hPrice,txt_hRmb);
				SetPrice(curPID,curPrice,nPriceIcon,txt_nPrice,txt_rmb);
			end
			CSAPI.SetGOActive(hLayout2,onceMax>1);
			CSAPI.SetGOActive(hPrice,isShowHPrice)
		else
			SetPrice(curPID,curPrice,nPriceIcon,txt_nPrice,txt_rmb);
			if  onceMax>1 then
				SetPrice(curPID,curPrice,priceIcon,txt_price,txt_rmb2);
			end
			CSAPI.SetGOActive(hLayout2,false);
			CSAPI.SetGOActive(hPrice,false)
		end
	end
end

function SetPrice(id, num,pIcon,pText,pRmbIcon)
	if id==-1 then --SDK支付
		CSAPI.SetText(pRmbIcon, rmbIcon);
		CSAPI.SetText(pText, tostring(num));
		CSAPI.SetGOActive(pIcon,false);
		CSAPI.SetGOActive(pRmbIcon,true);
		return;
	else
		CSAPI.SetGOActive(pIcon,true);
		CSAPI.SetGOActive(pRmbIcon,false);
	end
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

function SetBtnState(btn,img, enable)
	if btn then
		-- local color = enableColor;
		if enable then
			btn.enabled = enable;
		else
			btn.enabled = false;
			-- color = disableColor;
		end
		-- if img then
		-- 	CSAPI.SetImgColor(img.gameObject, color[1], color[2], color[3], color[4]);
		-- end
	end
end 

function OnClickDetails()
	local getList=commodity:GetCommodityList();
	if getList then
		local good=getList[1];
		local type = good.data:GetType();
		if type==ITEM_TYPE.PANEL_IMG then--多人插图,特殊处理
			CSAPI.OpenView("MulPictureView",{id=good.data:GetDyVal1(),showMask=true},commodity:IsShowImg() and 1 or 0);
		elseif good.data:GetType()==ITEM_TYPE.BG_ITEM then--背景道具
			CSAPI.OpenView("BGPictureView",{id=good.data:GetDyVal1(),showMask=true});
		elseif good.data:GetType()==ITEM_TYPE.LIMITED_TIME_SKIN or good.data:GetType()==ITEM_TYPE.SKIN then --皮肤
			local d={good.data:GetDyVal2(), false};
			CSAPI.OpenView("RoleInfoAmplification", d,LoadImgType.Main);
		end
	end
end


function OnClickAdd()
	if currNum < currentMaxCount then
		currNum = currNum + 1;
		CSAPI.SetText(txt_num, tostring(currNum));		
		RefreshVoucherItem();
		-- SetSliderValue();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24025));	
		do return end	
	end
	-- SetBtnState(removeBtn,removeImg, currNum > 1);
	-- SetBtnState(addBtn,addImg, currNum < currentMaxCount);
	-- SetBtnState(maxBtn,maxImg, currNum < currentMaxCount);
	SetBuyContent();
	RefreshPrice();
end

function OnClickRemove()
	if currNum > 1 then
		currNum = currNum - 1;
		CSAPI.SetText(txt_num, tostring(currNum));	
		RefreshVoucherItem();
		-- SetSliderValue();
	else
		Tips.ShowTips(LanguageMgr:GetByID(24026));	
		do return end	
	end
	-- SetBtnState(removeBtn,removeImg, currNum > 1);
	-- SetBtnState(addBtn,addImg, currNum<currentMaxCount);
	-- SetBtnState(maxBtn,maxImg, currNum<currentMaxCount);
	SetBuyContent();
	RefreshPrice();
end

-- function SetSliderValue()
-- 	-- slider.value=currNum/currentMaxCount;
-- 	slider.value=currNum;
-- end

--变更滑动杠的值
-- function OnSliderChange(value)
-- 	-- currNum=math.floor(value*currentMaxCount+0.5)<=0 and 1 or math.floor(value*currentMaxCount+0.5);
-- 	currNum=value;
-- 	CSAPI.SetText(txt_num, tostring(math.floor(currNum+0.5)));
-- 	-- SetBtnState(removeBtn,removeImg, currNum > 1);
-- 	-- SetBtnState(addBtn,addImg, currNum<currentMaxCount);
-- 	-- SetBtnState(maxBtn,maxImg, currNum<currentMaxCount);
-- 	RefreshPrice();
-- end

function OnClickMax()
	if currNum==currentMaxCount then
		Tips.ShowTips(LanguageMgr:GetByID(24025));
		do return end	
	end
	currNum=currentMaxCount;
	-- SetBtnState(removeBtn,removeImg, currNum > 1);
	-- SetBtnState(addBtn,addImg, false);
	-- SetBtnState(maxBtn,maxImg, false);
	CSAPI.SetText(txt_num, tostring(currNum));	
	SetBuyContent();
	RefreshPrice();
	RefreshVoucherItem();
end

function OnClickMin()
	if currNum==1 then
		Tips.ShowTips(LanguageMgr:GetByID(24026));	
		do return end	
	end
	currNum=1;
	CSAPI.SetText(txt_num, tostring(currNum));	
	SetBuyContent();
	RefreshPrice();
	RefreshVoucherItem();
end

function SetMaxNum()
	local priceInfo = commodity:GetRealPrice();
	if priceInfo and priceInfo[1].id~=-1 then --非SDK支付
		local count=BagMgr:GetCount(priceInfo[1].id);
		local canBuyNum=math.floor(count/priceInfo[1].num); --实际可以购买的数量
		local onceMax=commodity:GetOnecBuyLimit() == - 1 and 99 or commodity:GetOnecBuyLimit(); --单次购买上限
		local itemMax =commodity:GetNum() == - 1 and 99 or commodity:GetNum(); --当前剩余数量
		if itemMax>=onceMax then
			currentMaxCount=onceMax>canBuyNum and canBuyNum or onceMax;
		else
			currentMaxCount=itemMax>canBuyNum and canBuyNum or itemMax;
		end
		currentMaxCount=currentMaxCount==0 and 1 or currentMaxCount;
		-- slider.maxValue=currentMaxCount;
	end
end


function Close()
	UIUtil:HideAction(childNode, function()
		if view and view.Close then
			view:Close();
		end
	end, UIUtil.active4);
end

function OnClickAnyWay()
	Close();
end

--点击购买
function OnClickPay()
	ShopCommFunc.HandlePayLogic(commodity,currNum,commodityType,voucherList,OnSuccess);
	-- local priceInfo=commodity:GetRealPrice();
	-- local channelType=CSAPI.GetChannelType();
	-- if priceInfo and priceInfo[1].id==-1 and (channelType==ChannelType.Normal or channelType==ChannelType.TapTap) then
	-- 	CSAPI.OpenView("SDKPaySelect",commodity);
	-- else
	-- 	if commodityType==1 then --购买道具
	-- 		ShopCommFunc.BuyCommodity(commodity,currNum,OnSuccess);
	-- 	elseif commodityType==2 then  --兑换随机物品
	-- 		ShopCommFunc.ExchangeCommodity(commodity,currNum,OnSuccess);
	-- 	end
	-- end
end

--SDK支付结果
function OnSDKResult(_d)
	if _d~=nil and _d.Code==200 then
		--判定是否能再次购买
		if commodityType==1 then
			commodity=ShopMgr:GetFixedCommodity(commodity:GetID());
			local num=commodity:GetNum();
			if num<=0 and num~=-1 then
				Close();
			else
				Refresh();
			end
		else
			Close();
		end
	end
end

function OnQROver()
	--判定是否能再次购买
	if commodityType==1 then
		commodity=ShopMgr:GetFixedCommodity(commodity:GetID());
		local num=commodity:GetNum();
		if num<=0 and num~=-1 then
			Close();
		else
			Refresh();
		end
	else
		Close();
	end
end

--购买成功
function OnSuccess(proto)
	Close();
	if proto then
		if payCallBack then
			payCallBack(proto);
		end
		if isShowCard==false and openSetting~=2 then --openSetting为2的时候，需要自己调用奖励面板	
			addBuffs=proto.add_bufs;
			if next(proto.gets) then
				UIUtil:OpenReward( {proto.gets})
			else
				ShowBuffTips();
			end
		end
	end
end

function OnVoucherChange(ls)
    voucherList=ls;
    if voucherList~=nil then
        realPrice=0;
        local isOk,tips,res=GLogicCheck:IsCanUseVoucher(commodity:GetCfg(),voucherList,TimeUtil:GetTime(),currNum,PlayerClient:GetLv());
        if isOk and res then
            realPrice=res[1][2];
        end
    else
        realPrice=nil;
    end
    RefreshPrice();
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

function OnClickAnyWay()
	Close();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
childNode=nil;
bg=nil;
gridNode=nil;
border=nil;
icon=nil;
txt_name=nil;
normalLayout=nil;
txt_desc=nil;
hasNumObj=nil;
txt_hasNumTips=nil;
txt_hasNum=nil;
numObj=nil;
txt_numTips=nil;
-- numSlider=nil;
-- sliderHandle=nil;
numTips=nil;
txt_num=nil;
btn_remove=nil;
removeImg=nil;
btn_add=nil;
addImg=nil;
line=nil;
btn_pay=nil;
priceObj=nil;
priceIcon=nil;
txt_price=nil;
btn_min=nil;
btn_max=nil;
nPrice=nil;
nPriceIcon=nil;
txt_nPrice=nil;
hPrice=nil;
txt_hPrice=nil;
hPriceIcon=nil;
view=nil;
voucherItem=nil;
end
----#End#----