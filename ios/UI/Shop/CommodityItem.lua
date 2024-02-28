--商品预制物
-- local grid=nil;
local eventMgr=nil;
function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh,SetRedInfo)
    eventMgr:AddListener(EventType.Shop_NewInfo_Refresh,SetNewInfo)
end

function OnDestroy()
    eventMgr:ClearListener();
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
    UIUtil:SetRedPoint(alphaNode,isShowRed,130,-130);
 end

 function SetNewInfo(infos)
    local hasThis=false;
    if this.data then
        local pageID=this.data:GetShopID();
        local tabID=this.data:GetTabID();
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


function Refresh(_data,_elseData)
    if _data==nil then
        return;
    end
    CSAPI.SetGOActive(tIcon2,false);
    CSAPI.SetGOActive(tBorder,false);
    this.data=_data;
    this.elseData=_elseData;
    SetName(this.data:GetName());
    local num=this.data:GetNum()
    ShopCommFunc.SetIconBorder2(_data,_elseData.commodityType,bg,icon,light,tIcon,tIcon2,tBorder)
    SetLimitTag(this.data:IsLimitTime(),this.data:GetEndBuyTips());
    -- if _elseData and _elseData.commodityType ==2 then
    --     SetLimit();
    -- else
        local s1,s2,s3=this.data:GetResetTips();
        SetLimit(s2,s3);
    -- end
    local good=this.data:GetCommodityList()[1];
    local costs={};
    costs=this.data:GetRealPrice();
    local getList=this.data:GetCommodityList();
    local type=1;
    local num=getList and getList[1].num or 0;
    local isOver=this.data:IsOver();
    local overType=1;
    if good then
        if good.data:GetType()==ITEM_TYPE.CARD_CORE_ELEM then
            CSAPI.SetGOActive(tIcon2,true);
        elseif good.data:GetType()==ITEM_TYPE.CARD then
            CSAPI.SetGOActive(tIcon2,true);
        elseif this.data:GetType()==CommodityItemType.THEME or this.data:GetType()==CommodityItemType.FORNITURE  then --查询宿舍表中的价格
            costs={};
            local dyVal1=good.data:GetDyVal1();
            local isMax=false;
            --查询宿舍表
            if dyVal1 then
                local cfg = Cfgs.CfgFurniture:GetByID(dyVal1);  
                type=2;
                --判断是否超过持有数，超过持有数不能购买
                if this.data:GetType()==CommodityItemType.FORNITURE then --家具
                    num=cfg.comfort;
                    local buyCount=DormMgr:GetBuyCount(dyVal1);
                    isMax=buyCount>=cfg.buyNumLimit;
                    if cfg.price_1 then
                        table.insert(costs,{id = cfg.price_1[1][1],num = cfg.price_1[1][2]});
                    end
                    if cfg.price_2 then
                        table.insert(costs,{id = cfg.price_2[1][1],num = cfg.price_2[1][2]});
                    end
                else--主题
                    local themeData = DormMgr:GetThemesByID(ThemeType.Sys, dyVal1)
                    local cfg2=Cfgs.CfgFurnitureTheme:GetByID(dyVal1);
                    num=cfg2.comfort;
                    isMax=themeData~=nil;
                    --获取主题价格
                    local price1,price2=DormMgr:GetThemePrices(dyVal1);
                    if cfg.price_1 then
                        table.insert(costs,{id = cfg.price_1[1][1],num = price1});
                    end
                    if cfg.price_2 then
                        table.insert(costs,{id = cfg.price_2[1][1],num = price2});
                    end
                    -- if cfg.price_1 then
                    --     table.insert(costs,{id = cfg.price_1[1][1],num = cfg.price_1[1][2]});
                    -- end
                    -- if cfg.price_2 then
                    --     table.insert(costs,{id = cfg.price_2[1][1],num = cfg.price_2[1][2]});
                    -- end
                end
            end
            if isOver==false and isMax==true then --达到持有上限
                isOver=true;
                overType=2;
            end
        end
    end
    SetGoodsNum(num,type);
    -- SetTIcon(this.data:GetTIcon());
    SetDiscount(this.data:GetNowDiscount())
    SetQuality(this.data:GetQuality())
    SetCost(costs,isOver);
    SetAlpha(isOver and 0.4 or 1);
    SetOver(isOver,overType);
    local isLock=not this.data:GetBuyLimit();
    SetLockObj(isLock,this.data:GetBuyLimitDesc());
    SetRedInfo();
end

-- function SetTIcon(iconName)
--     iconName=iconName or "img_4_01";
--     ResUtil.Commodity:Load(tIcon,iconName,true);
-- end

function SetName(str)
    CSAPI.SetText(text_name,str);
end

function SetDiscount(discount)
    local dis=math.floor(discount*10+0.5);
    CSAPI.SetGOActive(discountObj,discount~=1);
    CSAPI.SetText(txt_discount,string.format(LanguageMgr:GetByID(18074),dis));
end

function SetLimit(str,str2)
    if str and str~="" and str2 and str2~="" then
        CSAPI.SetGOActive(limitNum,true);
        CSAPI.SetText(text_limit,str);
        CSAPI.SetText(text_limitVal,str2);
    else
        CSAPI.SetGOActive(limitNum,false);
    end
end

--限时标签
function SetLimitTag(isShow,str)
    CSAPI.SetGOActive(limitTag,isShow==true);
    CSAPI.SetText(txt_limitTag,str or "");
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode,val);
end

function SetOver(isOver,overType)
    overType=overType or 1;
    CSAPI.SetGOActive(overObj,isOver);
    CSAPI.SetGOActive(overImg,overType==1)
    CSAPI.SetGOActive(overDesc,overType==2)
end

--type:nil或1表示为数量，2为舒适度
function SetGoodsNum(num,type)
    CSAPI.SetGOActive(countObj,num>=0);
    type=type==nil and 1 or type;
    CSAPI.SetGOActive(dormVal,type==2);
    CSAPI.SetGOActive(txt_count,type==1);
    CSAPI.SetText(txt_countVal,tostring(num));
end

--设置单种价格
function SetCost(costs,isOver)
    if isOver then
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(freeObj,false);
        CSAPI.SetGOActive(dPriceObj,false);
        do return end
    end
    if costs then
        if #costs==1 then
            if costs[1].num>0 then
                local tips="";
                ShopCommFunc.SetPriceIcon(moneyIcon,costs[1]);
                if costs[1].id==-1 then
                    tips=LanguageMgr:GetByID(18013);
                end
                CSAPI.SetText(txt_price,tips..tostring(costs[1].num));
                CSAPI.SetGOActive(priceObj,true);
                CSAPI.SetGOActive(dPriceObj,false);
                CSAPI.SetGOActive(freeObj,false);
            else
                CSAPI.SetGOActive(priceObj,false);
                CSAPI.SetGOActive(dPriceObj,false);
                CSAPI.SetGOActive(freeObj,true);
            end
        else
            CSAPI.SetGOActive(priceObj,false);
            CSAPI.SetGOActive(freeObj,false);
            CSAPI.SetGOActive(dPriceObj,true);
            ShopCommFunc.SetPriceIcon(dMIcon1,costs[1]);
            ShopCommFunc.SetPriceIcon(dMIcon2,costs[2]);
            CSAPI.SetText(txt_dPrice1,tostring(costs[1].num));
            CSAPI.SetText(txt_dPrice2,tostring(costs[2].num));
        end
    else
        CSAPI.SetGOActive(priceObj,false);
        CSAPI.SetGOActive(freeObj,true);
        CSAPI.SetGOActive(dPriceObj,false);
    end
end

function SetQuality(quality)
    -- CSAPI.LoadImg(bg,"UIs/Shop/"..CommodityQuality[quality],true,nil,true);
    -- CSAPI.SetImgColorByCode(priceObj,CommodityCostColor[quality]);
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

function SetLockObj(isLock,lockDesc)
    CSAPI.SetGOActive(lockObj,isLock);
    if isLock then
        CSAPI.SetText(txt_lockDesc,lockDesc);
    end
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
tIcon=nil;
alphaNode=nil;
bg=nil;
text_name=nil;
icon=nil;
priceObj=nil;
txt_price=nil;
moneyIcon=nil;
text_limit=nil;
text_limitVal=nil;
countObj=nil;
txt_count=nil;
limitTag=nil;
discountObj=nil;
txt_discount=nil;
txt_off=nil;
overObj=nil;
view=nil;
end
----#End#----