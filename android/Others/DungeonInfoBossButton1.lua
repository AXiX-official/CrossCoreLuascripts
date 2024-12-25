local cfg = nil
local data = nil
local sectionData = nil
local bossData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        bossData = GlobalBossMgr:GetData()
        SetRank()
    end
end

function SetRank()
    if GlobalBossMgr:GetRankIdx() > 0 then
        local rank = GlobalBossMgr:GetRankIdx() > 1000 and "1000+" or GlobalBossMgr:GetRankIdx()
        LanguageMgr:SetText(txtRank,70021,rank)
    else
        LanguageMgr:SetText(txtRank,70017)
    end
end

function OnClickReward()
    if bossData then
        CSAPI.OpenView("GlobalBossList",{id = bossData:GetID()})
    end
end

function OnClickRank()
    if bossData then
        CSAPI.OpenView("GlobalBossList",{id = bossData:GetID()},2)
    end
end