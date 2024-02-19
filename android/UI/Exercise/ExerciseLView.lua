-- 模拟
local curTeamIndex = 0
local runTime = false
local timer = 0
local needTime = 0
local nextTime = 0
local isEnd = false -- 赛季结束

local nextDayTime = nil
local nextDayTimer = nil

function Awake()
    timeBase = TimeBase.New()
    timeBase2 = TimeBase.New()

    nextDayTime = GCalHelp:GetNextActiveZeroTime()
    nextDayTimer = Time.time

    zf_slider = ComUtil.GetCom(zfSlider, "Slider")
end

function OnInit()
    UIUtil:AddTop2("ExerciseLView", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_Enemy_Info, EEnemyInfo) -- 查看对手
    eventMgr:AddListener(EventType.Exercise_Update, function()
        RefreshSelf()
        CheckTips()
    end) -- SetCount) -- 刷新自己的信息
    eventMgr:AddListener(EventType.Exercise_Enemy_Update, function()
        SetRefreshCnt()
        SetEnemyItems()
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed) -- 加载之后再显示奖励面板
    eventMgr:AddListener(EventType.Bag_Update, SetXz)
    eventMgr:AddListener(EventType.ExerciseL_BuyCount, SetCount)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Update()
    timeBase:Update()
    timeBase2:Update()

    -- -- 刷新次数 
    -- if (Time.time > nextDayTimer) then
    --     nextDayTimer = Time.time + 1
    --     if (GCalHelp:GetNextActiveZeroTime() > nextDayTime) then
    --         nextDayTime = CalHelp:GetNextActiveZeroTime()
    --         ExerciseMgr:GetPracticeInfo(true, false)
    --     end
    -- end
end

function OnOpen()
    RefreshSelf()
    -- 敌人
    SetEnemy() -- 请求数据 
end

-- 更新数据再提示，否则会出现数据返回的延迟错误 
function CheckTips()
    -- 赛季第一次进入 
    if (ExerciseMgr:IsNewSeason()) then
        ExerciseMgr:SetNewSeason()
        FuncUtil:Call(function()
            LanguageMgr:ShowTips(33001) -- 赛季已刷新，玩家积分排名已重置
        end, nil, 1)
    end
    -- 次数刷新了
    if (ExerciseMgr:IsNewJoinCnt()) then
        ExerciseMgr:SetNewJoinCnt()
        FuncUtil:Call(function()
            LanguageMgr:ShowTips(33002) -- 挑战次数已刷新
        end, nil, 2)
    end
end

function RefreshSelf()
    -- 赛季时间
    timeBase:Run(ExerciseMgr:GetEndTime(), SetTime)
    -- 段位
    SetGrade()
    -- 排名
    CSAPI.SetText(txtPm2, "" .. ExerciseMgr:GetRankStr())
    -- 积分
    SetZF()
    -- 勋章
    SetXz()
    -- 模拟次数
    SetCount()
    -- 刷新次数
    SetRefreshCnt()
end

function SetXz()
    CSAPI.SetText(txtXz, PlayerClient:GetCoin(g_ArmyCoinId) .. "")
end

-- 段位图标
function SetGrade()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(ExerciseMgr:GetRankLevel())
    CSAPI.SetGOActive(imgGrade, cfg.icon ~= nil)
    if (cfg.icon) then
        ResUtil.ExerciseGrade:Load(imgGrade, cfg.icon, true)
    end
    CSAPI.SetText(txtGrade, cfg.name)
end

function SetZF()
    local cfg = Cfgs.CfgPracticeRankLevel:GetByID(ExerciseMgr:GetRankLevel())
    -- cur
    -- CSAPI.SetText(txtZf2, ExerciseMgr:GetScore() .. "")
    -- next
    local cur, max = ExerciseMgr:GetScore(), 1
    if (cfg.nScore) then
        max = cfg.nScore
    else
        max = cur
    end

    local nextCfg = Cfgs.CfgPracticeRankLevel:GetByID(cfg.id + 1)
    if (nextCfg == nil) then
        cur, max = "--", "--"
        -- CSAPI.SetText(txtNextZf2, "--")
        zf_slider.value = 1
    else
        -- CSAPI.SetText(txtNextZf2, (max - cur) .. "")
        zf_slider.value = cur / max or 1
    end
    local str = string.format("%s/<color=#ffc146>%s</color>", cur, max)
    CSAPI.SetText(txtZf2, str)
    -- 

end

function SetCount()
    cnt, maxCnt = ExerciseMgr:GetJoinCnt()
    CSAPI.SetText(txtCount2, cnt .. "/" .. maxCnt)
    -- 下次刷新时间
    timeBase2:Run(ExerciseMgr:GetNextTime(), SetTime2)
end

function SetEnemy()
    -- 刷新次数
    -- SetRefreshCnt()
    -- 次数信息,请求敌人数据
    ExerciseMgr:GetPracticeInfo(true, true)
end

-- 赛季时间
function SetTime(_needTime)
    CSAPI.SetText(txtTime2, TimeUtil:GetTimeStr3(_needTime))
    if (_needTime <= 0) then
        isEnd = true
        -- LanguageMgr:ShowTips(33018)
        local str = LanguageMgr:GetTips(33018)
        UIUtil:OpenDialog(str)
        EventMgr.Dispatch(EventType.Exercise_End)
        view:Close()
    end
end

-- 回复时间
function SetTime2(_needTime)
    LanguageMgr:SetText(txtCount3, 33008, TimeUtil:GetTimeStr8(_needTime), g_ArmyPracticeJoinCntFlushCnt)
    if (_needTime <= 0) then
        ArmyProto:GetSelfPracticeInfo(function()
            -- 弹出提示 
            LanguageMgr:ShowTips(33002)
            ExerciseMgr:SetNewJoinCnt()
        end)
    end
end

-- 刷新对手次数
function SetRefreshCnt()
    local cnt, maxCnt = ExerciseMgr:GetFlushCnt()
    local curCnt = (maxCnt - cnt) < 0 and 0 or (maxCnt - cnt)
    CSAPI.SetText(txtRefresh3, curCnt .. "/" .. maxCnt)
end

-- 对手
function SetEnemyItems()
    enemyItems = enemyItems or {}
    local datas = ExerciseMgr:GetEnemy()
    table.sort(datas, function(a, b)
        if (a.rank == 0 and b.rank ~= 0) then
            return false
        elseif (a.rank ~= 0 and b.rank == 0) then
            return true
        end
        return a.rank < b.rank
    end)

    ItemUtil.AddItems("ExerciseL/ExerciseLItem", enemyItems, datas, enemyGrids, ItemClickCB)
end

function ItemClickCB(data)
    if (cnt <= 0) then
        local _num1, _num2 = ExerciseMgr:GetCanBuy()
        if (_num1 < _num2) then
            CSAPI.OpenView("ExerciseLBuy")
        else
            LanguageMgr:ShowTips(33007)
        end
        return
    end
    ExerciseMgr:GetPracticeOtherTeam(data.uid, data.is_robot)
end

-- 避免loading界面与RewardPanel冲突  todo 
function OnViewClosed(viewKey)
    -- 是否是新段位，新排名,获得积分币
    if (viewKey == "Loading") then
        local newChangeData = ExerciseMgr:GetNewChange()
        if (newChangeData[1] > 0 or newChangeData[2]) then
            CSAPI.OpenView("ExerciseLChange", newChangeData)
        elseif (newChangeData[3] > 0) then
            local data = {
                id = g_ArmyCoinId,
                type = RandRewardType.ITEM,
                num = newChangeData[3]
            }
            UIUtil:OpenReward({{data}})
        end
    end
end

-- 查看对手卡牌
function EEnemyInfo(proto)
    if (proto) then
        CSAPI.OpenView("ExerciseVsView", proto)
    end
end

-- 防御部署
function OnClickDeffense()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.PracticeDefine,
        canEmpty = false,
        is2D = true
    }, TeamOpenSetting.PVP)
end

-- 防御部署
function OnClickAttack()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.PracticeAttack,
        canEmpty = false,
        is2D = true
    }, TeamOpenSetting.PVP)
end

-- 排行榜
function OnClickRank()
    if (not isFirst) then
        isFirst = 1
        ExerciseMgr:ClearRankData()
    end
    CSAPI.OpenView("RankView")
end

-- 刷新对手
function OnClickRefresh()
    ExerciseMgr:FlushPracticeObj()
end

-- 跳转商店
function OnClickShop()
    CSAPI.OpenView("ShopView", 904)
end

-- 购买模拟次数
function OnClickAdd()
    -- 已满
    if (cnt >= maxCnt) then
        LanguageMgr:ShowTips(33004)
        return
    end
    -- 已购买次数 
    local buyCount, max = ExerciseMgr:GetCanBuy()
    if (buyCount >= max) then
        LanguageMgr:ShowTips(33005)
        return
    end
    CSAPI.OpenView("ExerciseLBuy")
end

-- 排名奖励
function OnClickReward()
    CSAPI.OpenView("ExerciseLRankReward")
end
