--[[
    10010:阿尔卑斯 UI_GangTieBiLei
    40310 荧:      UI_LieHeXinYun
    60050：纳格陵   Naglering
    20110：琶音     CharacterBanner_Arpeggio
    70050：哈迪斯    CharacterBanner_Hades    
    40400：坍陨      Collapsar
    30400:巴德兰兹  
]] local datas = nil
local perX = 0
-- local entTime = nil -- 下次检测时间点
local timer = 0

local needTime2 = nil
local timer2 = 0
local minStartTime, minEndTime = nil, nil

function Awake()
    CSAPI.PlayUISound("ui_window_open_load")
    image_bdPanel = ComUtil.GetCom(bdPanel, "Image")
end

function OnInit()
    top = UIUtil:AddTop2("CreateView", gameObject, function()
        view:Close()
    end, nil, {})
    -- top.SetCreateBtn(true)

    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Role_Create_Finish, ERoleCreateFinish)
    eventMgr:AddListener(EventType.Role_FirstCreate_Finish, ERoleFirstCreateFinish)
    -- eventMgr:AddListener(EventType.CardCool_Cnts_Update, ECardCoolCntsUpdate)
    eventMgr:AddListener(EventType.Role_Create_Ani_Disable_Skip, SetAniDisableSkipBtnState)
    eventMgr:AddListener(EventType.Role_Create_SetCard, SetBtnBD)
    -- eventMgr:AddListener(EventType.Bag_Update, SetTop2)
    --
    -- SetTop2()
end

function OnDestroy()
    eventMgr:ClearListener()

    ReleaseCSComRefs()
end

-- 开箱动画是否隐藏跳过按钮
function SetAniDisableSkipBtnState(state)
    disableSkipBtnState = state;
end

-- 建造回调
function ERoleCreateFinish(proto)
    if (proto.infos) then
        local quality_up = proto.quality_up -- 品质提升
        CSAPI.OpenView("CreateShowView", {proto.infos, proto.card_pool_id, quality_up, disableSkipBtnState})
    end
    -- 卡池是否已移除
    if (curData and curData:CheckIsRemove()) then
        curIndex = nil
        RefreshPanel()
    else
        -- 刷新累计抽卡
        -- ECardCoolCntsUpdate()
    end
    SetBtnBD()
end

-- 首抽10连回调/完成回调
function ERoleFirstCreateFinish(proto)
    if (proto and proto.hadGetLog) then
        local quality_up = proto.last_op.quality_up -- 品质提升
        CSAPI.OpenView("CreateShowView", {proto.hadGetLog, proto.card_pool_id, quality_up}, 3)
    end
    if (curData and curData:CheckIsRemove()) then
        curIndex = nil
        RefreshPanel()
    end
end

function Update()
    if (Time.time > timer and (minStartTime ~= nil or minEndTime ~= nil)) then
        timer = Time.time + 1
        if ((minEndTime ~= nil and TimeUtil:GetTime() > minEndTime) or
            (minStartTime ~= nil and TimeUtil:GetTime() > minStartTime)) then
            minEndTime = nil
            minStartTime = nil
            RefreshPanel()
        end
    end
end

function OnOpen()
    RefreshPanel()
end

function RefreshPanel()
    SetDatas()
    SetItems()
    CheckTime()
end

-- 通关1002前把卡池1001放最前面
function SetDatas()
    datas = {}
    local _datas = CreateMgr:GetArr()
    local isPass = true
    if (g_CardPoolBtnSort) then
        local _cfg = Cfgs.CfgOpenRules:GetByID(g_CardPoolBtnSort)
        if (_cfg and _cfg.val) then
            isPass = DungeonMgr:CheckDungeonPass(_cfg.val)
            if (not isPass) then
                local index = nil
                for k, v in pairs(_datas) do
                    if (v:GetId() == 1001) then
                        index = k
                    else
                        table.insert(datas, v)
                    end
                end
                if (index) then
                    table.insert(datas, 1, _datas[index])
                end
            end
        end
    end
    if (isPass) then
        datas = _datas
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Create/CreateBtn", items, datas, grid, ClickBtnItemCB, 1, nil, ClickFirst)
end

function ClickFirst()
    local index = 1
    if (openSetting) then
        for k, v in ipairs(datas) do
            if (v:GetId() == openSetting) then
                index = k
                break
            end
        end
        openSetting = nil
    end
    ClickBtnItemCB(index) -- 默认选中第一个数据
end

function CheckTime()
    minStartTime, minEndTime = CreateMgr:GetRefreshTime()
end

function ClickBtnItemCB(index)
    if (curIndex and curIndex == index) then
        return
    end

    if (curIndex) then
        items[curIndex].SetSelect(false)
    end
    curIndex = index
    items[curIndex].SetSelect(true)

    curData = datas[curIndex]

    -- SetCreateBuild()
    -- bg
    SetBgs()

    -- 底部按钮
    SetDowns()

    -- 首抽未完
    SetContinue()

    -- 累计抽卡界面 当前版本没有
    -- ECardCoolCntsUpdate()
    -- 保底列表
    SetBtnBD()

    -- 查看按钮
    SetLookItems()

    -- effect 卡池特效
    SetEffect()

    --
    SetShowTime()
end

function SetShowTime()
    local showTimes = curData:GetCfg().showTimes
    CSAPI.SetGOActive(timeObj, showTimes ~= nil)
    if (showTimes ~= nil) then
        for k, v in ipairs(showTimes) do
            CSAPI.SetText(this["txtTime" .. k], showTimes[k])
        end
    end
end

function SetEffect()
    -- bg 
    if (curBgEffectGO) then
        CSAPI.RemoveGO(curBgEffectGO)
    end
    CSAPI.SetGOActive(effect_bg, curData:GetCfg().effect_bg ~= nil)
    if (curData:GetCfg().effect_bg) then
        local res = string.format("CardPool/%s/effect_bg", curData:GetCfg().effect_bg)
        ResUtil:CreateEffect(res, 0, 0, 0, effect_bg, function(go)
            curBgEffectGO = go
        end)
    end
    -- imgbg 
    if (curImgBgEffectGO) then
        CSAPI.RemoveGO(curImgBgEffectGO)
    end
    CSAPI.SetGOActive(effect_imgbg, curData:GetCfg().effect_imgbg ~= nil)
    if (curData:GetCfg().effect_imgbg) then
        local res = string.format("CardPool/%s/effect_imgbg", curData:GetCfg().effect_imgbg)
        ResUtil:CreateEffect(res, 0, 0, 0, effect_imgbg, function(go)
            curImgBgEffectGO = go
        end)
    end
    -- img 
    if (curImgEffectGO) then
        CSAPI.RemoveGO(curImgEffectGO)
    end
    CSAPI.SetGOActive(effect_img, curData:GetCfg().effect_img ~= nil)
    if (curData:GetCfg().effect_img) then
        local res = string.format("CardPool/%s/effect_img", curData:GetCfg().effect_img)
        ResUtil:CreateEffect(res, 0, 0, 0, effect_img, function(go)
            curImgEffectGO = go
        end)
    end
end

function SetLookItems()
    local look_cards = curData:GetCfg().look_cards or {}
    lookItems = lookItems or {}
    ItemUtil.AddItems("Create/CreateLookItem", lookItems, look_cards, icon)
end

function SetBgs()
    -- bg 
    local scale = UIUtil:SetPerfectScale(bg) -- 适配大小
    UIUtil:SetObjScale(bg, scale + 0.1, scale, scale + 0.1, scale, 1, 1, nil, 500, 1)
    ResUtil:LoadBigImg(bg, "UIs/Create/" .. curData:GetCfg().bg .. "/bg", true)

    local icon3Str = curData:GetCfg().icon3
    -- icon1 
    local nType = UIUtil:GetSceneType()
    local x = icon3Str ~= nil and -300 or 500
    local y = 0--nType == 2 and -40 or 0 -- 宽屏提高40 

    CSAPI.SetGOActive(icon, false)
    ResUtil:LoadBigImg(icon, "UIs/Create/" .. curData:GetCfg().icon1 .. "/bg", true, function()
        CSAPI.SetGOActive(icon, true)
        UIUtil:SetPObjMove(icon, x, 0, y, y, 0, 0, nil, 500, 1)
        UIUtil:SetObjFade(icon, 0, 1, nil, 500, 1)
    end)

    -- icon3 机神图
    CSAPI.SetGOActive(iconjs, false)
    if (icon3Str ~= nil) then
        ResUtil:LoadBigImg(iconjs, "UIs/Create/" .. curData:GetCfg().icon3 .. "/bg", true, function()
            CSAPI.SetGOActive(iconjs, true)
            UIUtil:SetObjScale(iconjs, 1.1, 1, 1.1, 1, 1, 1, nil, 500, 1)
            UIUtil:SetObjFade(iconjs, 0, 1, nil, 500, 1)
        end)
    end
end

-- --创建建筑面板
-- function SetCreateBuild()
-- 	if(curData) then
-- 		--SetLeft()
-- 		--SetRole()
-- 		SetRight()
-- 	end
-- end
-- function SetLeft()
-- 	--time
-- 	SetTime()
-- 	--模型图
-- 	--SetModelInfo()
-- end
--[[function SetTime()
	needTime2 = curData:GetEndTime()
	if(needTime2) then
		needTime2 = needTime2 - TimeUtil:GetTime()
		needTime2 = needTime2 > 0 and needTime2 or nil
	else
		needTime2 = nil
	end
	if(not needTime2) then
		CSAPI.SetText(txtTime1, "")
		CSAPI.SetText(txtTime2, "")
	else
		local timeDatas = TimeUtil:GetTimeTab(needTime2)
		CSAPI.SetText(txtTime1, "剩余时间")
		CSAPI.SetText(txtTime2, string.format("%s天%s时%s分", timeDatas[1], timeDatas[2], timeDatas[3]))
	end
end
]]
-- function SetModelInfo()
-- 	local iconName = curData:GetCfg().cardeModel
-- 	CSAPI.SetGOActive(btnLook, iconName ~= nil)
-- 	if(iconName) then
-- 		ResUtil.Kacha:Load(btnLook, iconName)
-- 	end
-- end
-- function SetRole()
-- 	local cfgid = curData:GetCfg().coverCardId
-- 	local cardCfg =	Cfgs.CardData:GetByID(cfgid)

-- end
-- function SetRight()
-- 	--展示卡牌的信息
-- 	SetCardInfo()
-- end
function SetDowns()
    local conditions = curData:GetCfg().conditions
    -- CSAPI.SetGOActive(down, conditions == nil)
    -- CSAPI.SetGOActive(down2, conditions ~= nil)	
    if (conditions) then
        SetDown2(conditions)
    else
        SetDown1()
    end
end

-- function SetCardInfo()
-- 	local iconName = curData:GetCfg().cardName
-- 	CSAPI.SetGOActive(rightIcon, iconName ~= nil)
-- 	if(iconName) then
-- 		ResUtil.Kacha:Load(rightIcon, iconName)
-- 	end
-- end
function SetDown1()
    CSAPI.SetGOActive(btn3, false)
    CSAPI.SetGOActive(btnTips, false)

    -- l
    local cnt = curData:GetCfg().cnt
    CSAPI.SetGOActive(btn1, cnt ~= nil)
    if (cnt) then
        local jCost = curData:GetCfg().jCost
        local spendName = jCost ~= nil and "btn_4_04" or "btn_5_04"
        CSAPI.LoadImg(spend1, "UIs/Create/" .. spendName .. ".png", true, nil, true)
        -- CSAPI.SetGOActive(spend1, jCost ~= nil)
        -- CSAPI.SetGOActive(icon1, jCost ~= nil)
    end
    -- r 
    local multiCnt = curData:GetCfg().multiCnt
    CSAPI.SetGOActive(btn2, cnt ~= nil)
    if (multiCnt) then
        local multiCost = curData:GetCfg().multiCost
        local spendName = multiCost ~= nil and "btn_5_03" or "btn_5_04"
        CSAPI.LoadImg(spend2, "UIs/Create/" .. spendName .. ".png", true, nil, true)
        -- CSAPI.SetGOActive(spend2, multiCost ~= nil)
        -- CSAPI.SetGOActive(icon2, multiCost ~= nil)
    end
end

-- 条件抽卡
function SetDown2(conditions)
    CSAPI.SetGOActive(btn1, false)
    CSAPI.SetGOActive(btn2, false)

    CSAPI.SetGOActive(btnTips, true)

    local _isOpen, lockStr = MenuMgr:CheckConditionIsOK(conditions)
    local multiCnt = curData:GetCfg().multiCnt -- 多抽是否存在
    CSAPI.SetGOActive(btn3, multiCnt ~= nil)

    -- num
    local multiCost = curData:GetCfg().multiCost
    local spendName = multiCost ~= nil and "btn_5_03" or "btn_5_04"
    CSAPI.LoadImg(spend3, "UIs/Create/" .. spendName .. ".png", true, nil, true)
    -- CSAPI.SetGOActive(spend3, multiCost ~= nil)
    -- CSAPI.SetGOActive(icon3, multiCost ~= nil)
    -- lock str
    CSAPI.SetGOActive(imgLock, not _isOpen)
    CSAPI.SetGOActive(txtLock, not _isOpen)
    CSAPI.SetGOActive(txtExpend3, _isOpen)

    CSAPI.SetText(txtLock, lockStr or "")

    isOpen = _isOpen
end
--[[--条件抽卡
function SetDown2(conditions)
	local _isOpen, lockStr = MenuMgr:CheckConditionIsOK(conditions)
	isOpen = _isOpen
	CSAPI.SetGOActive(lock2, not isOpen)
	CSAPI.SetText(txtLock2, lockStr)
	--
	btn3Canvas = ComUtil.GetCom(btnCreate3, "CanvasGroup")
	btn3Canvas.alpha = isOpen and 1 or 0.5
	--btn3
	if(curData:GetCfg().multiCnt) then
		CSAPI.SetGOActive(btnCreate3, true)
		local multiCost = curData:GetCfg().multiCost
		if(multiCost) then
			CSAPI.SetGOActive(Text3, true)
			local index = #multiCost
			for i, v in ipairs(multiCost) do
				local count = BagMgr:GetCount(v[1])
				if(count >= v[2]) then
					index = i
					break
				end
			end
			SetItem(icon3, txtExpend3, multiCost[index])
		else
			CSAPI.SetGOActive(Text3, false)
		end
	else
		CSAPI.SetGOActive(Text3, false)
		CSAPI.SetGOActive(btnCreate3, false)
	end
end


function SetItem(_icon, _txt, _cost, _num)
	_num = _num or 1
	local cfg = Cfgs.ItemInfo:GetByID(_cost[1])
	if(cfg and cfg.icon) then
		ResUtil.IconGoods:Load(_icon, cfg.icon, true)
	end
	CSAPI.SetText(_txt, _cost[2] * _num .. "")
end
]]
function CheckEndough(costs, cnt)
    local enough = true
    local str = ""
    if (curData:GetCfg().nType == 2) then
        -- 要全部满足
        for i, v in ipairs(costs) do
            local need = v[2]
            local have = BagMgr:GetCount(v[1])
            if (have < need) then
                enough = false
                break
            end
            local cfg = Cfgs.ItemInfo:GetByID(v[1])
            local _str = LanguageMgr:GetByID(10060, StringUtil:SetByColor(need, "FFC146"),
                StringUtil:SetByColor(cfg.name, "FFC146"))
            if (i == 1) then
                str = _str
            else
                str = str .. "、" .. _str
            end
        end
    else
        enough = false
        -- 满足一个即可
        for i, v in ipairs(costs) do
            local need = v[2]
            local have = BagMgr:GetCount(v[1])
            local cfg = Cfgs.ItemInfo:GetByID(v[1])
            if (have >= need) then
                str = LanguageMgr:GetByID(10060, StringUtil:SetByColor(need, "FFC146"),
                    StringUtil:SetByColor(cfg.name, "FFC146"))
                enough = true
                break
            end
        end
    end
    if (enough == false) then
        -- 微晶是否足够
        local count = CreateMgr:GetExchangeCount(1002)

        local costData = costs and costs[1];
        local have = BagMgr:GetCount(costData and costData[1]) or 0;

        local cfgID = have + count >= cnt and 1002 or 1003
        CSAPI.OpenView("CreateBuy", {curData:GetCfg().id, cnt, cfgID})
    end
    return enough, str
end

function OnClickCreate1()
    local enough, _str = CheckEndough(curData:GetCfg().jCost, 1)
    if (enough) then
        Create(_str, 1)
    end
end

function OnClickCreate2()
    -- if(curData:GetCfg().nType == 2) then --弃用
    -- 	local jCost = curData:GetCfg().jCost
    -- 	local enough, _str = true, LanguageMgr:GetTips(10006)
    -- 	if(jCost) then
    -- 		enough, _str = CheckEndough(jCost, curRCnt)
    -- 	end
    -- 	if(enough) then
    -- 		Create(_str, curRCnt)
    -- 	end
    -- else
    local multiCost = curData:GetCfg().multiCost
    local enough, _str = true, LanguageMgr:GetTips(10006)
    if (multiCost) then
        enough, _str = CheckEndough(multiCost, 10)
    end
    if (enough) then
        Create(_str, 10)
    end
    -- end
end

function OnClickCreate3()
    if (isOpen) then
        OnClickCreate2()
    else
        local conditions = curData:GetCfg().conditions
        local _isOpen, lockStr = MenuMgr:CheckConditionIsOK(conditions)
        Tips.ShowTips(lockStr)
    end
end

function Create(_str, _cnt)
    if (g_CardPoolDailyUseLimit) then
        local surplus = g_CardPoolDailyUseLimit - CreateMgr.daily_use_cnt
        if (_cnt > surplus) then
            -- Tips.ShowTips("今天构建次数已达到上限，无法继续构建。")
            LanguageMgr:ShowTips(10005)
            return
        end
    end
    if (curData:GetCfg().nType == 2) then
        local cnt = CreateMgr:GetCreateCnt()
        if (cnt >= g_CardCreateMaxSize) then
            -- 已达核心研发室上限
            return
        end
    end

    -- 提示面板
    local jump = false
    local day = TimeUtil:GetTime3("day")
    local dayRecord = PlayerPrefs.GetString(PlayerClient:GetUid() .. "CreateTips_Day", "0")
    if (dayRecord ~= "0" and dayRecord == tostring(day)) then
        jump = true
    end
    if (not jump) then
        local str = ""
        if (_cnt == 10 and not curData:GetCfg().multiCost) then
            str = _str
        else
            str = LanguageMgr:GetTips(10000, _str, _cnt)
        end
        CSAPI.OpenView("CreateSelectPanel", {
            content = str,
            id = curData:GetCfg().id,
            cnt = _cnt
        })
    else
        CreateMgr:CardCreate(curData:GetCfg().id, _cnt)
    end
end

function SetBtnBD()
    CSAPI.SetGOActive(bdPanel, curData:GetCfg().sel_card_ids ~= nil)
    if (not bdPanel.activeSelf) then
        return
    end
    local ix = curData:GetCfg().def_sel_card_ix
    CSAPI.SetGOActive(btnBD, ix == nil)

    local strId = 17046
    local self_info = curData:GetBDData()
    if (self_info and self_info.num) then
        CSAPI.SetGOActive(bdEntity, true)
        CSAPI.SetGOActive(bdEmpty, false)

        local num = curData:GetCfg().sel_quality_cnt - self_info.type - 1
        local str = ""
        if (num == 0) then
            str = LanguageMgr:GetByID(17055, curData:GetCfg().sel_quality)
        else
            str = LanguageMgr:GetByID(17049, num)
        end
        CSAPI.SetText(txtBD2, str)
        -- item
        local _cfg = Cfgs.CardData:GetByID(self_info.num)
        if (not bgItem) then
            ResUtil:CreateUIGOAsync("RoleLittleCard/CreateBDItem", bdEntity, function(go)
                CSAPI.SetScale(go, 0.74, 0.74, 1)
                bgItem = ComUtil.GetLuaTable(go)
                bgItem.SetClickActive(false)
                bgItem.Refresh(_cfg)
            end)
        else
            bgItem.Refresh(_cfg)
        end
        -- btntxt
        strId = 17047
    else
        CSAPI.SetGOActive(bdEntity, false)
        CSAPI.SetGOActive(bdEmpty, true)
        -- CSAPI.SetGOActive(bdRoleBg, false)
    end
    LanguageMgr:SetText(txtBtnBD, strId)

    -- btn 
    image_bdPanel.raycastTarget = ix == nil
end

-- --查看详情
-- function OnClickLook()
-- 	local _cardData = RoleMgr:GetMaxFakeData(curData:GetCfg().coverCardId)
-- 	CSAPI.OpenView("RoleInfo", _cardData, RoleInfoOpenType.LookNoGet)
-- end
-- 概率面板
function OnClickProb()
    -- CSAPI.OpenView("CreateInfoPanel", curData)
    CSAPI.OpenView("CreateDetail", curData)
end

-- 存在首次未完成，则弹出奖励界面继续抽
function SetContinue()
    local needContinue = curData:CheckNeedContinue()
    CSAPI.SetGOActive(mask, needContinue)
    if (needContinue) then
        -- 打开奖励面板
        local _rewards = {}
        local isSave = curData:GetIsSvale()
        if (not isSave) then
            local lastOP = curData:GetLastOP()
            _rewards = lastOP.rewards
        else
            local logs = curData:GetLogs()
            _rewards = logs[#logs].rewards
        end
        local rewards = {}
        for i, v in ipairs(_rewards) do
            table.insert(rewards, {
                id = v.id,
                num = v.num,
                type = RandRewardType.CARD
            })
        end
        CSAPI.OpenView("CreateRoleView", {rewards, true, curData:GetId()})
    end
end

-- 说明
function OnClickTips()
    local str = LanguageMgr:GetTips(10007)
    UIUtil:OpenDialog(str, nil, nil, function(tab)
        CSAPI.SetGOActive(tab.btn_cancel, false)
        CSAPI.SetAnchor(tab.btn_ok, 0, -152, 0)
    end)
end

-- --记录
-- function OnClickRecord()
-- 	PlayerProto:GetCreateCardLogs(curData:GetCfg().id, function(proto)
-- 		if(proto.logs and #proto.logs > 0) then
-- 			CSAPI.OpenView("CreateRecord", proto)
-- 		else
-- 			LanguageMgr:ShowTips(10010)
-- 		end
-- 	end)
-- end

-- 保底选择
function OnClickBD()
    CSAPI.OpenView("CreateBDPanel", curData)
end

--------------------------------拖拽-----------------------------------------------------------
function OnBeginDragXY(x, y)
    perX = x
end

function OnEndDragXY(x, y)
    if (x - perX > 300) then
        ChangeBtnItems(true)
    elseif (x - perX < -300) then
        ChangeBtnItems(false)
    end
end

-- 循环
function ChangeBtnItems(isLeft)
    if (#datas <= 1) then
        return
    end
    local _curIndex = nil
    if (isLeft) then
        _curIndex = (curIndex - 1) < 1 and #datas or (curIndex - 1)
    elseif (not isLeft) then
        _curIndex = (curIndex + 1) > #datas and 1 or (curIndex + 1)
    end
    ClickBtnItemCB(_curIndex)
end

-- -- {g_CreateSpendID, ITEM_ID.DIAMOND}
-- -- 钱之类
-- function SetTop2()
--     local ids = {g_CreateSpendID, ITEM_ID.DIAMOND, ITEM_ID.DIAMOND, 10040, 10040}
--     -- icon 
--     for k, v in ipairs(ids) do
--         local iconName = Cfgs.ItemInfo:GetByID(v).icon
--         if (iconName) then
--             ResUtil.IconGoods:Load(this["moneyIcon" .. k], iconName .. "_1", true)
--         end
--     end
--     local iconName = Cfgs.ItemInfo:GetByID(g_CreateSpendID).icon
--     ResUtil.IconGoods:Load(this["moneyIcon2_2"], iconName .. "_1", true)
--     ResUtil.IconGoods:Load(this["moneyIcon4_2"], iconName .. "_1", true)
--     -- value 
--     local values = {}
--     -- 1
--     table.insert(values, BagMgr:GetCount(ids[1]))
--     -- 2
--     table.insert(values, CreateMgr:GetExchangeCount(1001))
--     -- 3 
--     table.insert(values, BagMgr:GetCount(ids[3]))
--     -- 4 
--     table.insert(values, CreateMgr:GetExchangeCount(1002))
--     -- 5 
--     table.insert(values, BagMgr:GetCount(ids[5]))
--     for k, v in ipairs(values) do
--         CSAPI.SetText(this["txtMoney" .. k], v .. "")
--     end
-- end

-- -- 资源跳转
-- function OnClickMoney1()

-- end

-- function OnClickMoney2()
--     JumpMgr:Jump(140001);
-- end

-- function OnClickMoney3()
--     JumpMgr:Jump(140012);
-- end

--[[-----------------------------------------------累计抽卡------------------------------------------------------------
--刷新累计抽卡
function ECardCoolCntsUpdate()
	childPoolID = nil
	local childIds = curData:GetCfg().childIds
	CSAPI.SetGOActive(childPanel, childIds ~= nil)
	if(childIds ~= nil) then
		--num
		local index = 0 --当前第几次奖励，0表示已全部抽完
		local childCfg = nil
		for i, v in ipairs(childIds) do
			childCfg = Cfgs.CfgCardPool:GetByID(v[2])
			local myNum1 = CreateMgr:GetCreateCnt(v[2])
			if(myNum1 < childCfg.multiCnt) then
				index = i
				break
			end
		end
		
		local num2 = #childIds
		local num1 = index == 0 and num2 or index - 1
		local str1 = num2 > 1 and string.format("%s/%s", num1, num2) or ""
		CSAPI.SetText(txtChild4, str1)
		
		--str
		if(num2 > 1) then
			LanguageMgr:SetText(txtChild2, 17018)
		else
			LanguageMgr:SetText(txtChild2, 17017)
		end
		
		--slider 
		if(c_slider == nil) then
			c_slider = ComUtil.GetCom(Slider, "Slider")
		end
		local totalCnt = CreateMgr:GetTotalCreateCnt(curData:GetId())
		if(index == 0) then
			c_slider.value = 1
		else		
			local cur = index == 1 and totalCnt or(totalCnt - childIds[index - 1] [1])
			local max = index == 1 and childIds[index] [1] or(childIds[index] [1] - childIds[index - 1] [1])
			local value = index == 0 and 1 or cur / max
			c_slider.value = value
		end
		
		--达成
		CSAPI.SetGOActive(txtChild5, index == 0)
		
		--btn 
		if(not canvasGroup_childbtn) then
			canvasGroup_childbtn = ComUtil.GetCom(btnChildCreate, "CanvasGroup")
		end
		alpha = 1
		if(index == 0 or totalCnt < childIds[index] [1]) then
			alpha = 0.3
		end
		canvasGroup_childbtn.alpha = alpha
		if(index == 0) then
			LanguageMgr:SetText(txtChildCreate, 17020)
		else
			LanguageMgr:SetText(txtChildCreate, 17021, childCfg.multiCnt)
		end
		--
		childPoolID = childCfg.id
	end
end

--构建
function OnClickChildCreate()
	if(childPoolID and alpha == 1) then
		local childCfg = Cfgs.CfgCardPool:GetByID(childPoolID)
		local cost = childCfg.multiCost[1]
		local str = LanguageMgr:GetByID(17023, cost[2], Cfgs.ItemInfo:GetByID(cost[1]).name)
		UIUtil:OpenDialog(str, function()
			if(BagMgr:GetCount(cost[1]) >= cost[2]) then
				CreateMgr:CardCreate(childPoolID, childCfg.multiCnt)
			else
				LanguageMgr:ShowTips(1004)
			end
		end)
		
	end
end


-- 
function OnClickChildInfo()
	local _curData = CreateMgr:GetData(childPoolID)
	CSAPI.OpenView("CreateInfoPanel", _curData)
end

function OnClickChildTips()
	CSAPI.OpenView("CreateTips", childPoolID)
end 

]]
----#Start#----
----释放CS组件引用（生成时会覆盖，请勿改动，尽量把该内容放置在文件结尾。）
function ReleaseCSComRefs()
    gameObject = nil;
    transform = nil;
    this = nil;
    bg = nil;
    icon = nil;
    maskL = nil;
    maskR = nil;
    left = nil;
    timeObj = nil;
    txtTime1 = nil;
    txtTime2 = nil;
    childPanel = nil;
    Slider = nil;
    txtChild1 = nil;
    txtChild2 = nil;
    txtChild3 = nil;
    txtChild4 = nil;
    txtChild5 = nil;
    btnChildCreate = nil;
    txtChildCreate = nil;
    txtChildInfo = nil;
    txtChildTips = nil;
    right = nil;
    Text = nil;
    grid = nil;
    btn1 = nil;
    spend1 = nil;
    icon1 = nil;
    txtExpend1 = nil;
    btn2 = nil;
    spend2 = nil;
    icon2 = nil;
    txtExpend2 = nil;
    btn3 = nil;
    icon3 = nil;
    spend3 = nil;
    lock = nil;
    imgLock = nil;
    txtLock = nil;
    txtExpend3 = nil;
    btnTips = nil;
    txtTips = nil;
    view = nil;
end
----#End#----
