--商城协议
ShopProto={
    buyCallBack=nil,
    exchangeCallBack=nil;
};
--返回购买记录信息
function ShopProto:GetShopInfos()
    local proto = {"ShopProto:GetShopInfos", {}}
	NetMgr.net:Send(proto);
    -- UIUtil:AddNetWeakHandle();
end

--获取购买记录返回
function ShopProto:GetShopInfosAdd(proto)
    ShopMgr:Init(proto);
    EventMgr.Dispatch(EventType.Shop_RecordInfos_Refresh);
end

--购买物品
function ShopProto:Buy(cfgId,time,sum,useCost,callBack)
    self.buyCallBack=callBack;
    useCost=useCost==nil and "price_1" or useCost;
    local proto = {"ShopProto:Buy", {id=cfgId,buy_time=time,buy_sum=sum,useCost=useCost}}
	NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();
end
--购买物品 --新手首冲礼包
function ShopProto:Buy2(cfgId,callBack)
    self.buyCallBack2=callBack;
    local proto = {"ShopProto:Buy", {id=cfgId,buy_sum=1}}
	NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();
end

--购买回调
function ShopProto:BuyRet(proto)
    ShopMgr:UpdateData(proto.id,proto.info,true);
    ShopMgr:UpdateMonthDays(proto.m_cnt);
    EventMgr.Dispatch(EventType.Shop_Buy_Ret,proto)
    if self.buyCallBack then
        self.buyCallBack(proto);
        self.buyCallBack=nil
    end
    if(self.buyCallBack2) then 
        UIUtil:OpenReward({proto.gets})
        self.buyCallBack2 = nil 
    end 
end

--兑换物品
function ShopProto:Exchange(cfgId,index,id,num,callBack)
    self.exchangeCallBack=callBack;
    local proto = {"ShopProto:Exchange", {cfgid=cfgId,index=index,id=id,num=num}}
	NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();
end

--兑换回调
function ShopProto:ExchangeRet(proto)
    ShopMgr:UpdateExchangeData(proto);
    EventMgr.Dispatch(EventType.Shop_Exchange_Ret,proto)
    if self.exchangeCallBack then
        self.exchangeCallBack(proto);
        self.exchangeCallBack=nil;
    end
end

--获取兑换商店数据
function ShopProto:GetExchangeInfo(cfgId,isRefresh)
    isRefresh=isRefresh==true;
    local proto={"ShopProto:GetExchangeInfo",{cfgid=cfgId,is_flush=isRefresh}};
    NetMgr.net:Send(proto);
    UIUtil:AddNetWeakHandle();  
end

--返回商店数据
function ShopProto:GetExchangeInfoRet(proto)
    ShopMgr:SetExchangeData(proto);
    if proto and proto.is_flush then --手动刷新 记录数数
        ThinkingAnalyticsMgr:TrackEvents("store_refresh", {store_type=tostring(proto.cfgid)})
    end
    EventMgr.Dispatch(EventType.Shop_RandComm_Refresh)
end

function ShopProto:GetShopResetTime()
    local proto={"ShopProto:GetShopResetTime",{}};
    NetMgr.net:Send(proto);
end

function ShopProto:GetShopResetTimeRet(proto)
    ShopMgr:SetShopResetTime(proto);
    EventMgr.Dispatch(EventType.Shop_ResetTime_Ret);
end
