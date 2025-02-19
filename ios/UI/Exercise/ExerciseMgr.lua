require "ExerciseFriendTool" -- 管理邀请或被邀请的数据
local ExerciseInfo = require "ExerciseInfo"

local this = MgrRegister("ExerciseMgr")

function this:Clear()
    self.info = {} -- 演习界面、个人信息
    self.objs = {} -- 模拟敌人信息
    self.rankInfos = {} -- 排行榜信息
    self.teamInfos = {} -- 排行榜队伍信息
    self.cur_rank = 0

    self.addCoin = 0
    self.addRankNum = 0
    self.isRankLevelUp = false
    self.delay = false
    self.isRankUp = false

    self.isOpen = false
    self._newSeasonData = nil
    self._isCheckNewJoinCnt = false
    self._isNewJoinCnt = false
    self._newJoinCntTime = nil

    self.isInit = false 

    ExerciseFriendTool:Clear()
end

function this:Init()
    self:Clear()

    -- 请求 infos
    --self:GetPracticeInfo(true, false)
end

--是否已初始化
function this:CheckIsInit()
    return self.isInit
end

-- 敌人
function this:GetEnemy()
    return self.objs or {}
end

-- 单个敌人信息
function this:GetEnemyInfo(uid)
    for i, v in ipairs(self:GetEnemy()) do
        if (v.uid == uid) then
            return v
        end
    end
end

function this:UpdateEnemyInfo(proto)
    for i, v in ipairs(self:GetEnemy()) do
        if (v.uid == proto.uid) then
            v.performance = proto.team.performance
        end
    end
end

-- 挑战次数下次刷新时间
function this:GetNextTime()
    --     local tab = TimeUtil:GetTimeHMS(TimeUtil:GetTime())
    --     local curHour = tab.hour
    --     local cnts = g_ArmyPracticeJoinCntFlushTime
    --    --table.insert(cnts, 24)
    --     local index = 1
    --     while curHour >= cnts[index] do
    --         index = index + 1
    --     end
    --     local nextTime = TimeUtil:GetTime2(tab.year, tab.month, tab.day, cnts[index], tab.min, tab.sec)
    --     return nextTime + 1

    return self.info.t_join_cnt or (TimeUtil:GetTime() + 1000)
end

-- 赛季结束时间
function this:GetEndTime()
    return self.info.end_time or 0
end

-- 赛季开始时间
function this:GetStartTime()
    return self.info.start_time or 0
end

-- 是不是休赛期
function this:IsLeisureTime()
    local curTime = TimeUtil:GetTime()
    if (curTime >= self:GetStartTime() and curTime < self:GetEndTime()) then
        return false
    end
    return true
end

--下次刷新时间
function this:GetRefreshTime()
    local isExerciseLOpen = MenuMgr:CheckModelOpen(OpenViewType.main, "ExerciseLView")
    if(isExerciseLOpen)then 
        if(not self:IsLeisureTime())then 
            return self:GetEndTime()
        end 
    end 
    return nil
end

----------------------------------------新赛季new------------------------------------
-- 演习 new 
function this:IsExerciseLNew()
    if (not self:IsOpen()) then
        return false
    end
    if (self:IsNewJoinCnt()) then
        return true
    end
    if (self:IsNewSeason()) then
        return true
    end
    return false
end

-- 演习系统是否已开启
function this:IsOpen()
    if (not self.isOpen) then
        local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "ExerciseLView")
        self.isOpen = isOpen
    end
    return self.isOpen
end

function this:CheckNewSeason()
    local num = self:IsNewSeason() and 1 or nil
    RedPointMgr:UpdateData(RedPointType.ExerciseL, num)
    EventMgr.Dispatch(EventType.ExerciseL_New)
end

-- 是否是新赛季（新赛季New,进入界面后消失）
function this:IsNewSeason()
    if (not self:IsLeisureTime()) then
        local key = string.format("%s_IsNewSeason.txt", PlayerClient:GetID())
        if (not self._newSeasonData) then
            self._newSeasonData = FileUtil.LoadByPath(key)
            if (not self._newSeasonData) then
                local data = {}
                data[1] = self:GetEndTime()
                data[2] = 1 -- 1:未看 2：已看
                self._newSeasonData = data
                FileUtil.SaveToFile(key, data)
            end
        end
        if (self._newSeasonData) then
            -- 对比，是否已查看 1:未查看 2：已查看但赛季不同
            if (self._newSeasonData[2] == 1 or self._newSeasonData[1] ~= self:GetEndTime()) then
                return true
            end
        end
    end
    return false
end
-- 本赛季已打开过界面
function this:SetNewSeason()
    local data = {}
    data[1] = self:GetEndTime()
    data[2] = 2 -- 1:未看 2：已看
    self._newSeasonData = data
    local key = string.format("%s_IsNewSeason.txt", PlayerClient:GetID())
    FileUtil.SaveToFile(key, data)
    self:CheckNewSeason()
end

----------------------------------------新赛季new------------------------------------

----------------------------------------演习次数刷新------------------------------

-- 时间大于下次参加次数刷新的时间，且未进入过演习界面推送new ，如果此时就在演习界面，则直接弹出提示，不显示new 
-- 进入界面会请求个人数据，那么可以重置为未进入过界面的状态
function this:CheckNewJoinCnt()
    if (self._isNewJoinCnt) then
        return
    end
    if (not self._newJoinCntTime) then
        local key = string.format("%s_CheckNewJoinCnt.txt", PlayerClient:GetID())
        self._newJoinCntTime = FileUtil.LoadByPath(key)
        if (not self._newJoinCntTime) then
            local data = {}
            data[1] = self:GetNextTime() - 1
            self._newJoinCntTime = data
            self._isNewJoinCnt = true
            FileUtil.SaveToFile(key, data)
        end
    end

    if (not self._isCheckNewJoinCnt and self:GetNextTime() > self._newJoinCntTime[1] and TimeUtil:GetTime() >
        self:GetNextTime()) then
        self._isCheckNewJoinCnt = true

        if (CSAPI.IsViewOpen("ExerciseLView")) then
            self._isNewJoinCnt = false
            -- 直接弹出提示 由界面播放
        else
            self._isNewJoinCnt = true
            EventMgr.Dispatch(EventType.ExerciseL_New)
        end
    end
end
function this:IsNewJoinCnt()
    return self._isNewJoinCnt
end
-- 已打开过界面
function this:SetNewJoinCnt()
    local key = string.format("%s_CheckNewJoinCnt.txt", PlayerClient:GetID())
    local data = {}
    data[1] = self:GetNextTime()
    self._newJoinCntTime = data
    FileUtil.SaveToFile(key, data)

    self._isCheckNewJoinCnt = false
    self._isNewJoinCnt = false
    EventMgr.Dispatch(EventType.ExerciseL_New)
end

-------------------------------演习次数刷新------------------------------
--已购买次数
function this:GetCanBuy()
    local cnt = self.info.can_join_buy_cnt or 0
    return cnt, g_ArmyAttackBuyCnt
end

-- 可以参加的次数
function this:GetJoinCnt()
    local cnt = self.info.can_join_cnt or 0
    return cnt, g_ArmyPracticeJoinCnt
end
-- 已刷新次数
function this:GetFlushCnt()
    local cnt = self.info.flush_cnt or 0
    return cnt, g_ArmyPracticeFlushMax
end

function this:SetFlushCnt(cnt)
    self.info.flush_cnt = cnt
end
-- 段位
function this:GetRankLevel()
    return self.info.rank_level or 1
end
function this:GetDwName()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(self:GetRankLevel())
    return cfg.name or ""
end

-- 段位图标
function this:GetDwIcon()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(self:GetRankLevel())
    return cfg.icon or ""
end

-- 排名
function this:GetRank()
    return self.info.rank or 0
end
function this:GetRankStr()
    return self:GetRank() == 0 and "--" or (self.info.rank .. "")
end
-- 最高排名
function this:GetMaxRank()
    return self.info and self.info.max_rank or 0
end

function this:GetMaxRankLevel()
    return self.info and self.info.max_rank_level or 0
end

-- 最高段位
function this:GetMaxDwName()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(self:GetMaxRankLevel())
    return cfg~=nil and cfg.name or "--"
end 

-- 积分
function this:GetScore()
    return self.info.score or 0
end

-- 一些新信息
function this:GetNewChange()
    local _addRankNum, _isRankLevelUp, _addCoin = 0, false, 0

    _addRankNum = self.addRankNum
    self.addRankNum = 0

    _isRankLevelUp = self.isRankLevelUp
    self.isRankLevelUp = false

    _addCoin = self.addCoin
    self.addCoin = 0

    return {_addRankNum, _isRankLevelUp, _addCoin}
end

-- 退出战斗，返回演习界面
function this:Quit(sceneType, armyType)
    if (sceneType == SceneType.PVP) then
        ClientProto:DelayChangeLine()
    end
    SceneLoader:Load("MajorCity", function()
        self:OnQuit(sceneType, armyType)
    end)
end

function this:OnQuit(sceneType, armyType)
    CSAPI.OpenView("Section", {
        type = 3
    })
    if (sceneType == SceneType.PVPMirror) then
        CSAPI.OpenView("ExerciseLView")
    else
        CSAPI.OpenView("ExerciseRView", nil, armyType - 1)
    end
end

function this:GetRankInfos()
    local arr = {}
    for i, v in pairs(self.rankInfos) do
        table.insert(arr, v)
    end
    if (#arr > 0) then
        table.sort(arr, function(a, b)
            return a:GetRank() < b:GetRank()
        end)
    end
    self.cur_rank = #arr
    return arr
end

function this:AddNextRankList()
    self.cur_rank = self.cur_rank or 0
    self.max_rank = self.max_rank or g_ArmyRankNumMax
    if (self.cur_rank < (self.max_rank - 1)) then
        local max = self.cur_rank + 10 > self.max_rank and self.max_rank or self.cur_rank + 10
        self:GetPracticeList(self.cur_rank + 1, max)
    end
end

-- 清空演习排行榜缓存数据
function this:ClearRankData()
    -- if (not self.clearTime) then
    --     self.clearTime = Time.time + 1800
    -- else
    --     if (Time.time > self.clearTime) then
    --         self.cur_rank = 0
    --         self.rankInfos = 0
    --         self.clearTime = Time.time + 1800
    --     end
    -- end

    self.cur_rank = 0
    self.rankInfos = {}
end

-- --当前邀请或接受邀请的好友
-- function this:GetYqUid()
-- 	return self.YqUid
-- end
function this:GetYqTeam()
    return self.YqTeam
end

-- 获取对手卡牌数据
function this:GetData(cid)
    return self.armyCardDatas[cid]
end

-- 下一级是否是最高段位
function this:NextIsMaxLevel(lv)
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(lv + 1)
    return cfg == nil
end

-- 排行榜队伍信息
function this:GetTeanInfo(uid)
    return self.teamInfos[uid]
end

-----------------------------------------------协议------------------------
function this:JoinFreeArmy(_JoinFreeArmyCB)
    self.JoinFreeArmyCB = _JoinFreeArmyCB
    local proto = {"ArmyProto:JoinFreeArmy", {}}
    NetMgr.net:Send(proto)
end
-- 参加自由军演返回
function this:JoinFreeArmyRet(proto)
    if (proto) then
        self.win_cnt = proto.win_cnt
        self.lost_cnt = proto.lost_cnt
        -- EventMgr.Dispatch(EventType.Exercise_Yq_CB, RealArmyType.Freedom)	
        if (self.JoinFreeArmyCB) then
            self.JoinFreeArmyCB()
        end
    end
end

function this:QuitFreeArmy(_QuitFreeArmyCB)
    self.QuitFreeArmyCB = _QuitFreeArmyCB
    local proto = {"ArmyProto:QuitFreeArmy"}
    NetMgr.net:Send(proto)
end
-- 退出匹配
function this:QuitFreeArmyRet(proto)
    -- EventMgr.Dispatch(EventType.Exercise_Yq_Cancel)	
    if (self.QuitFreeArmyCB) then
        self.QuitFreeArmyCB()
    end
end

-- 开始模拟
function this:Practice(_uid, _is_robot)
    local proto = {"ArmyProto:Practice", {
        uid = _uid,
        is_robot = _is_robot
    }}
    NetMgr.net:Send(proto)
end

-- 开始实时对战
function this:StartRealArmy(_team)
    local proto = {"ArmyProto:StartRealArmy", {
        team = _team
    }}
    NetMgr.net:Send(proto)
end

-- 获取军演信息
function this:GetPracticeInfo(_selfInfo, _listInfo)
    local proto = {"ArmyProto:GetPracticeInfo", {
        selfInfo = _selfInfo,
        listInfo = _listInfo
    }}
    NetMgr.net:Send(proto)
end

-- 获取军演信息
function this:GetPracticeInfoRet(proto)
    if (proto) then
        if (proto.selfInfo) then
            self.info = proto.info or {}
            EventMgr.Dispatch(EventType.Exercise_Update)
        end
        if (proto.listInfo) then
            self.objs = proto.objs
            EventMgr.Dispatch(EventType.Exercise_Enemy_Update)
        end

        self.isInit = true 
    end
end

-- 刷新对手
function this:FlushPracticeObj()
    local proto = {"ArmyProto:FlushPracticeObj"}
    NetMgr.net:Send(proto)
end
-- 刷新对手
function this:FlushPracticeObjRet(proto)
    if (proto) then
        self.objs = proto.objs
        self:SetFlushCnt(proto.flush_cnt)
        EventMgr.Dispatch(EventType.Exercise_Enemy_Update)
    end
end

-- 查看卡牌信息  
function this:GetPracticeOtherTeam(_uid, _is_robot)
    local proto = {"ArmyProto:GetPracticeOtherTeam", {
        uid = _uid,
        is_robot = _is_robot
    }}
    NetMgr.net:Send(proto)
end
-- 查看对手卡牌信息
function this:GetPracticeOtherTeamRet(proto)
    if (proto) then
        -- 更新战斗力
        self:UpdateEnemyInfo(proto)
        EventMgr.Dispatch(EventType.Exercise_Enemy_Info, proto)
    end
end

-- 请求排名
function this:GetPracticeList(_beg_rank, _end_rank)
    local proto = {"ArmyProto:GetPracticeList", {
        beg_rank = _beg_rank,
        end_rank = _end_rank
    }}
    NetMgr.net:Send(proto)
end
function this:GetPracticeListRet(proto)
    if (proto) then
        self.max_rank = proto.max_rank or 0
        if (proto.objs and #proto.objs > 0) then
            for i, v in pairs(proto.objs) do
                local info = ExerciseInfo.New()
                info:InitData(v)
                if (info:GetRank() ~= 0) then
                    self.rankInfos[info:GetRank()] = info
                end
            end
        end
        -- 队伍信息
        if (proto.teamInfos and #proto.teamInfos > 0) then
            for i, v in ipairs(proto.teamInfos) do
                self.teamInfos[v.uid] = v
            end
        end
        EventMgr.Dispatch(EventType.Exercise_Rank_Info)
    end
end

-- 封装自己的排行榜数据
function this:SetMyRankData()
    local _data = {}
    _data.id = PlayerClient:GetUid()
    _data.name = PlayerClient:GetName()
    _data.level = PlayerClient:GetLv()
    _data.rank_level = self:GetRankLevel()
    _data.rank = self:GetRank()
    _data.performance = self.info and self.info.performance or 0
    _data.score = self:GetScore()
    _data.icon_id = PlayerClient:GetIconId()
    _data.is_robot = false
    local info = ExerciseInfo.New()
    info:InitData(_data)
    return info
end

-- 准备好
function this:StartRealArmyRet(proto)
    EventMgr.Dispatch(EventType.Exercise_Ready, proto)
end

-- 邀请好友  _is_cancel:true 取消邀请   false：邀请
function this:InviteFriend(_ops, _YQCB)
    if(self.YQCB) then 
        return 
    end 
    self.YQCB = _YQCB
    local proto = {"ArmyProto:InviteFriend", {
        ops = _ops
    }}
    NetMgr.net:Send(proto)
end

-- 邀请回调
function this:InviteFriendRet(proto)
    if (proto) then
        ExerciseFriendTool:RefreshInviteDatas(proto)
        if (self.YQCB) then
            self.YQCB(proto)
        end
        self.YQCB = nil
    end
end

-- 好友应答(给邀请者)
function this:BeInviteRespond(proto)
    ExerciseFriendTool:BeInviteRespond(proto)
    -- if(proto) then
    -- 	if(proto.is_receive == false) then
    -- 		Log("对方不接受邀请")	
    -- 		if(self.YqUid ~= nil) then
    -- 			EventMgr.Dispatch(EventType.Exercise_Yq_Refuse, proto)
    -- 		end
    -- 		self.YqUid = nil
    -- 		self.YqTeam = nil
    -- 		self.YqRank = nil
    -- 	else
    -- 		Log("对方接受邀请，等待服务器返回进入倒计时")	
    -- 		self.YqUid = proto.uid
    -- 		self.YqTeam = proto.team	
    -- 		self.YqRank = proto.rank
    -- 	end
    -- end
end

-- 进入军演开始倒计时
function this:RealArmyStarCountDown(proto)
    local _team = nil
    if (proto.type == RealArmyType.Friend) then
        _team = ExerciseFriendTool:GetTeam(proto.is_inviter, proto.uid)
    end
    local _endTime = proto.end_time
    local data = {
        endTime = _endTime,
        uid = proto.uid,
        type = proto.type,
        team = _team
    }
    if (CSAPI.IsViewOpen("ExerciseRView")) then
        EventMgr.Dispatch(EventType.Exercise_Pp_Success, data)
    else
        CSAPI.OpenView("ExerciseRView", data)
    end

    -- 清除邀请的相关数据
    Tips.CleanInviteTips()
    ExerciseFriendTool:ClearFriendDatas()
end

-- 收到好友邀请(服务器推送)
function this:BeInvite(proto)
    if (proto) then
        ExerciseFriendTool:RefreshBeInviteDatas(proto)
        -- self.YqUid = proto.uid
        -- self.YqTeam = proto.team
        -- self.YqRank = proto.rank
        -- EventMgr.Dispatch(EventType.Exercise_Yq_Notice, proto)	
    end
end

-- 应答好友
function this:BeInviteRet(_ops)
    local proto = {"ArmyProto:BeInviteRet", {
        ops = _ops
    }}
    NetMgr.net:Send(proto)
end

-- 自由军演匹配成功
function this:FreeArmyMatch(proto)
    -- self.freeArmyData = proto
    ExerciseFriendTool:FreeArmyMatch(proto)
end

function this:FightServerInit(_self_uid, _fightIndex, _svrId)
    local proto = {"ArmyProto:FightServerInit", {
        self_uid = _self_uid,
        fightIndex = _fightIndex,
        svrId = _svrId
    }}
    local curNet = self:GetCurNet()
    curNet:Send(proto)
end
-- 获取当前网络
function this:GetCurNet()
    if (self.isFightNet) then
        return NetMgr.netFight
    else
        return NetMgr.net
    end
end

-- 实时军演战斗地址服务器
function this:FightAddress(proto)
    self.ip = proto.ip
    self.port = proto.port
    self.fightIndex = proto.fightIndex
    self.svrId = proto.svrId
    local localIp, localPort = LoginProto:GetIpPort()
    Log("主网络Ip：" .. localIp .. "  " .. localPort)
    Log("游戏服Ip：" .. proto.ip .. "   " .. proto.port)
    if (localIp ~= self.ip or localPort ~= self.port) then
        Log("连接到游戏逻辑服")
        self.isFightNet = true
        self:OnConnectFightServer()
    else
        Log("使用主网络")
        self.isFightNet = false
        self:FightServerInit(PlayerClient:GetID(), self.fightIndex, self.svrId)
    end
end

-- 连接到游戏逻辑服
function this:OnConnectFightServer()
    local func = function()
        local msg = {
            uid = LoginProto.vosQueryAccount.uid,
            key = LoginProto.vosPreLoginGame.key
        }
        self:FightServerInit(PlayerClient:GetID(), self.fightIndex, self.svrId)
    end
    NetMgr.netFight:Connect(self.ip, self.port, func)
end

-- 实时军演战斗服报道返回
function this:FightServerInitRet(proto)
    Log("实时军演战斗服报道返回")
end

-- 结果 实时pvp
function this:RealTimeFightFinish(proto)
    -- if(proto) then
    -- 	local data = {bIsWin = proto.bIsWin, result = proto, armyType = proto.type}
    -- 	if(proto.isForceOver) then
    -- 		FightActionMgr:Surrender(data)
    -- 	else
    -- 		FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, data))
    -- 	end
    -- end
    -- 断线重连在主界面时不进行结算
    local scene = SceneMgr:GetCurrScene()
    if (scene.key ~= "MajorCity") then
        FightOverTool.RealTimeFightFinish(proto)
    end
    -- 是否在战斗中
    -- if(FightClient:IsFightting()) then 
    -- 	FightOverTool.RealTimeFightFinish(proto)
    -- end
end

-- 结果 演习
function this:PracticeInfoUpdate(proto)
    local score = proto.info.score - self.info.score
    -- local _oldInfo = {}
    -- table.copy(self.info, _oldInfo)
    -- self.info = proto.info
    -- self.addCoin = proto.coin
    -- local data = {bIsWin = proto.bIsWin, oldInfo = _oldInfo, result = proto, armyType = RealArmyType.Mirror}
    -- FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, data))
    --
    -- 是否有升段位
    if (proto.info.max_rank_level > self.info.max_rank_level) then
        self.isRankLevelUp = true
    else
        self.isRankLevelUp = false
    end
    -- 是否刷新最高排名
    if (proto.info.max_rank and proto.info.max_rank ~= 0 and proto.info.max_rank < self.info.max_rank) then
        self.addRankNum = self.info.max_rank - proto.info.max_rank
    else
        self.addRankNum = 0
    end

    -- 排名提升
    if (proto.info.rank and proto.info.rank ~= 0 and proto.info.rank < self.info.rank) then
        self.isRankUp = true
    else
        self.isRankUp = false
    end

    self.info = proto.info or {}
    self.addCoin = proto.coin

    FightOverTool.PracticeInfoUpdate(proto, score)
end

function this:IsRankUp()
    return self.isRankUp
end

-- 获取旧等级，积分 
function this:GetOldInfo(jf)
    local lv = self:GetRankLevel()
    local cur = self:GetScore() - jf
    if (cur < 0) then
        lv = self:GetRankLevel() - 1
        local cfg = Cfgs.CfgPracticeRankLevel:GetByID(lv)
        cur = cfg.nScore + cur
    end
    return lv, cur
end

--购买军演次数返回
function this:BuyAttackCntRet(proto)
    if(self.info) then 
        self.info.can_join_buy_cnt = proto.can_join_buy_cnt
        self.info.can_join_cnt = proto.can_join_cnt
        EventMgr.Dispatch(EventType.ExerciseL_BuyCount)
    end 
end

return this
