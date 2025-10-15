function SetClickCB(_cb)
    cb = _cb
end
function Awake()
    slider = ComUtil.GetCom(Slider, "Slider")
end
function Refresh(_cfg, _type)
    cfg = _cfg
    type = _type
    local rewardInfo = ExerciseRMgr:GetRewardInfo()
    if (type == ePVPTaskType.Join) then
        jion_cnt = rewardInfo.jion_cnt or 0
        get_jion_cnt_id = rewardInfo.get_jion_cnt_id or 0
    else
        jion_cnt = rewardInfo.win_cnt or 0
        get_jion_cnt_id = rewardInfo.get_win_cnt_ix or 0
    end
    -- 
    CSAPI.SetText(txtDesc, cfg.sDescription)
    CSAPI.SetText(txtCount, jion_cnt .. "/" .. cfg.order)
    slider.value = jion_cnt / cfg.order
    CSAPI.SetGOActive(success, cfg.order <= get_jion_cnt_id)
    CSAPI.SetGOActive(btn, cfg.order > get_jion_cnt_id)
    if (cfg.order > get_jion_cnt_id) then
        CSAPI.SetGOActive(btnBg1, jion_cnt >= cfg.order)
        CSAPI.SetGOActive(btnBg2, jion_cnt < cfg.order)
        LanguageMgr:SetText(txtBtn1, jion_cnt >= cfg.order and 6011 or 90049)
        CSAPI.SetGOAlpha(btn, jion_cnt >= cfg.order and 1 or 0.3)
    end
    SetReward(cfg.jAward)
    SetRed()
end

function SetReward(rewards)
    grids = grids and grids or {}
    for i, v in ipairs(grids) do
        CSAPI.SetGOActive(v.gameObject, false)
    end
    local item, go = nil, nil
    for k, v in ipairs(rewards) do
        if (k <= #grids) then
            item = grids[k]
            CSAPI.SetGOActive(item.gameObject, true)
        else
            go, item = ResUtil:CreateRewardGrid(hLayout.transform)
            table.insert(grids, item)
        end
        local data = {
            id = v[1],
            num = v[2],
            type = v[3]
        }
        local result, clickCB = GridFakeData(data)
        item.Refresh(result)
        item.SetClickCB(clickCB)
        item.SetCount(data.num)
    end
end

function SetRed()
    UIUtil:SetRedPoint2("Common/Red2", btn, btnBg1.activeSelf, 99.6, 29, 0)
end

function OnClick()
    if (btnBg1.activeSelf) then
        local ids = GetIDs()
        ArmyProto:GetPvpReward(type, ids, function()
            if (cb ~= nil) then
                cb()
            end
        end)
    end
end

function GetIDs()
    local ids = {}
    if (type == ePVPTaskType.Join) then
        local jion_cnt = ExerciseRMgr:GetProto().reward_info.jion_cnt
        local _i = 0
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(1)
        for k, v in ipairs(cfg.infos) do
            if (v.order >= jion_cnt) then
                _i = v.order == jion_cnt and k or (k - 1)
                _i = _i <= 0 and 0 or _i
                break
            end
        end
        local get_jion_cnt_id = ExerciseRMgr:GetProto().reward_info.get_jion_cnt_id or 0
        for k = get_jion_cnt_id + 1, _i do
            table.insert(ids, k)
        end
    else
        local jion_cnt = ExerciseRMgr:GetProto().reward_info.win_cnt
        local _i = 0
        local cfg = Cfgs.CfgPvpTaskReward:GetByID(2)
        for k, v in ipairs(cfg.infos) do
            if (v.order >= jion_cnt) then
                _i = v.order == jion_cnt and k or (k - 1)
                _i = _i <= 0 and 0 or _i
                break
            end
        end
        local get_jion_cnt_id = ExerciseRMgr:GetProto().reward_info.get_win_cnt_ix or 0
        for k = get_jion_cnt_id + 1, _i do
            table.insert(ids, k)
        end
    end
    return ids
end
