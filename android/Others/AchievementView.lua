local leftCfgs = {}
local panels = {}
local lastPanel = nil
curIndex1, curIndex2 = 1, 0 -- 父index,子index
local recoverNews = {}

function Awake()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Achievement_Data_Update,RefreshPanel)
end

function OnInit()
    UIUtil:AddTop2("Achievement", topParent, OnClickBack ,OnClickHome);
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    InitDatas()
    InitJumpState()
    InitLeftPanel()
    RefreshPanel()
end

function InitDatas()
    if #leftCfgs < 1 then
        local cfgs = Cfgs.CfgAchieveType:GetAll()
        if cfgs == nil then
            LogError("配置表信息丢失！！！CfgAchieveType")
            return
        end
        for _, cfg in pairs(cfgs) do
            table.insert(leftCfgs,cfg)
        end
        if #leftCfgs > 0 then
            table.sort(leftCfgs,function (a,b)
                return a.sort < b.sort
            end)
        end
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas,leftChildDatas = {{47100,"ActivityList/icon1"}},{{}} -- 多语言id，需要配置英文 -- 子项多语言，需要配置英文
    if #leftCfgs > 0 then
        for _, cfg in ipairs(leftCfgs) do
            table.insert(leftDatas,{cfg.leftInfo[1].id,cfg.leftInfo[1].path})
            local _data = {}
            if cfg.infos then
                for i, v in ipairs(cfg.infos) do
                    table.insert(_data,v.childId)
                end
            end
            table.insert(leftChildDatas,_data)
        end
    end
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function InitJumpState()
    if openSetting and openSetting.group then
        if #leftCfgs > 0 then
            for k, cfg in ipairs(leftCfgs) do
                if cfg.infos and #cfg.infos>0 then
                    for i, v in ipairs(cfg.infos) do
                        if v.typeNum == openSetting.group then
                            curIndex1,curIndex2 = k + 1, v.index
                        end
                    end
                end
            end
        end
    end
end


function RefreshPanel()
    ShowRightPanel()
    -- 侧边动画
    leftPanel.Anim()
    -- 红点
    SetRed()
end

function ShowRightPanel()
    if lastPanel then
        CSAPI.SetGOActive(lastPanel.gameObject,false)
    end
    local currIndex = curIndex1 == 1 and 1 or 2
    local elseData = openSetting and openSetting.itemId
    openSetting = nil
    if panels[currIndex] then
        CSAPI.SetGOActive(panels[currIndex].gameObject, true)
        lastPanel = panels[currIndex]
        panels[currIndex].Refresh(GetData(),elseData)
    else
        ResUtil:CreateUIGOAsync("Achievement/AchievementListView" .. currIndex,rightParent,function (go)
            local lua = ComUtil.GetLuaTable(go)
            lua.Refresh(GetData(),elseData)
            panels[currIndex] = lua
            lastPanel = lua
        end)
    end
    RefreshNew()
end

function GetData()
    if curIndex1 > 1 then
        local cfg = leftCfgs[curIndex1 - 1]
        if cfg.infos and cfg.infos[curIndex2] and cfg.infos[curIndex2].typeNum then
            return AchievementMgr:GetListData(cfg.infos[curIndex2].typeNum)
        end
    end
    return nil
end

function RefreshNew()
    local info1 = FileUtil.LoadByPath("Achievement_New_Recover_1.txt") or {}
    local info2 = FileUtil.LoadByPath("Achievement_New_Recover_2.txt") or {}
    if info1 and #info1> 0 then
        for k, v in ipairs(info1) do
            info2[k] = v
        end
        info1 = nil
    end
    FileUtil.SaveToFile("Achievement_New_Recover_1.txt",info1)
    FileUtil.SaveToFile("Achievement_New_Recover_2.txt",info2)
end

function SetRed()
    for i, v in ipairs(leftPanel.leftItems) do
        local isRed = false
        if i == 1 then
            isRed = AchievementMgr:CheckRed()
        elseif leftCfgs[i - 1] then
            isRed = AchievementMgr:CheckRed2(leftCfgs[i - 1].id)
        end
        v.SetRed(isRed)
    end
    for i, v in ipairs(leftPanel.leftChildItems) do
        local infos = leftCfgs[i-1] and leftCfgs[i-1].infos or nil
        for k, m in ipairs(v) do
            local isRed = false
            if infos and infos[k] then
                isRed = AchievementMgr:CheckRed(infos[k].typeNum)
            end
            m.SetRed(isRed)
        end
    end
end

function OnClickBack()
    if curIndex1 ~= 1 then
        curIndex1 = 1
        RefreshPanel()
    else
        RefreshNew()
        view:Close()    
    end
end

function OnClickHome()
    RefreshNew()
    UIUtil:ToHome();
end