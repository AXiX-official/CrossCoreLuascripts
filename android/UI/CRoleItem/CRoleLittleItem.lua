-- 皮肤 data : RoleSkinInfo
function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

-- _elseData 根据key来划分数据
function Refresh(_data, _curID)
    data = _data
    elseData = _elseData or {}

    --isUse = elseData.useID and elseData.useID == data:GetID() or false
    isSelect = _curID == data:GetID() or false

    -- icon
    -- SetIcon(data:GetIcon())
    SetIcon2()
    -- name 
    CSAPI.SetText(txtName, data:GetAlias())
    -- use 
    --CSAPI.SetGOActive(use, isUse)
    -- select
    CSAPI.SetGOActive(select, isSelect)
end

-- function SetIcon(_iconName)
--     if (_iconName) then
--         ResUtil.Card:Load(icon, _iconName)
--     end
-- end

-- 设置角色详情选择的皮肤头像（如果是看板，则用看板的）
function SetIcon2()
    local modelId = nil
    -- if (PlayerClient:KBIsRole()) then
    --     local cfg = Cfgs.character:GetByID(PlayerClient:GetIconId())
    --     if (cfg and cfg.role_id and cfg.role_id == data:GetID()) then
    --         modelId = PlayerClient:GetIconId()
    --     end
    -- end
    if (modelId == nil) then
        modelId = RoleMgr:GetSkinIDByRoleID(data:GetID())
    end
    local cfgModel = modelId and Cfgs.character:GetByID(modelId) or nil
    local iconName = cfgModel and cfgModel.List_head or nil
    if (iconName) then
        ResUtil.Card:Load(icon, iconName)
    end
end

-- function SetNew()
--     local isAdd = data:CheckHadNewSkin()
--     UIUtil:SetNewPoint(node, isAdd, 85.7, 79, 0)
-- end

function OnClick()
    if (cb) then
        cb(data)
    end
end

