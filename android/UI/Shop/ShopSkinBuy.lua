--皮肤购买界面
local roleItem=nil;
local currSkinInfo=nil;
local voucherItem=nil;
local eventMgr=nil;
local voucherList=nil;
local realPrice=0;
local curModelCfg=nil;

function Awake()
    SetMoney({ {ITEM_ID.DIAMOND}});
    UIUtil.SetRTAlpha(rtCamera,rtObj);
    local go= ResUtil:CreateUIGO("Shop/VoucherDropItem",vObj.transform);
    voucherItem=ComUtil.GetLuaTable(go);
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Shop_PayVoucher_Change, OnVoucherChange);
end

function OnDestroy()
    eventMgr:ClearListener();
end

--data:CommodityData
function OnOpen()
    if data then
         --显示皮肤立绘
        currSkinInfo=ShopCommFunc.GetSkinInfo(data);
        if roleItem then
            roleItem.Refresh(data);
        else
            ResUtil:CreateUIGOAsync("Shop/SkinCommodityItem",roleNode,function(go)
                roleItem=ComUtil.GetLuaTable(go);
                roleItem.Refresh(data);
                CSAPI.SetAnchor(go,20,-20);
            end);
        end
        -- roleItem.Refresh(currSkinInfo:GetModelID(), LoadImgType.Shop,function()
        --     roleItem.imgItemLua.faceLua.SetMask(false);
        -- end,false)
        -- CSAPI.SetGOActive(l2dTag,currSkinInfo:HasL2D());
        -- CSAPI.SetGOActive(animaTag,currSkinInfo:HasEnterTween());
        -- CSAPI.SetGOActive(modelTag,currSkinInfo:HasModel());
        CSAPI.SetText(content,currSkinInfo:GetDesc());
        curModelCfg=currSkinInfo:GetModelCfg();
        RefreshPrice();
        local changeInfo=currSkinInfo:GetChangeInfo();
        if changeInfo then
            local type=changeInfo[1].cfg.skinType;
            local langID=18099;
            if type==3 then
                langID=18100;
            elseif type==4 then
                langID=18103;
            elseif type==5 then
                langID=18099;
            end
            local cardName=changeInfo[1].cfg.key;
            -- if changeInfo[1].cfg.role_id then
            --     local cardCfg=Cfgs.Card:GetByID(changeInfo[1].cfg.role_id);
            --     cardName=cardCfg.name;
            -- end
            CSAPI.SetText(txt_tips3,LanguageMgr:GetByID(langID,cardName,changeInfo[1].cfg.desc));
        end
        CSAPI.SetGOActive(txt_tips3,changeInfo~=nil);
        local isShow=false;
        if voucherItem~=nil then
            voucherItem.Init(data,1);
            if voucherItem.GetOptionsLength()>0 then
                isShow=true;
            end
        end
        SetVoucherItem(isShow)
    end
end

function SetVoucherItem(isShow)
    if isShow then
        CSAPI.SetRTSize(content,818,258);
        CSAPI.SetAnchor(tipsObj,154,-3);
        CSAPI.SetGOActive(vObj,isShow);
    else
        CSAPI.SetRTSize(content,818,338);
        CSAPI.SetAnchor(tipsObj,154,37);
        CSAPI.SetGOActive(vObj,isShow);
    end
end

function OnClickBuy()
    ShopCommFunc.HandlePayLogic(data,1,1,voucherList,OnSuccess);
    -- local priceInfo=data:GetRealPrice();
	-- local channelType=CSAPI.GetChannelType();
	-- if priceInfo and priceInfo[1].id==-1 and (channelType==ChannelType.Normal or channelType==ChannelType.TapTap) then
	-- 	CSAPI.OpenView("SDKPaySelect",data);
	-- else
	-- 	ShopCommFunc.BuyCommodity(data,1,OnSuccess);
	-- end
    -- ShopCommFunc.BuyCommodity(data,1,OnSuccess);
    -- CSAPI.OpenView("SkinShowView",currSkinInfo)
end

function OnSuccess(proto)
    EventMgr.Dispatch(EventType.Card_Skin_Get)
    -- LogError(proto.gets[1])
    OnClickAnyway();
    if currSkinInfo and proto and next(proto.gets) then
        CSAPI.OpenView("SkinShowView",currSkinInfo)
    end
end

function OnClickAnyway()
    if gameObject~=nil and view~=nil then
        view:Close();
    end
end

function OnClickCancel()
    OnClickAnyway();
end

-- datas ={{id,跳转id}......}
function SetMoney(_datas)
    datas = _datas or datas
    CSAPI.SetGOActive(moneys, datas ~= nil)
    if (datas == nil) then
        return
    end
    for i = 1, 3 do
        local isShow = i <= #datas and datas[i] ~= nil
        CSAPI.SetGOActive(this["btnMoney" .. i], isShow)
    end
    -- money
    for i = 1, #datas do
        local _data = datas[i]
        if _data ~= nil then
            -- icon
            local cfg = Cfgs.ItemInfo:GetByID(_data[1])
            ResUtil.IconGoods:Load(this["moneyIcon" .. i], cfg.icon .. "_1")
            -- num
            if (_data[1] == ITEM_ID.Hot) then
                HotChange()
            else
                local num = BagMgr:GetCount(_data[1])
                -- if (num >= 100000) then
                --     CSAPI.SetText(this["txtMoney" .. i], math.floor(num / 1000) .. "K")
                -- else
                    CSAPI.SetText(this["txtMoney" .. i], num .. "")
                --end
            end
            -- add 

            CSAPI.SetGOActive(this["add" .. i], _data[2] ~= nil)
            if (_data[2] ~= nil) then
                local colorName = cfg.addColor
                CSAPI.SetImgColorByCode(this["add" .. i], colorName)
            end
        end
    end
end

function OnVoucherChange(ls)
    voucherList=ls;
    if voucherList~=nil then
        realPrice=0;
        local isOk,tips,res=GLogicCheck:IsCanUseVoucher(data:GetCfg(),voucherList,TimeUtil:GetTime(),1,PlayerClient:GetLv());
        if isOk and res then
            realPrice=res[1][2];
        end
    else
        realPrice=nil;
    end
    RefreshPrice();
end

function RefreshPrice()
    if data==nil then
        do return end;
    end
    CSAPI.SetText(txt_tips,LanguageMgr:GetByID(18073));
    local tips2=LanguageMgr:GetByID(18086,curModelCfg.key);
    tips2=string.format("%s<color=\'#ffc146\'>%s</color>",tips2,curModelCfg.desc)
    CSAPI.SetText(txt_tips2,tips2);
    -- CSAPI.SetText(txt_name,curModelCfg.desc)
    local priceInfo=data:GetRealPrice();
    local money=0;
    local moneyName="";
    local currMoney=nil;
    local cfg=Cfgs.ItemInfo:GetByID(ITEM_ID.DIAMOND);
    moneyName=cfg.name;
    local tp1,tp2,tg1,tg2=txt_price,txt_disPrice,txt_goodsName,txt_disGoodsName;
    local isNilList=voucherList==nil
    if isNilList~=true then
        tp1=txt_disPrice;
        tp2=txt_price;
        tg1=txt_disGoodsName;
        tg2=txt_goodsName;
        currMoney=realPrice;
    end
    CSAPI.SetGOActive(txt_disGoodsName,isNilList~=true);
    CSAPI.SetGOActive(txt_disPrice,isNilList~=true);
    if priceInfo then
        currMoney=currMoney or priceInfo[1].num;
        if priceInfo[1].id == ITEM_ID.GOLD then --金币
            -- ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.GOLD).."_1");
            money=PlayerClient:GetGold();
            local cfg=Cfgs.ItemInfo:GetByID(ITEM_ID.GOLD);
            moneyName=cfg.name;
        elseif priceInfo[1].id == ITEM_ID.DIAMOND then --钻石
            -- ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.DIAMOND).."_1");
            money=PlayerClient:GetDiamond();
        end
        if money>=currMoney then
            CSAPI.SetTextColorByCode(txt_price,"ffc146");
            CSAPI.SetTextColorByCode(txt_goodsName,"ffc146");
        else
            CSAPI.SetTextColorByCode(txt_price,"ff7781");
            CSAPI.SetTextColorByCode(txt_goodsName,"ffc146");
        end
        CSAPI.SetText(tp1, tostring(math.floor(priceInfo[1].num+0.5)));
        CSAPI.SetText(tg1,moneyName);
        if not isNilList then
            CSAPI.SetText(tp2,tostring(math.floor(realPrice+0.5)));
            CSAPI.SetText(tg2,moneyName);
        end
    else
        CSAPI.SetTextColorByCode(txt_price,"ffc146");
        CSAPI.SetTextColorByCode(txt_goodsName,"ffc146");
        CSAPI.SetText(tp1, tostring(0));
        CSAPI.SetText(tg1,moneyName);
        CSAPI.SetText(tp2, tostring(0));
        CSAPI.SetText(tg2,moneyName);
    end
end