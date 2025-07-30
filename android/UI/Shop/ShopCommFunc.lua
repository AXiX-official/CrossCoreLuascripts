-- 商店公用方法
local this = {};
local normalSize = 1;
local iconSize = 1.3;
local roleSize = 0.75
local itemQualitys = {"img_15_09", "img_15_08", "img_15_07", "img_15_06", "img_15_05", "img_15_10"};
local itemQualitys2 = {"img_06_04", "img_16_04", "img_16_03", "img_16_02", "img_16_01", "img_16_05"};
local itemQualitys3 = {"img_18_05", "img_18_04", "img_18_03", "img_18_02", "img_18_01", "img_18_06"};
local packQualitys2 = {"img_25_05", "img_25_04", "img_25_03", "img_25_02", "img_25_01", "img_25_06"};
local channelType = CSAPI.GetChannelType();
this.fixedSkinID=50025;
this.fixedHideTab=1006;

-- 读取图标和边框 （支付页面用）openSetting:支付窗口填2
function this.SetIconBorder(data, commodityType, border, icon, tIcon, tBorder, openSetting, isSmall)
    local goodsData = nil;
    if border then
        CSAPI.SetGOActive(border, true);
        CSAPI.SetScale(border, normalSize, normalSize, normalSize);
    end
    local iSize = isSmall == true and normalSize or iconSize;
    openSetting = openSetting or 1
    local qulaity = 1;
    local iName = data:GetIcon();
    if commodityType == 1 then
        if iName ~= nil and iName ~= "" and openSetting == 2 and data:GetType()~=CommodityItemType.ChoiceCard  then -- 固定商品有配置图标优先读取
            qulaity = data:GetQuality();
            iSize = 1;
            ResUtil.IconGoods:Load(icon, iName);
        elseif data:GetType() == CommodityItemType.Item then -- 商品类型为1时读取物品表中的icon
            local item = data:GetCommodityList()[1];
            local good = {
                id = item.cid
            };
            goodsData = GoodsData(good);
            qulaity = goodsData:GetQuality();
            if goodsData:GetType() == ITEM_TYPE.CARD then
                -- CSAPI.SetScale(icon,roleSize,roleSize,roleSize);
                -- ResUtil.RoleCard:Load(icon, goodsData:GetIcon());
                GridUtil.LoadCIcon(icon, tIcon, goodsData:GetCfg(), true);
            elseif goodsData:GetType() == ITEM_TYPE.CARD_CORE_ELEM then
                ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                GridUtil.LoadTIcon(tIcon, tBorder, goodsData:GetCfg(), true);
            elseif goodsData:GetType() == ITEM_TYPE.PanelImg then -- 多人插图,特殊处理
                local cfg = goodsData:GetCfg();
                ResUtil.MultiIcon:Load(icon, cfg.itemPicture);
            elseif goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL or goodsData:GetType() == ITEM_TYPE.EQUIP then -- 装备素材
                -- GridUtil.LoadEquipIcon(icon,tIcon,goodsData:GetCfg(),false,true);
                GridUtil.LoadEquipIcon(icon, tIcon, goodsData:GetIcon(), goodsData:GetQuality(),
                    goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL, false)
            else
                -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                goodsData:GetIconLoader():Load(icon, goodsData:GetIcon());
            end
        elseif data:GetType() == CommodityItemType.Package or data:GetType() == CommodityItemType.Deposit or data:GetType() == CommodityItemType.MonthCard then -- 商品类型为2，4，5时读商店表中的icon
            -- CSAPI.SetGOActive(border,false);
            qulaity = data:GetQuality();
            ResUtil.IconGoods:Load(icon, iName);
        elseif data:GetType() == CommodityItemType.FORNITURE or data:GetType() == CommodityItemType.THEME then -- 家具图标
            local item = data:GetCommodityList()[1];
            local good = {
                id = item.cid
            };
            goodsData = GoodsData(good);
            ResUtil.Furniture:Load(icon, goodsData:GetIcon());
        elseif data:GetType()==CommodityItemType.ChoiceCard then
            --判断是否绑定了卡牌
            local infos = data:GetCommodityList()
            if infos~=nil then--已绑定
                local item = infos[1];
                local good = {
                    id = item.cid
                };
                goodsData = GoodsData(good);
                if goodsData==nil then
                    LogError("物品表不存在物品配置："..tostring(item.cid));
                    do return end
                end
                qulaity=goodsData:GetQuality();
                if goodsData:GetType() == ITEM_TYPE.CARD then
                    GridUtil.LoadCIcon(icon, tIcon, goodsData:GetCfg(), true);
                elseif goodsData:GetType() == ITEM_TYPE.CARD_CORE_ELEM then
                    ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                    GridUtil.LoadTIcon(tIcon, tBorder, goodsData:GetCfg(), true);
                elseif goodsData:GetType() == ITEM_TYPE.PanelImg then -- 多人插图,特殊处理
                    local cfg = goodsData:GetCfg();
                    ResUtil.MultiIcon:Load(icon, cfg.itemPicture);
                elseif goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL or goodsData:GetType() == ITEM_TYPE.EQUIP then -- 装备素材
                    -- GridUtil.LoadEquipIcon(icon,tIcon,goodsData:GetCfg(),false,true);
                    GridUtil.LoadEquipIcon(icon, tIcon, goodsData:GetIcon(), goodsData:GetQuality(),
                        goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL, false)
                else
                    -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                    goodsData:GetIconLoader():Load(icon, goodsData:GetIcon());
                end
            else
                this.LoadBorderFrame(icon, data:GetIcon());
            end
        end
    else
        if data:GetType() == RandRewardType.EQUIP then -- 装备
            goodsData = data.goods;
            qulaity = goodsData:GetQuality();
            GridUtil.LoadEquipIcon(icon, tIcon, goodsData:GetIcon(), goodsData:GetQuality(), false, false)
            -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
        elseif data:GetType() == RandRewardType.CARD or data:GetType() == RandRewardType.ITEM then
            local good = {
                id = data:GetID(),
                num = BagMgr:GetCount(data:GetID())
            };
            goodsData = GoodsData(good);
            qulaity = goodsData:GetQuality();
            if goodsData:GetType() == ITEM_TYPE.CARD then
                -- CSAPI.SetScale(border,roleSize,roleSize,roleSize);
                -- CSAPI.SetScale(icon,roleSize,roleSize,roleSize);
                -- RoleTool.AddCardBG(border, goodsData:GetQuality())
                GridUtil.LoadCIcon(icon, tIcon, goodsData:GetCfg());
                -- ResUtil.RoleCard:Load(icon, goodsData:GetIcon());
            elseif goodsData:GetType() == ITEM_TYPE.CARD_CORE_ELEM then
                ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                GridUtil.LoadTIcon(tIcon, tBorder, goodsData:GetCfg(), true);
            elseif goodsData:GetType() == ITEM_TYPE.PanelImg then -- 多人插图,特殊处理
                local cfg = goodsData:GetCfg();
                ResUtil.MultiIcon:Load(icon, cfg.itemPicture);
            elseif goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL or goodsData:GetType() == ITEM_TYPE.EQUIP then -- 装备素材
                -- GridUtil.LoadEquipIcon(icon,tIcon,goodsData:GetCfg(),false,true);
                GridUtil.LoadEquipIcon(icon, tIcon, goodsData:GetIcon(), goodsData:GetQuality(),
                    goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL, false)
            else
                -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                goodsData:GetIconLoader():Load(icon, goodsData:GetIcon());
            end
        end
    end
    CSAPI.SetScale(icon, iSize, iSize, iSize);
    if border then
        this.LoadBorderFrame(qulaity, border);
    end
end

-- 读取边框和图标（商品子物体用）
function this.SetIconBorder2(data, commodityType, border, icon, light, tIcon, tIcon2, tBorder, openSetting)
    local goodsData = nil;
    if border then
        CSAPI.SetGOActive(border, true);
        CSAPI.SetScale(border, normalSize, normalSize, normalSize);
    end
    CSAPI.SetScale(icon, normalSize, normalSize, normalSize);
    local qulaity = data:GetQuality();
    openSetting = openSetting or 1;
    local iName = data:GetIcon();
    if commodityType == 1 then
        if iName ~= nil and iName ~= "" and openSetting == 2 and data:GetType()~=CommodityItemType.ChoiceCard then -- 固定商品有配置图标优先读取
            qulaity = data:GetQuality();
            iSize = 1;
            ResUtil.IconGoods:Load(icon, iName);
        elseif data:GetType() == CommodityItemType.Item then -- 商品类型为1时读取物品表中的icon
            local item = data:GetCommodityList()[1];
            if item == nil or data:GetCommodityList() == nil then
                LogError("读取物品信息时出现错误！商品ID：" .. tostring(data:GetID()));
            end
            local good = {
                id = item.cid
            };
            goodsData = GoodsData(good);
            -- qulaity=goodsData:GetQuality();
            if goodsData:GetType() == ITEM_TYPE.CARD then
                -- CSAPI.SetScale(icon,roleSize,roleSize,roleSize);
                -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                GridUtil.LoadCIcon(icon, tIcon2, goodsData:GetCfg());
            elseif goodsData:GetType() == ITEM_TYPE.CARD_CORE_ELEM then
                ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                GridUtil.LoadTIcon(tIcon2, tBorder, goodsData:GetCfg(), true);
                -- elseif goodsData:GetType()==ITEM_TYPE.PanelImg then--多人插图,特殊处理
                --     local cfg=goodsData:GetCfg();
                --     ResUtil.MultiIcon:Load(icon,cfg.itemPicture);
            elseif goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL or goodsData:GetType() == ITEM_TYPE.EQUIP then -- 装备素材
                GridUtil.LoadEquipIcon(icon, tIcon2, goodsData:GetIcon(), goodsData:GetQuality(),
                    goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL, false)
            else
                -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                goodsData:GetIconLoader():Load(icon, goodsData:GetIcon());
            end
        elseif data:GetType() == CommodityItemType.Package or data:GetType() == CommodityItemType.Deposit or
            data:GetType() == CommodityItemType.MonthCard or data:GetType() == CommodityItemType.SingleSelection or 
            data:GetType() == CommodityItemType.DoubleSelection or data:GetType() == CommodityItemType.SUIT then -- 商品类型为2，4，5, 11, 12, 13时读商店表中的icon
            -- CSAPI.SetGOActive(border,false);
            -- qulaity=data:GetQuality();
            ResUtil.IconGoods:Load(icon, iName);
        elseif data:GetType() == CommodityItemType.FORNITURE or data:GetType() == CommodityItemType.THEME then -- 家具图标
            local item = data:GetCommodityList()[1];
            local good = {
                id = item.cid
            };
            goodsData = GoodsData(good);
            ResUtil.Furniture:Load(icon, goodsData:GetIcon());
            --判断是否可交互的家具
            if goodsData and goodsData:GetDyVal1() then
                local cfg=Cfgs.CfgFurniture:GetByID(goodsData:GetDyVal1());
                if cfg and cfg.inteActionId~=nil then
                    CSAPI.LoadImg(tIcon2,"UIs/Shop/img_11_02.png",true,nil,true);
                end
            end
        elseif data:GetType()==CommodityItemType.ChoiceCard then
            --判断是否绑定了卡牌
            local infos = data:GetCommodityList()
            if infos~=nil then--已绑定
                local item = infos[1];
                local good = {
                    id = item.cid
                };
                goodsData = GoodsData(good);
                if goodsData==nil then
                    LogError("物品表不存在物品配置："..tostring(item.cid));
                    do return end
                end
                -- qulaity=goodsData:GetQuality();
                if goodsData:GetType() == ITEM_TYPE.CARD then
                    -- CSAPI.SetScale(icon,roleSize,roleSize,roleSize);
                    -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                    GridUtil.LoadCIcon(icon, tIcon2, goodsData:GetCfg());
                elseif goodsData:GetType() == ITEM_TYPE.CARD_CORE_ELEM then
                    ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                    GridUtil.LoadTIcon(tIcon2, tBorder, goodsData:GetCfg(), true);
                    -- elseif goodsData:GetType()==ITEM_TYPE.PanelImg then--多人插图,特殊处理
                    --     local cfg=goodsData:GetCfg();
                    --     ResUtil.MultiIcon:Load(icon,cfg.itemPicture);
                elseif goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL or goodsData:GetType() == ITEM_TYPE.EQUIP then -- 装备素材
                    GridUtil.LoadEquipIcon(icon, tIcon2, goodsData:GetIcon(), goodsData:GetQuality(),
                        goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL, false)
                else
                    -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                    goodsData:GetIconLoader():Load(icon, goodsData:GetIcon());
                end
            else
                ResUtil.Commodity:Load(icon, data:GetIcon());
            end
        end
    else
        if data:GetType() == RandRewardType.EQUIP then -- 装备
            goodsData = data.goods;
            qulaity = goodsData:GetQuality();
            -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
            GridUtil.LoadEquipIcon(icon, tIcon2, goodsData:GetIcon(), qulaity, false, false)
        elseif data:GetType() == RandRewardType.CARD or data:GetType() == RandRewardType.ITEM then
            local good = {
                id = data:GetID(),
                num = BagMgr:GetCount(data:GetID())
            };
            goodsData = GoodsData(good);
            qulaity = goodsData:GetQuality();
            if goodsData:GetType() == ITEM_TYPE.CARD then
                -- CSAPI.SetScale(border,roleSize,roleSize,roleSize);
                -- CSAPI.SetScale(icon,roleSize,roleSize,roleSize);
                -- RoleTool.AddCardBG(border, goodsData:GetQuality())
                -- ResUtil.RoleCard:Load(icon, goodsData:GetIcon());
                GridUtil.LoadCIcon(icon, tIcon2, goodsData:GetCfg());
            elseif goodsData:GetType() == ITEM_TYPE.CARD_CORE_ELEM then
                ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                GridUtil.LoadTIcon(tIcon2, tBorder, goodsData:GetCfg(), true);
            elseif goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL or goodsData:GetType() == ITEM_TYPE.EQUIP then -- 装备素材
                -- GridUtil.LoadEquipIcon(icon,tIcon,goodsData:GetCfg(),false,true);
                GridUtil.LoadEquipIcon(icon, tIcon2, goodsData:GetIcon(), goodsData:GetQuality(),
                    goodsData:GetType() == ITEM_TYPE.EQUIP_MATERIAL, false)
                -- elseif goodsData:GetType()==ITEM_TYPE.PanelImg then--多人插图,特殊处理
                --     local cfg=goodsData:GetCfg();
                --     ResUtil.MultiIcon:Load(icon,cfg.itemPicture);
            else
                -- ResUtil.IconGoods:Load(icon, goodsData:GetIcon());
                goodsData:GetIconLoader():Load(icon, goodsData:GetIcon());
            end
        end
    end
    if border then
        ResUtil.Commodity:Load(border, itemQualitys[qulaity]);
    end
    if light then
        ResUtil.Commodity:Load(light, itemQualitys3[qulaity]);
    end
    if tIcon then
        local tIcons = packQualitys2
        ResUtil.Commodity:Load(tIcon, tIcons[qulaity]);
    end
end

function this.LoadBorderFrame(lvQuality, border)
    -- local frame = GridFrame[lvQuality];
    -- ResUtil.IconGoods:Load(border, frame);
    ResUtil:LoadBigImg(border, string.format("UIs/Shop/img_03_0%s", lvQuality or 1), true);
end

--shopPriceKey:消耗货币类型
function this.GetPriceTips(commodity, currNum,shopPriceKey)
    local str = "";
    if commodity == nil then
        return str;
    end
    local priceInfo = commodity:GetRealPrice(shopPriceKey);
    if priceInfo then
        local currPrice = priceInfo[1].num * currNum;
        if priceInfo[1].id == -1 then
            str = LanguageMgr:GetByID(18013) .. currPrice;
        else
            local goldInfo = GoodsData();
            goldInfo:InitCfg(priceInfo[1].id);
            str = currPrice .. goldInfo:GetName();
        end
    end
    return str;
end

-- 设置价格图标 pIconTips:货币的文字符号
function this.SetPriceIcon(moneyIcon, cost)
    if moneyIcon == nil or cost == nil then
        LogError("设置价格图标出错！" .. tostring(moneyIcon == nil) .. "\t" .. tostring(cost == nil));
        return;
    end
    if cost.id == -1 then
        CSAPI.SetGOActive(moneyIcon, false);
    else
        CSAPI.SetGOActive(moneyIcon, true);
        local cfg = Cfgs.ItemInfo:GetByID(cost.id);
        if cfg and cfg.icon then
            ResUtil.IconGoods:Load(moneyIcon, cfg.icon .. "_1");
        else
            LogError("道具商店：读取物品的价格Icon出错！CostInfo:");
            LogError(cost)
        end
    end
end

-- 是否有足够的货币进行支付 shopPriceKey：不传默认判断第一个支付方式是否支持支付
function this.CheckCanPay(commodity, currNum, voucherList,shopPriceKey)
    local canPay = false;
    if commodity == nil then
        return canPay;
    end
    local priceInfo = commodity:GetRealPrice(shopPriceKey);
    if priceInfo then
        local currPrice = priceInfo[1].num * currNum;
        if voucherList ~= nil then -- 计算扣除折扣券之后的值
            local isOk, tips, res = GLogicCheck:IsCanUseVoucher(commodity:GetCfg(), voucherList, TimeUtil:GetTime(), 1,
                PlayerClient:GetLv(),nil,shopPriceKey);
            if isOk and res ~= nil then
                currPrice = res[1][2];
            end
        end
        if priceInfo[1].id == ITEM_ID.GOLD or priceInfo[1].id == ITEM_ID.DIAMOND or priceInfo[1].id == g_AbilityCoinId or
            priceInfo[1].id == g_ArmyCoinId then
            canPay = PlayerClient:GetCoin(priceInfo[1].id) >= currPrice;
        elseif priceInfo[1].id == -1 then
            canPay = true;
        else
            local count = BagMgr:GetCount(priceInfo[1].id);
            canPay = count >= currPrice;
        end
    else -- 没有价格等于免费
        return true;
    end
    return canPay;
end

-- 购买道具 --useCost:扣费方式price_1/price_2:用于家具商店判断支付道具 payType:对应payType枚举 isIntall:是否安装对应的app客户端 shopPriceKey:普通道具的价格枚举
function this.BuyCommodity(commodity, currNum, callBack, useCost, payType, isInstall, voucherList,shopPriceKey)
    if commodity == nil then
        do
            return
        end
    end
    local canPay = this.CheckCanPay(commodity, currNum, voucherList,shopPriceKey);
    if commodity:GetType() == CommodityItemType.MonthCard then -- 月卡,判断剩余时间是否可以续费
        local curDays=0;
        if commodity:GetSubType()==CommodityItemSubType.MonthCard then
            curDays=ShopMgr:GetMonthCardDays();
        else
            local info=commodity:GetMonthCardInfo();
            curDays=info and info.l_cnt or 0;
        end
        local limitDays = commodity:GetResetValue();
        if curDays > limitDays then -- 月卡大于限制天数则无法购买
            local langId=commodity:GetSubType()==CommodityItemSubType.MonthCard and 15108 or 15128;
            Tips.ShowTips(LanguageMgr:GetTips(langId));
            do
                return
            end
        end
    end
    if canPay then
        if CSAPI.IsDomestic() then            
            -- 添加弹窗
            local priceInfo=commodity:GetRealPrice(shopPriceKey);
            if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then --弹窗确认
                local good=BagMgr:GetFakeData(priceInfo[1].id);
                local rNum=priceInfo[1].num;
                local isOk,tips,res=GLogicCheck:IsCanUseVoucher(commodity:GetCfg(),voucherList,TimeUtil:GetTime(),currNum,PlayerClient:GetLv(),nil,shopPriceKey);
                if isOk and res  then
                    rNum=res[1][2];
                end
                local dialogData = {
                    content = LanguageMgr:GetTips(15123,good:GetName(),rNum*currNum),
                    okCallBack = function()
                        this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall, voucherList,shopPriceKey)
                    end
                }
                CSAPI.OpenView("Dialog", dialogData);
            else
                this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall, voucherList,shopPriceKey)
            end
            -- this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall, voucherList,shopPriceKey)
        elseif CSAPI.IsADV() then
            ---海外------------------------
            local priceInfo=commodity:GetRealPrice(shopPriceKey);
            Log("-------------------canPay------------priceInfo--------"..table.tostring(priceInfo))
            if priceInfo and priceInfo[1].id==-1 then --使用SDK调用支付
                SDKPayMgr:SetLastPayInfo(nil,nil);
                if SDKPayMgr:GetIsPaying()  then --目前只针对IOS进行拦截
                    Log("正在处理支付中...");
                    do return end;
                end
                local priceInfo2=commodity:GetPrice(shopPriceKey);
                if CSAPI.Currentplatform == CSAPI.Android or CSAPI.Currentplatform == CSAPI.IPhonePlayer or CSAPI.Currentplatform == CSAPI.OpenHarmony then
                    EventMgr.Dispatch(EventType.Shop_Buy_Mask,true);
                else
                    print("-----PC-----IsGetIsMobileplatform")
                end

                --LogError(commodity)
                print("commodity---------------------"..table.tostring(commodity))
                local AdvpriceInfo=commodity:GetPrice(shopPriceKey);
                local Advcommodityprice=AdvpriceInfo[1].num*100;---单位元
                local SDKamount=commodity["cfg"]["amount"];---单位分
                ---如果没有这个字段，那么传表数据给服务端
                if SDKamount==nil  then
                    SDKamount=Advcommodityprice;
                elseif tostring(SDKamount)==tostring(0) and tostring(SDKamount)~=tostring(Advcommodityprice) then
                    SDKamount=Advcommodityprice;
                    LogError("存在定价表数据异常："..table.tostring(commodity,true))
                elseif tostring(SDKamount)~=tostring(Advcommodityprice) then
                    SDKamount=Advcommodityprice;
                    LogError("配置表和SDK存在定价表数据异常："..table.tostring(commodity,true))
                end
                Log("商品价格分："..Advcommodityprice)
                ClientProto:QueryPrePay(commodity:GetID(),SDKamount,function(proto)
                    if tostring(proto["productId"])==tostring(commodity:GetID()) then
                        SDKPayMgr:GenOrderID(commodity,payType,isInstall,shopPriceKey,function(Backresult)
                            Log("GenOrderID data back："..table.tostring(Backresult));
                            local result={};
                            --LogError(Backresult)
                            print("GenOrderID  Backresult---------------------"..table.tostring(commodity))
                            result.is_ok=Backresult["is_ok"];
                            result.msg=Backresult["msg"];
                            result.id=Backresult["id"];
                            result.inc_id=Backresult["inc_id"];
                            result.key_id=Backresult["key_id"];
                            result.rand_key=Backresult["rand_key"];
                            -- LogError(result)
                            if result and (result.msg~=nil and result.is_ok==false) then
                                LogError("获取订单ID时出现错误！信息："..tostring(result.msg))
                                if payType and payType==PayType.ZiLongGitPay and tostring(commodity:GetID())==tostring(30033) then
                                    if commodity:GetName() then
                                        LanguageMgr:ShowTips(1046,commodity:GetName())
                                    end
                                else
                                    Tips.ShowTips(LanguageMgr:GetTips(1011));
                                end
                                EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
                                do return end;
                            elseif result==nil or (result and (result.id==nil or result.id=="")) then
                                LogError("获取订单ID返回为nil！")
                                if payType and payType==PayType.ZiLongGitPay and tostring(commodity:GetID())==tostring(30033) then
                                    if commodity:GetName() then
                                        LanguageMgr:ShowTips(1046,commodity:GetName())
                                    end
                                else
                                    Tips.ShowTips(LanguageMgr:GetTips(1011));
                                end
                                EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
                                do return end;
                            end
                            --LogError("result.id:"..result.id)
                            SDKPayMgr:SetLastPayInfo(result.inc_id,PayType.ZiLong);
                            ---is_ok
                            ---id  游戏订单
                            ---key_id
                            ---rand_key
                            ---msg
                            local payData=
                            {
                                skuCode=tostring(commodity:GetID()),---商品id
                            gameOrderId=result.id,---游戏订单号
                                --amount=commodity["cfg"]["amount"],---定价价格（单位分）      ------
                                --amount=commodity["cfg"]["amount"] or AdvpriceInfo[1].num*100;---定价价格（单位分）      ------
                                amount=Advcommodityprice;---定价价格（单位分）      ------
                                currency=commodity["cfg"]["displayCurrency"],---定价币种   -----
                                productName=commodity:GetName(),---商品名称
                                productDesc=commodity["data"]["sDesc"],---商品描述         -----
                                --- gameExt=commodity["cfg"]["goodsId"],---游戏传入自定义参数
                                gameExt=Json.encode(Backresult);---游戏传入自定义参数
                            }
                            if payData.productDesc==nil then
                                payData.productDesc="";
                            end
                            payData.currency=RegionalSet.RegionalCurrencyType();
                            print("GenOrderID  Backresult-----payData---------------"..table.tostring(payData))
                            if payType~=nil and payType==10 then
                                Log("--------------抵扣券抵扣--------------")
                                if CSAPI.RegionalCode()==3 then
                                    ShiryuSDK.SetPayLimitLevel(CSAPI.JPGetTypelimit());
                                end
                                ---抵扣券接口
                                ShiryuSDK.PayPoints(payData,function(success,voucherNum)
                                    Log("---------------ShiryuSDK.PayPoints Back---------------")
                                    EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
                                    if success then
                                        AdvDeductionvoucher.SDKvoucherNum=voucherNum;
                                        AdvDeductionvoucher.QueryPoints(function() CSAPI.DispatchEvent(EventType.Shop_View_Refresh) end);
                                        CSAPI.DispatchEvent(EventType.SDK_Deduction_voucher_paymentcompleted)
                                        SDKPayMgr:SearchPayReward(true);
                                        if callBack then callBack(); end
                                    else
                                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                                    end
                                end)
                            elseif payType~=nil and payType==11 then
                                ShiryuSDK.ClaimGift(payData,function(success,BackJson)
                                    Log("---------------ShiryuSDK.ClaimGift Back---------------:")
                                    EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
                                    if success then
                                        Log("---------------ShiryuSDK.ClaimGift successful---------------:")
                                        SDKPayMgr:SearchPayReward(true);
                                        if callBack then callBack(); end
                                    else
                                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                                    end
                                end)
                            else
                                ---正常支付接口
                                if CSAPI.RegionalCode()==3 then
                                    ShiryuSDK.SetPayLimitLevel(CSAPI.JPGetTypelimit());
                                end
                                CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Pay,payData)
                            end
                        end);
                    else
                        LogError("返回订单号异常："..table.tostring(proto))
                    end
                end);
            else --正常购买
                Log("-------------------canPay--------正常购买------------")
                if CSAPI.IsADVRegional(3) then
                    if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then --弹窗确认
                        print("--------------------BuyCommodity----------------------------")
                        CSAPI.ADVJPTitle(priceInfo[1].num*currNum,function() ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum,useCost,nil,shopPriceKey, callBack); end)
                    else
                        ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum,useCost,nil,shopPriceKey, callBack);
                    end
                else
                    ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum,useCost,nil,shopPriceKey, callBack);
                end
            end
        else
            ---国内--------------------------
            -- 判断支付类型
            local priceInfo = commodity:GetRealPrice(shopPriceKey);
            if priceInfo and priceInfo[1].id == -1 then -- 使用SDK调用支付
                if payType == nil then
                    payType = this.GetChannelPayType();
                end
                -- LogError("PayType:"..tostring(payType))
                local priceInfo2 = commodity:GetPrice(shopPriceKey);
                if SDKPayMgr:GetIsPaying() and payType == PayType.IOS then -- 目前只针对IOS进行拦截
                    LogError("正在处理支付中...");
                    do
                        return
                    end
                end
                EventMgr.Dispatch(EventType.Shop_Buy_Mask, true);
                SDKPayMgr:GenOrderID(commodity, payType, isInstall,shopPriceKey, function(result)
                    -- local result={
                    --     isOk=true,
                    --     id="1",
                    -- };
                    if result and (result.err ~= nil or result.isOk ~= true) then
                        LogError("获取订单ID时出现错误！信息：" .. tostring(result.err))
                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    elseif result == nil or (result and (result.id == nil or result.id == "")) then
                        LogError("获取订单ID返回为nil！")
                        Tips.ShowTips(LanguageMgr:GetTips(1011));
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    end
                    local data = ShopCommFunc.GetChannelData(commodity, result, payType,shopPriceKey);
                    -- LogError("申请订单ID数据：")
                    -- LogError(result);
                    -- LogError("下单数据：")
                    -- LogError(data)
                    if data == nil then
                        LogError("下单数据错误，停止下单：")
                        LogError(data)
                        EventMgr.Dispatch(EventType.Shop_Buy_Mask, false);
                        do
                            return
                        end
                    end
                    -- 发送数据，状态为未支付
                    local record = {
                        goods_id = tostring(commodity:GetID()), -- 商品ID
                        goods_name = commodity:GetName(), -- 商品名
                        channel_name = CSAPI.GetChannelName(), -- 渠道名
                        pay_result = "未支付", -- 支付状态
                        pay_tips = "已下单", -- 付费流程
                        goods_num = currNum, -- 数量
                        cost_type = "人民币", -- 币种
                        price = priceInfo2[1].num, -- 原价格
                        pay_price = priceInfo[1].num, -- 实付价格
                        pay_channel = PayTypeName[payType], -- 支付渠道
                        create_time = TimeUtil.GetTime(), -- 创建时间
                        order_id = GCardCalculator:GetPayOrderStrId(result.id, payType, channelType), -- 后台订单ID
                        sdk_order_id = data.out_trade_no or "", -- sdk交易订单ID
                        send_time = TimeUtil.GetTime()
                    }
                    -- LogError("上传数数内容：")
                    -- LogError(record)
                    BuryingPointMgr:TrackEvents("store_pay", record);
                    if payType == PayType.AlipayQR or payType == PayType.WeChatQR then
                        EventMgr.Dispatch(EventType.SDK_Pay_QRURL, data.code_url)
                    elseif payType == PayType.BsAli then
                        if data.is_install and data.is_install == "1" then -- H5
                            -- 打开浏览器页面
                            CSAPI.JumpUri(data.code_url);
                        else -- 二维码
                            EventMgr.Dispatch(EventType.SDK_Pay_QRURL, data.code_url)
                        end
                    else
                        SDKPayMgr:SetIsPaying(true);
                        EventMgr.Dispatch(EventType.SDK_Pay, data, true);
                    end
                end);
            else -- 正常购买
                if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then --弹窗确认
                    local good=BagMgr:GetFakeData(priceInfo[1].id);
                    local rNum=priceInfo[1].num;
                    local isOk,tips,res=GLogicCheck:IsCanUseVoucher(commodity:GetCfg(),voucherList,TimeUtil:GetTime(),currNum,PlayerClient:GetLv(),nil,shopPriceKey);
                    if isOk and res  then
                        rNum=res[1][2];
                    end
                    local dialogData = {
                        content = LanguageMgr:GetTips(15123,good:GetName(),rNum*currNum),
                        okCallBack = function()
                            ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList,shopPriceKey, callBack);
                        end
                    }
                    CSAPI.OpenView("Dialog", dialogData);
                else
                    ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum, useCost, voucherList,shopPriceKey, callBack);
                end
            end
        end
    else
        local goods = GoodsData();
        local price = commodity:GetRealPrice(shopPriceKey)[1];
        goods:InitCfg(price.id);
        Tips.ShowTips(string.format(LanguageMgr:GetTips(15000), goods:GetName()));
    end
end

function this.BuyCommodity_Domestic(commodity, currNum, callBack, useCost, payType, isInstall, voucherList,shopPriceKey)

            ---海外------------------------
            local priceInfo=commodity:GetRealPrice(shopPriceKey);
            Log("-------------------canPay------------priceInfo--------"..table.tostring(priceInfo))
            if priceInfo and priceInfo[1].id==-1 then --使用SDK调用支付
                SDKPayMgr:SetLastPayInfo(nil,nil);
                if SDKPayMgr:GetIsPaying()  then --目前只针对IOS进行拦截
                    Log("正在处理支付中...");
                    do return end;
                end
                local priceInfo2=commodity:GetPrice(shopPriceKey);
                ---2024-09-14 中台SDK 重合 要求去掉游戏加载圈
                if CSAPI.Currentplatform == CSAPI.Android or CSAPI.Currentplatform == CSAPI.IPhonePlayer or (CSAPI.OpenHarmony ~= nil and CSAPI.Currentplatform == CSAPI.OpenHarmony) then
                    EventMgr.Dispatch(EventType.Shop_Buy_Mask,true);
                else
                   print("-----PC-----IsGetIsMobileplatform")
                end

                print("commodity---------------------"..table.tostring(commodity))

                local AdvpriceInfo=commodity:GetPrice(shopPriceKey);
                local Advcommodityprice=AdvpriceInfo[1].num*100;---单位元
                local SDKamount=commodity["cfg"]["amount"];---单位分
                ---如果没有这个字段，那么传表数据给服务端
                if SDKamount==nil  then
                    SDKamount=Advcommodityprice;
                elseif tostring(SDKamount)==tostring(0) and tostring(SDKamount)~=tostring(Advcommodityprice) then
                    SDKamount=Advcommodityprice;
                    LogError("存在定价表数据异常："..table.tostring(commodity,true))
                elseif tostring(SDKamount)~=tostring(Advcommodityprice) then
                    SDKamount=Advcommodityprice;
                    LogError("配置表和SDK存在定价表数据异常："..table.tostring(commodity,true))
                end
                Log("商品价格分："..Advcommodityprice)
                ClientProto:QueryPrePay(commodity:GetID(),SDKamount,function(proto)
                    if tostring(proto["productId"])==tostring(commodity:GetID()) then
                        SDKPayMgr:GenOrderID(commodity,payType,isInstall,shopPriceKey,function(Backresult)
                            Log("GenOrderID data back："..table.tostring(Backresult));
                            local result={};
                            print("GenOrderID  Backresult---------------------"..table.tostring(commodity))
                            result.is_ok=Backresult["is_ok"];
                            result.msg=Backresult["msg"];
                            result.id=Backresult["id"];
                            -- 订单ID
                            result.inc_id=Backresult["inc_id"];
                            result.key_id=Backresult["key_id"];
                            result.rand_key=Backresult["rand_key"];
                            -- LogError(result)
                            if result and (result.msg~=nil and result.is_ok==false) then
                                LogError("获取订单ID时出现错误！信息："..tostring(result.msg))                                
                                Tips.ShowTips(LanguageMgr:GetTips(1011));
                                EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
                                do return end;
                            elseif result==nil or (result and (result.id==nil or result.id=="")) then
                                LogError("获取订单ID返回为nil！")
                                Tips.ShowTips(LanguageMgr:GetTips(1011));
                                EventMgr.Dispatch(EventType.Shop_Buy_Mask,false);
                                do return end;
                            end
                            --LogError("result.id:"..result.id)
                            SDKPayMgr:SetLastPayInfo(result.inc_id,PayType.CenterWeb);

                            local AdvpriceInfo=commodity:GetPrice(shopPriceKey);
                            local payData=
                            {
                                skuCode=tostring(commodity:GetID()),---商品id
                                gameOrderId=result.id,---游戏订单号
                                --amount=commodity["cfg"]["amount"],---定价价格（单位分）      ------
                                amount=Advcommodityprice;---定价价格（单位分）      ------
                                currency=commodity["cfg"]["displayCurrency"],---定价币种   -----
                                productName=commodity:GetName(),---商品名称
                                productDesc=commodity["data"]["sDesc"],---商品描述         -----
                                --- gameExt=commodity["cfg"]["goodsId"],---游戏传入自定义参数
                                gameExt=Json.encode(Backresult);---游戏传入自定义参数
                            }
                            -- LogError("productName = " .. payData.productName .. "   productDesc = " .. payData.productDesc .. "   amount = " .. payData.amount)
                            if payData.productDesc==nil then
                                payData.productDesc="";
                            end
                            -- 中台要求此处写死
                            payData.currency="CNY";
                            print("GenOrderID  Backresult-----payData---------------"..table.tostring(payData))                            
                            ---正常支付接口
                            CSAPI.DispatchEvent(EventType.SDK_ShiryuSDK_Pay,payData)
                        end);
                    else
                        LogError("返回订单号异常："..table.tostring(proto))
                    end
                end);
            else --正常购买
                Log("-------------------canPay--------正常购买------------")
                ShopProto:Buy(commodity:GetCfgID(), TimeUtil:GetTime(), currNum,useCost,nil,shopPriceKey, callBack);
            end
end

-- 返回非官方渠道的支付类型
function this.GetChannelPayType()
    if channelType == ChannelType.QOO then
        return PayType.Qoo;
    elseif channelType == ChannelType.BliBli then
        return PayType.BiliBili;
    end
end

-- 返回支付的数据
function this.GetChannelData(commodity, result, payType,shopPriceKey)
    local t = nil;
    if payType == PayType.BiliBili then
        local userInfo = PlayerClient:GetSDKUserInfo();
        local total_fee = commodity:GetRealPrice(shopPriceKey)[1].num * 100;
        local item = commodity:GetCommodityList()[1];
        local game_money = "1";
        local out_trade_no = result.out_trade_no;
        local subject = tostring(commodity:GetName());
        -- local body = commodity:GetDesc();
        local body="";
        local serverInfo = ChannelWebUtil.GetServerInfo();
        local extension_info = string.format("server_id=%s", serverInfo.id);
        t = {
            uid = userInfo.uid,
            username = userInfo.name,
            role = PlayerClient:GetName(),
            serverId = result.serverId,
            total_fee = tonumber(total_fee),
            game_money = game_money,
            out_trade_no = out_trade_no,
            subject = subject,
            body = body,
            extension_info = extension_info,
            notify_url = result.notify_url,
            order_sign = result.order_sign,
            productId = commodity:GetID(),
            orderId = result.id
        };
    elseif payType == PayType.Qoo then
        t = {
            productId = commodity:GetID(),
            cpOrderId = result.id,
            developerPayload = Json.encode({
                uid = PlayerClient:GetID(),
                account = PlayerClient:GetAccount(),
                server_id = tostring(ChannelWebUtil.GetServerID()),
                channel = tostring(channelType)
            })
        };
    elseif payType == PayType.Alipay then
        t = {
            sdkType = payType,
            cpOrderId = result.id,
            orderInfo = result.orderStr
        };
    elseif payType == PayType.WeChat then
        t = {
            sdkType = payType,
            cpOrderId = result.id,
            packageValue = "Sign=WXPay",
            perpayId = result.prepay_id,
            nonceStr = result.nonceStr,
            timeStamp = result.timeStamp,
            out_trade_no = result.out_trade_no,
            sign = result.sign
        };
    elseif payType == PayType.IOS then
        t = {
            productId = tostring(commodity:GetID()),
            cpOrderId = tostring(result.id),
            storeProductId = tostring(commodity:GetChargeID()),
            out_trade_no = tostring(result.out_trade_no),
            uid = PlayerClient:GetID(),
            account = PlayerClient:GetAccount(),
            server_id = tostring(ChannelWebUtil.GetServerID()),
            channel = tostring(channelType),
            pay_type = tostring(PayType.IOS),
            create_time = TimeUtil.GetTime() -- 创建时间
        };
    elseif payType == PayType.AlipayQR or payType == PayType.WeChatQR then
        t = {
            code_url = result.code_url,
            payType = tostring(payType)
        }
    elseif payType == PayType.BsAli then -- 聚合正扫
        t = {
            code_url = result.code_url,
            payType = tostring(payType),
            is_install = result.is_install
        }
    end
    return t;
end

-- 兑换道具
function this.ExchangeCommodity(commodity, currNum, callBack)
    if commodity == nil then
        return
    end
    local canPay = this.CheckCanPay(commodity, currNum);
    if canPay then
        if CSAPI.IsADVRegional(3) then
            -- 兑换商店的ID
            local priceInfo=commodity:GetRealPrice();
            if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then --弹窗确认
                print("--------------------ExchangeCommodity----------------------------")
                CSAPI.ADVJPTitle(priceInfo[1].num*currNum,function() ShopProto:Exchange(commodity:GetShopID(), commodity:GetExchangeIndex(), commodity:GetID(), currNum, callBack); end)
            else
                ShopProto:Exchange(commodity:GetShopID(), commodity:GetExchangeIndex(), commodity:GetID(), currNum, callBack);
            end
        else
            -- 兑换商店的ID
            local priceInfo=commodity:GetRealPrice();
            if priceInfo and priceInfo[1].id == ITEM_ID.DIAMOND then --弹窗确认
                local good=BagMgr:GetFakeData(priceInfo[1].id);
                local dialogData = {
                    content = LanguageMgr:GetTips(15123,good:GetName(),priceInfo[1].num*currNum),
                    okCallBack = function()
                        ShopProto:Exchange(commodity:GetShopID(), commodity:GetExchangeIndex(), commodity:GetID(), currNum, callBack);
                    end
                }
                CSAPI.OpenView("Dialog", dialogData);
            else
                ShopProto:Exchange(commodity:GetShopID(), commodity:GetExchangeIndex(), commodity:GetID(), currNum, callBack);
            end
        end
    else
        local goods = GoodsData();
        local price = commodity:GetRealPrice()[1];
        goods:InitCfg(price.id);
        Tips.ShowTips(string.format(LanguageMgr:GetTips(15000), goods:GetName()));
    end
end

-- 显示奖励面板
function this.ShowRewardPanel(commodity, currentNum)
    local rewards = {};
    currentNum = currentNum or 1;
    -- 奖励列表中剔除物品类型为10的道具信息
    local goods = commodity:GetCommodityList();
    for k, v in ipairs(goods) do
        local rewardInfo = {};
        rewardInfo.id = v.cid;
        rewardInfo.num = currentNum * v.num;
        local type = v.type == nil and 2 or v.type; -- 不填或者为空默认为道具类型
        rewardInfo.type = type;
        if v.type == 2 then
            local cfg = Cfgs.ItemInfo:GetByID(v.cid);
            if cfg and cfg.type == ITEM_TYPE.PROP then
            else
                table.insert(rewards, rewardInfo);
            end
        else
            table.insert(rewards, rewardInfo);
        end
    end
    if rewards and #rewards > 0 then
        UIUtil:OpenReward({rewards})
    end
end

-- 是否需要记录第一次打开时的刷新信息
function this.IsRecordRefreshInfo(shopId)
    this.firstRecord = this.firstRecord or {};
    if this.firstRecord[shopId] ~= nil then
        return false
    else
        this.firstRecord[shopId] = shopId
    end
    return true
end

-- 检查固定商品页面是否需要刷新 isUpdate:是否重置列表，isRefresh：某个商品是否需要刷新
function this.IsRefreshCommodityInfos(datas, nowTime)
    local isUpdate = false
    local isRefresh = false;
    this.starBuyList = this.starBuyList or {};
    this.endBuyList = this.endBuyList or {};
    if datas and nowTime then
        for k, v in ipairs(datas) do
            -- local beginTime=this.beginTime or 0;
            -- local endTime=this.endTime or 0;
            local beginTime = v:GetBuyStartTime();
            local endTime = v:GetBuyEndTime();
            -- if (nowTime >= v:GetResetTime() and v:GetResetTime() ~= 0) or
            --     (endTime > 0 and beginTime > 0 and nowTime >= beginTime and nowTime <= endTime) or
            --     (endTime == 0 and beginTime > 0 and nowTime >= beginTime) or (endTime > 0 and nowTime >= endTime) then 
            -- 检查商品重置
            if (v:GetResetType() ~= 0 and nowTime >= v:GetResetTime() and v:GetResetTime() ~= 0) then -- 检查商品重置
                -- Log( "道具重置啦！")
                -- LogError(v:GetResetTime().."\t"..v:GetID().."\t"..v:GetName().."\t"..v:GetResetType().."\t"..nowTime);
                isUpdate = true
                break
            elseif (endTime == 0 or nowTime < endTime) and (beginTime > 0 and nowTime >= beginTime and
                (this.starBuyList[v:GetID()] == nil or
                    (this.starBuyList[v:GetID()] and beginTime ~= this.starBuyList[v:GetID()]))) then -- 检查是否可以购买
                -- LogError(endTime.."\t"..v:GetID().."\t"..v:GetName().."\t"..v:GetResetType().."\t"..nowTime);
                this.starBuyList[v:GetID()] = beginTime;
                isRefresh = true;
            elseif (endTime > 0 and nowTime >= endTime and
                (this.endBuyList[v:GetID()] == nil or
                    (this.endBuyList[v:GetID()] and endTime ~= this.endBuyList[v:GetID()]))) then
                this.endBuyList[v:GetID()] = endTime;
                isRefresh = true;
            end
            -- if v:GetID()==50003 or v:GetID()==50005 then
            --     LogError(v:GetName().."\t"..tostring(isRefresh).."\t开始时间："..beginTime.."\t当前时间："..nowTime.."\t是否大于购买时间："..tostring(nowTime>=beginTime).."\t停止购买时间："..tostring(endTime).."\t是否小于停止购买时间："..tostring(nowTime<endTime).."\t是否大于停止购买时间："..tostring(nowTime>=endTime));
            -- end
        end
    end
    return isUpdate, isRefresh;
end

-- 打开商品购买窗口，commodityID必须为固定商品ID isForce：强制开启
function this.OpenPayView2(commodityID, callBack, isForce)
    local commodity = ShopMgr:GetFixedCommodity(commodityID);
    if commodity then
        local pageData = ShopMgr:GetPageByID(commodity:GetShopID());
        if pageData == nil then
            LogError("未找到对应商品页信息!");
            do return end
        end
        this.OpenPayView(commodity, pageData, callBack, isForce);
    end
end

-- 打开购买窗口
function this.OpenPayView(commodityData, pageData, callBack, isForce)
    local commodityType = pageData:GetCommodityType();
    if commodityData:GetType() == CommodityItemType.Deposit and
        (commodityData:GetNum() >= 1 or commodityData:GetNum() == -1 or isForce == true) then -- 充值
        if commodityData:GetType() == CommodityItemType.MonthCard then -- 月卡
            CSAPI.OpenView("ShopPackPayView", {
                commodity = commodityData,
                pageData = pageData,
                callBack = callBack
            });
        else -- 其它，直接调用支付
            this.HandlePayLogic(commodityData, 1, commodityType,nil, callBack);
        end
    elseif commodityData:GetType() == CommodityItemType.FORNITURE and
        (commodityData:GetNum() >= 1 or commodityData:GetNum() == -1 or isForce == true) then -- 家具商品
        local good = commodityData:GetCommodityList()[1];
        CSAPI.OpenView("DormFurniturePayView", {
            id = good.data:GetDyVal1(),
            commId = commodityData:GetID()
        }, 2)
    elseif commodityData:GetType() == CommodityItemType.THEME and
        (commodityData:GetNum() >= 1 or commodityData:GetNum() == -1 or isForce == true) then -- 主题商品
        local good = commodityData:GetCommodityList()[1];
        CSAPI.OpenView("DormThemePayView", {
            id = good.data:GetDyVal1(),
            commId = commodityData:GetID()
        }, 2)
    elseif commodityData:GetNum() >= 1 or commodityData:GetNum() == -1 or isForce == true or (commodityData:GetType()==CommodityItemType.MonthCard and commodityData:GetSubType()==CommodityItemSubType.MonthCard2) then -- :-1代表不限制
        if commodityType == 1 then
            if commodityData:HasOtherPrice(ShopPriceKey.jCosts1) then
                CSAPI.OpenView("ShopMultPayView", {
                    commodity = commodityData,
                    pageData = pageData,
                    callBack = callBack
                });
            elseif commodityData:GetType() == CommodityItemType.Package or commodityData:GetType() ==
            CommodityItemType.MonthCard or commodityData:GetType() == CommodityItemType.Regression then
                CSAPI.OpenView("ShopPackPayView", {
                    commodity = commodityData,
                    pageData = pageData,
                    callBack = callBack
                });
            else
                CSAPI.OpenView("ShopPayView", {
                    commodity = commodityData,
                    pageData = pageData,
                    callBack = callBack
                });
            end       
        else
            if commodityData:HasOtherPrice(ShopPriceKey.jCosts1) then
                CSAPI.OpenView("ShopMultPayView", {
                    commodity = commodityData,
                    pageData = pageData,
                    callBack = callBack
                });
            else
                CSAPI.OpenView("ShopPayView", {
                    commodity = commodityData,
                    pageData = pageData,
                    callBack = callBack
                });
            end
        end
    end
end

-- 处理购买/兑换逻辑
function this.HandlePayLogic(commodity, num, commodityType, voucherList, func,shopPriceKey)
    if commodity and commodity:GetType() == CommodityItemType.MonthCard then -- 月卡,判断剩余时间是否可以续费
        local curDays=0;
        if commodity:GetSubType()==CommodityItemSubType.MonthCard then
            curDays=ShopMgr:GetMonthCardDays();
        else
            local info=commodity:GetMonthCardInfo();
            curDays=info and info.l_cnt or 0;
        end
        local limitDays = commodity:GetResetValue();
        if curDays > limitDays then -- 月卡大于限制天数则无法购买
            local langId=commodity:GetSubType()==CommodityItemSubType.MonthCard and 15108 or 15128;
            Tips.ShowTips(LanguageMgr:GetTips(langId));
            do
                return
            end
        end
    end

    local priceInfo = commodity:GetRealPrice(shopPriceKey);
    -- 调用支付渠道选择
    if priceInfo and priceInfo[1].id == -1 and CSAPI.IsDomestic()then
        if commodityType == 1 then -- 购买道具
            ShopCommFunc.BuyCommodity(commodity, num, func, nil,nil,nil,nil,shopPriceKey);
        elseif commodityType == 2 then -- 兑换随机物品
            ShopCommFunc.ExchangeCommodity(commodity, num, func, nil);
        end
    elseif priceInfo and priceInfo[1].id == -1 and (channelType == ChannelType.Normal or channelType == ChannelType.TapTap) then
        if CSAPI.GetPlatform() == 8 then -- IOS
            if commodityType == 1 then -- 购买道具
                ShopCommFunc.BuyCommodity(commodity, num, func, nil, PayType.IOS,nil,nil,shopPriceKey);
            elseif commodityType == 2 then -- 兑换随机物品
                ShopCommFunc.ExchangeCommodity(commodity, num, func, nil, PayType.IOS);
            end
        else
            CSAPI.OpenView("SDKPaySelect", {
                commodity = commodity,
                num = num,
                shopPriceKey=shopPriceKey,
                func = func
            });
        end
    elseif priceInfo and priceInfo[1].id==-1 and CSAPI.IsADV() and AdvDeductionvoucher.SDKvoucherNum>=priceInfo[1].num then
        CSAPI.OpenView("SDKPaySelect",{commodity=commodity,num=num,shopPriceKey=shopPriceKey,func=func});
    else
        if commodityType == 1 then -- 购买道具
            ShopCommFunc.BuyCommodity(commodity, num, func, nil, nil, nil, voucherList,shopPriceKey);
        elseif commodityType == 2 then -- 兑换随机物品
            ShopCommFunc.ExchangeCommodity(commodity, num, func);
        end
    end
end


---处理购买/兑换逻辑 海外
function this.AdvHandlePayLogic(commodity,num,commodityType,func,payType,Isdisplay,voucherList,shopPriceKey)
    if commodity and commodity:GetType() == CommodityItemType.MonthCard then -- 月卡,判断剩余时间是否可以续费
        local curDays=0;
        if commodity:GetSubType()==CommodityItemSubType.MonthCard then
            curDays=ShopMgr:GetMonthCardDays();
        else
            local info=commodity:GetMonthCardInfo();
            curDays=info and info.l_cnt or 0;
        end
        local limitDays = commodity:GetResetValue();
        if curDays > limitDays then -- 月卡大于限制天数则无法购买
            local langId=commodity:GetSubType()==CommodityItemSubType.MonthCard and 15108 or 15128;
            Tips.ShowTips(LanguageMgr:GetTips(langId));
            do
                return
            end
        end
    end
    local priceInfo=commodity:GetRealPrice(shopPriceKey);
    --调用支付渠道选择
    print("channelType:"..channelType)
    if priceInfo and priceInfo[1].id==-1 and (channelType==ChannelType.Normal or channelType==ChannelType.TapTap) then
        if CSAPI.GetPlatform()==8 then--IOS
            if commodityType==1 then --购买道具
                ShopCommFunc.BuyCommodity(commodity,num,func,nil,PayType.IOS,nil,nil,shopPriceKey);
            elseif commodityType==2 then  --兑换随机物品
                ShopCommFunc.ExchangeCommodity(commodity,num,func,nil,PayType.IOS);
            end
        else
            CSAPI.OpenView("SDKPaySelect",{commodity=commodity,shopPriceKey=shopPriceKey,num=num,func=func});
        end
    elseif priceInfo and priceInfo[1].id==-1 and CSAPI.IsADV() and AdvDeductionvoucher.SDKvoucherNum>=priceInfo[1].num and Isdisplay then
        CSAPI.OpenView("SDKPaySelect",{commodity=commodity,shopPriceKey=shopPriceKey,num=num,func=func});
    else
        if commodityType==1 then --购买道具
            ShopCommFunc.BuyCommodity(commodity,num,func,nil,payType,nil,voucherList,shopPriceKey);
        elseif commodityType==2 then  --兑换随机物品
            ShopCommFunc.ExchangeCommodity(commodity,num,func);
        end
    end
end

-- 是否在时间范围内
function this.TimeIsBetween(startTime, endTime, currentTime)
    if currentTime == nil then
        currentTime = TimeUtil:GetTime();
    end
    local sTime = startTime == nil and 0 or TimeUtil:GetTimeStampBySplit(startTime);
    local eTime = endTime == nil and 0 or TimeUtil:GetTimeStampBySplit(endTime);
    if (sTime == 0 or currentTime >= sTime) and (eTime == 0 or currentTime < eTime) then
        return true;
    end
    return false;
end

-- 是否在时间范围内
function this.TimeIsBetween2(startTime, endTime, currentTime)
    if currentTime == nil then
        currentTime = TimeUtil:GetTime();
    end
    if (startTime == 0 or currentTime >= startTime) and (endTime == 0 or currentTime < endTime) then
        return true;
    end
    return false;
end

-- 返回商品中包含的皮肤信息
function this.GetSkinInfo(commodity,key)
    local skinInfo = nil;
    if commodity then
        local list = key == nil and commodity:GetCommodityList() or commodity:GetCommodityList2(key);
        local skinId = nil;
        if list == nil then
            return skinInfo;
        end
        for k, v in ipairs(list) do
            if v.type == RandRewardType.ITEM and v.data and v.data:GetItemType() == ITEM_TYPE.SKIN then
                skinId = v.data:GetDyVal2();
                break
            end
        end
        if skinId ~= nil then
            skinInfo = ShopSkinInfo.New();
            skinInfo:InitCfg(skinId);
        end
    end
    return skinInfo;
end

-- 根据皮肤表ID获取商店配置表中对应的商品信息
function this.GetSkinCommodity(modelID)
    if modelID then
        local modelCfg=Cfgs.character:GetByID(modelID);
        if modelCfg~=nil and modelCfg.shopId then
            --判断是否在商品上架期限
            return ShopMgr:GetFixedCommodity(modelCfg.shopId);
        end
    end
    return nil;
end

function this.SortRandComm(a, b)
    local index1 = a:GetSort();
    local index2 = b:GetSort();
    local over1 = a:IsOver() and 1 or 0;
    local over2 = b:IsOver() and 1 or 0;
    if over1 ~= over2 then
        return over1 < over2;
    elseif index1 == index2 then
        return a:GetID() < b:GetID();
    else
        return index1 < index2;
    end

end

-- 皮肤商品排序
function this.SortSkinComm(a, b)
    local skinInfo = this.GetSkinInfo(a)
    local skinInfo2 = this.GetSkinInfo(b)
    local getType1 = skinInfo:GetWayInfo();
    local getType2 = skinInfo2:GetWayInfo();
    local rSkinInfo1 = RoleSkinMgr:GetRoleSkinInfo(skinInfo:GetModelCfg().role_id, skinInfo:GetModelCfg().id);
    local rSkinInfo2 = RoleSkinMgr:GetRoleSkinInfo(skinInfo2:GetModelCfg().role_id, skinInfo2:GetModelCfg().id);
    local r1 = 0;
    local r2 = 0;
    if rSkinInfo1 ~= nil and rSkinInfo1:CheckCanUse() and rSkinInfo1:IsLimitSkin()~=true then
        r1 = 1;
    end
    if rSkinInfo2 ~= nil and rSkinInfo2:CheckCanUse() and rSkinInfo2:IsLimitSkin()~=true then
        r2 = 1;
    end
    -- Log(skinInfo:GetSkinName().."\t"..r1.."\t"..r2.."\t"..getType1.."\t"..getType2.."\t"..a:GetSort().."\t"..b:GetSort())
    if r1 == r2 then
        if getType1 == getType2 then
            return a:GetSort() < b:GetSort();
        else
            return getType1 < getType2
        end
    else
        return r1 < r2
    end

end

function this.SortComm(a, b)
    local over1 = a:IsOver() and 1 or 0;
    local over2 = b:IsOver() and 1 or 0;
    if a:GetType()==CommodityItemType.MonthCard and a:GetSubType()==CommodityItemSubType.MonthCard2 and over1==1 then
        -- local gets=a:GetMonthCardInfo();
        -- if gets and gets.l_cnt>0 then
            over1=0;
        -- end
    end
    if b:GetType()==CommodityItemType.MonthCard and b:GetSubType()==CommodityItemSubType.MonthCard2 and over2==1 then
        -- local gets=b:GetMonthCardInfo();
        -- if gets and gets.l_cnt>0 then
            over2=0;
        -- end
    end
    if over1 ~= over2 then
        return over1 < over2;
    elseif a:GetSort() == b:GetSort() then
        return a:GetID() < b:GetID();
    else
        return a:GetSort() < b:GetSort();
    end
end

-- 返回后台商店商品列表
function this.InitPaySDK()
    -- 正式
    local comms = {};
    local cfgs = Cfgs.CfgRecharge:GetGroup(1); -- IOS
    if cfgs then
        for k, v in ipairs(cfgs) do
            comms[v.iosID] = v.appleShopType;
        end
    end
    local eventData = {
        comms = comms,
        bjTime = TimeUtil:GetBJTime()
    }
    -- LogError(eventData)
    -- 临时
    -- local eventData={comms={PayRecharge_40001=0,PayMonthly_30001=0}}--苹果商店数据，0=消耗型，1=不可销毁的，2=订阅的。
    EventMgr.Dispatch(EventType.SDK_Pay_Init, eventData, true)
end

-- 打开指定商品的购买界面
function this.OpenBuyConfrim(shopId, topId, commID)
    if shopId == nil or commID == nil then
        return;
    end
    local pageData = ShopMgr:GetPageByID(shopId);
    if pageData and pageData:IsOpen() then
        local list = pageData:GetCommodityInfos(true, topId);
        local commData = nil;
        if list then
            local idx=-1;
            for k, v in ipairs(list) do
                if v:GetID() == commID then
                    commData = v;
                    idx=k;
                    break
                end
            end
            if commData == nil then
                return;
            end
            if commData:GetType()==CommodityItemType.Skin and idx~=-1 then --皮肤界面
                local list2={};
                for k,v in ipairs(list) do
                    table.insert(list2,ShopCommFunc.GetSkinInfo(v));
                end
                CSAPI.OpenView("SkinFullInfo",{list=list2,idx=idx})
            elseif commData:GetType()~=CommodityItemType.Skin then
                ShopCommFunc.OpenPayView(commData, pageData);
            end
        end
    end
end

-- 通过商品信息获取当前可用的折扣券列表
function this.MatchVouchers(commodity,num)
    if commodity and commodity:GetUseVoucherTypes() ~= nil then
        local list = BagMgr:GetDataByType(ITEM_TYPE.VOUCHER);
        if list then
            local vs = nil;
            for k, v in ipairs(list) do
                local info = VoucherInfo.New();
                info:SetCfg(v:GetDyVal1());
                if info:CheckCanUse(commodity,num) then
                    vs = vs or {};
                    table.insert(vs, {
                        good = v,
                        info = info
                    });
                end
            end
            return vs;
        end
    end
    return nil;
end

--返回主题是否售罄
function this.GetThemeInfo(themeId)
    local counts = DormMgr:GetCfgFurnitureCount(themeId)
    local totalNum=0;
    local buyNum=0;
    for k, v in pairs(counts) do
        local buyCount = DormMgr:GetBuyCount(k)
        local num = v > buyCount and (v - buyCount) or 0
        local _cfg = Cfgs.CfgFurniture:GetByID(k)
        if _cfg and not _cfg.special then
            totalNum=totalNum+v;
            buyNum=buyNum+buyCount;
        end
    end
    local isSoldout=false;
    if totalNum~=0 and totalNum<=buyNum then
        isSoldout=true;
    end
    return isSoldout
end

return this;
