local sectionDatas = nil
local rankTypes = nil
local rankType = 0
local currDatas = nil
local layout = nil
local intervalTime = 0 -- 刷新间隔
curIndex1, curIndex2 = 1, 1
local rankTime, rankTimer = 0, 0
local isOpenReplace = true

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    -- layout:AddBarAnim(0.4, false)
    layout:Init("UIs/Rank/RankSummerItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
end

function OnInit()
    UIUtil:AddTop2("RankSummerView", gameObject, OnClickReturn, nil, {});
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Activity_Rank_Update, UpdateCardsPanel)
end

-- 数据刷新回调
function UpdateCardsPanel()
    currDatas = DungeonActivityMgr:GetRankInfos(rankType)
    layout:IEShowList(#currDatas, nil, 0)
    SetMyData()
    if rankTime <= 0 then
        rankTime = DungeonActivityMgr:GetRankTime(rankType)
        rankTimer = 0
    end
end

function OnDisable()
    eventMgr:ClearListener();
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if lua then
        local _data = currDatas[index]
        lua.SetClickCB(OnItemClickCB)
        lua.SetIndex(index)
        lua.Refresh(_data, {
            isOpenReplace = isOpenReplace
        })
        -- 请求更多数据
        if (index ~= 100 and index == #currDatas and intervalTime < TimeUtil:GetTime()) then
            DungeonActivityMgr:AddNextRankList(rankType)
            intervalTime = TimeUtil:GetTime() + 0.1
        end
    end
end

function OnItemClickCB(item)
    local index = item.index
    local name = item.GetName()
    PlayerProto:GetRankTeamInfo(rankType, index, function(proto)
        if proto ~= nil then
            proto.name = name
            CSAPI.OpenView("RankTeamCheck", proto)
        end
    end)
end

function Update()
    if rankTime > 0 and Time.time > rankTimer then
        rankTimer = Time.time + 1
        if rankType then
            rankTime = DungeonActivityMgr:GetRankTime(rankType)
            if rankTime <= 0 then
                DungeonActivityMgr:ClearRankData(rankType)
                DungeonActivityMgr:RefreshRankList(rankType)
            end
        end
    end
end

function OnOpen()
    rankTypes = data.types
    sectionDatas = data.datas
    curIndex1 = openSetting or 1
    -- 清空旧缓存
    rankType = rankTypes[curIndex1]
    DungeonActivityMgr:ClearRankData(rankType)
    rankTime = DungeonActivityMgr:GetRankTime(rankType)
    rankTimer = 0
    if sectionDatas then
        InitLeftPanel()
        RefreshPanel()
        tlua:AnimAgain()
    end
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftParent.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {} -- 多语言id，需要配置英文
    if #sectionDatas > 0 then
        for i, v in ipairs(sectionDatas) do
            local info = v:GetInfo()
            local id = info and info.rankId or 39006
            table.insert(leftDatas, {id, "Rank/icon_" .. v:GetID()})
        end
    end
    leftPanel.Init(this, leftDatas)
end

function SetState()
    local cfg = Cfgs.CfgRankTeam:GetByID(rankType)
    if cfg and cfg.isClose then
        isOpenReplace = false
    else
        isOpenReplace = true
    end
end

function RefreshPanel()
    rankType = rankTypes[curIndex1]
    SetTitle()
    SetState()
    leftPanel.Anim()
    ShowList()
    SetQuestion()
end

function SetTitle()
    local info = sectionDatas[curIndex1] and sectionDatas[curIndex1]:GetInfo() or nil
    if info and info.rankDes then
        LanguageMgr:SetText(txtTitle3, info.rankDes)
    end
    local lanID = 33002
    if rankType == eRankType.Abattoir then
        lanID = 64034
    end
    LanguageMgr:SetText(txtTips, lanID)
    -- if rankType == eRankType.SummerActiveRank then
    --     LanguageMgr:SetText(txtTitle3,62035)
    -- elseif rankType == eRankType.Abattoir then
    --     LanguageMgr:SetText(txtTitle3,64032)
    -- elseif rankType == eRankType.CentaurRank then
    -- end
    if info and info.rankDes2 then
        LanguageMgr:SetText(txtTitle4, info.rankDes2)
    end
end

function ShowList()
    currDatas = DungeonActivityMgr:GetRankInfos(rankType)
    if #currDatas <= 0 then
        DungeonActivityMgr:GetRank(1, rankType)
    else
        layout:IEShowList(#currDatas)
        -- 自己数据
        SetMyData()
    end
end

function SetMyData()
    local info = DungeonActivityMgr:GetMyRank(rankType)
    local rank = info:GetRank()

    CSAPI.SetGOActive(myObj, true)
    -- name
    CSAPI.SetText(txtName, info:GetName())
    -- 等级
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv, info:GetLevel() .. "")
    -- 排名
    CSAPI.SetText(txtRank1, (rank < 4 and rank ~= 0) and rank .. "" or "")
    local rankStr = rank >= 4 and rank .. "" or ""
    rankStr = rank > 100 and "100+" or rankStr
    CSAPI.SetText(txtRank2, rankStr)
    -- 战斗力
    CSAPI.SetText(txtFighting, info:GetScore() .. "")
    -- icon
    -- ResUtil.CRoleItem_BG:Load(iconBg, "btn_02_03")
    -- local _cfg = Cfgs.character:GetByID(info:GetModuleID())
    -- if(_cfg.icon) then
    -- 	ResUtil.RoleCard:Load(icon, _cfg.icon, true)
    -- end
    UIUtil:AddHeadByID(hfParent, 0.9, info:GetFrameId(), info:GetIconID(), info:GetSex())
    -- title
    UIUtil:AddTitleByID(titleParent, 0.6, info:GetTitle())

    CSAPI.SetGOActive(btnOpen, rank ~= 0 and isOpenReplace)
    --
    if (rankType == eRankType.RogueTRank) then
        local maxHard = RogueTMgr:GetMaxHard2()
        local str = maxHard == 0 and "" or LanguageMgr:GetByID(54049, maxHard)
        CSAPI.SetText(txtHard, str)
    end
end

function OnClickOpen()
    local info = DungeonActivityMgr:GetMyRank(rankType)
    local rank = info:GetRank()
    PlayerProto:GetRankTeamInfo(rankType, nil, function(proto)
        if proto ~= nil then
            proto.name = PlayerClient:GetName()
            proto.rankIdx = rank
            CSAPI.OpenView("RankTeamCheck", proto)
        end
    end)
end

function OnClickReturn()
    view:Close()
end

-----------------------------------------------------

function SetQuestion()
    local cfg = Cfgs.CfgModuleInfo:GetByID(rankType.."")
    CSAPI.SetGOActive(btnQuestion,cfg~=nil)
end

function OnClickQuestion()
    local cfg = Cfgs.CfgModuleInfo:GetByID(rankType.."")
    if(cfg)then 
        CSAPI.OpenView("ModuleInfoView", cfg)
    end
end
