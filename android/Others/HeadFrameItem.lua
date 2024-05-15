local effectGO = nil

function Awake()
    clickNode_img = ComUtil.GetCom(clickNode, "Image")
end

function SetClickCB(_cb)
    cb = _cb
end

-- HeadFrameData
function Refresh0(_data, _selectID)
    data = _data
    -- 
    CSAPI.SetGOActive(btnClick, true)
    -- select
    local isSelect = _selectID == nil and false or (_selectID == data:GetID())
    CSAPI.SetGOActive(select, isSelect)
    -- lock 
    CSAPI.SetGOActive(lock, not data:CheckCanUse())
    -- icon或特效
    SetIcon(data:GetCfg())
    -- use
    CSAPI.SetGOActive(use, data:CheckUse())
    -- red 
    isAdd = HeadFrameMgr:CheckRed(data:GetItemID())
    UIUtil:SetRedPoint(node, isAdd, 47.4, 49.7, 0)
end

function Refresh(cfgID, scale)
    local cfg = Cfgs.AvatarFrame:GetByID(cfgID)
    CSAPI.SetGOActive(btnClick, false)
    CSAPI.SetGOActive(select, false)
    CSAPI.SetGOActive(lock, false)
    CSAPI.SetGOActive(use, false)
    CSAPI.SetScale(node, scale, scale, 1)
    SetIcon(cfg)
end

function SetIcon(cfg)
    CSAPI.SetGOActive(icon, cfg.type == 1)
    CSAPI.SetGOActive(effectParent, cfg.type == 2)
    if (cfg.type == 1) then
        ResUtil.HeadFrame:Load(icon, cfg.picture, true)
    else
        if (effectGO) then
            if (effectGO.name == cfg.avatareffect) then
                return
            end
            CSAPI.RemoveGO(effectGO)
        end
        ResUtil:CreateEffect(cfg.avatareffect, 0, 0, 0, effectParent, function(go)
            effectGO = go
            effectGO.name = cfg.avatareffect
        end) 
    end
end

function OnClick()
    if (isAdd) then
        HeadFrameMgr:RefreshData(data:GetItemID())
    end
    if (cb) then
        cb(data:GetID())
    end
end
