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
-- 每周
local prograssGOs = {}

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

    -- pImg
    local imgGO = ComUtil.GetComInChildren(pImgObj, "Image").gameObject
    table.insert(prograssGOs, imgGO)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Mission_List, OnTowerRefresh)
    eventMgr:AddListener(EventType.Player_HotChange, ShowCost)
    eventMgr:AddListener(EventType.Sweep_Show_Panel, OnRefreshSweep)
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

-- 初始化右侧栏
function InitInfo(_isAnim)
    isAnim = _isAnim
    if isAnim then
        local x, y, z = CSAPI.GetLocalPos(childNode);
        enterPos = {x, y, z}
        outPos = {4000, y, 0};
        CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
    end
    CSAPI.SetGOActive(gameObject, false);
    ShowMask(false)
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
    txtSelDungeonName.text = cfgDungeon.name
    txtSelDungeonNum.text = cfgDungeon.chapterID and cfgDungeon.chapterID .. "" or ""
    -- CSAPI.SetText(selDungeonNum_1, cfgDungeon.chapterID and "STAGE" or "")
    CSAPI.SetText(selDungeonNum_1, cfgDungeon.chapterID and LanguageMgr:GetByID(15124) or "")
    ShowCost()
    local str = cfgDungeon.lvTips ~= nil and cfgDungeon.lvTips or 0
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
end

-- 右边信息栏移动
function PlayInfoMove(isShow)
    if not isAnim then
        CSAPI.SetGOActive(gameObject, isShow);
        if isShow then
            Refresh()
        end
        return
    end
    if isShow then
        CSAPI.SetGOActive(gameObject, true);
        if isInfoShow and selItem ~= lastItem then
            lastItem = selItem
            infoFade:Play(1, 0, 100, 0, function()
                CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
                infoCG.alpha = 1
                PlayMoveAction(childNode, {enterPos[1], enterPos[2], enterPos[3]})
                Refresh()
            end)
        else
            Refresh()
            lastItem = selItem
            infoFade:Play(0, 1)
            PlayMoveAction(childNode, {enterPos[1], enterPos[2], enterPos[3]}, function()
                isInfoShow = true
            end)
        end
    else
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
        local cost = cfgDungeon.enterCostHot and cfgDungeon.enterCostHot or 0
        cost = cfgDungeon.winCostHot and cost + cfgDungeon.winCostHot or cost
        cost = StringUtil:SetByColor(cost .. "", math.abs(cost) <= PlayerClient:Hot() and "191919" or "CD333E")
        txtCost.text = " " .. cost
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
    local sectionData = DungeonMgr:GetSectionData(cfg.group)
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
        local Len = isTower and 1 or 3
        for i = 1, Len do
            if #goGoals >= i then
                -- if cfgDungeon.nGroupID ~= nil and cfgDungeon.nGroupID ~= "" then -- 直接进入战斗的关卡类型
                --     if i == 1 then
                --         goGoals[i].Init(starInfos[i].tips, starInfos[i].isComplete, true, isTower);
                --         CSAPI.SetGOActive(goGoals[i].gameObject, true)
                --     end
                -- else
                CSAPI.SetGOActive(goGoals[i].gameObject, true)
                goGoals[i].Init(starInfos[i].tips, starInfos[i].isComplete);
                -- end
            else
                ResUtil:CreateUIGOAsync("FightTaskItem/FightBigTaskItem", goalTitle, function(go)
                    goGoals = goGoals or {};
                    local item = ComUtil.GetLuaTable(go);
                    -- if cfgDungeon.nGroupID ~= nil and cfgDungeon.nGroupID ~= "" then -- 直接进入战斗的关卡类型
                    --     if i == 1 then
                    --         item.Init(starInfos[i].tips, starInfos[i].isComplete, true, isTower);
                    --     else
                    --         CSAPI.SetGOActive(item.gameObject, false)
                    --     end
                    -- else
                    CSAPI.SetGOActive(item.gameObject, true)
                    item.Init(starInfos[i].tips, starInfos[i].isComplete);
                    -- end
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
    CSAPI.SetImgColor(btnSweep,255,255,255,isSweepOpen and 255 or 76)
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
        local cfgDungeon = selItem.GetCfg();
        if cfgDungeon then
            ShowDetails(cfgDungeon.map, DungeonDetailsType.Map);
        end
    end
end

function OnClickEnemy()
    if selItem ~= nil then
        local cfgDungeon = selItem.GetCfg();
        local list = {};
        if cfgDungeon and cfgDungeon.enemyPreview then
            for k, v in ipairs(cfgDungeon.enemyPreview) do
                local cfg = Cfgs.CardData:GetByID(v);
                table.insert(list, {
                    id = v,
                    -- level = cfgDungeon.previewLv,
                    isBoss = k == 1
                });
            end
        end
        CSAPI.OpenView("FightEnemyInfo", list);
        -- if cfgDungeon and cfgDungeon.enemyPreview then
        --     for k, v in ipairs(cfgDungeon.enemyPreview) do
        --         local cfg = Cfgs.CardData:GetByID(v);
        --         table.insert(list, {
        --             cfg = cfg,
        --             level = cfgDungeon.previewLv,
        --             isBoss = k == 1
        --         });
        --     end
        -- end
        -- ShowDetails(list, DungeonDetailsType.Enemy);
    end
end

function OnClickOutput()
    if selItem ~= nil then
        local cfgDungeon = selItem.GetCfg();
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

function OnSweepClick(_cfg)
    if isSweepOpen then
        CSAPI.OpenView("SweepView",{id = _cfg.id})
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
    if maskCB then
        maskCB()
        ShowMask(false)
    end
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
