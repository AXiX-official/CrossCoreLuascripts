local isInit = false
local isActive = true
local imgScale = 1
local oldModelId = nil
local clickRecords = {}
local mulNames = {} -- 多段组点击记录
local hideTxt = false

function Init(_playCB, _endCB, _needClick)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    isInit = true
end

function Refresh(_modelId, _posType, _callBack)
    if (not isInit or _modelId == nil) then
        return
    end
    cfgID = _modelId
    posType = _posType
    callBack = _callBack

    -- 重置点击记录
    if (oldModelId) then
        if (oldModelId ~= _modelId) then
            clickRecords = {}
        else
            if (callBack) then
                callBack()
            end
            return
        end
    end
    oldModelId = _modelId

    cfg = Cfgs.CfgSpineMultiImageAction:GetByID(cfgID)

    SetTouch()

    SetImg()
end

function SetImg()
    -- 多人插图立绘是会根据异形屏幕做适配的，所以l2d也要按照适配的比例做大小调整，但不是作用在sizeDetail上而是作用在scale上，因为子点击位置是固定的
    rate = UIUtil:GetSceneRate({2240, 1080})

    local pos, scale, img, l2dName = RoleTool.GetMulImgPosScale(cfgID, posType, true)

    scale = scale * rate

    CSAPI.SetAnchor(prefabObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(prefabObj, scale, scale, 1)
    if (l2dName) then
        if (l2dGo) then
            CSAPI.RemoveGO(l2dGo)
            l2dGo = nil
        end
        ResUtil:CreateSpine(l2dName .. "/" .. l2dName, 0, 0, 0, prefabObj, function(go)
            l2dGo = go
            l2d = ComUtil.GetCom(l2dGo, "CSpine")
            if (callBack) then
                callBack()
            end
        end)
    end

    imgScale = scale
end

-- 位置触摸
function SetTouch()
    if (not needClick) then
        return
    end
    touchItems = touchItems or {}
    touchDatas = {}
    if (cfg and #cfg.item > 0) then
        for k, v in ipairs(cfg.item) do
            if (v.mul) then
                if (not mulNames[v.sName]) then
                    table.insert(touchDatas, v) -- 直接添加第一个
                    mulNames[v.sName] = k
                else
                    if (v.index == mulNames[v.sName]) then
                        table.insert(touchDatas, v)
                    end
                end
            else
                if (v.sName ~= "in") then
                    table.insert(touchDatas, v)
                end
            end
        end
    end
    ItemUtil.AddItems("Common/CardTouchItem", touchItems, touchDatas, prefabObj, TouchItemClickCB, 1, this)
end

-- 点击触发
function TouchItemClickCB(cfgChild)
    if (isIn or RoleAudioPlayMgr:GetIsPlaying()) then
        return
    end

    if (cfgChild.gesture ~= nil and cfgChild.gesture ~= 0) then
        return
    end

    -- 1轨道需要在idle状态下才能点击
    if (cfgChild.trackIndex ~= 1 or IsIdle()) then
        if (cfgChild.trackIndex == 1) then
            l2d:PlayOne(cfgChild.sName, function()
                ActionComplete(cfgChild)
            end) -- 不用考虑手势值非2的情况
        else
            if (cfgChild.clickNum[1] == 2) then
                l2d:PlayOther(cfgChild.sName, cfgChild.trackIndex, function()
                    ActionComplete(cfgChild)
                end)
            else
                l2d:PlayByClick(cfgChild.sName, cfgChild.clickNum[1] * 100, cfgChild.trackIndex)
            end
        end
        SetMulNext(cfgChild)
        PlayAudio(cfgChild)
    end

    -- -- 需要在idle状态下才能点击
    -- if (CheckCanClick()) then
    --     if (cfgChild.clickNum[1] == 2) then
    --         l2d:Play(cfgChild.trackIndex, cfgChild.sName)
    --     else
    --         l2d:PlayByClick(cfgChild.sName, cfgChild.clickNum[1] * 100, cfgChild.trackIndex)
    --     end

    --     SetMulNext(cfgChild)
    --     PlayAudio(cfgChild)
    -- end
end

-- 拖拽 
function ItemDragBeginCB(cfgChild)
    if (isIn or RoleAudioPlayMgr:GetIsPlaying()) then
        return
    end

    PlayAudio(cfgChild)
end

function ItemDragCB(cfgChild, x, y)
    if (cfgChild.gesture == nil or cfgChild.gesture == 0) then
        return
    end
    local limit = cfgChild.clickNum[5] or 1
    local moveSpeed = cfgChild.clickNum[4] and cfgChild.clickNum[4]*0.001 or 0.001
    l2d:PlayByDrag(cfgChild.sName, cfgChild.gesture, x, y, cfgChild.trackIndex, limit, moveSpeed)
end

function ItemDragEndCB(cfgChild)
    if (cfgChild.clickNum[1] == 1) then
        local limit = cfgChild.clickNum[6]
        if (limit) then
            local cur = l2d:GetTrackTime(cfgChild.sName)
            if (limit - cur < 0.01) then
                l2d:Recover(cfgChild.sName, 0, cfgChild.clickNum[3], true, 0, function()
                    ActionComplete(cfgChild)
                end) -- 向前播放
                return
            end
        end
        l2d:Recover(cfgChild.sName, cfgChild.clickNum[2], cfgChild.clickNum[3], false, 0, function()
            ActionComplete(cfgChild)
        end)
    end
end

-- 动画后续
function ActionComplete(cfgChild)
    if (cfgChild.camEffect) then
        local _cfg = cfg.item[cfgChild.camEffect]
        if (IsIdle() and _cfg and _cfg.trackIndex == 1 and _cfg.clickNum[1] == 2) then
            TouchItemClickCB(_cfg)
        end
    end
end

-- -- 丢出
-- function ThrowOut(cfgChild)
--     l2d:Play(cfgChild.trackIndex, cfgChild.sName, false, nil, 0)
-- end

function IsIdle()
    if (l2d) then
        return l2d:CheckIsIdle() == 1
    end
    return false
end

-- -- 能否点击 
-- function CheckCanClick()
--     if (l2d) then
--         return l2d:CheckTrackIndex(1) == 0
--     end
--     return false
-- end

-- 多段组的下一个动作
function SetMulNext(cfgChild)
    if (cfgChild.mul ~= nil) then
        local _nextIndex = cfgChild.index + 1
        local nextIndex = 0
        for k, v in ipairs(cfg.item) do
            if (v.mul == cfgChild.mul) then
                if (nextIndex == 0) then
                    nextIndex = k
                end
                if (v.index == _nextIndex) then
                    nextIndex = k
                    break
                end
            end
        end
        mulNames[cfgChild.sName] = nextIndex
        SetTouch()
    end
end

function PlayAudio(cfgChild)
    if (RoleAudioPlayMgr:GetIsPlaying()) then
        return
    end

    hideTxt = false
    if (cfgChild.hideTxt and cfgChild.hideTxt == 1) then
        hideTxt = true
    end

    local audioIds = cfgChild.audioId
    if (audioIds) then
        local audioId, newIndex = nil, nil
        local oldIndex = clickRecords[cfgChild.index]
        local len = #audioIds
        if (len == 1 or oldIndex == nil) then
            audioId = audioIds[1]
            newIndex = 1
        else
            local newIndex = oldIndex
            while audioId == nil do
                newIndex = (newIndex + 1) > len and 1 or (newIndex + 1)
                if (newIndex == oldIndex) then
                    audioId = audioIds[newIndex]
                    break
                end
                -- 是否可用 
                local _audioId = audioIds[newIndex]
                local isOpen = true -- RoleAudioPlayMgr:CheckAndioIsOpen(cfgID, _audioId)
                if (isOpen) then
                    audioId = _audioId
                    break
                end
            end
        end
        clickRecords[cfgChild.index] = newIndex
        RoleAudioPlayMgr:PlayById(cfgID, audioId, PlayCB, EndCB)
    end
end

-- 能否点击
function SetClickActive(b)
    isActive = b
end

function PlayVoice(type)
    type = type == nil and RoleAudioType.touch or type
    if (not voicePlaying) then
        RoleAudioPlayMgr:PlayByType(cfgID, type, nil, PlayCB, EndCB)
    end
end

function PlayVoiceByID(id)
    if (not voicePlaying) then
        RoleAudioPlayMgr:PlayById(cfgID, id, PlayCB, EndCB)
    end
end

function PlayCB(curCfg)
    voicePlaying = true
    if (playCallBack) then
        playCallBack(curCfg)
    end
end

function EndCB()
    voicePlaying = false
    if (endCallBack) then
        endCallBack()
    end
end

-- -- 点击
-- function OnClick()
--     if (not needClick) then
--         return
--     end
-- end

function GetImgScale()
    return imgScale or 1
end

function GetImgSize()
    local x = 2240 * rate
    local y = 1080 * rate
    return {
        [0] = x,
        [1] = y
    }
end

function GetIconName()
    local _cfg = Cfgs.CfgArchiveMultiPicture:GetByID(cfgID)
    return _cfg.icon
end

--------------------------------------------------进场-------------------------------------------------------------

function CheckIn()
    if (l2d and l2d:CheckAnimExist("in")) then
        return true
    end
    return false
end

-- 进场动画 
function PlayIn(cb, _movePoint)
    isIn = true
    inCB = cb
    movePoint = _movePoint or transform.parent.parent.gameObject
    SetParentPos(true)
    -- l2d:Play(1, "in", false, InExit, 0)
    l2d:PlayIn(InExit)
    -- audio 
    for k, v in ipairs(cfg.item) do
        if (v.sName == "in") then
            PlayAudio(v)
            break
        end
    end
    HideBtns()
end

-- 特效1 
function InExit()
    isIn = false
    ResUtil:CreateEffect("pifuzhuanshi/fc_pifu_ToWhite", 0, 0, 0, gameObject, function(go)
        effect1 = go
        FuncUtil:Call(PlayInCB, nil, 350)
    end)
end

-- 播完时进场动画时回调，或者切换动画时立即回调
function PlayInCB()
    -- l2d:SetSetupPose()
    -- l2d:Play(0, "idle", true, nil, 0)
    SetParentPos(false)

    -- 特效2
    if (effect1) then
        CSAPI.SetGOActive(effect1, false)
        CSAPI.RemoveGO(effect1)
    end
    UIUtil:SetObjScale(gameObject, 1.1, 1, 1.1, 1, 1.1, 1, nil, 300, 1)
    ResUtil:CreateEffect("pifuzhuanshi/fc_pifu_OutWhite", 0, 0, 0, gameObject, function(go)
        FuncUtil:Call(function()
            if (inCB) then
                inCB()
            end
            HideBtns()
            CSAPI.RemoveGO(go)
        end, nil, 300)
    end)
end

function Update()
    -- 中断进场动画 
    if (isIn and CS.UnityEngine.Input.GetMouseButton(0)) then
        isIn = false
        -- l2d:ImmPlayComplete(1)
        l2d:CurTrackEntryComplete()
    end
end

function HideBtns()
    if (touchItems) then
        local scale = isIn and 0 or 1
        for k, v in pairs(touchItems) do
            -- CSAPI.SetGOActive(v.gameObject, not isIn)
            CSAPI.SetScale(v.gameObject, scale, scale, scale)
        end
    end
end

function SetParentPos(toZero)
    if (toZero) then
        cachePos = CSAPI.csGetAnchor(movePoint)
        cacheScale = CSAPI.csGetScale(movePoint)
        CSAPI.SetAnchor(movePoint, 0, 0, 0)
        CSAPI.SetScale(movePoint, 1, 1, 1)
    else
        cachePos = cachePos or {
            [0] = 0,
            [1] = 0,
            [2] = 0
        }
        cacheScale = cacheScale or {
            [0] = 1,
            [1] = 1,
            [2] = 1
        }
        CSAPI.SetAnchor(movePoint, cachePos[0], cachePos[1], cachePos[2])
        CSAPI.SetScale(movePoint, cacheScale[0], cacheScale[1], cacheScale[2])
    end
end

--------------------------------------------------进场end-------------------------------------------------------------
function Reset()
    oldModelId = nil
    clickRecords = {}
end
