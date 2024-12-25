function SetIndex(_index)
    index = _index
end

function Refresh(_data)
    data = _data
    --
    ids = index == 1 and {0, 0} or data:GetIDs()
    SetSlot(ids[1], empty, entity, icon)
    --
    if (index ~= 1) then
        CSAPI.SetGOActive(btnRemove, data:GetIdx() ~= CRoleDisplayMgr:GetPanelRet().using)
    end
end

function SetSlot(_id, _empty, _entity, _icon, _txtName1, _txtName2)
    CSAPI.SetGOActive(_empty, _id == 0)
    CSAPI.SetGOActive(_entity, _id ~= 0)
    if (_id ~= 0) then
        local cfg1 = Cfgs.CfgArchiveMultiPicture:GetByID(_id)
        if (cfg1) then
            -- icon
            ResUtil.MultBoardSmall:Load(_icon, cfg1.set_icon)
            local typeCfg = Cfgs.CfgMultiImageThemeType:GetByID(cfg1.theme_type)
            SetName(cfg1.sName, typeCfg.sName)
        else
            local cfg2 = Cfgs.character:GetByID(_id)
            -- icon
            ResUtil.CardIcon:Load(_icon, cfg2.Card_head)
            SetName(cfg2.key, cfg2.desc)
        end
    end
end

function SetName(str1, str2)
    CSAPI.SetText(txtName1, str2)
    CSAPI.SetText(txtName2, str1)
end

function OnClick()
    if (index == 1) then
        local arr = CRoleDisplayMgr:GetRandomPanels(eRandomPanelType.SINGLE)
        if (#arr >= g_RandomKanbanQuantity) then
            LanguageMgr:ShowTips(27008)
            return
        end
        local _d = CRoleDisplayMgr:CreateRandomData(CRoleDisplayMgr:GetRandomIdx(), 2)
        CSAPI.OpenView("CRoleDisplay", _d, 1)
    else
        PlayerProto:GetRandomPanelDetail(data:GetIdx(), function(proto)
            local _data = CRoleDisplayMgr:GerRamdomData(proto.idx)
            CSAPI.OpenView("CRoleDisplay", _data, 1)
        end)
    end
end

function OnClickRemove()
    -- local str = LanguageMgr:GetTips(27010)
    -- UIUtil:OpenDialog(str, function()
    --     PlayerProto:RemoveRandomPanel(data:GetIdx())
    -- end)
    --
    local str = LanguageMgr:GetTips(27010)
    UIUtil:OpenTipsDialog("CRoleDisplaySItem_Day", str, function()
        PlayerProto:RemoveRandomPanel(data:GetIdx())
    end)
end
