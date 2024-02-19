-- local goVideo = nil
local refreshTime = 7.3
local openInfo = nil
local isLoading = false

function Awake()
    CSAPI.SetGOActive(effObj, false)
    -- if not goVideo then
    --     goVideo = ResUtil:PlayVideo("activity_fright", videoParent.gameObject);
    -- end 
    
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mission_List, OnMissionRefresh)
    eventMgr:AddListener(EventType.Bag_Update, function()
        CSAPI.SetText(txtGoods, BagMgr:GetCount(10015) .. "")
    end)
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnLoadComplete)
    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
end

function OnMissionRefresh()
    SetRed(MissionMgr:CheckRed({eTaskType.Story}))
end

function OnLoadComplete()
    if isLoading then
        FuncUtil:Call(function ()
            if gameObject then
                CSAPI.PlayBGM("TEx_MovieHorrorJazzyVer", 1)
            end
        end,nil,200)
    end
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" or viewKey == "ShopView" then
        FuncUtil:Call(function ()
            if gameObject then
                CSAPI.PlayBGM("TEx_MovieHorrorJazzyVer", 1)
            end
        end,nil,200)
    end
end

local time = 1

function Update()
    if openInfo and not openInfo:IsOpen() then
        openInfo = nil
        LanguageMgr:ShowTips(24001)
        UIUtil:ToHome()   
    end
end

function OnOpen()
    if openSetting and openSetting.isDungeonOver then --战斗完返回
        isLoading = true
    else
        CSAPI.PlayBGM("TEx_MovieHorrorJazzyVer",1)
    end

    CSAPI.SetText(txtGoods, BagMgr:GetCount(10015) .. "")
    SetTime()
    CSAPI.SetText(txtHard, LanguageMgr:GetTips(24007, openInfo:GetOpenCfg().hardBegTime))

    FuncUtil:Call(function ()
        if gameObject then
            CSAPI.SetGOActive(effObj,true)
        end
    end,nil,300)

    SetRed(MissionMgr:CheckRed({eTaskType.Story}))
end

function SetTime()
    local sectionData = DungeonMgr:GetSectionData(data.id)
    if sectionData then
        openInfo = DungeonMgr:GetActiveOpenInfo(sectionData:GetActiveOpenID())
        if openInfo:IsDungeonOpen() then
            local strs = openInfo:GetTimeStrs()
            CSAPI.SetText(txtTime1,LanguageMgr:GetByID(22021) .. strs[1])
            CSAPI.SetText(txtTime2,strs[2] .. " - ")
            CSAPI.SetText(txtTime3,strs[3])
            CSAPI.SetText(txtTime4,strs[4])
            CSAPI.SetText(txtEndTime,"")
        else
            local str = openInfo:GetCloseTimeStr()
            CSAPI.SetText(txtTime1,"")
            CSAPI.SetText(txtTime2,"")
            CSAPI.SetText(txtTime3,"")
            CSAPI.SetText(txtTime4,"")
            CSAPI.SetText(txtEndTime,str)
        end
    end
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent,b,0,0)
end

function RefreshEff()
    CSAPI.SetGOActive(titleEff,false)
    CSAPI.SetGOActive(titleEff,true)
end

function OnInit()
    UIUtil:AddTop2("DungeonActivity1", topObj, OnClickReturn);
end

function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.Story,
        group = data.id,
        title = LanguageMgr:GetByID(6021)
    })
end

function OnClickDungeon()
    if data then
        CSAPI.OpenView("DungeonPlot",{id = data.id})
    end
end

function OnClickShop()
    CSAPI.OpenView("ShopView",901)
end

function OnClickReturn()
    view:Close()
end

function OnDestroy()
    EventMgr.Dispatch(EventType.Replay_BGM);
    eventMgr:ClearListener()
end