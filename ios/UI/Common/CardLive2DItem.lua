local isInit = false
local isActive = true
local imgScale = 1
local oldModelId = nil
local clickRecords = {}
local mulNames = {} -- 多段组点击记录
local hideTxt = false
local graphic = nil;
function Awake()
    img_imgObj = ComUtil.GetCom(imgObj, "Image")
end

function Init(_playCB, _endCB, _needClick)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    isInit = true
end

function Refresh(_modelId, _posType, _callBack)
    if (not isInit or _modelId == nil or _posType == nil) then
        return
    end
    modelId = _modelId
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

    cfg = Cfgs.CfgSpineAction:GetByID(modelId)

    SetTouch()

    SetImg()
end

function SetImg()
    local pos, scale, img, l2dName = RoleTool.GetImgPosScale(modelId, posType, true)
    CSAPI.SetAnchor(prefabObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(prefabObj, scale, scale, 1)
    if (l2dName) then
        if (l2dGo) then
            SetBlack(false);
            CSAPI.RemoveGO(l2dGo)
            l2dGo = nil
        end
        ResUtil:CreateSpine(l2dName .. "/" .. l2dName, 0, 0, 0, prefabObj, function(go)
            l2dGo = go
            l2d = ComUtil.GetCom(l2dGo, "CSpine")
            graphic = ComUtil.GetComInChildren(l2dGo, "SkeletonGraphic");
            SetBlack(false);
            if (callBack) then
                callBack()
            end
        end)
    end

    imgScale = scale * posType[3]

    SetClickImg()
end

-- img 不显示，用于普通点击 
function SetClickImg()
    local pos, scale, img, l2dName = RoleTool.GetImgPosScale(modelId, posType, false)
    CSAPI.SetAnchor(imgObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(imgObj, scale, scale, 1)
    ResUtil.ImgCharacter:Load(imgObj, img)
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
                if (v.sName ~= "in" and not v.hideAreas) then
                    table.insert(touchDatas, v)
                end
            end
        end
    end
    ItemUtil.AddItems("Common/CardTouchItem", touchItems, touchDatas, prefabObj, TouchItemClickCB, 1, this)
end

-- 点击触发
function TouchItemClickCB(_cfgChild)
    if (isIn or RoleAudioPlayMgr:GetIsPlaying()) then
        return
    end
    -- 随机动作 
    local cfgChild = nil
    if (_cfgChild.randomAnim) then
        local num = CSAPI.RandomInt(0, 100)
        local count = 0
        for k, v in ipairs(_cfgChild.randomAnim) do
            count = count + v[2] * 100
            if (num <= count) then
                cfgChild = cfg.item[v[1]]
                break
            end
        end
    end
    cfgChild = cfgChild or _cfgChild

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
    -- if (CheckCanClick() or cfgChild.trackIndex == 10) then
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
    local moveSpeed = cfgChild.clickNum[4] and cfgChild.clickNum[4] * 0.001 or 0.001
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
--     if (l2d:CheckTrackIndex(cfgChild.trackIndex) == 0) then
--         l2d:Play(cfgChild.trackIndex, cfgChild.sName, false, nil, 0)
--     end
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
                local isOpen = RoleAudioPlayMgr:CheckAndioIsOpen(modelId, _audioId)
                if (isOpen) then
                    audioId = _audioId
                    break
                end
            end
        end
        clickRecords[cfgChild.index] = newIndex
        RoleAudioPlayMgr:PlayById(modelId, audioId, PlayCB, EndCB)
    end
end

-- 能否点击
function SetClickActive(b)
    isActive = b
    img_imgObj.raycastTarget = b
end

function PlayVoice(type)
    type = type == nil and RoleAudioType.touch or type
    if (not voicePlaying) then
        RoleAudioPlayMgr:PlayByType(modelId, type, nil, PlayCB, EndCB)
    end
end

function PlayVoiceByID(id)
    if (not voicePlaying) then
        RoleAudioPlayMgr:PlayById(modelId, id, PlayCB, EndCB)
    end
end

function PlayCB(curCfg)
    voicePlaying = true
    if (not hideTxt and playCallBack) then
        playCallBack(curCfg)
    end
end

function EndCB()
    voicePlaying = false
    if (not hideTxt and endCallBack) then
        endCallBack()
    end
end

-- 点击
function OnClick()
    if (not needClick) then
        return
    end
    PlayVoice()
end

-- 类型
function PlayVoice(type)
    type = type == nil and RoleAudioType.touch or type
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:PlayByType(modelId, type, nil, PlayCB, EndCB)
    end
end

function GetImgScale()
    return imgScale or 1
end

function SetBlack(isBlack)
    if l2dGo and graphic then
        graphic.color = isBlack and UnityEngine.Color.black or UnityEngine.Color.white;
    end
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

--是否有开场动画语音
function HadInAudio()
    if (cfg) then
        for k, v in ipairs(cfg.item) do
            if (v.sName == "in") then
                return v.audioId ~= nil
            end
        end
    end
    return false
end
