local this = MgrRegister("TotalBattleMgr")
TotalBattleRankInfo = require "TotalBattleRankInfo"

function this:Init()
    self:Clear()
    PlayerProto:GetStarPalaceInfo()
end

function this:Clear()
    self.clearTime = 0
    self.cur_rank = {} 
    self.rankInfos = {} 
    self.myRank = {}
    self.myScore = {}
    self.max_rank = {}
    self.rankTime = 0

    self:ClearInfo()
    self.scoreInfos = {}
end

function this:SetInfo(proto)
    if proto then
        if proto.dupId then
            self.fightInfo = {
                id = proto.dupId,
                bossHp = proto.boss_hp,
            }
            self.fightTime = proto.stopTime or 0
            self.isFighting = self.fightTime > 0
        end
        if proto.infos and #proto.infos>0 then
            for i, v in ipairs(proto.infos) do
                if v.groupId then
                    if self.scoreInfos[v.groupId] == nil then
                        self.scoreInfos[v.groupId] = {
                            info = {},
                            rank = 0
                        }
                    end
                    self.scoreInfos[v.groupId].rank = v.ranks or self.scoreInfos[v.groupId].rank
                    if v.starDupInfos and #v.starDupInfos>0 then
                        for k, m in ipairs(v.starDupInfos) do
                            if self.scoreInfos[v.groupId].info[m.dupId] ==nil then
                                self.scoreInfos[v.groupId].info[m.dupId] = {
                                    score = 0,
                                    maxScore = 1,
                                }
                            end
                            self.scoreInfos[v.groupId].info[m.dupId].score = m.score or self.scoreInfos[v.groupId].info[m.dupId].score
                            self.scoreInfos[v.groupId].info[m.dupId].maxScore = m.history_max_score or self.scoreInfos[v.groupId].info[m.dupId].maxScore
                        end
                    end
                    self.rankTime = v.next_refresh_time and (v.next_refresh_time + 10) or self.rankTime --延后10秒用于获取服务器数据
                end
            end
        end
        if proto.isReset and proto.isReset == true then
            self:ClearInfo()
        end
        EventMgr.Dispatch(EventType.TotalBattle_Rank_Update)
    end
end

--获取章节排行榜信息
function this:GetRankInfo(sid)
    return self.scoreInfos and self.scoreInfos[sid] and self.scoreInfos[sid].rank
end

--有关卡未打完
function this:IsFighting()
    return self.isFighting
end

--获取当前正在进行的副本信息
function this:GetFightInfo()
    if self:IsFighting() then
        return self.fightInfo
    end
    return nil
end

--战斗剩余时间
function this:GetFightTime()
    if self.isFighting and self.fightTime > TimeUtil:GetTime() then
        return self.fightTime - TimeUtil:GetTime()
    end
    return 0
end

function this:GetFightBossHp()
    return self.fightInfo and self.fightInfo.bossHp or 0
end

function this:GetScore(sid,id)
    local cur,max = 0,1
    if sid and id and self.scoreInfos and self.scoreInfos[sid] and self.scoreInfos[sid].info and self.scoreInfos[sid].info[id] then
        cur = self.scoreInfos[sid].info[id].score
        max = self.scoreInfos[sid].info[id].maxScore
    end
    return cur,max
end

function this:GetSectionScore(sid)
    local score = 0
    if sid and self.scoreInfos and self.scoreInfos[sid] and self.scoreInfos[sid].info then
        for k, v in pairs(self.scoreInfos[sid].info) do
            score = score + v.maxScore
        end
    end
    return score
end

--清理缓存
function this:ClearInfo()
    self.fightInfo = nil
    self.cardCache = nil
    self.fightTime = 0
    self.isFighting = false
end

---------------------------------------------card----------------------------------------------
function this:CardCacheAdd(proto)
    if proto then
        self.cardCache = self.cardCache or {}
        if proto.cards and #proto.cards > 0 then
            for i, v in ipairs(proto.cards) do
                self.cardCache[v.c_id] = 1
            end
        end
        if proto.f_cards and #proto.f_cards > 0 then
            for i, v in ipairs(proto.f_cards) do
                local cid = FormationUtil.FormatAssitID(v.id,v.c_id)
                self.cardCache[cid] = 1
            end
        end
    end
end

function this:IsShowCard(_cid)
    if self.cardCache and self.cardCache[_cid] then
        return false
    end
    return true
end
---------------------------------------------rank----------------------------------------------

function this:ClearRankData()
    if(self.clearTime <= TimeUtil:GetTime()) then 
        self.cur_rank = {}
        self.rankInfos = {}
        self.clearTime = self.rankTime
    end 
end

--获取排行榜信息
function this:GetRank(idx,sid)
    PlayerProto:GetStarRank(idx,sid)
end

function this:GetRankRet(proto)
    if proto and proto.rank_type then
        if(proto.data and #proto.data > 0) then
            self.rankInfos = self.rankInfos or {}
            self.rankInfos[proto.rank_type] = self.rankInfos[proto.rank_type] or {}
            for k, v in ipairs(proto.data) do
                local info = TotalBattleRankInfo.New()
                info:Init(v)
                self.rankInfos[proto.rank_type][v.rank] = info
            end
        end
        self.myRank[proto.rank_type] = proto.rank or self.myRank[proto.rank_type]
        self.myScore[proto.rank_type] = proto.score or self.myScore[proto.rank_type]
    end
    EventMgr.Dispatch(EventType.TotalBattle_Rank_Update)
end

function this:GetRankInfos(sid)
    local arr = {}
    if self.rankInfos and self.rankInfos[sid] then
        for i, v in pairs(self.rankInfos[sid]) do
            table.insert(arr, v)
        end      
    end
    if(#arr > 0) then
        table.sort(arr, function(a, b)
            return a:GetRank() < b:GetRank()
        end)
    end	
	self.cur_rank[sid] = #arr
	return arr
end

function this:AddNextRankList(sid)
	self.cur_rank[sid] = self.cur_rank[sid] or 0
	self.max_rank[sid] = self.max_rank[sid] or g_ExploringRankRule
	if(self.cur_rank[sid] < (self.max_rank[sid] - 1)) then
        local curPage = math.modf((self.cur_rank[sid] / 11) + 1)
        curPage = curPage + 1 > 10 and curPage or curPage + 1
		self:GetRank(curPage,sid)
	end
end

function this:RefreshRankList(sid)
    self.cur_rank[sid] = self.cur_rank[sid] or 0
    local curPage = math.modf((self.cur_rank[sid] / 11) + 1)
    self:GetRank(curPage,sid)
end

function this:GetMyRank(sid)
    local cfgDungeon = DungeonMgr:GetLastPassDungeon(sid)
    local data = {
        id = PlayerClient:GetUid(),
        name = PlayerClient:GetName(),
        level = PlayerClient:GetLv(),
        rank = self.myRank[sid] or 101,
        icon_id = PlayerClient:GetIconId(),
        icon_frame = PlayerClient:GetHeadFrame(),
        score = self.myScore[sid] or 0,
        dupId = cfgDungeon and cfgDungeon.id or 0,
        -- sel_card_ix = PlayerClient:GetSex()
        -- nDamage = self:GetDamage()
    }
    local info = TotalBattleRankInfo.New()
    info:Init(data)
    return info
end

function this:GetRankTime()
    if self.rankTime and self.rankTime > TimeUtil.GetTime() then
        return self.rankTime - TimeUtil.GetTime()
    end
    return 0
end

return this