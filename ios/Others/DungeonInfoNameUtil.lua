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

return this; 