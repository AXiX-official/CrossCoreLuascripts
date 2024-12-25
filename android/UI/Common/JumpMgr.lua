-- 跳转管理
local this = MgrRegister("JumpMgr")

-- id = 40001
function this:Jump(id)
    local cfg = Cfgs.CfgJump:GetByID(id)
    if (cfg and cfg.sName) then
        local func = self:GetFunc(cfg.sName)
        -- Log(cfg);
        if (func) then
            func(cfg)
        end
    else
        print("跳转id不存在:" .. tostring(id))
    end
end

function this:GetFunc(sName)
    if (self.funcs == nil) then
        self.funcs = {}
        self.funcs["Menu"] = self.Menu
        self.funcs["Dungeon"] = self.Dungeon
        self.funcs["DungeonTower"] = self.Dungeon
        self.funcs["DungeonActivity"] = self.DungeonActivity
        self.funcs["DungeonRole"] = self.DungeonActivity
        self.funcs["DungeonShadowSpider"] = self.DungeonActivity
        self.funcs["DungeonPlot"] = self.DungeonActivity
        self.funcs["DungeonFeast"] = self.DungeonActivity
        self.funcs["DungeonTaoFa"] = self.DungeonActivity
        self.funcs["TotalBattle"] = self.DungeonActivity
        self.funcs["BattleField"] = self.DungeonActivity
        self.funcs["TowerView"] = self.DungeonActivity
        self.funcs["RogueView"] = self.DungeonActivity
        self.funcs["DungeonSummer"] = self.DungeonActivity
        self.funcs["RogueSView"] = self.DungeonActivity
        self.funcs["DungeonNight"] = self.DungeonActivity
        self.funcs["GlobalBossView"] = self.DungeonActivity
        self.funcs["ShopView"] = self.Shop
        self.funcs["Section"] = self.Section
        self.funcs["SignInContinue"] = self.SignInContinue
        -- self.funcs["MatrixCompound"] = self.MatrixCompound
        -- self.funcs["MatrixTrading"] = self.MatrixTrading
        self.funcs["SettingView"] = self.Setting
        self.funcs["Matrix"] = self.Matrix
        self.funcs["Dorm"] = self.Dorm
        self.funcs["ActivityListView"] = self.ActivityListView
        self.funcs["SpeicalJump"] = self.SpeicalJump
        self.funcs["AchievementView"] = self.Achievement
        self.funcs["RegressionList"] = self.RegressionList
        self.funcs["LovePlus"] = self.LovePlus
        self.funcs["TWWeb"] = self.TWWeb
        self.funcs["ColosseumView"] = self.ColosseumView
    end
    if (self.funcs[sName]) then
        return self.funcs[sName]
    else
        return self.Normal
    end
end

function this.TWWeb()
    ShiryuSDK.ShowActivityUI(function()
        EventMgr.Dispatch(EventType.Menu_WebView_Enabled) -- 主界面的问卷调查
    end)
end

function this.Menu()
    CSAPI.CloseAllOpenned()
end

-- 跳转到链接
function this.SpeicalJump(cfg)
    if (cfg.page) then
        UnityEngine.Application.OpenURL(cfg.page)
    end
end

-- 是否关闭所有上级界面
function this.CheckClose(cfg)
    if cfg.closeAll == 1 then
        CSAPI.CloseAllOpenned();
    end
end

-- 直接打开
function this.Normal(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
end

function this.ColosseumView(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
    --
    if(CSAPI.IsViewOpen("ColosseumMissionView"))then 
        CSAPI.CloseView("ColosseumMissionView")
    end 
end

-- 设置类型或分页
function this.SetPage(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
end

function this.Dorm(cfg)
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Dorm")
    if (not isOpen) then
        -- LanguageMgr:ShowTips(2310)
        Tips.ShowTips(str)
    else
        if (cfg.page == "DormRoom") then
            this.CheckClose(cfg);
            CSAPI.OpenView(cfg.page)
        else
            LogError("该跳转要特殊处理！" .. cfg.page)
        end
    end
end

-- 打开基地各界面
function this.Matrix(cfg)
    local isOpen, str = MenuMgr:CheckModelOpen(OpenViewType.main, "Matrix")
    if (not isOpen) then
        LanguageMgr:ShowTips(2310)
    else
        local detailView = CSAPI.GetView("DungeonDetail")
        if (detailView) then
            local lua = ComUtil.GetLuaTable(detailView)
            lua.view:Close()
        end
        if (not cfg.page) then
            local scene = SceneMgr:GetCurrScene()
            if (scene.key ~= "Matrix") then
                SceneLoader:Load("Matrix")
            end
            return
        end
        if (cfg.page == "MatrixCreate") then
            this.CheckClose(cfg);
            CSAPI.OpenView("MatrixCreate")
            return
        end

        -- 基地已开启
        local buildType = MatrixMgr:GetBuildingTypeByViewName(cfg.page)
        local buildingData = buildType and MatrixMgr:GetBuildingDataByType(buildType) or nil
        if (buildingData) then
            -- 建筑已建造
            if (buildType == BuildsType.Compound) then
                this.CheckClose(cfg);
                CSAPI.OpenView(cfg.page, buildingData, cfg.val1) -- 合成界面要调整到指定物品
            elseif (buildType == BuildsType.TradingCenter) then
                this.CheckClose(cfg);
                CSAPI.OpenView(cfg.page)
            else
                this.CheckClose(cfg);
                CSAPI.OpenView(cfg.page, buildingData)
            end
        else
            LanguageMgr:ShowTips(2311)
        end
    end
end

-- function this.MatrixCompound(cfg)
--     MatrixMgr:OpenCompoundPanel(cfg.val1)
-- end

-- function this.MatrixTrading(cfg)
--     MatrixMgr:OpenTradingCenter()
-- end

function this.ActivityListView(cfg)
    this.CheckClose(cfg);
    local state, tips = this.ActivityListViewState(cfg)
    if state == JumpModuleState.Normal then
        local data = ActivityMgr:GetALData(cfg.val3)
        if data then
            if data:GetSpecType() == ALType.SignIn then
                local key = SignInMgr:GetDataKeyById(data:GetID())
                ActivityMgr:AddNextOpen2(cfg.val3,{key = key})
            else
                ActivityMgr:AddNextOpen2(cfg.val3, {cfg.val1, cfg.val2})
            end
        end
        CSAPI.OpenView("ActivityListView", nil, cfg.page)
    else
        FuncUtil:Call(function()
            Tips.ShowTips(tips)
        end, nil, 100)
    end
end

function this.SignInContinue(cfg)
    -- if(SignInMgr:SignInIsOpen()) then
    -- 	local _key = SignInMgr:GetDataKey(cfg.val1, cfg.val2)
    -- 	CSAPI.OpenView(cfg.sName, {key = _key})
    -- else
    -- 	LogError("签到未开启,配置错误")
    -- end
    this.CheckClose(cfg);
    local _key = SignInMgr:GetDataKey(cfg.val1, cfg.val2)
    SignInMgr:OpenSignIn(cfg.val3, _key)
end

-- 副本类型/主线、每日
function this.Section(cfg)
    local state, _str = this.SectionState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        local jumpData = {
            type = tonumber(cfg.page),
            group = cfg.val1,
            id = cfg.val2,
            isJump = true
        }
        CSAPI.OpenView(cfg.sName, jumpData);
    else
        FuncUtil:Call(function()
            Tips.ShowTips(_str)
        end, nil, 100)
    end
end

-- 章节/关卡
function this.Dungeon(cfg)
    local state, lockStr = this.DungeonState(cfg);
    if state == JumpModuleState.Normal then
        local detailView = CSAPI.GetView("DungeonDetail") -- 爬塔跳转
        if (detailView) then
            local lua = ComUtil.GetLuaTable(detailView)
            lua.view:Close()
        end
        local sweepView = CSAPI.GetView("SweepView") -- 扫荡跳转
        if (sweepView) then
            local lua = ComUtil.GetLuaTable(sweepView)
            lua.view:Close()
        end
        this.CheckClose(cfg);
        if cfg.val2 == 1 or cfg.val2 == 2 then
            DungeonMgr:SetDungeonHardLv(cfg.val1, cfg.val2);
        end
        CSAPI.OpenView(cfg.sName, {
            id = cfg.val1,
            itemId = cfg.val3,
            state = DungeonOpenType.Jump
        }, nil)
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.DungeonActivity(cfg)
    local state, lockStr = this.DungeonActivityState(cfg);
    if state == JumpModuleState.Normal then
        if CSAPI.IsViewOpen("MissionActivity") then
            local viewGO = CSAPI.GetView("MissionActivity")
            ComUtil.GetLuaTable(viewGO).Close()
        end
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        if sectionData then
            local viewName = cfg.sName
            if viewName == "DungeonActivity" and cfg.page then
                viewName = viewName .. cfg.page
            end
            if sectionData:GetType() == SectionActivityType.BattleField then
                if cfg.val2 == 2 then
                    this.CheckClose(cfg);
                    CSAPI.OpenView("BattleFieldBoss")
                else
                    this.CheckClose(cfg);
                    CSAPI.OpenView(viewName, {
                        id = cfg.val1
                    })
                end
            else
                this.CheckClose(cfg);
                CSAPI.OpenView(viewName, {
                    id = cfg.val1,
                    type = cfg.val2,
                    itemId = cfg.val3
                }, nil)
            end
        else
            if (cfg.sName == "RogueView" or cfg.sName == "RogueSView") then
                local page = cfg.page ~= nil and tonumber(cfg.page) or nil
                CSAPI.OpenView("RogueMain")
                CSAPI.OpenView(cfg.sName, cfg.val1, page)
            else
                CSAPI.OpenView(cfg.sName)
            end
            -- LogError("缺少跳转的章节数据!跳转id:" .. cfg.id)
        end
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

-- 商店
function this.Shop(cfg)
    local state, lockStr = this.ShopState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        if cfg.val1 and cfg.val1 ~= 0 and cfg.val2 == nil and cfg.val3 == nil then -- 打开单个商店
            CSAPI.OpenView(cfg.sName, cfg.val1);
        else
            if cfg.val5 then
                local cId=tonumber(cfg.val5);
                local comm=ShopMgr:GetFixedCommodity(cId);
                if comm:GetType()==CommodityItemType.Skin then --皮肤购买界面不打开商店
                    ShopCommFunc.OpenBuyConfrim(cfg.val2, cfg.val3, cId)
                    do return end;
                end
            end
            CSAPI.OpenView(cfg.sName, nil, {
                [1] = cfg.val2,
                [2] = cfg.val3,
                [3] = cfg.val5
            }); -- val5是要打开购买界面的商品名称
        end
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.Setting(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, tonumber(cfg.page))
end

function this.Achievement(cfg)
    this.CheckClose(cfg);
    CSAPI.OpenView(cfg.sName, nil, {
        group = cfg.val1,
        itemId = cfg.val2
    })
end

function this.RegressionList(cfg)
    local state, lockStr = this.RegressionState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, {
            group = cfg.val1,
            id = cfg.val2
        })
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

function this.LovePlus(cfg)
    local state, lockStr = this.LovePlusState(cfg);
    if state == JumpModuleState.Normal then
        this.CheckClose(cfg);
        CSAPI.OpenView(cfg.sName, {
            id = cfg.page
        }, {
            type = cfg.val1,
            id = cfg.val2
        })
    else
        FuncUtil:Call(function()
            Tips.ShowTips(lockStr)
        end, nil, 100)
    end
end

-- 返回获取跳转状态的方法名
function this:GetStateFunc(sName)
    if (self.stateFuncs == nil) then
        self.stateFuncs = {}
        self.stateFuncs["Dungeon"] = self.DungeonState
        self.stateFuncs["DungeonTower"] = self.DungeonState
        self.stateFuncs["DungeonActivity1"] = self.DungeonActivityState
        self.stateFuncs["DungeonPlot"] = self.DungeonActivityState
        self.stateFuncs["DungeonActivity2"] = self.DungeonActivityState
        self.stateFuncs["BattleField"] = self.DungeonActivityState
        self.stateFuncs["ShopView"] = self.ShopState
        self.stateFuncs["Section"] = self.SectionState
        self.stateFuncs["SignInContinue"] = self.SignInContinueState
        self.stateFuncs["ActivityListView"] = self.ActivityListViewState
        self.stateFuncs["RegressionList"] = self.RegressionState
    end
    if (self.stateFuncs[sName]) then
        return self.stateFuncs[sName]
    else
        return self.ModuleState
    end
end

-- 返回传入的id的跳转状态
function this:GetJumpState(id)
    local type = JumpModuleState.Normal;
    local lockStr = "";
    local cfg = Cfgs.CfgJump:GetByID(id)
    if (cfg and cfg.sName) then
        if cfg.act then -- 检查活动开启状态
            local isOpen = DungeonMgr:IsActiveOpen(cfg.act);
            if isOpen ~= true then
                return JumpModuleState.Close;
            end
        end
        local func = self:GetStateFunc(cfg.sName)
        -- Log(cfg);
        if (func) then
            type, lockStr = func(cfg)
        end
    else
        print("跳转id不存在:" .. tostring(id))
    end
    return type, lockStr;
end

function this.DungeonState(cfg)
    if cfg.val2 == 1 or cfg.val2 == 2 then -- 主线
        local sectionData = DungeonMgr:GetSectionData(cfg.val1)
        local isOpen, tips = sectionData:GetOpen()
        if not isOpen then
            return JumpModuleState.Close, tips;
        end
        local cfgs = sectionData:GetDungeonCfgs(cfg.val2);
        local isOpen = false;
        local tips = nil;
        if cfg.val3 and cfg.val3 > 0 then
            if cfgs then
                isOpen, tips = DungeonMgr:IsDungeonOpen(cfg.val3);
            end
            if isOpen then
                return JumpModuleState.Normal;
            else
                return JumpModuleState.Close, tips;
            end
        else
            return JumpModuleState.Normal;
        end
    elseif cfg.val2 == 3 then -- 活动
        if cfg.val1 == 1001 then -- 爬塔
            return JumpModuleState.Normal
        else
            return JumpModuleState.Normal
        end
    else -- 每日
        local sectionData = DungeonMgr:GetSectionData(cfg.val1);
        if sectionData then
            local isOpen, tips = sectionData:GetOpen()
            if not isOpen then
                return JumpModuleState.Close, tips;
            end
        end
        return JumpModuleState.Normal
    end
end

function this.DungeonActivityState(cfg)
    local sectionData = DungeonMgr:GetSectionData(cfg.val1);
    if sectionData then
        local isOpen, _lockStr = sectionData:GetOpen()
        local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
        if isOpen and openInfo then
            if string.match(cfg.sName, "DungeonActivity") then
                if not openInfo:IsOpen() then
                    isOpen = false
                    _lockStr = LanguageMgr:GetTips(24001)
                end
            else
                if not openInfo:IsDungeonOpen() then
                    isOpen = false
                    _lockStr = LanguageMgr:GetTips(24003)
                end
            end
        end
        if not isOpen then -- 章节开启检测
            return JumpModuleState.Close, _lockStr
        end
        
        if sectionData:GetType() == SectionActivityType.GlobalBoss then
            if DungeonUtil.IsGlobalBossCloseTime(sectionData:GetID()) then
                local openInfo = DungeonMgr:GetActiveOpenInfo2(sectionData:GetID())
                local _cfg = openInfo:GetCfg()
                return JumpModuleState.Close, _cfg.desc
            end
        end

        if cfg.val3 then
            isOpen, _lockStr = DungeonMgr:IsDungeonOpen(cfg.val3)
            if not isOpen then -- 关卡开启检测
                return JumpModuleState.Close, _lockStr
            end
        end
    elseif cfg.val5 then
        local _cfg = Cfgs.CfgActiveEntry:GetByID(cfg.val5)
        if _cfg and _cfg.begTime and _cfg.endTime then
            local sTime = TimeUtil:GetTimeStampBySplit(_cfg.begTime)
            local eTime = TimeUtil:GetTimeStampBySplit(_cfg.endTime)
            if sTime < TimeUtil:GetTime() and eTime >= TimeUtil:GetTime() then
                return JumpModuleState.Normal
            else
                return JumpModuleState.Close, LanguageMgr:GetTips(24003)
            end
        end
    end
    return JumpModuleState.Normal
end

function this.ShopState(cfg)
    local isUnLock, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, cfg.sName)
    if isUnLock then
        return JumpModuleState.Normal;
    else
        return JumpModuleState.Lock, lockStr;
    end
end

function this.SectionState(cfg)
    local sectionData = DungeonMgr:GetSectionData(cfg.val1);
    if sectionData then
        local _isOpen, _str = sectionData:GetOpen()
        if not _isOpen then
            return JumpModuleState.Close, _str;
        end
    end
    if cfg.val2 then --有具体关卡
        local _isOpen,_str = DungeonMgr:IsDungeonOpen(cfg.val2)
        if not _isOpen then
            return JumpModuleState.Close, _str;
        end
    end
    return JumpModuleState.Normal;
end

function this.ActivityListViewState(cfg)
    if cfg.val3 and not ActivityMgr:CheckIsOpen(cfg.val3) then
        return JumpModuleState.Close, LanguageMgr:GetTips(24003)
    end
    return JumpModuleState.Normal;
end

function this.SignInContinueState(cfg)
    return JumpModuleState.Normal;
end

function this.ModuleState(cfg)
    local isUnLock, lockStr = MenuMgr:CheckModelOpen(OpenViewType.main, cfg.sName)
    if isUnLock then
        return JumpModuleState.Normal;
    else
        return JumpModuleState.Lock, lockStr;
    end
end

function this.RegressionState(cfg)
    local isOpen, type = RegressionMgr:IsHuiGui()
    if RegressionMgr:GetTime() <= 0 then
        return JumpModuleState.Lock, LanguageMgr:GetTips(38002);
    end
    if isOpen then
        if cfg.val1 == nil then
            return JumpModuleState.Normal;
        end
        if type == cfg.val1 then
            if cfg.val2 == nil then
                return JumpModuleState.Normal;
            end
            local _cfg = Cfgs.CfgReturningActivity:GetByID(cfg.val1)
            if _cfg and _cfg.infos and #_cfg.infos > 0 then
                for i, info in ipairs(_cfg.infos) do
                    if info.index == cfg.val2 then
                        if not info.IsHide and RegressionMgr:GetActivityEndTime(info.type) > TimeUtil:GetTime() then -- 超过持续时间不显示
                            return JumpModuleState.Normal;
                        else
                            return JumpModuleState.Lock, LanguageMgr:GetTips(38003);
                        end
                    end
                end
            end
        else
            return JumpModuleState.Lock, LanguageMgr:GetTips(38004);
        end
    else
        return JumpModuleState.Lock, LanguageMgr:GetTips(38002);
    end
end

function this.LovePlusState(cfg)
    return JumpModuleState.Normal
end

-- 是否禁止跳转
function this.IsDisableJump(viewKey, jumpID)
    if viewKey and jumpID then
        local cfg = Cfgs.view:GetByKey(viewKey);
        if cfg and cfg.jump_chose then
            for k, v in ipairs(cfg.jump_chose) do
                if jumpID == v or v == -1 then -- (-1代表跳转全部屏蔽)
                    return true;
                end
            end
        end
    end
    return false;
end

function this.Init()
    EventMgr.RemoveListener(EventType.View_Lua_Opened, this.OnViewOpen);
    EventMgr.RemoveListener(EventType.View_Lua_Closed, this.OnViewClose)
    this.openList = {};
    EventMgr.AddListener(EventType.View_Lua_Opened, this.OnViewOpen);
    EventMgr.AddListener(EventType.View_Lua_Closed, this.OnViewClose)
end

function this.OnViewOpen(event)
    table.insert(this.openList, event);
end

function this.OnViewClose(event)
    if #this.openList > 0 then
        local index = 0;
        for i = #this.openList, 1, -1 do
            if this.openList[i] == event then
                index = i;
                break
            end
        end
        if index ~= 0 then
            table.remove(this.openList, index);
        end
    end
end

function this:GetLastViewKey()
    if this.openList and #this.openList > 0 then
        return this.openList[#this.openList];
    end
end

-- 能否跳转 bool,desc
function this:CheckCanJump(id)
    local cfg = Cfgs.CfgJump:GetByID(id)
    if (cfg) then
        if (cfg.sName == "Section") then
            local state, _str = this.SectionState(cfg)
            if (state == JumpModuleState.Normal) then
                return true, ""
            else
                return false, _str
            end
        else
            return MenuMgr:CheckModelOpen(OpenViewType.main, cfg.sName)
        end
    end
    -- return false, "跳转界面不存在"
    return false,LanguageMgr:GetTips(1052);
end

this.Init();

return this
