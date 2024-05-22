local openInfo = nil
local lastBGM = nil
local isLoading = false

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Mission_List, function ()
        SetRed(MissionMgr:CheckDungeonActivityRed(data.id))
    end)
    eventMgr:AddListener(EventType.Bag_Update, function()
        CSAPI.SetText(txtNum, BagMgr:GetCount(10016) .. "")
    end)

    eventMgr:AddListener(EventType.View_Lua_Closed,OnViewClosed)
    eventMgr:AddListener(EventType.Scene_Load_Complete, OnLoadComplete)
end

function OnViewClosed(viewKey)
    if viewKey == "Plot" or viewKey == "ShopView" then
        FuncUtil:Call(function ()
            CSAPI.PlayBGM("Event_ArachnidsInTheTwilight", 1)
        end,this,200)
    end
end

function OnLoadComplete()
    if isLoading then
        FuncUtil:Call(function ()
            if gameObject then
                lastBGM = CSAPI.PlayBGM("Event_ArachnidsInTheTwilight", 1)
            end
        end,nil,200)
    end
end

function OnInit()
    UIUtil:AddTop2("DungeonActivity4", gameObject, OnClickReturn);
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
    if openSetting and openSetting.isDungeonOver then --战斗完返回
        isLoading = true
    else
        lastBGM = CSAPI.PlayBGM("Event_ArachnidsInTheTwilight", 1)
    end
    if data then
        SetTime()
        SetNum()
        SetRed(MissionMgr:CheckDungeonActivityRed(data.id))
    end
end

function SetBGScale()
    local size = CSAPI.GetMainCanvasSize()
    local offset1,offset2 = size[0] / 1920,size[1] / 1080
    local offset = offset1>offset2 and offset1 or offset2
    CSAPI.SetScale(bgScale,offset,offset,offset)
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
    CSAPI.SetText(txtNum, BagMgr:GetCount(10016) .. "")
end

function SetRed(b)
    UIUtil:SetRedPoint(redParent,b,0,0)
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
        CSAPI.OpenView("DungeonShadowSpider", {
            id = data.id
        })
    end
end

function OnClickReturn()
    view:Close()
end

function OnDestroy()
    if not FightClient:IsFightting() then --不在战斗中关闭界面时重播bgm
        FuncUtil:Call(function ()
            CSAPI.ReplayBGM(lastBGM)
        end,this,300)
    end
    
    eventMgr:ClearListener()
end