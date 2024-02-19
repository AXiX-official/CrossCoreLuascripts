local commData = nil
local isClose = true
local isEnough = false
local fade = nil
local animTime = 3833
local isJumpAnim = false
local reward = nil
local targetTime = 0

function Awake()
    fade =ComUtil.GetCom(node,"ActionFade")
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Shop_RecordInfos_Refresh, Refresh)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)

    CSAPI.SetGOActive(effObj, false)
    CSAPI.SetGOActive(clickMask, false)
end

function OnViewClosed(viewKey)
    if viewKey == "ShopView" then
        Refresh()
    end
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    if isClose then
        return
    end

    RefreshTime()
end

function RefreshTime()
    if targetTime <= TimeUtil:GetBJTime() then
        LanguageMgr:SetText(txtTime,45006,"0","00:00:00")
        isClose = true
        LanguageMgr:ShowTips(24003)
        return
    end

    local time = targetTime - TimeUtil:GetBJTime()
    local d = math.floor(time / 86400)
    local str = TimeUtil:GetTimeStr(time - d * 86400)
    LanguageMgr:SetText(txtTime,45006,d,str)
end

function Refresh(_data)
    SetTime()
    commData = GetCurrData()
    if commData then
        RefreshPanel()
    end
end

function SetTime()
    targetTime = PlayerClient:GetCreateTime() + (g_InvestmentTimes * 86400)
    if TimeUtil:GetBJTime() >= targetTime then
        return
    end
    isClose = false
end

function GetCurrData()
    local pageData = ShopMgr:GetPageByID(1001)
    if pageData == nil then
        LogError("找不到对应商店页的商品数据！1001")
        return nil
    end

    local comms = pageData:GetCommodityInfos2()
    if comms and #comms < 1 then
        ShowFinishPanel()
        return nil
    end
    return comms[1]
end

function ShowFinishPanel()
    CSAPI.SetGOActive(btnPay,false)
    LanguageMgr:SetText(txtDesc, 45011)
    ResUtil:LoadBigImg(icon,"UIs/ActivityList/Investment/img_05_01")
end

function RefreshPanel()
    local costCount = 0
    local getCount = 0
    if commData:GetPrice() and #commData:GetPrice()>0 then
        costCount = commData:GetPrice()[1].num
    else
        LogError("获取不到价格数据!商品id:" .. commData:GetID())
        return
    end
    CSAPI.SetText(txtCount,costCount .. "")
    isEnough = BagMgr:GetCount(ITEM_ID.DIAMOND) >= costCount
    UIUtil:SetRedPoint(btnPay,isEnough,124,38,0)

    if commData:GetCommodityList() and #commData:GetCommodityList()>0 then
        getCount = commData:GetCommodityList()[1].num
    else
        LogError("获取不到奖励数据!商品id:" .. commData:GetID())
        return
    end

    LanguageMgr:SetText(txtDesc,45010,costCount,getCount)
    ResUtil:LoadBigImg(icon,"UIs/ActivityList/Investment/img_05_02")
end

function OnClickPay()
    if isClose then
        LanguageMgr:ShowTips(24003)
        return
    end

    if not isEnough then
        local dialogData = {}
        dialogData.content = LanguageMgr:GetTips(10004)
        dialogData.okCallBack = function()
            JumpMgr:Jump(140001)
        end
        CSAPI.OpenView("Dialog", dialogData)
        return 
    end

    ShopCommFunc.HandlePayLogic(commData, 1, CommodityType.Normal, ShowReward)
end

function ShowReward(proto)
    reward = {proto.gets}
    isJumpAnim = false
    PlayAnim(function ()
        UIUtil:OpenReward(reward)
        reward = nil
        ActivityMgr:CheckRedPointData()
        Refresh()
    end)
end

function PlayAnim(callBack)
    ShowState(false)
    FuncUtil:Call(function ()
        if gameObject and not isJumpAnim then
            ShowState(true)
            if callBack then
                callBack()
            end
        end
    end,nil, animTime)
end

function ShowState(isShow)
    CSAPI.SetGOActive(clickMask,not isShow)
    CSAPI.SetGOActive(icon, isShow)
    CSAPI.SetGOActive(effObj, not isShow)
    CSAPI.SetGOActive(txtDesc, isShow)
    CSAPI.SetGOActive(btnPay, isShow)
end

function PlayFade(isFade,cb)
	local star = isFade and 1 or 0
	local target = isFade and 0 or 1
	fade:Play(star,target,200,0,function ()
		if cb then
			cb()
		end
	end)
end

function OnClickJump()
    ShowState(true)
    isJumpAnim = true
    if reward then
        UIUtil:OpenReward(reward)
        reward = nil
        ActivityMgr:CheckRedPointData()
        Refresh()
    end
end


