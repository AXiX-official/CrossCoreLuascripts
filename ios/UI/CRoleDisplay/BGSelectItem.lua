function SetIndex(_index)
    index = _index
end

function SetClickCB(_cb)
    cb = _cb
end

-- CfgMenuBg
function Refresh(_cfg, _curID, _useID)
    cfg = _cfg
    -- icon 
    if (cfg and cfg.icon) then
        ResUtil.BGIcon:Load(icon, cfg.icon, true)
    end
    -- name 
    CSAPI.SetText(txtName, cfg.sName)
    -- select 
    CSAPI.SetGOActive(select, cfg.id == _curID)
    -- use 
    CSAPI.SetGOActive(use, cfg.id == _useID)
end

function OnClick()
    if (cb) then
        cb(cfg)
    end
end
