DungeonActivityMgr = MgrRegister("DungeonActivityMgr")
local this = DungeonActivityMgr;
RankActivityInfo = require "RankActivityInfo"

function this:Init()
    self:Clear()
    self:InitNewDatas()
end

function this:Clear()
    -- rank
    self.clearTime = {}
    self.cur_rank = {}
    self.rankInfos = {}
    self.myRank = {}
    self.myTurnNum = {}
    self.myScore = {}
    self.max_rank = {}
    self.rankTime = {}
    self.dungeonTeams = {}
    self.isRequest = false
    -- new
    self.sectionNewDatas = nil
end

function this:InitNewDatas()
    self.sectionNewDatas = {}
    for _, datas in pairs(self:GetSectionDatasByType(true)) do
        for i, v in ipairs(datas) do
            self.sectionNewDatas[v:GetID()] = v
        end
    end  
end

-- 包含积分战斗
function this:HasBuffBattle(sid)
    local dungeonGroups = DungeonMgr:GetDungeonGroupDatas(sid)
    local isHas = false
    if dungeonGroups and #dungeonGroups > 0 then
        for i, v in ipairs(dungeonGroups) do
            if v:IsEx() then
                isHas = true
                break
            end
        end
    end
    return isHas
end

--获取对应类型的章节组数据
function this:GetSectionDatasByType(isCheckOnly)
    local activityTypeDatas = {}
    local activityCfgs = Cfgs.Section:GetGroup(SectionType.Activity)
    if activityCfgs then
        for _, cfg in pairs(activityCfgs) do
            local sectionData = DungeonMgr:GetSectionData(cfg.id)
            local openState1, openState2 = 0, 0
            if sectionData and sectionData:GetType() then
                activityTypeDatas[sectionData:GetType()] = activityTypeDatas[sectionData:GetType()] or {}
                if sectionData:IsShowOnly() and isCheckOnly then
                    if #activityTypeDatas[sectionData:GetType()] > 0 then
                        local id = activityTypeDatas[sectionData:GetType()][1]:GetID()
                        openState1 = activityTypeDatas[sectionData:GetType()][1]:GetOpenState()
                        openState2 = sectionData:GetOpenState()
                        if openState1 ~= openState2 then
                            if openState2 > openState1 then
                                activityTypeDatas[sectionData:GetType()][1] = sectionData
                            end
                        elseif id > sectionData:GetID() then
                            activityTypeDatas[sectionData:GetType()][1] = sectionData
                        end
                    else
                        table.insert(activityTypeDatas[sectionData:GetType()], sectionData)
                    end
                else
                    table.insert(activityTypeDatas[sectionData:GetType()], sectionData)
                end
            end
        end
    end
    return activityTypeDatas
end
---------------------------------------------rank----------------------------------------------
-- 本地清空
function this:ClearRankData(type)
    if type == nil then
        return
    end
    self.clearTime[type] = self.clearTime[type] or 0
    if (self.clearTime[type] <= TimeUtil:GetTime()) then
        self.cur_rank = {}
        self.rankInfos = {}
        self.myRank = {}
        self.myTurnNum = {}
        self.myScore = {}
        self.clearTime[type] = self.rankTime[type]
    end
end

-- 服务器发协议清空
function this:ClearRank(proto)
    if proto and proto.rank_type then
        self.cur_rank[proto.rank_type] = nil
        self.rankInfos[proto.rank_type] = nil
        self.myRank[proto.rank_type] = nil
        self.myScore[proto.rank_type] = nil
        self.myTurnNum[proto.rank_type] = nil
        EventMgr.Dispatch(EventType.Activity_Rank_Update)
    end
end

-- 获取排行榜信息
function this:GetRank(idx, type)
    PlayerProto:GetRank(idx, type)
end

function this:GetRankRet(proto)
    if proto and proto.rank_type then
        if (proto.data and #proto.data > 0) then
            self.rankInfos = self.rankInfos or {}
            self.rankInfos[proto.rank_type] = self.rankInfos[proto.rank_type] or {}
            for k, v in ipairs(proto.data) do
                local info = RankActivityInfo.New()
                info:Init(v)
                self.rankInfos[proto.rank_type][v.rank] = info
            end
        end
        self.myRank[proto.rank_type] = proto.rank or self.myRank[proto.rank_type]
        self.myScore[proto.rank_type] = proto.score or self.myScore[proto.rank_type]
        self.myTurnNum[proto.rank_type] = proto.turn_num or self.myTurnNum[proto.rank_type]
        self.rankTime[proto.rank_type] = proto.next_refresh_time and proto.next_refresh_time + 10 or 0 -- 延后10秒用于获取服务器数据
    end
    EventMgr.Dispatch(EventType.Activity_Rank_Update)
end

function this:GetRankInfos(type)
    local arr = {}
    if self.rankInfos and self.rankInfos[type] then
        for i, v in pairs(self.rankInfos[type]) do
            table.insert(arr, v)
        end
    end
    if (#arr > 0) then
        table.sort(arr, function(a, b)
            return a:GetRank() < b:GetRank()
        end)
    end
    self.cur_rank[type] = #arr
    return arr
end

function this:AddNextRankList(type)
    self.cur_rank[type] = self.cur_rank[type] or 0
    self.max_rank[type] = self.max_rank[type] or g_ExploringRankRule
    if (self.cur_rank[type] < (self.max_rank[type] - 1)) then
        local curPage = math.modf((self.cur_rank[type] / 11) + 1)
        curPage = curPage + 1 > 10 and curPage or curPage + 1
        self:GetRank(curPage, type)
    end
end

function this:RefreshRankList(type)
    self.cur_rank[type] = self.cur_rank[type] or 0
    local curPage = math.modf((self.cur_rank[type] / 11) + 1)
    self:GetRank(curPage, type)
end

function this:GetMyRank(type)
    local cfgDungeon = DungeonMgr:GetLastPassDungeon(type)
    local data = {
        id = PlayerClient:GetUid(),
        name = PlayerClient:GetName(),
        level = PlayerClient:GetLv(),
        rank = self.myRank[type] or 0,
        icon_id = PlayerClient:GetIconId(),
        icon_frame = PlayerClient:GetHeadFrame(),
        score = self.myScore[type] or 0,
        turn_num = self.myTurnNum[type] or 0,
        dupId = cfgDungeon and cfgDungeon.id or 0,
        sel_card_ix = PlayerClient:GetSex(),
        icon_title = PlayerClient:GetIconTitle()
        -- nDamage = self:GetDamage()
    }
    local info = RankActivityInfo.New()
    info:Init(data)
    return info
end

function this:GetRankTime(type)
    if self.rankTime[type] and self.rankTime[type] > TimeUtil.GetTime() then
        return self.rankTime[type] - TimeUtil.GetTime()
    end
    return 0
end

---------------------------------------------red----------------------------------------------
function this:CheckRed(sid)
    local sectionData = DungeonMgr:GetSectionData(sid)
    if sectionData and sectionData:GetOpen() then
        if sectionData:GetType() == SectionActivityType.Tower then
            return MissionMgr:CheckRed({eTaskType.TmpDupTower, eTaskType.DupTower})
        elseif sectionData:GetType() == SectionActivityType.Plot then
            local isRed = MissionMgr:CheckRed2(eTaskType.Story, sectionData:GetID())
            if not isRed then
                if sectionData:GetExploreId() then
                    local exData = ExplorationMgr:GetExData(sectionData:GetExploreId())
                    isRed = exData and exData:HasRevice()
                end
            end
            return isRed
        elseif sectionData:GetType() == SectionActivityType.TaoFa then
            local isRed = MissionMgr:CheckRed2(eTaskType.DupTaoFa, sectionData:GetID())
            if not isRed and self:HasBuffBattle(sid) then
                isRed = MissionMgr:CheckRed2(eTaskType.PointsBattle, sectionData:GetID())
            end
            return isRed
        elseif sectionData:GetType() == SectionActivityType.TotalBattle then
            return MissionMgr:CheckRed({eTaskType.StarPalace})
        elseif sectionData:GetType() == SectionActivityType.Rogue then
            if (RogueMgr:IsRed() or RogueSMgr:IsRed() or RogueTMgr:IsRed()) then
                return true
            end
        elseif sectionData:GetType() == SectionActivityType.GlobalBoss then
            return GlobalBossMgr:IsRed()
        elseif sectionData:GetType() == SectionActivityType.MultTeamBattle then
            return MultTeamBattleMgr:IsRed();
        end
    end
    return false
end

---------------------------------------------new----------------------------------------------
function this:IsNew()
    local isNew = false
    local newInfos = FileUtil.LoadByPath("section_activity_new") or {}
    for k, v in pairs(self.sectionNewDatas) do
        if v:GetOpen() and not newInfos[k] then
            isNew = true
            break   
        end
    end
    return isNew
end

function this:GetIsNew(sid)
    local newInfos = FileUtil.LoadByPath("section_activity_new") or {}
    if self.sectionNewDatas and self.sectionNewDatas[sid] and self.sectionNewDatas[sid]:GetOpen() and not newInfos[sid] then
        return true
    end
    return false
end

function this:SetNew(sid)
    local newInfos = FileUtil.LoadByPath("section_activity_new") or {}
    newInfos[sid] = 1
    FileUtil.SaveToFile("section_activity_new",newInfos)
end

return this
