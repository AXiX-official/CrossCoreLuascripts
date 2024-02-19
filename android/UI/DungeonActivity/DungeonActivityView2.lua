local curType = 1
local curOpen = 1
local currCfgs = nil
local blackFade = nil
local blackFade2 = nil
local videoGOs = nil
local isEnoughCount = false
local openInfo = nil
local info = nil
local refreshTime = -1
local isRefresh = false
local isFirstRefresh = true

function Awake()
    blackFade = ComUtil.GetCom(frontBlack, "ActionFade")
    blackFade2 = ComUtil.GetCom(black, "ActionFade")
    CSAPI.SetGOActive(action,false)
    CSAPI.SetText(txtLockTime, "")
end

function OnInit()
    UIUtil:AddTop2("DungeonActivity2", topObj, OnClickReturn);
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.RedPoint_Refresh, OnRedPointRefresh)
    -- eventMgr:AddListener(EventType.Bag_Update, SetCost)
    -- eventMgr:AddListener(EventType.TaoFa_Count_Refresh, OnPanelRefresh)
    -- eventMgr:AddListener(EventType.TaoFa_Count_BuyRefresh, OnBuyRetRefresh)
end

function OnRedPointRefresh()
    local _data = RedPointMgr:GetData(RedPointType.MissionTaoFa)
    UIUtil:SetRedPoint2("Common/Red2", btnMission, _data == 1, 79, 42, 0)
end

function OnBuyRetRefresh(proto)
    if proto and proto.buy_res == true then
        LanguageMgr:ShowTips(33008)
        PlayerProto:GetTaoFaCount()
    end
end

function OnDisable()
    eventMgr:ClearListener()
end

function Update()
    UpdateRefresh()
    -- UpdateLockTime()
    if openInfo and not openInfo:IsOpen() then
        openInfo = nil
        LanguageMgr:ShowTips(24001)
        UIUtil:ToHome()
    end
end

function UpdateRefresh()
    if isRefresh then
        if refreshTime >= 0 then
            refreshTime = refreshTime - Time.deltaTime
            local timeStr = TimeUtil:GetTimeStr(refreshTime)
            LanguageMgr:SetText(txtRefresh,15120,timeStr)
        else
            -- PlayerProto:GetTaoFaCount(SetInfo) --有自动推送
            isRefresh = false
        end
    end
end

function UpdateLockTime()
    if openInfo and openInfo:GetHardTime() then
        local tab = TimeUtil:GetTimeTab(openInfo:GetHardTime() - TimeUtil:GetTime())
        local hour = tab[2] % 24 < 10 and 0 .. tab[2] % 24 or tab[2] % 24
        LanguageMgr:SetText(txtLockTime,45006,tab[1], hour .. ":" ..tab[3] .. ":" ..tab[4])
    end
end

function OnOpen()
    if data and data.id then
        local sectionData = DungeonMgr:GetSectionData(data.id)
        if sectionData then
            openInfo = DungeonMgr:GetActiveOpenInfo(sectionData:GetActiveOpenID())
        end
        SetCfgs(data.id)
    end
    OnPanelRefresh()
    -- PlayerProto:GetTaoFaCount()
end

function OnPanelRefresh(proto)
    -- if proto == nil then
    --     LogError("协议无返回！！！")
    --     return
    -- end

    -- SetInfo(proto)
    -- if isFirstRefresh then
    if currCfgs and #currCfgs > 0 then
        AnimMask(500)
        SetScale()
        PlayVideo()
        RefreshPanel()
        ShowTips()
    else
        LogError("获取不到副本数据!")
    end
    blackFade2:Play(1,0,200)
    CSAPI.SetGOActive(action, true)

    MissionMgr:CheckRedPointData()
    
    --  if CSAPI.IsViewOpen("DungeonTaoFaBuy") then
    --     CSAPI.OpenView("DungeonTaoFaBuy", info)
    --  end
end

function SetInfo(proto)
    info = {
        count= proto.tao_fa_count or 0,
        buyCount = proto.buy_cnt
    }

    refreshTime = proto.next_reset_time - TimeUtil:GetTime()
    isRefresh = true
end

function SetRed(b)
    if isLock then
        b = false
    end
    UIUtil:SetRedPoint2("Common/Red2", gameObject, b, 89.8, 23.8)
end

-- 初始化数据
function SetCfgs(id)
    local cfgs = Cfgs.MainLine:GetGroup(id)
    if cfgs then
        currCfgs = {}
        for i, v in pairs(cfgs) do
            table.insert(currCfgs, v)
        end
        if #currCfgs>0 then
            table.sort(currCfgs,function (a,b)
                return a.id < b.id
            end)

            for i, v in ipairs(currCfgs) do
                if i == 4 then
                    break
                end
                if data.itemId and data.itemId == v.id then
                    curType = i
                end
                if DungeonMgr:IsDungeonOpen(v.id) then
                    curOpen = i
                end
            end
        end
        if not data.itemId then --无跳转id选中最新关卡
            curType = curOpen
        end
    end
end

-- 设置按钮初始大小
function SetScale()
    -- scale
    local scale1 = curType == 1 and 1 or 0.58
    local scale2 = curType == 2 and 1 or 0.58
    local scale3 = curType == 3 and 1 or 0.58
    CSAPI.SetScale(nolImg2, scale1, scale1, scale1)
    CSAPI.SetScale(hardImg2, scale2, scale2, scale2)
    CSAPI.SetScale(hellImg2, scale3, scale3, scale3)

    CSAPI.SetGOActive(nolImg1, curType == 1)
    CSAPI.SetGOActive(hardImg1, curType == 2)
    CSAPI.SetGOActive(hellImg1, curType == 3)
end

-- 刷新
function RefreshPanel()
    SetBg()
    CSAPI.SetGOActive(before, curType == 3)
    -- PlayVideo()
    SetTitle()
    SetState()
    -- SetCost()
    -- SetSweep(currCfgs[curType])
end

-- 背景
function SetBg()
    -- ResUtil:LoadBigImg(bg1, "UIs/DungeonActivity/TaoFa/bg" .. curType .. "/bg", true)
    CSAPI.LoadImg(btnEnter,"UIs/DungeonActivity2/btn_01_0" .. curType .. ".png",true, nil, true)
end

function SetTitle()
    local title = ""
    local timeStr =""
    if openInfo then
        title = openInfo:GetName()
        if openInfo:IsDungeonOpen() then
            local strs = openInfo:GetTimeStrs()
            timeStr = strs[1] .. " " .. strs[2] .. " - " .. strs[3] .. " " .. strs[4]
        else    
            timeStr = openInfo:GetCloseTimeStr()
        end
    end
    CSAPI.SetText(txtTitle,title)
    CSAPI.SetText(txtTime,timeStr)
end

-- 状态
function SetState()
    -- alpha
    CSAPI.SetImgColor(nolImg2, 255, 255, 255, curType == 1 and 255 or 179)
    CSAPI.SetImgColor(hardImg2, 255, 255, 255, curType == 2 and 255 or 179)
    CSAPI.SetImgColor(hellImg2, 255, 255, 255, curType == 3 and 255 or 179)

    CSAPI.SetGOActive(hardLock, curOpen < 2)
    CSAPI.SetGOActive(hellLock, curOpen < 3)
end

-- 票数
function SetCost()
    local cur = info.count or 0
    local max = g_DungeonTaoFaDailyNum
    local costStr = cur ..  "/" .. max
    CSAPI.SetText(txtCost, costStr)
end

--扫荡状态
function SetSweep(cfgDungeon)
    CSAPI.SetGOActive(btnSweep,cfgDungeon.modUpCnt ~= nil)
    if cfgDungeon.modUpCnt == nil then
        return
    end
    isSweepOpen = false
    local sweepData = SweepMgr:GetData(cfgDungeon.id)
    if sweepData then
        isSweepOpen = sweepData:IsOpen()
    end 
    CSAPI.SetGOActive(lockImg,not isSweepOpen)
    CSAPI.SetImgColor(btnSweep,255,255,255,isSweepOpen and 255 or 76)
end

function OnClickSweep()
    OnSweepClick(currCfgs[curType])
end

function OnSweepClick(_cfg)
    if isSweepOpen then
        CSAPI.OpenView("SweepView",{id = _cfg.id},{taoFaInfo = info})
    else
        local sweepData = SweepMgr:GetData(_cfg.id)
        if sweepData then
            Tips.ShowTips(sweepData:GetLockStr())
        else
            local cfg = Cfgs.CfgModUpOpenType:GetByID(_cfg.modUpOpenId)
            if cfg then
                Tips.ShowTips(cfg.sDescription)
            end
        end
    end
end

-- 商店
function OnClickShop()
    CSAPI.OpenView("ShopView", 902)
end

-- 普通
function OnClickNol()
    if curType ~= 1 then
        curType = 1
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end

-- 困难
function OnClickHard()
    if curOpen < 2 then
        LanguageMgr:ShowTips(24002)
        return
    end
    if curType ~= 2 then
        curType = 2
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end

-- 地狱
function OnClickHell()
    if curOpen < 3 then
        -- if openInfo and not openInfo:IsHardOpen() and openInfo:GetHardTime() then
        --     local tab =TimeUtil:GetTimeTab(openInfo:GetHardTime() - TimeUtil:GetTime())
        --     local hour = tab[2] % 24
        --     hour = hour < 10 and 0 .. hour or hour
        --     LanguageMgr:ShowTips(34003, tab[1], hour..":" ..tab[3]..":" ..tab[4])
        -- else
            LanguageMgr:ShowTips(24002)
        -- end
        return
    end
    if curType ~= 3 then
        curType = 3
        PlayButtonAnim()
        AnimBlackTo(RefreshPanel)
    end
end

-- 任务
function OnClickMission()
    CSAPI.OpenView("MissionActivity", {
        type = eTaskType.DupTaoFa,
        title = LanguageMgr:GetByID(6020)
    })
end

-- 怪物说明
function OnClickExplain()
    if currCfgs and currCfgs[curType] then
        local cfgDungeon = currCfgs[curType]
        local list = {};
        if cfgDungeon and cfgDungeon.enemyPreview then
            for k, v in ipairs(cfgDungeon.enemyPreview) do
                local cfg = Cfgs.CardData:GetByID(v);
                table.insert(list, {
                    id = v,
                    -- level = cfgDungeon.previewLv,
                    isBoss = k == 1
                });
            end
            CSAPI.OpenView("FightEnemyInfo", list);
        end
    end
end

-- 进入编队
function OnClickEnter()
    if openInfo and not openInfo:IsDungeonOpen() then
        LanguageMgr:ShowTips(24003)
        return
    end
    -- if info.count < 1 and info.buyCount < g_DungeonTaoFaDailyBuy then
    --     CSAPI.OpenView("DungeonTaoFaBuy", info)
    --     return
    -- end
    -- if info.count < 1 and info.buyCount >= g_DungeonTaoFaDailyBuy then
    --     LanguageMgr:ShowTips(33005)
    --     return
    -- end
    if currCfgs and currCfgs[curType] then
        local cfg = currCfgs[curType]
        if cfg then
            CSAPI.OpenView("TeamConfirm", { -- 正常上阵
                dungeonId = cfg.id,
                teamNum = cfg.teamNum
            }, TeamConfirmOpenType.Dungeon)
        end
    end
end

function OnClickBuy()
    if info.count >= g_DungeonTaoFaDailyNum then --超过上限
        LanguageMgr:ShowTips(33004)
        return
    elseif info.buyCount >= g_DungeonTaoFaDailyBuy then --超过购买上限
        LanguageMgr:ShowTips(33005)
        return
    end
    CSAPI.OpenView("DungeonTaoFaBuy", info)
end

-- 关闭界面
function OnClickReturn()
    view:Close()
end
-------------------------------------------video-------------------------------------------
-- 播放背景视频
function PlayVideo()
    videoGOs = videoGOs or {}
    for i, v in pairs(videoGOs) do
        CSAPI.SetGOActive(v, false)
    end
    local goVideo = videoGOs[curType]
    if not goVideo then
        goVideo = ResUtil:PlayVideo("dungeon_activity_" .. 2, videoParent);
        videoGOs[curType] = goVideo.gameObject
    else
        CSAPI.SetGOActive(goVideo, true)
    end
end

-------------------------------------------anim-------------------------------------------
-- 按钮动画
function PlayButtonAnim()
    AnimScaleTo(nolImg2.gameObject, curType == 1)
    AnimScaleTo(hardImg2.gameObject, curType == 2)
    AnimScaleTo(hellImg2.gameObject, curType == 3)

    -- active
    CSAPI.SetGOActive(nolImg1, curType == 1)
    CSAPI.SetGOActive(hardImg1, curType == 2)
    CSAPI.SetGOActive(hellImg1, curType == 3)
    AnimScaleTo(nolImg1.gameObject, curType == 1)
    AnimScaleTo(hardImg1.gameObject, curType == 2)
    AnimScaleTo(hellImg1.gameObject, curType == 3)
end

-- 缩放动画
function AnimScaleTo(go, isSel, cb)
    local scale = isSel and 1 or 0.58
    CSAPI.SetUIScaleTo(go, nil, scale, scale, scale, cb, 0.2)
end

-- 切换动画
function AnimBlackTo(cb)
    AnimMask(400)
    blackFade:Play(0, 1, 200, 0, function()
        blackFade:Play(1, 0, 200)
        if cb then
            cb()
        end
    end)
end

function AnimMask(delay)
    CSAPI.SetGOActive(clickMask, true)
    FuncUtil:Call(function()
        if gameObject then
            CSAPI.SetGOActive(clickMask, false)
        end
    end, nil, delay)
end
-------------------------------------------tips-------------------------------------------

function ShowTips()
    local info = FileUtil.LoadByPath("Dungeon_TaoFa_OpenInfo_" .. PlayerClient:GetUid() ..".txt") or {1}
    if curOpen > 1 and info[curOpen] == nil then -- 没记录则弹出提示
        info[curOpen] = 1
        FileUtil.SaveToFile("Dungeon_TaoFa_OpenInfo_" .. PlayerClient:GetUid() ..".txt",info)
        if curOpen >= #currCfgs then --全开启
            local dungeonData = DungeonMgr:GetData(currCfgs[curOpen].id)
            if dungeonData and dungeonData:IsPass() then --已通关则不用提示
                return
            end
        end
        LanguageMgr:ShowTips(34002)
    end
end