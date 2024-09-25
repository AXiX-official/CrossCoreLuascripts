-- ui工具
local this = {}
this.active1 = "View_Open_Scale" -- 界面打开
this.active2 = "View_Open_Scale2"
this.active3 = "View_Close_Scale_Smaller" -- 界面关闭
this.active4 = "View_Close_Scale_Smaller2"

-- 入场动画
function this:ShowAction(gameObject, callBack, _actionName)
    if (gameObject) then
        CSAPI.SetScale(gameObject, 0, 0, 0)
        _actionName = _actionName == nil and self.active2 or _actionName
        CSAPI.ApplyAction(gameObject, _actionName, callBack);
    end
end

-- 退场动画
function this:HideAction(gameObject, callBack, _actionName)
    if (gameObject) then
        _actionName = _actionName == nil and self.active4 or _actionName
        CSAPI.ApplyAction(gameObject, _actionName, callBack);
    end
end

-- 获取UI相机对象
function this:GetUICameraGO()
    if (IsNil(self.uiCameraGO)) then
        self.uiCameraGO = CSAPI.GetGlobalGO("UICamera");
    end
    return self.uiCameraGO;
end

-- ui相机
function this:GetUICamera()
    local go = CSAPI.GetGlobalGO("UICamera")
    local camera = ComUtil.GetCom(go, "Camera")
    return camera
end

function this:GetFuncs()
    local Input = CS.UnityEngine.Input
    local GetMouseButton = CS.UnityEngine.Input.GetMouseButton
    local GetMouseButtonDown = CS.UnityEngine.Input.GetMouseButtonDown
    local GetMouseButtonUp = CS.UnityEngine.Input.GetMouseButtonUp
    local Physics = CS.UnityEngine.Physics
    return Input, GetMouseButton, GetMouseButtonDown, GetMouseButtonUp, Physics
end

-- 移动动画，tab={{go=gameObject,pos={0,0,0},func=function,actionFunc=function}} go:要移动的物体，pos:目标位置 func:该物体移动后的回调 actionFunc:移动动画，不传的话默认为UIUtil:DoLocalMove;
function this:PlayMoveList(tab)
    for k, v in ipairs(tab) do
        if v.actionFunc then
            v.actionFunc(v.go, v.pos, v.func);
        else
            self:DoLocalMove(v.go, v.pos, v.func);
        end
    end
end

function this:DoLocalMove(go, pos, callBack)
    CSAPI.csMoveTo(go, "UI_Local_Move", pos[1], pos[2], pos[3], callBack, 0.2);
end

-- 添加顶部栏  货币数据自定义，格式 = {{id,跳转id}......}
function this:AddTopByDatas(viewName, _go, _backCB, _homeCB, _datas)
    local go = ResUtil:CreateUIGO("Top2/Top", _go.transform)
    local tab = ComUtil.GetLuaTable(go)
    tab.Init(_backCB, _homeCB, viewName, _datas)
    CSAPI.SetAnchor(go, 0, 0, 0)
    return tab
end

-- 添加顶部栏 货币数据由View界面决定，策划填写
function this:AddTop2(viewName, _go, _backCB, _homeCB)
    local go = ResUtil:CreateUIGO("Top2/Top", _go.transform)
    local tab = ComUtil.GetLuaTable(go)
    local cfg = Cfgs.view:GetByKey(viewName)
    local _datas = cfg and cfg.Show_CurrencyType
    tab.Init(_backCB, _homeCB, viewName, _datas)
    CSAPI.SetAnchor(go, 0, 0, 0)
    return tab
end

-- 返回基地
function this:ToMatrix()
    local scene = SceneMgr:GetCurrScene()
    if (scene.key ~= "Matrix") then
        SceneLoader:Load("Matrix")
    end
end

-- 返回主界面
function this:ToHome()
    local scene = SceneMgr:GetCurrScene()
    if (scene.key == "MajorCity") then
        CSAPI.CloseAllOpenned()
    else
        SceneLoader:Load("MajorCity")
    end
end

-- 打开界面
function this:OpenView(sViewName, closeAll, cb)
    local cfg = nil
    if (Cfgs.CfgOpenCondition) then
        cfg = Cfgs.CfgOpenCondition:GetByID(sViewName)
    end
    if (cfg) then
        local isOpen, tipsStr = MenuMgr:CheckModelOpen(OpenViewType.main, sViewName) -- self:CheckIsOpen(cfg)
        if (isOpen) then
            local scene = SceneMgr:GetCurrScene()
            if (cfg.sSceneName) then
                if (cfg.sSceneName == scene.key) then
                    -- 在当前场景
                    if (closeAll) then
                        if (CSAPI.IsViewOpen(sViewName)) then
                            CSAPI.CloseAllOpenned(sViewName)
                        else
                            CSAPI.CloseAllOpenned()
                            FuncUtil:Call(cb, nil, 350)
                        end
                    else
                        cb()
                    end
                else
                    -- 不在当前场景
                    SceneLoader:Load(cfg.sSceneName, function()
                        cb()
                    end)
                end
            else
                cb()
            end
        else
            if (not StringUtil:IsEmpty(tipsStr)) then
                Tips.ShowTips(tipsStr)
            end
        end
    else
        cb()
    end
end

-- 打开掉落奖励
function this:OpenReward(data, elseData)
    self:OpenReward2("RewardPanel",data, elseData)
end

function this:OpenSummerReward(data, elseData)
    self:OpenReward2("RewardSummerPanel", data, elseData)
end

-- 打开掉落奖励 优先检查是否有卡牌，有卡牌的情况下先打开卡牌展示界面
function this:OpenReward2(viewPath, data, elseData)
    -- LogError("奖励数据：")
    -- LogError(data)
    if data and #data > 0 then
        local showRoleList = {};
        local showSkinList = {}
        for k, v in ipairs(data[1]) do -- data[1]是奖励数据
            if v.type == RandRewardType.CARD then
                local card = RoleMgr:GetData(v.c_id);
                if card == nil then
                    LogError("未获得卡牌数据：" .. v.c_id);
                elseif card:GetQuantity() < 2 then
                    table.insert(showRoleList, {
                        id = v.c_id,
                        num = card:GetQuantity()
                    });
                elseif card:GetQuality() == CardQuality.SSR or card:GetQuality() == CardQuality.SR then
                    table.insert(showRoleList, {
                        id = v.c_id,
                        num = card:GetQuantity()
                    });
                end
            elseif v.type == RandRewardType.ITEM then
                local cfg = Cfgs.ItemInfo:GetByID(v.id);
                if cfg.type == ITEM_TYPE.CARD and v.c_id then
                    local card = RoleMgr:GetData(v.c_id);
                    if card == nil then
                        LogError("未获得卡牌数据：" .. v.c_id);
                    elseif card:GetQuantity() < 2 then
                        table.insert(showRoleList, {
                            id = v.c_id,
                            num = card:GetQuantity()

                        });
                    elseif card:GetQuality() == CardQuality.SSR or card:GetQuality() == CardQuality.SR then
                        table.insert(showRoleList, {
                            id = v.c_id,
                            num = card:GetQuantity()
                        });
                    end
                elseif cfg.type == ITEM_TYPE.SKIN then
                    local skinInfo = ShopSkinInfo.New()
                    skinInfo:InitCfg(cfg.dy_value2)
                    table.insert(showSkinList, skinInfo)
                end
            end
        end
        if (#showSkinList >= 1) or (#showRoleList >= 1) then
            if (#showRoleList >= 1) then
                CSAPI.OpenView("CreateShowView", {showRoleList}, 2, function(go)
                    local lua = ComUtil.GetLuaTable(go);
                    lua.SetShowRewardPanel(function()
                        if #showSkinList >= 1 then
                            UIUtil:ShowSkinList(showSkinList, data, elseData)
                        else
                            CSAPI.OpenView(viewPath, data, elseData)
                        end
                    end)
                end);
            else
                UIUtil:ShowSkinList(showSkinList, data, elseData)
            end
        else
            CSAPI.OpenView(viewPath, data, elseData)
        end
    end
end

-- 递归播放皮肤展示界面
function this:ShowSkinList(list, data, elseData)
    local skinInfo = table.remove(list, 1)
    CSAPI.OpenView("SkinShowView", skinInfo, nil, function(go)
        local lua = ComUtil.GetLuaTable(go);
        lua.ClickBtn = function()
            if #list > 0 then
                lua.Init()
                UIUtil:ShowSkinList(list, data, elseData)
            else
                CSAPI.OpenView("RewardPanel", data, elseData)
                lua.CloseView();
            end
        end
    end)
end

function this:OpenQuestion(viewKey)
    if (Cfgs.CfgModuleInfo) then
        local cfg = Cfgs.CfgModuleInfo:GetByID(viewKey);
        if (cfg) then
            CSAPI.OpenView("ModuleInfoView", cfg);
        end
    end
end

-- 引导弹窗（不可与新手引导冲突，如冲突则改成非自动弹出）
function this:AddQuestionItem(viewKey, go, father, prefabName)
    prefabName = prefabName == nil and "QuestionItem" or prefabName
    local cfg = nil
    if (Cfgs.CfgModuleInfo) then
        cfg = Cfgs.CfgModuleInfo:GetByID(viewKey)
    end
    if (cfg and cfg.isOpen and go) then
        local tab = ComUtil.GetLuaTable(go)
        if (tab and tab.isHideQuestionItem) then
            return -- 界面不让显示
        end
        if (tab["QuestionItem"] == nil) then
            tab["QuestionItem"] = 1 -- 防止异步生成时有额外的进入
            local parent = father --== nil and go or father
            if(parent == nil) then 
                local tran = go.transform:Find("AdaptiveScreen")
                if(tran~=nil) then 
                    parent = tran.gameObject 
                else 
                    parent = go 
                end 
            end 
            ResUtil:CreateUIGOAsync("ModuleInfo/" .. prefabName, parent, function(itemGo)
                tab["QuestionItem"] = ComUtil.GetLuaTable(itemGo)
                tab["QuestionItem"].Refresh(cfg)
                if tab.OnAddQuestionItem then
                    tab:OnAddQuestionItem(1);
                end
            end)
        else
            if (tab["QuestionItem"] ~= 1) then
                tab["QuestionItem"].Refresh(cfg)
                if tab.OnAddQuestionItem then
                    tab:OnAddQuestionItem(2);
                end
            end
        end
    end
end

-- 异形屏位置转化(传入1334X750下的坐标),anchorIndex对应Anchor九宫格1-9,左到右上到下
function this:TransPos(x, y, anchorIndex)
    local arr = CSAPI.GetScreenSize()
    local ratio = (arr[0] / arr[1]) / (1334 / 750)
    if (ratio > 1) then

    elseif (ratio < 1) then

    end
    return x, y
end

function this:SetDoublePoint(parent, isAdd, x, y, z, scale)
    return self:SetRedPoint2("Common/Double", parent, isAdd, x, y, z, 1)
end

-- 添加或者移除new
function this:SetNewPoint(parent, isAdd, x, y, z, scale)
    return self:SetRedPoint2("Common/NewP", parent, isAdd, x, y, z, 1)
end

-- 添加或者移除红点
function this:SetRedPoint(parent, isAdd, x, y, z)
    return self:SetRedPoint2("Common/Red2", parent, isAdd, x, y, z, 1)
end

-- 添加或者移除红点
function this:SetRedPoint2(path, parent, isAdd, x, y, z, scale)
    if (parent) then
        local go = nil
        isAdd = isAdd == nil and true or isAdd
        x = x or 0
        y = y or 0
        z = z or 0
        scale = scale or 1
        local redName = string.format("%s_%s_%s", x, y, z)
        local red = parent.transform:Find(redName)
        if (not isAdd) then
            if (red) then
                CSAPI.SetGOActive(red.gameObject, false)
                return red.gameObject;
            end
            return go;
        else
            if (red) then
                CSAPI.SetGOActive(red.gameObject, true)
                return red.gameObject;
            else
                go = ResUtil:CreateUIGO(path, parent.transform, x, y, z)
                go.name = redName
                CSAPI.SetScale(go, scale, scale, scale)
                return go
            end
        end
    end
end

-- 设置登陆动画
function this:AddLoginMovie(gameObject)
    -- local isReset = false;
    if IsNil(self.videoGo) then
        local video = ResUtil:PlayVideo("login", gameObject);
        self.videoGo = video.gameObject;
        --	isReset = true
    end
    --	if gameObject and not IsNil(self.videoGo) then
    --		CSAPI.SetParent(self.videoGo, gameObject, isReset)
    --		if isReset == false then
    --			local scale = CSAPI.GetScale(self.videoGo);
    --			CSAPI.SetScale(self.videoGo, scale / 1000, scale / 1000, scale / 1000);
    --		end
    --	end
end

-- 关闭界面时使用
function this:RemoveLoginMovie()
    if not IsNil(self.videoGo) then
        CSAPI.RemoveGO(self.videoGo);
        self.videoGo = nil;
    end
end

-- 打开物品信息框
function this:OpenGoodsInfo(data, openSetting)
    local panelName = "GoodsFullInfo";
    local key = JumpMgr:GetLastViewKey();
    if key then
        local cfg = Cfgs.view:GetByKey(key);
        if cfg then
            panelName = cfg.layer ~= nil and panelName or panelName .. "2";
        end
    end
    CSAPI.OpenView(panelName, {
        data = data,
        key = key
    }, openSetting);
end

-- 打开二次确认框
function this:OpenDialog(_content, okFunc, _cancelFunc, cb)
    local dialogdata = {}
    dialogdata.content = _content
    dialogdata.okCallBack = okFunc
    dialogdata.cancelCallBack = _cancelFunc
    if (cb) then
        CSAPI.OpenView("Dialog", dialogdata, nil, function(go)
            local tab = ComUtil.GetLuaTable(go)
            cb(tab)
        end)
    else
        CSAPI.OpenView("Dialog", dialogdata)
    end
end

-- 打开二次确认框（显示消耗道具） 
-- {titleID,desc,itemID,surecb,cancelcb}
function this:OpenPoputSpendView(titleID, desc, itemID, surecb, cancelcb)
    local dialogdata = {}
    dialogdata.titleID = titleID or 1037
    dialogdata.desc = desc
    dialogdata.itemID = itemID
    dialogdata.surecb = surecb
    dialogdata.cancelcb = cancelcb
    CSAPI.OpenView("PopupSpendView", dialogdata)
end

-- 移动
function this:SetPObjMove(obj, x1, x2, y1, y2, z1, z2, cb, timer, delay)
    local action = ComUtil.GetOrAddCom(obj, "ActionUIMoveTo")
    CSAPI.SetAnchor(obj, x1, y1, z1)
    action.ignoreTimeScale = true
    action:SetStartPos(x1, y1, z1)
    action:SetTargetPos(x2, y2, z2)
    action.isLocal = true
    action.time = timer
    action.delay = delay or 0
    action:ToPlay(cb)
    return action
end

-- 透明度
function this:SetObjFade(obj, from, to, cb, timer, delay, delayValue)
    local action = ComUtil.GetOrAddCom(obj, "ActionFade")
    action.ignoreTimeScale = true
    action.from = from
    action.to = to
    action.time = timer
    action.delay = delay or 0
    if (delayValue) then
        action.delayValue = delayValue
    end
    action:ToPlay(cb)
    return action
end

-- 透明度
function this:SetObjFade2(obj, from, to, cb, timer, delay)
    local action = ComUtil.GetOrAddCom(obj, "ActionFadeCurve")
    action.ignoreTimeScale = true
    action.from = from
    action.to = to
    action.time = timer
    action.delay = delay or 0
    action:ToPlay(cb)
    return action
end

-- 大小
function this:SetObjScale(obj, x1, x2, y1, y2, z1, z2, cb, timer, delay)
    local action = ComUtil.GetOrAddCom(obj, "ActionScaleToTarget")
    action.ignoreTimeScale = true
    CSAPI.SetScale(obj, x1, y1, z1)
    action:SetTargetScale(x2, y2, z2)
    action.isIncrement = true
    action.time = timer
    action.delay = delay or 0
    action:ToPlay(cb)
    return action
end

-- sizeDelta
function this:SetObjSizeDelta(obj, x1, x2, y1, y2, cb, timer, delay)
    local action = ComUtil.GetOrAddCom(obj, "ActionSizeDeltaT")
    action.ignoreTimeScale = true
    action:SetStartSD(x1, y1)
    action:SetTargetSD(x2, y2)
    action.delaySetStartSD = true
    action.time = timer
    action.delay = delay or 0
    action:ToPlay(cb)
    return action
end

-- 自动适配屏幕大小
function this:SetPerfectScale(obj)
    local baseScale = {1920, 1080}
    local curScale = CSAPI.GetMainCanvasSize()
    local nType = self:GetSceneType()
    local scale = 1
    if (nType == 1) then
        -- 长屏
        scale = curScale[0] / baseScale[1]
    elseif (nType == 2) then
        -- 宽屏
        scale = curScale[1] / baseScale[2]
    end
    CSAPI.SetScale(obj, scale, scale, 1)
    return scale
end

-- 0：正常 1:长屏 2：宽屏
function this:GetSceneType()
    local baseScale = {1920, 1080}
    local curScale = CSAPI.GetMainCanvasSize()
    local ratio = (curScale[0] / curScale[1]) / (baseScale[1] / baseScale[2])
    local nType = 0
    if ((ratio - 1) > 0.001) then
        nType = 1
    elseif (1 - ratio) > 0.001 then
        nType = 2
    end
    return nType
end

-- 以该大小相对屏幕大小所应该做的放大缩小比例  scale = {长，宽} 
-- 以最小比例覆盖全屏幕为目的，如果大小本身就比屏幕大，则不处理
function this:GetSceneRate(scale)
    local rate = 1
    local nType = self:GetSceneType()
    if (nType == 1) then
        local curScale = CSAPI.GetMainCanvasSize()
        rate = curScale[0] / scale[1]
    elseif (nType == 2) then
        local curScale = CSAPI.GetMainCanvasSize()
        rate = curScale[1] / scale[2]
    end
    return rate
end

-- 清空引用
function this:RemoveRef(tab)
    if (tab == nil) then
        return
    end
    for k, v in pairs(tab) do
        local t = type(v)
        if (t == "userdata") then
            tab[k] = nil
        end
    end
    tab = nil
end

-- 网络延迟严重时，超过延迟时间没返回任何消息则会显示网络延迟界面，延迟时间内未收到返回消息则会提示重登
function this:AddNetWeakHandle(waitTime)
    waitTime = waitTime or 1000;
    EventMgr.Dispatch(EventType.Net_Loading, waitTime, true);
end

-- 是否点击到UI
function this:IsClickUI()
    if (CSAPI.GetDeviceType() == 3) then
        -- 电脑
        if (GetMouseButtonDown(0)) then
            if (eventCurrent:IsPointerOverGameObject()) then
                return true
            end
        end
    else
        -- 非电脑
        if (Input.touchCount == 1 and Input.GetTouch(0).phase == CS.UnityEngine.TouchPhase.Began) then
            if (eventCurrent:IsPointerOverGameObject(Input.GetTouch(0).fingerId)) then
                return true
            end
        end
    end
    return false
end

-- 记录战斗队伍数据的状态信息
function this:AddFightTeamState(state, desc)
    this.fightTeamState = this.fightTeamState or {};
    this.fightTeamState.time = TimeUtil:GetTime();
    this.fightTeamState.state = state == 1 and "添加" or "清理"
    this.fightTeamState.desc = desc;
end

function this:LogFightTeamState()
    if this.fightTeamState then
        LogError("最后操作战斗队伍的状态：" .. this.fightTeamState.state .. "\t时间：" ..
                     tostring(TimeUtil:GetTimeStr2(this.fightTeamState.time)) .. "\t调用入口：" ..
                     tostring(this.fightTeamState.desc))
    end
end

-- 持有/消耗
function this:GetDownStr(num1, num2)
    local str1 = ""
    if num1 > 9999 then
        local n = num1 / 1000;
        local c = math.floor(n * 10);
        if c % 10 == 0 then
            str1 = tostring(math.floor(n)) .. "K";
        else
            str1 = tostring(c / 10) .. "K";
        end
    else
        str1 = tostring(num1)
    end
    str1 = num1 < num2 and StringUtil:SetByColor(str1, "ff6565") or str1

    local str2 = StringUtil:SetByColor("/" .. num2, "c3c3c8")

    return str1 .. str2
end

--- 设置按钮状态
---@param go any
---@param enable 是否启用
---@param cAlpha 传了则按照传的值显示，否则默认为启用时1，禁用时0.5
function this:SetBtnState(go, enable, cAlpha)
    if go == nil then
        do
            return
        end
    end
    CSAPI.SetImgClicker(go, enable);
    if enable then
        CSAPI.SetGOAlpha(go, cAlpha and cAlpha or 1);
    else
        CSAPI.SetGOAlpha(go, cAlpha and cAlpha or 0.5);
    end
end

-- 打开通用购买界面
---@param title 标题
---@param tips 提示语
---@param count 可购买数量
---@param maxCount 可购买最大数量
---@param cost 单次购买价格
---@param reward 购买的物品
---@param payFunc 购买函数
function this:OpenPurchaseView(title, tips, count, maxCount, cost, reward, payFunc)
    if count <= 0 or maxCount<= 0 then
        local dialogData = {}
        local cfg = Cfgs.ItemInfo:GetByID(reward[1][1])
        dialogData.content = LanguageMgr:GetTips(24009)
        dialogData.okCallBack = function()
            JumpMgr:Jump(cfg and cfg.j_moneyGet or 0)
        end
        CSAPI.OpenView("Dialog", dialogData)
        return
    end
    local data = {}
    data.title = title
    data.tips = tips
    data.count = count
    data.max = maxCount
    data.cost = cost
    data.reward = reward
    data.payFunc = payFunc
    CSAPI.OpenView("UniversalPurchase", data)
end

-- 添加头像+头像框(自己)
function this:AddHeadFrame(parent, scale,frameID, iconID,sel_card_ix)
    self:AddHeadByID(parent, scale, frameID or PlayerClient:GetHeadFrame(), iconID or PlayerClient:GetIconId(),sel_card_ix or PlayerClient:GetSex(),"RoleHead0")
end

-- frameID头像框id，iconID头像id
function this:AddHeadByID(parent, scale, frameID, iconID,sel_card_ix,itemGoName)
    -- 真实性别和头像 
    --local isGirl, frameID = self:GetSexAndID(_frameID)
    scale = scale or 1
    itemGoName = itemGoName or "RoleHead"
    local itemGo = parent.transform:Find(itemGoName)
    if (not itemGo) then
        ResUtil:CreateUIGOAsync("Common/"..itemGoName, parent, function(go)
            local item = ComUtil.GetLuaTable(go)
            item.Refresh(scale, frameID, iconID, sel_card_ix)
        end)
    else
        local item = ComUtil.GetLuaTable(itemGo.gameObject)
        item.Refresh(scale, frameID, iconID, sel_card_ix)
    end
end

-- function this:GetSexAndID(frameID)
--     if (frameID > 10000) then
--         -- 女 
--         return true, frameID / 10
--     else
--         return false, frameID
--     end
-- end

-- 移除头像（头像+头像框）
function this:RemoveHead(parent)
    local itemGo = parent.transform:Find("RoleHead")
    if (itemGo) then
        CSAPI.RemoveGO(itemGo.gameObject)
    end
end

-- 打开成就弹窗
function this:OpenAchieveReward(data, elseData)
    local rewards = elseData
    local closeCallBack = nil
    if rewards then
        closeCallBack = function()
            self:OpenReward({rewards})
        end
    end

    CSAPI.OpenView("RewardAchievement", data, {
        closeCallBack = closeCallBack
    })
end

-- 临时用,设置RT_mix_v2的材质球属性
function this.SetRTAlpha(cameraGO, rawGO)
    if cameraGO == nil or rawGO == nil then
        do
            return
        end
    end
    local img = ComUtil.GetCom(rawGO, "RawImage");
    if img == nil then
        LogError("没找到对应的RawImage脚本！" .. tostring(img == nil) .. "\t" .. tostring(img2 == nil));
        do
            return
        end
    end
    local rt = this.CreateRT();
    local c = ComUtil.GetCom(cameraGO, "Camera");
    c.targetTexture = rt;
    img.texture = rt;
end

-- 创建临时用的RT
function this.CreateRT()
    if CRT then
        return CRT;
    else
        local rtSize = {
            x = 1334,
            y = 750
        };
        local wh = UnityEngine.Screen.width * 1.0 / UnityEngine.Screen.height * 1.0; -- 当前UI的宽高比
        local rtWh = (rtSize.x / rtSize.y); -- rt尺寸的宽高比
        local v2 = UnityEngine.Vector2(0, 0);
        if (UnityEngine.Mathf.Abs(wh - rtWh) <= 0.2) then
            v2 = UnityEngine.Vector2(rtSize.x, rtSize.y);
        else
            v2 = UnityEngine.Vector2(rtSize.y * wh, rtSize.y);
        end
        CRT = UnityEngine.RenderTexture(UnityEngine.Mathf.CeilToInt(v2.x), UnityEngine.Mathf.CeilToInt(v2.y), 24,
            UnityEngine.RenderTextureFormat.ARGB32);
        return CRT;
    end
end

-- 销毁RT
function this.DestoryRT()
    if CRT ~= nil then
        UnityEngine.GameObject.Destroy(CRT);
        CRT = nil;
    end
end

-- 奖励转成带key的 [[10040,30,2]]=》 {{id= 10010,num = 30,type = 2}}
function this.ChangeRewards(_rewards)
    local rewards = {}
    for k, v in ipairs(_rewards) do
        table.insert(rewards,{id = v[1],num = v[2],type = v[3]})
    end
    return rewards
end

--- 打开扫荡界面
---@param cfgId 关卡表id
function this:OpenSweepView(cfgId,buy,cost,gets,payFunc)
    buy = buy or g_DungeonArachnidDailyBuy
    cost = cost or g_DungeonArachnidDailyCost
    gets = gets or g_DungeonArachnidGets
    payFunc = payFunc or function(count)
        PlayerProto:BuyArachnidCount(count)
    end
    local sweepData = SweepMgr:GetData(cfgId)
    if sweepData then
        if sweepData:IsOpen() then
            local OnBuyFunc = function()
                UIUtil:OpenPurchaseView(nil,nil,DungeonMgr:GetArachnidCount(),buy,cost,gets,payFunc)
            end
            CSAPI.OpenView("SweepView",{id = cfgId},{onBuyFunc = OnBuyFunc})
        else
            Tips.ShowTips(sweepData:GetLockStr())
        end
    else
        local cfg = Cfgs.MainLine:GetByID(cfgId)
        if cfg then
            local cfgModUp = Cfgs.CfgModUpOpenType:GetByID(cfg.modUpOpenId)
            if cfgModUp then
                Tips.ShowTips(cfgModUp.sDescription)
            end
        end
    end
end

return this
