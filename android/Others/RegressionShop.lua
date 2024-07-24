--回归商店
local fixedTime=60;
local upTime=0;
local overTime=0;
local endTime=0;
function Refresh(info)
    --初始化持续时间
    if info then
        overTime=RegressionMgr:GetActivityEndTime(info.type)
        endTime=overTime-TimeUtil:GetTime();
        RefreshDownTime();
    end
end

function OnClickC()
    CSAPI.OpenView("ShopView",3001);
end

function Update()
    if endTime and endTime>0 then
        upTime=upTime+Time.deltaTime;
        if upTime>=fixedTime then
            endTime=endTime-fixedTime;
            RefreshDownTime();
            upTime=0;
        end
    end
end

function RefreshDownTime()
    local count=TimeUtil:GetDiffHMS(overTime,TimeUtil.GetTime());
    if count.day>0 or count.hour>0 or count.minute>0 or count.second>60 then
        CSAPI.SetText(txtTime,string.format("%s%s",LanguageMgr:GetByID(60001),LanguageMgr:GetByID(34039,count.day,count.hour,count.minute)));
    else
        CSAPI.SetText(txtTime,string.format("%s%s",LanguageMgr:GetByID(60001),LLanguageMgr:GetByID(1062,count.second)));
    end
    if endTime<=0 then--回到主界面并提示
        HandlerOver();
    end
end