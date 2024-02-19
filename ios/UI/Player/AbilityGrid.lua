-- 能力格子
local data = nil
local elseData = nil
local cb = nil

function SetClickCB(_cb)
    cb = _cb
end

function Refresh(_data, _elseData)
    data = _data
    elseData = _elseData
    if (data) then
        SetSelect(false)
        SetIcon(data.icon)
        SetPos(elseData.isRight or false)
        SetContent(data)
    end
end

function SetIcon(iconName)
    CSAPI.SetGOActive(icon, iconName ~= nil);
    if iconName then
        ResUtil.IconSkill:Load(icon, iconName);
        -- CSAPI.SetRTSize(icon,85,85);
    end
end

function SetPos(isRight)
    local x = isRight and -290 or 290
    CSAPI.SetAnchor(showObj, x, 0, 0)
end

function SetSelect(isShow)
    CSAPI.SetGOActive(selectObj, isShow)
end

function SetContent(d)
    CSAPI.SetText(txtName, d.name)
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv, lvStr .. d.lv)
    CSAPI.SetText(txtDesc, d.desc)
end

function OnClick()
    SetSelect(true)
    if (cb) then
        cb(this)
    end
end
