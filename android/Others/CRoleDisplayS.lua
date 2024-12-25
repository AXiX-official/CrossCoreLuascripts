local CRoleDisplayData = require("CRoleDisplayData")
local topType = 1 -- 1：单人看板  2：双人看板
function Awake()
    UIUtil:AddTop2("CRoleDisplayS", gameObject, function()
        view:Close()
    end, ToHome, {})
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    layout1:Init("UIs/CRoleDisplay/CRoleDisplaySItem", LayoutCallBack1, true)
    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    layout2:Init("UIs/CRoleDisplay/CRoleDisplaySItemConta", LayoutCallBack2, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.CRoleDisplayS_Change, RefreshPanel)
    eventMgr:AddListener(EventType.Player_Select_Card, function ()
        if (topType == 1) then
            layout1:UpdateList()
        else
            layout2:UpdateList()
        end
    end)
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
    -- 排序
    ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
        local lua = ComUtil.GetLuaTable(go)
        CSAPI.SetGOActive(lua.btnL, false)
        lua.Init(24, RefreshPanel)
    end)
end

function ToHome()
    if(CSAPI.IsViewOpen("CRoleDisplayMain"))then 
        local viewGO = CSAPI.GetView("CRoleDisplayMain")
        local viewLua = ComUtil.GetLuaTable(viewGO)
        viewLua.Level(true)
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end
function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.Refresh(_data)
    end
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    SetTop()
    --
    CSAPI.SetGOActive(vsv1, topType == 1)
    CSAPI.SetGOActive(vsv2, topType == 2)
    --  
    SetDatas()
    SetDown()
    SetLayout()
end

function SetTop()
    CSAPI.SetGOActive(normal1, topType == 2)
    CSAPI.SetGOActive(sel1, topType == 1)
    CSAPI.SetGOActive(normal2, topType == 1)
    CSAPI.SetGOActive(sel2, topType == 2)
    CSAPI.SetGOActive(sortParent, topType == 1)
end

function SetDatas()
    --
    curDatas = CRoleDisplayMgr:GetRandomPanels(topType)
    if (#curDatas > 0 and topType == 1) then
        curDatas = SortMgr:Sort(24, curDatas)
    end
    table.insert(curDatas, 1, {
        idx = 0
    })
end

function SetLayout()
    if (topType == 1) then
        layout1:IEShowList(#curDatas)
    else
        layout2:IEShowList(#curDatas)
    end
end

function SetDown()
    -- 
    local languageID = topType == 1 and 7067 or 7068
    LanguageMgr:SetText(txtDown1, languageID)
    LanguageMgr:SetEnText(txtDown2, languageID)
    --
    local cur, max = #curDatas - 1, g_RandomKanbanQuantity
    cur = StringUtil:SetByColor(cur, "ffc146")
    CSAPI.SetText(txtNum, cur .. "/" .. max)
    -- 
    SetUsingType()
end

function SetUsingType()
    random_type = CRoleDisplayMgr:GetPanelRet().random_type
    CSAPI.SetGOActive(objSSel, random_type == eRandomPanelType.SINGLE or random_type == eRandomPanelType.ALL)
    CSAPI.SetGOActive(objDSel, random_type == eRandomPanelType.DOUBLE or random_type == eRandomPanelType.ALL)
end

function OnClickOne()
    if (topType ~= 1) then
        topType = 1
        RefreshPanel()
    end
end
function OnClickMore()
    if (topType ~= 2) then
        topType = 2
        RefreshPanel()
    end
end

function OnClickSingle()
    if (random_type == eRandomPanelType.SINGLE) then
        LanguageMgr:ShowTips(27009)
        return
    end
    local isChange = false
    local num = random_type == eRandomPanelType.ALL and eRandomPanelType.DOUBLE or eRandomPanelType.ALL
    if (num == eRandomPanelType.ALL) then
        -- 另外一页是否有数据
        local arr = CRoleDisplayMgr:GetRandomPanels(eRandomPanelType.DOUBLE)
        if (#arr <= 0) then
            LanguageMgr:ShowTips(27007)
            return
        end
    else
        -- 如果当前正在使用该页，则切到另外一页
        local usingData = CRoleDisplayMgr:GetUsingData()
        if (usingData:GetTy() == 2) then
            isChange = true
            --CRoleDisplayMgr:Change3(eRandomPanelType.DOUBLE)
        end
    end
    PlayerProto:SetPanelRandomType(num, SetUsingType)
    if(isChange)then 
        CRoleDisplayMgr:Change3(eRandomPanelType.DOUBLE)
    end 
end
function OnClickDouble()
    if (random_type == eRandomPanelType.DOUBLE) then
        LanguageMgr:ShowTips(27009)
        return
    end
    local num = random_type == eRandomPanelType.ALL and eRandomPanelType.SINGLE or eRandomPanelType.ALL
    if (num == eRandomPanelType.ALL) then
        -- 另外一页是否有数据
        local arr = CRoleDisplayMgr:GetRandomPanels(eRandomPanelType.SINGLE)
        if (#arr <= 0) then
            LanguageMgr:ShowTips(27007)
            return
        end
    else
        -- 如果当前正在使用该页，则切到另外一页
        local usingData = CRoleDisplayMgr:GetUsingData()
        if (usingData:GetTy() == 3) then
            CRoleDisplayMgr:Change3(eRandomPanelType.SINGLE)
        end
    end
    PlayerProto:SetPanelRandomType(num, SetUsingType)
end

function OnViewOpened(viewKey)
    if (viewKey == "CRoleDisplay" and gameObject ~= nil) then
        CSAPI.SetScale(gameObject, 0, 0, 0)
    end
end
function OnViewClosed(viewKey)
    if (viewKey == "CRoleDisplay" and gameObject ~= nil) then
        CSAPI.SetScale(gameObject, 1, 1, 1)
    end
end
