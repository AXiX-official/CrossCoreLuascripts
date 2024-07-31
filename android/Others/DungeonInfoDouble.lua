local cfg = nil
local data = nil
local sectionData = nil
local multiUpdateTime = 0
local isMultiUpdate = false
local isDoubleOpen = false
local multiNum = 0

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Dungeon_DailyData_Update, OnDailyDataUpdate)

    ShowMask(false)
    ShowDesc(false)
end

function OnDailyDataUpdate()
    ShowDoublePanel()
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

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowDoublePanel()
    end
end

function ShowDoublePanel()
    multiUpdateTime = DungeonMgr:GetMultiUpdateTime()
    if multiUpdateTime and TimeUtil:GetTime() < multiUpdateTime then
        isMultiUpdate = false
    end
    -- double		
    local hasMulti = DungeonUtil.HasMultiDesc(sectionData:GetID());
    CSAPI.SetGOActive(gameObject,hasMulti)
    if not hasMulti then
        return
    end
    local dStr = DungeonUtil.GetMultiDesc(sectionData:GetID())
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

function ShowMask(b)
    CSAPI.SetGOActive(doubleMask,b)
end

function OnClickDesc()
    ShowMask(true)
    ShowDesc(true)
end

function OnClickBack()
    ShowMask(false)
    ShowDesc(false)
end

function SetPos(x,y)
    CSAPI.SetAnchor(doubleObj,x,y)
end

function SetIsCanvas(b)
    CSAPI.SetScriptEnable(doubleMask,"Canvas",b)
    CSAPI.SetScriptEnable(descObj,"Canvas",b)
end