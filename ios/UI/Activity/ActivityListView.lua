local cfgs = nil
local curIndex = 0
local rightItems = {}
local openCfgs = {} -- 开启的活动
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
    local redTypes = group == 1 and RedPointMgr:GetData(RedPointType.ActivityList1) or RedPointMgr:GetData(RedPointType.ActivityList2)
    if leftPanel and openCfgs and #redTypes > 0 then
        for k, v in ipairs(redTypes) do
            local cfg = Cfgs.CfgActiveList:GetByID(v.type)
            local idx = cfg and cfg.index or 0
            if idx > 0 and leftPanel.leftItems[idx] then
                leftPanel.leftItems[idx].SetRed(v.b == 1)
            end
        end
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

    -- ActivityMgr:CheckRedPointData()
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", left.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {}
    openCfgs = ActivityMgr:GetArr(tonumber(group))
    for i, v in ipairs(openCfgs) do
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
            curItem.PlayFade(true,function ()
                CSAPI.SetGOActive(curItem.gameObject, false)
                curItem = nil
                SetRight()
            end)
        else
            SetRight()
        end
    end
    ActivityMgr:CheckRedPointData()
end

function SetRight()
    local cfg = openCfgs[curIndex]
    if (cfg) then
        if cfg.path and (cfg.id == ActivityListType.SignInContinue or cfg.id == ActivityListType.Investment) then
            CSAPI.SetGOActive(imgParent,false)
        else
            CSAPI.SetGOActive(imgParent,true)
        end

        ShowTop(cfg)
        ShowQusetion(cfg)

        local data = ActivityMgr:TryGetData(cfg.id)

        if (rightItems[cfg.id]) then
            CSAPI.SetGOActive(rightItems[cfg.id].gameObject, true)
            rightItems[cfg.id].isFirst = false
            rightItems[cfg.id].Refresh(data, {cfg = cfg})
            rightItems[cfg.id].PlayFade(false)
            curItem = rightItems[cfg.id]
        else
            if (cfg.path) then
                ResUtil:CreateUIGOAsync(cfg.path, right, function(go)
                    local lua = ComUtil.GetLuaTable(go)
                    lua.Refresh(data, {cfg = cfg})
                    lua.PlayFade(false)
                    rightItems[cfg.id] = lua
                    curItem = lua
                end)
            else
                LogError("找不到对应位置的预设体！！！" .. cfg.id)
            end
        end
        curData = nil
    end
end

function ShowTop(_cfg)
    if _cfg.path and _cfg.id == ActivityListType.Investment then
        top.SetMoney({{ITEM_ID.DIAMOND,140001}})
    else
        top.SetMoney()
    end
end

function ShowQusetion(_cfg)
    CSAPI.SetGOActive(qusetion, _cfg.moduleInfo ~= nil)
    if _cfg.moduleInfo then
        UIUtil:AddQuestionItem(_cfg.moduleInfo, gameObject, qusetion)
    end
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
    -- if(btnCallBack)then
    -- 	btnCallBack()
    -- end
    CSAPI.SetGOActive(clickMask, false)
end
