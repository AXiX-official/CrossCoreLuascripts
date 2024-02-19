-- 抽卡结果
local timer = 0

function Awake()
    items = items or {}
    for i = 1, 10 do
        local go = ResUtil:CreateUIGO("CreateShow/CreateRoleItem", grid.transform)
        local lua = ComUtil.GetLuaTable(go)
        lua.SetIndex(i)
        table.insert(items, lua)
    end

    timer = Time.time + 1.5

    ResUtil:CreateEffect("OpenBox/BGLineLoop", 0, 0, 0, bg)

    -- SettingMgr:SetMusic(false)
    bgm = CSAPI.StopBGM()

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.View_Lua_Opened, OnViewOpened)
    eventMgr:AddListener(EventType.Role_FirstCreate_End, FirstEnd)
end

function OnDestroy()
    eventMgr:ClearListener()
    -- SettingMgr:SetMusic(true)
    --EventMgr.Dispatch(EventType.Replay_BGM)
    CSAPI.ReplayBGM(bgm)
end

function OnViewOpened(viewKey)
    if (viewKey == "CreateShowView") then
        view:Close()
    end
end

-- {rewards, isFirst10, poolId}
function OnOpen()
    local rewards = data[1]
    -- local goodsDatas = data[4] or {}
    local quality = GetMaxQuality(rewards)

    for i, v in ipairs(items) do
        -- v.Refresh(rewards[i], goodsDatas[rewards[i].id])
        v.Refresh(rewards[i], rewards[i].goodsData)
        -- 动画
        local index = i % 5 == 0 and 5 or i % 5
        local delay = (index - 1) * 100
        local timer = 1000 - delay
        local y1 = i > 5 and -430 or 430

        UIUtil:SetPObjMove(v.moveNode, 0, 0, y1, 0, 0, 0, function()
            v.SetEffect()
            if (i == 1) then
                CSAPI.PlayUICardSound("ui_card_draw_summary_end")
                if (quality >= 5) then
                    CSAPI.PlayUICardSound("ui_card_draw_summary_golden")
                elseif (quality >= 4) then
                    CSAPI.PlayUICardSound("ui_card_draw_summary_purple")
                else
                    CSAPI.PlayUICardSound("ui_card_draw_summary_bule")
                end
            end
        end, timer, delay)

        UIUtil:SetObjFade(v.moveNode, 0, 1, nil, timer, delay)

        v.SetImg67Anim(timer, delay)
    end

    CSAPI.PlayUICardSound("ui_card_draw_summary_start")
end

function GetMaxQuality(rewards)
    local quality = 3
    for i, v in ipairs(rewards) do
        local cfg = Cfgs.CardData:GetByID(v.id)
        if (cfg.quality > quality) then
            quality = cfg.quality
        end
    end
    return quality
end

-- function SetItems()
-- 	ItemUtil.AddItems("RoleCard/CreateRoleItem", items, data[1], grid)
-- end
-- 重复10连界面
function OpenCreateCachePanel()
    if (createCachePanel == nil) then
        local go = ResUtil:CreateUIGO("Create/CreateCachePanel", transform)
        createCachePanel = ComUtil.GetLuaTable(go)
        -- createCachePanel.SetSureCB(function()
        --     view:Close()
        -- end)
    end
    createCachePanel.Refresh(data)
end

function OnClickMask()
    if (Time.time < timer) then
        return
    end

    if (data[2]) then
        OpenCreateCachePanel()
    else
        view:Close()
    end
end

function FirstEnd()
    view:Close()
end