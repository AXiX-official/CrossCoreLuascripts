curIndex1, curIndex2 = 1, 1 -- 对应  StringConstant.Exercise61
local timer = 1
function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/Rank/RankRItem", LayoutCallBack, true)
end

function LayoutCallBack(index)
    local lua = layout:GetItemLua(index)
    if (lua) then
        local _data = curDatas[index]
        lua.Refresh(_data)
        -- 请求更多数据
        if (index ~= 100 and index == #curDatas) then
            ExerciseMgr:AddNextRankList()
        end
    end
end

function OnInit()
    UIUtil:AddTop2("RankView", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_Rank_Info, UpdateCardsPanel)
    eventMgr:AddListener(EventType.Exercise_End, function()
        view:Close()
    end)
end

function OnDestroy()
    eventMgr:ClearListener();
end

function OnOpen()
    -- 定时清空旧缓存
    ExerciseMgr:ClearRankData()

    InitLeftPanel()
    RefreshPanel()
end

function InitLeftPanel()
    if (not leftPanel) then
        local go = ResUtil:CreateUIGO("Common/LeftPanel", leftPoint.transform)
        leftPanel = ComUtil.GetLuaTable(go)
    end
    local leftDatas = {{33003, "Rank/btn_1_01"}} -- , {33004, "Rank/btn_1_02"}, {33005, "Rank/btn_1_02"}} --多语言id，需要配置英文
    local leftChildDatas = {}
    leftPanel.Init(this, leftDatas, leftChildDatas)
end

function RefreshPanel()
    SetDatas()

    -- 侧边动画
    leftPanel.Anim()
end

function SetDatas()
    if (curIndex1 == 1) then
        -- 演习数据
        curDatas = ExerciseMgr:GetRankInfos()
        if (#curDatas <= 0) then
            ExerciseMgr:GetPracticeList(1, 10)
        else
            layout:IEShowList(#curDatas, nil, 0)
        end
        -- 自己数据
        SetMyData()
    else
        -- else	其它排行榜 todo
        CSAPI.SetGOActive(myObj, false)

        curDatas = {}
        layout:IEShowList(#curDatas, nil, 0)
    end
end

-- 数据刷新回调
function UpdateCardsPanel()
    curDatas = ExerciseMgr:GetRankInfos()
    layout:IEShowList(#curDatas, nil, 0)
end

function SetMyData()
    local info = ExerciseMgr:SetMyRankData()
    local rank = info:GetRank()

    CSAPI.SetGOActive(myObj, true)
    -- name
    CSAPI.SetText(txtName, info:GetName())
    -- 等级
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
    CSAPI.SetText(txtLv, lvStr .. info:GetLevel())
    -- 排名
    CSAPI.SetGOActive(txtRank1, rank < 4)
    CSAPI.SetText(txtRank1, (rank < 4 and rank ~= 0) and rank .. "" or "-")
    CSAPI.SetText(txtRank2, rank >= 4 and rank .. "" or "")
    -- 战斗力
    CSAPI.SetText(txtFighting, info:GetScore() .. "")
    -- icon
    -- ResUtil.CRoleItem_BG:Load(iconBg, "btn_02_03")
    -- local _cfg = Cfgs.character:GetByID(info:GetModuleID())
    -- if (_cfg.icon) then
    --     ResUtil.RoleCard:Load(icon, _cfg.icon, true)
    -- end
    UIUtil:AddHeadFrame(hfParent, 0.9)
end

