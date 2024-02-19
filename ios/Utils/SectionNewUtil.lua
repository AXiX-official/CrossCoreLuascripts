local this = {}

function this:IsSectionNew()
    if self:IsDoubleNew() then
        return true
    end
    if self:IsDailyNew()then
        return true
    end
    return false
end

function this:IsDailyNew()
    local newInfo = FileUtil.LoadByPath("Dungeon_new_Info" .. PlayerClient:GetUid() .. ".txt") or {}
    local sectionCfgs = Cfgs.Section:GetGroup(SectionType.Daily)
    if sectionCfgs then
        for i, cfgSection in pairs(sectionCfgs) do
            local sectionData = DungeonMgr:GetSectionData(cfgSection.id)
            if sectionData:GetOpen() then
                local dungeonCfgs = Cfgs.MainLine:GetGroup(cfgSection.id)
                if dungeonCfgs then
                    for i, cfgDungeon in pairs(dungeonCfgs) do
                        if DungeonMgr:IsDungeonOpen(cfgDungeon.id) and (newInfo[cfgDungeon.id] == nil or newInfo[cfgDungeon.id] == 1) then
                            return true
                        end
                    end
                end
            end
        end
    end
    return false
end

function this:IsDoubleNew()
    local newInfo = FileUtil.LoadByPath("Section_Daily_New"..PlayerClient:GetUid().. ".txt") or {}
    if not newInfo.resetTime then
        self:RefreshDoubleNew()
        return false
    end
    if TimeUtil:GetTime() >= newInfo.resetTime then
        return true
    end
    return false
end

function this:RefreshDoubleNew()
    local newInfo = FileUtil.LoadByPath("Section_Daily_New"..PlayerClient:GetUid().. ".txt") or {}
    local dayDiffs = g_ActivityDiffDayTime * 3600
    newInfo.resetTime = TimeUtil:GetResetTime(dayDiffs)
    FileUtil.SaveToFile("Section_Daily_New"..PlayerClient:GetUid().. ".txt",newInfo)
end

return this