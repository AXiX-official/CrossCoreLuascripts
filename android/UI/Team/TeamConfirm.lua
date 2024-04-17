--队伍选择面板
local currDungeonID=nil;
local teamItems={};
local startTeamIdx=0; --起始队伍下标
local endTeamIdx=0; --结束队伍下标
local teamMax=1;
local count=0;--当前可用队伍数量
local localCfg=nil;--本地保存信息
local choosieID={};--当前选择的队伍id
local downListView
local forceNPC=nil;--强制支援NPC
local assistNPCList=nil;--可选支援NPC ID列表
local isEdit=false;
local isNotAssist=false;
local slider=nil;
local currCostHot=0;--当前消耗的热值
local currCostInfo=nil;--当前消耗物品的信息
-- {-5.22988,-200}
-- {-5.22988,250}
function Awake()
    -- slider=ComUtil.GetCom(hotSlider, "OutlineBar")
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Team_Confirm_Refreh, RefreshItems)
    eventMgr:AddListener(EventType.Team_Confirm_ItemDisable, OnOptionChange)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    eventMgr:AddListener(EventType.CoolView_Close, RefreshTeams);    
    eventMgr:AddListener(EventType.Team_Card_Refresh, RefreshTeams);    
    --更新热值
	eventMgr:AddListener(EventType.CardCool_Update, OnCardCoolUpdate)
    eventMgr:AddListener(EventType.Player_HotChange, SetEnterCost)
    eventMgr:AddListener(EventType.Bag_Update,SetEnterCost);
    CSAPI.SetGOActive(btnAISetting,true);
end

function OnViewOpened(viewkey)
    if viewkey=="TeamView" then
        isEdit=true;
    end
end

function OnViewClosed(viewkey)
    if viewkey=="TeamView" then
        isEdit=false;
    end
end

function OnCardCoolUpdate()
    local team=TeamMgr:GetTeamData(1,true);
    if not isEdit then
        RefreshItems();
    end
end

function OnInit()
    UIUtil:AddTop2("TeamConfirm",gameObject, OnClickClose,nil,{})
end

function OnDisable()
    DungeonMgr:ClearAIFightInfo();
    TeamMgr:DelEditTeam();
end

function OnDestroy()
    --清理助战AI预设
    AIStrategyMgr:ClearAssistAIPrefs();
    eventMgr:ClearListener();
    ReleaseCSComRefs();
end

function OnOpen()
    TeamMgr:ClearAssistTeamIndex();
    if data then
        isNotAssist=data.isNotAssist;
    end
    -- if FriendMgr:IsRefreshAssist() then
    --     FriendMgr:InitAssistData();
    -- end
    if openSetting==TeamConfirmOpenType.Dungeon then
        LoadConfig();
        InitDungeon();
    elseif openSetting==TeamConfirmOpenType.Matrix then
        InitMatrix();
    elseif openSetting==TeamConfirmOpenType.FieldBoss then
        InitFieldBoss()
    end
    InitChoosieIDs();--初始化已选择的队伍id
    InitOptions();
    InitItem();
    InitHotItem();
    --LogError(data);
    EventMgr.Dispatch(EventType.Guide_Trigger_View,data);--尝试触发引导
end

function InitHotItem()
    if currCostInfo then
         --读取消耗信息
         local type = currCostInfo[3]
         -- local type=2;
         local num=currCostInfo[2];
         local cid=currCostInfo[1];
         if type == RandRewardType.ITEM then
             local data = GoodsData()
             data:InitCfg(cid)
             local hasCount=BagMgr:GetCount(cid);
             ResUtil.IconGoods:Load(moneyIcon3,data:GetIcon().."_1");
             CSAPI.SetText(txt_hot,tostring(hasCount));
             CSAPI.SetGOActive(moneyAdd,data:GetMoneyJumpID()~=nil);
         else
             LogError("配置表错误！道具类型错误！");
             LogError(currCostInfo);
         end
    else
        local maxHot=PlayerClient:MaxHot();
        local currHot=PlayerClient:Hot();
        ResUtil.IconGoods:Load(moneyIcon3, "10035_1")
        CSAPI.SetText(txt_hot,string.format("%s/%s",currHot,maxHot));
        CSAPI.SetGOActive(moneyAdd,true);
        -- slider:SetProgress(currHot/maxHot);
    end
end

function SetFighting(num)
    if num==nil or num==0 then
        CSAPI.SetGOActive(fightObj,false);
    else
        CSAPI.SetGOActive(fightObj,true);
        CSAPI.SetText(txt_fighting,tostring(tostring(num)));
    end
end

function RefreshItems()
    RefreshChoosieIDs();
    InitOptions()
    local list={};
    for k,v in ipairs(teamItems) do
        local state=TeamConfirmItemState.Normal;
        if openSetting==TeamConfirmOpenType.Matrix or isNotAssist then
            state=TeamConfirmItemState.UnAssist;
        end
        if k>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        local npc=k==1 and forceNPC or nil
        table.insert(list,{id=k,num=k,options=optionsData,forceNPC=npc,NPCList=assistNPCList,showClean=teamMax>1,currState=v.GetState(),state=state,ShowDownList=ShowDownList});
    end
    ItemUtil.AddItems("TeamConfirm/TeamListItem", teamItems, list, itemNode, nil, 1, nil)
end

function RefreshTeams()
    for k,v in ipairs(teamItems) do
        v.SetTeamData(v.GetTeamIndex());
    end
end

function InitItem()
    local list={};
    if teamMax>1 then
        CSAPI.SetGOActive(lines,true);
        CSAPI.SetGOActive(lines2,false);
    else
        CSAPI.SetGOActive(lines2,true);
        CSAPI.SetGOActive(lines,false);
    end
    for i=1,teamMax do
        local state=TeamConfirmItemState.Normal;
        if openSetting==TeamConfirmOpenType.Matrix or isNotAssist then
            state=TeamConfirmItemState.UnAssist;
        end
        if i>teamMax then
            state=TeamConfirmItemState.Disable;
        end
        local npc=i==1 and forceNPC or nil
        table.insert(list,{id=i,num=i,options=optionsData,showClean=teamMax>1,forceNPC=npc,NPCList=assistNPCList,state=state,ShowDownList=ShowDownList});
    end
    ItemUtil.AddItems("TeamConfirm/TeamListItem", teamItems, list, itemNode, nil, 1, nil)
end

function InitChoosieIDs()
    local choosieCount=0;
    local otherID={};--未选中的可用队伍id
    --查找当前可用的队伍中是否有对应的id
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        if team and team:GetCount()>0 and team:HasLeader() then
            if  localCfg~=nil then
                local hasID=false;
                local idx=0;
                for k,v in ipairs(localCfg) do
                    if v.order==-1 then --置空
                        hasID=true;
                        choosieID[v.index]={index=v.index,teamId=v.order};
                        choosieCount=choosieCount+1;
                        idx=k;
                        break;
                    elseif i==v.order then                 
                        hasID=true;
                        --可以选中的队伍
                        choosieID[v.index]={index=v.index,teamId=i};--index:子物体的下标，teamId:队伍id
                        choosieCount=choosieCount+1;
                        idx=k;
                        break;
                    end
                end
                if hasID==false then
                    table.insert(otherID,i);
                else
                    table.remove(localCfg,idx);
                end
            else
                table.insert(otherID,i);
            end
        end
    end
    if choosieCount<teamMax then
        if choosieCount==0 then
            otherID={1,2};
        elseif (otherID==nil or #otherID<=0) and choosieID then
            for i = startTeamIdx, endTeamIdx do
                local has=false;
                for k,v in pairs(choosieID) do
                    if i==v.teamId then
                        has=true;
                        break;
                    end
                end
                if has~=true then
                    table.insert(otherID,i);
                    break;
                end
            end
        end
        local otherIndex=1;
        for i=1,teamMax  do
            if choosieCount>0 then
                for k,v in pairs(choosieID) do
                    if i~=v.index then
                        choosieID[i]={index=i,teamId=otherID[otherIndex]};
                        otherIndex=otherIndex+1;
                        choosieCount=choosieCount+1;
                    end
                end
            else
                choosieID[i]={index=i,teamId=otherID[otherIndex]};
                otherIndex=otherIndex+1;
                choosieCount=choosieCount+1;
            end
            if choosieCount==teamMax then
                break;
            end
        end
    end
    count=choosieCount;
end

function RefreshChoosieIDs() --当编队消失时查找下一支符合编队条件的队伍
    local choosieCount=0;
    local otherID={};--未选中的可用队伍id
    local choosieIndex=0;
    --查找当前可用的队伍中是否有对应的id
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        local hasID=false;
        if choosieID then
            for k,v in pairs(choosieID) do
                 if v.teamId==i and team and team:GetCount()>0 and team:HasLeader() then --置空
                    hasID=true;
                    choosieCount=choosieCount+1;
                    choosieIndex=v.index;
                    break;
                elseif v.teamId==-1 then                 
                    hasID=true;
                    choosieID[v.index]={index=tonumber(v.index),teamId=i};--index:子物体的下标，teamId:队伍id
                    choosieCount=choosieCount+1;
                    break;
                end
            end
        end
        if hasID==false and team and team:GetCount()>0 and team:HasLeader() then
            table.insert(otherID,i);
        end
    end
    if choosieCount<teamMax and otherID~=nil and #otherID>0 then
        if choosieCount==0 then
            otherID={1,2};
        elseif (otherID==nil or #otherID<=0) and choosieID then
            for i = startTeamIdx, endTeamIdx do
                local has=false;
                for k,v in pairs(choosieID) do
                    if i==v.teamId then
                        has=true;
                        break;
                    end
                end
                if has~=true then
                    table.insert(otherID,i);
                    break;
                end
            end
        end
        local otherIndex=1;
        for i=1,teamMax  do
            if choosieCount>0 then
                for k,v in pairs(choosieID) do
                    if choosieIndex~=v.index then
                        choosieID[v.index]={index=v.index,teamId=otherID[otherIndex]};
                        otherIndex=otherIndex+1;
                        choosieCount=choosieCount+1;
                    end
                end
            else
                choosieID[i]={index=i,teamId=otherID[otherIndex]};
                otherIndex=otherIndex+1;
                choosieCount=choosieCount+1;
            end
            if choosieCount==teamMax then
                break;
            end
        end
    end
    count=choosieCount;
end

function InitOptions()
    optionsData = {};
    local sNum=0;--选中的id数
    for i = startTeamIdx, endTeamIdx do
        local team=TeamMgr:GetTeamData(i);
        if team  then
            local option={};
            if sNum<count then
                for k,v in pairs(choosieID) do
                    if i==v.teamId then
                        option.isSelect=true;
                        option.itemID=v.index; --子物体id
                        sNum=sNum+1;
                        break;
                    end
                end   
            end
            option.desc=i<10 and "0".. i or i; --选项描述
            option.name=team:GetTeamName();
            option.id=i; --队伍id
            -- option.index=#optionsData+1;--选项下标
            if (team:GetCount()>0 and team:HasLeader()) or option.isSelect  then
                option.enable=true;
                table.insert(optionsData, option);
            -- else
            --     option.enable=false;
            end
        end
    end
end

function OnClickBattle()
    --检测热值
    if currCostInfo then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local data = GoodsData()
            data:InitCfg(cid)
            local hasCount=BagMgr:GetCount(cid);
            if hasCount<num then
                return;
            end
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
   else
        local currHot=PlayerClient:Hot();
        if currHot<math.abs(currCostHot) then
            --弹出补充热值的提示
            CSAPI.OpenView("HotPanel");
            return;
        end
   end
    if openSetting==TeamConfirmOpenType.Dungeon then
        OnDungeon();
    elseif openSetting==TeamConfirmOpenType.Matrix then
        OnMatrix();
    elseif openSetting==TeamConfirmOpenType.FieldBoss then
        OnFieldBoss()
    end
end

function OnClickClose()
    TeamMgr:ClearAssistTeamIndex();
    Close();
end

function SetEnterCost()
    if currCostInfo~=nil then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local data = GoodsData()
            data:InitCfg(cid)
            local hasCount=BagMgr:GetCount(cid);
            ResUtil.IconGoods:Load(costIcon,data:GetIcon().."_3");
            local costHot=hasCount>=num and string.format("<color='#000000'>%s</color>",num) or string.format("<color='#cd333e'>%s</color>",num);
            CSAPI.SetText(txt_cost,data:GetName().."-"..costHot);
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
    else
        local currHot=PlayerClient:Hot();
        local cHot=math.abs(currCostHot)
        local costHot=currHot>=cHot and string.format("<color='#000000'>%s</color>",currCostHot) or string.format("<color='#cd333e'>%s</color>",currCostHot);
        CSAPI.LoadImg(costIcon,"UIs/TeamConfirm/btn_8_07.png",true,nil,true);
        CSAPI.SetText(txt_cost,LanguageMgr:GetByID(26041,costHot));
    end
    InitHotItem();
end

function Close()
    -- for k,v in ipairs(teamItems) do
    --     if v.IsChange() then
    --         v.SaveData();
    --     end
    -- end
    view:Close();
end
function OnClickEdit()
    CSAPI.OpenView("TeamView");
end

function InitDungeon()
    if CSAPI.IsViewOpen("FightOverResult") then
        FightClient:Clean()
        FriendMgr:ClearAssistData();
        TeamMgr:ClearAssistTeamIndex();
        TeamMgr:ClearFightTeamData();
        UIUtil:AddFightTeamState(2, "FightOverResult:ApplyQuit()")
    end
    if data and data.dungeonId then
        currDungeonID=data.dungeonId;
    end
    if data and data.teamNum then
        teamMax=data.teamNum 
    else
        teamMax=1;
    end
    --读取强制NPC的id，该支援位只有队伍一存在
    local starNum=0;
    local dungeonData= DungeonMgr:GetDungeonData(currDungeonID);
    local enterCost=0;
    local successCost=0;
    local moveLimit=0;
    local warnDesc=nil;
    local dungeonCfg=Cfgs.MainLine:GetByID(currDungeonID)
    if dungeonData and dungeonData:IsPass() then--已通关
        forceNPC=nil;
        assistNPCList=dungeonData:GetAssistNPCList();
        starNum=dungeonData:GetStar();
        enterCost=dungeonData:GetCfg().enterCostHot or 0;
        successCost=dungeonData:GetCfg().winCostHot or 0;
        moveLimit=dungeonData:GetActionNum();
        warnDesc=dungeonData:GetCfg().teamDescription
    else
        forceNPC=dungeonCfg.forceNPC;
        assistNPCList=dungeonCfg.arrNPC;
        enterCost=dungeonCfg.enterCostHot or 0;
        successCost=dungeonCfg.winCostHot or 0;
        local winNum=10000
        local type = dungeonCfg.jWinCon[1];
        if type == 3 then
            winNum = tonumber(dungeonCfg.jWinCon[2]);
        end
        local loseNum=10000;
        for k,v in ipairs(dungeonCfg.jLostCon) do
            if v[1]==3 then
                loseNum=tonumber(v[2]);
                break;
            end
        end
        moveLimit=winNum<loseNum and winNum or loseNum;
        warnDesc=dungeonCfg.teamDescription
    end
    if isNotAssist then
        warnDesc=teamMax>1 and LanguageMgr:GetByID(15076) or LanguageMgr:GetByID(15075)
    end
    CSAPI.SetGOActive(tipsWarn,warnDesc~=nil);
    CSAPI.SetText(txt_tipsWarn,warnDesc==nil and "" or warnDesc);
    --如果配置表中存在cost值，则读取cost信息，否则直接当热值处理
    currCostInfo=DungeonUtil.GetCost(dungeonCfg);
    currCostHot=enterCost+successCost;
    SetFighting(dungeonCfg.lvTips);
    SetEnterCost();
    CSAPI.SetText(txt_move,tostring(moveLimit));
    if dungeonCfg.nGroupID==nil or dungeonCfg.nGroupID=="" then --没有怪物组ID的时候执行逻辑
        CSAPI.SetGOActive(btnNavi,starNum==3);
    else
        CSAPI.SetGOActive(btnNavi,false);
    end
    CSAPI.SetGOActive(nameObj,true);
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
end

function OnDungeon()
    local teamNum=0;
    local duplicateTeamDatas={};
    local choosieID={};
    local choosieInfo={};--缓存配置的信息
    local dungeonCfg=Cfgs.MainLine:GetByID(currDungeonID)
    for k,v in ipairs(teamItems) do
        if k<=teamMax and v.IsUse()==true then
            local duplicateTeam=v.GetDuplicateTeamData();
            local canBattle=v.CanBattle();
            if v.GetState()~=TeamConfirmItemState.UnUse and canBattle==false then
                teamNum=teamNum+1;
            elseif duplicateTeam~=nil and canBattle==true and v.GetState()~=TeamConfirmItemState.UnUse then
                teamNum=teamNum+1;
                table.insert(duplicateTeamDatas,duplicateTeam);
                table.insert(choosieID,duplicateTeam.nTeamIndex);
                table.insert(choosieInfo,{index=k,order=duplicateTeam.nTeamIndex});
            end
        end
    end
    if currDungeonID==nil or currDungeonID=="" then
        LogError("出战关卡的ID不能为nil！"..tostring(currDungeonID));
        return;
    elseif #duplicateTeamDatas==teamNum then
        if #duplicateTeamDatas>0 then
            --判断装备是否超量
            if EquipMgr:IsBagFull() then
                TipsMgr:HandleMsg({strId="equipBagSpaceLimit"});
                -- Tips.ShowTips(LanguageMgr:GetTips(14003));
                do return end
            end
            --进入战斗！！
            BattleMgr:SetLastCtrlId(nil);
            for k,v in ipairs(choosieID) do --用于处理单机模式下获取不到战斗中队伍数据的情况
                TeamMgr.currentIndex=v;
                local teamData=TeamMgr:GetEditTeam();
                if  teamItems[k] and teamItems[k].GetAssistData()~=nil then
                    teamData:AddCard(teamItems[k].GetAssistData());
                end
                TeamMgr:AddFightTeamData(teamData);
                UIUtil:AddFightTeamState(1,"TeamConfirm:OnDungeon()")
            end
            TeamMgr:DelEditTeam();
            for k, v in ipairs(duplicateTeamDatas) do
                for _, val in ipairs(v.team) do
                    if val.fuid then --助战卡
                        FriendMgr:SetAssistMemberCnt(val.fuid);
                    end
                end
            end
            -- LogError(duplicateTeamDatas)
            DungeonMgr:ApplyEnter(currDungeonID, choosieID, duplicateTeamDatas);
            SaveConfig(choosieInfo);
            UIUtil:AddNetWeakHandle(500);
        else
            Tips.ShowTips(LanguageMgr:GetTips(14004));
        end
    elseif duplicateTeamDatas==nil or #duplicateTeamDatas<1 then
        Tips.ShowTips(LanguageMgr:GetTips(14005));
    end
end

function InitMatrix()
    CSAPI.SetGOActive(nameObj,false);
    CSAPI.SetGOActive(btnNavi,false);
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
    teamMax=2;
end

function OnMatrix()
    local item=teamItems[1];
    if item.CanBattle()==true then
        local teamData = item.GetDuplicateTeamData()
        MatrixMgr:SetIsAttack(true)
        BuildingProto:AssualtAttack(data.id,data.index,teamData.nTeamIndex,teamData.nSkillGroup);
    end
end

function InitFieldBoss()
    CSAPI.SetGOActive(btnNavi,false)
    startTeamIdx = 1;
    endTeamIdx = g_TeamMaxNum;  
    teamMax=2;
end

function OnFieldBoss()
    local item=teamItems[1];
    if item.CanBattle()==true then
        local index = item.GetTeamIndex()
        FightProto:EnterBattleFieldBossFight({nTeamIndex = index})
    end
end

--本地保存当前选择的队伍id
function SaveConfig(tab)
    if tab then
        FileUtil.SaveToFile("config"..data.dungeonId..".txt",tab);
    end
end

--读取当前选择的队伍id
function LoadConfig()
    localCfg=FileUtil.LoadByPath("config"..data.dungeonId..".txt");
end

--刷新下拉面板
function ShowDownList(pos,itemID,func,func2)
    if downListView==nil then
        local go=ResUtil:CreateUIGO("TeamConfirm/TeamDownListView",gameObject.transform);
        downListView=ComUtil.GetLuaTable(go);
    end
    --将pos转为本地坐标
    -- pos=transform:InverseTransformPoint(pos);
    -- pos.x=pos.x+150
    downListView.Show(pos,optionsData,itemID);
    downListView.AddOnValueChange(OnDownValChange);
    downListView.AddOnClose(func2);
end

function OnDownValChange(options)
    for k,v in pairs(options) do
        teamItems[v.itemID].OnDropValChange(v);
        choosieID[v.itemID]={index=v.itemID,teamId=v.id};
    end
end

function OnOptionChange(eventData)
    for k,v in ipairs(optionsData) do
        if v.itemID==eventData then
            v.itemID=nil;
            v.isSelect=false;
            break;
        end
    end
end

function OnClickHot()
    if currCostInfo then
        --读取消耗信息
        local type = currCostInfo[3]
        -- local type=2;
        local num=currCostInfo[2];
        local cid=currCostInfo[1];
        if type == RandRewardType.ITEM then
            local data = GoodsData()
            data:InitCfg(cid)
            local jumpId=data:GetMoneyJumpID();
           if jumpId then
                JumpMgr:Jump(jumpId);
           end
        else
            LogError("配置表错误！道具类型错误！");
            LogError(currCostInfo);
        end
    else
        CSAPI.OpenView("HotPanel");
    end
end

--设置AI寻路
function OnClickNavi(go)
    local num=0;
    for k,v in ipairs(teamItems) do
        if v.GetDuplicateTeamData()~=nil and v.GetState()~=TeamConfirmItemState.UnUse then
            num=num+1;
        end
    end
    CSAPI.OpenView("FightNaviSetting",nil,num);
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()     
gameObject=nil;
transform=nil;
this=nil;  
itemNode=nil;
tipsWarn=nil;
txt_tipsWarn=nil;
btnBattle=nil;
txt_battle=nil;
txt_battleTips=nil;
btnNavi=nil;
txt_navi=nil;
txt_naviTips=nil;
hotIcon=nil;
moveIcon=nil;
txt_cost=nil;
txt_move=nil;
view=nil;
end
----#End#----