-- 角色看板
local isRole = false
local curLIndex = nil
local curModelID = nil
local curPanelID = nil
local curCRoleInfo = nil
local curDatas = nil
local isL2D = true
local isCanUse = false

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/CRoleDisplay/CRoleDisplayItem", LayoutCallBack, true)
    tlua1 = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)

    cardIconItem = RoleTool.AddRole(iconParent)
    mulIconItem = RoleTool.AddMulRole(iconParent)

    -- 
    cg_btnTKb = ComUtil.GetCom(btnTKb, "CanvasGroup")

    eventMgr = ViewEvent.New()
    -- eventMgr:AddListener(EventType.RedPoint_Refresh, function()
    --     if (layout) then
    --         layout:UpdateList()
    --     end
    --     SetNew()
    -- end)

    top = UIUtil:AddTop2("CRoleDisplay", gameObject, function()
        view:Close()
    end, nil, {})
end

function OnDestroy()
    eventMgr:ClearListener()
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.SetIndex(index)
        lua.SetClickCB(ItemClickCB)
        lua.Refresh(_data, curLIndex, useModelID)
    end
end

function ItemClickCB(index)
    if (curLIndex and curLIndex == index) then
        return
    end
    curLIndex = index
    curModelID = curDatas[curLIndex]:GetSkinID()
    isL2D = true

    RefreshPanel()
end

function OnOpen()
    useModelID = PlayerClient:GetIconId()
    usePanelID = PlayerClient:GetPanelId()

    curModelID = usePanelID == nil and useModelID or nil
    curPanelID = usePanelID
    curLIndex = nil
    RefreshPanel()
    SetBG(PlayerClient:GetBG())
end

function RefreshPanel()
    isRole = curPanelID == nil and true or false

    SetDatas()
    SetLeft()
    SetGet()
    SetMiddle()
    SetL2dBtn()
    -- SetGet()
    SetBtns()

    -- SetNew()
end

function SetBG(id)
    local cfg = Cfgs.CfgMenuBg:GetByID(id)
    if (cfg and cfg.name) then
        ResUtil:LoadBigImg2(bg, "UIs/BGs/" .. cfg.name .. "/bg", false, function()
            CSAPI.SetScale(bg, 1.05, 1.05, 1)
        end)
    end
end

function SetDatas()
    if (isRole) then
        curCRoleInfo = CRoleMgr:GetCRoleByModelID(curModelID)
        curDatas = curCRoleInfo:GetAllSkinsArr(true)
        if (curLIndex == nil) then
            for k, v in ipairs(curDatas) do
                if (v:GetSkinID() == curModelID) then
                    curLIndex = k
                    break
                end
            end
        end
    end
end

function SetLeft()
    CSAPI.SetGOActive(left, isRole)
    if (isRole and node.activeSelf) then
        layout:IEShowList(#curDatas)
    end
end

function SetMiddle()
    CSAPI.SetGOActive(mulIconItem.gameObject, not isRole)
    CSAPI.SetGOActive(cardIconItem.gameObject, isRole)

    -- 缓存的位置
    local type = isRole and 1 or 2
    local id = isRole and curModelID or curPanelID
    cache = CRoleMgr:GetCacheData(type, id) -- 缓存位置 
    local _isL2D = isL2D
    if (cache ~= nil) then
        _isL2D = cache.l2d
    end
    -- 和谐不显示动态
    local isShopImg = false
    if (not isCanUse and CheckIsHX()) then
        _isL2D = false
        isShopImg = true
    end
    --
    if (isRole) then
        CSAPI.SetGOActive(movePoint, false)
        cardIconItem.Refresh(curModelID, LoadImgType.Main, function()
            CSAPI.SetGOActive(movePoint, true)
            if (oldModelID and oldModelID ~= curModelID) then
                UIUtil:SetObjFade(movePoint, 0, 1, nil, 300, 0, 0)
            end
            oldModelID = curModelID
        end, _isL2D, isShopImg)
        isL2D = cardIconItem.IsLive2D()
    else
        mulIconItem.Refresh(curPanelID, nil, nil, _isL2D, isShopImg)
        isL2D = mulIconItem.IsLive2D()
    end
    --
    if (cache ~= nil) then
        CSAPI.SetAnchor(iconParent, cache.x, cache.y, 0)
        CSAPI.SetScale(iconParent, cache.scale, cache.scale, 1)
    else
        CSAPI.SetAnchor(iconParent, 0, 0, 0)
        CSAPI.SetScale(iconParent, 1, 1, 1)
    end
end

-- 是否和谐中 
function CheckIsHX()
    if (isRole) then
        local _cfg1 = Cfgs.character:GetByID(curModelID)
        local _cfg2 = _cfg1.shopId and Cfgs.CfgCommodity:GetByID(_cfg1.shopId) or nil
        if (_cfg2 and _cfg2.isShowImg == 1) then
            return true
        end
    else
        local _cfg1 = Cfgs.CfgArchiveMultiPicture:GetByID(curPanelID)
        local _cfg2 = _cfg1.show and Cfgs.CfgCommodity:GetByID(_cfg1.shopId) or nil
        if (_cfg2 and _cfg2.isShowImg == 1) then
            return true
        end
    end
    return false
end

function SetL2dBtn()
    local isShow = false
    if (isRole) then
        local cfg = Cfgs.character:GetByID(curModelID)
        if (cfg and cfg.l2dName) then
            isShow = true
        end
    else
        local cfg = Cfgs.CfgArchiveMultiPicture:GetByID(curPanelID)
        if (cfg and cfg.l2dName) then
            isShow = true
        end
    end
    if (isRole and not isCanUse and CheckIsHX()) then
        isShow = false
    end
    CSAPI.SetGOActive(btnKey, isShow)
    if (isShow) then
        CSAPI.SetGOActive(allOn, isL2D)
        CSAPI.SetGOActive(allOff, not isL2D)
    end
end

function SetGet()
    local _isCanUse, str = true, ""
    isCanUse = _isCanUse
    if (isRole and curLIndex) then
        local _data = curDatas[curLIndex]
        isCanUse = _data:CheckCanUse()
        str = isCanUse and "" or _data:GetCfg().get_txt
    else
        local _data = MulPicMgr:GetData(curPanelID)
        if (_data and _data:IsHad()) then
            isCanUse = true
        else
            isCanUse = false
        end
    end

    CSAPI.SetText(txtNoGet, str)
    if (not isCanUse and str ~= "") then
        CSAPI.SetGOActive(objNoGet, true or false)
    else
        CSAPI.SetGOActive(objNoGet, false)
    end
end

function SetBtns()
    -- use 
    local isShow = false
    if (isRole) then
        if (isCanUse and useModelID ~= curModelID) then
            isShow = true
        end
    end
    CSAPI.SetGOActive(btnUse, isShow)
    -- 调整看板
    local alpha = 0.3
    if ((isRole and useModelID == curModelID) or not isRole) then
        alpha = 1
    end
    cg_btnTKb.alpha = alpha
    -- bg 
    CSAPI.SetGOActive(btnCBg, isRole)
end

function OnClickUse()
    CRoleMgr:SaveCacheData(curPanelID, curModelID, isL2D)
    PlayerMgr:ChangeIcon(curPanelID, curModelID, OnOpen)
end

-- 动态开关
function OnClickKey()
    isL2D = not isL2D

    -- 如果是当前选择的角色/多人插图，则立即保存
    if ((isRole and useModelID == curModelID) or not isRole) then
        if (cache) then
            cache.l2d = isL2D
            CRoleMgr:SetCacheData(cache)
        else
            CRoleMgr:SaveCacheData(curPanelID, curModelID, isL2D)
        end
        EventMgr.Dispatch(EventType.Player_Select_Card)
    end
    SetL2dBtn()
    SetMiddle()
end

-- 看板调整
function OnClickTKb()
    if (isRole) then
        if (cg_btnTKb.alpha == 1) then
            CSAPI.SetAnchor(gameObject, 0, 10000, 0)
            local _data = {cardIconItem, iconParent, CB, cache}
            CSAPI.OpenView("CRoleDisplayDetail", _data)
        else
            LanguageMgr:ShowTips(27001)
        end
    else
        local _data = {mulIconItem, iconParent, CB, cache}
        CSAPI.OpenView("CRoleDisplayDetailT", _data)
    end
end

function CB(str)
    if (str == "save") then
        local x, y, scale = GetXYZ(iconParent)
        CRoleMgr:SaveCacheData(curPanelID, curModelID, isL2D, x, y, scale)
        EventMgr.Dispatch(EventType.Player_Select_Card)
    end
    CSAPI.SetAnchor(gameObject, 0, 0, 0)
    CSAPI.SetParent(iconParent, movePoint)
    SetMiddle()
end

function GetXYZ(obj)
    local x, y = CSAPI.GetAnchor(obj)
    local scale = CSAPI.GetScale(obj)
    x = tonumber(string.format("%.2f", x))
    y = tonumber(string.format("%.2f", y))
    scale = tonumber(string.format("%.2f", scale))
    return x, y, scale
end

-- 更换看板
function OnClickCkB()
    local type = isRole and 1 or 2
    NodeActive(false)
    -- CSAPI.OpenView("CRoleSelectView", {ChangeKBCB, OnOpenSelectView, Save}, type)
    if (not cRoleSelectView) then
        ResUtil:CreateUIGOAsync("CRoleDisplay/CRoleSelectView", gameObject, function(go)
            cRoleSelectView = ComUtil.GetLuaTable(go)
            cRoleSelectView.Refresh({ChangeKBCB, OnOpenSelectView, Save}, type)
        end)
    else
        CSAPI.SetGOActive(cRoleSelectView.gameObject, true)
        cRoleSelectView.Refresh({ChangeKBCB, OnOpenSelectView, Save}, type)
    end

end
-- 还原
function OnOpenSelectView()
    NodeActive(true)
    OnOpen()
end
-- type:1角色 2多人插图 id
function ChangeKBCB(type, id)
    if (type == 1) then
        curModelID = RoleMgr:GetSkinIDByRoleID(id) -- roleID
        curLIndex = nil
        isL2D = true -- 进场动画 todo 
        curPanelID = nil
    else
        curModelID = nil
        curPanelID = id
        isL2D = true -- 进场动画 todo 
    end
    RefreshPanel()
end

function Save(panelID, modelID)
    NodeActive(true)
    if (isRole) then -- 角色不立即保存
        curModelID = modelID
        curPanelID = panelID
        curLIndex = nil
        if (usePanelID ~= nil) then
            useModelID = nil
        end
        RefreshPanel()
    else
        CRoleMgr:SaveCacheData(panelID, modelID, isL2D)
        PlayerMgr:ChangeIcon(panelID, modelID, OnOpen)
    end
end

-- 更换背景
function OnClickCBg()
    NodeActive(false)
    CSAPI.OpenView("BGSelectView", SetBGCB)
end

function SetBGCB(id, b)
    SetBG(id)
    NodeActive(b)
end

function NodeActive(b)
    CSAPI.SetGOActive(node, b)
    CSAPI.SetGOActive(top.gameObject, b)
end

function SetNew()
    local _data = RedPointMgr:GetData(RedPointType.CRoleSkin)
    UIUtil:SetNewPoint(btnCKb, _data ~= nil, 98, 32.6, 0)
end

---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    if (not cRoleSelectView) then
        ---填写退出代码逻辑/接口
        if top.OnClickBack then
            top.OnClickBack();
        end
    else
        if cRoleSelectView.gameObject.activeInHierarchy then
            if cRoleSelectView.OnClickC then
                cRoleSelectView.OnClickC();
            else
                CSAPI.SetGOActive(cRoleSelectView.gameObject, false)
            end
        else
            ---填写退出代码逻辑/接口
            if top.OnClickBack then
                top.OnClickBack();
            end
        end
    end
end
