-- 运营活动
OperateActiveProto = {
    SkinRebateInfoCallBack = nil,
}

function OperateActiveProto:GetOperateActive(_id)
    local proto = {"OperateActiveProto:GetOperateActive", {
        id = _id
    }}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetOperateActiveRet(proto)
    for k, v in pairs(proto.operateActiveList) do
        if (v.id == eOperateType.RechargeSign) then -- 累充签到
            ActivityMgr:SetOperateActive(v.id, v)
            MenuBuyMgr:ConditionCheck4(6, v)         --累充6
        elseif (v.id == eOperateType.PayNotice7) then -- 累充7
            MenuBuyMgr:ConditionCheck4(7, v)
        elseif (v.id == eOperateType.PayNotice8) then -- 累充8
            MenuBuyMgr:ConditionCheck4(8, v)
        elseif (v.id == eOperateType.PayNotice1) then -- 累充1
            MenuBuyMgr:ConditionCheck4(1, v)
        end
    end
    EventMgr.Dispatch(EventType.MenuBuy_RechargeCB)
end

function OperateActiveProto:GetActiveTimeList()
    local proto = {"OperateActiveProto:GetActiveTimeList", {}}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetActiveTimeListRet(proto)
    ActivityMgr:UpdateDatas(proto)
end

--获取皮肤返利特权卡数据
function OperateActiveProto:GetSkinRebateInfo(skinId)
    local proto = {"OperateActiveProto:GetSkinRebateInfo", {skinId = skinId}}
    NetMgr.net:Send(proto);
end

--获取皮肤返利特权卡数据返回
function OperateActiveProto:GetSkinRebateInfoRet(proto)
    OperationActivityMgr:SetSkinRebateInfos(proto)
end

function OperateActiveProto:DragonBoatFestivalRefuel(id,type)
    local proto = {"OperateActiveProto:DragonBoatFestivalRefuel", {id = id,type = type}}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetDragonBoatFestivalInfo()
    local proto = {"OperateActiveProto:GetDragonBoatFestivalInfo", {}}
    NetMgr.net:Send(proto);
end

function OperateActiveProto:GetDragonBoatFestivalInfoRet(proto)
    OperationActivityMgr:SetDuanWuInfos(proto)
end