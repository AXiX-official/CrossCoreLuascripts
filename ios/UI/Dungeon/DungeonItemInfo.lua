local infoUtil = nil
local enterPos = nil
local outPos = nil
local isInfoShow = nil
local lastCfg = nil
local currCfg = nil
local infoFade = nil
local infoCG = nil
local infoMove = nil
local isActive = false
local enterCB = nil
local sweepCB = nil
local maskCB = nil
local buyFunc = nil
-- 多倍
local isDouble = true
local multiNum = 0

function Awake()
    eventMgr = ViewEvent.New();
    eventMgr:AddListener(EventType.Dungeon_InfoPanel_Update, OnPanelUpdate)

    infoFade = ComUtil.GetCom(gameObject, "ActionFade")
    infoCG = ComUtil.GetCom(gameObject, "CanvasGroup")
    infoMove = ComUtil.GetCom(gameObject, "ActionMoveByCurve")

    InitInfo()
end

function OnPanelUpdate(_data)
    infoUtil.RefreshPanel()
end

function InitInfo()
    infoUtil = DungeonInfoUtil.New()
    local x, y, z = CSAPI.GetLocalPos(childNode);
    enterPos = {x, y, z}
    outPos = {4000, y, 0};
    CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
    CSAPI.SetGOActive(gameObject, false);
    CSAPI.SetGOActive(clickMask, false)
    CSAPI.SetGOActive(mask, false)
end

function OnDestroy()
    eventMgr:ClearListener()
end

function Show(cfg, _elseData, callBack)
    PlayInfoMove(cfg ~= nil, function()
        Refresh(cfg, _elseData, callBack)
        ShowAnim()
    end)
end

function Refresh(cfg, _elseData, callBack)
    currCfg = cfg
    infoUtil:Set(cfg)
    infoUtil:Hidden()
    local type = _elseData or DungeonInfoType.Normal
    local names = DungeonInfoNameUtil.GetNames(type)
    SetItems(names, callBack)
end

function SetItems(typeNames, callBack)
    if typeNames and #typeNames > 0 then
        for i, typeName in ipairs(typeNames) do
            if typeName ~= "" then
                if typeName == "Double" then
                    if IsShowDouble() then
                        infoUtil:Show(typeName, doubleParent)    
                    end
                elseif i == #typeNames then
                    infoUtil:Show(typeName, layout, function(panel)
                        OnButtonClick(panel)
                        if i == #typeNames and callBack then
                            callBack()
                        end
                    end)
                else
                    infoUtil:Show(typeName, layout)
                end
            end
        end
    end
end
------------------------------------------------多倍
function IsShowDouble()
    if not currCfg or (currCfg.diff and currCfg.diff == 3) then -- 危险等级不显示双倍
        return false
    end
    local sectionData = DungeonMgr:GetSectionData(currCfg.group)
    if sectionData and DungeonUtil.GetMultiNum(sectionData:GetID()) > 0 then
        CSAPI.SetRTSize(layout,579,880)
        return true
    end
    return false
end

function CheckDouble(panel, cb)
    if panel == nil then
        cb()
        return
    end
    local isDouble = panel.IsDouble()
    local multiNum = panel.GetMultiNum()
    local isFirstDouble = DungeonMgr:GetFisrtOpenDouble()
    if (not isDouble and multiNum > 0 and not isFirstDouble) then
        DungeonMgr:SetFisrtOpenDouble(true)
        local dialogData = {}
        local name = currCfg.name
        dialogData.content = string.format(LanguageMgr:GetByID(15072), name, multiNum)
        dialogData.okText = LanguageMgr:GetByID(1031)
        dialogData.cancelText = LanguageMgr:GetByID(1003)
        dialogData.okCallBack = function()
            panel.ShowDouble(true)
            cb()
        end
        dialogData.cancelCallBack = function()
            panel.ShowDouble(false)
            cb()
        end
        CSAPI.OpenView("Dialog", dialogData)
    else
        cb()
    end
end

------------------------------------------------接口
function IsShow()
    return isInfoShow
end

function IsSweepOpen()
    local panel = infoUtil:GetPanel("Button")
    return panel and panel:IsSweepOpen()
end

function ClearLastItem()
    lastCfg = nil
end
------------------------------------------------按钮回调

function SetClickCB(_cb1, _cb2)
    enterCB = _cb1
    sweepCB = _cb2
    if enterCB then
        local _enterCB = enterCB
        enterCB = function()
            local doublePanel = infoUtil:GetPanel("Double")
            CheckDouble(doublePanel, _enterCB)
        end
    end
end

function OnButtonClick(panel)
    if enterCB then
        panel.OnClickEnter = enterCB
    end
    if sweepCB then
        panel.OnClickSweep = sweepCB
    end
    if buyFunc then
        panel.SetBuyFunc(buyFunc)
    end
end

function SetClickMaskCB(_cb)
    maskCB = _cb
    CSAPI.SetGOActive(mask, true)
end

function OnClickMask()
    if maskCB then
        maskCB()
    end
end

function SetBuyFunc(_func)
    buyFunc = _func
end

------------------------------------------------动效
function PlayAnim(time, callback)
    CSAPI.SetGOActive(clickMask, true)
    FuncUtil:Call(function()
        CSAPI.SetGOActive(clickMask, false)
        if callback then
            callback()
        end
    end, this, time)
end

-- 右边信息栏移动
function PlayInfoMove(isShow, callBack)
    local animTime = 200
    if isShow then
        CSAPI.SetGOActive(gameObject, true);
        if isInfoShow and lastCfg ~= currCfg then
            lastCfg = currCfg
            infoFade:Play(1, 0, 100, 0, function()
                CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
                infoCG.alpha = 1
                PlayMoveAction(childNode, enterPos)
                if callBack then
                    callBack()
                end
            end)
            animTime = 300
        else
            lastCfg = currCfg
            infoFade:Play(0, 1)
            PlayMoveAction(childNode, enterPos, function()
                isInfoShow = true
            end)
            if callBack then
                callBack()
            end
        end
    elseif isInfoShow then
        PlayMoveAction(childNode, {outPos[1], outPos[2], outPos[3]}, function()
            CSAPI.SetLocalPos(childNode, outPos[1], outPos[2], outPos[3])
            isInfoShow = false;
            CSAPI.SetGOActive(gameObject, false);
        end)
    end
    PlayAnim(animTime)
end

-- 移动动画
function PlayMoveAction(go, pos, callBack)
    infoMove.target = go
    local x, y, z = CSAPI.GetLocalPos(go)
    infoMove.startPos = UnityEngine.Vector3(x, y, z)
    infoMove.targetPos = UnityEngine.Vector3(pos[1], pos[2], pos[3])
    infoMove:Play(function()
        if callBack then
            callBack()
        end
    end)
end

--------------------------------------------活动用
function SetIsActive(b)
    isActive = b
end

function ShowAnim()
    if isActive then
        CSAPI.SetGOActive(enterAnim, false)
        CSAPI.SetGOActive(enterAnim, true)
    end
end

function SetPos(isShow)
    local pos = isShow and enterPos or outPos
    CSAPI.SetLocalPos(childNode, pos[1], pos[2], pos[3])
end

function ShowDangeLevel(isDanger, cfgs, currDanger)
    local dangerPanel =infoUtil:GetPanel("Danger")
    if isDanger and cfgs then
        dangerPanel.ShowDangeLevel(isDanger, cfgs, currDanger)
    end
end

function SetItemPos(typeName,x,y)
    local panel = infoUtil:GetPanel(typeName)
    if panel then
        panel.SetPos(x,y)
    end
end