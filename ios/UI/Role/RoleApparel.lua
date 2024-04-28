local curIndex = nil
local isLive2D = true
local isFirst1 = false
-- local countDown = 0.46
-- local isFirst2 = true
local svUtil = nil;
function Awake()
    UIUtil:AddTop2("RoleApparel", gameObject, function()
        view:Close()
    end, nil, {})

    cardIconItem = RoleTool.AddRole(item1, nil, nil, false)

    layout = ComUtil.GetCom(hsv, "UISV")
    layout:Init("UIs/RoleSkinComm/SkinInfoItem2", LayoutCallBack, true)
    layout:AddOnValueChangeFunc(OnValueChange)

    svUtil = SVCenterDrag.New()

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Card_Update, function()
        useIndex = GetBaseIndex() -- 当前使用的
        RefreshPanel()
    end)
    eventMgr:AddListener(EventType.Card_Skin_Get, RefreshPanel)

    CSAPI.SetGOActive(mask, true)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- function Update()
--     if isFirst2 then
--         countDown = countDown - Time.deltaTime
--         if countDown <= 0 then
--             isFirst2 = false
--             CSAPI.SetGOActive(mask, false)
--         end
--     end
-- end

-- data => CharacterCardsData
function OnOpen()
    cardData = data
    InitSkinData()
    RefreshPanel()
end

function InitSkinData()
    curDatas = {}
    local _curDatas = {}
    local infos = RoleSkinMgr:GetDatas(cardData:GetCfgID())
    for i, v in pairs(infos) do
        if (v:GetTypeNum() == 0) then
            table.insert(_curDatas, v)
        end
    end
    -- 非突破皮肤，未获得且不在出售时间内，要隐藏 
    for k, v in ipairs(_curDatas) do
        if (v:CheckCanUse()) then
            table.insert(curDatas, v)
        else
            if (not v:CheckIsNotBreakType() or v:IsInSell()) then
                table.insert(curDatas, v)
            end
        end
    end

    table.sort(curDatas, function(a, b)
        if (a:GetIndex() == b:GetIndex()) then
            return a:GetSkinID() < b:GetSkinID()
        else
            return a:GetIndex() < b:GetIndex()
        end
    end)
    useIndex = GetBaseIndex() -- 当前使用的
    isLive2D = cardData:GetSkinIsL2d()
    curIndex = curIndex ~= nil and curIndex or useIndex -- 当前点中的

    -- items 
    svUtil:Init(layout, #curDatas, {274, 422}, 7, 0.1, 0.5)
    layout:IEShowList(#curDatas, FirstCB, curIndex)
end

-- 第几个
function GetBaseIndex()
    local curSkinID = cardData:GetSkinID()
    for i, v in ipairs(curDatas) do
        if (v:GetSkinID() == curSkinID) then
            return i
        end
    end
    return 1
end

function FirstCB()
    if (not isFirst1) then
        isFirst1 = true
        CSAPI.SetGOActive(mask, false)
        OnValueChange()
    end
end

function RefreshPanel(isCheck)
    curModeId = curDatas[curIndex]:GetSkinID()
    cfgModel = Cfgs.character:GetByID(curModeId)

    if (isCheck) then
        if (cfgModel.l2dName ~= nil) then
            isLive2D = true
        end
    end

    -- desc
    CSAPI.SetText(txt_desc, cfgModel.model_desc)
    -- l2d btn
    SetL2dBtn()
    -- role 
    SetImg()
    -- btn
    SetBtn()

    SetArrow()
end

function SetArrow()
    if curIndex <= 1 then
        CSAPI.SetGOAlpha(arrow1, 0.48)
        CSAPI.SetGOAlpha(arrow2, 1)
    elseif curIndex == #curDatas then
        CSAPI.SetGOAlpha(arrow1, 1)
        CSAPI.SetGOAlpha(arrow2, 0.48)
    else
        CSAPI.SetGOAlpha(arrow1, 1)
        CSAPI.SetGOAlpha(arrow2, 1)
    end
end

-- l2d开关  data:IsHX() and cfgModel.shopImg or 
function SetL2dBtn()
    local b = cfgModel.l2dName ~= nil
    if (curDatas[curIndex]:IsHX()) then
        b = false -- 和谐中 
    end

    if (not b and isLive2D) then
        isLive2D = false
    end

    CSAPI.SetGOActive(btnL2D, b)
    if (b) then
        local name = "UIs/RoleSkinComm/btn_03_03.png"
        if isLive2D then
            name = "UIs/RoleSkinComm/btn_03_02.png"
        end
        CSAPI.LoadImg(l2dState, name, true, nil, true)
    end

end

-- role
function SetImg()
    -- CSAPI.SetGOActive(iconParent, false)
    -- cardIconItem.Refresh(curModeId, LoadImgType.RoleInfo, function(go)
    --     CSAPI.SetGOActive(iconParent, true)
    -- end, isLive2D)
    cardIconItem.Refresh(curModeId, LoadImgType.RoleInfo, nil, isLive2D, curDatas[curIndex]:IsHX())
end

function SetBtn()
    local is1, lanId, tips, isShow = true, 4020, "", true -- 黄色，替换,提示,显示按钮
    -- 皮肤是否可用
    canUse = curDatas[curIndex]:CheckCanUse(cardData)
    jumId = nil
    if (canUse) then
        -- 可用  已用/未用
        if (useIndex == curIndex) then
            local isL2d = cardData:GetSkinIsL2d()
            if (isL2d == isLive2D) then
                is1, lanId = false, 18085
            end
        end
    else
        -- 不可用 突破解锁/其他跳转途径
        tips = cfgModel.get_txt
        if (curDatas[curIndex].type == CardSkinType.Break) then
            isShow = false
        else
            local getCondition = curDatas[curIndex]:GetCfg().getCondition
            if (getCondition) then
                -- 有跳转
                -- shopCfg = Cfgs.CfgCommodity:GetByID(getCondition[2])
                -- if (shopCfg and shopCfg.jCosts) then
                --     itemCfg = Cfgs.ItemInfo:GetByID(shopCfg.jCosts[1][1])
                --     ResUtil.IconGoods:Load(imgMoney, itemCfg.icon, true)
                --     CSAPI.SetText(txtMoney, shopCfg.jCosts[1][2] .. "")
                --     local had = BagMgr:GetCount(shopCfg.jCosts[1][1])
                --     if (canvasGroup == nil) then
                --         canvasGroup = ComUtil.GetCom(btnSure, "CanvasGroup")
                --     end
                --     canvasGroup.alpha = had >= shopCfg.jCosts[1][2] and 1 or 0.3
                -- end
                is1, lanId = false, 18038
                jumId = getCondition[1]
            else
                -- 无跳转
                isShow = false
            end
        end
    end
    CSAPI.SetGOActive(btnSure, isShow)
    if (isShow) then
        CSAPI.SetGOActive(btnImg1, is1)
        CSAPI.SetGOActive(btnImg2, not is1)
        LanguageMgr:SetText(txtSure1, lanId)
        LanguageMgr:SetEnText(txtSure2, lanId)
    end
    CSAPI.SetText(txt_tips, tips)
end

-- 更换
function OnClickSure()
    if (canUse) then
        if (cardData:IsBaseCard()) then
            RoleSkinMgr:UseSkin(cardData:GetID(), curModeId, cardData:GetSkinIDElse(), isLive2D)
        else
            RoleSkinMgr:UseSkin(cardData:GetID(), cardData:GetSkinIDBase(), curDatas[curIndex]:GetSkinID(), isLive2D)
        end
    elseif (jumId) then
        -- local dialogdata = {}
        -- local str = LanguageMgr:GetTips(3007, itemCfg.name, curDatas[curIndex]:GetCfg().key,
        --     curDatas[curIndex]:GetCfg().desc)
        -- dialogdata.content = str
        -- dialogdata.okCallBack = function()
        --     ShopProto:Buy(shopCfg.id, TimeUtil:GetTime(), 1, nil, RefreshPanel)
        -- end
        -- CSAPI.OpenView("Dialog", dialogdata)
        JumpMgr:Jump(jumId)
    end
end

--------------------------------------------------------------
function LayoutCallBack(index)
    local _data = curDatas[index]
    local item = layout:GetItemLua(index)
    item.Refresh(_data)
    item.SetIndex(index)
    item.SetClickCB(OnClickItem)
    -- item.SetIsUse(index == useIndex)
    item.SetSelect(index == curIndex)
end

function OnValueChange()
    local index = layout:GetCurIndex()
    if index + 1 ~= curIndex then
        local item = layout:GetItemLua(curIndex)
        if item then
            item.SetSelect(false)
        end
        lastIdx = curIndex
        curIndex = index + 1
        local item = layout:GetItemLua(curIndex)
        if (item) then
            item.SetSelect(true);
        end
        -- if not isFirst2 then
        --     FuncUtil:Call(function()
        if curIndex < lastIdx then
            PlayMoveTween(true)
        else
            PlayMoveTween()
        end
        --     end, nil, 1)
        -- end
        SetArrow()
    end
    svUtil:Update()
end

function OnClickItem(index)
    layout:MoveToCenter(index)
end

-- -- 播放立绘移动动画 isRTL:是否从右到左
-- function PlayMoveTween(isRTL)
--     local x1 = 0
--     local x2 = isRTL and 400 or -400
--     UIUtil:SetObjFade(iconNode, 1, 0, nil, 300, 0, 1)
--     UIUtil:SetPObjMove(iconNode, x1, x2, 0, 0, 0, 0, function()
--         RefreshPanel()
--         UIUtil:SetObjFade(iconNode, 0, 1, nil, 300, 100, 0)
--         UIUtil:SetPObjMove(iconNode, -x2, x1, 0, 0, 0, 0, nil, 300, 100)
--     end, 300, 0)
-- end

-- 播放立绘移动动画 isRTL:是否从右到左
function PlayMoveTween(isRTL)
    local x1 = 0
    local x2 = isRTL and 400 or -400
    if (isLive2D) then
        UIUtil:SetObjFade(item1, 1, 0, nil, 1, 299, 1)
    else
        UIUtil:SetObjFade(item1, 1, 0, nil, 300, 1, 1)
    end
    UIUtil:SetPObjMove(item1, x1, x2, 0, 0, 0, 0, function()
        RefreshPanel(true)
        if (isLive2D) then
            UIUtil:SetObjFade(item1, 0, 1, nil, 1, 1, 0)
        else
            UIUtil:SetObjFade(item1, 0, 1, nil, 300, 1, 0)
        end
        UIUtil:SetPObjMove(item1, -x2, x1, 0, 0, 0, 0, nil, 300, 1)
    end, 301, 1)
end

-------------------------------------------------------放大
-- 放大
function OnClickSearch()
    CSAPI.OpenView("RoleInfoAmplification", {cardData:GetRoleID(), curModeId, isLive2D}, LoadImgType.RoleInfo)
end

-- 动态开关
function OnClickKey()
    isLive2D = not isLive2D
    SetImg()
    SetL2dBtn()
    SetBtn()
end

function OnClickL2D()
    isLive2D = not isLive2D
    RefreshPanel()
end

