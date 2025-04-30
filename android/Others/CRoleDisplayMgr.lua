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
    self.panelRet = {} -- PlayerProto:GetNewPanelRet的内容但不包含panels
    self:ClearCopyData()

    self.random_panels = {}
    self.random_idx = 7
end

function this:InitDatas()
    self.panels = {}
    for k = 1, 6 do
        local _data = CRoleDisplayData.New()
        _data:InitIndex(k)
        self.panels[k] = _data
    end
end

-----------------------------------------------------------------------------------------------------------

function this:GetDatas()
    return self.panels
end
function this:GetData(idx)
    return self.panels[idx]
end

function this:GerRamdomDatas()
    return self.random_panels
end
function this:GerRamdomData(idx)
    return self.random_panels[idx]
end

--
function this:GetPanelRet()
    return self.panelRet
end

-- 获取随机看板
function this:GetRandomPanels(random_type)
    local arr = {}
    if (random_type == nil or random_type == eRandomPanelType.ALL) then
        for k, v in pairs(self.random_panels) do
            table.insert(arr, v)
        end
    else
        for k, v in pairs(self.random_panels) do
            if ((random_type == eRandomPanelType.SINGLE and v:GetTy() == 2) or
                (random_type == eRandomPanelType.DOUBLE and v:GetTy() == 3)) then
                table.insert(arr, v)
            end
        end
    end
    return arr
end

function this:GetRandomType()
    return self.panelRet.random_type or eRandomPanelType.SINGLE
end

function this:GetRandomIdx()
    return self.random_idx
end

function this:IsRandom()
    return self:GetPanelRet().random == 1
end

function this:GetUsingData()
    if (self:IsRandom()) then
        return self.random_panels[self:GetPanelRet().using]
    else
        return self.panels[self:GetPanelRet().using]
    end
end

-----------------------------------------------------------------------------------------------------------

-- 服务器数据 2
function this:GetNewPanelRet(proto)
    if (proto.panels) then
        for k, v in pairs(proto.panels) do
            self.panels[k]:InitRet(v)
        end
    end
    if (proto.random_panel) then
        if (self.random_panels[proto.random_panel.idx]) then
            self.random_panels[proto.random_panel.idx]:InitRet(proto.random_panel)
        end
    end
    self.panelRet = proto
    self.panelRet.panels = nil
    self.panelRet.random_panel = nil
end
-- 服务器数据 1
function this:GetRandomPanelRet(proto)
    if (proto.random_panels) then
        for k, v in pairs(proto.random_panels) do
            local _data = CRoleDisplayData.New()
            _data:InitIndex(v.idx, v.ty)
            _data:InitRet(v)
            self.random_panels[v.idx] = _data
        end
    end
    if (proto.finish) then
        self.random_idx = proto.random_idx
    end
end

-- 选择新看板返回
function this:SetNewPanelUsingRet(proto, noIn)
    self.panelRet.using = proto.using
    self.panelRet.update_time = proto.update_time
    if (proto.random_panel and proto.random_panel.ty ~= 1 and self.random_panels[proto.random_panel.idx]) then
        self.random_panels[proto.random_panel.idx]:InitRet(proto.random_panel)
    end
    -- 取消入场动画
    if (noIn) then
        local _data = nil
        if (proto.random_panel) then
            _data = self.random_panels[self.panelRet.using]
        else
            _data = self.panels[self.panelRet.using]
        end
        if (_data) then
            local _id = _data:GetIDs()[_data:GetTopSlot()]
            self:SetPlayInID(_id)
        end
    end
    EventMgr.Dispatch(EventType.Player_Select_Card)
end

-- 设置随机看板返回
function this:SetRandomPanelRet(proto)
    self.random_idx = proto.random_idx
    --
    if (not self.random_panels[proto.random_panel.idx]) then
        local _data = CRoleDisplayData.New()
        _data:InitIndex(proto.random_panel.idx)
        self.random_panels[proto.random_panel.idx] = _data
    end
    self.random_panels[proto.random_panel.idx]:InitRet(proto.random_panel)
end

-- 获取随机看板详细
function this:GetRandomPanelDetailRet(proto)
    if (self.random_panels[proto.idx]) then
        self.random_panels[proto.idx]:InitRet(proto.random_panel)
    end
end

-- 设置当前看板随机类型返回
function this:SetPanelRandomTypeRet(random_type)
    self.panelRet.random_type = random_type
end

-- 移除随机看板返回
function this:RemoveRandomPanelRet(idx)
    self.random_panels[idx] = nil
end
--------------------------------------------临时当前使用的数据(方便切换随机看板时使用)------------------------------------------------------------

function this:SetRandon(random, using)
    self.panelRet.random = random
    self.panelRet.using = using
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
    if (self:IsRandom()) then
        return self.random_panels[self.panelRet.using]
    else
        return self.panels[self.panelRet.using]
    end
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
    if (self:IsRandom()) then
        local arr = self:GetRandomPanels(self:GetRandomType())
        len = #arr
    else
        for k, v in pairs(self.panels) do
            if (v:CheckIsEntity()) then
                len = len + 1
            end
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
-- function this:GetRandomUsing()
--     if (self:GetRealLen() <= 1) then
--         return self.panelRet.using
--     end
--     local list = {}
--     local using = self.panelRet.using
--     for k, v in pairs(self.panels) do
--         if (k ~= using and v:CheckIsEntity()) then
--             table.insert(list, k)
--         end
--     end
--     local num = CSAPI.RandomInt(1, #list)
--     return list[num]
-- end

-- 随机一个
function this:GetRandomUsing(random_type)
    local arr = {}
    if (random_type == eRandomPanelType.ALL) then
        arr = self.random_panels
    else
        arr = self:GetRandomPanels(random_type)
    end
    local ids = {}
    for k, v in pairs(arr) do
        if (v:GetIdx() ~= self.panelRet.using) then
            table.insert(ids, v:GetIdx())
        end
    end
    local len = #ids
    local num = CSAPI.RandomInt(1, len)
    return ids[num]
end

-- 登录
function this:Change()
    local nextUsing = self:IsRandom() and self:GetRandomUsing(self:GetRandomType()) or self:GetNextUsing()
    PlayerProto:SetNewPanelUsing(nextUsing, false)
end

-- 主界面的切换
function this:Change2()
    local nextUsing = self:IsRandom() and self:GetRandomUsing(self:GetRandomType()) or self:GetNextUsing()
    local _data = self:IsRandom() and self.random_panels[nextUsing] or self.panels[nextUsing]
    PlayerProto:SetNewPanelUsing(nextUsing, true)
end

-- 切到另一页的任意一个
function this:Change3(_type)
    local arr = self:GetRandomPanels(_type)
    PlayerProto:SetNewPanelUsing(arr[1]:GetIdx(), false)
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
-- 1、如果轮换选返回主界面触发，那么不做处理，让NormalCheck2处理(但长度要大于2，如果修改后长度小于1则需要抛事件处理)
-- 2、如过是其他触发(不换，每天，每次登录)，那么只判断当前选择的是否改动，是的话则抛事件
function this:NormalCheck1(old_curData)
    self.check1 = nil
    if (self.panelRet.setting ~= 3 or self:GetRealLen() <= 1) then
        if (old_curData ~= nil and not FuncUtil.TableIsSame(old_curData, self:GetCurData())) then
            EventMgr.Dispatch(EventType.Player_Select_Card)
            self.check1 = 1
        end
    end
end

-- -- 返回主界面 触发
function this:NormalCheck2()
    self.check2 = nil
    if (self.panelRet.setting == 3 and self:GetRealLen() > 1) then
        self:Change()
        self.check2 = 1
    end
    --
    return self:CheckPlayIn()
end

-- 如果是完整模式，每次关闭界面都要播放一次入场，这里在无改动的情况下抛时事件处理
function this:CheckPlayIn()
    local isPlay = false
    if (not self.check1 and not self.check2 and CRoleDisplayMgr:GetSpineInType() == 2) then
        EventMgr.Dispatch(EventType.Player_Select_Card)
        isPlay = true
    end
    self.check1 = nil
    self.check2 = nil
    if (not isPlay) then
        isPlay = self:CheckCRoleDisplayS()
    end
    return isPlay
end

function this:SetCRoleDisplayS()
    if (not self.old_curDataS) then
        local curDisplayData = CRoleDisplayMgr:GetCurData()
        self.old_curDataS = table.copy(curDisplayData:GetRet())
    end
end
-- 是否只是改变了随机看板的内容
function this:CheckCRoleDisplayS()
    local isPlay = false
    if (self.old_curDataS) then
        local curDisplayData = CRoleDisplayMgr:GetCurData()
        if (not FuncUtil.TableIsSame(self.old_curDataS, curDisplayData:GetRet())) then
            EventMgr.Dispatch(EventType.Player_Select_Card)
            isPlay = true
        end
    end
    self.old_curDataS = nil
    return isPlay
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

--------------------------------------------更多设置------------------------------------------------------------
-- 入场动画播放设置 1：简洁模式  2：完整模式 3：例登模式（默认）4：例次模式
function this:GetSpineInType()
    local key = "spineintype"
    local num = PlayerPrefs.GetInt(key) or 0
    if (num == 0) then
        num = 3
        PlayerPrefs.SetInt(key, num)
    end
    return num
end
function this:SetSpineInType(num)
    local key = "spineintype"
    PlayerPrefs.SetInt(key, num)
end
-----------------------------------------------------------------------------------------------------

-- 随机看板的数据结构
function this:CreateRandomData(idx, ty)
    local _data = CRoleDisplayData.New()
    _data:InitIndex(idx, ty)
    return _data
end

-- 能否随机
function this:CheckCanRandom()
    local arr = self:GetRandomPanels(self:GetRandomType())
    if (#arr > 0) then
        return true, arr[1]:GetIdx()
    end
    return false
end

-- 获取从1-6位置第一个有用的位置
function this:GetUsefulUsing()
    for k = 1, 6 do
        local item = self.c_panels[k]
        if (item and item:CheckIsEntity()) then
            return k
        end
    end
    return self.panelRet.using
end

--演习 模拟创建基数据
function this:CreateDisplayData(_modelID,_live2d)
    local _data = CRoleDisplayData.New()
    _data:InitIndex(1,4)
    _data:GetRet().ids = {_modelID}
    _data:GetDetail(1).live2d = _live2d
    _data:GetDetail(1).top = true
    return _data
end


return this
