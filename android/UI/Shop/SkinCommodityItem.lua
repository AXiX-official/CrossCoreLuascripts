--皮肤商品子物体
local currPrice=priceObj;
local skinInfo=nil;
local countTime=0;
local updateTime=600;
local changeInfo=nil;

function Refresh(_data,_elseData)
    this.data=_data;
    this.elseData=_elseData;
    skinInfo=ShopCommFunc.GetSkinInfo(this.data);
    currPrice=priceObj3
    local num=this.data:GetNum()
    RefreshTime();
    SetDiscount(this.data:GetNowDiscountTips())
    if skinInfo then
        changeInfo=skinInfo:GetChangeInfo();
        local hasMore=changeInfo~=nil and true or false;
        local showBg1=true;
        local showOtherIcon=false;
        -- if this.data:GetIcon2()~=nil then
        --     --加载SpriteRenderer
        --     ResUtil.SkinMall:LoadSR(Role_A,this.data:GetIcon());
        --     ResUtil.SkinMall:LoadSR(Role_B,this.data:GetIcon2());
        --     showBg1=false  
        -- else
        --     local index= this.data:GetID()%2==0 and 2 or 1;
        --     local imgA=index==1 and "60020_Skin101_mall" or "20070_Skin104_mall";
        --     local imgB=index==1 and "40050_Skin108_mall" or "60110_Skin102_mall";
        --     ResUtil.SkinMall:LoadSR(Role_A,imgA);
        --     ResUtil.SkinMall:LoadSR(Role_B,imgB);
        --     showBg1=false  
        -- end
        if hasMore~=true then
            ResUtil.SkinMall:Load(icon,this.data:GetIcon(),true);
        else
            if changeInfo[1].cfg.skinType~=5 then --形切或者同调
                if this.data:GetIcon2()~=nil then
                    --加载SpriteRenderer
                    ResUtil.SkinMall:LoadSR(Role_A,this.data:GetIcon());
                    ResUtil.SkinMall:LoadSR(Role_B,this.data:GetIcon2());
                    showBg1=false  
                end
            else
                ResUtil.SkinMall:Load(icon,this.data:GetIcon(),true);
                --加载机神icon
                showBg1=true
                showOtherIcon=true;
            end
        end
        CSAPI.SetGOActive(otherIcon,showOtherIcon);
        CSAPI.SetGOActive(bg,showBg1);
        CSAPI.SetGOActive(bg2,not showBg1);
        CSAPI.SetGOActive(asmrIcon,this.data:GetBundlingID()~=nil);
        SetName(skinInfo:GetRoleName());
        SetL2dTag(skinInfo:HasL2D());
        SetAnimaTag(skinInfo:HasEnterTween());
        SetModelTag(skinInfo:HasModel());
        SetSPPriceTag(this.data:HasDiscountTag());
        SetSPTag(skinInfo:HasSpecial());
        local cfg=skinInfo:GetSetCfg();
        SetTag(skinInfo:GetSkinName());
        SetSIcon(cfg.icon);
        local getType,getTips=skinInfo:GetWayInfo(true)
        local isOver=this.data:IsOver();
        if isOver then
            SetOver(isOver);
        elseif getType~=SkinGetType.Store then
            SetGetTips(getTips);
        else
            local cost=this.data:GetRealPrice();
            if cost and cost[1].id==-1 then
                currPrice=priceObj2;
            end
            SetCost(cost,isOver);
        end
    else
        LogError("未找到对应的模型Id");
    end
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

function Update()
    countTime=countTime+Time.deltaTime;
	if countTime>=updateTime then
        countTime=0;
        RefreshTime()
    end
end

function RefreshTime()
    if this.data and this.data:GetEndBuyTime()>0 then
        CSAPI.SetText(txt_limit,this.data:GetEndBuyTips())
        CSAPI.SetGOActive(limitObj,true);
    else
        CSAPI.SetGOActive(limitObj,false);
    end
end

function SetSIcon(iconName)
    CSAPI.SetGOActive(setIcon,iconName~=nil);
    if iconName then
        ResUtil.SkinSetIcon:Load(setIcon,iconName.."_w",true);
    end
end

function SetTag(str)
    CSAPI.SetText(txt_setTag,str or "");
    CSAPI.SetGOActive(txt_setTag,str~=nil)
end

function SetName(str)
    CSAPI.SetText(txt_name,str or "");
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode,val);
end

function SetOver(isOver)
    CSAPI.SetGOActive(priceObj,false);
    CSAPI.SetGOActive(priceObj2,false);
    CSAPI.SetGOActive(priceObj3,false);
    CSAPI.SetGOActive(freeObj,true);
    CSAPI.SetText(txt_free,LanguageMgr:GetByID(18068));
end

--设置价格
function SetCost(cost,isOver)
    if isOver then
        do return end
    end
    if cost then
        if currPrice==priceObj2 then
            CSAPI.SetText(txt_rmbVal,tostring(cost[1].num));
        elseif currPrice==priceObj then
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id,true);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon, cfg.icon.."_1");
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            CSAPI.SetText(txt_price,tostring(cost[1].num));
        else
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon3, cfg.icon.."_1",true);
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:"..tostring(cfg));
            end
            CSAPI.SetText(txt_price3,tostring(cost[1].num));
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

--设置获得方式
function SetGetTips(str)
    CSAPI.SetGOActive(priceObj,false);
    CSAPI.SetGOActive(priceObj2,false);
    CSAPI.SetGOActive(priceObj3,false);
    CSAPI.SetGOActive(freeObj,true);
    if str~=nil and str~="" then
        CSAPI.SetText(txt_free,str);
    else
        CSAPI.SetText(txt_free,LanguageMgr:GetByID(18057));
    end
end

function SetL2dTag(isShow)
    --CSAPI.SetGOActive(l2dTag,isShow==true); --和谐隐藏
end

function SetAnimaTag(isShow)
    --CSAPI.SetGOActive(animaTag,isShow==true);
end

function SetModelTag(isShow)
    --CSAPI.SetGOActive(modelTag,isShow==true);
end

function SetSPPriceTag(isShow)
    --CSAPI.SetGOActive(spPriceTag,isShow==true);
end

function SetSPTag(isShow)
    --CSAPI.SetGOActive(spTag,isShow==true);
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

function SetIndex(index)
    this.index=index;
end

function GetIndex()
    return this.index;
end
