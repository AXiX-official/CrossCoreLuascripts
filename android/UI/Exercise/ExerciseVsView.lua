function OnInit()
    UIUtil:AddTop2("ExerciseVsView", gameObject, function()
        view:Close()
    end, nil, {})

    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_End, function()
        view:Close()
    end)
    eventMgr:AddListener(EventType.View_Lua_Closed, OnViewClosed)
end

function OnDestroy()
    eventMgr:ClearListener()
end

-- 演习 data GetPracticeOtherTeamRet  {team,uid,is_robot}
function OnOpen()
    SetLeft()
    SetRight()
    -- 积分
    local zf1 = ExerciseMgr:GetScore()
    local zf2 = lData.score
    local zf = GCalHelp:GetArmyAddScore(zf1, zf2)
    LanguageMgr:SetText(txtZf, 33051, "+" .. zf)
    -- CSAPI.SetText(txtZf, "+" .. zf)
end

-- 自己
function SetLeft()
    -- icon
    --SetIconL(PlayerClient:GetLastRoleID())
    -- attack
    local teamData = TeamMgr:GetTeamData(eTeamType.PracticeAttack)
    if teamData then
        local haloStrength = teamData:GetHaloStrength();
        CSAPI.SetText(txtFightingL2, tostring(teamData:GetTeamStrength() + haloStrength))
    end
    -- rank
    CSAPI.SetText(txtRankL2, ExerciseMgr:GetRankStr())
    -- lv
    CSAPI.SetText(txtLvL2, PlayerClient:GetLv() .. "")
    -- name
    CSAPI.SetText(txtNameL, PlayerClient:GetName())
    -- team
    SetLTeamItems()
end

function SetIconL(icon_id)
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 2
    CSAPI.SetRTSize(iconMaskL, width, arr.y)
    -- CSAPI.SetAnchor(iconMaskL, - arr.x / 4)
    RoleTool.LoadImg(iconL, icon_id, LoadImgType.ExerciseLView)
    -- 
    UIUtil:SetLiveBroadcast(iconL)
end

function SetLTeamItems()
    local cards = TeamMgr:GetTeamCardDatas(eTeamType.PracticeAttack)
    -- 封装数据
    local _newDatas = {}
    for i = 1, 5 do
        if (i <= #cards) then
            table.insert(_newDatas, cards[i])
        else
            -- table.insert(_newDatas, {})
        end
    end

    lTeamGrids = lTeamGrids or {}
    ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", lTeamGrids, _newDatas, itemGridL, nil, 1, {
        hideFormat = true
    })

    --icon 
    SetIconL(_newDatas[1]:GetSkinID())
end

-- 敌人
function SetRight()
    lData = ExerciseMgr:GetEnemyInfo(data.uid)
    if(not lData) then 
        LogError("找不到玩家数据："..data.uid)
        return 
    end 
    -- icon
    local icon_id = lData.icon_id
    if (lData.role_panel_id ~= nil and lData.role_panel_id ~= 0) then
        icon_id = lData.role_panel_id
    end
    SetIconR(icon_id)
    -- attack
    CSAPI.SetText(txtFightingR2, lData.performance .. "")
    -- rank
    CSAPI.SetText(txtRankR2, lData.rank == 0 and "__" or tostring(lData.rank))
    -- lv
    CSAPI.SetText(txtLvR2, lData.level .. "")
    -- name
    CSAPI.SetText(txtNameR, lData.name .. "")
    -- team
    SetRTeamItems()
end
function SetIconR(icon_id)
    local arr = CSAPI.GetMainCanvasSize()
    local width = arr.x / 2
    CSAPI.SetRTSize(iconMaskR, width, arr.y)
    -- CSAPI.SetAnchor(iconMaskR, arr.x / 4)
    RoleTool.LoadImg(iconR, icon_id, LoadImgType.ExerciseLView, function()
        local x, y = CSAPI.GetAnchor(iconR)
        CSAPI.SetAnchor(iconR, -x, y)
    end)
    -- 
    UIUtil:SetLiveBroadcast(iconR)
end
function SetRTeamItems()
    local cardDatas = {}
    if (data and data.team) then
        for i, v in ipairs(data.team.data) do
            local _card = CharacterCardsData(v.card_info)
            table.insert(cardDatas, _card)
        end
    end
    -- 封装数据
    local _newDatas = {}
    for i = 1, 5 do
        if (i <= #cardDatas) then
            table.insert(_newDatas, cardDatas[i])
        else
            -- table.insert(_newDatas, {})
        end
    end
    rTeamGrids = rTeamGrids or {}
    ItemUtil.AddItems("RoleLittleCard/RoleLittleCard", rTeamGrids, _newDatas, itemGridR, nil, 1, {
        hideFormat = true
    })
end

function OnClickTeam()
    CSAPI.OpenView("TeamView", {
        currentIndex = eTeamType.PracticeAttack,
        canEmpty = false,
        is2D = true
    }, TeamOpenSetting.PVP)
end

function OnViewClosed(viewKey)
    if (viewKey == "TeamView") then
        SetLeft()
    end
end

function OnClickStart()
    ExerciseMgr:Practice(data.uid, data.is_robot)
end

