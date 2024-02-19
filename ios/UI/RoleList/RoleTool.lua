-- 卡牌工具
RoleTool = {}
local this = RoleTool

-- 升到最大等级需要的经验(真实需要经验)
function this.GetExpForMaxLv(cardData)
    if (cardData == nil) then
        return 0
    end
    local lv = cardData:GetLv()
    local max = cardData:GetMaxLv()
    if (lv >= max) then
        return 0
    end
    local maxExp = -cardData:GetEXP()
    for i = lv, (max - 1) do
        maxExp = maxExp + this.GetExpByLv(i)
    end
    return maxExp > 0 and maxExp or 0
end

-- 升到指定等级需要的经验(真实需要经验)
function this.GetExpForLv(curExp, curlv, tolv)
    if (curlv >= tolv) then
        return 0
    end
    local maxExp = -curExp
    for i = curlv, (tolv - 1) do
        maxExp = maxExp + this.GetExpByLv(i)
    end
    return maxExp > 0 and maxExp or 0
end

-- 等级经验
function this.GetExpByLv(lv)
    if (lv == nil or lv == 0) then
        return 0
    end
    local cfg = Cfgs.CardLevel:GetByID(lv)
    return cfg and cfg.exp or 0
end

-- 卡牌最大等级 
function this.GetMaxLv()
    -- local cfg = Cfgs.CardLevel:GetAll()
    -- return #cfg
    return 80 -- todo 
end

-- 卡牌最大突破等级
function this:GetMaxBreakLv()
    local cfg = Cfgs.CardBreak:GetAll()
    return #cfg
end

-- =========================立绘、live2d--------------------------------------------------------------------------------

-- 混合加载（无语言表情的不可调用，直接用this.LoadImg）
function this.AddRole(_parent, _playCB, _endCB, _needClick)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/CardIconItem", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB, _needClick)
    return lua
end

-- 仅加载 img（含表情）
function this.AddImg(_parent, _playCB, _endCB, _needClick)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/CardImgItem", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB, _needClick)
    return lua
end

-- 仅加载l2d
function this.AddLive2D(_parent, _playCB, _endCB, _needClick)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/CardLive2DItem", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB, _needClick)
    return lua
end

-- 仅加载图片（只有立绘）
function this.LoadImg(_imgGo, _modelId, _posType, _callBack)
    if (_modelId == nil or _imgGo == nil) then
        LogError("nil")
        return
    end
    local pos, scale, img, l2dName = this.GetImgPosScale(_modelId, _posType)
    ResUtil.ImgCharacter:Load(_imgGo, img, function(go)
        CSAPI.SetAnchor(_imgGo, pos.x, pos.y, pos.z)
        CSAPI.SetScale(_imgGo, scale, scale, 1)
        if (_callBack) then
            _callBack(go)
        end
    end)
end

-- 立绘配置表信息   
function this.GetImgPosScale(modelId, posType, isL2d)
    local pos, scale, img, l2dName = nil, 1, nil, nil
    local cfg = Cfgs.character:GetByID(modelId)
    if (cfg) then
        local _pos = isL2d and cfg.l2dPos or cfg.imgPos
        local offset = posType or {0, 0, 1}
        pos = UnityEngine.Vector3(_pos[1] + offset[1], _pos[2] + offset[2], 0)
        scale = _pos[3] * offset[3]
        img = cfg.img
        l2dName = cfg.l2dName
    else
        LogError("角色模型表不存在id：" .. tostring(modelId))
    end
    return pos, scale, img, l2dName
end

-- =========================多人插图--------------------------------------------------------------------------------

-- --添加多人插图
-- function this.AddMulIcon(_parent, _playCB, _endCB, _needClick)
--     if (_parent == nil) then
--         return
--     end
--     local go = ResUtil:CreateUIGO("Common/MulIconItem", _parent.transform)
--     local lua = ComUtil.GetLuaTable(go)
--     lua.Init(_playCB, _endCB, _needClick)
--     return lua
-- end

-- 混合加载（无语言表情的不可调用，直接用this.LoadImg）
function this.AddMulRole(_parent, _playCB, _endCB, _needClick)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/MulIconItem", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB, _needClick)
    return lua
end

-- 仅加载 img（含表情）
function this.AddMulImg(_parent, _playCB, _endCB)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/MulImgItem", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB)
    return lua
end

-- 仅加载l2d
function this.AddMulLive2D(_parent, _playCB, _endCB)
    if (_parent == nil) then
        return
    end
    local go = ResUtil:CreateUIGO("Common/MulLive2DItem", _parent.transform)
    local lua = ComUtil.GetLuaTable(go)
    lua.Init(_playCB, _endCB)
    return lua
end

-- 仅加载图片（只有立绘）
function this.LoadMulImg(_imgGo, _modelId, _posType, _callBack)
    if (_modelId == nil or _imgGo == nil) then
        LogError("nil")
        return
    end
    local pos, scale, img, l2dName = this.GetMulImgPosScale(_modelId, _posType)
    ResUtil.ImgCharacter:Load(_imgGo, img, function(go)
        CSAPI.SetAnchor(_imgGo, pos.x, pos.y, pos.z)
        CSAPI.SetScale(_imgGo, scale, scale, 1)
        if (_callBack) then
            _callBack(go)
        end
    end)
end

-- 立绘配置表信息   
function this.GetMulImgPosScale(modelId, posType, isL2d)
    local pos, scale, img, l2dName = nil, 1, nil, nil
    local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(modelId)
    if (cfg) then
        local _pos = isL2d and cfg.l2dPos or cfg.imgPos
        local offset = posType or {0, 0, 1}
        pos = UnityEngine.Vector3(_pos[1] + offset[1], _pos[2] + offset[2], 0)
        scale = _pos[3] * offset[3]
        img = cfg.img
        l2dName = cfg.l2dName
    else
        LogError("多人插图表不存在id：" + tostring(modelId))
    end
    return pos, scale, img, l2dName
end

-- =========================end--------------------------------------------------------------------------------

-- 属性str
function this.GetStatusValueStr(_key, _num)
    if (_key == "career") then
        return StringConstant.role_114[math.floor(_num)]
    elseif (_key == "maxhp" or _key == "defense" or _key == "attack" or _key == "speed" or _key == "sp") then
        return math.modf(_num) .. ""
    elseif (_key == "nStep" or _key == "nJump") then
        if (_num == 0) then
            return "0"
        end
        return _num > 0 and "+" .. math.modf(_num) .. "" or math.modf(_num) .. ""
    elseif (_key == "nMoveType") then
        return Cfgs.CfgMoveEnum:GetByID(_num).sName or ""
    else
        local str = string.match(_num * 100, "%d+");
        return str .. "%"
    end
end

-- 28001：SP（同步率）
-- 28012：SP（同步）
-- 28013：NP（能量值）
-- 28014：NP（能量）
-- 封装技能消耗的显示
function this.GetSPStr(cfg)
    local num = 0
    local str = ""
    local _spStr = LanguageMgr:GetByID(28012) or "SP"
    local _npStr = LanguageMgr:GetByID(28014) or "NP"
    if cfg.sp and cfg.sp > 0 then
        str = _spStr .. "  -" .. cfg.sp
        num = cfg.sp
    elseif cfg.np and cfg.np > 0 then
        str = _npStr .. "  -" .. cfg.np
        num = cfg.np
    end
    return str, num
end

-- 封装技能消耗的显示
function this.GetNPStr(cfg)
    local num = 0
    local _spStr = LanguageMgr:GetByID(28012) or "SP"
    local _npStr = LanguageMgr:GetByID(28014) or "NP"
    local str = _npStr
    if cfg.sp and cfg.sp > 0 then
        str = _spStr
        num = cfg.sp
    elseif cfg.np and cfg.np > 0 then
        str = _npStr
        num = cfg.np
    end
    return str, num
end

-- 优先度：战斗中>远征中>冷却中>训练中>演习中（表示演习编队中）>军演中（军演编队中)>助战中
function this.GetStateStr(_cardData)
    local index = nil
    if (_cardData:GetType() == RoleCardType.card) then
        local cid = _cardData:GetID()
        if TeamMgr:GetCardIsDuplicate(cid) then
            index = 1
        elseif (MenuMgr:CheckSystemIsOpen("Matrix") and _cardData:IsInExpedition()) then
            index = 2
            -- elseif(MenuMgr:CheckSystemIsOpen("CoolView") and CoolMgr:CheckIsIn(cid)) then
            -- 	index = 3
        elseif (MenuMgr:CheckSystemIsOpen("special4", OpenViewType.special) and RoleSkillMgr:CheckIsIn(cid)) then
            index = 4
            -- 演习、pvp 本次不开放 rui/20220608
            -- elseif(MenuMgr:CheckSystemIsOpen("special5", OpenViewType.special) and(TeamMgr:CheckIsInTeam(cid, eTeamType.PracticeAttack) or TeamMgr:CheckIsInTeam(cid, eTeamType.PracticeDefine))) then
            -- index = 5
            -- elseif (MenuMgr:CheckSystemIsOpen("special6", OpenViewType.special) and
            --     TeamMgr:CheckIsInTeam(cid, eTeamType.RealPracticeAttack)) then
            --     index = 6
            -- elseif (MenuMgr:CheckSystemIsOpen("PlayerView") and TeamMgr:CheckIsInTeam(cid, eTeamType.Assistance)) then
            -- index = 7
        end
    end
    return index
end

-- 限制等级
function this.GetLimitLv(coreLv, quality)
    local cfg = Cfgs.CfgCardCoreLv:GetByID(quality)
    return cfg.infos[coreLv].limitLv
end

-- 下一限制等级
function this.GetNextLimitLv(_cardData)
    local coreLv = _cardData:GetCoreLv() + 1
    local cfg = Cfgs.CfgCardCoreLv:GetByID(_cardData:GetQuality())
    return cfg.infos[coreLv].limitLv
end

-- 核心升级消耗碎片数量
function this.GetCoreUpgrateCostNum(_cardData)
    local coreCfg = Cfgs.CfgCardCoreLv:GetByID(_cardData:GetQuality())
    local lvCfg = coreCfg.infos[_cardData:GetCoreLv()]
    return lvCfg.costNum or 0
end

-- 核心升级的额外素材
function this.GetCoreUpgrateElseCost(_cardData)
    local coreCfg = Cfgs.CfgCardCoreLv:GetByID(_cardData:GetQuality())
    local lvCfg = coreCfg.infos[_cardData:GetCoreLv()]
    local nClass = _cardData:GetCamp()
    for i, v in ipairs(lvCfg.costArr) do
        if (v[1] == nClass) then
            return v[2]
        end
    end
    return nil
end

-- 是否已是最大跃升等级
function this.IsMaxBreakLevel(_cardData)
    return _cardData:GetBreakLevel() >= #CardBreak and true or false
end

-- 获取卡牌的最大突破等级
function this.GetMaxCoreLv(quality)
    local coreCfg = Cfgs.CfgCardCoreLv:GetByID(quality)
    return #coreCfg.infos
end

-- 是否最大突破等级
function this.IsMaxCoreLv(_cardData)
    return _cardData:GetCoreLv() >= this.GetMaxCoreLv(_cardData:GetQuality()) and true or false
end

-- 主天赋升级消耗碎片数量
function this.GetTalentUpgrateCostNum(_cardData, _skillData)
    local quality = _cardData:GetQuality()
    local taletCfg = Cfgs.CfgMainTalentSkillUpgrade:GetByID(quality)
    local cfg = Cfgs.skill:GetByID(_skillData.id)
    local lvCfg = taletCfg.infos[cfg.lv]
    return lvCfg.costNum or 0
end

-- 主天赋升级的额外素材
function this.GetTalentUpgrateElseCost(_cardData, _skillData)
    local quality = _cardData:GetQuality()
    local taletCfg = Cfgs.CfgMainTalentSkillUpgrade:GetByID(quality)
    local cfg = Cfgs.skill:GetByID(_skillData.id)
    local lvCfg = taletCfg.infos[cfg.lv]
    local nClass = _cardData:GetCamp()
    for i, v in ipairs(lvCfg.costArr) do
        if (v[1] == nClass) then
            return v[2]
        end
    end
    return nil
end

function this.GetSkillColor(icon_bg_type)
    local iconColors = {"ffffff", "57bd7e", "39a9ff", "cf83f3", "ffb847", "ff4747"}
    return iconColors[icon_bg_type] or "ffffff"
end

return this

