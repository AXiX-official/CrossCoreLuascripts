local openInfo = nil
local info = nil
local lastBGM = nil
local isLoading = false
local top = nil
local sectionData = nil
local redPath = nil

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mission_List, function ()
        SetRed(MissionMgr:CheckDungeonActivityRed(data.id))
    end)
    eventMgr:AddListener(EventType.Bag_Update, function()
        CSAPI.SetText(txtNum, BagMgr:GetCount(info.goodsId) .. "")
        SetExploreRed()
    end)

    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.RedPoint_Refresh, SetExploreRed)
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" or viewKey == "ShopView" then
        FuncUtil:Call(function ()
            if gameObject then
                CSAPI.PlayBGM(info.bgm, 1)
            end
        end,this,200)
    end
end

function OnLoadComplete()
    if isLoading then
        FuncUtil:Call(function ()
            if gameObject then
                lastBGM = CSAPI.PlayBGM(info.bgm, 1)
            end
        end,nil,200)
    end
end

function Update()
    if openInfo and not openInfo:IsOpen() then
        openInfo = nil
        LanguageMgr:ShowTips(24001)
        UIUtil:ToHome()   
    end
end

function OnOpen()
    SetBGScale()
    if data then
        sectionData = DungeonMgr:GetSectionData(data.id)
        info = sectionData:GetInfo()
        SetTime()
        SetNum()
        SetSpecial()
        SetRed(MissionMgr:CheckDungeonActivityRed(data.id))
        SetExploreRed()
        if top == nil then
            top = UIUtil:AddTop2(info.view ,topParent, OnClickReturn);
        end
    end

    if openSetting and openSetting.isDungeonOver then --战斗完返回
        isLoading = true
    end
    lastBGM = CSAPI.PlayBGM(info.bgm, 1000)
end

function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1,offset2 = size[0] / 1920,size[1] / 1080
    local offset = offset1>offset2 and offset1 or offset2
    local child = bg.transform:GetChild(0)
    if child then
        CSAPI.SetScale(child.gameObject,offset,offset,offset)
    end
end

function SetTime()
    if sectionData then
    openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if openInfo:IsDungeonOpen() then
            local strs = openInfo:GetTimeStrs()
            local str = LanguageMgr:GetByID(22021) .. strs[1] .. " " .. strs[2] .. "-" .. strs[3] .. " " .. strs[4]
            CSAPI.SetText(txtTime, str)
        else
            local str = openInfo:GetCloseTimeStr()
            CSAPI.SetText(txtTime,str)
        end
    end
end

function SetNum()
    CSAPI.SetText(txtNum, BagMgr:GetCount(info.goodsId) .. "")
end

function SetRed(b)
    if redPath == nil then
        redPath = sectionData and sectionData:GetRedPath() or "Common/Red2"
    end
    if not IsNil(redParent) then
        UIUtil:SetRedPoint2(redPath,redParent,b,0,0)
    else
        CSAPI.SetGOActive(redAnim,b)
    end
end

function SetExploreRed()
    if redAnim2 then
        local isRed = false
        if sectionData:GetExploreId() then
            local exData = ExplorationMgr:GetExData(sectionData:GetExploreId())
            isRed = exData and exData:HasRevice() or false
        end
        CSAPI.SetGOActive(redAnim2,isRed)
    end
end

function SetSpecial()
    if info.view  == "DungeonActivity1" then
        FuncUtil:Call(function ()
            if gameObject then
                CSAPI.SetGOActive(effObj,true)
            end
        end,nil,300)
        if openInfo:GetOpenCfg().hardBegTime then
            CSAPI.SetText(txtHard, LanguageMgr:GetTips(24007, openInfo:GetOpenCfg().hardBegTime))
        else
            CSAPI.SetText(txtHard, "")
        end
    end
end

function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = info.taskType,
        group = data.id,
        title = LanguageMgr:GetByID(6021)
    })
end

function OnClickShop()
    CSAPI.OpenView("ShopView",openInfo:GetShopID())
end

function OnClickDungeon()
    if not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    if data then
        CSAPI.OpenView(info.childView, {
            id = data.id
        })
    end
end

function OnClickExploration()
    if sectionData:GetExploreId() then
        CSAPI.OpenView("SpecialExploration",sectionData:GetExploreId());
    end
end

function OnClickReturn()
    view:Close()
end

function OnDestroy()
    if not FightClient:IsFightting() then --不在战斗中关闭界面时重播bgm
        FuncUtil:Call(function ()
            if lastBGM ~= nil then
                CSAPI.ReplayBGM(lastBGM)
            else
                EventMgr.Dispatch(EventType.Replay_BGM, 50);
            end
        end,this,300)
    end
    
    eventMgr:ClearListener()
end