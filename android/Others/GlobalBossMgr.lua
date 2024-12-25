GlobalBossMgr = MgrRegister("GlobalBossMgr")
local this = GlobalBossMgr;
GlobalBossData = require "GlobalBossData"

function this:Init()
    -- self:Clear()
end

function this:Clear()
    self.info = {}
    self.cfg = nil
    self.hp = 0
    self.maxHp = 0
    self.rank = 0
    self.useCount = 0
    self.data = nil

    --rank
    self.clearTime = 0
    self.cur_rank = 0
    self.rankInfos = {} 
    self.myRank = 0
    self.myScore = 0
    self.max_rank = 0
end

function this:SetInfo(proto)
    local isOffset = false
    if proto then
        self.info = {}
        self.info.sTime = proto.beginTime
        self.info.eTime = proto.endTime
        if proto.bossId then
            if self.data == nil then
                local data = GlobalBossData.New()
                data:InitCfg(proto.bossId)
                self.data = data
            elseif self.data:GetID() ~= proto.bossId then
                self.data:InitCfg(proto.bossId)
                isOffset = true
            end
        end
    end
    EventMgr.Dispatch(EventType.GlobalBoss_Data_Update,isOffset)
end

--世界boss活动信息
function this:GetInfo()
    return self.info
end

function this:GetData()
    return self.data
end

--活动开启
function this:IsOpen()
    if self.info.sTime and self.info.eTime then
        return TimeUtil:GetTime() >self.info.sTime and TimeUtil:GetTime() <= self.info.eTime
    end
    return false
end

--剩余时间
function this:GetActiveTime()
    if self.info.eTime and TimeUtil:GetTime() <= self.info.eTime then
        return self.info.eTime - TimeUtil:GetTime()
    end
    return 0
end

function this:SetData(proto)
    if proto then
        self.hp = proto.hp and math.floor(proto.hp) or 0
        self.maxHp = proto.maxHp and math.floor(proto.maxHp) or 0
        self.rank = proto.rank or 0
        self.useCount = proto.challengeTimes or 0
    end
    EventMgr.Dispatch(EventType.GlobalBoss_Data_Update)
end

--血量
function this:GetHp()
    return self.hp < 0 and 0 or self.hp
end

--血量上限
function this:GetMaxHp()
    return self.maxHp < 0 and 0 or self.maxHp
end

--界面排位
function this:GetRankIdx()
    return self.rank
end

--挑战次数
function this:GetCount()
    local cur,max = 0,0
    if self.data and self.data:GetMaxCount() > 0 then
        max = self.data:GetMaxCount()
        cur = max - self.useCount
    end
    return cur,max
end

--击败boss
function this:IsKill()
    return self.hp <= 0
end

-- 退出战斗
function this:Quit()
    SceneLoader:Load("MajorCity", function()
        CSAPI.OpenView("Section",{type = 4})
        CSAPI.OpenView("GlobalBossView")
    end)
end

------------------------------------rank------------------------------------
--本地清空
function this:ClearRankData(type)
    self.clearTime = self.clearTime or 0
    if(self.clearTime <= TimeUtil:GetTime()) then 
        self.cur_rank = 0
        self.rankInfos = {}
        self.myRank = 0
        self.myScore = 0
        self.clearTime = TimeUtil:GetTime() + 1
    end 
end

--获取排行榜信息
function this:GetRank(idx)
    FightProto:GetGlobalBossRank(idx)
end

function this:GetRankRet(proto)
    self.rankInfos = self.rankInfos or {}
    if proto then
        if(proto.data and #proto.data > 0) then
            for k, v in ipairs(proto.data) do
                local info = RankActivityInfo.New()
                info:Init(v)
                self.rankInfos[v.rank] = info
            end
        end
        self.myRank = proto.rank
        self.myScore = proto.nDamage
    end
    EventMgr.Dispatch(EventType.GlobalBoss_Rank_Update)
end

--排行榜列表信息
function this:GetRankInfos()
    local arr = {}
    self.rankInfos = self.rankInfos or {}
    if #self.rankInfos> 0 then
        for i, v in pairs(self.rankInfos) do
            table.insert(arr, v)
        end      
    end
    if(#arr > 0) then
        table.sort(arr, function(a, b)
            return a:GetRank() < b:GetRank()
        end)
    end	
	self.cur_rank = #arr
	return arr
end

function this:AddNextRankList()
	self.cur_rank = self.cur_rank or 0
	self.max_rank = self.max_rank or g_ExploringRankRule
	if(self.cur_rank < (self.max_rank - 1)) then
        local curPage = math.modf((self.cur_rank / 11) + 1)
        curPage = curPage + 1 > 10 and curPage or curPage + 1
		self:GetRank(curPage)
	end
end

function this:RefreshRankList()
    self.cur_rank = self.cur_rank or 0
    local curPage = math.modf((self.cur_rank / 11) + 1)
    self:GetRank(curPage)
end

--自身排行榜信息
function this:GetMyRank(type)
    local data = {
        id = PlayerClient:GetUid(),
        name = PlayerClient:GetName(),
        level = PlayerClient:GetLv(),
        rank = self.myRank or 0,
        icon_id = PlayerClient:GetIconId(),
        icon_frame = PlayerClient:GetHeadFrame(),
        score = self.myScore or 0,
        sel_card_ix = PlayerClient:GetSex(),
        icon_title = PlayerClient:GetIconTitle(),
        -- nDamage = self:GetDamage()
    }
    local info = RankActivityInfo.New()
    info:Init(data)
    return info
end

return this