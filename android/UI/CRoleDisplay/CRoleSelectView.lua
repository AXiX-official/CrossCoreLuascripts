-- 选择角色
local curTabIndex = 1 -- 单人看板
local curID = nil
local timeSort1 = 1 -- 早到后 
local timeSort2 = 1 -- 多人插图
-- local sortLua1 = nil
-- local sortLua2 = nil
local _useRoleID = nil
local _usePanelID = nil 


function Awake()
    layout1 = ComUtil.GetCom(vsv1, "UIInfinite")
    -- layout1:AddBarAnim(0.4, false)
    layout1:Init("UIs/CRoleItem/CRoleLittleItem", LayoutCallBack1, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout1, UIInfiniteAnimType.Normal)

    layout2 = ComUtil.GetCom(vsv2, "UIInfinite")
    -- layout2:AddBarAnim(0.4, false)
    layout2:Init("UIs/CRoleDisplay/CRoleMulItem", LayoutCallBack2, true)
    tlua2 = UIInfiniteUtil:AddUIInfiniteAnim(layout2, UIInfiniteAnimType.Normal)

    cg_btnOne = ComUtil.GetCom(btnOne, "CanvasGroup")
    cg_btnMore = ComUtil.GetCom(btnMore, "CanvasGroup")

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.RedPoint_Refresh, function()
        if (curTabIndex == 1 and layout1) then
            layout1:UpdateList()
        end
    end)

    cg_btns = ComUtil.GetOrAddCom(btnS, "CanvasGroup")
end
function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack1(index)
    local lua = layout1:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB1)
        local _useID = usePanelID == nil and useRoleID or nil
        lua.Refresh(_data, {
            curID = _useRoleID,--curID,
            useID = _useID
        })
        -- lua.SetNew()
    end
end
function ItemClickCB1(_data)
    if (curID and _data:GetID() == curID) then
        return
    end
    curID = _data:GetID()
    _useRoleID = curID
    cg_btns.alpha = curID ~= nil and 1 or 0.3
    layout1:UpdateList()
    ChangeKBCB(curTabIndex, curID)
end

function LayoutCallBack2(index)
    local lua = layout2:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB2)
        lua.Refresh(_data, {
            curID = _usePanelID,--curID,
            useID = usePanelID
        })
    end
end
function ItemClickCB2(_data)
    if (curID and _data:GetID() == curID) then
        return
    end
    curID = _data:GetID()
    _usePanelID = curID
    cg_btns.alpha = _data:IsHad() and 1 or 0.3
    layout2:UpdateList()
    ChangeKBCB(curTabIndex, curID)
    SetNoGet()
end

function OnOpen()
    ChangeKBCB = data[1]
    OnOpenSelectView = data[2]
    Save = data[3]
    curTabIndex = openSetting or 1

    local baseID = PlayerClient:GetPanelId()
    local isRole = PlayerClient:KBIsRole()
    if (isRole) then
        useRoleID = Cfgs.character:GetByID(baseID).role_id
        usePanelID = nil
    else
        useRoleID = nil
        usePanelID = baseID
    end
    curID = nil -- 默认不选中

    RefreshPanel()
end

function Refresh(data, type)
    ChangeKBCB = data[1]
    OnOpenSelectView = data[2]
    Save = data[3]
    openSetting = type
    curTabIndex = openSetting or 1

    local baseID = PlayerClient:GetPanelId()
    local isRole = PlayerClient:KBIsRole()
    if (isRole) then
        useRoleID = Cfgs.character:GetByID(baseID).role_id
        usePanelID = nil
    else
        useRoleID = nil
        usePanelID = baseID
    end
    curID = nil -- 默认不选中

    RefreshPanel()
end

function RefreshPanel()
    SetDatas()
    -- tab 
    SetTab()
    -- sort 
    local angle = timeSort1 == 1 and 180 or 0
    CSAPI.SetAngle(objSort, 0, 0, angle)
    -- btn 
    local lanID = curTabIndex == 1 and 7012 or 1048
    LanguageMgr:SetText(txtS1, lanID)
    LanguageMgr:SetEnText(txtS2, lanID)
    cg_btns.alpha = curID ~= nil and 1 or 0.3
    SetNoGet()
end

function SetNoGet()
    if (curTabIndex == 2 and curID) then
        local _data = MulPicMgr:GetData(curID)
        CSAPI.SetGOActive(objNoGet, not _data:IsHad())
        if (not _data:IsHad()) then
            CSAPI.SetText(txtNoGet, _data:GetCfg().get_txt or "")
        end
    else
        CSAPI.SetGOActive(objNoGet, false)
    end
end

function SetDatas()
    CSAPI.SetGOActive(vsv1, curTabIndex == 1)
    CSAPI.SetGOActive(vsv2, curTabIndex == 2)

    -- CSAPI.SetGOActive(sortLua1.gameObject, curTabIndex == 1)
    -- CSAPI.SetGOActive(sortLua2.gameObject, curTabIndex == 2)
    sortId = curTabIndex == 1 and 5 or 6
    if (not sortLua) then
        ResUtil:CreateUIGOAsync("Sort/SortTop", sortParent, function(go)
            sortLua = ComUtil.GetLuaTable(go)
            sortLua.Init(sortId, RefreshPanel)
        end)
    else
        sortLua.Init(sortId, RefreshPanel)
    end

    curDatas = {}
    if (curTabIndex == 1) then
        -- curDatas = CRoleMgr:SortArr()
        -- if (#curDatas > 1) then
        --     table.sort(curDatas, function(a, b)
        --         if (timeSort1 == 1) then
        --             return a:GetCreateTime() < b:GetCreateTime()
        --         else
        --             return a:GetCreateTime() > b:GetCreateTime()
        --         end
        --     end)
        -- end
        -- layout1:IEShowList(#curDatas)

        curDatas = SortMgr:Sort(sortId, CRoleMgr:GetDatas())
        layout1:IEShowList(#curDatas)
    else
        -- 如果未获得，判断是否隐藏，不隐藏的话则要判断是否在可售时间内 
        local arr = {}
        local _arr = MulPicMgr:GetArr()
        for k, v in ipairs(_arr) do
            if (v:IsHad() or v:IsShow()) then
                table.insert(arr, v)
            end
        end
        curDatas = SortMgr:Sort(sortId, arr)
        layout2:IEShowList(#curDatas)
    end

    CSAPI.SetGOActive(SortNone, #curDatas <= 0)
end

function SetTab()
    CSAPI.SetGOActive(normal1, curTabIndex ~= 1)
    CSAPI.SetGOActive(sel1, curTabIndex == 1)
    CSAPI.SetGOActive(normal2, curTabIndex ~= 2)
    CSAPI.SetGOActive(sel2, curTabIndex == 2)
    -- cg_btnOne.alpha = curTabIndex == 1 and 1 or 0.3
    -- cg_btnMore.alpha = curTabIndex == 2 and 1 or 0.3
end
function OnClickOne()
    if (curTabIndex == 1) then
        return
    end
    curTabIndex = 1
   --curID = usePanelID == nil and useRoleID or nil
    if(_usePanelID) then 
        _useRoleID = nil 
    end 
   curID = _useRoleID
    RefreshPanel()
end

function OnClickMore()
    if (curTabIndex == 2) then
        return
    end
    curTabIndex = 2
    --curID = usePanelID
    if(_useRoleID) then 
        _usePanelID = nil 
    end 
    curID = _usePanelID
    RefreshPanel()
end

function OnClickC()
    -- OnClickMask()
    OnOpenSelectView()
    -- view:Close()
    CSAPI.SetGOActive(gameObject, false)
end

function OnClickS()
    if (not curID) then
        return
    end
    local modelID
    local panelID
    if (curTabIndex == 1) then
        modelID = RoleMgr:GetSkinIDByRoleID(curID) -- roleID 
        panelID = nil
    else
        local _data = MulPicMgr:GetData(curID)
        if (not _data:IsHad()) then
            return
        end
        modelID = PlayerClient:GetIconId()
        panelID = curID
    end
    Save(panelID, modelID)
    -- view:Close()
    CSAPI.SetGOActive(gameObject, false)
end

function OnClickMask()
    -- OnOpenSelectView()
    -- view:Close()
end

--[[

function OnClickFiltrate()
    if (curTabIndex == 1) then
        OnClickFiltrate1()
    else
        OnClickFiltrate2()
    end
end

-- 筛选
function OnClickFiltrate1()
    local mData = {}
    -- 由上到下排序
    mData.list = {"RoleTeam"} -- , "RoleQuality"}
    -- 标题名(与list一一对应)
    mData.titles = {}
    table.insert(mData.titles, LanguageMgr:GetByID(3023))
    -- table.insert(mData.titles, LanguageMgr:GetByID(3024))
    -- 当前数据
    mData.info = CRoleMgr:SGetCurFiltrateType()
    -- 源数据
    local _root = {}
    -- _root.RoleQuality = "CfgCardQuality"
    _root.RoleTeam = "CfgTeamEnum"
    mData.root = _root
    -- 回调
    mData.cb = SortCB1

    CSAPI.OpenView("SortView", mData)
end
function SortCB1(newInfo)
    CRoleMgr:SGetCurFiltrateType(newInfo)
    RefreshPanel()
end

-- 筛选
function OnClickFiltrate2()
    local mData = {}
    -- 由上到下排序
    mData.list = {"ThemeType"}
    -- 标题名(与list一一对应)
    mData.titles = {}
    table.insert(mData.titles, LanguageMgr:GetByID(32018))
    -- table.insert(mData.titles, LanguageMgr:GetByID(3024))
    -- 当前数据
    mData.info = MulPicMgr:SGetCurFiltrateType()
    -- 源数据
    local _root = {}
    _root.ThemeType = "CfgMultiImageThemeType"
    mData.root = _root
    -- 回调
    mData.cb = SortCB2

    CSAPI.OpenView("SortView", mData)
end

function SortCB2(newInfo)
    MulPicMgr:SGetCurFiltrateType(newInfo)
    RefreshPanel()
end

function OnClickUD()
    timeSort1 = timeSort1 == 1 and 2 or 1
    RefreshPanel()
end
]]
