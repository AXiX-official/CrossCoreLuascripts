--特殊勘探活动界面
local progress=nil;
local curDatas={};
local slider=nil;
local sliderTween=nil;
local eventMgr=nil;
local lastLv=-1;
local totalLv=80;
local endTime=0;
local fixedTime=1;
local upTime=0;
local fixedGirds={};
local isSpecial=false;
local exData=nil;--活动信息
local currClickLv=nil;
local layout=nil;
local girds={};
local animator=nil;
local fixedCfg=nil;
local isPlayTween=true;
local sPosX=0;
local width=187;
local progressTween=nil;
local action=nil;
local action2=nil;
function Awake()
    UIUtil:AddTop2("ExplorationMain",gameObject, OnClickReturn,OnClickHome,{})
    layout=ComUtil.GetCom(hsv,"UISV");
    layout:Init("UIs/SpecialExploration/SpecialExplorationItem",LayoutCallBack,true)
    -- layout:AddToCenterFunc(OnSRChange);
    layout:AddOnValueChangeFunc(OnValueChange);
    layout:AddOnOpenFunc(PlayEnterTween);
    layout.animTotalTime=0.6
    progress=ComUtil.GetCom(progressBar,"Slider")
    slider=ComUtil.GetCom(expBar,"Slider")
    sliderTween=ComUtil.GetCom(expBar,"ActionSliderBar")
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.SpecialExploration_Info_Ret,Refresh)
    eventMgr:AddListener(EventType.SpecialExploration_Revice_Ret,Refresh)
    eventMgr:AddListener(EventType.SpecialExploration_Tween_Over,OnTweenOver);
    animator=ComUtil.GetComInChildren(btn_change,"Animator");
    action=ComUtil.GetCom(enterTween,"ActionMoveByCurve");
    action2=ComUtil.GetCom(enterTween2,"ActionMoveByCurve");
    progressTween=ComUtil.GetCom(progressBar,"ActionScaleT");
end

function OnDestroy()
    eventMgr:ClearListener();
end

--data:特殊勘探ID
function OnOpen()
    -- if data then
    --     PermitProto:GetInfo(data);
    -- end
    Refresh();
end

function Refresh()
    exData=ExplorationMgr:GetExData(data);
    -- LogError(exData:GetLevelUpExp(30));
    -- LogError(exData:GetLevelUpExp(31));
    -- LogError(exData:GetLevelUpExp(32));
    local hasRevice=false;
    if exData then
        --初始化规则、剩余时间
        hasRevice=exData:HasRevice();
        CSAPI.SetText(txtRule2,exData:GetDesc());
        local st= TimeUtil:GetTimeStampBySplit(exData:GetStartTime())
        local et=TimeUtil:GetTimeStampBySplit(exData:GetEndTime())
        endTime=et-TimeUtil:GetTime();
        -- local sTime=os.date("%Y-%m-%d", st)
        -- local eTime=os.date("%Y-%m-%d", et)
        -- local txt=LanguageMgr:GetByID(34009,sTime,eTime);
        RefreshDownTime();
        -- CSAPI.SetText(txtTime,txt);
        --初始化代币数量、进度条
        local exp=exData:GetCurrExp();
        local curLv=exData:GetCurrLv();
        RefreshExp();
        --初始化物品信息和领取状况
        fixedCfg=exData:GetFixedSPCfg();
        SetFixedObj(fixedCfg);
        local lessLv=nil;
        curDatas,lessLv=exData:GetRewardCfgs(isSpecial,false);
        curLv=lessLv and lessLv or curLv;
        CSAPI.SetGOActive(fullMask,isPlayTween)
        if isPlayTween then
            CSAPI.SetAnchor(spNode,-1440,0)
        end
        if isSpecial then
            curLv=0;
            CSAPI.SetScale(progressBar,0,1,1);
        end
        CSAPI.SetGOActive(spObj,not isSpecial);
        layout.isAnim=isPlayTween;
        layout:IEShowList(#curDatas,nil,curLv);
    end
    CSAPI.SetGOActive(btn_receive,hasRevice);
    CSAPI.SetGOActive(btn_jump,not hasRevice);
end

function PlayEnterTween()
    if isPlayTween then
        if not isSpecial then
            SetProgressBar();
            if progressTween then
                progressTween:Play();
            end
        end
        if action and action2 and isSpecial~=true then
            action:Play();
            action2:Play();
        end
        local ls=layout:GetIndexs();  
        for i=0,ls.Length-1 do
            local index=ls[i];
            local posX=width*i*-1;
            local item=layout:GetItemLua(index);
            local isLast=(index+1)==ls[ls.Length-1];
            item.SetEnterTween({posX},0,isLast);
        end
    end
end

function LayoutCallBack(index)   
    local item=layout:GetItemLua(index);
    local d=curDatas[index];
    local state=exData:GetRewardState(d.index);
    local realExp=0;
    if d.isInfinite then
        realExp=exData:GetLevelUpExp(index);
    end
    item.Refresh(d,state,realExp);
    item.SetClickCB(OnClickItem);
    if isPlayTween then
        local posX=width*index*-1;
        item.SetPos({posX});
    end
end

function OnTweenOver()
    if IsNil(gameObject) then
        do return end
    end
    isPlayTween=false;
    CSAPI.SetGOActive(fullMask,false);
end

function OnClickItem(cfg)
    if cfg and exData then
        local state=exData:GetRewardState(cfg.index);
        if state==2 then
            PermitProto:GetReward(exData:GetID(),cfg.index);
        end
    end
end

function OnValueChange()    
    local indexs=layout:GetIndexs();
    if indexs and indexs.Length>0 then
        local cIndex=indexs.Length>2 and indexs[indexs.Length-1] or indexs[0];
        if currClickLv~=cIndex and exData then
            currClickLv=cIndex;
            fixedCfg=exData:GetFixedSPCfgByLv(currClickLv)
            SetFixedObj(fixedCfg);
        end
        if not isSpecial then
            SetProgressBar();
        end
    end
end

--设置进度条长度
function SetProgressBar()
    if exData==nil then
        do return end
    end
    local x=CSAPI.GetAnchor(Content)
    local val=(exData:GetCurrLv()*187+x-38)/1590;
    val=isSpecial and 0 or val;
    progress.value=val;
    CSAPI.SetGOActive(fillEff,val>0.1);
end


function OnClickReturn()
    view:Close();
end

function OnClickHome()
    UIUtil:ToHome()
end

--经验值相关动画
function RefreshExp()
    local percent=0;
    --刷新经验
    local upExp=exData:GetLevelUpExp();
    CSAPI.SetText(txtCoin,tostring(exData:GetCurrExp()));
    if exData and exData:IsMaxLv() then
        CSAPI.SetText(txtLvCoin,LanguageMgr:GetByID(62042));
        percent=1;
    else
        if upExp then
            CSAPI.SetText(txtLvCoin,tostring(upExp));
            percent=exData:GetCurrExpPercent();
        end
    end
    lastLv=exData:GetCurrLv()
    slider.value=percent;
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

function SetFixedObj(_d)
    --设置代币数量
    if _d==nil or exData==nil then
        do return end
    end
    local state=exData:GetRewardState(_d.index);
    if _d.isInfinite then
        local str=state==2 and LanguageMgr:GetByID(62038,exData:GetLoopReviceNum()) or tostring(exData:GetLevelUpExp(_d.index));
        CSAPI.SetText(txtNum,str);
    else
        CSAPI.SetText(txtNum,tostring(_d.exp));
    end
    local list=GridUtil.GetGridObjectDatas2(_d.reward);
    local cb=state==2 and OnClickFixed or GridClickFunc.OpenInfoSmiple;
    -- ItemUtil.AddItems("Grid/GridItem", fixedGirds, list, spLayout, OnClickFixed, 1)
    for i=1,3 do
        CSAPI.SetGOActive(this["over"..i],i<=#list);
        CSAPI.SetGOActive(this["node"..i],i<=#list);
        if i>#girds then
            ResUtil:CreateUIGOAsync("Grid/GridItem", this["node"..i],function(go)
                local lua=ComUtil.GetLuaTable(go);
                lua.Refresh(list[i]);
                lua.SetClickCB(cb);
                table.insert(girds,lua);
                UIUtil:SetRedPoint2("Common/Red2", this["node"..i], state==2, 80, 80, 0, 1.44)
            end)
        else
            if i<=#list then
                girds[i].Refresh(list[i]);
                girds[i].SetClickCB(cb);
                UIUtil:SetRedPoint2("Common/Red2", this["node"..i], state==2, 80, 80, 0, 1.44)
            end
        end
    end
    --初始化物品信息和领取状况
    CSAPI.SetGOActive(lockObj,state==1);
    CSAPI.SetGOActive(spRedObj,state==2);
    CSAPI.SetGOActive(spMask,state==3);
end

function OnClickFixed()
    if fixedCfg and exData then
        local state=exData:GetRewardState(fixedCfg.index);
        if state==2 then
            PermitProto:GetReward(exData:GetID(),fixedCfg.index);
        end
    end
end

function RefreshDownTime()
    local t=TimeUtil:GetTimeStampBySplit(exData:GetEndTime());
    local count=TimeUtil:GetDiffHMS(t,TimeUtil.GetTime());
    if count.day>0 or count.hour>0 or count.minute>0 or count.second>60 then
        CSAPI.SetText(txtTime,string.format(LanguageMgr:GetByID(34039),count.day,count.hour,count.minute));
    else
        CSAPI.SetText(txtTime,LanguageMgr:GetByID(1062,count.second));
    end
    if endTime<=0 then--回到主界面并提示
        HandlerOver();
    end
end

--活动结束或者没有下一个活动
function HandlerOver()
    CSAPI.CloseAllOpenned();
    FuncUtil:Call(function()
        Tips.ShowTips(LanguageMgr:GetTips(22003));
    end,nil,100);      
end

--一键领取
function OnClickReceive()
    if exData then
        PermitProto:GetReward(exData:GetID(),-1);
    end
end

--变更内容为特殊结果
function OnClickChange()
    isPlayTween=true;
    isSpecial=not isSpecial
    Refresh();
    if animator then
        animator:Play("Btn_flod",-1,0);
    end
end

function OnClickJump()
    if exData then
        exData:Jump()
    end
end