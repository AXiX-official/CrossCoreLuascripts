local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetText()
    end
end

function SetText()
    local str = cfg.lvTips ~= nil and cfg.lvTips or "— —"
    str = cfg.type == eDuplicateType.Teaching and "— —" or str -- 教程不显示lv
    CSAPI.SetText(txtLevel, str);
end