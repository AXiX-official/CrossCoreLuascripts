local expBar = nil;
local pos = {{-514, -7}, {-256, -7}, {3, -7}, {265, -7}, {526, -7}};
local hpBar = nil;
local fillExpBar = SetNil
local hasCallFunc = false;
local isShowLvBar = false

local bIsWin = false
local isPVPWin = false
local fightOverData = nil
local sceneType = nil

local viewLua = nil

-- 结算
function Awake()
    CSAPI.SetGOActive("AIMask", false)

    -- GM挂机测试用
    if (_G.Fight_Auto) then
        FuncUtil:Call(ApplyQuit, nil, 2000);
    end

    MenuMgr:ReduceMenuBuyChangeNum()
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.Loading_Complete, OnLoadComplete)
    FightClient.IsFightOver=true;
end

function OnViewOpened(viewKey)
    if viewKey == "Plot" then
        CSAPI.StopUISound("ui_battle_victory_settlement")
    end
end

function OnLoadComplete()
    if bIsWin then
        CSAPI.PlayUISound("ui_battle_victory_settlement")
    end
end

function OnDisable()
    FightClient.IsFightOver=false;
    eventMgr:ClearListener();
end

-- data  FightResultTool的封装
function OnOpen()
    if isFirst then
        return 
    end
    isFirst = false
    
    sceneType = data.sceneType -- 在FightActionFightEnd添加的

    bIsWin = GetIsWin(sceneType)

    --FightProto:DuplicateOver整合的数据
    local fightOverData = FightProto:GetFightOverData() 
    if fightOverData then
        data.rewards = fightOverData.rewards or data.rewards
        data.nPlayerExp = fightOverData.nPlayerExp and data.nPlayerExp + fightOverData.nPlayerExp or data.nPlayerExp
    end

    local viewPath = bIsWin and "FightOver/FightOverToWin" or "FightOver/FightOverToLose"
    ResUtil:CreateUIGOAsync(viewPath, viewParent, function(go)
        viewLua = ComUtil.GetLuaTable(go)
        viewLua.Refresh(data, data.elseData)
        -- 自动
        AI()
    end)

    EventMgr.Dispatch(EventType.Fight_Over_Panel_Show)

    local isSweep = data.elseData and data.elseData.isSweep or false
    if not isSweep then
        MenuMgr:SetFightOver(true)
    end
end

function GetIsWin(_sceneType)
    if (_sceneType == SceneType.BOSS or _sceneType == SceneType.PVP or _sceneType == SceneType.PVPMirror) then
        return true
    elseif _sceneType == SceneType.PVP then
        isPVPWin = data.bIsWin
        return true
    else
        return data.bIsWin
    end
end

-- 自动过图
function AI()
    if (sceneType == SceneType.PVE and BattleMgr:GetAIMoveState()) then
        -- 缓存奖励数据
        CSAPI.SetGOActive("AIMask", true)
        FuncUtil:Call(AIClick, nil, 2000)
    end
end

function AIClick()
    OnClickMask()
    if (isClicked == 1) then
        FuncUtil:Call(OnClickMask, nil, 1500)
    end
end

-- 退出 jump:跳转方式
function ApplyQuit()
    if(not PlayerClient:GetUid())then
        return;
    end

    FightClient:Clean()
    if sceneType == SceneType.PVE or sceneType == SceneType.PVEBuild then -- 清理PVE的数据
        local dungeonId = DungeonMgr:GetCurrId();
        local isOver = DungeonMgr:IsCurrDungeonComplete();
        if isOver then
            -- 副本结束
            if sceneType == SceneType.PVE and BattleMgr:GetAIMoveState() and DungeonMgr:CurrSectionIsMainLine() and
                hasCallFunc ~= true then
                -- 记录战斗队伍信息、关卡ID
                local teams = TeamMgr:GetAutoDuplicateTeamData();
                DungeonMgr:AddAutoDungeonInfo(dungeonId, teams);
                MenuMgr:AddOpenFunc("Dungeon", function()
                    local eventMgr = ViewEvent.New();
                    eventMgr:AddListener(EventType.Loading_Complete, function()
                        if bIsWin then -- 胜利
                            CSAPI.OpenView("FightNaviReward");
                        else -- 失败
                            local dialogdata = {};
                            dialogdata.content = LanguageMgr:GetByID(25006);
                            dialogdata.okCallBack = function()
                                CSAPI.OpenView("FightNaviReward");
                            end
                            CSAPI.OpenView("Prompt", dialogdata)
                        end
                        eventMgr:ClearListener();
                    end)
                end);
                hasCallFunc = true;
            end
            FriendMgr:ClearAssistData();
            TeamMgr:ClearAssistTeamIndex();
            TeamMgr:ClearFightTeamData();
            UIUtil:AddFightTeamState(2, "FightOverResult:ApplyQuit()")
        elseif dungeonId ~= nil and dungeonId ~= "" then -- 未结束
            DungeonMgr:ApplyEnter(dungeonId);
            return;
        end
    end
    -- 基地突袭
    if (sceneType == SceneType.PVEBuild) then
        if (data.elseData and data.elseData == RealArmyType.Matrix) then
            MatrixMgr:InScene()
        else
            -- 测试用
            SceneLoader:Load("MajorCity")
        end
    elseif (sceneType == SceneType.PVP or sceneType == SceneType.PVPMirror) then
        ExerciseMgr:Quit(sceneType, data.elseData.type)
    elseif (sceneType == SceneType.BOSS) then
        BattleFieldMgr:Quit()
    elseif sceneType == SceneType.PVE then
        DungeonMgr:Quit(not bIsWin);
    elseif (sceneType == SceneType.GuildBOSS) then
        GuildFightMgr:FightQuit();
    end
end

function OnClickMask()
    if (isClicked == 2 or isClicked == 1) then
        return;
    end

    if bIsWin and not viewLua.IsAnimEnd() then
        isClicked = 1
        viewLua.JumpToAnimEnd()
        FuncUtil:Call(function ()
            if gameObject then
                isClicked = 0
            end
        end, nil, 500)
        return
    end

    isClicked = 2;
    if data and data.elseData and data.elseData.isSweep then --扫荡关闭
        view:Close()
        return
    end

    local cfg = DungeonMgr:GetFightMonsterGroup();
    local isNotPvP = sceneType ~= SceneType.PVP and sceneType ~= SceneType.PVPMirror
    if (bIsWin and cfg and cfg.storyID2 and isNotPvP) then
        PlotMgr:TryPlay(cfg.storyID2, ApplyQuit, nil, false);
    else
        ApplyQuit();
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  OnClickMask then
        OnClickMask();
    end
end

function OnDestroy()
    ReleaseCSComRefs();
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    PlayerLv = nil;
    winObj = nil;
    titleObj = nil;
    txtTitle = nil;
    txtTitle1 = nil;
    txtName = nil;
    SliderExp = nil;
    expSlider = nil;
    Fill = nil;
    txtLv2 = nil;
    lifeBuffs = nil;
    goldAdd = nil;
    txtGoldBuff = nil;
    dropAdd = nil;
    txtDropBuff = nil;
    expAdd = nil;
    txtExpBuff = nil;
    jfObj = nil;
    txtJf1 = nil;
    txtJf2 = nil;
    hurtObj = nil;
    txtHurt1 = nil;
    txtHurt2 = nil;
    btnStatistics = nil;
    txtStatistics = nil;
    txtNone = nil;
    failObj = nil;
    txt_fail1 = nil;
    txtFail1 = nil;
    txt_fail2 = nil;
    txtFail2 = nil;
    txt_fail3 = nil;
    txtFail3 = nil;
    txt_fail4 = nil;
    txtFail4 = nil;
    bossFailObj = nil;
    SliderHP = nil;
    txtHP = nil;
    hpSlider = nil;
    Fill = nil;
    txtHPVal = nil;
    txtDamage = nil;
    txtDamageVal = nil;
    cardGrid = nil;
    txtClose = nil;
    lvFade = nil;
    AIMask = nil;
    view = nil;
end
----#End#----
