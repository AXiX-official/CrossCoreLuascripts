-- 背景图的位置
local bgPos = {{14, 0}, {-78, 19}, {-44, 21}, {-78, 19}, {-23.8, 22.5}, {0, 32}}
local closePos = {{662, 310}, {537.8, 322.1}, {716,321}, {537.8, 322.1}, {568.1, 249.6}, {657, 237}}
local skipPos = {{607.2, -415.6}, {229, -430}, {-550, 402}, {229, -430}, {513.1, -365.6}, {590.9, -327.8}}

local curItem = nil
local endTime = nil

function OnInit()
    eventMgr = ViewEvent.New()
    -- 3点刷新 签到检查
    eventMgr:AddListener(EventType.Update_Everyday, function()
        RefreshPanel()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    data = MenuBuyMgr:GetCurData()
    data:SetPush(false)
    RefreshPanel()
end

function Update()
    if (endTime and TimeUtil:GetTime() > endTime) then
        endTime = nil
        view:Close()
    end
end

function RefreshPanel()
    cfg = data:GetCfg()

    SetBg()
    -- node
    local len = #Cfgs.CfgPayNoticeWindow:GetAll()
    for i = 1, len do
        CSAPI.SetGOActive(this["node" .. i], data:GetID() == i)
    end
    local func = this["SetNode" .. data:GetID()]
    func()
    --
    SetClose()
    SetTips()
    -- time
    endTime = data:GetEndTime()
end

function SetBg()
    local bgRes = "UIs/MenuBuy/" .. data:GetID() .. "/bg"
    ResUtil:LoadBigImg(bg, bgRes, true, function()
        local pos = bgPos[data:GetID()]
        CSAPI.SetAnchor(bg, pos[1], pos[2])
    end)
end

-- 首冲奖励
function SetNode1()
    -- items 
    -- local rewards = cfg.item or {}
    -- items1 = items1 or {}
    -- ItemUtil.AddItems("MenuBuy/MenuBuyItem1", items1, rewards, itemParent1)
    -- btn 
    local isEnough = data:IsEnough()
    LanguageMgr:SetText(txtBtn1, isEnough and 38015 or 38014)
    --
    UIUtil:SetRedPoint(btn1, isEnough, 150, 43, 0)
end

-- 6元付费
function SetNode2()
    CSAPI.SetText(txtTitle2, cfg.title)
    CSAPI.SetText(txtDesc2, cfg.des)
    -- icon
    local reward = cfg.item[1]
    curItem = BagMgr:GetFakeData(reward[1], reward[2])
    -- icon 
    ResUtil.IconGoods:Load(icon2, curItem:GetIcon() .. "_3")
    -- num
    CSAPI.SetText(txt2_Num, reward[2] .. "")
end

-- 月卡
function SetNode3()
    CSAPI.SetText(txtTitle3, cfg.title)
    CSAPI.SetText(txtDesc3, cfg.des)
    -- time  
    local isShowTime = false
    local num = ShopMgr:GetMonthCardDays()
    if (num > 0 and num <= 7) then
        isShowTime = true
        LanguageMgr:SetText(txt3_time, 18082, num)
    end
    CSAPI.SetGOActive(txt3_time, isShowTime)
    -- item 
    local rewards = cfg.item or {}
    items3 = items3 or {}
    ItemUtil.AddItems("MenuBuy/MenuBuyItem2", items3, rewards, itemParent3)
end

-- 特价
function SetNode4()
    CSAPI.SetText(txtTitle4, cfg.title)
    CSAPI.SetText(txtDesc4, cfg.des)
    -- icon
    local reward = cfg.item[1]
    curItem = BagMgr:GetFakeData(reward[1], reward[2])
    -- icon 
    ResUtil.IconGoods:Load(icon4, curItem:GetIcon() .. "_3")
    -- num
    CSAPI.SetText(txt4_Num, reward[2] .. "")
end

function SetNode5()
    CSAPI.SetText(txtDesc5, cfg.des)
    endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
end

function SetNode6()
    -- time 
    CSAPI.SetText(txtTime6, cfg.title)
    -- desc 
    CSAPI.SetText(txtDesc6, cfg.des)
    -- items
    local rewardCfg =SignInMgr:GetRewardCfgByType(ActivityListType.SignInGift) or {}
    items6 = items6 or {}
    for k, v in ipairs(rewardCfg.infos) do
        local item = items6[k]
        if (item) then
            CSAPI.SetGOActive(item.gameObject, true)
            item.Refresh(v)
        else
            ResUtil:CreateUIGOAsync("MenuBuy/MenuBuyItem6", this["grids6" .. k], function(go)
                local item = ComUtil.GetLuaTable(go)
                item.Refresh(v)
            end)
        end
    end
    -- red 
    UIUtil:SetRedPoint(btn6, data:GetRed(), 124, 33.5, 0)
end

function SetClose()
    local pos = closePos[data:GetID()]
    CSAPI.SetAnchor(btnClose, pos[1], pos[2])
end

function SetTips()
    -- -- 如果是首充并且在可领状态，则隐藏
    -- if (cfg.nType == MenuBuyState.First) then
    --     local amount = PlayerClient:GetPayAmount()
    --     if (amount / 100 >= 6) then
    --         CSAPI.SetGOActive(btnSkip, false)
    --         return
    --     end
    -- end
    -- CSAPI.SetGOActive(btnSkip, true)
    --
    local pos = skipPos[data:GetID()]
    CSAPI.SetAnchor(btnSkip, pos[1], pos[2])

    -- tick 
    -- day = TimeUtil:GetTime3("day")
    -- local dayRecord = PlayerPrefs.GetString(MenuMgr:GetMenuBuySaveStr(cfg.id), "0")
    -- if (dayRecord ~= "0" and dayRecord == tostring(day)) then
    --     isSet = true
    -- end
    CSAPI.SetGOActive(skip, data:IsTick())
end

function OnClickSkip()
    -- if (not isSet) then
    --     PlayerPrefs.SetString(MenuMgr:GetMenuBuySaveStr(cfg.id), tostring(day))
    -- else
    --     PlayerPrefs.SetString(MenuMgr:GetMenuBuySaveStr(cfg.id), "0")
    -- end
    data:SetTick()
    -- isSet = not isSet
    SetTips()
end

-- 前往充值/领取
function OnClickBtn1()
    local isEnough = data:IsEnough()
    if (not isEnough) then
        JumpMgr:Jump(140001) -- 跳到商店
    else
        ShopProto:Buy2(cfg.shopItem, {})
    end
    view:Close()
end
-- 购买
function OnClickBtn2()
    ShopCommFunc.OpenPayView2(cfg.shopItem)
    view:Close()
end
-- 购买月卡
function OnClickBtn3()
    ShopCommFunc.OpenPayView2(cfg.shopItem)
    view:Close()
end
-- 购买
function OnClickBtn4()
    ShopCommFunc.OpenPayView2(cfg.shopItem)
    view:Close()
end
-- 立即领取
function OnClickBtn5()
    ShopProto:Buy2(cfg.shopItem, {})
    view:Close()
end

-- 前往  商城/签到
function OnClickBtn6()
    local isEnough = data:IsEnough()
    if (not isEnough) then
        JumpMgr:Jump(140001) -- 跳到商店
    else
        JumpMgr:Jump(180005) -- 跳到签到
    end
    view:Close()
end

function OnClickIcon2()
    if (curItem) then
        GridRewardGridFunc({
            data = curItem
        })
    end
end

function OnClickClose()
    view:Close()
end
