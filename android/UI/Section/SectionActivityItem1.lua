local data = nil
local canvasGroup = nil
local isLock = false
local lockStr = ""
local openInfo = nil
local currState = 0
local sectionData = nil
local enterCB = nil
local cb = nil
local itemX = 0
local isSelect = false
local isNew = false
-- time 
local time = 0
local timer = 0
-- 爬塔
local isTower = false
local resetTime = 0
-- 爬塔
local isNewTower = false
local towerResetTime = 0
-- rogue
local isRogue = false
local rogueTime = 0
-- 深塔计划
local isTowerDeep = false
local towerDeepTime = 0
-- 十二星宫
local isTotal = false
local totalTime = 0
local sliderTotal = nil
-- 世界boss
local isGlobalBoss = false
local globalBossTime = 0
-- 递归沙盒
local isMultTeamBattle = false
local globalMTBTime = 0
local globalMTBTime2 = 0;
-- 副本活动
local isAcitvity = false
local activityTime = 0
local activityTime2 = 0
-- 动效
local textRand = nil
local lastSelect = false

function SetIndex(idx)
    index = idx
end

function SetEnterCB(_cb)
    enterCB = _cb
end

function SetClickCB(_cb)
    cb = _cb
end

function Awake()
    canvasGroup = ComUtil.GetCom(node, "CanvasGroup")
    textRand = ComUtil.GetCom(action, "ActionTextRand")
    sliderTotal = ComUtil.GetCom(totalSlider, "Slider")

    CSAPI.SetGOActive(selectObj, false)
end

function Refresh(_data, elseData)
    data = _data
    SetEnterCB(elseData)
    if data then
        sectionData = data.data
        currState = sectionData:GetOpenState()
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        SetBG()
        SetTower()
        SetNewTower()
        SetTotalBattle()
        SetRogue()
        SetGlobalBoss()
        SetMultTeamBattle();
        SetTowerDeep()
        SetActivity()
        SetTitle()
        SetLock()
        isNew = DungeonActivityMgr:GetIsNew(sectionData:GetID())
        SetNew()
        SetRed()
    end
    itemX = CSAPI.GetAnchor(gameObject)
end

function Update()
    if timer < Time.time then
        timer = Time.time + 1
        UpdateTime()
    end
end

function SetBG()
    local name = sectionData:GetSectionBG()
    if name and name ~= "" then
        ResUtil:LoadBigImg(bg, "UIs/SectionImg/aBg1/" .. name)
    end
end

function SetTitle()
    CSAPI.SetText(txtTitle1, data.chaperName)
    CSAPI.SetText(txtTitle2, sectionData:GetEName())
    textRand.targetStr = sectionData and sectionData:GetEName() or ""
end

function SetLock()
    isLock = currState < 1
    _, lockStr = sectionData:GetOpen()
    SetLockPanel(isLock, lockStr)
end

function SetLockPanel(b, str)
    canvasGroup.alpha = b and 0.3 or 1
    CSAPI.SetGOActive(lockImg, b)
    CSAPI.SetGOActive(lockObj, b)
    CSAPI.SetGOActive(unLockImg, not b)
    CSAPI.SetText(txtLock, str)
end

function SetNew()
    UIUtil:SetNewPoint(redParent, isNew)
end

function SetRed()
    if not isNew then
        UIUtil:SetRedPoint(redParent, DungeonActivityMgr:CheckRed(sectionData:GetID()))
    end
end

function GetData()
    return data
end

function GetSectionData()
    return sectionData
end

function GetID()
    return sectionData and sectionData:GetID()
end

function GetOpen()
    return currState == 1
end

function GetItemX()
    return itemX
end

function OnClick()
    if isNew then
        isNew = false
        DungeonActivityMgr:SetNew(sectionData:GetID())
        SetNew()
        SetRed()
        RedPointMgr:ApplyRefresh()
    end
    if globalBossTime > 0 then
        Tips.ShowTips(lockStr)
        return
    end
    if cb then
        cb(this)
    end
end

-------------------------------------------时间
function UpdateTime()
    if isTower then
        UpdateTower()
    elseif isNewTower then
        UpdateNewTower()
    elseif isRogue then
        UpdateRogue()
    elseif isTotal then
        UpdateTotalBattle()
    elseif isGlobalBoss then
        UpdateGlobalBoss()
    elseif isMultTeamBattle then
        UpdateMultTeamBattle();
    elseif isTowerDeep then
        UpdateTowerDeep()
    elseif isAcitvity then
        UpdateAcitivty()
    end
end
-------------------------------------------爬塔
function SetTower()
    isTower = data.type == SectionActivityType.Tower
    CSAPI.SetGOActive(towerObj, isTower)
    if isTower then
        ResUtil.IconGoods:Load(icon, ITEM_ID.BIND_DIAMOND, true)
        CSAPI.SetScale(icon, 0.43, 0.43, 1)

        local info = DungeonMgr:GetTowerData()
        RefreshTower(info)
    end
end

function RefreshTower(info)
    if info then
        CSAPI.SetText(txtTowerCur, info.cur .. "")
        CSAPI.SetText(txtTowerMax, info.max .. "")
        -- time
        resetTime = info.resetTime
        timer = 0
    end
end

function UpdateTower()
    if TimeUtil:GetTime() > resetTime then
        local info = DungeonMgr:GetTowerData()
        if info then
            info = DungeonMgr:AddTowerCur(-info.cur)
            RefreshTower(info)
        end
        resetTime = resetTime + 604800 -- 7天秒数
        timer = 0
    end

    if (resetTime >= 0) then
        local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
        local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
        local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
        local min = timeTab.minute > 0 and timeTab.minute .. LanguageMgr:GetByID(11011) or ""
        LanguageMgr:SetText(txtTowerTime, 36006, day .. hour .. min)
    end
end

function IsTower()
    return isTower
end
-------------------------------------------新爬塔
function SetNewTower()
    isNewTower = data.type == SectionActivityType.NewTower
    CSAPI.SetGOActive(towerObj2, isNewTower)
    if isNewTower then
        RefreshNewTower()
    end
end

function RefreshNewTower()
    if openInfo then
        towerResetTime = openInfo:GetEndTime()
    end
    local tab = TowerMgr:GetCounts()
    tab[1] = tab[1] or {}
    CSAPI.SetText(txtTowerNol1, "/" .. (tab[1].max or 0))
    CSAPI.SetText(txtTowerNol2, (tab[1].cur or 0) .. "")
    tab[2] = tab[2] or {}
    CSAPI.SetText(txtTowerHard1, "/" .. (tab[2].max or 0))
    CSAPI.SetText(txtTowerHard2, (tab[2].cur or 0) .. "")
end

function UpdateNewTower()
    if isNewTower then
        if TimeUtil:GetTime() > towerResetTime then
            return
        end

        if (towerResetTime >= 0) then
            towerTimer = Time.time + 1
            local timeTab = TimeUtil:GetDiffHMS(towerResetTime, TimeUtil:GetTime())
            local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
            local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
            local min = timeTab.minute > 0 and timeTab.minute .. LanguageMgr:GetByID(11011) or ""
            LanguageMgr:SetText(txtTowerTime2, 49032, day .. hour .. min)
        end
    end
end
-------------------------------------------十二星宫
function SetTotalBattle()
    isTotal = data.type == SectionActivityType.TotalBattle and TotalBattleMgr:IsFighting()
    CSAPI.SetGOActive(totalObj, isTotal)
    if isTotal then
        local fightInfo = TotalBattleMgr:GetFightInfo()
        if fightInfo then
            local cfg = Cfgs.MainLine:GetByID(fightInfo.id)
            if cfg then
                local sectionData = DungeonMgr:GetSectionData(cfg.group)
                CSAPI.SetText(txtTotalName, sectionData:GetName())
                local max = cfg.hp or 1
                local cur = TotalBattleMgr:GetFightBossHp() or 0
                sliderTotal.value = cur / max
                CSAPI.SetText(txtTotalNum, cur .. "/" .. max)
                totalTime = TotalBattleMgr:GetFightTime()
                if totalTime <= 0 then
                    CSAPI.SetGOActive(totalObj, false)
                end
            end
        end
    end
end

function UpdateTotalBattle()
    if (totalTime > 0) then
        totalTimer = Time.time + 1
        totalTime = TotalBattleMgr:GetFightTime()
        local timeData = TimeUtil:GetTimeTab(totalTime)
        local day = timeData[1] > 0 and timeData[1] .. LanguageMgr:GetByID(11010) or ""
        local hour = timeData[2] > 0 and timeData[2] .. LanguageMgr:GetByID(11009) or ""
        local min = timeData[3] > 0 and timeData[3] .. LanguageMgr:GetByID(11011) or ""
        LanguageMgr:SetText(txtTotalTime, 49032, day .. hour .. min)
        if totalTime <= 0 then
            CSAPI.SetGOActive(totalObj, false)
        end
    end
end
-------------------------------------------乱序演习
function SetRogue()
    isRogue = data.type == SectionActivityType.Rogue
    CSAPI.SetGOActive(rogueObj, isRogue)
    rogueTime = RogueMgr:GetRogueTime()
    if rogueTime <= 0 then
        CSAPI.SetGOActive(rogueObj, false)
    end
end

function UpdateRogue()
    if (rogueTime > 0) then
        rogueTime = RogueMgr:GetRogueTime()
        local timeData = TimeUtil:GetTimeTab(rogueTime)
        LanguageMgr:SetText(txtRogueTime, 50001, timeData[1], timeData[2], timeData[3])
        if rogueTime <= 0 then
            CSAPI.SetGOActive(rogueObj, false)
        end
    end
end
-------------------------------------------深塔计划
function SetTowerDeep()
    isTowerDeep = data.type == SectionActivityType.TowerDeep
    CSAPI.SetGOActive(rogueObj, isTowerDeep)
    if isTowerDeep then
        towerDeepTime = openInfo and openInfo:GetEndTime() - TimeUtil:GetTime() or 0
        if towerDeepTime <= 0 then
            CSAPI.SetGOActive(rogueObj, false)
        end
    end
end

function UpdateTowerDeep()
    if (towerDeepTime > 0) then
        towerDeepTime = openInfo:GetEndTime() - TimeUtil:GetTime()
        local timeData = TimeUtil:GetTimeTab(towerDeepTime)
        LanguageMgr:SetText(txtRogueTime, 77032, timeData[1], timeData[2], timeData[3])
        if towerDeepTime <= 0 then
            CSAPI.SetGOActive(rogueObj, false)
        end
    end
end
-------------------------------------------递归沙盒
function SetMultTeamBattle()
    isMultTeamBattle = data.type == SectionActivityType.MultTeamBattle
    CSAPI.SetGOActive(mtbObj, isMultTeamBattle)
    if isMultTeamBattle then
        local curMTBData = MultTeamBattleMgr:GetCurData();
        if curMTBData then
            local state = curMTBData:GetActivityState();
            if state ~= MultTeamActivityState.Over then
                globalMTBTime = curMTBData:GetEndTime()
                globalMTBTime2 = globalMTBTime - TimeUtil:GetTime();
            end
        end
        if globalMTBTime <= 0 then
            CSAPI.SetGOActive(mtbObj, false)
        end
    end
end

function UpdateMultTeamBattle()
    if (globalMTBTime2 > 0) then
        globalMTBTime2 = globalMTBTime - TimeUtil:GetTime();
        local timeData = TimeUtil:GetTimeTab(globalMTBTime2)
        LanguageMgr:SetText(txtMTBTime, 77032, timeData[1], timeData[2], timeData[3])
        if globalMTBTime2 <= 0 then
            CSAPI.SetGOActive(mtbObj, false)
        end
    end
end

-------------------------------------------世界boss
function SetGlobalBoss()
    isGlobalBoss = data.type == SectionActivityType.GlobalBoss
    if isGlobalBoss then
        if GlobalBossMgr:IsClose() then
            globalBossTime = GlobalBossMgr:GetCloseTime()
            if not isLock then
                SetLockPanel(true, GlobalBossMgr:GetCloseDesc())
                lockStr = GlobalBossMgr:GetCloseDesc()
            end
        end
    end
end

function UpdateGlobalBoss()
    if (globalBossTime > 0) then
        globalBossTime = GlobalBossMgr:GetCloseTime()
        if globalBossTime <= 0 then
            if not isLock then
                SetLockPanel(false, "")
                DungeonMgr:CheckRedPointData()
            end
        end
    end
end
-------------------------------------------副本活动
function SetActivity()
    isAcitvity = IsActivity()
    CSAPI.SetGOActive(activityObj, isAcitvity)
    if isAcitvity then
        local openInfo = sectionData:GetOpenInfo()
        if openInfo then
            activityTime = openInfo:GetDungeonEndTime() - TimeUtil:GetTime()
            activityTime2 = openInfo:GetEndTime() - TimeUtil:GetTime()
        end
    end
end

function IsActivity()
    local b = false
    if data.type == SectionActivityType.Plot or data.type == SectionActivityType.TaoFa or data.type ==
        SectionActivityType.TotalBattle  then
        b = true
    end
    if sectionData and sectionData:IsResident() then
        b = false
    end
    return b
end

function UpdateAcitivty()
    if (activityTime > 0 or activityTime2 > 0) then
        activityTime = openInfo:GetDungeonEndTime() - TimeUtil:GetTime()
        activityTime2 = openInfo:GetEndTime() - TimeUtil:GetTime()
        local timeTab = TimeUtil:GetTimeTab(activityTime > 0 and activityTime or activityTime2)
        LanguageMgr:SetText(txtActivityTime, activityTime > 0 and 36014 or 36015, timeTab[1], timeTab[2], timeTab[3])
        if activityTime2 <= 0 then
            CSAPI.SetGOActive(activityObj, false)
            EventMgr.Dispatch(EventType.Activity_Open_State)
        end
    end
end

------------------------------------动效----------------------------------------

function PlayAnim()
    textRand:Play()
end

function SetScale(value)
    CSAPI.SetScale(node, value, value, 1)
    CSAPI.SetScale(lockObj, value, value, 1)
end

function SetSelect(b)
    if lastSelect ~= b then
        lastSelect = b
        CSAPI.SetGOActive(selectObj, b)
    end
end

function ShowDowm(isShow, isSel)
    CSAPI.SetGOActive(downObj, isShow)
    CSAPI.SetGOActive(selImg, isSel)
end
