-- 红点和new是同一个位置
local redPoss = {
    ["PlayerView"] = {141, 35.5},
    ["MailView"] = {40, 22},
    ["Bag"] = {40, 22},
    ["MenuMore"] = {40, 22},
    ["ActivityListView"] = {109, 55},
    ["Section"] = {112, 71},
    ["Matrix"] = {33.8, 43.5},
    ["MissionView"] = {33.8, 43.5},
    ["RoleListNormal"] = {33.8, 43.5},
    ["TeamView"] = {33.8, 43.5},
    ["CreateView"] = {33.8, 43.5},
    ["ShopView"] = {33.8, 43.5},
    ["ActiveityEnter"] = {112.4, 59.6} -- 版本活动入口
}
-- 上锁位置，下面没有就用红点的位置
local lockPoss = {
    ["ActivityListView"] = {0, 0},
    ["ActiveityEnter"] = {0, 0} -- 版本活动入口
}
-- 入口拿取红点的key值，没有的特殊处理
local redsRef = {
    ["MailView"] = RedPointType.Mail,
    -- ["Bag"] = RedPointType.Bag,
    ["ActivityListView"] = RedPointType.ActivityList1,
    -- ["Section"] = RedPointType.Attack,
    ["Matrix"] = RedPointType.Matrix,
    -- ["MissionView"] = RedPointType.Mission,
    ["RoleListNormal"] = RedPointType.RoleList,
    ["CreateView"] = RedPointType.Create,
    ["ShopView"] = RedPointType.Shop
}
--
local moneyIDs = {ITEM_ID.DIAMOND, ITEM_ID.GOLD, 10035}
--
local views = {"PlayerView", "MailView", "Bag", "MenuMore", "ActivityListView", "Matrix", "MissionView",
               "RoleListNormal", "TeamView", "CreateView", "ShopView", "Section"} -- 统一处理（上锁，红点检查，点击）
--
local MenuLBtnData = require("MenuLBtnData")
--
local mAlpha = 0.5
local fill_lv = nil
local fill_attack = nil
local sv_ltsv = nil
local cg_node = nil
--
local isAnimSuccess = false -- 入场完毕（角色入场动画完成，UI动画完成）
local isPlayIn = false
--
local timer = 0
local curTime = nil
local isHideUI = false -- 隐藏ui
local showTime = nil
local isShowTalk = true -- 台词文本
local activeEnter_tab = {} -- {cfg:CfgActiveEntry,刷新时间,是否开启}
local menuBuy_tab = nil -- 下次刷新点{time，id}
local isTalking = false -- 正在说话
local lvSV_time = nil
local lockDatasDic = {} -- 当前上锁的view
local closeViews = nil
local voicePlaying
local nextPlayTime
local hotTimer = nil
local matrixRTime = nil
local colosseumRTime = nil
-- local petStateTime = nil 
local isExerciseLOpen = false
local activityRefreshTime = nil
local menuStandbyTimer = nil
local exerciseLTime = nil
local openViews = {} -- 当前打开的界面
local anim_uis
local anim_rd
local anim_center_ctl
local anim_center_ltc
local rdType = 1
local barTime = nil
local barValue = 0
local barLen = 0.5
local anim_create
local anim_shop
local rdLNR = {}
local globalBossTime = 0
local bagLimitTime
local skinLimitTime = nil

function Awake()
    AdaptiveConfiguration.SetLuaObjUIFit("MenuView", gameObject)
    fill_lv = ComUtil.GetCom(fillLv, "Image")
    fill_attack = ComUtil.GetCom(fillAttack, "Image")
    sv_ltsv = ComUtil.GetCom(ltSV, "ScrollRect")
    cg_node = ComUtil.GetCom(node, "CanvasGroup")
    --
    cardIconItem = RoleTool.AddRole(iconParent1, PlayCB, EndCB, true) -- 立绘
    mulIconItem = RoleTool.AddMulRole(iconParent1, PlayCB, EndCB, true) -- 多人插图 
    cardIconItem2 = RoleTool.AddRole(iconParent2, PlayCB, EndCB, true) -- 立绘
    -- 台词相关
    voicePlaying = false -- 正在播放
    nextPlayTime = TimeUtil:GetTime() + 180 -- 自动播放台词间隔 180s	
    --
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Loading_Complete, LoadingComplete) -- 关闭loading
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    if CSAPI.IsADV() then
        AdvBindingRewards.Querystate();
        AdvDeductionvoucher.QueryPoints()
    end
end
function OnEnable()
    PlayerClient:SetEnterHall(true);
end
function InitListener()
    if (isInitListener) then
        return
    end
    isInitListener = 1
    -- 红点刷新
    eventMgr:AddListener(EventType.RedPoint_Refresh, function()
        SetReds()
        SetLTSV()
        SetActivityEnter()
    end)
    -- 更换看板
    eventMgr:AddListener(EventType.Player_Select_Card, function()
        SetBG()
        SetImg()
    end)
    -- 续战提示
    eventMgr:AddListener(EventType.Fight_Restore, OnFightRestore)
    -- 升级
    eventMgr:AddListener(EventType.Player_Update, function()
        SetPlayerDetail()
        SetLocks()
    end)
    -- 背包
    eventMgr:AddListener(EventType.Bag_Update, function()
        bagLimitTime = BagMgr:GetLessLimitTime()
        SetMoneys()
    end)
    -- 体力变更
    eventMgr:AddListener(EventType.Player_HotChange, SetHot)
    -- 强制弹出公告
    eventMgr:AddListener(EventType.Main_Activity, ShowActivity)
    -- 刷新当前关卡
    eventMgr:AddListener(EventType.Dungeon_PlotPlay_Over, function()
        SetAttack()
        InitActivityEnter()
        SetActivityEnter()
    end)
    -- 副本数据设置完
    eventMgr:AddListener(EventType.Dungeon_Data_Setted, SetAttack)
    -- 基地 
    eventMgr:AddListener(EventType.Matrix_Building_UpdateEnd, InitMatrixRTime)
    -- 3点刷新 检查弹窗
    eventMgr:AddListener(EventType.Update_Everyday, function()
        if (CheckIsTop()) then
            CheckPopUpWindow()
        end
    end)
    -- 商店购买回调 商店界面返回就自动触发弹窗了
    eventMgr:AddListener(EventType.Shop_Buy_Ret, SetMenuBuy)
    -- 回归判断(3点会更新)
    eventMgr:AddListener(EventType.HuiGui_Check, SetRegressionBtn)
    -- 改名
    eventMgr:AddListener(EventType.Player_EditName, function()
        CSAPI.SetText(txtName, PlayerClient:GetName())
    end)
    -- 更换看板
    eventMgr:AddListener(EventType.CRoleDisplayMain_Change, SetBtnChange)
    -- 宠物？
    -- eventMgr:AddListener(EventType.PetActivity_TimeStamp_Change, SetPetTimeStamp)
    -- 直播模式
    eventMgr:AddListener(EventType.Setting_Live_Change, SetLiveBroadcast)
    -- 更新看板2.0
    eventMgr:AddListener(EventType.CRoleDisplayS_Change, SetBtnChange)
    -- 首充界面关闭
    eventMgr:AddListener(EventType.MenuBuy_RechargeCB, SetMenuBuy)

    -- rtSV相关 START
    -- 回归绑定活动数据更新
    eventMgr:AddListener(EventType.Collaboration_Info_Update, SetLTSV)
    -- 台服web
    eventMgr:AddListener(EventType.Menu_WebView_Enabled, SetLTSV)
    -- rtSV相关 END
    eventMgr:AddListener(EventType.Role_LimitSkin_Refresh, function()
        skinLimitTime = RoleSkinMgr:CheckLimitSkin()
    end)
end

function OnDestroy()
    AdaptiveConfiguration.LuaView_Lua_Closed("MenuView")
    eventMgr:ClearListener()
    RoleAudioPlayMgr:StopSound()
end

function Update()
    -- 展示立绘 
    if (isHideUI) then
        if (CS.UnityEngine.Input.GetMouseButton(0)) then
            showTime = Time.time + 1.5
            CSAPI.SetGOActive(btnBack, true)
        end
        if (showTime and Time.time > showTime) then
            showTime = nil
            CSAPI.SetGOActive(btnBack, false)
        end
    end

    -- 重置待机时间
    if (menuStandbyTimer ~= nil and CS.UnityEngine.Input.GetMouseButton(0)) then
        menuStandbyTimer = MenuMgr:GetNextStandbyTimer()
    end

    -- 经验
    if (barTime) then
        Anim_fillLv()
    end

    ----------------------------下面1s一次--------------------------------------------------
    if (Time.time < timer) then
        return
    end
    timer = Time.time + 1
    curTime = TimeUtil:GetTime()
    -- 活动入口
    if (activeEnter_tab[2]~=nil and curTime >= activeEnter_tab[2]) then
        InitActivityEnter()
        SetActivityEnter()
    end
    -- 刷新rtSV
    if (lvSV_time and curTime >= lvSV_time) then
        SetLTSV()
    end
    -- 付费弹窗
    if (menuBuy_tab and curTime > menuBuy_tab[1]) then
        MenuBuyMgr:ConditionCheck2(menuBuy_tab[2])
        SetMenuBuy()
        if (CheckIsTop()) then
            CheckPopUpWindow()
        end
    end
    -- 自动播放台词
    if (not voicePlaying and curTime > nextPlayTime and mainIconItem and mainIconItem.modelId > 10000) then
        nextPlayTime = curTime + 180
        if (CheckIsTop()) then
            mainIconItem.PlayVoice()
        else
            EndCB() -- 进入下一个循环
        end
    end
    -- 体能回复
    if (hotTimer and curTime > hotTimer) then
        InitHot()
        EventMgr.Dispatch(EventType.Player_HotChange)
    end
    -- 基地刷新
    if (matrixRTime and curTime > matrixRTime) then
        local ids = MatrixMgr:GetResetIds()
        if (#ids > 0) then
            BuildingProto:GetBuildUpdate(ids)
        end
        matrixRTime = nil
    end
    -- 角斗场 
    if (colosseumRTime and curTime > colosseumRTime[1]) then
        local type = colosseumRTime[2]
        colosseumRTime = ColosseumMgr:GetRefreshTimes()
        EventMgr.Dispatch(EventType.Colosseum_Refresh_Time, type)
    end
    -- 宠物
    -- if petStateTime and curTime > petStateTime then
    --     petStateTime = PetActivityMgr:GetEmotionChangeTimestamp()
    -- end
    -- 演习 
    if (exerciseLTime and curTime > exerciseLTime) then
        -- 演习新赛季 new 
        ExerciseMgr:CheckNewSeason()
        -- 参加次数重置 
        ExerciseMgr:CheckNewJoinCnt()
    end

    -- 到点活动更新
    if (activityRefreshTime and curTime > activityRefreshTime) then
        activityRefreshTime = TimeUtil:GetRefreshTime("CfgActiveList", "sTime", "eTime")
        ActivityMgr:RefreshOpenState()
        EventMgr.Dispatch(EventType.Update_Everyday) -- 到点刷新活动
    end
    -- 协同
    if (CollaborationMgr:GetNextBeginTime() > 0 and curTime > CollaborationMgr:GetNextBeginTime()) or
        (CollaborationMgr:GetNextEndTime() > 0 and curTime > CollaborationMgr:GetNextEndTime()) then
        CollaborationMgr:Clear()
        RegressionProto:PlrBindInfo()
    end
    -- 待机界面
    if (menuStandbyTimer and Time.time > menuStandbyTimer) then
        menuStandbyTimer = nil
        if (openViews["Guide"] ~= nil) then
            menuStandbyTimer = MenuMgr:GetNextStandbyTimer()
        else
            CSAPI.OpenView("MenuStandby")
        end
    end
    -- 世界boss
    if globalBossTime > 0 then
        globalBossTime = GlobalBossMgr:GetCloseTime()
        if globalBossTime <= 0 then
            DungeonMgr:CheckRedPointData()
        end
    end
    -- 背包限时物品
       if (bagLimitTime) then
        -- 检测时间是否小于24小时
        if curTime < bagLimitTime and (bagLimitTime - curTime) <= 86400 and BagMgr:IsDayLimitTipsDone() ~= true then
            -- 弹提示
            local dialogData = {};
            dialogData.content = LanguageMgr:GetByID(24045);
            dialogData.title = LanguageMgr:GetByID(24046);
            dialogData.okText = LanguageMgr:GetByID(24044);
            dialogData.hasClose = true;
            dialogData.okCallBack = function()
                -- 跳转到背包
                JumpMgr:Jump(80001);
            end;
            CSAPI.OpenView("Prompt", dialogData);
            -- 记录一次时间戳
            BagMgr:RecordDayLimitTips();
        end
        if curTime > bagLimitTime then
            bagLimitTime = BagMgr:GetLessLimitTime()
            BagMgr:CheckBagRedInfo()
        end
    end
    -- 限时皮肤
    if (skinLimitTime and curTime > skinLimitTime and not skinLimitTime and CheckIsTop()) then
        skinLimitTime = nil
        RoleSkinMgr:CheckLimitSkin()
    end
end

-- 界面逻辑不在这里处理，在Loading_Complete后再处理,这里处理初始化数据操作
function OnOpen()
    -- 解决宿舍模型残留问题
    DormMgr:ClearDormModels()

    -- 初始化
    CSAPI.SetGOActive(uis, false)
    CSAPI.SetGOActive(mask, false)
    CSAPI.SetGOActive(btnBack, false)

end

function LoadingComplete()
    MenuMgr:InitDatas() -- 系统解锁数据
    DungeonMgr:CheckRedPointData() -- 关卡红点检测
    MenuBuyMgr:ConditionCheck(1) -- 检测充值弹窗
    ActivityMgr:InitListOpenState() -- 检测滚动窗口
    --
    Init()
    --
    InitTimers()
    --
    RefreshPanel()
    InitListener()
end

function Init()
    InitOnClick()
    InitActivityEnter()
    InitHot()
    InitMatrixRTime()
    InitAnims()
end

function InitTimers()
    colosseumRTime = ColosseumMgr:GetRefreshTimes()
    -- petStateTime = PetActivityMgr:GetEmotionChangeTimestamp()
    activityRefreshTime = TimeUtil:GetRefreshTime("CfgActiveList", "sTime", "eTime")
    menuStandbyTimer = MenuMgr:GetNextStandbyTimer()
    exerciseLTime = ExerciseMgr:GetRefreshTime()
    globalBossTime = GlobalBossMgr:GetCloseTime()
    bagLimitTime = BagMgr:GetLessLimitTime()
    skinLimitTime = RoleSkinMgr:GetSkinMinLimitTime()
end

function RefreshPanel()
    SetLocks()
    if (isAnimSuccess) then
        SetReds()
        SetLocks()
    else
        FuncUtil:Call(SetReds, nil, 320)
        FuncUtil:Call(SetLocks, nil, 320)
    end
    SetLT()
    SetLD()
    SetRT()
    SetRD()
    SetCenter()
end

-- 入场动画（无动画）完毕  SetCenter->SetImg->PlayInEnd
function PlayInEnd()
    isPlayIn = false
    CSAPI.PlayUISound("ui_window_open_load")
    PlayUIAnim()
end

-- 开始播放ui动画
function PlayUIAnim()
    CSAPI.SetGOActive(uis, true)
    UIUtil:SetObjFade(uis, 0, 1, nil, 200, 1, 0)
    UIUtil:SetPObjMove(LT, 0, 0, 300, 0, 0, 0, nil, 300, 1)
    UIUtil:SetPObjMove(RT, 0, 0, 300, 0, 0, 0, nil, 300, 1)
    UIUtil:SetPObjMove(LD, 0, 0, -300, 0, 0, 0, nil, 300, 1)
    UIUtil:SetPObjMove(RD, 0, 0, -300, 0, 0, 0, nil, 300, 1)
    FuncUtil:Call(PlayUIAnimEnd, nil, 500)
end

------------------------------
-- 【UI动画播放完毕】
------------------------------
function PlayUIAnimEnd()
    isAnimSuccess = true
    --
    local isGuide = GuideMgr:HasGuide("Menu") or GuideMgr:IsGuiding()
    if (not isGuide) then
        PlayerClient:ApplyChangeLine() -- 切线
    end
    --
    if (not CheckIsTop()) then
        return
    end
    -- 检测邀请
    MenuMgr:CheckInviteTips()

    -- 引导相关（有引导时，在关闭引导界面时会触发OnViewClosed）
    local b = false
    FightProto:ShowRestoreFightDialog(not isGuide)
    if (isGuide) then
        TriggerGuide()
        b = true
    else
        b = EActivityGetCB()
    end
    ShowHint(true)
    EventMgr.Dispatch(EventType.Main_Enter)
    if (not b) then
        PlayLoginVoice() -- 登录语音
        VerChecker:ApplyCheck() -- 版本检查
    end
end

function SetLocks()
    lockDatasDic = {}
    for i, v in ipairs(views) do
        local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, v)
        if (not isOpen) then
            lockDatasDic[v] = 1
        end
        if (v ~= "PlayerView") then
            local obj = this["btn" .. v]
            local pos = lockPoss[v] or redPoss[v]
            -- if (obj.transform.parent.name == "rdBtns") then
            --     local x = 33.8 + 131.42 * obj.transform:GetSiblingIndex()
            --     local y = 43.5
            --     UIUtil:SetLockPoint(rdBtnsRedPoint, not isOpen, x, y)
            -- else
            local isShow = not isOpen
            local lockObj = UIUtil:SetLockPoint(obj, isShow, pos[1], pos[2])
            -- end
            CSAPI.SetGOAlpha(obj, isOpen and 1 or 0.5)
            --
            if (obj.transform.parent.name == "rdBtns") then
                rdLNR[v .. "_lock"] = {lockObj, isShow}
            end
        end
    end
    anim_shop.enabled = lockDatasDic["ShopView"] == nil
    anim_create.enabled = lockDatasDic["CreateView"] == nil
end

function SetReds()
    for i, v in ipairs(views) do
        local isNew = false
        local isRed = false
        local isLimit = false -- 是否限时
        if (not lockDatasDic[v]) then
            if (redsRef[v]) then
                local _data = RedPointMgr:GetData(redsRef[v])
                isRed = _data ~= nil
            elseif (v == "MissionView") then
                local _data = RedPointMgr:GetData(RedPointType.Mission)
                if (_data and _data[1] == 1) then
                    isRed = true
                end
            elseif (v == "PlayerView") then
                local _pData = RedPointMgr:GetData(RedPointType.HeadFrame)
                local _pData2 = RedPointMgr:GetData(RedPointType.Head)
                local _pData3 = RedPointMgr:GetData(RedPointType.Badge)
                local _pData4 = RedPointMgr:GetData(RedPointType.Title)
                if (_pData ~= nil or _pData2 ~= nil or _pData3 ~= nil or _pData4 ~= nil) then
                    isRed = true
                end
            elseif (v == "MenuMore") then
                isRed = CheckMoreRed()
            elseif (v == "Section") then
                isNew = SectionNewUtil:IsSectionNew()
                if (not isNew) then
                    isRed = RedPointMgr:GetData(RedPointType.Attack) ~= nil
                end
            elseif (v == "Bag") then
                isLimit = BagMgr:IsShowLimit()
                if (not isLimit) then
                    isRed = RedPointMgr:GetData(RedPointType.Bag) ~= nil
                end
            end
        end
        local obj = this["btn" .. v]
        local pos = redPoss[v]
        -- if (obj.transform.parent.name == "rdBtns") then
        --     local x = 33.8 + 131.42 * obj.transform:GetSiblingIndex()
        --     local y = 43.5
        --     UIUtil:SetNewPoint(rdBtnsRedPoint, isNew, x, y)
        --     UIUtil:SetRedPoint(rdBtnsRedPoint, isRed, x, y)
        -- else
        local newObj = UIUtil:SetNewPoint(obj, isNew, pos[1], pos[2])
        local redObj = UIUtil:SetRedPoint(obj, isRed, pos[1], pos[2])
        local limitObj = UIUtil:SetLimitPoint(obj, isLimit, pos[1], pos[2])
        -- end
        if (obj.transform.parent.name == "rdBtns") then
            rdLNR[v .. "_new"] = {newObj, isNew}
            rdLNR[v .. "_red"] = {redObj, isRed}
            rdLNR[v .. "_limit"] = {limitObj, isLimit}
        end
    end
end

function CheckMoreRed()
    local _redsRef = {
        ["Achievement"] = RedPointType.Achievement,
        -- ["Dorm"] = ,
        ["FriendView"] = RedPointType.Friend,
        ["CourseView"] = RedPointType.Achievement,
        ["PlayerAbility"] = RedPointType.PlayerAbility,
        ["ArchiveView"] = RedPointType.Archive
        -- ["ActivityView"] = RedPointType.,
        -- ["SettingView"] = RedPointType.,
        ----["ActivityListView"] = RedPointType.ActivityList1
    }
    for k, v in pairs(_redsRef) do
        local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, k)
        if (isOpen) then
            local _data = RedPointMgr:GetData(v)
            if (_data ~= nil) then
                return true
            end
        end
    end
    return false
end
-------------------------Init--------------------------------------
function InitOnClick()
    for k, key in pairs(views) do
        local _name = "OnClick" .. key
        if (key == "Matrix") then
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    MatrixMgr:SetEnterAnim(true)
                    SceneLoader:Load("Matrix") -- 基地的打开方式（要加载场景）
                end
            end
        elseif (key == "MissionView") then
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    local openSetting = nil
                    if (GuideMgr:IsGuiding()) then
                        openSetting = eTaskType.Daily
                    end
                    CSAPI.OpenView(key, nil, openSetting)
                end
            end
        else
            -- 通用的打开方式
            this[_name] = function()
                local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, key)
                if (not isOpen) then
                    Tips.ShowTips(str)
                else
                    CSAPI.OpenView(key)
                end
            end
        end
    end
end

function InitActivityEnter()
    activeEnter_tab = {}
    local ativeEnter = {}
    local curTime = TimeUtil:GetTime()
    local cfgs = Cfgs.CfgActiveEntry:GetAll()
    for k, v in pairs(cfgs) do
        if (v.sort and v.sort > 0) then
            if (curTime < TimeUtil:GetTimeStampBySplit(v.endTime)) then
                table.insert(ativeEnter, v)
            end
        end
    end
    if (#ativeEnter > 0) then
        if (#ativeEnter > 1) then
            table.sort(ativeEnter, function(a, b)
                return a.sort < b.sort
            end)
        end
        local index = 1
        for k, v in ipairs(ativeEnter) do
            local begTime = TimeUtil:GetTimeStampBySplit(v.begTime)
            if (curTime >= begTime) then
                index = k
                break
            end
        end
        local cfg = ativeEnter[index]
        activeEnter_tab = {cfg}
        local begTime = TimeUtil:GetTimeStampBySplit(cfg.begTime)
        local endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
        --
        local isOpen = curTime >= TimeUtil:GetTimeStampBySplit(cfg.begTime)
        activeEnter_tab[3] = isOpen
        --
        activeEnter_tab[2] = isOpen and endTime or begTime
        --
        local isLock = false
        if (cfg.nConfigID) then
            isLock = true
            local _cfg = Cfgs[cfg.config]:GetByID(cfg.nConfigID)
            if (_cfg) then
                local sid = 0
                if _cfg.sectionID then
                    sid = _cfg.sectionID
                elseif _cfg.infos and _cfg.infos[1] and _cfg.infos[1].sectionID then
                    sid = _cfg.infos[1].sectionID
                end
                local sectionData = DungeonMgr:GetSectionData(sid)
                if (sectionData ~= nil) then
                    isLock = not sectionData:GetOpen()
                end
            end
        end
        activeEnter_tab[4] = isLock
    end
end

function InitHot()
    local time = PlayerClient:THot()
    hotTimer = nil
    if (time ~= 0) then
        hotTimer = time
    end
end

function InitMatrixRTime()
    matrixRTime = MatrixMgr:GetResetTime()
end

-------------------------Center--------------------------------------
function SetCenter()
    SetBG()
    SetImg()
    SetLiveBroadcast()
end
-- 设置背景
function SetBG()
    local curDisplayData = CRoleDisplayMgr:GetCurData()
    local cfg = curDisplayData and Cfgs.CfgMenuBg:GetByID(curDisplayData:GetBG()) or nil
    if (cfg and cfg.name) then
        ResUtil:LoadMenuBg(bg, "UIs/" .. cfg.name, false)
    end
end
function SetImg()
    RoleAudioPlayMgr:StopSound()
    EndCB()
    --
    isChangeImgPlayVoice = true
    local curDisplayData = CRoleDisplayMgr:GetCurData()
    SetItem(1, curDisplayData:GetIDs()[1], cardIconItem, true, iconParent1, curDisplayData)
    SetItem(1, curDisplayData:GetIDs()[1], mulIconItem, false, iconParent1, curDisplayData)
    SetItem(2, curDisplayData:GetIDs()[2], cardIconItem2, true, iconParent2, curDisplayData)
    -- 
    local top = iconParent2
    if (curDisplayData:GetDetail(1) and curDisplayData:GetDetail(1).top) then
        top = iconParent1
    end
    top.transform:SetAsLastSibling()
end

function SetItem(slot, id, item, roleSlot, iconParent, curDisplayData)
    if (id and id ~= 0 and ((roleSlot and id > 10000) or (not roleSlot and id < 10000))) then
        CSAPI.SetGOActive(item.gameObject, true)
        local detail = curDisplayData:GetDetail(slot)
        CSAPI.SetAnchor(iconParent, detail.x, detail.y, 0)
        CSAPI.SetScale(iconParent, detail.scale, detail.scale, 1)
        -- item.EnNeedClick(detail.top) -- 启禁点击 
        item.Refresh(id, LoadImgType.Main, function()
            -- 入场动画
            if (slot == curDisplayData:GetTopSlot()) then
                mainIconItem = item
                local isIn = false
                local inType = CRoleDisplayMgr:GetSpineInType()
                if (inType == 2) then
                    -- 完整模式
                    local hadIn = MenuMgr:CheckHadL2dIn(id > 10000, id, detail.live2d)
                    if (hadIn and mainIconItem.CheckIn()) then
                        isIn = true
                    end
                elseif (inType == 3) then
                    -- 例登模式
                    local num = MenuMgr:GetIsPlay()
                    if (num == 0) then
                        local hadIn = MenuMgr:CheckHadL2dIn(id > 10000, id, detail.live2d)
                        if (hadIn and mainIconItem.CheckIn()) then
                            isIn = true
                            MenuMgr:SetIsPlay(1)
                        end
                    end
                elseif (inType == 4) then
                    -- 例次
                    local hadIn = MenuMgr:CheckHadL2dIn(id > 10000, id, detail.live2d)
                    if (hadIn and mainIconItem.CheckIn() and not CRoleDisplayMgr:CheckIsPlayIn(id)) then
                        isIn = true
                    end
                end
                if (inFirstLoadCB ~= nil) then
                    if (isIn) then
                        OnClickHide() -- 隐藏UI元素 
                        isPlayIn = true
                        mainIconItem.PlayIn(function()
                            isPlayIn = false
                            OnClickBack()
                            CheckPopUpWindow()
                        end, iconParent)
                    end
                else
                    inFirstLoadCB = 1
                    if (isIn and CRoleDisplayMgr:IsFirst()) then
                        isPlayIn = true
                        mainIconItem.PlayIn(PlayInEnd, iconParent)
                    else
                        PlayInEnd()
                    end
                end
                CRoleDisplayMgr:SetPlayInID(id)
            end
        end, detail.live2d, curDisplayData:IsShowShowImg(slot), detail.top)
    else
        item.ClearCache()
        CSAPI.SetGOActive(item.gameObject, false)
    end
end

function SetLiveBroadcast()
    if (cardIconItem and cardIconItem.gameObject.activeSelf) then
        cardIconItem.SetLiveBroadcast()
    end
    if (mulIconItem and mulIconItem.gameObject.activeSelf) then
        mulIconItem.SetLiveBroadcast()
    end
    if (cardIconItem2 and cardIconItem2.gameObject.activeSelf) then
        cardIconItem2.SetLiveBroadcast()
    end
    SetImgLive()
end

function SetImgLive()
    CSAPI.SetGOActive(imgLive, SettingMgr:GetValue(s_other_live_key) == 1)
end

function SetTalkBg()
    local b = false
    if (isTalking and isShowTalk) then
        b = true
    end
    CSAPI.SetGOActive(talkBg, b)
end

-------------------------LT--------------------------------------
function SetLT()
    SetPlayerDetail()
    SetLTSV()
end
function SetPlayerDetail()
    CSAPI.SetText(txtName, PlayerClient:GetName())
    CSAPI.SetText(txtUID, "UID:" .. PlayerClient:GetUid())
    CSAPI.SetText(txtLv, PlayerClient:GetLv() .. "")
    local isMax = PlayerClient:GetLv() == PlayerClient:GetMaxLv()
    fill_lv.fillAmount = isMax and 1 or (PlayerClient:GetExp() / PlayerClient:GetNextExp())
    --
    barValue = fill_lv.fillAmount
    barTime = 0
end
function SetLTSV()
    lvSV_time = nil
    -- 初始化数据
    local ltSVDatas = {}
    local cfgs = Cfgs.CfgMenuLBtns:GetAll()
    for k, v in pairs(cfgs) do
        local _data = MenuLBtnData.New()
        _data:Init(v)
        if (_data:IsShow()) then
            table.insert(ltSVDatas, _data)
        end
        -- 刷新的最短时间
        local _time = _data:RefreshTime()
        if (_time and (lvSV_time == nil or _time < lvSV_time)) then
            lvSV_time = _time
        end
    end
    if (#ltSVDatas > 1) then
        table.sort(ltSVDatas, function(a, b)
            return a:GetCfg().sort < b:GetCfg().sort
        end)
    end
    ltSVItems = ltSVItems or {}
    local len = #ltSVDatas
    ItemUtil.AddItems("Menu/MenuLBtn", ltSVItems, ltSVDatas, ltSVContent, nil, 1, nil, function()
        if (not isltSVItemsIn and #ltSVItems > 1) then
            isltSVItemsIn = 1
            local len = #ltSVDatas
            for k = 1, len do
                if (ltSVItems[k]) then
                    CSAPI.SetGOActive(ltSVItems[k].gameObject, false)
                    FuncUtil:Call(ShowLTSVItem, nil, 33 * (k - 1) + 1, k)
                end
            end
        end
    end)
end
function ShowLTSVItem(k)
    CSAPI.SetGOActive(ltSVItems[k].gameObject, true)
end
-------------------------LD--------------------------------------
function SetLD()
    SetTalkBtn()
    SetAD()
    SetBtnChange()
end
function SetTalkBtn()
    local imgName = isShowTalk and "UIs/Menu/btn_01_05.png" or "UIs/Menu/btn_01_01.png"
    CSAPI.LoadImg(btnTalk, imgName, true, nil, true)
end
function SetAD()
    if (isSetAD == nil) then
        isSetAD = 1
        ResUtil:CreateUIGO("Menu/MenuAD", objAD.transform)
    end
end
function SetBtnChange()
    CSAPI.SetGOActive(btnChange, CRoleDisplayMgr:GetRealLen() > 1)
end
-------------------------RT--------------------------------------
function SetRT()
    SetMoneys()
    SetHot()
    SetMenuBuy()
end
function SetMoneys()
    for i, v in ipairs(moneyIDs) do
        local cfg = Cfgs.ItemInfo:GetByID(v)
        ResUtil.IconGoods:Load(this["moneyIcon" .. i], cfg.icon .. "_1")
        if (v ~= 10035) then
            local num = BagMgr:GetCount(v)
            CSAPI.SetText(this["txtMoney" .. i], num .. "")
        end
    end
end
-- 体力变化
function SetHot()
    local cur = PlayerClient:Hot()
    local max1, max2 = PlayerClient:MaxHot()
    CSAPI.SetText(txtMoney3, cur .. "/" .. max1)
end
-- 付费弹窗
function SetMenuBuy()
    if (CSAPI.IsAppReview()) then
        return -- app审核
    end
    local isHad = false
    menuBuy_tab = nil
    local isOpen = MenuBuyMgr:CheckMenuBuyIsOpen()
    if (isOpen) then
        local curData = MenuBuyMgr:GetCurData()
        if (curData) then
            isHad = true
            if (not menuBuyItem) then
                local go = ResUtil:CreateUIGO("Menu/MenuBuy", objBuy.transform)
                menuBuyItem = ComUtil.GetLuaTable(go)
            else
                CSAPI.SetGOActive(menuBuyItem.gameObject, true)
            end
            menuBuyItem.Refresh(curData)
        end
        menuBuy_tab = MenuBuyMgr:GetOpenEndTimeInfo()
    end
    CSAPI.SetGOActive(objBuy, isHad)
end

-- function SetPetTimeStamp(eventData)
--     if eventData then
--         petStateTime = eventData
--     end
-- end

-------------------------RD--------------------------------------
function SetRD()
    SetAttack()
    SetActivityEnter()
end
function SetAttack()
    local sectionData = DungeonMgr:GetLastMainLineSection() -- 获取当前进行的主线章节
    if (sectionData) then
        local data = sectionData:GetLastOpenDungeon() -- 获取进行的副本配置表
        local per = sectionData:GetCompletePercent() -- 获取当前章节完成度的百分比 0-100
        CSAPI.SetText(txtAttackCur, data and data.chapterID or "0-1")
        fill_attack.fillAmount = per / 100
    end
end

function SetActivityEnter()
    CSAPI.SetGOActive(btnActiveityEnter, activeEnter_tab[3])
    if (activeEnter_tab[3]) then
        local imgName = activeEnter_tab[1].mainBtn
        ResUtil.MenuEnter:Load(img_activity, imgName)
        local isLock = activeEnter_tab[4]
        CSAPI.SetGOAlpha(btnActiveityEnter, not isLock and 1 or mAlpha)
        SetLock("ActiveityEnter", isLock)
        local isRed = false
        if (not isLock) then
            local key = "ActiveEntry" .. activeEnter_tab[1].id
            if (key == "ActiveEntry26") then
                data = ColosseumMgr:IsRed()
            else
                data = RedPointMgr:GetData(key)
            end
            if (data and data ~= 0) then
                isRed = true
            end
        end
        SetRed("ActiveityEnter", isRed)
    end
end

-------------------------公共处理--------------------------------------
-- 主界面是否在最上
function CheckIsTop()
    for i, v in pairs(openViews) do
        if (v ~= nil) then
            return false
        end
    end
    return true
end

-- 主界面是否在最上（忽略窗口型界面）
function CheckIsTop2()
    for i, v in pairs(openViews) do
        if (v == 1) then
            return false
        end
    end
    return true
end

function SetLock(key, isLock)
    local pos = lockPoss[key] or redPoss[key]
    UIUtil:SetLockPoint(this["btn" .. key], isLock, pos[1], pos[2])
end

function SetRed(key, add)
    local pos = redPoss[key]
    UIUtil:SetRedPoint(this["btn" .. key], add, pos[1], pos[2])
end
-------------------------弹窗+Else--------------------------------------
function EActivityGetCB()
    -- 公告活动
    if (ActivityMgr:ToShowAD()) then
        CSAPI.OpenView("ActivityView")
        return true
    end

    -- 活动相关的界面弹窗
    if (ActivityMgr:CheckPopView()) then
        return true
    end

    -- 解禁数据
    if (RoleMgr:GetJieJinDatas()) then
        CSAPI.OpenView("RoleJieJinSuccess")
        return true
    end

    -- 资源找回 
    if (RegressionMgr:CheckNeedShow()) then
        CSAPI.OpenView("ResRecovery")
        return true
    end
    -- 首冲
    if (not CSAPI.IsAppReview()) then
        if (isNeedToShowMenuBuy) then
            return true
        elseif (not isNeedToShowMenuBuy and objBuy.activeSelf and menuBuyItem ~= nil and MenuBuyMgr:CheckIsNeedShow()) then
            isNeedToShowMenuBuy = true
            FuncUtil:Call(EActivityGetCB2, nil, 100)
            return true
        end
    end

    if (OpenGoogleRewards()) then
        return true
    end

    -- 周年活动  
    if (ActivityMgr:CheckWindowShow()) then
        return true
    end

    -- 皮肤是否过期
    RoleSkinMgr:CheckLimitSkin()

    CSAPI.SetGOActive(mask, false)
    return false
end

function EActivityGetCB2()
    CSAPI.SetGOActive(mask, false)
    isNeedToShowMenuBuy = false
    menuBuyItem.OnClick()
end

---谷歌奖励
function OpenGoogleRewards()
    if CSAPI.IsViewOpen("MenuBuyPanel") then
        return false
    end
    if CSAPI.IsADV() then
        local isOpen = MenuMgr:CheckModelOpen(OpenViewType.main, "MailView")
        ShiryuSDK.IsEnterhall = true
        if isOpen then
            return AdvGoogleGit.GoogleReservationRewards()
        end
    end
    return false
end

function ShowHint(state)
    if (state) then
        local x, y, z = CSAPI.GetPos(btnSection)
        EventMgr.Dispatch(EventType.Guide_Hint, {
            x = x,
            y = y,
            z = z
        })
    else
        EventMgr.Dispatch(EventType.Guide_Hint)
    end
end

-- 登录语言
function PlayLoginVoice()
    local isPlay = false
    if (mainIconItem and mainIconItem.modelId > 10000 and isChangeImgPlayVoice) then
        if (PlayerClient:IsPlayerBirthDay() and not PlayerClient:IsPlayBirthDayVoice()) then
            mainIconItem.PlayVoice(RoleAudioType.birthday) -- 玩家生日
        elseif (MenuMgr:CheckIsFightVier()) then
            mainIconItem.PlayVoice(RoleAudioType.levelBack) -- 归来语音
            MenuMgr:SetFightOver(false)
        else
            if (not mainIconItem.HadInAudio()) then -- 无开场动画语音才会播登录语音
                mainIconItem.PlayVoice(RoleAudioType.login)
            end
        end
        isPlay = true
    end
    isChangeImgPlayVoice = false
    return isPlay
end

function TriggerGuide()
    CSAPI.SetGOActive(mask, false)
    EventMgr.Dispatch(EventType.Guide_Trigger, "Menu")
end
-------------------------事件--------------------------------------
-- 其它界面打开
function OnViewOpened(viewKey)
    closeViews = closeViews or {}
    for k, v in ipairs(closeViews) do
        if (v == viewKey) then
            table.remove(closeViews, k)
            break
        end
    end
    local cfg = Cfgs.view:GetByKey(viewKey)
    if (not cfg.top_mask) then
        openViews[viewKey] = cfg.is_window and 2 or 1
        local cfg = Cfgs.view:GetByKey(viewKey)
        if (not cfg.is_window and viewKey ~= "CreateShowView") then
            RoleAudioPlayMgr:StopSound() -- 有其它界面打开则中断语音
        end
        HidePanel(viewKey, true)
    end
end

-- 其它界面关闭
function OnViewClosed(viewKey)
    closeViews = closeViews or {}
    table.insert(closeViews, viewKey)
    if (isApplyRefresh) then
        return
    end
    isApplyRefresh = 1
    if (gameObject ~= nil) then
        FuncUtil:Call(OnViewCloseds, nil, 100)
    end
end

-- 其它界面关闭
function OnViewCloseds()
    if (not gameObject) then
        return
    end
    isApplyRefresh = nil
    local isContain = false
    for k, v in ipairs(closeViews) do
        if (openViews[v]) then
            openViews[v] = nil
            isContain = true
            HidePanel(v, false)
        end
    end
    closeViews = nil
    -- 当前不是最高（那么关闭高界面还会触发OnViewClosed）
    if (not CheckIsTop()) then
        return
    end
    -- -- 不在主场景
    -- if (not SceneMgr:IsMajorCity()) then
    --     return
    -- end
    -- -- 入场动画
    -- if (isPlayIn) then
    --     return
    -- end
    -- -- ui动画
    -- if (not isAnimSuccess) then
    --     return
    -- end
    -- 弹窗
    if (CheckPopUpWindow()) then
        return
    end

    ShowHint(true)
    PlayLoginVoice() -- 登录语音
    VerChecker:ApplyCheck() -- 检测是否强制更新
end

function CheckPopUpWindow()
    -- 不在主场景
    if (not SceneMgr:IsMajorCity()) then
        return true
    end
    -- 入场动画
    if (isPlayIn) then
        return true
    end
    -- ui动画
    if (not isAnimSuccess) then
        return true
    end

    local isGuide = GuideMgr:HasGuide("Menu") or GuideMgr:IsGuiding()
    if (isGuide) then
        TriggerGuide()
        return true
    else
        return EActivityGetCB()
    end
end

-- 语音开始播放
function PlayCB(curCfg)
    if (not IsNil(gameObject) and not IsNil(talkBg)) then
        voicePlaying = true
        local script = SettingMgr:GetSoundScript(curCfg) or ""
        CSAPI.SetText(txtTalk1, script)
        CSAPI.SetText(txtTalk2, script)
        -- SetTalkName(curCfg)
        CSAPI.SetGOActive(txtTalkBg1, curCfg.menuPos == nil)
        CSAPI.SetGOActive(txtTalkBg2, curCfg.menuPos == 1)
        isTalking = true
        SetTalkBg()
    end
end
-- function SetTalkName(curCfg)
--     local str = ""
--     if (curCfg.model) then
--         local cfg = Cfgs.character:GetByID(curCfg.model)
--         if (cfg) then
--             local croleCfg = Cfgs.CfgCardRole:GetByID(cfg.role_id)
--             CSAPI.SetText(txtTalkName, croleCfg and croleCfg.sAliasName or "")
--         end
--     end
-- end

-- 语音播放后
function EndCB()
    if (not IsNil(gameObject) and not IsNil(talkBg)) then
        voicePlaying = false
        nextPlayTime = TimeUtil:GetTime() + 180
        isTalking = false
        SetTalkBg()
    end
end

function OnFightRestore()
    if (not isAnimSuccess) then
        return
    end
    local isGuide = GuideMgr:HasGuide("Menu") or GuideMgr:IsGuiding()
    FightProto:ShowRestoreFightDialog(not isGuide)
end

function ShowActivity(type)
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

-- 回归活动
function SetRegressionBtn()
    CSAPI.SetGOActive(btnRegression, RegressionMgr:IsHuiGui() and #RegressionMgr:GetArr() > 0)
    regresTime = RegressionMgr:GetTime()
    regresTimer = 0
end

-- 当界面不是最前时，隐藏
function HidePanel(viewKey, open)
    SetLook(viewKey, open)
    if (not open) then
        -- 关闭viewKey
        if (CheckIsTop2()) then
            local cfg = Cfgs.view:GetByKey(viewKey)
            if (cfg and not cfg.is_window) then
                CRoleDisplayMgr:NormalCheck2()
            end
            menuStandbyTimer = MenuMgr:GetNextStandbyTimer()
            CSAPI.SetScale(gameObject, 1, 1, 1)
            sv_ltsv.enabled = true
        end
    else
        if (not openViews[viewKey] or openViews[viewKey] == 2) then
        else
            -- 打开viewKey
            if (CheckIsOneTop()) then
                if (viewKey ~= "CRoleDisplayMain") then
                    sv_ltsv.enabled = false
                    CSAPI.SetScale(gameObject, 0, 0, 0)
                end
            end

            menuStandbyTimer = nil
        end
    end
    -- 如果仅Guide在上层则关闭mask
    if (openViews ~= nil and openViews["Guide"] ~= nil) then
        local num = 0
        for k, v in pairs(openViews) do
            num = num + 1
            if (num > 1) then
                return
            end
        end
        CSAPI.SetGOActive(mask, false)
    end
end
function SetLook(viewKey, open)
    -- if (not isAnimSuccess or viewKey == "MenuStandby") then
    --     return
    -- end
    -- if (not open) then
    --     CSAPI.SetScale(movePoint, 1, 1, 1)
    --     cg_node.alpha = 1
    -- else
    --     CSAPI.SetScale(movePoint, 0, 0, 0)
    --     cg_node.alpha = 0.5
    -- end
    if (viewKey == "CRoleDisplay") then
        if (not open) then
            CSAPI.SetScale(movePoint, 1, 1, 1)
            cg_node.alpha = 1
        else
            CSAPI.SetScale(movePoint, 0, 0, 0)
            cg_node.alpha = 0.5
        end
    end
end
-- 是否最多只有一层上层(不包含弹窗类型)
function CheckIsOneTop()
    local num = 0
    for i, v in pairs(openViews) do
        if (v == 1) then
            num = num + 1
            if (num > 1) then
                return false
            end
        end
    end
    return true
end

function GetOpenViews()
    return openViews
end

function GetIsHideUI()
    return isHideUI
end

-------------------------anims--------------------------------------
function InitAnims()
    anim_uis = ComUtil.GetCom(uis, "Animator")
    anim_rd = ComUtil.GetCom(RD, "Animator")
    -- anim_center_ctl = ComUtil.GetCom(center_ctl, "ActionBase")
    -- anim_center_ltc = ComUtil.GetCom(center_ltc, "ActionBase")
    anim_create = ComUtil.GetCom(imgCreate, "Animator")
    anim_shop = ComUtil.GetCom(imgShop, "Animator")
    -- 根据历史记录初始化RD
    rdType = MenuMgr:GetMenuRDType()
    -- SetRDBtns()
end

function SetRDBtns()
    local isShow = rdType == 1
    CSAPI.SetAnchor(rdBtnsBG, isShow and -566 or 175, 84, 0)
    CSAPI.SetAnchor(rdBtnsMove, isShow and -440 or 301, 0, 0)
    CSAPI.SetText(rdTxt, not isShow)
    CSAPI.SetAngle(rdArror, 0, isShow and 0 or 180, 0)
end

-- b:进场
function Anim_uis(b, isPlay)
    if (isPlay) then
        local animNam = b and "uis_in" or "uis_hidden"
        anim_uis:Play(animNam)
        --
        if (b) then
            barValue = fill_lv.fillAmount
            barTime = 0
        end
    end
end
-- b:展开 rdType:1 当前是隐藏状态
function Anim_RD(b)
    local animNam = b and "RD_folding_1" or "RD_folding_2"
    if ((rdType == 1 and b)) or ((rdType ~= 1 and not b)) then
        anim_rd.enabled = true
        anim_rd:Play(animNam)
        if (b) then
            FuncUtil:Call(SetRDLockNexRed, nil, 300, b)
        else
            SetRDLockNexRed(b)
        end
    end
end
function SetRDLockNexRed(b)
    for key, v in pairs(rdLNR) do
        local isShow = false
        if (b and v[2]) then
            isShow = true
        end
        CSAPI.SetGOActive(v[1], isShow)
    end
end
function HideAnimRD()
    if (rdType == 2) then
        anim_rd.enabled = false
    end
end

-- b:还原
function Anim_center(b, isPlay)
    CSAPI.SetGOActive(center_ctl, false)
    CSAPI.SetGOActive(center_ltc, false)
    if (isPlay) then
        if (b) then
            -- anim_center_ltc:ToPlay()
            CSAPI.SetGOActive(center_ltc, true)
        else
            -- anim_center_ctl:ToPlay()
            CSAPI.SetGOActive(center_ctl, true)
        end
    else
        CSAPI.SetAnchor(center, b and 0 or -350, 0, 0)
        CSAPI.SetAnchor(imgLive, b and 0 or -350, 383, 0)
        CSAPI.SetAnchor(txtTalkBg1, b and 0 or -350, -388, 0)
    end
end

function Anim_fillLv()
    if (barTime) then
        barTime = barTime + Time.deltaTime
        fill_lv.fillAmount = barTime / barLen * barValue
        if (barTime >= barLen) then
            barTime = nil
            fill_lv.fillAmount = barValue
        end
    end
end

-------------------------OnClick--------------------------------------

-- 隐藏语音文本框
function OnClickTalk()
    isShowTalk = not isShowTalk
    PlayerPrefs.SetInt(isShowTalkSaveKey, isShowTalk and 1 or 0)
    SetTalkBtn()
    SetTalkBg()
    LanguageMgr:ShowTips(isShowTalk and 13002 or 13001)
end
function OnClickHide()
    showTime = nil
    isHideUI = true
    Anim_uis(false, true)
end
function OnClickBack()
    isHideUI = false
    Anim_uis(true, true)
    CSAPI.SetGOActive(btnBack, false)
end
function OnClickShow()
    CSAPI.OpenView("CRoleDisplayMain")
end
function OnClickChange()
    CRoleDisplayMgr:Change2()
end
function OnClickRDBack()
    rdType = rdType == 1 and 2 or 1
    MenuMgr:SetMenuRDType(rdType)
    Anim_RD(rdType == 1)
end

function OnClickActiveityEnter()
    if (not activeEnter_tab[4]) then
        if (activeEnter_tab[1].JumpID) then
            JumpMgr:Jump(activeEnter_tab[1].JumpID)
        end
    else
        Tips.ShowTips(activeEnter_tab[1].desc) -- 未开启
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
    if (index <= #moneyIDs) then
        local cfg = Cfgs.ItemInfo:GetByID(moneyIDs[index])
        if (cfg and cfg.j_moneyGet) then
            JumpMgr:Jump(cfg.j_moneyGet)
        end
    end
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if btnHide.gameObject.activeInHierarchy == false and OnClickBack then
        OnClickBack()
    else
        if CSAPI.IsADV() then
            ShiryuSDK.ExitGame()
        end
    end
end
