local data = nil
local canvasGroup = nil
local isLock = false
local lockStr = ""
local openInfo = nil
local currState = 0
local lastState = 0
local sectionData = nil
local enterCB = nil
local cb = nil
local itemX = 0
local isSelect = false
local isNew = false

-- 爬塔
local isTower = false
local resetTime = 0
local timer = 0

-- 爬塔
local isNewTower = false
local towerResetTime = 0
local towerTimer = 0

-- rogue
local isRogue = false
local rogueTimer = 0
local rogueTime = 0

-- 十二星宫
local isTotal = false
local totalTimer = 0
local totalTime = 0
local sliderTotal = nil

--世界boss
local isGlobalBoss = false
local globalBossTimer = 0
local globalBossTime = 0

--递归沙盒
local isMultTeamBattle = false
local globalMTBTimer = 0
local globalMTBTime = 0
local globalMTBTime2=0;

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
        lastState = currState
        SetBG()
        SetTower()
        SetNewTower()
        SetTotalBattle()
        SetRogue()
        SetTitle()
        SetLock()
        isNew = DungeonActivityMgr:GetIsNew(sectionData:GetID())
        SetNew()
        SetRed()
        SetGlobalBoss()
        SetMultTeamBattle();
    end

    itemX = CSAPI.GetAnchor(gameObject)
end

function Update()
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
    CSAPI.SetText(txtTitle2,sectionData:GetEName())
    textRand.targetStr = sectionData and sectionData:GetEName() or ""
end

function SetLock()
    isLock = currState < 1
    _, lockStr = sectionData:GetOpen()
    SetLockPanel(isLock,lockStr)
end

function SetLockPanel(b,str)
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
-------------------------------------------活动
function UpdateActivity()
    if sectionData then
        local currState = sectionData:GetOpen() and 1 or 0
        if currState ~= lastState then
            lastState = currState
            EventMgr.Dispatch(EventType.Activity_Open_State)
        end
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
    if isTower then
        if TimeUtil:GetTime() > resetTime then
            local info = DungeonMgr:GetTowerData()
            if info then
                info = DungeonMgr:AddTowerCur(-info.cur)
                RefreshTower(info)
            end
            resetTime = resetTime + 604800 -- 7天秒数
            timer = 0
        end

        if (resetTime >= 0 and Time.time > timer) then
            timer = Time.time + 1
            local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
            local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
            local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
            local min = timeTab.minute > 0 and timeTab.minute .. LanguageMgr:GetByID(11011) or ""
            LanguageMgr:SetText(txtTowerTime,36006 , day .. hour .. min)
        end
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
        openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        RefreshNewTower()
    end
end

function RefreshNewTower()
    if openInfo then
        towerResetTime = openInfo:GetEndTime()
        towerTimer = 0
    end
    local tab = TowerMgr:GetCounts()
    tab[1] = tab[1] or {}
    CSAPI.SetText(txtTowerNol1,"/" .. (tab[1].max or 0))
    CSAPI.SetText(txtTowerNol2,(tab[1].cur or 0) .. "")
    tab[2] = tab[2] or {}
    CSAPI.SetText(txtTowerHard1,"/" .. (tab[2].max or 0))
    CSAPI.SetText(txtTowerHard2,(tab[2].cur or 0) .. "")
end

function UpdateNewTower()
    if isNewTower then
        if TimeUtil:GetTime() > towerResetTime then
            return
        end

        if (towerResetTime >= 0 and Time.time > towerTimer) then
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
                CSAPI.SetText(txtTotalName,sectionData:GetName())
                local max= cfg.hp or 1
                local cur =TotalBattleMgr:GetFightBossHp() or 0
                sliderTotal.value = cur/max
                CSAPI.SetText(txtTotalNum,cur.."/"..max)
                totalTime = TotalBattleMgr:GetFightTime()
                totalTimer = 0
                if totalTime <= 0 then
                    CSAPI.SetGOActive(totalObj, false)
                end
            end
        end
    end
end

function UpdateTotalBattle()
    if (totalTime > 0 and Time.time > totalTimer) then
        totalTimer = Time.time + 1
        totalTime = TotalBattleMgr:GetFightTime()
        local timeData = TimeUtil:GetTimeTab(totalTime)
        local day = timeData[1] > 0 and timeData[1] .. LanguageMgr:GetByID(11010) or ""
        local hour = timeData[2] > 0 and timeData[2] .. LanguageMgr:GetByID(11009) or ""
        local min = timeData[3] > 0 and timeData[3] .. LanguageMgr:GetByID(11011) or ""
        LanguageMgr:SetText(txtTotalTime, 49032, day .. hour .. min)
        if totalTime <= 0 then
            CSAPI.SetGOActive(totalObj,false)
        end
    end
end
-------------------------------------------乱序演习
function SetRogue()
    isRogue = data.type == SectionActivityType.Rogue
    CSAPI.SetGOActive(rogueObj,isRogue)
    rogueTimer = 0
    rogueTime = RogueMgr:GetRogueTime()
    if rogueTime <= 0 then
        CSAPI.SetGOActive(rogueObj,false)
    end
end

function UpdateRogue()
    if (rogueTime > 0 and Time.time > rogueTimer) then
        rogueTimer = Time.time + 1
        rogueTime = RogueMgr:GetRogueTime()
        local timeData = TimeUtil:GetTimeTab(rogueTime)
        LanguageMgr:SetText(txtRogueTime, 50001, timeData[1], timeData[2], timeData[3])
        if rogueTime <= 0 then
            CSAPI.SetGOActive(rogueObj,false)
        end
    end
end
-------------------------------------------递归沙盒

function SetMultTeamBattle()
    isMultTeamBattle = data.type == SectionActivityType.MultTeamBattle
    CSAPI.SetGOActive(mtbObj,isMultTeamBattle)
    if isMultTeamBattle then
        globalMTBTimer = 0
        local curMTBData=MultTeamBattleMgr:GetCurData();
        if curMTBData then
            local state=curMTBData:GetActivityState();
            if state~=MultTeamActivityState.Over then
                globalMTBTime = curMTBData:GetEndTime()
                globalMTBTime2 = globalMTBTime-TimeUtil:GetTime();
            end
        end
        if globalMTBTime <= 0 then
            CSAPI.SetGOActive(mtbObj,false)
        end
    end
end

function UpdateMultTeamBattle()
    if (globalMTBTime2 > 0 and Time.time > globalMTBTimer) then
        globalMTBTimer = Time.time + 1
        globalMTBTime2 = globalMTBTime-TimeUtil:GetTime();
        local timeData = TimeUtil:GetTimeTab(globalMTBTime2)
        LanguageMgr:SetText(txtMTBTime, 77032, timeData[1], timeData[2], timeData[3])
        if globalMTBTime2 <= 0 then
            CSAPI.SetGOActive(mtbObj,false)
        end
    end
end

-------------------------------------------世界boss
function SetGlobalBoss()
    isGlobalBoss = data.type == SectionActivityType.GlobalBoss
    if isGlobalBoss then
        globalBossTimer = 0
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
    if (globalBossTime > 0 and Time.time > globalBossTimer) then
        globalBossTimer = Time.time + 1
        globalBossTime = GlobalBossMgr:GetCloseTime()
        if globalBossTime <= 0 then
            if not isLock then
                SetLockPanel(false, "")
                DungeonMgr:CheckRedPointData()
            end
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
