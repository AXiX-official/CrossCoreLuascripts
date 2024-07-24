local this = {};

function this.GetNames(_type)
    if _type == DungeonInfoType.Normal then
        return this.Normal()
    elseif _type == DungeonInfoType.Tower then
        return this.Tower()
    elseif _type == DungeonInfoType.Course then
        return this.Course()
    elseif _type == DungeonInfoType.Trials then
        return this.Trials()
    elseif _type == DungeonInfoType.Danger then
        return this.Danger()
    elseif _type == DungeonInfoType.Plot then
        return this.Plot()
    elseif _type == DungeonInfoType.Feast then
        return this.Feast()
    elseif _type == DungeonInfoType.TotalBattle then
        return this.TotalBattle()
    elseif _type == DungeonInfoType.Summer then
        return this.Summer()
    elseif _type == DungeonInfoType.SummerDanger then
        return this.Summer()
    end
end

function this.Normal()
    return  {"Title", "Level", "Target", "Output", "Details","Double","Button"}
end

function this.Tower()
    return {"Title", "Prograss", "Level", "Target", "Output", "Details","Double","Button"}
end

function this.Course()
    return {"Title", "Course", "Target", "Output", "Details","Double","Button"}
end

function this.Trials()
    return {"Title", "Level", "Target", "Badge", "Danger", "Details","Double","Button"}
end

function this.Danger()
    return  {"Title", "Level", "Target", "Danger", "Details","Button"}
end

function this.Plot()
    return  {"Title", "Level", "Plot", "Output","PlotButton"}
end

function this.Feast()
    return  {"Title", "Level", "Target", "Output", "Details","Double","Button2"}
end

function this.TotalBattle()
    return  {"Title2", "Level", "Total", "Output","Danger2" ,"Details","Button3"}
end

function this.Summer()
    return {"Title3","Level2","Target2","Output2","Details","Double2","Button2"}
end

return this; 