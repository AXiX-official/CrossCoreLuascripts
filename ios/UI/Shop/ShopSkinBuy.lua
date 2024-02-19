--皮肤购买界面
local roleItem=nil;
local currSkinInfo=nil;

function Awake()
    SetMoney({ {ITEM_ID.DIAMOND}});
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
        local curModelCfg=currSkinInfo:GetModelCfg();
        CSAPI.SetText(txt_tips,LanguageMgr:GetByID(18073));
        local tips2=LanguageMgr:GetByID(18086,curModelCfg.key);
        tips2=string.format("%s<color=\'#ffc146\'>%s</color>",tips2,curModelCfg.desc)
        CSAPI.SetText(txt_tips2,tips2);
        -- CSAPI.SetText(txt_name,curModelCfg.desc)
        local priceInfo=data:GetRealPrice();
        local money=0;
        local moneyName="";
        local cfg=Cfgs.ItemInfo:GetByID(ITEM_ID.DIAMOND);
        moneyName=cfg.name;
        if priceInfo then
            if priceInfo[1].id == ITEM_ID.GOLD then --金币
                -- ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.GOLD).."_1");
                money=PlayerClient:GetGold();
                local cfg=Cfgs.ItemInfo:GetByID(ITEM_ID.GOLD);
                moneyName=cfg.name;
            elseif priceInfo[1].id == ITEM_ID.DIAMOND then --钻石
                -- ResUtil.IconGoods:Load(priceIcon, tostring(ITEM_ID.DIAMOND).."_1");
                money=PlayerClient:GetDiamond();
            end
            if money>=priceInfo[1].num then
                CSAPI.SetTextColorByCode(txt_price,"ffc146");
                CSAPI.SetTextColorByCode(txt_goodsName,"ffc146");
            else
                CSAPI.SetTextColorByCode(txt_price,"ff7781");
                CSAPI.SetTextColorByCode(txt_goodsName,"ffc146");
            end
            CSAPI.SetText(txt_price, tostring(math.floor(priceInfo[1].num+0.5)));
            CSAPI.SetText(txt_goodsName,moneyName);
            -- CSAPI.SetScale(priceIcon,1,1,1);
        else
            CSAPI.SetTextColorByCode(txt_price,"ffc146");
            CSAPI.SetTextColorByCode(txt_goodsName,"ffc146");
            CSAPI.SetText(txt_price, tostring(0));
            CSAPI.SetText(txt_goodsName,moneyName);
        end
    end
end

function OnClickBuy()
    ShopCommFunc.HandlePayLogic(data,1,1,OnSuccess);
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
    view:Close();
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