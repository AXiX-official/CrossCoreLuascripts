--竖形的商品展示
local descPos={{-94.63,-99},{-94.63,-145.5}}
local currPrice=priceObj;
local eventMgr=nil;
local StrText=nil;
local rmbIcon=nil;
local SDKdisplayPrice=nil;
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
    if this.data and this.data:GetType()==CommodityItemType.MonthCard then--月卡，显示剩余天数
        SetDays(days);--刷新剩余时间
    end
end
function Refresh(_data,_elseData)
    this.data=_data;
    this.elseData=_elseData;
    currPrice=priceObj3
    local num=this.data:GetNum()
    ResUtil.VCommodity:Load(icon,this.data:GetPackageIcon(),true);
    rmbIcon=this.data:GetCurrencySymbols();
    SDKdisplayPrice=this.data:GetSDKdisplayPrice();
    -- if this.elseData.showType==ShopShowType.Card then
    --     CSAPI.SetGOActive(mask,true)
    --     CSAPI.SetGOActive(icon,true)
    --     --显示类型为卡牌时，商品icon为模型表ID
    --     local good=this.data:GetCommodityList()[1];
    --     if good then
    --         local cardCfg=Cfgs.CardData:GetByID(good.data:GetDyVal1());
    --         if cardCfg then
    --             local modelCfg=Cfgs.character:GetByID(cardCfg.model);
    --             ResUtil.CardIcon:Load(icon,modelCfg.Card_head,true);
    --             CSAPI.SetText(text_altName,modelCfg.englishName);
    --             -- SetTIcon(cardCfg.nClass);
    --         end
    --     end
    --     ResUtil.VCommodity:Load(bg,"img_10_01",true);
    --     CSAPI.SetGOActive(altNameItem,true);
    --     currPrice=priceObj;
    --     SetCount(this.data:GetLimitDesc("ffffff"));
    -- elseif this.elseData.showType==ShopShowType.Package then
    --     CSAPI.SetGOActive(icon,false)
    --     CSAPI.SetGOActive(mask,false)
    --     CSAPI.SetGOActive(altNameItem,false);
    --     ResUtil.VCommodity:Load(bg,"img_02_01",true);
    --     -- SetTIcon();
    --     SetCount(this.data:GetLimitDesc(num >0 and "ffc146" or "ffffff"));
    -- end
    SetCount(this.data:GetLimitDesc());
    SetName(this.data:GetName());
    
    -- ShopCommFunc.SetIconBorder(_data,_elseData.commodityType,border,icon)
    SetLimitTag(this.data:IsLimitTime(),this.data:GetEndBuyTips());
    SetDiscount(this.data:GetNowDiscountTips())
    local exStr=""
    local isDouble=false;
    local isOver=this.data:IsOver();
    if this.data:GetType()==CommodityItemType.Deposit then--充值类型,首充双倍逻辑
        local exList=this.data:GetExCommodityList();
        local buyNum=this.data:GetBuyCount();
        if buyNum==0 and this.data:GetExCommodityList()~=nil then
            isDouble=true;
        end
        -- local langID=buyNum>0 and 18031 or 18030
        -- if exList then
        --     exStr=LanguageMgr:GetByID(langID,exList[1].num,exList[1].data:GetName());
        -- end
    elseif this.data:GetType()==CommodityItemType.MonthCard then--月卡，显示剩余天数
        SetDays(ShopMgr:GetMonthCardDays());
    else
        SetDays(0);
    end
    SetDoubleTag(isDouble);
    local costs=nil
    if this.data:HasOtherPrice(ShopPriceKey.jCosts1) then
        costs={this.data:GetRealPrice()[1],this.data:GetRealPrice(ShopPriceKey.jCosts1)[1]};
    else
        costs=this.data:GetRealPrice();
    end
    SetCost(costs,isOver);
    SetAlpha(isOver and 0.4 or 1);
    SetOver(isOver);
    local isLock=not this.data:GetBuyLimit();
    SetLockObj(isLock,this.data:GetBuyLimitDesc());
    SetRedInfo();
    SetOrgPrice();
end
function SetPrice(TxtUI)
    ---价格显示，如果没有就不显示
    if CSAPI.IsADV() then if SDKdisplayPrice~=nil then CSAPI.SetText(TxtUI,SDKdisplayPrice); end end
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
                CSAPI.SetText(txt_dsRmb,this.data:GetCurrencySymbols(true));
                CSAPI.SetGOActive(dsMoneyIcon,false);
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

-- function SetTIcon(iconName)
--     CSAPI.SetGOActive(tIcon,iconName~=nil);
--     if iconName and iconName~=8 then
--         ResUtil.VCommodity:Load(tIcon,"img_03_0"..iconName,true);
--     end
-- end

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
    if str~=nil and str ~="" then
        CSAPI.SetGOActive(countObj,true);
        CSAPI.SetText(text_num,str);
    else
        CSAPI.SetGOActive(countObj,false);
    end
end

--限时标签
function SetLimitTag(isShow,tips)
    CSAPI.SetGOActive(limitTag,isShow==true);
    CSAPI.SetText(txt_limitTag,tips);
end

function SetOver(isOver)
    CSAPI.SetGOActive(overObj,isOver);
end

--设置价格
function SetCost(cost,isOver)
    if cost then
        if #cost<2 and cost[1].id==-1 then
            currPrice=priceObj2;
        elseif #cost>=2 then
            currPrice=dPriceObj
        end
    end
    if isOver then
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(priceObj2,false);
        CSAPI.SetGOActive(priceObj3,false);
        CSAPI.SetGOActive(freeObj,true);
        CSAPI.SetGOActive(dPriceObj,false);
        CSAPI.SetText(txt_free,LanguageMgr:GetByID(18012));
        do return end
    end
    if cost then
        if currPrice==priceObj2 then
            CSAPI.SetText(txt_rmb,rmbIcon);
            CSAPI.SetText(txt_rmbVal,tostring(cost[1].num));
            SetPrice(txt_rmbVal)
        elseif currPrice==priceObj then
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id,true);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon, cfg.icon.."_1");
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            CSAPI.SetText(txt_price,tostring(cost[1].num));
            SetPrice(txt_price)
        elseif currPrice==dPriceObj then
            CSAPI.SetGOActive(dMNode,cost[1].id~=-1 )
            CSAPI.SetGOActive(pnIcon1,cost[1].id==-1 )
            if cost[1].id~=-1 then
                ShopCommFunc.SetPriceIcon(dMIcon1,cost[1]);
            else
                CSAPI.SetText(pnIcon1,rmbIcon);
            end
            CSAPI.SetGOActive(dMNode2,cost[2].id~=-1 )
            CSAPI.SetGOActive(pnIcon2,cost[2].id==-1 )
            if cost[2].id~=-1 then
                ShopCommFunc.SetPriceIcon(dMIcon2,cost[2]);
            else
                CSAPI.SetText(pnIcon2,rmbIcon);
            end
            CSAPI.SetText(txt_dPrice1,tostring(cost[1].num));
            CSAPI.SetText(txt_dPrice2,tostring(cost[2].num));
            SetPrice(txt_dPrice1)
        else
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon3, cfg.icon.."_1",true);
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            CSAPI.SetText(txt_price3,tostring(cost[1].num));
            SetPrice(txt_price3)
        end
        if cost[1].num>0 then
            CSAPI.SetGOActive(freeObj,false);
            CSAPI.SetGOActive(priceObj,currPrice==priceObj);
            CSAPI.SetGOActive(priceObj2,currPrice==priceObj2);
            CSAPI.SetGOActive(priceObj3,currPrice==priceObj3);
            CSAPI.SetGOActive(dPriceObj,currPrice==dPriceObj);
        else
            CSAPI.SetGOActive(priceObj,false);
            CSAPI.SetGOActive(priceObj2,false);
            CSAPI.SetGOActive(priceObj3,false);
            CSAPI.SetGOActive(dPriceObj,false);
            CSAPI.SetGOActive(freeObj,true);
            CSAPI.SetText(txt_free,LanguageMgr:GetByID(18032));
        end
    else
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(priceObj2,false);
        CSAPI.SetGOActive(priceObj3,false);
        CSAPI.SetGOActive(dPriceObj,false);
        CSAPI.SetGOActive(freeObj,true);
        CSAPI.SetText(txt_free,LanguageMgr:GetByID(18032));
    end
end

function SetLockObj(isLock,lockDesc)
    CSAPI.SetGOActive(lockObj,isLock);
    if isLock then
        CSAPI.SetText(txt_lockDesc,lockDesc);
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
icon=nil;
priceObj=nil;
txt_price=nil;
moneyIcon=nil;
priceObj2=nil;
line=nil;
txt_rmb=nil;
txt_rmbVal=nil;
priceObj3=nil;
txt_price3=nil;
moneyIcon3=nil;
nameItem=nil;
text_name=nil;
limitItem=nil;
text_limit=nil;
text_limitVal=nil;
limitTag=nil;
discountObj=nil;
txt_discount=nil;
txt_off=nil;
txtState=nil;
overObj=nil;
altNameItem=nil;
text_altName=nil;
doubleTag=nil;
view=nil;
end
----#End#----