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
