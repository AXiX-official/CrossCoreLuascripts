--商品预制物
-- local grid=nil;
local currPrice=nil;
function Refresh(_data,_elseData)
    this.data=_data;
    this.elseData=_elseData;
    ResUtil.VCommodity:Load(icon,this.data:GetPackageIcon());
    SetLimitTag(this.data:IsLimitTime(),this.data:GetEndBuyTips());
    local getList=this.data:GetCommodityList();
    SetDiscount(this.data:GetNowDiscount())
    local isOver=this.data:IsOver();
    local cost=this.data:GetRealPrice();
    if cost and cost[1].id==-1 then
        currPrice=priceObj2;
    end
    SetCost(cost,isOver);
    SetAlpha(isOver and 0.4 or 1);
    SetOver(isOver);
    SetName(this.data:GetName());
    SetExTips();
    local isLock=not this.data:GetBuyLimit();
    SetLockObj(isLock,this.data:GetBuyLimitDesc());

    SetcurrencySymbols();
end

function SetcurrencySymbols()
    if CSAPI.IsADV() then
        StrText=this.data["cfg"]["displayCurrency"];
        if StrText~=nil then
            CSAPI.SetText(txt_rmb,StrText);
        else
            CSAPI.SetText(txt_rmb,RegionalSet.RegionalCurrencyType());
        end
    end
end
function SetPrice(TxtUI)
    if CSAPI.IsADV() then
        displayPrice=this.data["cfg"]["displayPrice"];
        if displayPrice~=nil then
            CSAPI.SetText(TxtUI,displayPrice);
        else
            CSAPI.SetText(TxtUI,this.data:GetRealPrice()[1].num);
        end
    end
end

function SetLockObj(isLock,lockDesc)
    CSAPI.SetGOActive(lockObj,isLock);
    if isLock then
        CSAPI.SetText(txt_lockDesc,lockDesc);
    end
end

function SetName(nameStr)
    CSAPI.SetText(text_name,nameStr or "");
end

--设置价格
function SetCost(cost,isOver)
    if isOver then
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(priceObj2,false);
        CSAPI.SetGOActive(priceObj3,false);
        CSAPI.SetGOActive(freeObj,false);
        do return end
    end
    if cost then
        if currPrice==priceObj2 then
            if CSAPI.IsADV() then
                SetcurrencySymbols();
                SetPrice(txt_rmbVal);
            else
                CSAPI.SetText(txt_rmbVal,tostring(cost[1].num));
            end
        elseif currPrice==priceObj then
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id,true);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon, cfg.icon.."_1");
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            if CSAPI.IsADV() then
                SetPrice(txt_price);
            else
                CSAPI.SetText(txt_price,tostring(cost[1].num));
            end

        else
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon3, cfg.icon.."_1",true);
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            if CSAPI.IsADV() then
                SetPrice(txt_price3);
            else
                CSAPI.SetText(txt_price3,tostring(cost[1].num));
            end

        end
        if cost[1].num>0 then
            CSAPI.SetGOActive(freeObj,false);
            CSAPI.SetGOActive(priceObj,currPrice==priceObj);
            CSAPI.SetGOActive(priceObj2,currPrice==priceObj2);
            CSAPI.SetGOActive(priceObj3,currPrice==priceObj3);
        else
            CSAPI.SetGOActive(priceObj,false);
            CSAPI.SetGOActive(priceObj2,false);
            CSAPI.SetGOActive(priceObj3,false);
            CSAPI.SetGOActive(freeObj,true);
        end
    else
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(priceObj2,false);
        CSAPI.SetGOActive(priceObj3,false);
        CSAPI.SetGOActive(freeObj,true);
    end
end

function SetExTips()
    local buyNum=-1;
    local exStr=nil;
    local exNum=0;
    if this.data:GetType()==CommodityItemType.Deposit then--充值类型,首充双倍逻辑
        local exList=this.data:GetExCommodityList();
        buyNum=this.data:GetBuyCount();
        local langID=buyNum>0 and 18031 or 18030
        if exList then
            exNum=exList[1].num;
            exStr=LanguageMgr:GetByID(langID,exList[1].num,exList[1].data:GetName());
        end
    end
    CSAPI.SetGOActive(doubleTag,buyNum<=0)
    if exNum>0 and exStr~=nil then
        CSAPI.SetGOActive(altNameItem,true)
        CSAPI.SetText(text_altName,exStr);
    else
        CSAPI.SetGOActive(altNameItem,false)
    end
end

function SetDiscount(discount)
    local dis=math.floor(discount*100+0.5);
    CSAPI.SetGOActive(discountObj,discount~=1);
    CSAPI.SetText(txt_discount,dis.."%");
end

--限时标签
function SetLimitTag(isShow,tips)
    CSAPI.SetGOActive(limitTag,isShow==true);
    CSAPI.SetText(txt_limitTag,tips);
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode,val);
end

function SetOver(isOver)
    CSAPI.SetGOActive(overObj,isOver);
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
function OnDestroy()    
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
node=nil;
alphaNode=nil;
bg=nil;
limitTag=nil;
discountObj=nil;
txt_discount=nil;
txt_off=nil;
overObj=nil;
view=nil;
end
----#End#----