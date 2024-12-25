local cfg = nil
local data = nil
local sectionData = nil

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetIcon()
    end
end

function SetIcon()
    local bossData = GlobalBossMgr:GetData()
    if bossData then
        local iconName = bossData:GetIcon()
        if iconName and iconName~="" then
            ResUtil.GlobalBoss:Load(icon,iconName)
        end
    end
end

function OnClickDetails()
    local list = {};
    if cfg and cfg.enemyPreview then
        for k, v in ipairs(cfg.enemyPreview) do
            local cfg = Cfgs.CardData:GetByID(v);
            table.insert(list, {
                id = v,
                isBoss = k == 1
            });
        end
    end
    CSAPI.OpenView("FightEnemyInfo", list);
end