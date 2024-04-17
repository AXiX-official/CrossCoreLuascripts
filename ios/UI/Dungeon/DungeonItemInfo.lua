local isInfoShow = false -- 右侧信息栏打开
local lastItem = nil
local selItem = nil
local infoFade = nil
local infoCG = nil
local infoMove = nil
local enterPos = {}
local outPos = {}
local txtSelDungeonName = nil
local txtSelDungeonNum = nil
local txtCost = nil
local goGoals = {}
local cfgDungeon = nil
local isCanAIMove = false
local isAIMove = false
local currDungeonData = nil
local isShow = false
local isAnim = true
local isSweepOpen = false
local sectionData = nil
-- 每周
local prograssGOs = {}
-- 多倍
local multiNum = 0
local isDoubleOpen = false
local isMultiUpdate = false
local multiUpdateTime = 0
local isDescOpen = false
-- 活动
local isActive = false

local layout = nil
local svUtil = nil
local curDatas = nil
local currLevel = 1

function SetClickCB(_cb)
    cb = _cb
end

function SetClickMaskCB(_cb)
    maskCB = _cb
end

function Awake()
    infoFade = ComUtil.GetCom(gameObject, "ActionFade")
    infoCG = ComUtil.GetCom(gameObject, "CanvasGroup")
    infoMove = ComUtil.GetCom(gameObject, "ActionMoveByCurve")
    txtSelDungeonName = ComUtil.GetCom(selDungeonName, "Text")
    txtSelDungeonNum = ComUtil.GetCom(selDungeonNum, "Text")
    txtCost = ComUtil.GetCom(cost, "Text")

    layout = ComUtil.GetCom(hsv, "UISV")
    if layout then
        layout:Init("UIs/DungeonActivity2/DungeonDangerNum", LayoutCallBack, true)
        layout:AddOnValueChangeFunc(OnValueChange)    
    end
    svUtil = SVCenterDrag.New()
    CSAPI.SetGOActive(dangerObj, false)

    -- pImg
    local imgGO = ComUtil.GetComInChildren(pImgObj, "Image").gameObject
    table.insert(prograssGOs, imgGO)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, OnTowerRefresh)
    eventMgr:AddListener(EventType.Player_HotChange, ShowCost)
    eventMgr:AddListener(EventType.Bag_Update, ShowCost)
    eventMgr:AddListener(EventType.Sweep_Show_Panel, OnRefreshSweep)
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update,OnDailyDataUpdate)
end

function Update()
    if isMultiUpdate or not sectionData then
        return
    end
    if multiUpdateTime and TimeUtil:GetTime() >= multiUpdateTime then
        isMultiUpdate = true
        PlayerProto:SectionMultiInfo()
    end
end

function OnTowerRefresh()
    if cfgDungeon then
        ShowTowerPrograss(cfgDungeon)
    end
end

function OnRefreshSweep()
    if cfgDungeon then
        ShowSweep(cfgDungeon)
    end
end

function OnDailyDataUpdate()
    ShowDoublePanel()
end

-- 初始化右侧栏
function InitInfo(_isAnim)
    -- isAnim = _isAnim
    -- if isAnim then
    local x, y, z = CSAPI.GetLocalPos(childNode);
    enterPos = {x, y, z}
    outPos = {4000, y, 0};
    CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
    -- end
    CSAPI.SetGOActive(gameObject, false);
    ShowMask(false)
    ShowDesc(false)
end

function Show(item)
    cfgDungeon = nil;
    isShow = item ~= nil
    if item ~= nil then
        cfgDungeon = item.GetCfg();
        selItem = item
    end
    if (item == nil) then
        PlayInfoMove(false);
        ShowOutput(nil)
        return
    else
        PlayInfoMove(true);
    end
end

function Refresh()
    sectionData = DungeonMgr:GetSectionData(cfgDungeon.group)
    txtSelDungeonName.text = cfgDungeon.name
    txtSelDungeonNum.text = cfgDungeon.chapterID and cfgDungeon.chapterID .. "" or ""
    -- CSAPI.SetText(selDungeonNum_1, cfgDungeon.chapterID and "STAGE" or "")
    CSAPI.SetText(selDungeonNum_1, cfgDungeon.chapterID and LanguageMgr:GetByID(15124) or "")
    ShowCost()
    CSAPI.SetGOActive(levelObj,cfgDungeon.lvTips ~= nil)
    local str = cfgDungeon.lvTips ~= nil and cfgDungeon.lvTips or "— —"
    str = cfgDungeon.type == eDuplicateType.Teaching and "— —" or str -- 教程不显示lv
    CSAPI.SetText(txt_topTips2, str);
    CSAPI.SetGOActive(hardInfoObj, cfgDungeon.type == eDuplicateType.MainElite)
    ShowOutput(cfgDungeon) -- 掉落信息
    ShowStarInfo(cfgDungeon); -- 显示条件信息	
    ShowCourse(cfgDungeon)
    -- ShowAIMove(cfgDungeon) -- 自动寻路	
    CSAPI.SetGOActive(aiMoveObj, false)	
    ShowSweep(cfgDungeon)
    ShowTowerPrograss(cfgDungeon) -- 副本进度
    -- 地图预览显示
    local isFighting = cfgDungeon.nGroupID ~= nil and cfgDungeon.nGroupID ~= ""
    CSAPI.SetGOActive(mapObj, not isFighting)
    CSAPI.SetGOActive(enemyImg1, not isFighting)
    CSAPI.SetGOActive(enemyImg2, isFighting)
    ShowDoublePanel()
end

-- 右边信息栏移动
function PlayInfoMove(isShow)
    -- if not isAnim then
    --     CSAPI.SetGOActive(gameObject, isShow);
    --     if isShow then
    --         Refresh()
    --     end
    --     return
    -- end
    if isShow then
        CSAPI.SetGOActive(gameObject, true);
        if isInfoShow and selItem ~= lastItem then
            lastItem = selItem
            infoFade:Play(1, 0, 100, 0, function()
                CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
                infoCG.alpha = 1
                PlayMoveAction(childNode, {enterPos[1], enterPos[2], enterPos[3]})
                ShowAnim()
                Refresh()
            end)
        else
            Refresh()
            lastItem = selItem
            infoFade:Play(0, 1)
            PlayMoveAction(childNode, {enterPos[1], enterPos[2], enterPos[3]}, function()
                isInfoShow = true
            end)
            ShowAnim()
        end
    elseif isInfoShow then
        PlayMoveAction(childNode, {outPos[1], outPos[2], outPos[3]}, function()
            CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
            isInfoShow = false;
            CSAPI.SetGOActive(gameObject, false);
        end)
    end
end

-- 移动动画
function PlayMoveAction(go, pos, callBack)
    infoMove.target = go
    local x, y, z = CSAPI.GetLocalPos(go)
    infoMove.startPos = UnityEngine.Vector3(x, y, z)
    infoMove.targetPos = UnityEngine.Vector3(pos[1], pos[2], pos[3])
    infoMove:Play(function()
        if callBack then
            callBack()
        end
    end)
end

function ShowCost()
    if cfgDungeon then
        local _cost = DungeonUtil.GetCost(cfgDungeon)
        CSAPI.SetGOActive(ticketObj, _cost~=nil)
        if _cost~=nil then
            local cur = BagMgr:GetCount(_cost[1])
            CSAPI.SetText(txtTicket,cur .. "")
            ResUtil.IconGoods:Load(ticketIcon, _cost[1] .. "_1")
            ResUtil.IconGoods:Load(costImg, _cost[1] .. "_3")
            CSAPI.SetAnchor(costImg,-153,0)
            CSAPI.SetText(cost,"-" .. _cost[2])
            local cfg = Cfgs.ItemInfo:GetByID(_cost[1])
            if cfg then
                CSAPI.SetText(txt_cost, cfg.name)
            end
        else
            ResUtil.IconGoods:Load(ticketIcon, ITEM_ID.Hot .. "_1")
            ResUtil.IconGoods:Load(costImg, ITEM_ID.Hot .. "_3")
            local cost = cfgDungeon.enterCostHot and cfgDungeon.enterCostHot or 0
            cost = cfgDungeon.winCostHot and cost + cfgDungeon.winCostHot or cost
            cost = StringUtil:SetByColor(cost .. "", math.abs(cost) <= PlayerClient:Hot() and "191919" or "CD333E")
            txtCost.text = " " .. cost
            LanguageMgr:SetText(txt_cost, 15004)
        end
    end
end

-- 显示掉落
function ShowOutput(cfg)
    local rewardDatas = nil
    if cfg then
        rewardDatas = GetRewardDatas(cfg)
    end
    if (outputGoodItems and #outputGoodItems > 0) then
        for _, goodsItem in ipairs(outputGoodItems) do
            CSAPI.SetGOActive(goodsItem.gameObject, false);
        end
    end
    if (not rewardDatas or #rewardDatas < 1) then
        return
    end
    for i = 1, 4 do
        local goodsData = GoodsData();
        if (not rewardDatas[i]) then
            break
        end
        local id = rewardDatas[i].id
        goodsData:InitCfg(id);
        if outputGoodItems == nil or i > #outputGoodItems then
            ResUtil:CreateUIGOAsync("DungeonDetail/DungeonGoodsItem", goodsNode, function(go)
                outputGoodItems = outputGoodItems or {}
                local goodsItem = ComUtil.GetLuaTable(go);
                goodsItem.Refresh(goodsData, rewardDatas[i].elseData)
                goodsItem.SetFindImg(true)
                table.insert(outputGoodItems, goodsItem)
            end)
        else
            local goodsItem = outputGoodItems[i];
            CSAPI.SetGOActive(goodsItem.gameObject, true);
            goodsItem.Refresh(goodsData, rewardDatas[i].elseData)
            goodsItem.SetFindImg(true)
        end
    end
end

-- 获取掉落信息
function GetRewardDatas(cfg)
    local _datas = {}
    local dungeonData = DungeonMgr:GetDungeonData(cfg.id)
    local isTeaching = cfg.type == eDuplicateType.Teaching -- 教程关
    local specialRewards = RewardUtil.GetSpecialReward(cfg.group)
    if (specialRewards) then
        for i, v in ipairs(specialRewards) do
            local _data = {
                id = v[1],
                elseData = {
                    tag = ITEM_TAG.TimeLimit,
                }
            }
            table.insert(_datas, _data)
        end
    end
    if (cfg.fisrtPassReward and ((not dungeonData or not dungeonData.data or not dungeonData.data.isPass) or isTeaching)) then
        for i, v in ipairs(cfg.fisrtPassReward) do
            local _isPass = false
            if (isTeaching and dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.isPass
            end
            local _data = {
                id = v[1],
                elseData = {
                    tag = ITEM_TAG.FirstPass,
                    isPass = _isPass
                }
            }
            table.insert(_datas, _data)
        end
    end
    if (cfg.fisrt3StarReward and ((not dungeonData or not dungeonData.data or dungeonData.data.star < 3) or isTeaching)) then
        for i, v in ipairs(cfg.fisrt3StarReward) do
            local _isPass = false
            if (isTeaching and dungeonData and dungeonData.data) then
                _isPass = dungeonData.data.star >= 3
            end
            local _data = {
                id = v[1],
                elseData = {
                    tag = ITEM_TAG.ThreeStar,
                    isPass = _isPass
                }
            }
            table.insert(_datas, _data)
        end
    end
    if cfg.fixedReward then --固定
        for i, v in ipairs(cfg.fixedReward) do
            table.insert(_datas, {
                id = v
            })
        end
    end
    if cfg.randomReward then --概率
        for i, v in ipairs(cfg.randomReward) do
            table.insert(_datas, {
                id = v,
                elseData = {
                    tag = ITEM_TAG.Chance
                }
            })
        end
    end
    if cfg.littleReward then --小概率
        for i, v in ipairs(cfg.littleReward) do
            table.insert(_datas, {
                id = v,
                elseData = {
                    tag = ITEM_TAG.LittleChance
                }
            })
        end
    end
    return _datas
end

-- 显示条件信息
function ShowStarInfo(cfgDungeon)
    local list = {};
    -- 显示通关条件
    local dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
    local isTower = cfgDungeon.type == eDuplicateType.Tower
    CSAPI.SetGOActive(goalTitle, true);
    local completeInfo = nil
    if dungeonData and dungeonData.data then
        completeInfo = dungeonData:GetNGrade()
    end
    local starInfos = DungeonUtil.GetStarInfo2(cfgDungeon.id, completeInfo);
    for i = 1, #goGoals do
        CSAPI.SetGOActive(goGoals[i].gameObject, false)
    end
    if #starInfos > 0 then
        local Len = (isTower or (cfgDungeon.diff and cfgDungeon.diff == 3)) and 1 or 3
        for i = 1, Len do
            if #goGoals >= i then
                CSAPI.SetGOActive(goGoals[i].gameObject, true)
                goGoals[i].Init(starInfos[i].tips, starInfos[i].isComplete);
            else
                ResUtil:CreateUIGOAsync("FightTaskItem/FightBigTaskItem", goalTitle, function(go)
                    goGoals = goGoals or {};
                    local item = ComUtil.GetLuaTable(go);
                    CSAPI.SetGOActive(item.gameObject, true)
                    item.Init(starInfos[i].tips, starInfos[i].isComplete);
                    table.insert(goGoals, item);
                end);
            end
        end
    end
end

-- 自动寻路
function ShowAIMove(cfgDungeon)
    CSAPI.SetGOActive(aiMoveObj, IsOpenAI())
    local dungeonData = DungeonMgr:GetDungeonData(cfgDungeon.id)
    if dungeonData and IsOpenAI() then
        currDungeonData = dungeonData
        local aiDatas = LoadAIMoveSetting()
        isAIMove = false
        local starNum = dungeonData:GetStar()
        if starNum >= 3 then
            if aiDatas and aiDatas[dungeonData:GetID()] ~= nil then
                isAIMove = aiDatas[dungeonData:GetID()]
            else
                isAIMove = true
            end
            isCanAIMove = true
        else
            isCanAIMove = false
        end
        if isCanAIMove then
            isAIMove = not isAIMove
            OnClickAIMove()
        else
            SetAIMoveBtnState(false)
        end
    else
        currDungeonData = nil
        isCanAIMove = false
        SetAIMoveBtnState(false)
    end
end

-- 每周副本关卡进度
function ShowTowerPrograss(cfgDungeon)
    local isTower = cfgDungeon.type == eDuplicateType.Tower
    CSAPI.SetGOActive(selDungeonNum,not isTower)
    CSAPI.SetGOActive(selDungeonNum_1,not isTower)
    CSAPI.SetGOActive(prograssObj, isTower)
    CSAPI.SetRTSize(targetObj, 100, isTower and 126 or 240)
    if isTower then
        local num, maxNum = selItem:GetPrograssCount()
        local isRed = selItem.GetRed()
        CSAPI.SetGOActive(redPoint, isRed)
        CSAPI.SetText(txtPrograss, LanguageMgr:GetByID(15029) .. num .. "/" .. maxNum)
        for _, v in ipairs(prograssGOs) do
            CSAPI.SetGOActive(v.gameObject, false)
        end
        if maxNum > 0 then
            for i = 1, maxNum do
                local go = nil
                if (#prograssGOs < i) then
                    go = CSAPI.CloneGO(prograssGOs[1])
                    CSAPI.SetParent(go, pImgObj)
                    table.insert(prograssGOs, go)
                else
                    go = prograssGOs[i].gameObject
                    CSAPI.SetGOActive(go, true)
                end
                local color = i <= num and {255,183,38,255} or {255,255,255,255}
                CSAPI.SetImgColor(go, color[1], color[2], color[3], color[4])
            end
        end
        CSAPI.SetGOActive(txtTime, cfgDungeon.nEndTime ~= nil)
        if (cfgDungeon.nEndTime) then
            local _endTime = GCalHelp:GetTimeStampBySplit(cfgDungeon.nEndTime)
            local surplusTime = TimeUtil:GetTimeTab(_endTime - TimeUtil:GetTime())
            if surplusTime[1] > 0 then
                LanguageMgr:SetText(txtTime, 36008, surplusTime[1] .. "")
            else
                CSAPI.SetText(txtTime, "")
                LogError("该限时副本已结束!" .. cfgDungeon.id)
            end
        end
    end
end

--扫荡状态
function ShowSweep(cfgDungeon)
    if cfgDungeon.diff and cfgDungeon.diff == 3 then
        CSAPI.SetGOActive(btnSweep,false)
        return  
    end
    CSAPI.SetGOActive(btnSweep,cfgDungeon.modUpCnt ~= nil)
    if cfgDungeon.modUpCnt == nil then
        return
    end
    isSweepOpen = false
    local sweepData = SweepMgr:GetData(cfgDungeon.id)
    if sweepData then
        isSweepOpen = sweepData:IsOpen()
    end 
    CSAPI.SetGOActive(sweepLock,not isSweepOpen)
    CSAPI.SetImgColor(sweepImg,255,255,255,isSweepOpen and 255 or 76)
end

function ShowCourse(cfgDungeon)
    local isCourse = cfgDungeon.type == eDuplicateType.Teaching
    CSAPI.SetGOActive(levelObj, not isCourse)
    CSAPI.SetGOActive(courseObj,isCourse)
    if isCourse then
        CSAPI.SetText(txtCourse,cfgDungeon.moduleDesc)
    end
end

function OnClickReward()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.TmpDupTower,
        title = LanguageMgr:GetByID(6018, cfgDungeon.name),
        group = cfgDungeon.missionID
    })
end

function OnClickSafe()
    CSAPI.OpenView("AttributeInfoView", {
        key = "dungeonPassInfo"
    })
end

function OnClickCourse()
    local cfgCourse = Cfgs.CfgModuleInfo:GetByID(cfgDungeon.moduleId)
    if cfgCourse then
        CSAPI.OpenView("ModuleInfoView", cfgCourse)
    end
end

-- 设置自动寻敌按钮状态
function SetAIMoveBtnState(b)
    local posX = b and 23 or -23
    CSAPI.SetAnchor(aiImg, posX, 0)
    local color = b and {59, 46, 20} or {255, 255, 255}
    CSAPI.SetImgColor(aiImg.gameObject, color[1], color[2], color[3], 255)
    local iconName = b and "sel" or "nol"
    CSAPI.LoadImg(btnAI, "UIs/Dungeon/" .. iconName .. ".png", false, nil, true)
end

function OnClickAIMove()
    if not isCanAIMove then
        LanguageMgr:ShowTips(8003)
        return
    end
    isAIMove = not isAIMove
    SetAIMoveBtnState(isAIMove)
    if currDungeonData and isCanAIMove then
        SaveAIMoveSetting(currDungeonData:GetID(), isAIMove)
    end
end

-- 本地保存
function SaveAIMoveSetting(_id, _isOpen)
    local aiDatas = LoadAIMoveSetting()
    aiDatas[_id] = _isOpen
    FileUtil.SaveToFile("AIMoveState.txt", aiDatas)
end

-- 本地读取
function LoadAIMoveSetting()
    local aiDatas = FileUtil.LoadByPath("AIMoveState.txt")
    return aiDatas and aiDatas or {}
end

--清除上一个选中物体
function ClearLastItem()
    lastItem = nil
end

function OnClickMap()
    if selItem ~= nil then
        if cfgDungeon then
            ShowDetails(cfgDungeon.map, DungeonDetailsType.Map);
        end
    end
end

function OnClickEnemy()
    if selItem ~= nil then
        local list = {};
        if cfgDungeon and cfgDungeon.enemyPreview then
            for k, v in ipairs(cfgDungeon.enemyPreview) do
                local cfg = Cfgs.CardData:GetByID(v);
                table.insert(list, {
                    id = v,
                    isBoss = k == 1
                });
            end
        end
        CSAPI.OpenView("FightEnemyInfo", list);
    end
end

function OnClickOutput()
    if selItem ~= nil then
        ShowDetails(cfgDungeon, DungeonDetailsType.MainLineOutPut);
    end
end

function ShowDetails(_data, _elseData)
    CSAPI.OpenView("DungeonDetail", {_data, _elseData})
end

function OnClickEnter()
    if (cb) then
        cb()
    end
end

function OnClickSweep()
    OnSweepClick(cfgDungeon)
end

function OnSweepClick(_cfg,_buyFunc)
    if isSweepOpen then
        CSAPI.OpenView("SweepView",{id = _cfg.id},{onBuyFunc = _buyFunc})
    else
        local sweepData = SweepMgr:GetData(_cfg.id)
        if sweepData then
            Tips.ShowTips(sweepData:GetLockStr())
        else
            local cfg = Cfgs.CfgModUpOpenType:GetByID(_cfg.modUpOpenId)
            if cfg then
                Tips.ShowTips(cfg.sDescription)
            end
        end
    end
end

function IsSweepOpen()
    return isSweepOpen
end

function OnClickBack()
    if isDescOpen then
        ShowDesc(false)
    end
    if maskCB then
        maskCB()
    end
    ShowMask(false)
end

function ShowMask(b)
    CSAPI.SetGOActive(backMask, b)
end

function IsCanAIMove()
    return isCanAIMove
end

function IsAIMove()
    return isAIMove
end

function IsShow()
    return isShow
end

function IsOpenAI()
    if cfgDungeon and (cfgDungeon.nGroupID or cfgDungeon.type == eDuplicateType.Tower) then
        return false
    end
    return true
end

function IsMainLine()
    return cfgDungeon and (cfgDungeon.type == eDuplicateType.MainNormal or cfgDungeon.type == eDuplicateType.MainElite)
end

function OnDestroy()
    eventMgr:ClearListener()
end

--------------------------------------------双倍
-- 设置双倍
function ShowDoublePanel()
    if cfgDungeon and cfgDungeon.diff and cfgDungeon.diff == 3 then --危险等级不显示双倍
        DungeonMgr:SetMultiReward(false)
        CSAPI.SetGOActive(doubleObj,false)
        return
    end
    multiUpdateTime = DungeonMgr:GetMultiUpdateTime()
    if multiUpdateTime and TimeUtil:GetTime() < multiUpdateTime then
        isMultiUpdate = false
    end
    -- double		
    local hasMulti = DungeonUtil.HasMultiDesc(sectionData:GetID());
    CSAPI.SetGOActive(doubleObj,hasMulti)
    if not hasMulti then
        return
    end
    local dStr = DungeonUtil.GetMultiDesc2(sectionData:GetID())
    CSAPI.SetText(txtDouble, dStr);

    multiNum = DungeonUtil.GetMultiNum(sectionData:GetID())
    CSAPI.SetGOActive(btnMask, multiNum <= 0)
    if (multiNum > 0) then
        local doubleState = LoadDoubleState(sectionData:GetID())
        if (doubleState) then
            isDoubleOpen = doubleState.type == 1
        end
    else
        isDoubleOpen = false
    end
    SetDoubleState()
end

-- 设置双倍状态
function SetDoubleState()   
    CSAPI.SetGOActive(close,not isDoubleOpen)
    CSAPI.SetGOActive(open,isDoubleOpen)
    DungeonMgr:SetMultiReward(isDoubleOpen)
    SaveDoubleState(sectionData:GetID(), isDoubleOpen and 1 or 0)
end

-- 保存副本双倍状态
function SaveDoubleState(_id, _type)
    if (_id > 0) then
        local _data = LoadDoubleState(_id) or {}
        _data.id = _id
        _data.type = _type
        FileUtil.SaveToFile("doubleState_" .. _id .. ".txt", _data)
    end
end

-- 读取副本双倍状态
function LoadDoubleState(_id)
    return FileUtil.LoadByPath("doubleState_" .. _id .. ".txt")
end

function ShowDouble(b)
    isDoubleOpen = b
    SetDoubleState()
end

function IsDouble()
    return isDoubleOpen
end

function GetMultiNum()
    return multiNum
end

function OnClickDouble()
    isDoubleOpen = not isDoubleOpen
    if multiNum < 1 then
        LanguageMgr:ShowTips(8016)
        isDoubleOpen = false
    end
    SetDoubleState()
end

function ShowDesc(b)
    isDescOpen = true
    CSAPI.SetGOActive(descObj,b)
end

function OnClickDesc()
    ShowMask(true)
    ShowDesc(true)
end
--------------------------------------------危险难度
function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    item.Refresh(_data)
    item.SetSelect(index == currLevel)
end

function OnClickItem(index)
    layout:MoveToCenter(index)
end

function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= currLevel then
        local item = layout:GetItemLua(currLevel)
        if item then
            item.SetSelect(false)
        end
        currLevel = index + 1
        local item = layout:GetItemLua(currLevel)
        if (item) then
            item.SetSelect(true);
        end
        SetArrows()
        CSAPI.SetGOActive(tipImg, currLevel == 1)
        CSAPI.SetGOActive(txt_tip, currLevel == 1)
        if curDatas then
            cfgDungeon = curDatas[currLevel]
            Refresh()
        end
    end
    svUtil:Update()
end

function SetArrows()
    CSAPI.SetGOActive(btnFirst,currLevel ~= 1)
    CSAPI.SetGOActive(btnLast,currLevel ~= #curDatas)
end

function ShowDangeLevel(isDanger,cfgs,currDanger)
    currLevel = currDanger or currLevel
    CSAPI.SetGOActive(dangerObj, isDanger)
    CSAPI.SetGOActive(outputObj, not isDanger)
    if isDanger and cfgs then
        curDatas = cfgs
        svUtil:Init(layout, #curDatas, {100, 100}, 5, 0.1, 0.58)
        layout:IEShowList(#curDatas, nil, currLevel)
        SetArrows()
        CSAPI.SetGOActive(tipImg, currLevel == 1)
        CSAPI.SetGOActive(txt_tip, currLevel == 1)
        if curDatas then
            cfgDungeon = curDatas[currLevel]
            Refresh()
        end
    end
end

function GetCurrDanger()
    return currLevel
end

function OnClickLast()
    if (currLevel ~= #curDatas) then
        layout:MoveToCenter(#curDatas)
    end
end

function OnClickFirst()
    if (currLevel ~= 1) then
        layout:MoveToCenter(1)
    end
end

function GetCurrLevel()
    return currLevel
end

--------------------------------------------动画
function SetIsActive(b)
    isActive = b
end

function ShowAnim()
    if isActive then
        CSAPI.SetGOActive(enterAnim,false)
        CSAPI.SetGOActive(enterAnim,true)
    end
end

function SetPos(isShow)
    local pos = isShow and enterPos or outPos
    CSAPI.SetLocalPos(childNode, pos[1], pos[2], pos[3])
end