local openInfo = nil
local lastBGM = nil
local isLoading = false

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mission_List, function ()
        SetRed(MissionMgr:CheckDungeonActivityRed(data.id))
    end)
    eventMgr:AddListener(EventType.Bag_Update, function()
        CSAPI.SetText(txtNum, BagMgr:GetCount(10201) .. "")
    end)

    -- eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnLoadComplete)
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" then
        CSAPI.PlayBGM("Sys_Hesitant_Cage", 1)
    end
end

function OnLoadComplete()
    if isLoading then
        FuncUtil:Call(function ()
            if gameObject then
                lastBGM = CSAPI.PlayBGM("Sys_Hesitant_Cage", 1)
            end
        end,nil,200)
    end
end

function OnInit()
    UIUtil:AddTop2("DungeonActivity3", gameObject, OnClickReturn);
end

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
        lastBGM = CSAPI.PlayBGM("Sys_Hesitant_Cage", 1)
    end
    
    if data then
        SetTime()
        SetNum()
        SetRed(MissionMgr:CheckDungeonActivityRed(data.id))
        -- SetPlot()
    end
end

function SetTime()
    local sectionData = DungeonMgr:GetSectionData(data.id)
    if sectionData then
    openInfo = DungeonMgr:GetActiveOpenInfo(sectionData:GetActiveOpenID())
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
    CSAPI.SetText(txtNum, BagMgr:GetCount(10201) .. "")
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent,b,0,0)
end

function SetPlot()
    local sectionData = DungeonMgr:GetSectionData(data.id)
    if sectionData:GetStoryID() and (not PlotMgr:IsPlayed(sectionData:GetStoryID())) then
        PlotMgr:TryPlay(sectionData:GetStoryID(), function()
            PlotMgr:Save()
        end, this, true);
    end
end

function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.Story,
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
        CSAPI.OpenView("DungeonRole", {
            id = data.id
        })
    end
end

function OnClickReturn()
    view:Close()
end

function OnDestroy()
    -- EventMgr.Dispatch(EventType.Replay_BGM);

    if not FightClient:IsFightting() then --不在战斗中关闭界面时重播bgm
        CSAPI.ReplayBGM(lastBGM)
    end
    
    eventMgr:ClearListener()
end
