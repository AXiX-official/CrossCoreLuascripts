--[[1、遍历所有anim，赋值target，查找丢失的
2、按需求激活或者关闭对应的anim（开启记录需要保存到本地）
3、激活note和anim，在规定时间激活额外动画，动画完成
]] require "LoginCommFuns"
local menuRedPath = "Common/Red2"
local menuLockPath = "Menu/MenuLock"
local menuMessagePath = "Menu/MenuMessage"
local menuTeamItemPath = "Menu/MenuTeamItem"
local isShowLvBar = false -- 等级经验条动画
local ids = {ITEM_ID.DIAMOND, ITEM_ID.GOLD, 10035} -- 11003
local bossIsActive = false
local bossBtnNextRefreshTime = 0
local lockData = {} -- 记录锁定状态
local openViews = {} -- 当前打开的界面
local isOpenView = false
local needCheckBtns = nil -- 需要检测是否开启的按键
local btnsLockInfo = nil -- 按键加锁的信息
local topTimer = -1
local isAnim = false
local animTimer = 0
local uIGyro
local isClickAttack = false
local hotTimer = 0
local isRole = true
local isShow = false
local showTime = 0
local isIn = false -- l2d入场动画 
local isCheckExerciseL = false -- 已推送演习新是赛季提示 

local rRunTime
local rFastestData
local isReady = false

local isLoading_Complete = false
local menuBuyItem
-- local endAnim

-- 新春活动
local isSpring = false
local springCheckTime = nil
local isSpringStart = nil

local activityRefreshTime = nil
local enterRefreshTime = nil
local talkTxtIsShow = true -- 聊天文本框
local talkTxtIsShowSaveKey = "talkTxtIsShow"
local isTalk = false

-- 主界面
function Awake()
    cg_node = ComUtil.GetCom(node, "CanvasGroup")
    enterSV_sv = ComUtil.GetCom(enterSV, "ScrollRect")
    -- endAnim = ComUtil.GetCom(node, "ActionBase")

    -- init
    InitPanel()
    -- 监听
    InitListener()
    -- 为按钮添加方法
    AddBtnsFunc()
    -- 当前背景
    SetBG()

    -- 以下暂时不开放 rui/20220608
    CSAPI.SetGOActive(objChat, false)
    CSAPI.SetGOActive(btnBuff, false)

    -- 
    isRole = PlayerClient:KBIsRole()
    CSAPI.SetGOActive(cardIconItem.gameObject, isRole)
    CSAPI.SetGOActive(mulIconItem.gameObject, not isRole)
    -- CSAPI.SetGOActive(bg, isRole)
    CSAPI.SetGOActive(ui_structure, false)

    local value = PlayerPrefs.GetInt(talkTxtIsShowSaveKey)
    talkTxtIsShow = value == 0
end

function InitPanel()
    -- 等级bar
    lvFill = ComUtil.GetCom(fillLv, "Image")
    bar = Bar.New()
    bar:Init(fillLv, CfgPlrUpgrade, "nNextExp", SetLv, nil, 2, function()
        isShowLvBar = false
    end, true)

    -- 立绘
    cardIconItem = RoleTool.AddRole(iconParent, PlayCB, EndCB, true)
    -- 多人插图 
    mulIconItem = RoleTool.AddMulRole(iconParent, PlayCB, EndCB, true)

    fade_iconParent = ComUtil.GetCom(iconParent, "ActionFade")

    -- 台词相关
    voicePlaying = false -- 正在播放
    nextPlayTime = TimeUtil:GetTime() + 180 -- 自动播放台词间隔 180s	

    -- 陀螺仪
    uIGyro = ComUtil.GetCom(node, "UIGyro")

    -- 锁屏动画
    uiEffect = ComUtil.GetCom(node, "UIEffectControl")

    cg_node.alpha = 0
    CSAPI.SetGOActive(anims, false)
    CSAPI.SetGOActive(objMailRed, false)
    CSAPI.SetGOActive(objAttackRed, false)
    CSAPI.SetGOActive(objMessageBG, false)
    CSAPI.SetGOActive(talkBg, false)
    CSAPI.SetGOActive(btnBoss, false)
    CSAPI.SetGOActive(btnTeamBoss, false)
    CSAPI.SetGOActive(cGrab, false) -- 抖动
    CSAPI.SetGOActive(uiEffectObj, false)
end

function InitListener()
    eventMgr = ViewEvent.New()
    -- 界面打开关闭
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    -- 更换看板
    eventMgr:AddListener(EventType.Player_Select_Card, ChangeDisplay)
    eventMgr:AddListener(EventType.Player_Select_BG, SetBG)
    -- 续战提示
    eventMgr:AddListener(EventType.Fight_Restore, OnFightRestore)
    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
    -- 世界boss
    -- eventMgr:AddListener(EventType.WorldBoss_List, SetBoss)
    -- 玩家升级
    eventMgr:AddListener(EventType.Player_Update, function()
        SetLocks()
        UpdateLvBar()
        HotChange()
        CalHot()
    end)
    -- 背包
    eventMgr:AddListener(EventType.Bag_Update, RefreshMoney)
    -- loading 完成
    eventMgr:AddListener(EventType.Loading_Complete, L2dIn) -- 开始动画  OnLoadingComplete影响动画播放，放在动画之后执行
    -- 卡牌添加及删除
    eventMgr:AddListener(EventType.Role_Card_Add, SetRole)
    eventMgr:AddListener(EventType.Role_Card_Delete, SetRole)
    eventMgr:AddListener(EventType.Role_Card_GridAdd, SetRole)

    -- 任务更新	
    eventMgr:AddListener(EventType.Mission_List, function()
        SetMission()
        SetMissionBar()
    end)
    -- 好友
    eventMgr:AddListener(EventType.Friend_Op, SetFriend)
    eventMgr:AddListener(EventType.Friend_Update, SetFriend)
    eventMgr:AddListener(EventType.Friend_Add, SetFriend)
    -- 图鉴
    eventMgr:AddListener(EventType.CRole_Add, SetCRole)
    -- 强制弹出公告
    eventMgr:AddListener(EventType.Main_Activity, ShowActivity)
    -- 刷新当前关卡
    eventMgr:AddListener(EventType.Dungeon_PlotPlay_Over, RefreshLevel)
    -- 副本数据设置完
    eventMgr:AddListener(EventType.Dungeon_Data_Setted, RefreshLevel)
    -- 聊天
    -- eventMgr:AddListener(EventType.Chat_NewInfo_Menu, OnChatNewInfo)
    -- 编队更新
    eventMgr:AddListener(EventType.Team_Data_Setted, SetTeam)
    eventMgr:AddListener(EventType.CardCool_Update, SetTeam) -- 更新热值
    eventMgr:AddListener(EventType.Team_Data_Update, SetTeam) -- 队伍更新
    eventMgr:AddListener(EventType.Role_Cool, SetTeam) -- 卡牌冷却
    eventMgr:AddListener(EventType.Role_Cool_Finish, SetTeam) -- 冷却完成
    -- 体力变更
    eventMgr:AddListener(EventType.Player_HotChange, HotChange)
    -- 基地 
    eventMgr:AddListener(EventType.Matrix_Building_UpdateEnd, InitResetTime)
    -- 3点刷新 签到检查
    eventMgr:AddListener(EventType.Update_Everyday, function()
        if (CheckIsTop()) then
            CheckPopUpWindow()
        end
    end)
    -- 商店购买回调
    eventMgr:AddListener(EventType.Shop_Buy_Ret, SetMenuBuy)
    -- 检测活动列表是否为空
    eventMgr:AddListener(EventType.Activity_List_Null_Check, SetActivityBtn)
    -- 重置金额刷新
    eventMgr:AddListener(EventType.Pay_Amount_Change, SetMenuBuy)
    -- 回归判断(3点会更新)
    eventMgr:AddListener(EventType.HuiGui_Check, SetResRecoveryBtn)
    -- 资源找回 
    eventMgr:AddListener(EventType.HuiGui_Res_Recovery, SetResRecoveryBtn)
end

function OnDestroy()
    eventMgr:ClearListener()
    RoleAudioPlayMgr:StopSound()
    ReleaseCSComRefs()
end

-- 按钮添加点击方法
function AddBtnsFunc()
    if (needCheckBtns ~= nil) then
        return
    end
    -- 设置上锁的位置
    if (needCheckBtns == nil) then
        needCheckBtns = {"PlayerView", "ActivityListView", "FriendView", "ArchiveView", "TeamView", "RoleListNormal",
                         "MissionView", "ShopView", "CreateView", "Matrix", "Bag", "MailView", "Dorm", "PlayerAbility",
                         "ExerciseLView", "ExplorationMain", "CourseView", "Achievement"} -- "GuildMenu",
        btnsLockInfo = {}
        for i, v in pairs(needCheckBtns) do
            if (v == "PlayerAbility") then
                btnsLockInfo[v] = {30.7, 63}
            elseif (v == "MissionView") then
                btnsLockInfo[v] = {220, 25}
            elseif (v == "ShopView") then
                btnsLockInfo[v] = {-19, 35}
            elseif (v == "CreateView") then
                btnsLockInfo[v] = {73, 35}
            elseif (v == "RoleListNormal" or v == "TeamView") then
                btnsLockInfo[v] = {30, 35}
            elseif (v == "ActivityListView" or v == "MailView" or v == "ExplorationMain") then
                btnsLockInfo[v] = {22.5, 21}
            elseif (v == "FriendView" or v == "ArchiveView" or v == "CourseView" or v == "Matrix" or v == "Bag" or v ==
                "Dorm" or "Achievement") then -- or v =="GuildMenu") then -- 公会默认不开放 rui/20220608
                btnsLockInfo[v] = {51, 19}
            end
        end
    end
    for i = 1, #needCheckBtns do
        local key = needCheckBtns[i]
        if (key == "Matrix") then
            -- 基地的打开方式（要加载场景）
            this["OnClick" .. key] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    MatrixMgr:SetEnterAnim(true)
                    SceneLoader:Load("Matrix")
                end
            end
        elseif (key == "Dorm") then -- 和基地一致
            this["OnClick" .. key] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Dorm")
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    CSAPI.OpenView("DormRoom")
                end
            end
        elseif (key == "MissionView") then
            this["OnClick" .. key] = function()
                local openSetting = nil
                if (GuideMgr:IsGuiding()) then
                    openSetting = eTaskType.Daily
                end
                CSAPI.OpenView(key, nil, openSetting)
            end
        elseif (key == "ExplorationMain") then
            this["OnClick" .. key] = function()
                if (ExplorationMgr:CanOpenExploration()) then
                    CSAPI.OpenView("ExplorationMain")
                else
                    Tips.ShowTips(LanguageMgr:GetTips(22003));
                end
            end
        else
            -- 通用的打开方式
            this["OnClick" .. key] = function()
                CSAPI.OpenView(key)
            end
        end
    end
end

-- ==============================------------------------------------------OnOpen-----------------------------------------------
-- desc:
-- time:2021-11-01 11:23:07
-- @return 
-- ==============================--
function OnOpen()
    -- ResUtil:CreateUIGOAsync("Test/Test", gameObject)    
    InitResetTime()

    -- 解决宿舍模型残留问题
    DormMgr:ClearDormModels()

    --
    activityRefreshTime = TimeUtil:GetRefreshTime("CfgActiveList", "sTime", "eTime")
    enterRefreshTime = TimeUtil:GetRefreshTime("CfgActiveEntry", "begTime", "endTime")
end

-- 设置看板回调
function ChangeDisplay()
    -- LogError(1)
    isChangeDisplay = true
end
function SetDisplay()
    if (isChangeDisplay) then
        SetImg(ToPlayIn)
        -- LogError(tostring(isIn))
        -- if (isIn) then
        --     OnClickHide() -- 隐藏UI元素 
        --     if (isRole) then
        --         cardIconItem.PlayIn(OnClickBack, iconParent)
        --     else
        --         mulIconItem.PlayIn(OnClickBack, iconParent)
        --     end
        -- end
    end
    isChangeDisplay = false
end

function ToPlayIn()
    OnClickHide() -- 隐藏UI元素 
    if (isRole) then
        cardIconItem.PlayIn(OnClickBack, iconParent)
    else
        mulIconItem.PlayIn(OnClickBack, iconParent)
    end
end

-- 场景加载完成，l2d进场动画
function L2dIn()
    ActivityMgr:InitListOpenState() -- 检测滚动窗口

    inFirstLoadCB = true -- 允许进入l2d加载后的回调(在手机端l2d的加载比较慢，需要异步处理)

    MenuMgr:InitDatas() -- 更新一下系统开启信息
    InitLockDatas()
    InitAnims()
    RefreshUI()

    isLoading_Complete = true
end
function FirstLoadCB()
    if (not inFirstLoadCB) then
        return
    end
    inFirstLoadCB = false

    if (MenuMgr:IsFirst() and isIn) then
        CSAPI.SetScale(uis, 0, 0, 0)
        if (isRole) then
            cardIconItem.PlayIn(SetTweened, iconParent)
        else
            mulIconItem.PlayIn(SetTweened, iconParent)
        end
    else
        SetTweened()
    end
end

-- 动画 全部执行，用延迟隔开
function SetTweened()
    isReady = true
    isIn = false

    CSAPI.SetGOActive(mask, true)
    cg_node.alpha = 1
    CSAPI.SetScale(uis, 1, 1, 1)
    CSAPI.SetGOActive(anims, true)
    -- if (endAnim) then
    --     endAnim:ToPlay(function()
    --         if (anims) then
    --             CSAPI.SetGOActive(anims, false)
    --         end
    --     end)
    -- end

    if (isRole) then
        cardIconItem.PlayLC() -- 立绘拉扯
    end

    animTimer = Time.time
    isAnim = true
    -- 音效
    CSAPI.PlayUISound("ui_window_open_load")

    -- 当次登录
    if (not MenuMgr:GetIsPlay()) then
        -- 碎屏效果
        CSAPI.SetGOActive(uiEffectObj, true)
        uiEffect:SetFloatValue(effectGrid, "_Progress02", 1, 0, 1, 1, 0)
        uiEffect:SetFloatValue(effectGridFlash, "_Progress01", 1, 0, 1, 0, 0)

        -- 屏幕适配收缩动画
        CSAPI.PlayShrinkAction(function()
            StopAnim()
            CSAPI.SetGOActive(uiEffectObj, false)
        end)
    end
end

function InitLockDatas()
    for i, v in ipairs(needCheckBtns) do
        local key = needCheckBtns[i]
        local isOpen = MenuMgr:CheckModelOpen(OpenViewType.main, v)
        lockData[v] = isOpen
    end
end

-- 按钮状态lock
function SetLocks()
    for i, v in ipairs(needCheckBtns) do
        SetLock(v)
    end
end

function SetLock(key)
    local btn = "btn" .. key
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.main, key)
    local lockInfo = btnsLockInfo[key]
    if (key ~= "PlayerView" and lockInfo) then
        -- 加减锁
        UIUtil:SetRedPoint2(menuLockPath, this[btn], not isOpen, lockInfo[1], lockInfo[2], 1, lockInfo[3])
    end
    lockData[key] = isOpen -- 刷新数据
end

function SetBtnAlpha(key, alpha)
    local btn = "btn" .. key
    if (key ~= "PlayerView" and this[btn]) then
        local canvasGroup = ComUtil.GetOrAddCom(this[btn], "CanvasGroup")
        canvasGroup.alpha = alpha
    end
end

-- 激活或者关闭动画
function InitAnims()
    local tweens = ComUtil.GetComsInChildren(anims, "ActionBase")
    local len = tweens.Length - 1
    for i = 0, len do
        local tween = tweens[i]
        local name = string.sub(tween.name, 1, -2)
        if (this[name]) then
            -- 赋值对象
            tween.target = this[name]
            -- 时间
            tween.ignoreTimeScale = true

            -- 是否需要锁的按钮
            local lockKey = StringUtil:StrReplace(name, "btn", "", 1)
            if (lockData[lockKey] ~= nil) then
                local isActive = false
                local key = string.sub(tween.name, -1, -1)
                if (key == "1") then
                    isActive = lockData[lockKey]
                else
                    isActive = not lockData[lockKey]
                end
                CSAPI.SetGOActive(tween.gameObject, isActive)
            end

            if (name == "txtMoney1" or name == "txtMoney2") then
                -- 赋值金钱
                local key = string.sub(tween.name, -2, -2)
                local num = BagMgr:GetCount(ids[tonumber(key)])
                -- if (num >= 100000) then
                --     CSAPI.SetGOActive(tween.gameObject, false)
                --     CSAPI.SetText(this[name], math.floor(num / 1000) .. "K")
                -- else
                -- CSAPI.SetGOActive(tween.gameObject, true)
                -- tween.targetNum = num   
                -- tween:Play()
                CSAPI.SetGOActive(tween.gameObject, false)
                CSAPI.SetText(this[name], math.floor(num) .. "")
                -- end
            end
            -- 名字
            if (name == "txtName") then
                local str = PlayerClient:GetName()
                tween:SetStr(str, CS.TextTweenType.Addtive, nil)
            end
        else
            LogError("不存在动画物体：" .. name)
        end
    end
end

function RefreshUI()
    -- top
    SetTop()
    -- left
    SetLeft()
    -- right
    SetRight()
    -- bottom
    SetBottom()
    -- cnetre
    SetCenter()
end

-- 加载完
function OnLoadingComplete()
    -- MenuMgr:UpdateDatas() -- 更新数据
    local isGuide = GuideMgr:HasGuide("Menu") or GuideMgr:IsGuiding();
    if (not isGuide) then
        PlayerClient:ApplyChangeLine(); -- 切线
    end

    loadingComplete = 1;
    if (not CheckIsTop()) then
        return
    end

    -- 功能解锁
    if (CheckModelOpen()) then
        return
    end

    FightProto:ShowRestoreFightDialog(not isGuide);
    if (isGuide) then
        TriggerGuide();
    else
        EActivityGetCB();
    end

    ShowHint(true);
    EventMgr.Dispatch(EventType.Main_Enter);
    -- 检测邀请
    MenuMgr:CheckInviteTips()
end

local curTime = 0
function Update()
    if (not isLoading_Complete) then
        return
    end

    curTime = TimeUtil:GetTime()

    -- 经验条
    if (isShowLvBar and bar ~= nil) then
        bar:Update()
    end

    -- 自动播放台词
    if (isRole and not voicePlaying and cardIconItem and curTime > nextPlayTime) then
        nextPlayTime = curTime + 180
        if (CheckIsTop()) then
            cardIconItem.PlayVoice()
        else
            EndCB() -- 进入下一个循环
        end
    end
    --[[
    -- 功能开启
    if (isOpenView) then
        ModelOpen()
    end
--]]
    -- top时间
    if (topTimer > 0 and Time.time > topTimer) then
        SetTopTime()
    end

    if (isAnim) then
        Anim()
    end

    -- 电量
    if (isStartCalEQ) then
        CalEQ()
    end

    -- 体能回复
    if (hotTimer and curTime > hotTimer) then
        CalHot()
        EventMgr.Dispatch(EventType.Player_HotChange)
    end

    -- 展示界面 
    if (isShow) then
        if (CS.UnityEngine.Input.GetMouseButton(0)) then
            showTime = Time.time + 1.5
            CSAPI.SetGOActive(btn_exit, true)
        end
        if (showTime and Time.time > showTime) then
            showTime = nil
            CSAPI.SetGOActive(btn_exit, false)
        end
    end

    -- 基地
    MatrixUpdate()

    -- 演习 
    if (lockData["ExerciseLView"]) then -- ExerciseMgr:IsOpen()
        -- 演习新赛季 new 
        if (not isCheckExerciseL and curTime > ExerciseMgr:GetStartTime()) then
            isCheckExerciseL = true
            ExerciseMgr:CheckNewSeason()
        end
        -- 参加次数重置 
        ExerciseMgr:CheckNewJoinCnt()
    end
    if (isSpring ~= nil and springCheckTime ~= nil and curTime > springCheckTime) then
        springCheckTime = nil
        -- 活动开始，强制弹出一次
        if (isSpringStart) then
            MenuMgr.isCheckSpringGift = nil
            if (CheckIsTop()) then
                CheckPopUpWindow()
            end
        end
        SetMenuBuy()
    end

    -- 到点活动更新
    if (activityRefreshTime and curTime > activityRefreshTime) then
        activityRefreshTime = TimeUtil:GetRefreshTime("CfgActiveList", "sTime", "eTime")
        ActivityMgr:RefreshOpenState()
        EventMgr.Dispatch(EventType.Update_Everyday) -- 到点刷新活动
    end

    -- 到点活动更新
    if (enterRefreshTime and curTime > enterRefreshTime) then
        enterRefreshTime = TimeUtil:GetRefreshTime("CfgActiveEntry", "begTime", "endTime")
        SetEnter()
    end

    -- -- 强制隐藏mask，防止锁屏
    -- if (mask.activeSelf and animTimer ~= nil and (Time.time - animTimer) > 20) then
    --     CSAPI.SetGOActive(mask, false)
    -- end

    -- 头像框 
    if (HeadFrameMgr:GetMinExpiry()) then
        if (curTime > HeadFrameMgr:GetMinExpiry()) then
            HeadFrameMgr:RefreshDatas()
        end
    end
    -- 头像
    if (HeadIconMgr:GetMinExpiry()) then
        if (curTime > HeadIconMgr:GetMinExpiry()) then
            HeadIconMgr:RefreshDatas()
        end
    end
end
----------------------------------------动画+红点-----------------------------------------------】
-- 处理动画在某个关键帧上的事件
function Anim()
    -- tip 图标拉扯
    -- if ((Time.time - animTimer) > 0.25 and isPlayTopGrad == nil) then
    --     isPlayTopGrad = 1
    --     CSAPI.SetGOActive(cGrab, true)
    -- end
    -- if ((Time.time - animTimer) > 1 and isPlayTopGrad == 1) then
    --     isPlayTopGrad = 2
    --     CSAPI.SetGOActive(cGrab, false)
    -- end
    -- 红点、上锁
    if ((Time.time - animTimer) > 1.05 and isRedPoint == nil) then
        isRedPoint = 1
        OnRedPointRefresh()
        --
        SetLocks()
    end
    -- 播放设置看板的声音
    if ((Time.time - animTimer) > 1.11 and isPlayVoiceFirst == nil) then
        isPlayVoiceFirst = 1
        local isPlay = PlayLoginVoice()
        if (not isPlay) then
            isChangeImgPlayVoice = true -- 如果未播放，则设置为关闭所有界面时再检测一次
        end
    end
    -- 任务bar
    if ((Time.time - animTimer) > 1.07 and isShowMissionBar == nil) then
        isShowMissionBar = 1
        SetMissionBar()
    end
    -- 构建bar
    if ((Time.time - animTimer) > 1.37 and isShowCreateBar == nil) then
        isShowCreateBar = 1
        SetCreateBar()
    end
    -- 完成
    if ((Time.time - animTimer) > 2 and MenuMgr:GetIsPlay()) then
        StopAnim()
    end
end

function StopAnim()
    MenuMgr:SetPlay(1)
    -- CSAPI.SetGOActive(anims, false)
    -- CSAPI.SetGOActive(mask, false) --改动所有活动都关了才隐藏
    cg_node.alpha = 1
    CSAPI.SetGOActive(ui_structure, true)
    OnLoadingComplete()

    uIGyro:Play()

    -- 强制设置为1 20220602立绘消失的问题
    if (iconParent) then
        local cg = ComUtil.GetOrAddCom(iconParent, "CanvasGroup")
        cg.alpha = 1
    end
    isAnim = false
end

-- 任务的bar
function SetMissionBar()
    local fill_mission = ComUtil.GetCom(fillMission, "BarBase")
    local target = fillMissionValue or 0
    fill_mission:SetProgress(target)
end

-- 建造的bar
function SetCreateBar()
    local isOpen = lockData["CreateView"]
    local fill_create = ComUtil.GetCom(fillCreate, "BarBase")
    fill_create:SetProgress(0.86, not isOpen)
end

-- 刷新红点
function OnRedPointRefresh()
    if (not isReady) then
        return
    end
    -- 邮件
    local _data = RedPointMgr:GetData(RedPointType.Mail)
    CSAPI.SetGOActive(objMailRed, _data ~= nil and lockData["MailView"])
    if (_data) then
        CSAPI.SetText(txtMailCount, _data .. "")
    end

    local isOpen = false
    -- 演习 new 
    local isNew = false
    -- 因服务器压力，屏蔽
    -- isOpen = lockData["ExerciseLView"] -- ExerciseMgr:IsOpen()
    -- if (isOpen) then
    --     local _data = RedPointMgr:GetData(RedPointType.ExerciseL)
    --     isNew = _data ~= nil
    --     UIUtil:SetNewPoint(btnAttack, isNew, 93.5, 166, 0)
    --     UIUtil:SetRedPoint2(menuRedPath, btnAttack, false, 93.6, 166, 0)
    -- end

    -- 章节 new
    if (not isNew) then
        isNew = SectionNewUtil:IsSectionNew()
        UIUtil:SetNewPoint(btnAttack, isNew, 93.5, 166, 0)
        UIUtil:SetRedPoint2(menuRedPath, btnAttack, false, 93.6, 166, 0)
    end

    -- 出击(战斗必定继续，不用再显示)  --演习有new时不显示红点 
    -- SetAttackRed()
    if (not isNew) then
        local _data = RedPointMgr:GetData(RedPointType.Attack)
        UIUtil:SetNewPoint(btnAttack, false, 93.5, 166, 0)
        UIUtil:SetRedPoint2(menuRedPath, btnAttack, _data ~= nil, 93.6, 166, 0)
    end

    isOpen = lockData["MissionView"]
    if (isOpen) then
        local _data = RedPointMgr:GetData(RedPointType.Mission)
        local b = false
        if (_data and _data[1] == 1) then
            b = true
        end
        UIUtil:SetRedPoint2(menuRedPath, this["btnMissionView"], b, 220, 27, 0)
    end

    -- 角色
    isOpen = lockData["RoleListNormal"]
    if (isOpen) then
        local _data = RedPointMgr:GetData(RedPointType.RoleList)
        UIUtil:SetRedPoint2(menuRedPath, this["btnRoleListNormal"], _data ~= nil, -13, 78, 0)
        -- -- 技能完成弹窗
        -- if (not isAnim and CheckIsTop()) then
        --     CheckPopUpWindow()
        -- end
    end

    -- 好友
    isOpen = lockData["FriendView"]
    if (isOpen) then
        local _data = RedPointMgr:GetData(RedPointType.Friend)
        local lockInfo = btnsLockInfo["FriendView"]
        UIUtil:SetRedPoint2(menuRedPath, this["btnFriendView"], _data ~= nil, lockInfo[1], lockInfo[2], lockInfo[3])
    end

    -- 玩家能力
    isOpen = lockData["PlayerAbility"]
    if (isOpen) then
        local _pData = RedPointMgr:GetData(RedPointType.PlayerAbility)
        UIUtil:SetRedPoint2(menuRedPath, btnPlayerAbility, _pData ~= nil, 32, 55, 0)
    end

    -- 活动（签到...）
    isOpen = lockData["ActivityListView"]
    if (isOpen) then
        local _aData = RedPointMgr:GetData(RedPointType.ActivityList1)
        local isRed = false
        if _aData and #_aData > 0 then
            for k, v in ipairs(_aData) do
                if v.b == 1 then
                    isRed = true
                    break
                end
            end
        end
        UIUtil:SetRedPoint2(menuRedPath, btnActivityListView, isRed, 22, 22, 0)
    end

    -- 活动（阶段...）
    isOpen = true
    if (isOpen) then
        local _aData = RedPointMgr:GetData(RedPointType.ActivityList2)
        local isRed = false
        if _aData and #_aData > 0 then
            for k, v in ipairs(_aData) do
                if v.b == 1 then
                    isRed = true
                    break
                end
            end
        end
        UIUtil:SetRedPoint2(menuRedPath, btnPay, isRed, 122, 39, 0)
    end

    -- 活动（特别...）
    -- isOpen = true
    -- if (isOpen) then
    --     local _aData = RedPointMgr:GetData(RedPointType.ActivityList3)
    --     local isRed = false
    --     if _aData and #_aData > 0 then
    --         for k, v in ipairs(_aData) do
    --             if v.b == 1 then
    --                 isRed = true
    --                 break
    --             end
    --         end
    --     end
    --     UIUtil:SetRedPoint2(menuRedPath, btnSpecialGifts, isRed, 122, 39, 0)
    -- end

    -- 商店
    isOpen = lockData["ShopView"]
    if (isOpen) then
        local _pData = RedPointMgr:GetData(RedPointType.Shop)
        UIUtil:SetRedPoint2(menuRedPath, btnShopView, _pData ~= nil, 13, 46, 0)
    end

    -- 勘察 
    isOpen = lockData["ExplorationMain"]
    if (isOpen) then
        local explorationData = RedPointMgr:GetData(RedPointType.Exploration)
        UIUtil:SetRedPoint2(menuRedPath, btnExplorationMain, explorationData ~= nil, 22, 22, 0)
    end

    -- 教程
    -- isOpen = lockData["CourseView"]
    -- if (isOpen) then
    --     local explorationData = RedPointMgr:GetData(RedPointType.CourseView)
    --     UIUtil:SetRedPoint2(menuRedPath, btnCourseView, explorationData ~= nil, 22, 22, 0)
    -- end

    -- 基地
    isOpen = lockData["Matrix"]
    if (isOpen) then
        local _pData = RedPointMgr:GetData(RedPointType.Matrix)
        UIUtil:SetRedPoint2(menuRedPath, btnMatrix, _pData ~= nil, 51, 19, 0)
    end

    -- 背包
    isOpen = lockData["Bag"]
    if (isOpen) then
        local _pData = RedPointMgr:GetData(RedPointType.Bag)
        UIUtil:SetRedPoint2(menuRedPath, btnBag, _pData ~= nil, 51, 19, 0)
    end

    -- 构建
    isOpen = lockData["CreateView"]
    if (isOpen) then
        local _pData = RedPointMgr:GetData(RedPointType.Create)
        local go = UIUtil:SetRedPoint2(menuRedPath, btnCreateView, _pData ~= nil, 80, 46, 0)
        -- if (go) then
        --     local canvas = ComUtil.GetOrAddCom(go, "Canvas")
        --     canvas.overrideSorting = true;
        --     canvas.sortingOrder = 2
        -- end
    end

    -- 成就 todo 
    isOpen = lockData["Achievement"]
    if (isOpen) then
        local _pData = RedPointMgr:GetData(RedPointType.Achievement)
        UIUtil:SetRedPoint2(menuRedPath, btnAchievement, _pData ~= nil, 51, 19, 0)
    end

    -- 角色详情 头像框 徽章
    if (true) then
        local _pData = RedPointMgr:GetData(RedPointType.HeadFrame)
        local _pData2 = RedPointMgr:GetData(RedPointType.Head)
        local _pData3 = RedPointMgr:GetData(RedPointType.Badge)
        local _isRed = false
        if (_pData ~= nil or _pData2 ~= nil or _pData3 ~= nil) then
            _isRed = true
        end
        UIUtil:SetRedPoint2(menuRedPath, btnPlayerView, _isRed, 169.4, -6.1, 0)
    end
    -- -- 新皮肤（看板）
    -- local _data = RedPointMgr:GetData(RedPointType.CRoleSkin)
    -- UIUtil:SetNewPoint(btnShow, _data ~= nil, 35, 25, 0)

    -- 活动入口 
    SetEnter()
end

-- function SetAttackRed()
--     local id = DungeonMgr:GetCurrFightId()
--     if (id) then
--         local cfg = Cfgs.MainLine:GetByID(id)
--         if (cfg) then
--             CSAPI.SetGOActive(objAttackRed, true)
--         end
--     else
--         CSAPI.SetGOActive(objAttackRed, false)
--     end
-- end

----------------------------------------common-----------------------------------------------

-- 语音开始播放
function PlayCB(curCfg)
    if (not IsNil(gameObject) and not IsNil(talkBg)) then
        voicePlaying = true
        local script = SettingMgr:GetSoundScript(curCfg) or ""
        CSAPI.SetText(txtTalk, script)
        SetTalkName(curCfg)
        -- CSAPI.SetGOActive(talkBg, true)
        isTalk = true
        SetTalkBg()
    end
end

function SetTalkName(curCfg)
    if (isRole) then
        return
    end
    local str = ""
    if (curCfg.model) then
        local cfg = Cfgs.character:GetByID(curCfg.model)
        if (cfg) then
            local croleCfg = Cfgs.CfgCardRole:GetByID(cfg.role_id)
            CSAPI.SetText(txtTalkName, croleCfg and croleCfg.sAliasName or "")
        end
    end
end

-- 语音播放后
function EndCB()
    if (not IsNil(gameObject) and not IsNil(talkBg)) then
        voicePlaying = false
        -- CSAPI.SetGOActive(talkBg, false)
        nextPlayTime = TimeUtil:GetTime() + 180
        isTalk = false
        SetTalkBg()
    end
end

----------------------------------------top-----------------------------------------------
function SetTop()
    SetMoneys()
    InitTopTime()
    SetPower()
end

-- 金钱
function SetMoneys()
    -- icon
    for i, v in ipairs(ids) do
        local cfg = Cfgs.ItemInfo:GetByID(v)
        ResUtil.IconGoods:Load(this["moneyIcon" .. i], cfg.icon .. "_1")
    end

    -- 金币最大
    -- local num = PlayerClient:GetGoldMax()
    -- if (num >= 100000) then
    --     CSAPI.SetText(txtMax, "MAX:" .. math.floor(num / 1000) .. "K")
    -- else
    --     CSAPI.SetText(txtMax, "MAX:" .. num)
    -- end

    -- 体力
    HotChange()
end

-- 金钱更新
function RefreshMoney()
    for i, v in ipairs(ids) do
        if (v ~= 10035) then
            local num = BagMgr:GetCount(v)
            -- if (num >= 100000) then
            --     CSAPI.SetText(this["txtMoney" .. i], math.floor(num / 1000) .. "K")
            -- else
            CSAPI.SetText(this["txtMoney" .. i], num .. "")
            -- end
        end
    end
    -- 金币最大
    -- CSAPI.SetText(txtMax, "MAX:" .. PlayerClient:GetGoldMax())
end

-- 体力变化
function HotChange()
    local cur = PlayerClient:Hot()
    local max1, max2 = PlayerClient:MaxHot()
    CSAPI.SetText(txtMoney3, cur .. "/" .. max1)
end

function InitTopTime()
    -- local timeStr, s = TimeUtil:GetTimeStr5(TimeUtil:GetTime())
    local timeStr, s = TimeUtil:GetTimeStr5(TimeUtil:GetBJTime())
    CSAPI.SetText(txtDay, timeStr)
    topTimer = Time.time + (60 - s)
end

function SetTopTime()
    -- local timeStr, s = TimeUtil:GetTimeStr5(TimeUtil:GetTime())
    local timeStr, s = TimeUtil:GetTimeStr5(TimeUtil:GetBJTime())
    CSAPI.SetText(txtDay, timeStr)
    topTimer = Time.time + 60
end

-- 电量 todo
function SetPower()
    calEQTimer = Time.time
    isStartCalEQ = true
end
function CalEQ()
    if (Time.time > calEQTimer) then
        calEQTimer = Time.time + 60
        local cur = CSAPI.GetElectricQuantity()
        cur = cur and math.ceil(math.abs(cur) * 100) or 100
        CSAPI.SetText(txtPower, cur .. "%")
        if (fill_power == nil) then
            fill_power = ComUtil.GetCom(fillPower, "Image")
        end
        fill_power.fillAmount = cur / 100
    end
end

function CalHot()
    local time = PlayerClient:THot()
    hotTimer = nil
    if (time ~= 0) then
        hotTimer = time
    end
end

function OnClickMoney1()
    OnClickMoney(1)
end
function OnClickMoney2()
    OnClickMoney(2)
end
function OnClickMoney3()
    OnClickMoney(3)
end
function OnClickMoney(index)
    if (index <= #ids) then
        -- if (ids[index] == 10035) then
        --     -- JumpMgr:Jump(140002)
        --     CSAPI.OpenView("HotPanel")
        -- elseif (ids[index] == ITEM_ID.DIAMOND) then
        --     JumpMgr:Jump(140001)
        -- elseif (ids[index] == ITEM_ID.GOLD) then
        --     JumpMgr:Jump(140014)
        -- end
        local cfg = Cfgs.ItemInfo:GetByID(ids[index])
        if (cfg and cfg.j_moneyGet) then
            JumpMgr:Jump(cfg.j_moneyGet)
        end
    end
end
-- 设置
function OnClickSet()
    CSAPI.OpenView("SettingView")
end
-- 公告
function OnClickNotice()
    CSAPI.OpenView("ActivityView")
end

-- -- 勘察
-- function OnClickExploration()
--     -- CSAPI.OpenView("BuffInfoView")
--     CSAPI.OpenView("ExplorationMain")
-- end

----------------------------------------bottom-----------------------------------------------
function SetBottom()
    SetFriend()
    SetCRole()
end

function SetFriend()
    local isOpen = lockData["FriendView"]
    if (isOpen) then
        local cur = FriendMgr:GetFriendCount()
        local max = FriendMgr:GetMaxCount()
        CSAPI.SetText(txtFriendCount1, cur .. "")
        CSAPI.SetText(txtFriendCount2, "/" .. max)
    else
        CSAPI.SetText(txtFriendCount1, "0")
        CSAPI.SetText(txtFriendCount2, "/0")
    end
end

function SetCRole()
    local isOpen = lockData["ArchiveView"]
    if (isOpen) then
        local cur, max = CRoleMgr:GetCount()
        CSAPI.SetText(txtArchiveCount1, cur .. "")
        CSAPI.SetText(txtArchiveCount2, "/" .. max)
    else
        CSAPI.SetText(txtArchiveCount1, "0")
        CSAPI.SetText(txtArchiveCount2, "/0")
    end
end

----------------------------------------left-----------------------------------------------
function SetLeft()
    UpdateLvBar()
    -- SetName()
    SetAD()

    SetUID()

    SetMenuBuy()

    SetActivityBtn()

    SetResRecoveryBtn()

    -- SetSpecialGiftsBtn()
end

-- 等级经验条
function UpdateLvBar()
    local curLv = PlayerClient:GetLv()
    if (PlayerClient:GetAddExp() > 0 and curLv > PlayerClient.oldLv) then
        -- if (CSAPI.IsViewOpen("PlayerUpgrade")) then
        --     local go = CSAPI.GetView("PlayerUpgrade")
        --     local lua = ComUtil.GetLuaTable(go)
        --     lua.SetLeft()
        -- else
        CSAPI.OpenView("PlayerUpgrade") -- , nil, nil, nil, true)
        -- end
    end
    if (PlayerClient:GetAddExp() == 0) then
        bar:Stop()
        -- lv
        SetLv(curLv)
        -- bar
        if (curLv >= #CfgPlrUpgrade) then
            lvFill.fillAmount = 1
        else
            local cur = PlayerClient:GetExp()
            local curMax = CfgPlrUpgrade[curLv].nNextExp
            lvFill.fillAmount = cur / curMax
        end
    else
        local add_exp = PlayerClient:GetAddExp()
        PlayerClient:GetAddExp(0) -- 归0
        bar:Show(PlayerClient.oldLv, PlayerClient.oldExp, add_exp)
        isShowLvBar = true
    end
end
-- 设置等级
function SetLv(_lv)
    _lv = _lv or 1
    CSAPI.SetText(txtLv, string.format("%d", _lv))
end

function SetUID()
    CSAPI.SetText(txtUID, PlayerClient:GetUid() .. "")
end

-- --名称
-- function SetName()
-- 	CSAPI.SetText(txtName, PlayerClient:GetName())
-- 	local str = PlayerClient:GetName()
-- 	local com = ComUtil.GetCom(txtName, "ActionTextRand")
-- 	--com:PlayByStr(str, CS.TextTweenType.Full, 1, nil, 200)
-- 	com:SetStr(str, CS.TextTweenType.Addtive, nil)
-- end
-- ad
function SetAD()
    if (isSetAD == nil) then
        isSetAD = 1
        ResUtil:CreateUIGO("Menu/MenuAD", objAD.transform)
    end
end

-- chat
function OnClickChat()
    if (menuMessage == nil) then
        menuMessage = ResUtil:CreateUIGO(menuMessagePath, objChat.transform)
    end
    CSAPI.SetGOActive(objMessageBG, false)
    CSAPI.SetGOActive(menuMessage.gameObject, false)
    CSAPI.OpenView("Chat", {
        type = ChatType.World
    })
    openViews["Chat"] = 1
end

function OnChatNewInfo(_data)
    if (menuMessage == nil) then
        menuMessage = ResUtil:CreateUIGO(menuMessagePath, objChat.transform)
    end
    if not openViews["Chat"] then
        CSAPI.SetGOActive(objMessageBG, true)
        CSAPI.SetGOActive(menuMessage.gameObject, true)
        local lua = ComUtil.GetLuaTable(menuMessage)
        lua.AddMessage(_data)
    else
        CSAPI.SetGOActive(objMessageBG, false)
        CSAPI.SetGOActive(menuMessage.gameObject, false)
    end
end

-- 维纳测度
function SetActivityBtn()
    CSAPI.SetGOActive(btnPay, not ActivityMgr:IsActivityListNull("ExtraActivityView", 2))
end

-- 资源找回
function SetResRecoveryBtn()
    -- local isShow = false
    -- if (RegressionMgr:CheckHadActivity(RegressionActiveType.ResourcesRecovery) and
    --     not RegressionMgr:CheckResRecoveryIsGain()) then
    --     isShow = true
    -- end
    -- CSAPI.SetGOActive(btnResRecovery, isShow)
    -- if (isShow) then
    --     local isRed = not RegressionMgr:CheckResRecoveryIsGain()
    --     UIUtil:SetRedPoint(btnResRecovery, isRed, 123, 31, 0)
    -- end
end

-- 特别馈赠
function SetSpecialGiftsBtn()
    -- local isShow = not ActivityMgr:IsActivityListNull("SpecialActivityView", 3)
    -- CSAPI.SetGOActive(btnSpecialGifts, true)
end

----------------------------------------right-----------------------------------------------
function SetRight()
    SetCurLevel()
    -- SetBoss()
    -- SetTeamBoss()
    SetRole()
    SetTeam()
    SetMission()
    SetShop()
    SetEnter()
end

-- 活动入口
function SetEnter()
    local datas = {}
    local curTime = TimeUtil:GetTime()
    local cfgs = Cfgs.CfgActiveEntry:GetAll()
    for k, v in ipairs(cfgs) do
        local begTime = TimeUtil:GetTimeStampBySplit(v.begTime) -- GCalHelp:GetTimeStampBySplit(v.begTime)
        local endTime = TimeUtil:GetTimeStampBySplit(v.endTime) -- GCalHelp:GetTimeStampBySplit(v.endTime)
        if (v.mainShow == 1 and curTime >= begTime and curTime < endTime) then
            table.insert(datas, v)
        end
    end
    if (#datas > 1) then
        table.sort(datas, function(a, b)
            return a.sort < b.sort
        end)
    end
    -- local openInfos = DungeonMgr:GetActiveOpenInfos()
    -- for k, v in pairs(openInfos) do
    --     if v:IsOpen() and v:GetOpenCfg().mainShow == 1 then
    --         table.insert(datas, v:GetOpenCfg())
    --     end
    -- end

    CSAPI.SetGOActive(activeityEnter, #datas > 0)
    CSAPI.SetGOActive(enterSV, #datas > 0)
    if (#datas > 0) then
        enterItems = enterItems or {}
        ItemUtil.AddItems("Menu/MenuEnter", enterItems, datas, enterContent)

        -- sv 大小 
        local num = #datas > 3 and 3 or #datas
        local height = num * 221 - 17
        CSAPI.SetRTSize(enterSV, 200, height)
    end
end

-- 更新关卡相关
function RefreshLevel()
    SetCurLevel()
    SetEnter()
end

-- 当前关卡
function SetCurLevel()
    local sectionData = DungeonMgr:GetLastMainLineSection(); -- 获取当前进行的主线章节
    if (sectionData) then
        local data = sectionData:GetLastOpenDungeon() -- 获取进行的副本配置表
        local per = sectionData:GetCompletePercent() -- 获取当前章节完成度的百分比 0-100
        CSAPI.SetText(txtAttackCur, data and data.chapterID or "0-1")
        CSAPI.SetText(txtAttackPercent, per ~= nil and per .. "" or "0")
    end
end

-- --boss
-- function SetBoss()
-- 	local _curTime = TimeUtil:GetTime()
-- 	local _bossIsActive, _bossStartTime, _bossEndTime = WorldBossMgr:CheckIsActive()
-- 	if(_bossIsActive) then
-- 		bossIsActive = _curTime >= _bossEndTime and false or _bossEndTime
-- 		if(_curTime >= _bossStartTime) then
-- 			bossBtnNextRefreshTime = _bossEndTime
-- 		else
-- 			bossBtnNextRefreshTime = _bossStartTime
-- 		end
-- 		if(bossIsActive) then
-- 			local isShowBtn =(_curTime >= _bossStartTime and _curTime < _bossEndTime) and true or false
-- 			CSAPI.SetGOActive(btnBoss, isShowBtn)
-- 		else
-- 			CSAPI.SetGOActive(btnBoss, false)
-- 		end
-- 	else
-- 		bossIsActive = false
-- 		CSAPI.SetGOActive(btnBoss, false)
-- 	end
-- end

-- TeamBoss
-- function SetTeamBoss()
-- 	local curTime = TimeUtil:GetTime()
-- 	teamBossIsActive, teamBossEndTime, teamBossNextCheckTime = TeamBossMgr:CheckOpen()
-- 	CSAPI.SetGOActive(btnTeamBoss, teamBossIsActive)
-- 	local height = btnBoss.activeSelf and 310 or 342
-- 	CSAPI.SetRTSize(imgTeamBossBg, 217, height)
-- end

-- 出击
function OnClickAttack()
    -- local id = DungeonMgr:GetCurrFightId()
    -- 设置点击间隔
    local viewBase = ComUtil.GetCom(btnAttack, "ViewBase")
    viewBase.clickSpaceTime = id ~= nil and 5000 or 500

    -- if(id) then
    -- 	DungeonMgr:SetToCheckBattleFight()
    -- 	DungeonMgr:ApplyEnter(id)
    -- else
    CSAPI.OpenView("Section")
    -- end
end
-- boss
-- function OnClickBoss()
--     CSAPI.OpenView("WorldBossMenu")
-- end
-- function OnClickTeamBoss()
--     CSAPI.OpenView("TeamBossView")
-- end

function SetRole()
    CSAPI.SetText(txtRoleCur, RoleMgr:GetCurSize() .. "")
    -- CSAPI.SetText(txtRoleMax, RoleMgr:GetMaxSize() .. "")
end
function SetTeam()
    teamItems = teamItems or {}
    local datas = {}
    local _datas = TeamMgr:GetDuplicateTeamCoolState() -- 123 正常，冷却中，低于10
    for i = 1, 8 do
        if (_datas[i]) then
            table.insert(datas, {i, _datas[i]})
        else
            table.insert(datas, {i, 0})
        end
    end
    ItemUtil.AddItems(menuTeamItemPath, teamItems, datas, teamGrid)
end
function SetMission()
    local cur, max = MissionMgr:GetDayStars(eTaskType.Daily)
    local per = max == 0 and 1 or cur / max
    per = math.ceil(per * 100)
    per = per > 100 and 100 or per
    -- CSAPI.SetText(txtMissionPercent, per .. "")
    fillMissionValue = per / 100
end
function SetShop()
    CSAPI.SetGOActive(imgNew, false)
end

----------------------------------------centre-----------------------------------------------
function SetCenter()
    SetBG()
    SetImg()
    SetObjTalk()
end
-- 设置背景
function SetBG()
    local curBGID = PlayerClient:GetBG()
    local cfg = Cfgs.CfgMenuBg:GetByID(curBGID)
    if (cfg and cfg.name) then
        ResUtil:LoadBigImg2(bg, "UIs/BGs/" .. cfg.name .. "/bg", false)
    end
end

-- 设置看板  
function SetImg(cb)
    -- 加载立绘并且调整到调整过的位置
    isRole = PlayerClient:KBIsRole()
    CSAPI.SetGOActive(cardIconItem.gameObject, isRole)
    CSAPI.SetGOActive(mulIconItem.gameObject, not isRole)
    -- CSAPI.SetGOActive(bg, isRole)
    if (isRole) then
        SetImg1(cb)
    else
        SetImg2(cb)
    end
end

function SetImg1(cb)
    local cache = FileUtil.LoadByPath("kanban") or {}
    local l2d = cache.l2d
    local scale = cache.scale or 1
    local x = cache.x or 0
    local y = cache.y or 0
    CSAPI.SetAnchor(iconParent, x, y, 0)
    CSAPI.SetScale(iconParent, scale, scale, 1)
    -- 看板角色名
    local modelCfg = Cfgs.character:GetByID(PlayerClient:GetPanelId())
    local cfg = Cfgs.CfgCardRole:GetByID(modelCfg.role_id)
    if (cfg and (cfg.id == g_InitRoleId[1] or cfg.id == g_InitRoleId[2])) then
        CSAPI.SetGOActive(nameBg, false)
    else
        CSAPI.SetGOActive(nameBg, true)
        CSAPI.SetText(txtTalkName, cfg and cfg.sAliasName or "")
    end

    -- 停止上一段语音
    RoleAudioPlayMgr:StopSound()
    EndCB()

    isChangeImgPlayVoice = true

    -- 是否有入场动画 
    isIn = false
    if (l2d) then
        isIn = MenuMgr:CheckHadL2dIn(true, PlayerClient:GetPanelId(), true) -- 有 in
        if (isIn and MenuMgr:CheckIsPlayIn(PlayerClient:GetPanelId())) then
            isIn = false
        end
    end

    cardIconItem.Refresh(PlayerClient:GetPanelId(), LoadImgType.Main, function()
        if (isIn and not cardIconItem.CheckIn()) then
            isIn = false
        end
        if (isIn) then
            MenuMgr:SetPlayInID(PlayerClient:GetPanelId())
            if (cb) then
                cb()
            end
        else
            MenuMgr:SetPlayInID(nil)
        end
        -- isIn = false -- 是否有入场动画 
        -- if (l2d) then
        --     local _isIn = cardIconItem.CheckIn()
        --     if (_isIn and not MenuMgr:CheckIsPlayIn(PlayerClient:GetPanelId())) then
        --         MenuMgr:SetPlayInID(PlayerClient:GetPanelId())
        --         isIn = true
        --     end
        -- else
        --     MenuMgr:SetPlayInID(nil)
        -- end
        FirstLoadCB()
    end, l2d)
end

function SetImg2(cb)
    local cache = FileUtil.LoadByPath("kanban") or {}
    local l2d = cache.l2d
    local scale = cache.scale or 1
    local x = cache.x or 0
    local y = cache.y or 0

    CSAPI.SetAnchor(iconParent, x, y, 0)
    CSAPI.SetScale(iconParent, scale, scale, 1)

    -- 停止上一段语音
    RoleAudioPlayMgr:StopSound()
    EndCB()

    -- 是否有入场动画 
    isIn = false
    if (l2d) then
        isIn = MenuMgr:CheckHadL2dIn(false, PlayerClient:GetPanelId(), true) -- 有 in
        if (isIn and MenuMgr:CheckIsPlayIn(PlayerClient:GetPanelId())) then
            isIn = false
        end
    end

    mulIconItem.Refresh(PlayerClient:GetPanelId(), nil, function()
        if (isIn and not mulIconItem.CheckIn()) then
            isIn = false
        end
        if (isIn) then
            MenuMgr:SetPlayInID(PlayerClient:GetPanelId())
            if (cb) then
                cb()
            end
        else
            MenuMgr:SetPlayInID(nil)
        end
        -- isIn = false -- 是否有入场动画 
        -- if (l2d) then
        --     local _isIn = mulIconItem.CheckIn()
        --     if (_isIn and not MenuMgr:CheckIsPlayIn(PlayerClient:GetPanelId())) then
        --         MenuMgr:SetPlayInID(PlayerClient:GetPanelId())
        --         isIn = true
        --     end
        -- else
        --     MenuMgr:SetPlayInID(nil)
        -- end
        FirstLoadCB()
    end, l2d)
end

-- 看板调整
function OnClickShow()
    CSAPI.OpenView("CRoleDisplay")
end

-- 隐藏语音文本框
function OnClickTalk()
    local value = talkTxtIsShow and 1 or 0
    talkTxtIsShow = not talkTxtIsShow
    PlayerPrefs.SetInt(talkTxtIsShowSaveKey, value)
    SetObjTalk()
    SetTalkBg()
    LanguageMgr:ShowTips(talkTxtIsShow and 13002 or 13001)
end
-- 隐藏语音文本按钮的样式更换
function SetObjTalk()
    local imgName = talkTxtIsShow and "UIs/Menu/btn_03_01.png" or "UIs/Menu/btn_03_02.png"
    CSAPI.LoadImg(btnTalk, imgName, true, nil, true)
end
-- 语音文本
function SetTalkBg()
    local b = false
    if (isTalk and talkTxtIsShow) then
        b = true
    end
    CSAPI.SetGOActive(talkBg, b)
end

-- 隐藏界面，展示角色
function OnClickHide()
    ShowRole(true)
end

function OnClickBack()
    ShowRole(false)
end

-- 看板调整  isShow 展示角色
function ShowRole(_isShow)
    isShow = _isShow
    showTime = nil
    if (not isShow) then
        CSAPI.SetGOActive(btn_exit, false)
    end
    CSAPI.SetGOActive(objShow, not isShow)
    CSAPI.SetGOActive(objHide, not isShow)
    CSAPI.SetGOActive(objTalk, not isShow)

    -- 收缩动画
    if (not anims2.activeSelf and isShow) then
        CSAPI.SetGOActive(anims2, true)
    else
        CSAPI.SetGOActive(anims2, false)
    end

    -- 展开动画
    if (not anims3.activeSelf and not isShow) then
        CSAPI.SetGOActive(anims3, true)
    else
        CSAPI.SetGOActive(anims3, false)
    end

    CSAPI.SetGOActive(ui_structure, not isShow)
end

-------------------------------------------------回调--------------------------------------------
-- 其它界面打开
function OnViewOpened(viewKey)
    -- if (viewKey == "CRoleDisplayDetail") then
    --     CSAPI.SetAnchor(centre, 0, 10000, 0)
    -- end
    if (viewKey == "CRoleDisplay") then
        CSAPI.SetGOActive(centre, false)
    end

    local cfg = Cfgs.view:GetByKey(viewKey)
    if (IsNeedAdd(viewKey) or (viewKey ~= "Menu" and cfg and not cfg.layer and not cfg.is_window)) then
        openViews[viewKey] = 1
        if (viewKey ~= "RoleBreakSuccess" and viewKey ~= "CreateShowView" and viewKey ~= "MenuBuyPanel" and viewKey ~= "ResRecovery") then
            RoleAudioPlayMgr:StopSound() -- 有其它界面打开则中断语音
        end

        HidePanel(viewKey)
    end

    CreateEffect()
end

-- 其它界面关闭
function OnViewClosed(viewKey)
    -- if (viewKey == "CRoleDisplayDetail") then
    --     CSAPI.SetAnchor(centre, 0, 0, 0)
    -- end
    -- 是否更换了看板
    if (viewKey == "CRoleDisplay") then
        CSAPI.SetGOActive(centre, true)
        SetDisplay()
    end

    if (not SceneMgr:IsMajorCity()) then
        return
    end

    if (not openViews[viewKey]) then
        -- 是不影响的界面，将不处理下面的逻辑	
        return
    end

    openViews[viewKey] = nil

    HidePanel(viewKey)

    if (not CheckIsTop()) then
        return
    end

    CreateEffect()

    if (loadingComplete == nil) then
        return -- 动画未播完
    end

    if (isIn) then
        return -- 入场动画
    end

    --EndCB() -- 执行语音循环播放

    PlayLoginVoice()

    -- 功能解锁
    if (CheckModelOpen()) then
        return
    end

    CheckPopUpWindow();

    --
    ShowHint(true)
end

function CheckPopUpWindow()
    local isGuide = GuideMgr:HasGuide("Menu") or GuideMgr:IsGuiding();
    if (isGuide) then
        TriggerGuide();
    else
        EActivityGetCB();
    end
end

-- 主界面是否在最上
function CheckIsTop()
    for i, v in pairs(openViews) do
        if (v ~= nil) then
            -- 还有界面，主界面不是在最上层
            return false
        end
    end
    return true
end

--
function CheckIsTop2()
    for i, v in pairs(openViews) do
        if (i ~= "Guide" and v ~= nil) then
            -- 还有界面，主界面不是在最上层
            return false
        end
    end
    return true
end

function ShowHint(state)
    if (state) then
        local x, y, z = CSAPI.GetPos(btnAttack);
        EventMgr.Dispatch(EventType.Guide_Hint, {
            x = x,
            y = y,
            z = z
        });
    else
        EventMgr.Dispatch(EventType.Guide_Hint);
    end
end

-- 有新公告时，强制弹出界面
function ShowActivity(type)
    if (loadingComplete == nil) then
        return -- 动画未播完
    end
    if (type == BackstageFlushType.Board) then
        if (GuideMgr:HasGuide() or GuideMgr:IsGuiding()) then
            return
        end
        if (not CheckIsTop()) then
            return
        end
        if (ActivityMgr:ToShowAD()) then
            CSAPI.OpenView("ActivityView")
            return
        end
    end
end

-- ==============================--
-- desc:弹窗
-- time:2019-09-23 02:23:26
-- @return 
-- ==============================--
function EActivityGetCB()

    -- 公告活动
    if (ActivityMgr:ToShowAD()) then
        CSAPI.OpenView("ActivityView")
        return
    end

    -- 签到 签到记录接收完毕，检测自动签到 
    if (SignInMgr:CheckAll()) then
        return
    end

    -- 解禁数据
    --if (RoleMgr:GetJieJinDatas()) then
    --    CSAPI.OpenView("RoleJieJinSuccess")
    --    return
    --end

    -- 资源找回 
    -- if (RegressionMgr:CheckNeedShow()) then
    --     CSAPI.OpenView("ResRecovery")
    --     return
    -- end

    -- 付费弹窗 所有界面关闭的0.2后才打开界面（因为有可能是跳转触发的关闭所有界面）
    if (isCheckTime == nil or Time.time > (isCheckTime + 0.2)) then
        isCheckTime = Time.time
        FuncUtil:Call(EActivityGetCB2, nil, 200)
    end

    CSAPI.SetGOActive(mask, false)
end

function EActivityGetCB2()
    if (not CheckIsTop()) then
        return
    end
    if (MenuMgr:CheckNeedToShowMenuBuy()) then
        if (menuBuyItem ~= nil and menuBuyItem.gameObject.activeSelf) then
            menuBuyItem.OnClick()
        end
    end
end

-- --技能升级完成 提示是否打开技能列表
-- function OpenRoleListNormal(need)
-- 	if(not need) then
-- 		local b = RoleSkillMgr:NeedToShowSuccessID()
-- 		if(b) then
-- 			if(isShowDialog) then
-- 				return
-- 			end
-- 			isShowDialog = true
-- 			UIUtil:OpenDialog(LanguageMgr:GetTips(13000), function()
-- 				RoleSkillMgr:CancelAllSuccessIDs()
-- 				CSAPI.OpenView("RoleListNormal")
-- 				isShowDialog = false
-- 			end, function()
-- 				RoleSkillMgr:CancelAllSuccessIDs()
-- 				isShowDialog = false
-- 			end)
-- 		end
-- 	end
-- end
function OnFightRestore()
    if (not loadingComplete) then
        return;
    end

    local isGuide = GuideMgr:HasGuide("Menu") or GuideMgr:IsGuiding();
    FightProto:ShowRestoreFightDialog(not isGuide);
end

function TriggerGuide()
    CSAPI.SetGOActive(mask,false)
    -- LogError("Menu引导");
    EventMgr.Dispatch(EventType.Guide_Trigger, "Menu");
end

------------------------------------------------------------------///功能解锁
-- 检测功能开启 解锁动画 
function CheckModelOpen()
    -- 需要弹窗的放在关卡弹，然后解锁数据
    --[[
    local b = false
    MenuMgr:UpdateDatas() -- 更新数据
    if (not isOpenView and MenuMgr:CheckOpenList()) then
        CSAPI.SetGOActive(mask, true)
        curOpenTimer = TimeUtil:GetTime() + 0.01
        isOpenView = true
        b = true
    end
--]]
    -- 不需要弹窗，直接刷新按钮
    local _datas = MenuMgr:GetNoNeedOpenWaitDatas()
    if (_datas and #_datas > 0) then
        for i, v in pairs(_datas) do
            SetLock(v:GetID())
            SetBtnAlpha(v:GetID(), 1)
        end
    end
    return b
end

--[[
function ModelOpen()
    local timer = curOpenTimer - TimeUtil:GetTime()
    if (timer <= 0) then
        local _data = MenuMgr:GetPost()
        isOpenView = false
        CSAPI.SetGOActive(mask, false)
        CSAPI.OpenView("MenuOpen", _data, nil, nil, true)
        -- 解锁动画 TODO
        SetLock(_data:GetID())
        SetBtnAlpha(_data:GetID(), 1)
    else
        -- todo  倒计时显示
        -- CSAPI.SetText(txtOpen2, math.floor(timer) .. "")
    end
end
]]

-- 登录语言
function PlayLoginVoice()
    local isPlay = false
    if (isRole and isChangeImgPlayVoice and CheckIsTop() and (not ActivityMgr:CheckIsNeedShow()) and
        (not SignInMgr:CheckNeedSignIn())) then
        if (PlayerClient:IsPlayerBirthDay() and not PlayerClient:IsPlayBirthDayVoice()) then
            cardIconItem.PlayVoice(RoleAudioType.birthday) -- 玩家生日
        elseif (MenuMgr:CheckIsFightVier()) then
            cardIconItem.PlayVoice(RoleAudioType.levelBack) -- 归来语音
            MenuMgr:SetFightOver(false)
        else
            if (not cardIconItem.HadInAudio()) then -- 无开场动画语音才会播登录语音
                cardIconItem.PlayVoice(RoleAudioType.login)
            end
        end
        isPlay = true
    end
    isChangeImgPlayVoice = false
    return isPlay
end

-- 部分虽然是Top或者弹窗，但它们影响了主界面的逻辑顺序，所以记录进来
function IsNeedAdd(viewKey)
    if (viewKey == "ActivityView" or viewKey == "PlayerUpgrade" or viewKey == "Guide" or viewKey == "SignInContinue" or
        viewKey == "CRoleDisplay" or viewKey == "MenuBuyPanel" or viewKey == "ResRecovery") then
        return true
    end
    return false
end

-- 当界面不是最前时，隐藏
function HidePanel(viewKey)
    if (IsNeedAdd(viewKey)) then
        return
    end
    if (CheckIsTop2()) then
        CSAPI.SetScale(gameObject, 1, 1, 1)
        enterSV_sv.enabled = true
    else
        enterSV_sv.enabled = false
        CSAPI.SetScale(gameObject, 0, 0, 0)
    end
end

-- function OnClickAbility()
-- 	CSAPI.OpenView("PlayerAbility")
-- end

function CreateEffect()
    local b = false
    if (CheckIsTop2() and not CSAPI.IsViewOpen("CRoleDisplay")) then
        b = true
    end
    CSAPI.SetGOActive(ui_structure, b)
end

-- 付费弹窗
function SetMenuBuy()
    local isOpen = MenuMgr:CheckMenuBuyIsOpen()
    if (not isOpen) then
        return
    end

    local arr = MenuMgr:GetMenyBuyList()
    local curCfg = arr[1]
    if (curCfg) then
        if (not menuBuyItem) then
            local go = ResUtil:CreateUIGO("Menu/MenuBuy", objBuy.transform)
            menuBuyItem = ComUtil.GetLuaTable(go)
        else
            CSAPI.SetGOActive(menuBuyItem.gameObject, true)
        end
        menuBuyItem.Refresh(curCfg)
    else
        if (menuBuyItem) then
            CSAPI.SetGOActive(menuBuyItem.gameObject, false)
        end
    end
    isSpring, springCheckTime, isSpringStart = MenuMgr:CheckSpringTime()
end

-- 付费活动
function OnClickBtnBuy2()
    CSAPI.OpenView("ExtraActivityView", nil, 2)
    -- Tips.ShowTips("敬请期待")
end

-- 资源回收
function OnClickResRecovery()
    --CSAPI.OpenView("ResRecovery")
end

-- 特别馈赠
function OnClickSpecialGifts()
    -- CSAPI.OpenView("SpecialActivityView", nil, 3)
end

-----------------------------------------------基地数据更新----------------------------------------------------------------
function MatrixUpdate()
    if (rRunTime) then
        if (TimeUtil:GetTime() > rRunTime) then
            -- Log("请求更新建筑的时间点："..TimeUtil:GetTime())
            local ids = MatrixMgr:GetResetIds()
            if (#ids > 0) then
                BuildingProto:GetBuildUpdate(ids)
            end
            rRunTime = false
        end
    end
end

function InitResetTime()
    rRunTime = MatrixMgr:GetResetTime()
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if btnHide.gameObject.activeInHierarchy == false and OnClickBack then
        OnClickBack();
    end
end

----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    node = nil;
    bg = nil;
    uiEffectObj = nil;
    effectGrid = nil;
    effectGridFlash = nil;
    centre = nil;
    movePoint = nil;
    movePoint2 = nil;
    iconParent = nil;
    btnShow = nil;
    talkBg = nil;
    txtTalkBg = nil;
    txtTalk = nil;
    nameBg = nil;
    txtTalkName = nil;
    maskL = nil;
    maskR = nil;
    maskT = nil;
    maskTPoint1 = nil;
    maskTPoint2 = nil;
    maskTPoint3 = nil;
    maskTPoint4 = nil;
    maskD = nil;
    top = nil;
    btnSet = nil;
    btnSignInView = nil;
    btnNotice = nil;
    btnMailView = nil;
    objMailRed = nil;
    txtMailCount = nil;
    btnBuff = nil;
    topMiddle = nil;
    txtDay = nil;
    fillPower = nil;
    txtPower = nil;
    btnMoney3 = nil;
    moneyIconBg3 = nil;
    moneyIcon3 = nil;
    txtMoney3 = nil;
    btnMoney2 = nil;
    moneyIconBg2 = nil;
    moneyIcon2 = nil;
    txtMoney2 = nil;
    btnMoney1 = nil;
    moneyIconBg1 = nil;
    moneyIcon1 = nil;
    txtMoney1 = nil;
    txtMax = nil;
    objAD = nil;
    objName = nil;
    btnPlayerView = nil;
    txtLv = nil;
    txtName = nil;
    txtUID = nil;
    fillLv = nil;
    objChat = nil;
    objMessageBG = nil;
    btnChat = nil;
    rightBg = nil;
    rightBgPoint = nil;
    btnRoleListNormal = nil;
    txtRole1Bg = nil;
    txtRole1 = nil;
    txtRole2 = nil;
    txtRoleCur = nil;
    txtRole3 = nil;
    txtRoleMax = nil;
    btnTeamView = nil;
    txtTeam = nil;
    teamGrid = nil;
    attackBg = nil;
    btnAttack = nil;
    txtAttackCur = nil;
    txtAttackPercent = nil;
    objAttackRed = nil;
    Image = nil;
    btnCoolView = nil;
    btnMissionView = nil;
    txtMissionPercent = nil;
    fillMission = nil;
    btnShopView = nil;
    imgShop = nil;
    txtShopBg = nil;
    txtShop = nil;
    imgNew = nil;
    btnCreateView = nil;
    fillCreate = nil;
    imgCreate = nil;
    btnBoss = nil;
    imgBoss = nil;
    txtBoss = nil;
    txtBossTime = nil;
    btnTeamBoss = nil;
    imgTeamBossBg = nil;
    imgTeamBoss = nil;
    txtTeamBoss = nil;
    txtTeamBossTime = nil;
    bottom = nil;
    btnFriendView = nil;
    txtFriendCount1 = nil;
    txtFriendCount2 = nil;
    txtFriend = nil;
    btnArchiveView = nil;
    txtArchiveCount1 = nil;
    txtArchiveCount2 = nil;
    txtArchive = nil;
    btnGuildMenu = nil;
    txtGuildMenu = nil;
    btnMatrix = nil;
    txtMatrix = nil;
    btnBag = nil;
    txtBag = nil;
    cGrab = nil;
    mask = nil;
    anims = nil;
    view = nil;
end
----#End#----

