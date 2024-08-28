local cfgs = nil
local curIndex = 0
local rightItems = {}
local openCfgs = {} -- 开启的活动
local list = {}
local curItem = nil
local btnCallBack = nil
local top = nil
local isClickMask = true
local group = 1
curIndex1, curIndex2 = 1, 1;

function OnInit()
    top = UIUtil:AddTop2("ActivityListView", topParent.gameObject, CloseView, nil, {})
    CSAPI.SetGOActive(top.btn_home, false)
    -- CSAPI.SetGOActive(top.moneys, false)
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Activity_OpenQueue, OnItemSelect);
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClose);
    eventMgr:AddListener(EventType.Activity_Click, OnBtnCallBack);
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
    eventMgr:AddListener(EventType.Update_Everyday, OnDayRefresh)
    eventMgr:AddListener(EventType.Acitivty_List_Pop,CheckNextView)
end

function OnItemSelect(_type)
    SetRightPanel(_type)
end

function OnViewClose(key)
    if (key == "RewardPanel") then
        CheckNextView()
    end
end

function OnBtnCallBack()
    isClickMask = true
    -- btnCallBack = _cb or nil
    CSAPI.SetGOActive(clickMask, true)
    -- CSAPI.SetGOActive(topParent,false)
end

function OnRedPointRefresh()
    for i, v in ipairs(leftPanel.leftItems) do
        local isRed = ActivityMgr:CheckRed(openCfgs[i].id)
        isRed = i == curIndex1 and false or isRed
        v.SetRed(isRed)
    end
end

function OnDayRefresh()
   UIUtil:ToHome()
end

function OnDisable()
    eventMgr:ClearListener();
end

function OnOpen()
    group = openSetting or 1
    InitLeftPanel()
    if openCfgs and #openCfgs > 0 then
        CheckNextView(data)
    end

    CSAPI.SetGOActive(emptyObj,openCfgs == nil or #openCfgs < 1)
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", left.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {}
    openCfgs = ActivityMgr:GetArr(tonumber(group))
    for i, v in ipairs(openCfgs) do
        list[v.id] = {index = i} --记录当前类型的顺序
        table.insert(leftDatas,{v.leftInfo[1].id, v.leftInfo[1].path})
    end
    leftPanel.Init(this, leftDatas)
end

function CheckNextView(_type)
    local nextType = ActivityMgr:TryGetNextType(group)
    if (_type == nil and nextType) then
        _type = nextType
    end
    SetRightPanel(_type)
end

function SetRightPanel(_type)
    if (_type and openCfgs) then
        for i, v in ipairs(openCfgs) do
            if (v.id == _type) then
                curIndex1 = i
                break
            end
        end
    end
    RefreshPanel()
end

function RefreshPanel()
    leftPanel.Anim()
    leftPanel.leftItems[curIndex1].SetRed(false)

    local isRefresh = curIndex ~= curIndex1
    if (isRefresh) then
        curIndex = curIndex1
        if (curItem) then
            UIUtil:SetObjFade(curItem.gameObject,1,0,function ()
                CSAPI.SetGOActive(curItem.gameObject, false)
                curItem = nil
                SetRight()
            end,200)
        else
            SetRight()
        end
    end
    OnRedPointRefresh()
end

function SetRight()
    local cfg = openCfgs[curIndex]
    if (cfg) then
        if cfg.path and (cfg.id == ActivityListType.SignInContinue or cfg.id == ActivityListType.Investment or ActivityListType.DropAdd) then
            CSAPI.SetGOActive(imgParent,false)
        else
            CSAPI.SetGOActive(imgParent,true)
        end

        ShowTop(cfg)
        ShowQusetion(cfg)

        local data,esleData = GetInfo(cfg)

        if (rightItems[cfg.id]) then
            CSAPI.SetGOActive(rightItems[cfg.id].gameObject, true)
            rightItems[cfg.id].isFirst = false
            rightItems[cfg.id].Refresh(data, esleData)
            UIUtil:SetObjFade(rightItems[cfg.id].gameObject,0,1,nil,200)
            curItem = rightItems[cfg.id]
        else
            if (cfg.path) then
                ResUtil:CreateUIGOAsync(cfg.path, right, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(data, esleData)
                    UIUtil:SetObjFade(go,0,1,nil,200)
                    rightItems[cfg.id] = lua
                    curItem = lua
                end)
            else
                LogError("找不到对应位置的预设体！！！" .. cfg.id)
            end
        end
        curData = nil

        PlayerPrefs.SetInt(PlayerClient:GetUid() .."_Activity_Red_" .. cfg.id,1)
        ActivityMgr:CheckRedPointData(cfg.id)
    end
end

function ShowTop(_cfg)
    if _cfg.path and _cfg.id == ActivityListType.Investment then
        top.SetMoney({{ITEM_ID.DIAMOND,140001}})
    elseif _cfg.id == ActivityListType.Exchange then
        local info =_cfg.info and _cfg.info[1] or nil
        local tab = {}
        if info and info.goodId then
            tab = {{info.goodId}}
        end
        top.SetMoney(tab)
    else
        top.SetMoney()
    end
end

function ShowQusetion(_cfg)
    local info =_cfg.info
    local isShow = false
    if info and info[1] and info[1].moduleInfo then
        UIUtil:AddQuestionItem(_cfg.moduleInfo, gameObject, qusetion)
        isShow = true
    end
    CSAPI.SetGOActive(qusetion, isShow)
end

function GetInfo(_cfg)
    local data,elseData = ActivityMgr:TryGetData(_cfg.id),{cfg = _cfg}
    return data,elseData
end


function CloseView()
    CSAPI.SetGOActive(top.btn_home, true)
    -- CSAPI.SetGOActive(top.moneys, true)
    EventMgr.Dispatch(EventType.Activity_List_Null_Check)
    view:Close()
end

function OnClick()
    if curItem and isClickMask then
        curItem.OnClickMask()
        isClickMask = false
    end
    CSAPI.SetGOActive(clickMask, false)
end
