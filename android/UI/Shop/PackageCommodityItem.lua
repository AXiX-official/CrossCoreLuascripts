--礼包的商品展示
local descPos={{-94.63,-99},{-94.63,-145.5}}
local eventMgr=nil;
local rmbIcon=nil;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_MonthCard_DaysChange,OnMonthCardDaysChange)
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnMonthCardDaysChange(days)
    if  this.data and this.data:GetType()==CommodityItemType.MonthCard then--月卡，显示剩余天数
		local info=this.data:GetMonthCardInfo();
		if info and info.id==ITEM_ID.MonthCard then
			SetDays(days);--刷新剩余时间
		end
    end
end

function Refresh(_data,_elseData)
    this.data=_data;
    this.elseData=_elseData;
    local num=this.data:GetNum()
    if this.elseData.showType==ShopShowType.Package then
        ResUtil.Commodity:Load(bg,this.data:GetPackageIcon(),true);
    else
        CSAPI.LoadImg(bg,"UIs/Shop/btn_2_01.png",false,nil,true);
    end
    SetName(this.data:GetName());
    SetCount(this.data:GetLimitDesc(num >0 and "ffc146" or "ffffff"));
    -- ShopCommFunc.SetIconBorder(_data,_elseData.commodityType,border,icon)
    SetLimitTag(this.data:IsLimitTime(),this.data:GetEndBuyTips());
    rmbIcon=this.data:GetCurrencySymbols();
    SetDiscount(this.data:GetNowDiscountTips())
    local exStr=""
    local buyNum=-1;
    if this.data:GetType()==CommodityItemType.Deposit then--充值类型,首充双倍逻辑
        local exList=this.data:GetExCommodityList();
        buyNum=this.data:GetBuyCount();
        -- local langID=buyNum>0 and 18031 or 18030
        -- if exList then
        --     exStr=LanguageMgr:GetByID(langID,exList[1].num,exList[1].data:GetName());
        -- end
    elseif this.data:GetType()==CommodityItemType.MonthCard then--月卡，显示剩余天数
        SetDays(ShopMgr:GetMonthCardDays());
    else
        SetDays(0);
    end
    SetDoubleTag(buyNum==0);
    local isOver=this.data:IsOver();
    local cost=this.data:GetRealPrice();
    SetCost(cost,isOver);
    SetAlpha(isOver and 0.4 or 1);
    SetOver(isOver);
    local isLock=not this.data:GetBuyLimit();
    SetLockObj(isLock,this.data:GetBuyLimitDesc());
    SetRedInfo();
end

--检测红点数据
function SetRedInfo()
    local rd=RedPointMgr:GetData(RedPointType.Shop);
    local isShowRed=false;
    if rd and this.data then
        local list=rd[this.data:GetShopID()];
        if list~=nil then
            isShowRed=list[this.data:GetID()]~=nil;
        end
    end
    UIUtil:SetRedPoint(alphaNode,isShowRed,100,-280);
 end

 function SetNewInfo(infos)
    local hasThis=false;
    if this.data then
        local pageID=this.data:GetShopID();
        local tabID=this.data:GetTabID();
        -- Log(tostring(pageID).."\t"..tostring(tabID).."\t"..tostring(this.data:GetID()))
        if infos and pageID and pageID and infos[pageID] and infos[pageID][tabID] then
            for k,v in ipairs(infos[pageID][tabID]) do
                if v==this.data:GetID() then
                    hasThis=true;
                    break;
                end
            end
        end 
    end
    CSAPI.SetGOActive(newObj,hasThis);
end

function SetDays(days)
    days =days or 0;
    CSAPI.SetGOActive(dayObj,days>0);
    if days>0 then
        CSAPI.SetText(text_day,LanguageMgr:GetByID(18083,days));
    end
end

function SetName(str)
    CSAPI.SetText(text_name,str);
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode,val);
end

function SetDiscount(discount)
    CSAPI.SetGOActive(discountObj,discount~=nil);
    if discount then
        CSAPI.SetText(txt_discount,discount);
    end
    -- local dis=math.floor(discount*10+0.5);
    -- CSAPI.SetGOActive(discountObj,discount~=1);
    -- CSAPI.SetText(txt_discount,string.format(LanguageMgr:GetByID(18074),dis));
end

function SetCount(str)
    CSAPI.SetGOActive(text_limit,str~=nil);
    CSAPI.SetText(text_limit,str);
end

--限时标签
function SetLimitTag(isShow,tips)
    CSAPI.SetGOActive(limitTag,isShow==true);
    CSAPI.SetText(txt_limitTag,tips);
end

function SetOver(isOver)
    CSAPI.SetGOActive(overObj,isOver);
end

function SetLockObj(isLock,lockDesc)
    CSAPI.SetGOActive(lockObj,isLock);
    if isLock then
        CSAPI.SetText(txt_lockDesc,lockDesc);
    end
end

--设置价格
function SetCost(cost,isOver)
    if isOver then
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(freeObj,true);
        CSAPI.SetText(txt_free,LanguageMgr:GetByID(18012));
        do return end
    end
    if cost then
        local cfg = Cfgs.ItemInfo:GetByID(cost[1].id,true);
        if cfg and cfg.icon then
            ResUtil.IconGoods:Load(moneyIcon, cfg.icon.."_1");
        else
            LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
        end
        if cost[1].num>0 then
            CSAPI.SetText(txt_price,tostring(cost[1].num));
            CSAPI.SetGOActive(priceObj,true)
            CSAPI.SetGOActive(freeObj,false);
        else
            CSAPI.SetGOActive(priceObj,false);
            CSAPI.SetGOActive(freeObj,true);
            CSAPI.SetText(txt_free,LanguageMgr:GetByID(18032));
        end
    else
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(freeObj,true);
        CSAPI.SetText(txt_free,LanguageMgr:GetByID(18032));
    end
end

function SetDoubleTag(isShow)
    CSAPI.SetGOActive(doubleTag,isShow==true);
end

function SetClickCB(cb)
    this.cb=cb;
end

function OnClickSelf()
    if this.cb then
        this.cb(this);
    end
end

--检查固定商品类型的道具折扣信息是否需要刷新
function CheckDiscountRefresh(nowTime)
    if this.elseData.commodityType==1 then
        local endTime = this.data:GetDiscountEndTime()
        local startTime = this.data:GetDiscountStartTime()
        if startTime~=0 and nowTime>=startTime and nowTime<=endTime then
            RefreshByFixed();
        elseif endTime~=0 and nowTime>=endTime then
            RefreshByFixed(); 
        end
    end
end

function RefreshByFixed()
    local records=ShopMgr:GetRecordInfos(this.data:GetCfgID());
	data:SetData(records);
    -- Refresh(data,commodityType);
end
