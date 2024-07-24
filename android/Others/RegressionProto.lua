-- 回归活动信息
RegressionProto = {}

-- 回归活动信息 
function RegressionProto:GetInfo()
    local proto = {"RegressionProto:GetInfo"}
    NetMgr.net:Send(proto)
end
function RegressionProto:GetInfoRet(proto)
    RegressionMgr:GetInfoRet(proto)
end

-- 日常资源找回领取奖励返回
function RegressionProto:ResourcesRecoveryGainRet(proto)
    if (proto.resourcesIsGain == 1) then
        RegressionMgr:SetResRecoveryGain(proto.resourcesIsGain)
        EventMgr.Dispatch(EventType.HuiGui_Res_Recovery)
    end
end


--获取道具池信息
function RegressionProto:ItemPoolInfo(id,isNextRound)
    local proto = {"RegressionProto:ItemPoolInfo",{id=id,nextRound=isNextRound}}
    NetMgr.net:Send(proto)
end

function RegressionProto:ItemPoolInfoRet(proto)
    ItemPoolActivityMgr:UpdatePoolInfo(proto);
    EventMgr.Dispatch(EventType.ItemPool_Date_Update);
end

--抽取道具池 id:道具池id，times：次数
function RegressionProto:ItemPoolDraw(id,times)
    local proto = {"RegressionProto:ItemPoolDraw",{id=id,times=times}}
    NetMgr.net:Send(proto)
end

function RegressionProto:ItemPoolDrawRet(proto)
    ItemPoolActivityMgr:OnDrawRet(proto);
    EventMgr.Dispatch(EventType.ItemPool_Draw_Ret,proto);
end