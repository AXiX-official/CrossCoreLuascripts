TowerMgr = MgrRegister("TowerMgr")
local this = TowerMgr;

function this:Init()
    self:Clear()
    PlayerProto:GetNewTowerResetCnt()
    PlayerProto:GetNewTowerCardInfo()
end

function this:SetCardInfos(proto)
    if proto then
        if proto.card_infos and #proto.card_infos > 0 then
            self.cardInfos=self.cardInfos or {};
            self.cardInfos[proto.sid]=self.cardInfos[proto.sid] or {};
            for i, v in ipairs(proto.card_infos) do
                self.cardInfos[proto.sid][v.cid] = v
            end
        end
    end
    if proto and proto.is_finish then
        EventMgr.Dispatch(EventType.NewTower_CardInfo_Update_Finish)
    end
end

function this:SetAssistCardInfos(proto)
    if proto and proto.assit_card_infos then
        self.assits = self.assits or {}
        for k, v in ipairs(proto.assit_card_infos) do
            if next(v.assit_card_info)==nil then
                self.assits[v.sid]=nil
            else
                self.assits[v.sid]=v.assit_card_info
            end
        end
        EventMgr.Dispatch(EventType.NewTower_AssistCardInfo_Update_Finish)
    end
end

function this:GetCardInfos()
    return self.cardInfos
end

--获取角色信息
function this:GetCardInfo(cid,fuid,sectionId)
    local info = {
        cid = cid,
        tower_hp = 100,
        tower_sp = 0
    }
    if self.assits and sectionId and self.assits[sectionId] and fuid and self.assits[sectionId].fuid==fuid and self.assits[sectionId].cid==cid then--获取锁定的助战卡牌
        return self.assits[sectionId]
    elseif fuid~=nil or sectionId==nil or self.cardInfos[sectionId]==nil or (self.cardInfos[sectionId] and self.cardInfos[sectionId][cid] == nil) then
        return info
    end
    return self.cardInfos[sectionId][cid]
end

function this:GetLockAssistInfo(sectionId)
    if sectionId and self.assits  then
        return self.assits[sectionId];
    end
    return nil;
end

function this:SetDatas(proto)
    if proto and proto.dup_monster_infos then
         for k, v in pairs(proto.dup_monster_infos) do
            if self.datas[v.id] then
                self.datas[v.id]:Init(v)
            else
                local data= TowerData.New()
                data:Init(v)
                self.datas[v.id] = data
            end
         end
    end
end

--副本id
function this:GetData(id)
    return self.datas[id] or self:GetNewData(id)
end

function this:GetNewData(_id)
    local data= TowerData.New()
    data:Init({id = _id})
    self.datas[_id] = data
    return data
end

--isOrder:顺序
function this:GetArr(sectionId,isOrder)
    local _datas = {}
    local cfgs= Cfgs.MainLine:GetGroup(sectionId)
    if cfgs then
        for k, v in pairs(cfgs) do
            table.insert(_datas, self:GetData(v.id))
        end
    end
    if #_datas>0 then
        table.sort(_datas, function(a,b)
            if isOrder then
                return a:GetID() < b:GetID()
            else
                return a:GetID() > b:GetID()
            end
        end)
    end
    return _datas
end

function this:SetResetCnt(proto)
    if proto and proto.reset_cnt then
        for i, v in ipairs(proto.reset_cnt) do
            self.reset_cnt[v.sid] = v.num
        end
    end
    EventMgr.Dispatch(EventType.NewTower_ResetCnt_Update)
end

--获取当天重置次数
function this:GetResetCnt(sid)
    return self.reset_cnt and self.reset_cnt[sid] or 0
end

--获取通关数
function this:GetCount(group)
    local cur, max = 0, 0
    local cfgs = Cfgs.MainLine:GetGroup(group)
    if cfgs then
        for k, v in pairs(cfgs) do
            local dungeonData = DungeonMgr:GetDungeonData(v.id)
            if dungeonData and dungeonData:IsPass() then
                cur = cur + 1
            end
            max = max + 1
        end
    end
    return cur, max
end

--获取所有通关数
function this:GetCounts()
    local tab = {}
    local datas = DungeonMgr:GetActivitySectionDatas(SectionActivityType.NewTower)
    if #datas > 0 then
        local _cur, _max = 0, 0
        for i, v in ipairs(datas) do
            _cur, _max = self:GetCount(v:GetID())
            table.insert(tab, {
                cur = _cur,
                max = _max
            })
        end
    end
    return tab
end

function this:SetSectionId(_id)
    self.sectionId = _id
end

function this:GetSectionId()
    return self.sectionId
end

function this:ClearSectionId()
    self.sectionId = nil
end

function this:Clear()
    self.datas = {}
    self.reset_cnt = {}
    self.cardInfos = {}
    self.assits = nil
    self.sectionId = nil
end

return this
