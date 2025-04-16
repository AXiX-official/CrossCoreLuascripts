local cfg = nil
local data = nil
local sectionData = nil
local isSweepOpen = false
local buyFunc = nil

local time = 0
local timer = 0
local hotTime = 0

local openViewKey = nil
local isHide = false


function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Sweep_Show_Panel, ShowSweep)
    eventMgr:AddListener(EventType.Player_HotChange, ShowCost)
    eventMgr:AddListener(EventType.Bag_Update, function ()
        ShowCost()
        ShowTicket()
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
    eventMgr:AddListener(EventType.View_Lua_Opened,OnViewOpened)
end

function OnViewClosed(viewKey)
    if viewKey ~= "Dungeon" and viewKey ~= "SpecialGuide" and openViewKey == viewKey  then
        ShowSpecialGuide()
        openViewKey = nil
    end
end

function OnViewOpened(viewKey)
    if viewKey ~= "Dungeon" and viewKey ~= "SpecialGuide" and openViewKey == nil  then
        SpecialGuideMgr:StopAll()
        openViewKey = viewKey
    end
end

function OnDestroy()
    SpecialGuideMgr:CloseView()
    eventMgr:ClearListener()
end

function Update()
    UpdateSpecialGuide()

    if time > 0 and timer < Time.time then
        timer = Time.time + 1
        time = hotTime - TimeUtil:GetTime()
        if time <= 0 then
            ShowHotChange(false)
        end
    end
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowCost()
        ShowSweep()
        ShowTicket()
        ShowSpecialGuide()
    end
end

function ShowCost()
    if cfg then
        local _cost = DungeonUtil.GetCost(cfg)
        if _cost~=nil then
            local cur = BagMgr:GetCount(_cost[1])
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
            local costNum,isHotChange = DungeonUtil.GetHot(cfg)
            ShowHotChange(isHotChange)
            costNum = StringUtil:SetByColor(costNum .. "", math.abs(costNum) <= PlayerClient:Hot() and "191919" or "CD333E")
            CSAPI.SetText(cost," " .. costNum)
        end
    end
end

function ShowHotChange(b)
    local info =sectionData:GetInfo()
    local isHide = info and info.isHideExtre ~= nil
    UIUtil:SetHotPoint(btnEnter,b and not isHide,170,51)
    if b then
        _,hotTime = DungeonUtil.GetHotChangeTime()
        if hotTime > 0  then
            time = hotTime - TimeUtil:GetTime()
            timer = 0
        end
    end
end

--扫荡状态
function ShowSweep()
    if cfg == nil then
        return
    end
    if cfg.diff and cfg.diff == 3 then
        CSAPI.SetGOActive(btnSweep,false)
        CSAPI.SetAnchor(btnEnter,0,58)
        return  
    end
    CSAPI.SetGOActive(btnSweep,cfg.modUpCnt ~= nil)
    if cfg.modUpCnt == nil then
        CSAPI.SetAnchor(btnEnter,0,58)
        return
    end
    CSAPI.SetAnchor(btnEnter,59,58)
    isSweepOpen = false
    local sweepData = SweepMgr:GetData(cfg.id)
    if sweepData then
        isSweepOpen = sweepData:IsOpen()
    end 
    CSAPI.SetGOActive(sweepLock,not isSweepOpen)
    CSAPI.SetImgColor(sweepImg,255,255,255,isSweepOpen and 255 or 76)
end

function ShowTicket()
    local _cost = DungeonUtil.GetCost(cfg)
    CSAPI.SetGOActive(ticketObj, _cost~=nil)
    if not IsNil(gameObject) and gameObject.activeSelf then
        CSAPI.SetRTSize(gameObject,589, _cost~=nil and 149 or 116)
    end
    if _cost~=nil then
        local cur = BagMgr:GetCount(_cost[1]) or 0
        CSAPI.SetText(txtTicket,cur .. "")
        ResUtil.IconGoods:Load(ticketIcon, _cost[1] .. "_1")
    end
end

function OnClickEnter()
    OnEnterClick()
end

function OnEnterClick()
    if cfg and cfg.arrForceTeam ~= nil then -- 强制上阵编队
        CSAPI.OpenView("TeamForceConfirm", {
            dungeonId = cfg.id,
            teamNum = cfg.teamNum or 1
        })
    else
        CSAPI.OpenView("TeamConfirm", { -- 正常上阵
            dungeonId = cfg.id,
            teamNum = cfg.teamNum or 1
        }, TeamConfirmOpenType.Dungeon)
    end
end

function SetBuyFunc(_func)
    buyFunc = _func
end

function OnClickSweep()
    local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end

    if isSweepOpen then
        CSAPI.OpenView("SweepView",{id = cfg.id},{onBuyFunc = buyFunc})
    else
        local sweepData = SweepMgr:GetData(cfg.id)
        if sweepData then
            Tips.ShowTips(sweepData:GetLockStr())
        else
            local cfg = Cfgs.CfgModUpOpenType:GetByID(cfg.modUpOpenId)
            if cfg then
                Tips.ShowTips(cfg.sDescription)
            end
        end
    end
end

function IsSweepOpen()
    return isSweepOpen
end

-------------------------------------特殊引导-------------------------------------
function ShowSpecialGuide()
    if not IsMainLine() then return end
    SpecialGuideMgr:TryCallFunc("Dungeon","Start")
end

function StopSpecialGuide()
    if not IsMainLine() then return end
    SpecialGuideMgr:TryCallFunc("Dungeon","Stop")
end

function FinishSpecialGuide()
    if not IsMainLine() then return end
    SpecialGuideMgr:TryCallFunc("Dungeon","Finish")
end

function UpdateSpecialGuide()
    if not IsMainLine() then return end

    if (CS.UnityEngine.Input.GetMouseButton(0)) then
        SpecialGuideMgr:TryCallFunc("Dungeon","Start")
    end

    SpecialGuideMgr:Update()
end

function IsMainLine()
   return sectionData:GetSectionType() == SectionType.MainLine
end
