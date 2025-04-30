ArmyProto = {}

-- 获取军演信息
function ArmyProto:GetPracticeInfoRet(proto)
    ExerciseMgr:GetPracticeInfoRet(proto)
end

-- 信息刷新(结算)
function ArmyProto:PracticeInfoUpdate(proto)
    ExerciseMgr:PracticeInfoUpdate(proto)
end

-- 刷新对手
function ArmyProto:FlushPracticeObjRet(proto)
    ExerciseMgr:FlushPracticeObjRet(proto)
end

-- 查看对手卡牌信息
function ArmyProto:GetPracticeOtherTeamRet(proto)
    ExerciseMgr:GetPracticeOtherTeamRet(proto)
end

-- 查看对手卡牌信息
function ArmyProto:GetPracticeListRet(proto)
    ExerciseMgr:GetPracticeListRet(proto)
end

-- 准备好
function ArmyProto:StartRealArmyRet(proto)
    ExerciseMgr:StartRealArmyRet(proto)
end

-- 邀请军演信息返回
function ArmyProto:InviteFriendRet(proto)
    ExerciseMgr:InviteFriendRet(proto)
end

-- 被好友邀请军演(服务器推送)
function ArmyProto:BeInvite(proto)
    ExerciseMgr:BeInvite(proto)
end

-- 好友邀请军演应答(给邀请者)
function ArmyProto:BeInviteRespond(proto)
    ExerciseMgr:BeInviteRespond(proto)
end

-- 参加自由军演返回
function ArmyProto:JoinFreeArmyRet(proto)
    ExerciseMgr:JoinFreeArmyRet(proto)
end

-- 退出自由军演
function ArmyProto:QuitFreeArmyRet()
    ExerciseMgr:QuitFreeArmyRet(proto)
end

-- 自由军演匹配成功
function ArmyProto:FreeArmyMatch(proto)
    ExerciseMgr:FreeArmyMatch(proto)
end

-- 实时军演战斗地址服务器
function ArmyProto:FightAddress(proto)
    ExerciseMgr:FightAddress(proto)
end

-- 实时军演战斗服报道返回
function ArmyProto:FightServerInitRet(proto)
    ExerciseMgr:FightServerInitRet(proto)
end

-- 实时军演开始倒计时
function ArmyProto:RealArmyStarCountDown(proto)
    ExerciseMgr:RealArmyStarCountDown(proto)
end

-- 实时军演结果
function ArmyProto:RealTimeFightFinish(proto)
    ExerciseMgr:RealTimeFightFinish(proto)
end

-- 不重进战斗
function ArmyProto:NotReEntryRealFight()
    local proto = {"ArmyProto:NotReEntryRealFight"}
    NetMgr.net:Send(proto)
end

-- 不重进战斗
function ArmyProto:NotReEntryRealFightRet(proto)

end

-- 请求自由军演对战列表
function ArmyProto:FreeArmyFightList()
    local proto = {"ArmyProto:FreeArmyFightList"}
    NetMgr.net:Send(proto)
end
function ArmyProto:FreeArmyFightListRet(proto)
    EventMgr.Dispatch(EventType.Exercise_WaringList, proto)
end

-- 退出军演
function ArmyProto:QuitArmy()
    local proto = {"ArmyProto:QuitArmy"}
    NetMgr.net:Send(proto)
end
-- 实时军演对手已经下线
function ArmyProto:RealArmyLogout(proto)
    EventMgr.Dispatch(EventType.Exercise_Army_Out)
end

-- 请求自己的数据（仅在倒计时用）
function ArmyProto:GetSelfPracticeInfo(GetSelfPracticeInfoCB)
    self.GetSelfPracticeInfoCB = GetSelfPracticeInfoCB
    local proto = {"ArmyProto:GetSelfPracticeInfo"}
    NetMgr.net:Send(proto)
end
function ArmyProto:GetSelfPracticeInfoRet(proto)
    local datas = {
        info = proto.info,
        selfInfo = true
    }
    ExerciseMgr:GetPracticeInfoRet(datas)
    if (self.GetSelfPracticeInfoCB) then
        self.GetSelfPracticeInfoCB()
    end
    self.GetSelfPracticeInfoCB = nil
end

-- 购买军演次数
function ArmyProto:BuyAttackCnt(_cnt)
    local proto = {"ArmyProto:BuyAttackCnt", {
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
function ArmyProto:BuyAttackCntRet(proto)
    ExerciseMgr:BuyAttackCntRet(proto)
    LanguageMgr:ShowTips(33008)
end


--军演立绘
function ArmyProto:SetRolePanel(_role_panel_id,_live2d)
    local proto = {"ArmyProto:SetRolePanel", {
        role_panel_id = _role_panel_id,
        live2d = _live2d
    }}
    NetMgr.net:Send(proto)
end
function ArmyProto:SetRolePanelRet(proto)
    ExerciseMgr:SetRolePanelRet(proto.role_panel_id,proto.live2d)
    LanguageMgr:ShowTips(33020)
end

--军演战报
function ArmyProto:GetFightLogs(_ix,_cnt,_cb)
    self.GetFightLogsCB = _cb
    local proto = {"ArmyProto:GetFightLogs", {
        ix = _ix,
        cnt = _cnt
    }}
    NetMgr.net:Send(proto)
end
function ArmyProto:GetFightLogsRet(proto)
    if(self.GetFightLogsCB)then 
        self.GetFightLogsCB(proto)
    end
    self.GetFightLogsCB = nil
end
