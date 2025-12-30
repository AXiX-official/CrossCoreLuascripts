--充值支付窗口
local commodity=nil;
local commodityType=nil;
local channelType=nil;
local eventMgr=nil;
function Awake()
	InitListener();
end

function InitListener()
	eventMgr = ViewEvent.New();
	eventMgr:AddListener(EventType.SDK_Pay_Result,OnSDKResult);
	eventMgr:AddListener(EventType.SDK_QRPay_Over,OnQROver)
end

function OnOpen()
	channelType=CSAPI.GetChannelType();
     commodity=data.commodity;
     commodityType=data.commodityType;
    CSAPI.SetText(txt_name,data.commodity:GetName());
	CSAPI.SetText(txt_desc,data.commodity:GetDesc());
    local normalPrice=commodity:GetPrice();
	local discount=commodity:GetNowDiscount();
		--其余价格显示
	if discount~=1 then
		local realPrice=commodity:GetRealPrice();
		SetPrice(normalPrice[1].id,normalPrice[1].num,txt_hPrice,txt_hRmb);
		SetPrice(realPrice[1].id,realPrice[1].num,txt_nPrice,txt_rmb);
		CSAPI.SetGOActive(hPrice,true)
		CSAPI.SetGOActive(discountObj,true);
		local dis=math.floor((1-discount)*100);
		CSAPI.SetText(txt_discount,"-"..dis.."%");
	else
		SetPrice(normalPrice[1].id,normalPrice[1].num,txt_nPrice,txt_rmb);
		CSAPI.SetGOActive(hPrice,false)
		CSAPI.SetGOActive(discountObj,false);
	end
	--当前剩余数量
	local num=commodity:GetNum();
	CSAPI.SetGOActive(txt_limit,num~=-1)
	if num~=-1 then
		CSAPI.SetText(txt_limit,LanguageMgr:GetByID(38005,num))
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
        local bagNum=BagMgr:GetCount(item.cid);
        SetHasNum(bagNum)
    elseif (commodityType==2 and commodity:GetType()==RandRewardType.ITEM) then --随机配置
        local bagNum=BagMgr:GetCount(commodity:GetID());
        SetHasNum(bagNum)
    else
        SetHasNum(0)
    end
    SetBuyContent();
    ShopCommFunc.SetIconBorder(commodity,commodityType,border,icon,nil,nil,2);
end

function SetHasNum(num)
	if(num >= 100000) then
		CSAPI.SetText(txt_hasNum, math.floor(num / 10000) .. "W")
	else
		CSAPI.SetText(txt_hasNum, num .. "")
	end
	CSAPI.SetGOActive(hasNumObj,num>0);
end

function SetBuyContent()
	local getInfo=commodity:GetCommodityList();
	CSAPI.SetText(txt_contentName,getInfo[1].data:GetName());
	CSAPI.SetText(txt_contentNum,"X"..tostring(getInfo[1].num));
end

function SetPrice(id, num,pIcon,pText,pRmbIcon)
	if id==-1 then --SDK支付
		CSAPI.SetText(pRmbIcon, rmbIcon..tostring(num));
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

--点击充值
function OnClickPay()
	local normalPrice=commodity:GetPrice();
	if normalPrice[1].id==-1 then
		UseSDK();
	else
		--发送充值协议
		ShopProto:Buy(data.commodity:GetCfgID(),TimeUtil:GetTime(),1,nil,nil,nil,OnSuccess);
	end
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
			end
		else
			Close();
		end
	end
end

function OnQROver()
	if commodityType==1 then
		commodity=ShopMgr:GetFixedCommodity(commodity:GetID());
		local num=commodity:GetNum();
		if num<=0 and num~=-1 then
			Close();
		end
	else
		Close();
	end
end

function OnSuccess()
    Close();
	if data.callBack then
        data.callBack(proto);
    end
end

--使用SDK调用支付 ,该UI暂时弃置
function UseSDK()
	-- SDKPayMgr:GenOrderID(commodity:GetID(),function(result)
	-- 	if result==nil then
	-- 		LogError("获取订单ID返回为nil！")
	-- 		return;
	-- 	end
	-- 	local orderID=GCardCalculator:GetPayOrderStrId(result.id, payType, channelType);
	-- 	local data=ShopCommFunc.GetChannelData(commodity,result.id);
	-- 	-- LogError(data);
	-- 	EventMgr.Dispatch(EventType.SDK_Pay,data,true);
	-- end);
end

function OnClickAnyWay()
	Close();
end

function Close()
	UIUtil:HideAction(childNode, function()
		view:Close();
	end, UIUtil.active4);
end

function OnDestroy()    
	eventMgr:ClearListener();
    ReleaseCSComRefs();
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
txt_desc=nil;
line=nil;
btn_pay=nil;
txt_price=nil;
view=nil;
end
----#End#----