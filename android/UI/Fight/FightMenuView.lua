-- 战斗菜单
local fade = nil
local canvasGroup = nil
local panel = nil
function Awake()
    --    if(g_FightMgr and g_FightMgr.type ~= SceneType.PVP) then
    --	    FightClient:SetStopState(true);	
    --    end
    fade = ComUtil.GetCom(btnObj, "ActionFade")
    canvasGroup =ComUtil.GetCom(btnQuit,"CanvasGroup")
end

function OnLoadBgCallBack()
    CSAPI.SetImgColor(bg, 255, 255, 255, 255);
end

function OnOpen()
    -- CSAPI.SetGOActive(btnQuit,g_FightMgr.type~=SceneType.PVPMirror) 
    ResUtil:CreateUIGOAsync("FightAction/FightPauseOrCut", itemParent.gameObject, function(go)
        SetClickMaskState(true);--屏蔽点击
        
        panel = ComUtil.GetLuaTable(go)
        local descStr = FightClient:GetDirll() and "" or LanguageMgr:GetByID(25031)
        panel.Init({LanguageMgr:GetByID(25034)}, descStr, true)
        fade:Play(0, 1, 250, 150,OnPlayEnterComplete)    
    end) 
       
    canvasGroup.alpha = GetQuitState() and 1 or 0.7
    --FuncUtil:Call(OnPlayEnterComplete,nil,500);
end
--等待入场动画结束，暂停，关闭点击遮罩
function OnPlayEnterComplete()
    if(FightActionUtil:IsHangup())then
        OnClickExit();
        FightClient:SetPauseState(false);
        return;        
    end


    SetClickMaskState(false);
    FightClient:SetPauseState(true);
end
function SetClickMaskState(state)
    CSAPI.SetGOActive(clickMask,state);
end

function GetQuitState()
    local cfgDungeon = Cfgs.MainLine:GetByID(DungeonMgr:GetCurrId())
    if cfgDungeon and (cfgDungeon.type == eDuplicateType.MainNormal or cfgDungeon.type == eDuplicateType.MainElite)  then
        return MenuMgr:CheckModelOpen(OpenViewType.special, SpecialOpenViewType.AutoFight);
    end
    return true
    -- return DungeonMgr:CheckDungeonPass(1003)
end

function OnClickQuit()
    if not GetQuitState() then
        LanguageMgr:ShowTips(1010, "0-3")
        return
    end
    if (FightActionMgr:HasFightEnd()) then
        OnClickExit();
        return;
    end
    if (g_FightMgr and g_FightMgr.type == SceneType.PVPMirror and g_ArmyCanQuit == 0) then
        LanguageMgr:ShowTips(19000)
        return;
    end
    local func = g_FightMgr and  (g_FightMgr.type == SceneType.PVP or g_FightMgr.type == SceneType.PVEBuild) and OnSureBack_PVP or
                     OnSureBack;

    local isDirll = FightClient:GetDirll() and true or false
    if (isDirll) then
        --func = OnDirllBack;
        OnDirllBack();
        return;
    elseif (g_FightMgr and g_FightMgr.type == SceneType.PVE) then
        --if (DungeonMgr:CheckDungeonPass(1004)) then
            func = OnSureDungeonFightQuit;
--        else
--            Tips.ShowTips("通关0-4后开启");
--            return;
--        end
    end

    local teamCount = BattleMgr:GetTeamCount();

    local quitStr = "";
    if (isDirll) then
        quitStr = LanguageMgr:GetTips(19005)
    elseif (teamCount >= 2) then
        quitStr = LanguageMgr:GetTips(19001)
    elseif (teamCount == 1) then
        quitStr = LanguageMgr:GetTips(19002)
    else
        quitStr = LanguageMgr:GetTips(19003)
    end

    local dialogData = {
        content = g_FightMgr and g_FightMgr.type == SceneType.PVPMirror and LanguageMgr:GetTips(19004) or quitStr,
        okCallBack = function()
            panel.ExitTween()
            if(not IsNil(fade))then
                fade:Play(1, 0, 200, 300, function()
                    func()
                end)
            end
        end
    };
    CSAPI.OpenView("Dialog", dialogData);
end

-- 训练退出
function OnDirllBack()
    FightActionMgr:Surrender({
        custom_result = 1,
        bIsWin = 1
    });
    -- FightActionMgr:Push(FightActionMgr:Apply(FightActionType.FightEnd, {custom_result = 1, bIsWin = 1, content = StringConstant.fight_result1}));
    OnClickExit();
end

-- 确认退出
function OnSureBack()
    --    if(g_FightMgr and g_FightMgr.type ~= SceneType.PVP) then
    --	    FightClient:SetStopState(false);	
    --    end
    FightOverTool.ApplyEnd(g_FightMgr and g_FightMgr.type)
    OnClickExit();

    FightProto:LeaveFight();
end

function OnSureDungeonFightQuit()
    if (FightActionMgr:HasFightEnd()) then
        OnClickExit();
        return;
    end

    FightClient:ApplySurrender();

    FightClient:QuitFihgt();

    OnClickExit();
end

function OnSureBack_PVP()
    g_FightMgr:Quit()
    OnClickExit();
end

function OnClickBack()
    FightClient:SetPauseState(false);
    panel.ExitTween()
    fade:Play(1, 0, 200, 300, function()
        view:Close();
    end) 
end

function OnClickExit()
    view:Close();

    FightClient:SetPauseState(false);
end

function OnClickSetting()
    -- FightClient:SetPauseState(false);
    CSAPI.OpenView("SettingView", SettingEnterType.FightMenu)
end

function OnDestroy()
    ReleaseCSComRefs();
end





---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  OnClickBack then
        OnClickBack();
    end
end


----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    itemParent = nil;
    btnObj = nil;
    btnQuit = nil;
    Text = nil;
    Text = nil;
    btnBack = nil;
    Text = nil;
    Text = nil;
    view = nil;
end
----#End#----
