
function Awake()    

    txtName = ComUtil.GetCom(goNameText,"Text");
    txtLv = ComUtil.GetCom(goLvText,"Text");

    hpBar = ComUtil.GetCom(goHp,"BarBase");
    hpBar0 = ComUtil.GetCom(goHp0,"BarBase");
    txtHp = ComUtil.GetCom(goHpText,"Text");

    spBar = ComUtil.GetCom(goSp,"BarBase");
    txtSp = ComUtil.GetCom(goSpText,"Text");
    
    xpBar = ComUtil.GetCom(goXp,"BarBase");
    --txtName = ComUtil.GetCom(goNameText,"Text");

    SetTarget(nil);
    --SetBlinkState(false);

    local goBuff = ResUtil:CreateUIGO("Fight/BuffActor",buffNode.transform);
    buffView = ComUtil.GetLuaTable(goBuff);
end

function OnInit()
    InitListener();

    InitBoss();
end

function InitListener()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Character_Create,OnCharacterCreate); 
    eventMgr:AddListener(EventType.Character_FightInfo_Changed,OnCharacterFightInfoChanged);
   
    eventMgr:AddListener(EventType.Fight_View_Main_Info_Show_State, OnFightInfoShowStateChanged);
    eventMgr:AddListener(EventType.Fight_UI_Enter_Action,PlayEnterAction);    
    eventMgr:AddListener(EventType.Fight_Action_Turn,OnFightActionTurn);    
     
end
function OnDestroy()
    eventMgr:ClearListener();
end

function PlayEnterAction()
    if(playAction)then
        return;
    end
    playAction = 1;
    ApplyShow();
end

function ApplyShow()
    if(not playAction or not isShow)then
        return;
    end
    CSAPI.SetGOActive(enterAction,true);
end

function SetShowState(state)
    isShow = state and not bossDead;
    --LogError("boss info" .. tostring(isShow));
    CSAPI.SetAnchor(rootNode,isShow and 0 or 10000,0);
    ApplyShow();
end

function OnFightInfoShowStateChanged(state)
    CSAPI.SetGOActive(node,state and target ~= nil);
end

function InitBoss()
    local characters = CharacterMgr:GetAll();
    for _,character in pairs(characters)do
        OnCharacterCreate(character);   
    end
end

function OnCharacterCreate(character)   
    if(character == nil or character.GetCharacterType() ~= CardType.Boss)then
        return;
    end
    EventMgr.Dispatch(EventType.Fight_Boss);
--    DebugLog("Boss信息");
--    DebugLog(character.data);
    SetTarget(character);
end
function OnCharacterFightInfoChanged(character)
    if(target == nil or character ~= target)then
        return;
    end

    UpdateInfo();
end

function SetTarget(targetCharacter)
    target = targetCharacter;
    CSAPI.SetGOActive(node,target ~= nil);

    if(target ~= nil)then
        txtName.text = target.GetName();
        local lvStr = LanguageMgr:GetByID(1033) or "LV."
        txtLv.text = lvStr.."<size=30>" .. target.GetLv() .. "</size>";

        local cfg = target.GetCfgModel();  

        ResUtil.RoleCard:Load(icon, cfg.icon);
    end
end

function OnFightActionTurn()
    UpdateBGM(currHPProgress);
end

function UpdateInfo()
    if(target == nil)then
        return;
    end
    --HP
    local hp,maxhp,buffhp = target.GetHpInfo();
    local hpProgress = (hp + buffhp)  / maxhp;
    currHPProgress = hpProgress;
    hpBar:SetProgress(hpProgress); 
    hpBar0:SetProgress(hpProgress); 
    txtHp.text = "<color=#ffffff><size=30>" .. math.ceil(hp) .. "</size></color>/" .. math.ceil(maxhp);
--    if(hpProgress < 0.3)then
--        SetBlinkState(true);
--    else
--        SetBlinkState(false);
--    end
            
    --XP
    --local xp = target.xp and (target.xp + 1) or 0;
    local xp = target.xp and target.xp or 0;
    local maxxp = target.xpMax or 1;
    xpBar:SetFullProgress(xp,maxxp);  
    
    --SP
    local sp = target.sp;   
    if(sp and sp >= 0)then
        if(sp > 0)then
            CSAPI.SetGOActive(spBarNode,true);
        end
        local maxsp = target.spMax or 100;
        if(sp)then        
            spBar:SetProgress(sp / maxsp); 
        else
            spBar:SetProgress(0,true); 
        end
        txtSp.text = "<color=#FFC146><size=35>" .. (sp or 0) .. "</size></color>/" .. maxsp;
    end

    UpdateBuff();

    --UpdateBGM(hpProgress);    
    
    if(hp <= 0)then
        if(not bossDead)then
            bossDead = 1;   
            FuncUtil:Call(SetShowState,nil,1000,false); 
        end
    else
        bossDead = nil;
        SetShowState(true);
    end
end
--更新Buff
function UpdateBuff()
    local buffs = nil;
    if(target)then
        buffs = target.GetBuffs();
    end
    
    buffView.UpdateBuff(buffs);
end


function UpdateBGM(hpProgress)
    if(not target or not hpProgress)then
        return;
    end
    local cfg = target.GetCfg();
    --LogError(cfg.bossBGM);
    --cfg.bossBGM = {{50,"Battle_LargeBoss_NeuroSeparator2"}};
    if(not cfg or not cfg.bossBGM)then
        return;
    end
    nextBGMIndex = nextBGMIndex or 1;
    
    local playIndex = nil;
    for i,cfgBossBGM in ipairs(cfg.bossBGM) do
        if(i >= nextBGMIndex)then
            if(hpProgress <= cfgBossBGM[1] * 0.01)then
                playIndex = i;
            end
        end
    end

    if(playIndex)then        
        nextBGMIndex = playIndex + 1;
        local playBossBGM = cfg.bossBGM[playIndex];
        CSAPI.StopBGM(1);
        FuncUtil:Call(function()
            --CSAPI.PlayBGM(playBossBGM[2]);
            EventMgr.Dispatch(EventType.Play_BGM, playBossBGM[2]);
        end,nil,0);
        
    end
end

function SetBlinkState(state)
    CSAPI.SetGOActive(blink,state);
end

function ApplyMove(state)
    --CSAPI.MoveTo(node,"move_linear_local",state and 0 or -800,0,0); 
end

function OnClickSelf()
    if(target)then
        local id = target.GetID();
        if(FightClient:GetInputCharacter())then
            if (g_FightMgr.type~=SceneType.PVP and g_FightMgr.type ~= SceneType.PVPMirror) or _G.showPvpRoleInfo==true then --非PVP界面可以打开查看数据
                CSAPI.OpenView("FightRoleInfo",id);
            end
        end
        EventMgr.Dispatch(EventType.Character_FightInfo_Log,id);
    end
end