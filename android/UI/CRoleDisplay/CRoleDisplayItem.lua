function Awake()
    canvasGroup = ComUtil.GetCom(clickNode, "CanvasGroup")
end

function SetIndex(_index)
    index = _index
end
function SetClickCB(_cb)
    cb = _cb
end

-- data :  RoleSkinInfo
function Refresh(_data, _curLIndex, _curCRoleID)
    data = _data

    -- item 
    SetItem()
    -- select
    isSelect = _curLIndex == index
    if (select.activeSelf ~= isSelect) then
        CSAPI.SetGOActive(select, isSelect)
    end
    -- use 
    isUse = false
    if (_curCRoleID and _curCRoleID == data:GetSkinID()) then
        isUse = true
    end
    CSAPI.SetGOActive(use, isUse)
    -- no
    isCanUse = data:CheckCanUse()
    CSAPI.SetGOActive(txtNo, not isCanUse)
    canvasGroup.alpha = isCanUse and 1 or 0.3

    -- SetNew()

    --限时皮肤
    SetLimitSkin()
end

function SetItem()
    local cRoleInfo = CRoleMgr:GetCRoleByModelID(data:GetSkinID())
    if (not item) then
        ResUtil:CreateUIGOAsync("CRoleItem/CRoleSmallItem", childPoint, function(go)
            item = ComUtil.GetLuaTable(go)
            item.Refresh(cRoleInfo, {
                isRayCast = false
            })
            SetIcon()
        end)
    else
        item.Refresh(cRoleInfo, {
            isRayCast = false
        })
        SetIcon()
    end
end

function SetIcon()
    local cfg = Cfgs.character:GetByID(data:GetSkinID())
    item.SetIcon(cfg.icon)
end

-- function SetNew()
--     isNew = data:CheckIsNew()
--     if (isNew and isSelect) then
--         isNew = false
--         PlayerProto:LookSkin(data:GetCfg().role_id, data:GetSkinID())
--     end
--     UIUtil:SetNewPoint(clickNode, isNew, 53, 69, 0)
-- end

function OnClick()
    if (cb) then
        cb(index)
    end
end

function SetLimitSkin()
    local isLimitSkin = data:IsLimitSkin()
    UIUtil:SetRedPoint2("Common/Red4", clickNode, isLimitSkin, -71, 74, 0)
end
