SystemProto = {};

--查询账号
function SystemProto:ServerError(msg)
    
    DebugLog(table.tostring(msg, true));
    --LogWarning("服务器报错\n"..table.tostring(msg), "ff0000");
    -- LogError("ff9977服务器报错\n"..table.tostring(msg));
    -- LogError(msg,"ff9977");
    --assert(nil, "服务器报错\n"..table.tostring(msg))
    -- ServerLogError("服务器报错,截图下一行");
    ServerLogError("服务器报错\n"..table.tostring(msg, true));
end

function SystemProto:ServerWarning(msg)
    -- LogWarning("服务器报错\n"..table.tostring(msg));
    ServerLogError("服务器警告\n"..table.tostring(msg, true));
end

function SystemProto:Tips(msg)
    if(msg) then
        TipsMgr:HandleMsg(msg); 
    end 
end

function SystemProto:TestMap(msg)
    DebugLog("====================TestMap=========================","ff0000");
    LogWarning(msg);
end

---------------------------------------------仅每日到点更新一次--------------------------
function SystemProto:ActiveZeroNotice(proto)
    Log("每日到点更新")

    --体能购买次数
    if (proto.datas and proto.datas.hot_buy_cnt) then
        PlayerClient:HotBuyCnt(proto.datas.hot_buy_cnt)
        EventMgr.Dispatch(EventType.Player_HotChange)
    end
    --催眠次数
    if (proto.datas and proto.datas.phy_game_cnt) then
        FavourMgr:DailyData(proto.datas.phy_game_cnt)
    end
    --抽卡相关
    if (proto.datas and proto.datas.card_pool_daily_use_cnt) then
        CreateMgr:SetDailyUseCnt(proto.datas.card_pool_daily_use_cnt)
    end
    if (proto.datas and proto.datas.card_pool_free_cnt) then
        CreateMgr:SetFreeCnt(proto.datas.card_pool_free_cnt)
    end
    --刷新活动时间
	ActivityMgr:RefreshOpenState()

    -- 每日刷新
    EventMgr.Dispatch(EventType.Update_Everyday)

    --签到刷新
    -- SignInMgr:CheckAll()
end
