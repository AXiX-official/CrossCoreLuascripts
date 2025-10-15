local panelIndex = 1

function Awake()
    fade = ComUtil.GetCom(gameObject, "ActionFade")
    fade1 = ComUtil.GetCom(goShaderRaw, "ActionFade")
    UIMaskGo = CSAPI.GetGlobalGO("UIClickMask")
end

function OnInit()
    eventMgr = ViewEvent.New()
    eventMgr:AddListener(EventType.Exercise_End, function()
        view:Close()
    end)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function OnOpen()
    -- music
    CSAPI.PlayUISound("ui_getitems")

    -- fade
    fade1:Play(0, 1, 167, 600, function()
        CSAPI.SetGOActive(bg1, false)
        CSAPI.SetGOActive(black, false)
        CSAPI.SetGOActive(shaderObj, true)
        isCanBack = true
    end)

    SetPanel()
end

function SetPanel()
    if (panelIndex == 1) then
        local socre = ExerciseRMgr:GetProto().score or 0
        local rankLe = GCalHelp:CalFreeMatchRankLv(socre)
        CSAPI.SetText(txtL1, socre .. "")
        CSAPI.SetText(txtL2, rankLe .. "")
        CSAPI.SetText(txtR1, data[1] .. "")
        CSAPI.SetText(txtR2, data[2] .. "")
    else
        fade:Play(1, 0, 167, 0, function()
            view:Close()
        end)
    end
end

function SetPanel1()
    LanguageMgr:SetText(txtTitle1, 33014)
    LanguageMgr:SetEnText(txtTitle2, 33014)

    CSAPI.SetText(txtMIddle1, data[1] .. "")
    local add = data[1] - data[2]
    LanguageMgr:SetText(txtDesc1, 33015, add, data[1])

    local rankLe1 = GCalHelp:CalFreeMatchRankLv(data[1] or 0)
    local renkLe2 = GCalHelp:CalFreeMatchRankLv(data[2] or 0)
    panelIndex = 2
end

function OnClickMask()
    if not isCanBack then
        return
    end
    SetPanel()
end

function AnimStart()
    CSAPI.SetGOActive(UIMaskGo, true)
end

function AnimEnd()
    CSAPI.SetGOActive(UIMaskGo, false)
end


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    OnClickMask()
end