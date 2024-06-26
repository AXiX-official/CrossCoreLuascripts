local cfg = nil
local data = nil
local sectionData = nil
local isSweepOpen = false
local buyFunc = nil

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Sweep_Show_Panel, ShowSweep)
    eventMgr:AddListener(EventType.Player_HotChange, ShowCost)
    eventMgr:AddListener(EventType.Bag_Update, ShowCost)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Refresh(tab)
    cfg = tab.cfg
    data = tab.data
    sectionData = tab.sectionData
    if cfg then
        ShowCost()
        ShowSweep()
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
            ResUtil.IconGoods:Load(costImg, ITEM_ID.Hot .. "_3")
            local costNum = cfg.enterCostHot and cfg.enterCostHot or 0
            costNum = cfg.winCostHot and costNum + cfg.winCostHot or costNum
            costNum = StringUtil:SetByColor(costNum .. "", math.abs(costNum) <= PlayerClient:Hot() and "191919" or "CD333E")
            CSAPI.SetText(cost," " .. costNum)
            LanguageMgr:SetText(txt_cost, 15004)
        end
    end
end

--扫荡状态
function ShowSweep()
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