
function Refresh(sectionData,num)
    local cfg = sectionData:GetCfg()
    if cfg then
        local index = cfg.index or 1
        index = index < 10 and "0" .. index or index .. ""
        if cfg.turnIcon then
            local iconName = cfg.turnIcon[num]
            ResUtil:LoadBigImg(icon,"UIs/DungeonActivity/Role/icon_02_" .. index .. "/" .. iconName .."/img")    
        end
    end
end