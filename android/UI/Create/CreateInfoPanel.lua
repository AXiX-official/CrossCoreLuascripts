-- 建造卡池详情
local qualityDatasArr = {}

function Awake()
    CSAPI.PlayUISound("ui_window_open_load")
end

function Refresh(_data)
    data = _data
    SetDatas()
    SetItems()

    SetItems0()
end

function SetDatas()
    qualityDatas = {}
    local rID = data:GetRewardCfgID()
    if (not rID) then
        return
    end
    local rCfg = Cfgs.RewardInfo:GetByID(rID)
    for i, v in ipairs(rCfg.item) do
        AddDatas1(v.id)
    end
    -- arr 
    qualityDatasArr = {}
    local count = 0
    for k, v in pairs(qualityDatas) do
        table.insert(qualityDatasArr, {k, v})
        count = count + 1
    end

    if (count > 1) then
        table.sort(qualityDatasArr, function(a, b)
            return a[1] > b[1]
        end)
    end
    qualityDatas = nil
end

function AddDatas1(id)
    local oCfg = Cfgs.RewardInfo:GetByID(id)
    if (oCfg.quality) then
        qualityDatas[oCfg.quality] = qualityDatas[oCfg.quality] or {}
        AddDatas2(qualityDatas[oCfg.quality], oCfg.item, oCfg.bIsLimit)
    else
        -- 模板
        for i, v in ipairs(oCfg.item) do
            AddDatas1(v.id)
        end
    end
end

function AddDatas2(datas, item, bIsLimit)
    for p, q in ipairs(item) do
        if (tonumber(q.s_probability) ~= 0) then
            -- 是否检查开启时间
            if (not bIsLimit or not q.openTimes or CheckInTime(q.openTimes)) then
                table.insert(datas, q)
            end
        end
    end
end

function SetItems()
    items = items or {}
    ItemUtil.AddItems("Create/CreateInfoItem", items, qualityDatasArr, Content)
end

function SetItems0()
    -- datas 
    local count = 0
    local _datas = {}
    for k, v in pairs(qualityDatasArr) do
        _datas[v[1]] = {}
        for p, q in pairs(v[2]) do
            if (q.s_up_probability) then
                table.insert(_datas[v[1]], q)
                count = count + 1
            end
        end
    end
    if (count <= 0) then
        if (item0) then
            CSAPI.SetGOActive(item0.gameObject, count > 0)
        end
        return
    end

    -- item 
    if (not item0) then
        ResUtil:CreateUIGOAsync("Create/CreateInfoItem0", Content, function(go)
            item0 = ComUtil.GetLuaTable(go)
            item0.Refresh(_datas)
            go.transform:SetAsFirstSibling()
        end)
    else
        CSAPI.SetGOActive(item0.gameObject, count > 0)
        item.Refresh(_datas)
    end
end

function CheckInTime(openTimes)
    local curTime = TimeUtil:GetTime()
    if (openTimes[1] and curTime < TimeUtil:GetTimeStampBySplit(openTimes[1])) then
        return false
    end
    if (openTimes[2] and curTime > TimeUtil:GetTimeStampBySplit(openTimes[2])) then
        return false
    end
    return true
end
