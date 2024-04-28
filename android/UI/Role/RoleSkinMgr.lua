-- 皮肤管理器
local RoleSkinInfo = require "RoleSkinInfo"

local this = MgrRegister("RoleSkinMgr")

-- typeNum  0:基础  1：变身  2：合体
-- 初始化表数据
function this:Init()
    self.datas = {}
    local cfgs = Cfgs.CardData:GetAll()
    for i, v in pairs(cfgs) do
        self:InitCfgData(v)
    end

    this:GetSkins(0)
end

function this:Clear()
    self.datas = {}
    self.newSkins = {}
end

-- 获取皮肤列表(已混合变身、同调的皮肤) --- 默认不包含解禁的皮肤
function this:GetDatas(cfgid, containJieJin)
    if (containJieJin) then
        return self.datas[cfgid]
    else
        local dic = {}
        local _dic = self.datas[cfgid]
        for k, v in pairs(_dic) do
            if (v:GetType() ~= CardSkinType.JieJin) then
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
            count = count + 1
        end
    end
    return count
end

-- 初始化表数据
function this:InitCfgData(cfg)
    if (not cfg) then
        return
    end
    self.datas[cfg.id] = self.datas[cfg.id] or {}
    local _data = self.datas[cfg.id]
    self:RefreshData(cfg, _data, 0)

    -- 添加变身的皮肤
    if (cfg.tTransfo) then
        for i, v in ipairs(cfg.tTransfo) do
            local transCfg = Cfgs.CardData:GetByID(v)
            self:RefreshData(transCfg, _data, 1)
        end
    end
    -- 添加合体的皮肤
    if (cfg.fit_result) then
        local transCfg = Cfgs.CardData:GetByID(cfg.fit_result)
        self:RefreshData(transCfg, _data, 2)
    end
end

function this:RefreshData(cfg, _data, _typeNum)
    if (not cfg) then
        return _data
    end
    -- 基础
    if (cfg.model) then
        if (not _data[cfg.model]) then
            local skin1 = RoleSkinInfo.New()
            skin1:Set(cfg.id, cfg.model, 1, nil, _typeNum)
            _data[cfg.model] = skin1
        end
    end
    -- 突破
    if (cfg.breakModels) then
        for n, m in ipairs(cfg.breakModels) do
            if (not _data[m]) then
                local skin2 = RoleSkinInfo.New()
                skin2:Set(cfg.id, m, n + 1, nil, _typeNum)
                _data[m] = skin2
            end
        end
    end
    -- 额外
    if (cfg.skin) then
        for n, m in ipairs(cfg.skin) do
            if (not _data[m]) then
                local skin3 = RoleSkinInfo.New()
                skin3:Set(cfg.id, m, n, CardSkinType.Else, _typeNum)
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
            local cfgid = value.cfgid
            local arr = value.info
            if (not self.datas[cfgid]) then
                local cfg = Cfgs.CardData:GetByID(cfgid)
                self:InitCfgData(cfg)
            end
            if (arr) then
                for i, v in ipairs(arr) do
                    if (self.datas[cfgid][v]) then
                        self.datas[cfgid][v]:SetCanUse(true)
                    else
                        local skin4 = RoleSkinInfo.New()
                        skin4:Set(cfgid, v, i, CardSkinType.Add)
                        skin4:SetCanUse(true)
                        self.datas[cfgid][v] = skin4
                    end
                end
            end
        end
    end
    --CRoleMgr:CheckNewSkin()
    -- EventMgr.Dispatch(EventType.Card_Skin_Get)
end

-- 使用皮肤
function this:UseSkin(_cid, _skin, _skin_a, _isL2d)
    local num = _isL2d and 2 or 1
    local proto = {"PlayerProto:UseSkin", {
        cid = _cid,
        skin = _skin,
        skin_a = _skin_a,
        skinIsl2d = num
    }}
    NetMgr.net:Send(proto)
end

-- 设置是否新皮肤
function this:LookSkinRet(proto)
    local info = CRoleMgr:GetData(proto.id)
    if (info) then
        info:RemoveNewSkin(proto.skin)
    end
    --CRoleMgr:CheckNewSkin()
end

return this
