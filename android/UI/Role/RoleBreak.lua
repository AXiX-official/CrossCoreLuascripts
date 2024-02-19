local targetPos = {{-243.9, 491.3}, {-81.4, 491.3}, {81.3, 491.3}, {243.5, 491.3}}
local lookBreakLv -- 预览等级

function Awake()
    cg_btnBreak = ComUtil.GetCom(btnBreak, "CanvasGroup")
end

function SetOldData(_oldData)

end

function OnDisable()
    RoleAudioPlayMgr:StopSound()
end

function Refresh(_cardData, _elseData)
    _lookBreakLv = _elseData -- 查看等级 
    InitData(_cardData)
    SetLv()
    SetStatus()
    SetTalent()
    SetMaterials()
    SetBtn()
    SetIconAnim()
end

function SetIconAnim()
    if (_lookBreakLv) then
        local pos = targetPos[_lookBreakLv - 1]
        CSAPI.SetGOIgnoreAlpha(imgBreak, true)
        UIUtil:SetPObjMove(imgBreak, pos[1], -162.7, pos[2], 503.6, 0, 0, nil, 300, 1)
        UIUtil:SetObjScale(imgBreak, 1, 0.6, 1, 0.6, 1, 1, function()
            CSAPI.SetGOIgnoreAlpha(imgBreak, false)
        end, 300, 0)
    end
end

function InitData(_cardData)
    -- if (cardData and cardData:GetID() ~= _cardData:GetID()) then
    --     curBreakLv = nil
    -- end

    cardData = _cardData or cardData
    totalResult = cardData:GetTotalProperty()

    SetNextData()

    -- 满级音效
    -- if (curBreakLv and cardData:GetBreakLevel() > curBreakLv) then
    --     if (cardData:GetBreakLevel() == 5) then
    --         RoleAudioPlayMgr:PlayByType(cardData:GetSkinID(), RoleAudioType.maxBreak)
    --     else
    --         RoleAudioPlayMgr:PlayByType(cardData:GetSkinID(), RoleAudioType.perBreak)
    --     end
    -- end
    -- curBreakLv = cardData:GetBreakLevel()
end

function SetNextData()
    lookBreakLv = _lookBreakLv ~= nil and _lookBreakLv or (cardData:GetBreakLevel() + 1)
    local _data = {}
    table.copy(cardData:GetData(), _data)
    _data.break_level = lookBreakLv
    nextData = CharacterCardsData(_data)
    newTotalResult = nextData:GetTotalProperty()
end

function SetLv()
    --
    ResUtil.RoleCard_BG:Load(imgBreak, "btn_20_0" .. (lookBreakLv - 1))
    -- 
    local curLv, maxLv = cardData:GetLv(), cardData:GetMaxLv()
    CSAPI.SetText(txtLv1, string.format("%s<color=#929296>/%s</color>", curLv, maxLv))
    --
    local cfg = Cfgs.CfgCardBreakLimitLv:GetByID(lookBreakLv - 1)
    CSAPI.SetText(txtLv2, string.format("%s<color=#ffc146>/%s</color>", curLv, cfg.MaxLv))
end

function SetStatus()
    statusItems = statusItems or {}
    statusDatas = {}
    for i, v in ipairs(g_RoleAttributeListT) do
        local cfg = Cfgs.CfgCardPropertyEnum:GetByID(v)
        local _data = {}
        _data.id = v
        _data.val1 = GetBaseValue(cfg.sFieldName)
        _data.val2 = GetAddValue(cfg.sFieldName)
        _data.nobg = true
        if (_data.val2 ~= nil) then
            table.insert(statusDatas, _data)
        end
    end
    ItemUtil.AddItems("AttributeNew2/AttributeItem6", statusItems, statusDatas, statusGrids)
end

-- 基础属性
function GetBaseValue(_key)
    local num = totalResult[_key]
    if (num) then
        return RoleTool.GetStatusValueStr(_key, num)
    end
    return 0
end

-- 升级加的
function GetAddValue(_key)
    if (nextData) then
        local num1 = totalResult[_key]
        local num2 = newTotalResult[_key]
        if (num1 and num2 and num2 - num1 > 0) then
            return "+" .. RoleTool.GetStatusValueStr(_key, num2 - num1)
        end
    end
    return nil
end

function SetTalent()
    local curTalentID = cardData:GetTalentIDByBreakLV(lookBreakLv)
    if (curTalentID) then
        local cfg = Cfgs.CfgSubTalentSkill:GetByID(curTalentID)

        -- item 
        if (not talentItem) then
            ResUtil:CreateUIGOAsync("Role/RoleInfoTalentItem1", talent, function(go)
                talentItem = ComUtil.GetLuaTable(go)
                talentItem.Refresh2(cfg)
            end)
        else
            talentItem.Refresh2(cfg)
        end
        -- name
        CSAPI.SetText(txtTalent1, cfg.name)
        -- desc 
        CSAPI.SetText(txtTalent2, cfg.desc1)
    end
end

-- 背包更新
function RefreshGoods()
    SetMaterials()
    SetBtn()
end

function SetMaterials()
    local goodsDatas = {}
    local break_id = cardData:GetCfg().break_id
    local useBreakId = GCardCalculator:CalUseBreakId(break_id, lookBreakLv - 1)
    materialCfg = Cfgs.CardBreakMaterial:GetByID(useBreakId)
    local mats = {}
    if (materialCfg) then
        mats = materialCfg.materials
    end
    for i, v in ipairs(mats) do
        local goodsData = BagMgr:GetFakeData(v[1])
        table.insert(goodsDatas, {goodsData, v[2]})
    end
    -- item
    items = items or {}
    ItemUtil.AddItems("Grid/RoleGridItem", items, goodsDatas, materialGrids, GridClickFunc.OpenInfo, 1,
        {nil, #goodsDatas})
end

-- 是否足够
function CheckEnough()
    if (materialCfg) then
        if (materialCfg.gold and materialCfg.gold > PlayerClient:GetGold()) then
            return false
        end
        if (materialCfg.materials) then
            for i, v in ipairs(materialCfg.materials) do
                local goodsData = BagMgr:GetData(v[1])
                local curNum = goodsData and goodsData:GetCount() or 0
                local needNum = v[2]
                if (curNum < needNum) then
                    return false
                end
            end
        end
        return true
    end
    return false
end

function SetBtn()
    CSAPI.SetGOActive(imgBreak1, _lookBreakLv == nil)
    CSAPI.SetGOActive(imgBreak2, _lookBreakLv ~= nil)
    if (_lookBreakLv ~= nil) then
        -- 预览 
        cg_btnBreak.alpha = 1
        LanguageMgr:SetText(txtBreak1, 4214)
        LanguageMgr:SetEnText(txtBreak2, 4214)
    else
        -- 正常升级 
        enough = CheckEnough()

        cg_btnBreak.alpha = not enough and 0.3 or 1
        LanguageMgr:SetText(txtBreak1, 4001)
        LanguageMgr:SetEnText(txtBreak2, 4001)
    end
    local money = materialCfg.gold or 0
    CSAPI.SetText(txtCost, PlayerClient:GetGold() >= money and money .. "" or StringUtil:SetByColor(money, "ff8790"))
end

function OnClickBreak()
    if (_lookBreakLv ~= nil) then
        -- 返回升级
        EventMgr.Dispatch(EventType.Role_Jump_Break, {_lookBreakLv, true})
    else
        if (enough) then
            RoleMgr:CardBreak(cardData:GetID())
        end
    end
end

