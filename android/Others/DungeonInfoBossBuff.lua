local cfg = nil
local data = nil
local sectionData = nil

local items= nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetItems()
    end
end

function SetItems()
    local curData= GlobalBossMgr:GetData()
    if curData and curData:GetBuffIds() then
        items = items or {}
        ItemUtil.AddItems("GlobalBoss/GlobalBossBuffItem2",items,curData:GetBuffIds(),itemParent)
    end
end

function OnClick()
    local curData= GlobalBossMgr:GetData()
    if curData and curData:GetBuffIds() then
        CSAPI.OpenView("GlobalBossBuff", curData:GetBuffIds())
    end
end