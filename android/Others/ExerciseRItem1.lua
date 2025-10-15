local rank_colors = {"191919", "191919", "ffffff"}

-- sFreeArmyRank
function Refresh(data)
    CSAPI.SetText(txtRank, data.rank.."")
    --
    UIUtil:AddHeadByID(hfParent, 1, data.icon_frame, data.icon_id, data.sel_card_ix)
    -- 
    UIUtil:AddTitleByID(titleParent, 1, data.icon_title)
    CSAPI.SetText(txtLevel, data.level .. "")
    CSAPI.SetText(txtName, data.name)
    local rank = GCalHelp:CalFreeMatchRankLv(data.score or 0)
    local rankCfg = Cfgs.CfgPvpRankLevel:GetByID(rank)
    CSAPI.SetText(txtScore1, rankCfg and rankCfg.name or "")
    CSAPI.SetText(txtScore2, data.score .. "")
    --
    local nodeName =  data.rank < 4 and "img_07_0" ..  data.rank or "img_07_04"
    CSAPI.LoadImg(node, "UIs/ExerciseR/" .. nodeName .. ".png", false, nil, true)
    --
    local color1 = data.rank <= 2 and rank_colors[data.rank] or "ffffff"
    local color2 = rankCfg and rankCfg.rankColor or "5d5d5d"
    CSAPI.SetTextColorByCode(txtRank, color1)
    CSAPI.SetTextColorByCode(txtScore1, color2)
end

function RefreshMySelf()
    local data = {}
    data.rank = ExerciseRMgr:GetProto().rank
    data.score = ExerciseRMgr:GetProto().score or 0
    data.name = PlayerClient:GetName()
    data.icon_title = PlayerClient:GetIconTitle()
    data.icon_id = PlayerClient:GetIconId()
    data.icon_frame = PlayerClient:GetHeadFrame()
    data.sel_card_ix = PlayerClient:GetSex()
    data.level = PlayerClient:GetLv()
    Refresh(data)
end
