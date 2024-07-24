-- 皮肤管理器
local RoleSkinInfo = require "RoleSkinInfo"

local this = MgrRegister("RoleSkinMgr")

-- typeNum  0:基础  1：变身  2：合体
-- 初始化表数据
function this:Init()
    self:Clear()
    local cfgs = Cfgs.CfgCardRole:GetAll()
    for i, v in pairs(cfgs) do
        for k, m in pairs(v.aCards) do
            self:InitCfgData(v.id, m)
        end
    end
    self:InitJieJin()

    this:GetSkins(0)
end

function this:Clear()
    self.datas = {}
    self.newAddCards = {}
end

-- 获取皮肤列表(已混合变身、同调的皮肤) --- 默认不包含解禁的皮肤
function this:GetDatas(cfgid, containJieJin)
    if (containJieJin) then
        return self.datas[cfgid]
    else
        local dic = {}
        local _dic = self.datas[cfgid]
        for k, v in pairs(_dic) do
            if (not v:CheckIsJieJin()) then
                dic[k] = v
            end
        end
        return dic
    end
end

-- 获取某张卡牌某个皮肤的对象
function this:GetRoleSkinInfo(cfgId, modelID)
    if cfgId and modelID then
        local list = self:GetDatas(cfgId);
        return list and list[modelID] or nil
    end
    return nil;
end

-- 皮肤数量
function this:GetSkinCount(cfgid)
    local count = 0
    local datas = self.datas[cfgid]
    if (datas) then
        for i, v in pairs(datas) do
            if (not v:CheckIsJieJin()) then
                count = count + 1
            end
        end
    end
    return count
end

-- 初始化解禁的数据
function this:InitJieJin()
    -- 队长
    for k, v in ipairs(g_InitRoleId) do
        local cfg = Cfgs.CardData:GetByID(v)
        local _data = self.datas[cfg.role_id]
        if (cfg.changeCardIds) then
            for n, m in ipairs(cfg.changeCardIds) do
                if (m[1] ~= v) then
                    self:InitCfgData(cfg.role_id, m[1], true, m[2])
                end
            end
        end
    end
    -- 队长机神 
    for k, v in ipairs(g_InitRoleId) do
        local cfg = Cfgs.CardData:GetByID(v)
        local _data = self.datas[cfg.add_role_id]
        if (cfg.allTcSkills) then
            local role_id = RoleTool.GetRoleCfgBySkillID(cfg.tcSkills[1]).role_id
            for n, m in ipairs(cfg.allTcSkills) do
                if (m[1] ~= cfg.tcSkills[1]) then
                    local monsterID = RoleTool.GetMonsterIDBySkillID(m[1])
                    local monsterCfg = Cfgs.MonsterData:GetByID(monsterID)
                    local _cfg = Cfgs.CardData:GetByID(monsterCfg.card_id)
                    self:InitCfgData(role_id, monsterCfg.card_id, true, m[2])
                end
            end
        end
    end
end

-- 初始化表数据
function this:InitCfgData(roleID, cardID, isJieJin, jiejinCondition)
    -- if (self.datas and self.datas[roleID]) then
    --     return
    -- end
    self.datas[roleID] = self.datas[roleID] or {}
    local _data = self.datas[roleID]

    local cfg = Cfgs.CardData:GetByID(cardID)
    if (not cfg) then
        return _data
    end
    -- 基础 1
    if (cfg.model) then
        if (not _data[cfg.model]) then
            local skin1 = RoleSkinInfo.New()
            skin1:Set(roleID, cfg.id, cfg.model, 1, CardSkinType.Break, isJieJin, jiejinCondition)
            _data[cfg.model] = skin1
        end
    end
    -- 突破 2345
    if (cfg.breakModels) then
        for n, m in ipairs(cfg.breakModels) do
            if (not _data[m]) then
                local skin2 = RoleSkinInfo.New()
                skin2:Set(roleID, cfg.id, m, n + 1, CardSkinType.Break, isJieJin, jiejinCondition)
                _data[m] = skin2
            end
        end
    end
    -- 额外
    if (cfg.skin) then
        for n, m in ipairs(cfg.skin) do
            if (not _data[m]) then
                local skin3 = RoleSkinInfo.New()
                skin3:Set(roleID, cfg.id, m, n, CardSkinType.Skin, isJieJin, jiejinCondition)
                _data[m] = skin3
            end
        end
    end
    return _data
end

-- --皮肤的l2d是否已开启
-- function this:CheckSkinL2DIsOpen(modelId)
-- 	if(not modelId) then
-- 		return false
-- 	end
-- 	local cfg = Cfgs.character:GetByID(modelId)
-- 	if(not cfg.live2d_openlv) then
-- 		return true
-- 	end
-- 	local cRoleInfo = CRoleMgr:GetData(cfg.role_id)
-- 	local breakLv = cRoleInfo:GetBreakLevel()
-- 	if(breakLv >= cfg.live2d_openlv) then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end

-- live2d是否存在
function this:CheckLive2DExist(modleID)
    local b = false
    local cfg = Cfgs.character:GetByID(modleID)
    if (cfg and cfg.l2dName) then
        b = true
    end
    return b
end

-- 设置是否默认开启L2D
function this:SetL2DState(isOn)
    self.l2dState = isOn;
end

function this:GetL2DState()
    return self.l2dState;
end

----------------------------------------------------------------------协议
-- 获取可用皮肤 -1 表示获取全部
function this:GetSkins(_cfgid)
    if (_cfgid) then
        local proto = {"PlayerProto:GetSkins", {
            cfgid = _cfgid
        }}
        NetMgr.net:Send(proto);
    end
end

-- 获取可用皮肤回调  info:模型表 id列表
function this:GetSkinsRet(proto)
    if (proto and proto.info) then
        for key, value in ipairs(proto.info) do
            local cardID = value.cfgid -- 卡牌id
            local cfg = Cfgs.CardData:GetByID(cardID)
            --
            -- self:InitCfgData(cfg.role_id, cardID)
            -- 
            if (value.info) then
                for i, v in ipairs(value.info) do
                    if (self.datas[cfg.role_id][v]) then
                        self.datas[cfg.role_id][v]:SetCanUse(true)
                    else
                        LogError("卡牌角色" .. cfg.role_id .. "的aCards未配置：" .. cardID)
                        -- local skin4 = RoleSkinInfo.New()
                        -- skin4:Set(cardID, v, i, CardSkinType.Add)
                        -- skin4:SetCanUse(true)
                        -- self.datas[cardID][v] = skin4
                    end
                end
            end
            -- new 
            if (proto.is_add and not CSAPI.IsViewOpen("RoleInfo")) then
                self.newAddCards[cardID] = 1
            end
        end
    end
    -- CRoleMgr:CheckNewSkin()
    -- EventMgr.Dispatch(EventType.Card_Skin_Get)
end

-- 使用皮肤
function this:UseSkin(_cid, _skin, _skin_a, _isL2d, _isL2d_a)
    local num1 = _isL2d and 2 or 1
    local num2 = _isL2d_a and 2 or 1
    local proto = {"PlayerProto:UseSkin", {
        cid = _cid,
        skin = _skin,
        skin_a = _skin_a,
        skinIsl2d = num1,
        skinIsl2d_a = num2
    }}
    NetMgr.net:Send(proto)
end

-- -- 设置是否新皮肤
-- function this:LookSkinRet(proto)
--     local info = CRoleMgr:GetData(proto.id)
--     if (info) then
--         info:RemoveNewSkin(proto.skin)
--     end
--     -- CRoleMgr:CheckNewSkin()
-- end

function this:CheckIsNewAdd(cardID)
    return self.newAddCards[cardID] ~= nil
end
function this:SetIsNewAdd(cardID)
    self.newAddCards[cardID] = nil
end

-----------------------------------解禁----------------------------------------------
-- 角色解禁皮肤（主角）
function this:AddRoleJieJinSkin(role_id, open_cards)
    local _data = self.datas[role_id]
    for k, v in pairs(open_cards) do
        local cfg = Cfgs.CardData:GetByID(v.id)
        if (_data[cfg.model]) then
            _data[cfg.model]:SetCanUse(true)
        end
    end
end
-- 机神解禁皮肤（主角机神）
function this:AddMechaJieJinSkin(add_role_id, open_mechas)
    local _data = self.datas[add_role_id]
    for k, v in pairs(open_mechas) do
        local monsterID = RoleTool.GetMonsterIDBySkillID(v.id)
        local model = Cfgs.MonsterData:GetByID(monsterID).model
        if (_data[model]) then
            _data[model]:SetCanUse(true)
        end
    end
end

return this
