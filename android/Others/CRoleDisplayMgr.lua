-- 打开界面是设置一份复制的数据，离开时赋值到真实数据并移除复制的数据，避免频繁交互
local CRoleDisplayData = require("CRoleDisplayData")
local this = MgrRegister("CRoleDisplayMgr")

function this:Init()
    self:Clear()
    self:InitDatas()
    PlayerProto:GetNewPanel(true)
end

function this:Clear()
    self.panels = {}
    self.panelRet = {}
    self:ClearCopyData()
end

function this:GetDatas()
    return self.panels
end
function this:GetPanelRet()
    return self.panelRet
end
function this:InitDatas()
    self.panels = {}
    for k = 1, 6 do
        local _data = CRoleDisplayData.New()
        _data:InitIndex(k)
        self.panels[k] = _data
    end
end

-- 服务器数据
function this:GetNewPanelRet(proto)
    if (proto.panels) then
        for k, v in pairs(proto.panels) do
            self.panels[k]:InitRet(v)
        end
    end
    self.panelRet = proto
    self.panelRet.panels = nil
end
-- 服务器数据
function this:SetNewPanelUsingRet(proto)
    self.panelRet.using = proto.using
    self.panelRet.update_time = proto.update_time
    EventMgr.Dispatch(EventType.Player_Select_Card)
end

--------------------------------------------复制的数据------------------------------------------------------------

function this:ClearCopyData()
    self.c_panels = {}
    self.c_panelRet = {}
end

function this:GetCopyDatas()
    self.c_panels = {}
    for k, v in pairs(self.panels) do
        self.c_panels[k] = self:GetCopyData(v)
    end
    return self.c_panels
end
function this:GetCopyData(data)
    local _data = CRoleDisplayData.New()
    _data:InitIndex(data:GetIndex())
    _data:InitRet(table.copy(data:GetRet()))
    return _data
end

function this:GetCopyPanelRet()
    self.c_panelRet = table.copy(self:GetPanelRet())
    return self.c_panelRet
end

-- 当前使用
function this:GetCopyUsing()
    return self.c_panelRet.using or 1
end
function this:SetCopyUsing(index)
    self.c_panelRet.using = index
end

-- -- 保存修改的数据并清除复制的数据
-- function this:CheckSave(c_datas, c_panelRet)
--     if (FuncUtil.TableIsSame(c_panelRet, self.panelRet) and FuncUtil.TableIsSame(c_datas, self.panels)) then
--         return -- 数据无改动
--     end
--     local panels = {}
--     for k, v in pairs(c_datas) do
--         panels[v:GetIndex()] = v:GetRet()
--     end
--     PlayerProto:SetNewPanel(panels, c_panelRet.setting, c_panelRet.random, c_panelRet.using)
--     self:ClearCopyData()
-- end

--------------------------------------------通用函数------------------------------------------------------------
function this:SetPlayInID(_id)
    self.oldPlayInID = _id
end
-- 是否与上一次播放的l2d相同
function this:CheckIsPlayIn(_id)
    return self.oldPlayInID ~= nil and self.oldPlayInID == _id
end
function this:IsFirst()
    if (not self.isFirst) then
        self.isFirst = 1
        return true
    end
    return false
end

-- 当前选择的槽位
function this:GetCurData()
    return self.panels[self.panelRet.using]
end
function this:GetCopyCurData()
    local curData = self:GetCurData()
    if (curData) then
        return self:GetCopyData(curData)
    end
    return nil
end

-- 当前选择的top的id
function this:GetTopID(data)
    if (data) then
        if (data:GetDetail(1).top) then
            return data:GetIDs()[1]
        end
        if (data:GetDetail(2).top) then
            return data:GetIDs()[2]
        end
    end
    return nil
end

-- 数据真实长度
function this:GetRealLen()
    local len = 0
    for k, v in pairs(self.panels) do
        if (v:CheckIsEntity()) then
            len = len + 1
        end
    end
    return len
end

-- 按顺序下一个下标（有数据的）
function this:GetNextUsing()
    if (self:GetRealLen() <= 1) then
        return self.panelRet.using
    end
    local using = self.panelRet.using
    while using < 7 do
        using = using + 1
        if (using > 6) then
            using = 1
        end
        if (self.panels[using]:CheckIsEntity()) then
            return using
        end
    end
end

-- 随机一个下标
function this:GetRandomUsing()
    if (self:GetRealLen() <= 1) then
        return self.panelRet.using
    end
    local list = {}
    local using = self.panelRet.using
    for k, v in pairs(self.panels) do
        if (k ~= using and v:CheckIsEntity()) then
            table.insert(list, k)
        end
    end
    local num = CSAPI.RandomInt(1, #list)
    return list[num]
end

function this:Change()
    local nextUsing = self.panelRet.random == 0 and self:GetNextUsing() or self:GetRandomUsing()
    PlayerProto:SetNewPanelUsing(nextUsing)
end

function this:Change2()
    local nextUsing = self.panelRet.random == 0 and self:GetNextUsing() or self:GetRandomUsing()
    local _data = self.panels[nextUsing]
    local _id = _data:GetIDs()[_data:GetTopSlot()]
    self:SetPlayInID(_id)
    PlayerProto:SetNewPanelUsing(nextUsing)
end


-- 登录返回
-- 如果是登录轮换，则需要换一下
function this:LoginCheck()
    if (self:GetRealLen() > 1) then
        if (self.panelRet.setting == 2) then
            -- 每次登录更换
            self:Change()
        elseif (self.panelRet.setting == 1) then
            -- 每天 
            if (not TimeUtil:IsSameDay(self.panelRet.update_time, TimeUtil:GetTime())) then
                self:Change()
            end
        end
    end
end

-- 打开Main界面修改后的返回 触发
-- 如果有改动，
-- 1、如果轮换选返回主界面触发，那么不做处理，让NormalCheck2处理(但长度要大于2，如果修改后长度小于1则需要抛事件处理)
-- 2、如过是其他触发，那么只判断当前选择的是否改动，是的话则抛事件
function this:NormalCheck1(old_curData)
    if (self.panelRet.setting ~= 3 or self:GetRealLen()<=1) then
        if (old_curData ~= nil and not FuncUtil.TableIsSame(old_curData, self:GetCurData())) then
            EventMgr.Dispatch(EventType.Player_Select_Card)
        end
    end
end
-- 返回主界面 触发
function this:NormalCheck2()
    if (self.panelRet.setting == 3) then
        if (self:GetRealLen() > 1) then
            self:Change()
        end
    end
end

-- 更换队长
function this:ChangeLeader(ocfgid)
    local cfg = Cfgs.CardData:GetByID(ocfgid)
    local skinsDic = RoleSkinMgr:GetDatas(cfg.role_id, true) or {}
    for k, v in pairs(self.panels) do
        local ids = v:GetIDs()
        for p, q in ipairs(ids) do
            if (q ~= 0 and skinsDic[q] ~= nil) then
                -- 使用了旧队长的某皮肤，替换成现队长的皮肤
                local leader = RoleMgr:GetLeader()
                ids[p] = leader:GetSkinID()
                local panels = {}
                for k, v in pairs(self.panels) do
                    panels[v:GetIndex()] = v:GetRet()
                end
                PlayerProto:SetNewPanel(panels, self.panelRet.setting, self.panelRet.random, self.panelRet.using,
                    function(old_curData)
                        if (old_curData) then
                            local curData = self:GetCurData()
                            local ids = curData:GetIDs()
                            local old_topID = self:GetTopID(old_curData)
                            for n, m in ipairs(ids) do
                                if (old_topID == m) then
                                    EventMgr.Dispatch(EventType.Player_Select_Card)
                                    break
                                end
                            end
                        end
                    end)
                break
            end
        end
    end
end

return this
