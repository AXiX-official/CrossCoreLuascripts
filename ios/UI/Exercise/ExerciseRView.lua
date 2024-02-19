local isAsk = false -- 是否邀请成功
local isFind = false -- 匹配中
local lIsReady = false -- 是否已准备
local askData = nil -- 邀请或匹配成功的数据
local isShowTeam = false
local fillCount = 0
local rIsReady = false

function Awake()
    tab = ComUtil.GetCom(tabObj, "CTab")
    tab:AddSelChangedCallBack(OnTabChanged)
    layout = ComUtil.GetCom(left2SV, "UISV")
    layout:Init("UIs/ExerciseR/ExerciseRFrientItem", LayoutCallBack, true)
    timeBase = TimeBase.New()
    canvasGroup = ComUtil.GetCom(btnMiddle, "CanvasGroup")
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function OnInit()
    UIUtil:AddTop2("ExerciseRView", gameObject, function()
        view:Close()
    end, nil, {})
    eventMgr = ViewEvent.New()
    -- 准备
    eventMgr:AddListener(EventType.Exercise_Ready, EReady)
    -- 刷新好友
    eventMgr:AddListener(EventType.Friend_Update, ERefreshFriendList)
    -- 邀请或匹配成功
    eventMgr:AddListener(EventType.Exercise_Pp_Success, function(_data)
        InitData(_data)
    end)
    -- 对方退出
    eventMgr:AddListener(EventType.Exercise_Army_Out, function()
        InitData(nil)
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function Update()
    timeBase:Update()
end

function OnDestroy()
    eventMgr:ClearListener()
    -- 中断已成功的匹配
    if (isAsk) then
        ArmyProto:QuitArmy()
    end
    -- 取消匹配
    if (isFind) then
        ExerciseMgr:QuitFreeArmy()
    end
    ExerciseFriendTool:CancelAllInvite() -- 取消邀请
end

-- 1：正常进来  2：被邀请进来(data 不为空)
-- data = {endTime = _endTime, left_time = proto.left_time, type = proto.type}
function OnOpen()
    InitData(data)
end

function InitData(_data)
    askData = _data
    if (askData) then
        isAsk = true
        isFind = false
        lIsReady = false
        SetData()
        RefreshPanel()
    else
        isAsk = false
        isFind = false
        lIsReady = false
        rIsReady = false
        if (curIndex) then
            RefreshPanel()
        else
            tab.selIndex = openSetting and openSetting or 1
        end
        if (timeBase) then
            timeBase:Stop(true)
        end
    end
end

function OnTabChanged(_index)
    if (isAsk or (curIndex and curIndex == _index)) then
        return
    end
    curIndex = _index
    RefreshPanel()
end

function SetData()
    myData = ExerciseFriendTool:GetMyData(askData.type, askData.uid)
    armyData = ExerciseFriendTool:GetArmyData(askData.type, askData.uid, askData.team)
end

function RefreshPanel()
    SetMe()
    SetEnemy()
    SetEnemy2()
    SetFriendPanel()
    SetMiddle()
end

-- 自己 
function SetMe()
    local modelId = PlayerClient:GetIconId()
    SetIconMe(modelId)
    -- lv
    CSAPI.SetText(txtLvL2, "" .. PlayerClient:GetLv())
    -- name
    CSAPI.SetText(txtNameL, PlayerClient:GetName())
    -- 排名
    CSAPI.SetText(txtRankL2, PlayerClient:GetUid() .. "")
    -- 战力
    CSAPI.SetText(txtFightingL2, ExerciseFriendTool:GetMeAttack() .. "")
    -- team
    SetMeItems()
    -- 编队按钮 
    CSAPI.SetGOActive(bntTeam, not isAsk and not lIsReady)
    -- 准备按钮
    CSAPI.SetGOActive(btnStart, isAsk and not lIsReady)
    -- 状态按钮
    CSAPI.SetGOActive(readyL, isAsk and lIsReady)
end

-- 自己
function SetIconMe(icon_id)
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 2
    CSAPI.SetRTSize(iconMaskL, width, arr.y)
    RoleTool.LoadImg(iconL, icon_id, LoadImgType.ExerciseLView)

end
function SetMeItems()
    local cards = TeamMgr:GetTeamCardDatas(eTeamType.RealPracticeAttack)
    -- 封装数据
    local rNewDatas = {}
    for i = 1, 5 do
        if (i <= #cards) then
            table.insert(rNewDatas, cards[i])
        else
            table.insert(rNewDatas, {})
        end
    end

    rTeamGrids = rTeamGrids or {}
    ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", rTeamGrids, rNewDatas, itemGridL)
end

function SetEnemy()
    CSAPI.SetGOActive(r, isAsk)
    if (isAsk) then
        SetEnemyIcon(armyData.icon_id)
        -- lv
        CSAPI.SetText(txtLvR2, armyData.level .. "")
        -- name
        CSAPI.SetText(txtNameR, armyData.name)
        -- uid
        CSAPI.SetText(txtRankR2, armyData.uid .. "")
        -- 战力
        CSAPI.SetText(txtFightingR2, armyData.attack .. "")
        -- items
        SetEnemyItems()
        -- 状态按钮
        CSAPI.SetGOActive(waitR, not rIsReady)
        CSAPI.SetGOActive(readyR, rIsReady)
    else
        CSAPI.SetGOActive(iconR, false)
    end
end
function SetEnemyIcon(icon_id)
    CSAPI.SetGOActive(iconR, true)
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 2
    CSAPI.SetRTSize(iconMaskR, width, arr.y)
    RoleTool.LoadImg(iconR, icon_id, LoadImgType.ExerciseLView, function()
        local x, y = CSAPI.GetAnchor(iconR)
        CSAPI.SetAnchor(iconR, -x, y)
    end)
end
function SetEnemyItems()
    local cardDatas = GetRightCardDatas()
    -- 封装数据
    local lNewDatas = {}
    for i = 1, 5 do
        if (i <= #cardDatas) then
            table.insert(lNewDatas, cardDatas[i])
        else
            table.insert(lNewDatas, {})
        end
    end

    lTeamGrids = lTeamGrids or {}
    ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", lTeamGrids, lNewDatas, itemGridR)
end
function GetRightCardDatas()
    local cardDatas = {}
    if (isExercise) then
        if (armyData and armyData.team) then
            for i, v in ipairs(armyData.team.data) do
                local _card = CharacterCardsData(v.card_info)
                table.insert(cardDatas, _card)
            end
        end
    else
        local _cardDatas = ExerciseFriendTool:GetArmyCardDatas()
        for i, v in pairs(_cardDatas) do
            table.insert(cardDatas, v)
        end
    end
    return cardDatas
end

function SetEnemy2()
    CSAPI.SetGOActive(r2, curIndex == 1)
    if (curIndex == 1) then
        CSAPI.SetGOActive(imgR2, not isAsk)
        CSAPI.SetGOActive(middleFind, isFind)
    end
end

function SetFriendPanel()
    local x = (not isAsk and curIndex == 0) and 0 or 1000
    CSAPI.SetAnchor(friendPanel, x, 0, 0)
    -- 内容 
    ERefreshFriendList()
end

function SetMiddle()
    CSAPI.SetGOActive(middlePair, isAsk)
    if (isAsk) then
        -- 匹配成功
        timeBase:Run(askData.endTime, SetTime1)
        CSAPI.SetText(txtPair3, rIsReady and StringConstant.Exercise80 or StringConstant.Exercise69)
    elseif (isFind) then
        -- 匹配中
        timeBase:Run(TimeUtil:GetTime() + g_ArmyFreeMatchWaitTime, SetTime2)
    else
        -- 停止倒计时
        if (timeBase) then
            timeBase:Stop(true)
        end
    end
end

function SetTime1(_needTime)
    CSAPI.SetText(txtPair2, _needTime .. "s")
    if (_needTime <= 0) then
        isAsk = false
        ExerciseMgr:StartRealArmy(myData.team)
    end
end

function SetTime2(_needTime)
    CSAPI.SetText(txtFind, _needTime .. "s")
    if (_needTime <= 0) then
        ExerciseMgr:QuitFreeArmy(QuitFreeArmyCB)
        LanguageMgr:ShowTips(33019)
    end
end

----------------------------------------------------------------------------
-- 刷新好友列表
function ERefreshFriendList()
    curDatas = FriendMgr:GetDatasByState(eFriendState.Pass)
    table.sort(curDatas, function(a, b)
        return FriendSort(a, b)
    end)
    layout:IEShowList(#curDatas)

    CSAPI.SetGOActive(leftEmpty, #curDatas <= 0)

    -- 数量 
    local cur = FriendMgr:GetFriendCount()
    local max = FriendMgr:GetMaxCount()
    CSAPI.SetText(txtFriendNum, string.format("<color=#ffc146>%s</color>/%s", cur, max))
end
function FriendSort(a, b)
    if ((a:IsOnLine() and b:IsOnLine()) or (a:IsOnLine() == false and b:IsOnLine() == false)) then
        if (a:GetLv() == b:GetLv()) then
            return a:GetAdd_time() < b:GetAdd_time()
        else
            return a:GetLv() > b:GetLv()
        end
    else
        return a:IsOnLine()
    end
end

-- 准备回调或通知
function EReady(proto)
    if (proto.uid == myData.uid) then
        lIsReady = true
        SetMe()
    else
        rIsReady = true
        SetEnemy()
    end
end

----------------------------------------------------------------------------
-- 刷新好友列表
function OnClickRefresh()
    FriendMgr:GetFlush({"icon_id", "name", "is_online", "level"})
end

-- 编队
function OnClickTeam()
    local isOpen = CSAPI.IsViewOpen("TeamView")
    if (isOpen) then
        CSAPI.CloseView("TeamView")
    end
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.RealPracticeAttack,
        canEmpty = false,
        is2D = true
    }, TeamOpenSetting.PVP)
end
function OnViewClosed(viewKey)
    if (viewKey == "TeamView") then
        SetMeItems()
    end
end

-- 开始匹配
function OnClickPP()
    ExerciseMgr:JoinFreeArmy(JoinFreeArmyCB)
end
function JoinFreeArmyCB()
    isFind = true
    SetEnemy2()
    SetMiddle()
end

function OnClickPPC()
    isFind = false
    ExerciseMgr:QuitFreeArmy(QuitFreeArmyCB)
end
function QuitFreeArmyCB()
    isFind = false
    SetEnemy2()
    SetMiddle()
end

function OnClickStart()
    ExerciseMgr:StartRealArmy(myData.team)
end

function OnClickAddFriend()
    CSAPI.OpenView("FriendView")
end
