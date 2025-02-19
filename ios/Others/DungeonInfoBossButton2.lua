local cfg = nil
local data = nil
local sectionData = nil

local time = 0
local timer = 0

function Update()
    if time > 0 and Time.time > timer then
        timer = Time.time + 1
        time = GlobalBossMgr:GetActiveTime()
        if time <= 0 then
            SetButtonState()
        end
    end
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        SetTime()
        SetButtonState()
        SetCount()
    end
end

function SetTime()
    time = GlobalBossMgr:GetActiveTime()
end

function SetButtonState()
    LanguageMgr:SetText(txt_title, 70002, ":")
    if (GlobalBossMgr:IsKill() or GlobalBossMgr:GetCount() <= 0 or GlobalBossMgr:GetActiveTime() <= 0) then
        CSAPI.LoadImg(btnEnter, "UIs/GlobalBoss/" .. "btn_01_03" .. ".png", true, nil, true)
    else
        CSAPI.LoadImg(btnEnter, "UIs/GlobalBoss/" .. "btn_01_01" .. ".png", true, nil, true)
    end
end

function SetCount()
    local bossData = GlobalBossMgr:GetData()
    local max = bossData and bossData:GetMaxCount() or 0
    CSAPI.SetText(txtCount, GlobalBossMgr:GetCount() .. "/" .. max)
end

function OnClickDirll()
    if GlobalBossMgr:IsClose() then
        LanguageMgr:ShowTips(47001)
        return
    end
    CSAPI.OpenView("TeamConfirm", { -- 正常上阵
        dungeonId = cfg.id,
        teamNum = cfg.teamNum or 1,
        isNotAssist = true,
        isDirll = true,
        overCB = OnFightOverCB
    }, TeamConfirmOpenType.GlobalBoss)
end

function OnFightOverCB(stage, winer, nDamage)
    DungeonMgr:SetCurrId1(cfg.id)
    FightOverTool.OnGlobalBossDirllOver(stage, winer, nDamage)
end

function OnClickEnter()
    if GlobalBossMgr:IsKill() then
        LanguageMgr:ShowTips(47001)
        return
    end
    if GlobalBossMgr:GetCount() <= 0 then
        LanguageMgr:ShowTips(47002)
        return
    end
    if GlobalBossMgr:GetActiveTime() <= 0 then
        LanguageMgr:ShowTips(47001)
        return
    end
    if GlobalBossMgr:IsClose() then
        LanguageMgr:ShowTips(47001)
        return
    end

    CSAPI.OpenView("TeamConfirm", { -- 正常上阵
        dungeonId = cfg.id,
        teamNum = cfg.teamNum or 1,
        isNotAssist = true
    }, TeamConfirmOpenType.GlobalBoss)
end
