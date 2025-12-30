-- 皮肤商品子物体
local currPrice = priceObj;
local skinInfo = nil;
local countTime = 0;
local updateTime = 600;
local changeInfo = nil;
local needToCheckMove = false
local rmbIcon = nil;
local SDKdisplayPrice = nil;
function Awake()
    luaTextMove = LuaTextMove.New()
    luaTextMove:Init(txt_name)
end
function Refresh(_data, _elseData)
    this.data = _data;
    this.elseData = _elseData;
    skinInfo = ShopCommFunc.GetSkinInfo(this.data);
    currPrice = priceObj3
    local num = this.data:GetNum()
    RefreshTime();
    SetDiscount(this.data:GetNowDiscountTips())
    rmbIcon = this.data:GetCurrencySymbols();
    SDKdisplayPrice = this.data:GetSDKdisplayPrice();
    if skinInfo then
        changeInfo = skinInfo:GetChangeInfo();
        local hasMore = changeInfo ~= nil and true or false;
        local showBg1 = true;
        -- local showOtherIcon=false;
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
        if hasMore ~= true then
            ResUtil.SkinMall:Load(icon, this.data:GetIcon(), true);
        else
            if changeInfo[1].cfg.skinType ~= 5 then -- 形切或者同调
                if this.data:GetIcon2() ~= nil then
                    -- 加载SpriteRenderer
                    ResUtil.SkinMall:LoadSR(Role_A, this.data:GetIcon());
                    ResUtil.SkinMall:LoadSR(Role_B, this.data:GetIcon2());
                    showBg1 = false
                end
            else
                ResUtil.SkinMall:Load(icon, this.data:GetIcon(), true);
                -- 加载机神icon
                showBg1 = true
                -- showOtherIcon=true;
            end
        end
        -- CSAPI.SetGOActive(otherIcon,showOtherIcon);
        CSAPI.SetGOActive(bg, showBg1);
        CSAPI.SetGOActive(bg2, not showBg1);
        -- CSAPI.SetGOActive(asmrIcon,this.data:GetBundlingID()~=nil);
        SetName(skinInfo:GetRoleName());
        SetTagIcons();
        local cfg = skinInfo:GetSetCfg();
        SetTag(skinInfo:GetSkinName());
        SetSIcon(cfg.icon);
        SetOrgPrice();
        local getType, getTips = skinInfo:GetWayInfo(true)
        local isOver = this.data:IsOver();
        if isOver then
            SetOver(isOver);
        elseif getType ~= SkinGetType.Store then
            SetGetTips(getTips);
        else
            local costs = {};
            if this.data:HasOtherPrice(ShopPriceKey.jCosts1) then
                costs = {this.data:GetRealPrice()[1], this.data:GetRealPrice(ShopPriceKey.jCosts1)[1]};
            else
                costs = this.data:GetRealPrice();
            end
            if costs and #costs > 1 then
                currPrice = dPriceObj;
            elseif costs and costs[1].id == -1 then
                currPrice = priceObj2;
            end
            SetCost(costs, isOver);
        end
    else
        LogError("未找到对应的模型Id");
    end
end

function SetTagIcons()
    local tagIdx=0;
    local hotType=this.data:HasDiscountTag();
    local icons,lIds=nil,nil;
    if hotType~=nil then
        icons=icons or {};
        lIds=lIds or {};
        if hotType==2 or hotType==4 then
            table.insert(icons,"img_25_09");
            table.insert(lIds,18169);
        end
        if hotType==3 or hotType==4 then
            table.insert(icons,"img_25_10");
            table.insert(lIds,18170);
        end
    end
    -- 特殊标签
    local icons2, lIds2 = skinInfo:GetTagIcons(true);
    if icons2~=nil then
        icons=icons or {};
        lIds=lIds or {};
        for i, v in ipairs(icons2) do
            table.insert(icons,v);
            table.insert(lIds,lIds2[i]);
        end
    end
    if icons ~= nil then
        -- LogError(skinInfo:GetSkinName().."\t"..table.tostring(icons))
        for i, v in ipairs(icons) do
            CSAPI.SetGOActive(this[("tagIcon" .. i)], true)
            ResUtil.Tag:Load(this[("tagIcon" .. i)], v);
            CSAPI.SetText(this["txtTagIcon" .. i], tostring(LanguageMgr:GetByID(lIds[i])));
            -- if lIds[i] == 18146 then
            --     CSAPI.SetTextColorByCode(this["txtTagIcon" .. i], "AA5324");
            -- else
            --     CSAPI.SetTextColorByCode(this["txtTagIcon" .. i], "A9C4F5");
            -- end
        end
    end
    tagIdx=icons==nil and 0 or #icons
    if tagIdx < 5 then
        local index = tagIdx +1;
        for i = index, 5 do
            CSAPI.SetGOActive(this[("tagIcon" .. i)], false)
        end
    end
end


function SetOrgPrice()
    if this.data ~= nil then
        if this.data:IsOver() then
            CSAPI.SetGOActive(discountInfo, false);
            do
                return
            end
        end
        local orgCosts = this.data:GetOrgCosts();
        local orgNum=orgCosts~=nil and #orgCosts or 0;
        CSAPI.SetGOActive(discountInfo, orgNum >0);
        CSAPI.SetGOActive(discountLayout1, orgNum >0);
        CSAPI.SetGOActive(discountLayout2, orgNum >1);
        if orgCosts ~= nil then
            -- 计算倒计时
            local timeTips = this.data:GetOrgEndBuyTips()
            CSAPI.SetGOActive(dsInfo2, timeTips ~= nil)
            if timeTips then
                CSAPI.SetText(txtDSTime, timeTips);
            end
            for i, v in ipairs(orgCosts) do
                CSAPI.SetText(this["txt_dsVal"..i], tostring(v[2]));
                if v[1] ~= -1 then
                    CSAPI.SetGOActive(this["dsMoneyIcon"..i], true);
                    CSAPI.SetGOActive(this["txt_dsRmb"..i], false);
                    local cfg = Cfgs.ItemInfo:GetByID(v[1], true);
                    if cfg and cfg.icon then
                        ResUtil.IconGoods:Load(this["dsMoneyIcon"..i], cfg.icon .. "_1");
                    else
                        LogError("道具商店：读取物品的价格Icon出错！Cfg:" .. tostring(cfg));
                    end
                else
                    CSAPI.SetText(this["txt_dsRmb"..i], this.data:GetCurrencySymbols(true));
                    CSAPI.SetGOActive(this["dsMoneyIcon"..i], false);
                    CSAPI.SetGOActive(this["txt_dsRmb"..i], true);
                end
                if #v == 3 then
                    CSAPI.SetTextColorByCode(this["pnIcon" .. v[3]], "FFC146");
                    CSAPI.SetTextColorByCode(this["txt_dPrice" .. v[3]], "FFC146");
                else
                    CSAPI.SetTextColorByCode(pnIcon1, "FFFFFF");
                    CSAPI.SetTextColorByCode(pnIcon2, "FFFFFF");
                    CSAPI.SetTextColorByCode(txt_dPrice1, "FFFFFF");
                    CSAPI.SetTextColorByCode(txt_dPrice2, "FFFFFF");
                end
            end
        else
            CSAPI.SetTextColorByCode(pnIcon1, "FFFFFF");
            CSAPI.SetTextColorByCode(pnIcon2, "FFFFFF");
            CSAPI.SetTextColorByCode(txt_dPrice1, "FFFFFF");
            CSAPI.SetTextColorByCode(txt_dPrice2, "FFFFFF");
        end
    end
end

function SetDiscount(discount)
    CSAPI.SetGOActive(discountObj, discount ~= nil);
    if discount then
        CSAPI.SetText(txt_discount, discount);
    end
    -- local dis=math.floor(discount*10+0.5);
    -- CSAPI.SetGOActive(discountObj,discount~=1);
    -- CSAPI.SetText(txt_discount,string.format(LanguageMgr:GetByID(18074),dis));
end

function Update()
    countTime = countTime + Time.deltaTime;
    if countTime >= updateTime then
        countTime = 0;
        RefreshTime()
    end
    if (needToCheckMove) then
        luaTextMove:CheckMove(txt_name)
        needToCheckMove = false
    end
end

function RefreshTime()
    if this.data and this.data:GetEndBuyTime() > 0 then
        CSAPI.SetText(txt_limit, this.data:GetEndBuyTips())
        CSAPI.SetGOActive(limitObj, true);
    else
        CSAPI.SetGOActive(limitObj, false);
    end
end

function SetSIcon(iconName)
    CSAPI.SetGOActive(setIcon, iconName ~= nil);
    if iconName then
        ResUtil.SkinSetIcon:Load(setIcon, iconName .. "_w", true);
    end
end

function SetTag(str)
    CSAPI.SetText(txt_setTag, str or "");
    CSAPI.SetGOActive(txt_setTag, str ~= nil)
end

function SetName(str)
    needToCheckMove = false
    CSAPI.SetText(txt_name, str or "");
    needToCheckMove = true
end

function SetAlpha(val)
    CSAPI.SetGOAlpha(alphaNode, val);
end

function SetOver(isOver)
    CSAPI.SetGOActive(priceObj, false);
    CSAPI.SetGOActive(priceObj2, false);
    CSAPI.SetGOActive(priceObj3, false);
    CSAPI.SetGOActive(dPriceObj, false);
    CSAPI.SetGOActive(freeObj, true);
    CSAPI.SetText(txt_free, LanguageMgr:GetByID(18068));
end

-- 设置价格
function SetCost(cost, isOver)
    if isOver then
        do
            return
        end
    end
    if cost then
        if currPrice == priceObj2 then
            CSAPI.SetText(txt_rmb, rmbIcon);
            CSAPI.SetText(txt_rmbVal, tostring(cost[1].num));
        elseif currPrice == priceObj then
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id, true);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon, cfg.icon .. "_1");
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:" .. tostring(cfg));
            end
            CSAPI.SetText(txt_price, tostring(cost[1].num));
        elseif currPrice == dPriceObj then
            CSAPI.SetGOActive(dMNode, cost[1].id ~= -1)
            CSAPI.SetGOActive(pnIcon1, cost[1].id == -1)
            if cost[1].id ~= -1 then
                ShopCommFunc.SetPriceIcon(dMIcon1, cost[1]);
            else
                CSAPI.SetText(pnIcon1, rmbIcon);
            end
            CSAPI.SetGOActive(dMNode2, cost[2].id ~= -1)
            CSAPI.SetGOActive(pnIcon2, cost[2].id == -1)
            if cost[2].id ~= -1 then
                ShopCommFunc.SetPriceIcon(dMIcon2, cost[2]);
            else
                CSAPI.SetText(pnIcon2, rmbIcon);
            end
            CSAPI.SetText(txt_dPrice1, tostring(cost[1].num));
            CSAPI.SetText(txt_dPrice2, tostring(cost[2].num));
            if CSAPI.IsADV() then
                ---显示价格
                if SDKdisplayPrice ~= nil then
                    CSAPI.SetText(txt_dPrice1, SDKdisplayPrice);
                end
            end
        else
            local cfg = Cfgs.ItemInfo:GetByID(cost[1].id);
            if cfg and cfg.icon then
                ResUtil.IconGoods:Load(moneyIcon3, cfg.icon .. "_1", true);
            else
                LogError("道具商店：读取物品的价格Icon出错！Cfg:" .. tostring(cfg));
            end
            CSAPI.SetText(txt_price3, tostring(cost[1].num));
        end
        if cost[1].num > 0 then
            CSAPI.SetGOActive(freeObj, false);
            CSAPI.SetGOActive(priceObj, currPrice == priceObj);
            CSAPI.SetGOActive(priceObj2, currPrice == priceObj2);
            CSAPI.SetGOActive(priceObj3, currPrice == priceObj3);
            CSAPI.SetGOActive(dPriceObj, currPrice == dPriceObj);
        else
            CSAPI.SetGOActive(priceObj, false);
            CSAPI.SetGOActive(priceObj2, false);
            CSAPI.SetGOActive(priceObj3, false);
            CSAPI.SetGOActive(dPriceObj, false);
            CSAPI.SetGOActive(freeObj, true);
            CSAPI.SetText(txt_free, LanguageMgr:GetByID(18032));
        end
    else
        CSAPI.SetGOActive(priceObj, false);
        CSAPI.SetGOActive(priceObj2, false);
        CSAPI.SetGOActive(priceObj3, false);
        CSAPI.SetGOActive(dPriceObj, false);
        CSAPI.SetGOActive(freeObj, true);
        CSAPI.SetText(txt_free, LanguageMgr:GetByID(18032));
    end
end

-- 设置获得方式
function SetGetTips(str)
    CSAPI.SetGOActive(priceObj, false);
    CSAPI.SetGOActive(priceObj2, false);
    CSAPI.SetGOActive(priceObj3, false);
    CSAPI.SetGOActive(freeObj, true);
    if str ~= nil and str ~= "" then
        CSAPI.SetText(txt_free, str);
    else
        CSAPI.SetText(txt_free, LanguageMgr:GetByID(18057));
    end
end

function SetL2dTag(isShow)
    -- CSAPI.SetGOActive(l2dTag,isShow==true); --和谐隐藏
end

function SetAnimaTag(isShow)
    -- CSAPI.SetGOActive(animaTag,isShow==true);
end

function SetModelTag(isShow)
    -- CSAPI.SetGOActive(modelTag,isShow==true);
end

function SetSPPriceTag(isShow)
    -- CSAPI.SetGOActive(spPriceTag,isShow==true);
end

function SetSPTag(isShow)
    -- CSAPI.SetGOActive(spTag,isShow==true);
end

function SetClickCB(cb)
    this.cb = cb;
end

function OnClickSelf()
    if this.cb then
        this.cb(this);
    end
end

-- 检查固定商品类型的道具折扣信息是否需要刷新
function CheckDiscountRefresh(nowTime)
    if this.elseData.commodityType == 1 then
        local endTime = this.data:GetDiscountEndTime()
        local startTime = this.data:GetDiscountStartTime()
        if startTime ~= 0 and nowTime >= startTime and nowTime <= endTime then
            RefreshByFixed();
        elseif endTime ~= 0 and nowTime >= endTime then
            RefreshByFixed();
        end
    end
end

function RefreshByFixed()
    local records = ShopMgr:GetRecordInfos(this.data:GetCfgID());
    data:SetData(records);
    -- Refresh(data,commodityType);
end

function SetIndex(index)
    this.index = index;
end

function GetIndex()
    return this.index;
end
