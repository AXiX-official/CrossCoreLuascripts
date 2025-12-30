local cfg = nil
local item 

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data)
    cfg = Cfgs.CfgBuffBattle:GetByID(_data)
    if cfg then
        SetItem()
    end
end

function SetItem()
    if item then
        item.Refresh(cfg)
    else
        ResUtil:CreateUIGOAsync("BuffBattle/BuffBattleItem2",itemParent,function (go)
            item = ComUtil.GetLuaTable(go)
            item.Refresh(cfg)
        end)
    end
end

function OnClick()
    if cb then
        cb(this)
    end
end

function GetDesc()
    return cfg and cfg.desc or ""
end