-- 组队攻击
ExerciseFriendTool = {}
local this = ExerciseFriendTool

this.inviteDatas = {} -- 邀请的数据
this.beInviteDatas = {} -- 被邀请的数据 
this.respondData = nil -- 受邀者数据
this.freeArmyData = nil -- 匹配的对手

function this:Clear()
    self:ClearFriendDatas()
    self.freeArmyData = nil
end

-- 换场景检测邀请
function this:CheckInvite()
    local scene = SceneMgr:GetCurrScene()
    if (scene.key == "MajorCity") then
        if (self.beInviteDatas) then
            for i, v in pairs(self.beInviteDatas) do
                if (TimeUtil:GetTime() < (v.invite_time + g_ArmyFriendMatchWaitTime)) then
                    Tips.ShowInviteTips(v)
                end
            end
        end
    end
end

function this:ClearFriendDatas()
    self.inviteDatas = {}
    self.beInviteDatas = {}
    self.respondData = nil
end

-- ArmyProto:InviteFriendRet	ops   {uid	is_cancel invite_time}
function this:RefreshInviteDatas(proto)
    for i, v in ipairs(proto.ops) do
        self.inviteDatas[v.uid] = v
    end
end

-- 邀请你的好友的数据
-- ArmyProto:BeInvite uid	is_cancel	team  rank  invite_time
function this:RefreshBeInviteDatas(proto)
    self.beInviteDatas[proto.uid] = proto
    -- 只在主场景接收
    local scene = SceneMgr:GetCurrScene()
    if (scene.key == "MajorCity") then
        if (TimeUtil:GetTime() < (proto.invite_time + g_ArmyFriendMatchWaitTime)) then
            Tips.ShowInviteTips(proto)
        end
    end
end

-- 好友应答（不接受时由服务器弹出提示）
function this:BeInviteRespond(proto)
    if (proto.is_receive) then
        self.respondData = proto
    end
end

function this:FreeArmyMatch(proto)
    self.freeArmyData = proto
end

function this:GetInviteData(uid)
    return self.inviteDatas[uid]
end

-- 取消所有申请（离开界面）
function this:CancelAllInvite()
    local curTime = TimeUtil:GetTime()
    local _ops = {}
    for i, v in pairs(self.inviteDatas) do
        if (curTime < (v.invite_time + g_ArmyFriendMatchWaitTime)) then
            table.insert(_ops, {
                uid = v.uid,
                is_cancel = true
            })
        end
    end
    if (#_ops > 0) then
        ExerciseMgr:InviteFriend(_ops)
    end
    self.inviteDatas = {}
end

-- 自己的信息
function this:GetMyData(type, uid)
    local win_cnt = 0
    local lost_cnt = 0
    if (type == RealArmyType.Freedom) then
        win_cnt = ExerciseMgr.win_cnt or 0
        lost_cnt = ExerciseMgr.lost_cnt or 0
    else
        local friendData = FriendMgr:GetData(uid) -- ??
        win_cnt = friendData:GetWinCnt()
        lost_cnt = friendData:GetLostCnt()
    end
    local team = TeamMgr:GetTeamData(eTeamType.RealPracticeAttack)
    local attack = self:GetMeAttack()
    return self:SetData(PlayerClient:GetID(), PlayerClient:GetName(), PlayerClient:GetLv(), win_cnt, lost_cnt,
        PlayerClient:GetIconId(), team, attack)
end

-- 获取对手信息
function this:GetArmyData(type, uid, team)
    local data = {}
    if (type == RealArmyType.Friend) then
        local friendData = FriendMgr:GetData(uid)
        local teamData = TeamData.New()
        teamData:SetData(team)
        local attack = team.performance
        data = self:SetData(uid, friendData:GetName(), friendData:GetLv(), friendData:GetWinCnt(),
            friendData:GetLostCnt(), friendData:GetIconId(), teamData, attack)
        self:SetArmyCardDatas(team)
    elseif (type == RealArmyType.Freedom) then
        data = self.freeArmyData
        for i, v in pairs(self.freeArmyData) do
            if (i == "team") then
                local teamData = TeamData.New()
                teamData:SetData(v)
                data["team"] = teamData
                data.attack = v.performance
            else
                data[i] = v
            end
        end

        self:SetArmyCardDatas(self.freeArmyData.team)
    end
    return data
end

function this:SetData(_uid, _name, _level, _win_cnt, _lost_cnt, _icon_id, _team, _attack)
    local data = {}
    data.uid = _uid
    data.name = _name
    data.level = _level
    data.win_cnt = _win_cnt
    data.lost_cnt = _lost_cnt
    data.icon_id = _icon_id
    data.team = _team
    data.attack = _attack
    return data
end

-- 设置对手卡牌数据
function this:SetArmyCardDatas(team)
    self.armyCardDatas = {}
    if (team and team.data) then
        for i, v in ipairs(team.data) do
            local card = CharacterCardsData(v.card_info)
            self.armyCardDatas[v.cid] = card
        end
    else
        LogError("对手无编队数据")
    end
end

-- 获取对方队伍
function this:GetTeam(is_inviter, uid)
    local _team = {}
    if (is_inviter) then
        _team = self.respondData.team
    else
        local _data = self.beInviteDatas[uid]
        _team = _data.team
    end
    return _team
end

function this:GetMeAttack()
    local attack = 0
    local teamData = TeamMgr:GetTeamData(eTeamType.PracticeAttack)
    if teamData then
        local haloStrength = teamData:GetHaloStrength()
        attack = teamData:GetTeamStrength() + haloStrength
    end
    return attack
end

-- 对手卡牌数据
function this:GetArmyCardDatas()
    return self.armyCardDatas
end

return this
