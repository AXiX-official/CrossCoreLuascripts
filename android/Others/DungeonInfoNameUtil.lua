local this = {};

function this.GetNames(_type)
    if this[_type] then
        return this[_type]()
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
    return {"Title", "Level", "Target", "Badge", "Danger2", "Details","Double","Button"}
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

function this.SummerPlot()
    return {"Title3","Level2","Plot2","Output2","PlotButton"}
end

function this.SummerDanger()
    return {"Title3","Level2","Target2","Danger3","Details","Double2","Button2"}
end

function this.SummerSpecial()
    return {"Title3","Level2","Plot2","Output2","Details","Button2"}
end

function this.Night()
    return {"NightTitle","NightLevel","NightTarget","NightOutput","NightDetails","Double","NightButton"},"DungeonActivity9"
end

function this.NightPlot()
    return {"NightTitle","NightPlot","NightOutput","NightPlotButton"},"DungeonActivity9"
end

function this.NightDanger()
    return {"NightTitle","NightLevel","NightTarget","NightDanger","NightDetails","Double","NightButton"},"DungeonActivity9"
end

function this.NightSpecial()
    return {"NightTitle","NightLevel","NightPlot","NightOutput","NightDetails","NightButton"},"DungeonActivity9"
end

function this.Colosseum()
    return {"Title4","Target","Output","Details","Button4"}
end

function this.GlobalBoss()
    return {"BossTitle","BossLevel","BossState","BossTime","BossButton1","BossDetails","BossButton2"},"GlobalBoss"
end

function this.RogueT()
    return {"Title2","Target3","Output","Details","Button5"}
end

return this; 