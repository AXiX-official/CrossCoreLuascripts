local data = nil
local canvasGroup = nil
local isLock = false
local openInfo = nil
local currState = 0
local lastState = 0
local sectionData = nil
local enterCB = nil
local cb = nil
local itemX = 0
local isSelect = false

-- 爬塔
local isTower = false
local resetTime = 0

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
        SetTitle()
        SetLock()
        SetRed()
    end

    itemX = CSAPI.GetAnchor(gameObject)
end

function Update()
    if isTower then
        UpdateTower()
    else
        -- UpdateActivity()
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
    -- CSAPI.SetText(txtTitle2,data:GetEName())
    textRand.targetStr = sectionData and sectionData:GetEName() or ""
end

function SetLock()
    local isLock = currState < 1
    canvasGroup.alpha = isLock and 0.3 or 1
    CSAPI.SetGOActive(lockImg, isLock)
    CSAPI.SetGOActive(lockObj, isLock)
    CSAPI.SetGOActive(unLockImg, not isLock)

    local _, lockStr = sectionData:GetOpen()
    CSAPI.SetText(txtLock, lockStr)
end

function SetRed()
    local type = data.type
    local isRed = false
    if type and currState > 0 then
        if type == SectionActivityType.Tower then
            isRed = MissionMgr:CheckRed({eTaskType.TmpDupTower,eTaskType.DupTower})
        elseif type == SectionActivityType.Plot then
            isRed = MissionMgr:CheckRed({eTaskType.Story})
        elseif type == SectionActivityType.TaoFa then
            isRed = MissionMgr:CheckRed({eTaskType.DupTaoFa})
        end
    end
    UIUtil:SetRedPoint(redParent, isRed, 0, 0)
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
    end
end

function UpdateTower()
    if isTower then
        if TimeUtil:GetTime() > resetTime then
            local info = DungeonMgr:GetTowerData()
            info = DungeonMgr:AddTowerCur(-info.cur)
            RefreshTower(info)
            resetTime = resetTime + 604800 -- 7天秒数
        end

        if (resetTime >= 0) then
            local timeTab = TimeUtil:GetDiffHMS(resetTime, TimeUtil:GetTime())
            local day = timeTab.day > 0 and timeTab.day .. LanguageMgr:GetByID(11010) or ""
            local hour = timeTab.hour > 0 and timeTab.hour .. LanguageMgr:GetByID(11009) or ""
            local min = timeTab.minute > 0 and timeTab.minute .. LanguageMgr:GetByID(11011) or ""
            LanguageMgr:SetText(txtTowerTime, 36006, day .. hour .. min)
        end
    end
end

function IsTower()
    return isTower
end

------------------------------------动效----------------------------------------

function PlayAnim()
    textRand:Play()
end

function SetScale(value)
    CSAPI.SetScale(node, value, value, 1)
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
