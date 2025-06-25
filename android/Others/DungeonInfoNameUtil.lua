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
    return {"Title", "Level", "Target", "Danger4", "Details","Double","Button"}
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
    return {"Title5","Target3","Output3","Details2","Button5"}
end

function this.Cloud()
    return {"CloudTitle","CloudLevel","CloudTarget","CloudOutput","CloudDetails","Double","CloudButton"},"DungeonActivity11"
end

function this.CloudPlot()
    return {"CloudTitle","CloudPlot","CloudOutput","CloudPlotButton"},"DungeonActivity11"
end

function this.CloudDanger()
    return {"CloudTitle","CloudLevel","CloudTarget","CloudDanger","CloudDetails","Double","CloudButton"},"DungeonActivity11"
end

function this.CloudSpecial()
    return {"CloudTitle","CloudLevel","CloudSpecial","CloudOutput","CloudDetails","CloudButton"},"DungeonActivity11"
end

function this.RogueMap()
    return {"Title2","Level","Output","Level3","Danger4","Details","Button6"}
end

function this.Summer2()
    return {"Title","Level","Target","Output","Details","Double","Button"},"DungeonActivity13"
end

function this.Summer2Plot()
    return {"Title","Plot","Output","PlotButton"},"DungeonActivity13"
end

function this.Summer2Danger()
    return {"Title","Level","Target","Danger","Details","Double","Button"},"DungeonActivity13"
end

function this.Summer2Special()
    return {"Title","Level","Plot","Output","Details","Button"},"DungeonActivity13"
end

return this; 