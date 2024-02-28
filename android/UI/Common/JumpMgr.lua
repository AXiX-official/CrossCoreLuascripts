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
        self.funcs["Dungeon"] = self.Dungeon
        self.funcs["DungeonTower"] = self.Dungeon
        self.funcs["DungeonActivity1"] = self.DungeonActivity
        self.funcs["DungeonPlot"] = self.DungeonActivity
        self.funcs["DungeonActivity2"] = self.DungeonActivity
        self.funcs["DungeonActivity3"] = self.DungeonActivity
        self.funcs["DungeonRole"] = self.DungeonActivity
        self.funcs["BattleField"] = self.DungeonActivity
        -- self.funcs["RoleListView"] = self.SetPage
        -- self.funcs["Bag"] = self.SetPage
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
    end
    if (self.funcs[sName]) then
        return self.funcs[sName]
    else
        return self.Normal
    end
end

--跳转到链接
function this.SpeicalJump(cfg)
    if(cfg.page) then 
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
    ActivityMgr:AddNextOpen2(cfg.val3, {cfg.val1, cfg.val2})
    CSAPI.OpenView("ActivityListView", nil, cfg.page)
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
            if sectionData:GetType() == SectionActivityType.BattleField then
                if cfg.val2 == 2 then
                    this.CheckClose(cfg);
                    CSAPI.OpenView("BattleFieldBoss")
                else
                    this.CheckClose(cfg);
                    CSAPI.OpenView(cfg.sName, {
                        id = cfg.val1
                    })
                end
            else
                this.CheckClose(cfg);
                CSAPI.OpenView(cfg.sName, {
                    id = cfg.val1,
                    type = cfg.val2,
                    itemId = cfg.val3
                }, nil)
            end
        else
            LogError("缺少跳转的章节数据!跳转id:" .. cfg.id)
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
            CSAPI.OpenView(cfg.sName, nil, {cfg.val2, cfg.val3});
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

        local openInfo = DungeonMgr:GetActiveOpenInfo(sectionData:GetActiveOpenID())
        if isOpen and openInfo then
            if cfg.sName == "DungeonActivity3" then
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

        if cfg.val3 then
            isOpen, _lockStr = DungeonMgr:IsDungeonOpen(cfg.val3)
            if not isOpen then -- 关卡开启检测
                return JumpModuleState.Close, _lockStr
            end
        end
        return JumpModuleState.Normal
    end
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
    return JumpModuleState.Normal;
end

function this.ActivityListViewState(cfg)
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
    return false, "跳转界面不存在"
end

this.Init();

return this
