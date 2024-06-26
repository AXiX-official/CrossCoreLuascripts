local cfg = nil
local data = nil
local sectionData = nil
local slider = nil

function Awake()
    slider = ComUtil.GetCom(hpSlider,"Slider")
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetName()
        SetSlider()
    end
end

function SetName()
    CSAPI.SetText(txtName,cfg.name)
end

function SetSlider()
    slider.value = 1
end