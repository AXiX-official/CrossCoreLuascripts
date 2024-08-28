function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_id, _data)
    id = _id
    data = _data

    -- lock
    isOpen, lockStr = data:CheckOpen()
    -- 
    CSAPI.SetGOActive(entity, id ~= 0)
    if (isOpen and (id == nil or id == 0)) then
        CSAPI.SetGOActive(empty, true)
    else 
        CSAPI.SetGOActive(empty, false)
    end
    CSAPI.SetGOActive(lock, not isOpen)
    -- 
    if (isOpen) then
        if (id ~= 0) then
            SetEntity()
        end
    else
        CSAPI.SetText(txtLock, lockStr)
    end
end

function SetEntity()
    local cfg1 = Cfgs.CfgArchiveMultiPicture:GetByID(id)
    if (cfg1) then
        -- icon
        ResUtil.MultBoardSmall:Load(icon, cfg1.set_icon)
        local typeCfg = Cfgs.CfgMultiImageThemeType:GetByID(cfg1.theme_type)
        SetName(cfg1.sName, typeCfg.sName)
    else
        local cfg2 = Cfgs.character:GetByID(id)
        -- icon
        ResUtil.CardIcon:Load(icon, cfg2.Card_head)
        SetName(cfg2.key, cfg2.desc)
    end
    --  
    CSAPI.SetGOActive(btnRemove, CRoleDisplayMgr:GetCopyUsing() ~= data:GetIndex())
end

function SetName(str1, str2)
    CSAPI.SetText(txtName1, str1)
    CSAPI.SetText(txtName2, str2)
end

function OnClick()
    if (isOpen) then
        cb(index, 1)
    end
end

function OnClickRemove()
    cb(index, 2)
end
