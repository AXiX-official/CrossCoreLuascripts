local cfg = nil
local data = nil
local sectionData = nil
local goGoals = {}

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetGoal()
        SetHeight()
    end
end

function SetGoal()
    local isTower = cfg.type == eDuplicateType.Tower
    local completeInfo = nil
    if data and data.data then
        completeInfo = data:GetNGrade()
    end
    local starInfos = DungeonUtil.GetStarInfo2(cfg.id, completeInfo);
    for i = 1, #goGoals do
        CSAPI.SetGOActive(goGoals[i].gameObject, false)
    end
    if #starInfos > 0 then
        local Len = (isTower or (cfg.diff and cfg.diff == 3)) and 1 or 3
        for i = 1, Len do
            if #goGoals >= i then
                CSAPI.SetGOActive(goGoals[i].gameObject, true)
                goGoals[i].Init(starInfos[i].tips, starInfos[i].isComplete);
            else
                ResUtil:CreateUIGOAsync("FightTaskItem/FightBigTaskItem", goalTitle, function(go)
                    goGoals = goGoals or {};
                    local item = ComUtil.GetLuaTable(go);
                    CSAPI.SetGOActive(item.gameObject, true)
                    item.Init(starInfos[i].tips, starInfos[i].isComplete);
                    table.insert(goGoals, item);
                end);
            end
        end
    end
end

function SetHeight()
    local size = CSAPI.GetRTSize(gameObject)
    if cfg.type == eDuplicateType.Tower then
        CSAPI.SetRTSize(gameObject,size[0], 110)
    end
end