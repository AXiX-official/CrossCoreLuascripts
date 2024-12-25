local currDatas = nil
local layout = nil
local intervalTime = 0 --刷新间隔
curIndex1, curIndex2 = 1, 1

function Awake()
    layout = ComUtil.GetCom(vsv, "UIInfinite")
    layout:Init("UIs/GlobalBoss/GlobalBossRankItem", LayoutCallBack, true)
    tlua = UIInfiniteUtil:AddUIInfiniteAnim(layout, UIInfiniteAnimType.Normal)
end

function OnEnable()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.GlobalBoss_Rank_Update, UpdateCardsPanel)
end

-- 数据刷新回调
function UpdateCardsPanel()
    currDatas = GlobalBossMgr:GetRankInfos()
    layout:IEShowList(#currDatas, nil, 0)
    SetMyData()
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
        lua.Refresh(_data)
        -- 请求更多数据
        if (index ~= 100 and index == #currDatas and intervalTime < TimeUtil:GetTime()) then
            GlobalBossMgr:AddNextRankList()
			intervalTime = TimeUtil:GetTime() + 0.1
        end
    end
end

function OnItemClickCB(item)
    local index = item.index
    local name = item.GetName()
    FightProto:GetGlobalBossRankTeam(index,function (proto)
        if proto ~= nil then
            proto.name = name
            proto.rankType = GlobalBossMgr:GetData() and GlobalBossMgr:GetData():GetRankType() or nil
            CSAPI.OpenView("RankTeamCheck",proto,{isGlobalBoss = true})
        end
    end)
end

function Refresh(_cfg,_elseData)
    curIndex1 = _elseData or 1
    -- 清空旧缓存
    GlobalBossMgr:ClearRankData()
    RefreshPanel()
    tlua:AnimAgain()
end

function RefreshPanel()
    ShowList()
end

function ShowList()
    currDatas = GlobalBossMgr:GetRankInfos()
    if #currDatas <= 0 then
        GlobalBossMgr:GetRank(1)
    else
        layout:IEShowList(#currDatas)
        --自己数据
	    SetMyData()
    end
end

function SetMyData()
	local info = GlobalBossMgr:GetMyRank()
    local rank = info:GetRank()
	
	CSAPI.SetGOActive(myObj, true)
	--name
	CSAPI.SetText(txtName, info:GetName())
	--等级
    local lvStr = LanguageMgr:GetByID(1033) or "LV."
	CSAPI.SetText(txtLv, info:GetLevel() .. "")
	--排名
	CSAPI.SetText(txtRank1,(rank < 4 and rank ~= 0) and rank .. "" or "")
    local rankStr = rank >= 4 and rank .. "" or ""
    rankStr = rank > 1000 and "1000+" or rankStr
	CSAPI.SetText(txtRank2, rankStr)
	--战斗力
	CSAPI.SetText(txtFighting, info:GetScore() .. "")
    --icon
    UIUtil:AddHeadByID(hfParent, 0.9, info:GetFrameId(), info:GetIconID(),info:GetSex())
	--title
	UIUtil:AddTitleByID(titleParent,0.6,info:GetTitle())
end

function OnClickReturn()
    view:Close()
end