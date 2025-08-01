--商品预制物
-- local grid=nil;
local currPrice=nil;
local rmbIcon=nil;
local SDKdisplayPrice=nil;
function Refresh(_data,_elseData)
    this.data=_data;
    this.elseData=_elseData;
    ResUtil.VCommodity:Load(icon,this.data:GetPackageIcon());
    SetLimitTag(this.data:IsLimitTime(),this.data:GetEndBuyTips());
    local getList=this.data:GetCommodityList();
    SetDiscount(this.data:GetNowDiscountTips())
    rmbIcon=this.data:GetCurrencySymbols();
    SDKdisplayPrice=this.data:GetSDKdisplayPrice();
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
    SetOrgPrice();
    SetSDKdisplayPrice();
end

function SetSDKdisplayPrice(TxtUI)
    if CSAPI.IsADV() then
        if SDKdisplayPrice~=nil then CSAPI.SetText(TxtUI,SDKdisplayPrice); end
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

function SetOrgPrice()
    if this.data~=nil then
        local orgCosts=this.data:GetOrgCosts();
        CSAPI.SetGOActive(discountInfo,orgCosts~=nil);
        if orgCosts~=nil then
            CSAPI.SetText(txt_discount2,tostring(orgCosts[2]));
            --计算倒计时
            local timeTips=this.data:GetOrgEndBuyTips()
            CSAPI.SetGOActive(dsInfo2,timeTips~=nil)
            if timeTips then
                CSAPI.SetText(txtDSTime,timeTips);
            end
            if orgCosts[1]~=-1 then
                CSAPI.SetGOActive(dsMoneyIcon,true);
                CSAPI.SetGOActive(txt_dsRmb,false);
                local cfg = Cfgs.ItemInfo:GetByID(orgCosts[1],true);
                if cfg and cfg.icon then
                    ResUtil.IconGoods:Load(dsMoneyIcon, cfg.icon.."_1");
                else
                    LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
                end
            else
                CSAPI.SetGOActive(dsMoneyIcon,false);
                CSAPI.SetText(txt_dsRmb,rmbIcon);
                CSAPI.SetGOActive(txt_dsRmb,true);
            end
        --     CSAPI.SetTextColorByCode(txt_price,"FFC146");
        --     CSAPI.SetTextColorByCode(txt_rmb,"FFC146");
        --     CSAPI.SetTextColorByCode(txt_rmbVal,"FFC146");
        --     CSAPI.SetTextColorByCode(txt_price3,"FFC146");
        -- else
        --     CSAPI.SetTextColorByCode(txt_price,"FFFFFF");
        --     CSAPI.SetTextColorByCode(txt_rmb,"FFFFFF");
        --     CSAPI.SetTextColorByCode(txt_rmbVal,"FFFFFF");
        --     CSAPI.SetTextColorByCode(txt_price3,"FFFFFF");
        end
    end
end

--设置价格
function SetCost(cost,isOver)
    if isOver then
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(priceObj2,false);
        CSAPI.SetGOActive(priceObj3,false);
        CSAPI.SetGOActive(freeObj,true);
        CSAPI.SetText(txt_free,LanguageMgr:GetByID(18012));
        do return end
    end
    if cost then
        if currPrice==priceObj2 then
            CSAPI.SetText(txt_rmb,rmbIcon)
            CSAPI.SetText(txt_rmbVal,tostring(cost[1].num));
            SetSDKdisplayPrice(txt_rmbVal);
        elseif currPrice==priceObj then
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id,true);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon, cfg.icon.."_1");
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            CSAPI.SetText(txt_price,tostring(cost[1].num));
            SetSDKdisplayPrice(txt_price);
        else
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon3, cfg.icon.."_1",true);
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            CSAPI.SetText(txt_price3,tostring(cost[1].num));
            SetSDKdisplayPrice(txt_price3);
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
            CSAPI.SetText(txt_free,LanguageMgr:GetByID(18032));
        end
    else
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(priceObj2,false);
        CSAPI.SetGOActive(priceObj3,false);
        CSAPI.SetGOActive(freeObj,true);
        CSAPI.SetText(txt_free,LanguageMgr:GetByID(18032));
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
    -- local dis=math.floor(discount*100+0.5);
    -- CSAPI.SetGOActive(discountObj,discount~=1);
    -- CSAPI.SetText(txt_discount,dis.."%");
    CSAPI.SetGOActive(discountObj,discount~=nil);
    if discount then
        CSAPI.SetText(txt_discount,discount);
    end
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