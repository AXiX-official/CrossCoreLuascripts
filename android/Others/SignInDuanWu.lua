local key = nil
local cfg = nil
local items = nil
local info = nil
local signInfo = nil
local alData = nil
local datas = nil
local curDay = nil
local isActive = false
local isSignIn = false
local isClose = false
local activeEndTime = 0
local isClick = false
local lAnim, rAnim = nil, nil
-- reward
local layout = nil
local curDatas = {}
local items2, items3 = nil, nil
local rewardIndex = 0

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/SignInContinue13/SignInDuanWuItem2", LayoutCallBack, true)

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Activity_SignIn, ESignCB)
    eventMgr:AddListener(EventType.Activity_DuanWu_Refresh, TryRefresh)
    eventMgr:AddListener(EventType.Update_Everyday, OnDayRefresh)

    lAnim = ComUtil.GetCom(DragonBoatL, "Animator")
    rAnim = ComUtil.GetCom(DragonBoatR, "Animator")

    CSAPI.SetGOActive(rewardObj, false)
    CSAPI.SetGOActive(clickMask, false)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
    end
end

function ESignCB(proto)
    -- if(isClick) then return end
    local _key = SignInMgr:GetDataKey(proto.id, proto.index)
    if (key ~= _key) then
        return
    end
    if proto.isOk == false then
        EventMgr.Dispatch(EventType.Acitivty_List_Pop)
        return
    end
    SignInMgr:AddCacheRecord(key)
    isClick = false
    OperationActivityMgr:CheckRedDuanWuPointData()
    isClose = false
    TryRefresh()
end

function OnDayRefresh()
    -- 清除弹出缓存
    ActivityPopUpMgr:ClearPopUpInfos()
    isClose = true
    UIUtil:ToHome()
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnInit()
    UIUtil:AddTop2("SignInDuanWu", topParent, OnClickBack);
end

function OnOpen()
    local id = data and data.id
    if id == nil then -- 没挑战获得最近开启的活动
        _, id = ActivityMgr:IsOpenByType(ActivityListType.SignInDuanWu)
    end
    alData = ActivityMgr:GetALData(id)
    if alData then
        key = SignInMgr:GetDataKeyById(alData:GetID())
        info = alData:GetInfo()
        SetTime()
        RefreshPanel()
    end
end

function SetTime()
    local str1 = TimeUtil:GetTimeHMS(alData:GetStartTime(), "%m/%d %H:%M")
    local str2 = TimeUtil:GetTimeHMS(alData:GetEndTime(), "%m/%d %H:%M")
    LanguageMgr:SetText(txtTime, 13033, StringUtil:SetByColor(str1 .. "-" .. str2, "ffc146"))
end

function TryRefresh()
    if isRefresh then
        return
    end
    isRefresh = true
    FuncUtil:Call(function()
        if not isClose then
            RefreshPanel()
        end
        isRefresh = false
    end, this, 300)
end

function RefreshPanel()
    signInfo = SignInMgr:GetDataByKey(key)
    isSignIn = signInfo:CheckIsDone()
    curDay = signInfo:GetRealDay()
    datas = SignInMgr:GetDayInfos(key)
    SetActive()
    SetReward()
    SetIcon()
    SetProgress()
    SetButton()
    SetSel()
    SetRed()
    SetMask()
end

function SetActive()
    local targetDay = (info and info.takeRewardDay) and info.takeRewardDay or 0
    local curDay = TimeUtil:GetActivyIntervalDay(alData:GetStartTime())
    isActive = curDay < targetDay
    CSAPI.SetGOActive(btnLeft, isActive)
    CSAPI.SetGOActive(btnRight, isActive)
    CSAPI.SetGOActive(btnSignIn, not isActive)
    rewardIndex = OperationActivityMgr:GetDuanWuRewardIndex()
end

function SetReward()
    local curData = datas[curDay]
    local rewards = curData:GetRewards() or {}
    items = items or {}
    ItemUtil.AddItems("SignInContinue13/SignInDuanWuItem", items, rewards, gridParent, nil, 1, {
        isGet = isSignIn
    })
end

function SetIcon()
    if info then
        if info.saltyReward then
            items2 = items2 or {}
            ItemUtil.AddItems("SignInContinue13/SignInDuanWuItem", items2, info.saltyReward, leftGrid, nil, 1, {
                isGet = rewardIndex == 2,
                isHide = true
            })
            -- local list = GridUtil.GetGridObjectDatas2(info.saltyReward)
            -- if list and list[1] and list[1]:GetIcon() then
            --     SetIcon()
            --     ResUtil.IconGoods:Load(icon1,list[1]:GetIcon())
            -- end
        end
        if info.sweetReward then
            ItemUtil.AddItems("SignInContinue13/SignInDuanWuItem", items3, info.sweetReward, rightGrid, nil, 1, {
                isGet = rewardIndex == 1,
                isHide = true
            })
            -- local list = GridUtil.GetGridObjectDatas2(info.sweetReward)
            -- if list and list[1] and list[1]:GetIcon() then
            --     ResUtil.IconGoods:Load(icon2,list[1]:GetIcon())
            -- end
        end
    end
end

function SetProgress()
    local recordInfo1 = OperationActivityMgr:GetDuanWuInfo(eDragonBoatFestivalType.Salty)
    local leftNum = recordInfo1 and recordInfo1.num or 0
    local recordInfo2 = OperationActivityMgr:GetDuanWuInfo(eDragonBoatFestivalType.Sweet)
    local rightNum = recordInfo2 and recordInfo2.num or 0
    for i = 1, 5 do
        if leftNum >= i then
            if this["pImg1_" .. i] and not IsNil(this["pImg1_" .. i].gameObject) then
                CSAPI.LoadImg(this["pImg1_" .. i].gameObject, "UIs/SignInContinue13/img_01_05.png", true, nil, true)
                CSAPI.SetImgColorByCode(this["pImg1_" .. i].gameObject, "ffc146")
            end
        end
        if rightNum >= i then
            if this["pImg2_" .. i] and not IsNil(this["pImg2_" .. i].gameObject) then
                CSAPI.LoadImg(this["pImg2_" .. i].gameObject, "UIs/SignInContinue13/img_01_05.png", true, nil, true)
                CSAPI.SetImgColorByCode(this["pImg2_" .. i].gameObject, "caf982")
            end
        end
    end
end

function SetButton()
    if isActive then
        local leftName = "btn_01_01"
        local rightName = "btn_01_02"
        CSAPI.SetGOAlpha(btnLeft, isSignIn and 0.5 or 1)
        CSAPI.SetGOAlpha(btnRight, isSignIn and 0.5 or 1)
        CSAPI.SetGOAlpha(txt_left, isSignIn and 0.5 or 1)
        CSAPI.SetGOAlpha(txt_right, isSignIn and 0.5 or 1)
        CSAPI.SetGOActive(leftEffect, not isSignIn)
        CSAPI.SetGOActive(rigthEffect, not isSignIn)
        if isSignIn then
            local isLeft = OperationActivityMgr:GetDuanWuCurSel() and OperationActivityMgr:GetDuanWuCurSel() ==
                               eDragonBoatFestivalType.Salty or false
            leftName = not isLeft and "btn_01_03" or leftName
            rightName = isLeft and "btn_01_03" or rightName
            if isLeft then
                LanguageMgr:SetText(txt_left, 13037)
            else
                LanguageMgr:SetText(txt_right, 13037)
            end
        end
        CSAPI.LoadImg(btnLeft, "UIs/SignInContinue13/" .. leftName .. ".png", true, nil, true)
        CSAPI.LoadImg(btnRight, "UIs/SignInContinue13/" .. rightName .. ".png", true, nil, true)
    else
        CSAPI.LoadImg(btnSignIn, "UIs/SignInContinue13/" .. (isSignIn and "btn_02_02" or "btn_02_01") .. ".png", true,
            nil, true)
        LanguageMgr:SetText(txt_sign, isSignIn and 13038 or 13007)
    end
end

function SetSel()
    local selType = OperationActivityMgr:GetDuanWuCurSel()
    CSAPI.SetGOActive(selLeft, isActive and isSignIn and selType and selType == eDragonBoatFestivalType.Salty)
    CSAPI.SetGOActive(selRight, isActive and isSignIn and selType and selType == eDragonBoatFestivalType.Sweet)
    if isSignIn then
        if selType and selType == eDragonBoatFestivalType.Salty and not IsNil(lAnim) then
            lAnim:Play("DragonBoat_gif_Boost")
        end
        if selType and selType == eDragonBoatFestivalType.Sweet and not IsNil(rAnim) then
            rAnim:Play("DragonBoat_gif_Boost")
        end
    end
end

function SetRed()
    UIUtil:SetRedPoint(btnSignIn, not isActive and not isSignIn, 262, 69)
end

function SetMask()
    CSAPI.SetGOActive(clickMask, not isActive and not isSignIn)
end

function OnClickSel(go)
    if not info or not info.signInId then
        return
    end
    if isSignIn then
        return
    end
    if isClick then
        return
    end
    local dialogData = {}
    dialogData.content = LanguageMgr:GetByID(go.name == "btnLeft" and 13039 or 13040)
    dialogData.okCallBack = function()
        if go.name == "btnLeft" then
            isClick = true
            OperateActiveProto:DragonBoatFestivalRefuel(info.signInId, eDragonBoatFestivalType.Salty)
        else
            isClick = true
            OperateActiveProto:DragonBoatFestivalRefuel(info.signInId, eDragonBoatFestivalType.Sweet)
        end
    end
    CSAPI.OpenView("Dialog", dialogData)
end

function OnClickReward()
    CSAPI.SetGOActive(rewardObj, true)
    ShowReward()
end

function ShowReward()
    curDatas = {}
    for i, v in ipairs(datas) do
        table.insert(curDatas, v)
    end
    if #curDatas > 0 then
        layout:IEShowList(#curDatas)
    end
end

function OnClickClose()
    CSAPI.SetGOActive(rewardObj, false)
end

function OnClickSign()
    if isClick then
        return
    end
    isClick = true
    ClientProto:AddSign(signInfo:GetID())
end

function OnClickBack()
    view:Close()
end

