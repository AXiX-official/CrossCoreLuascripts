local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        
    end
end

function SetName(str)
    CSAPI.SetText(txtName,str)
end