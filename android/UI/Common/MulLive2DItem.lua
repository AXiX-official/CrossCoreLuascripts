local isInit = false
local imgScale = 1
local hideTxt = false
local graphic = nil
local spineTools = nil
local oldModelId = nil
local records = {} -- 动作组播放进度记录+单动画播放到指定百分比 (key:index value:下标)
local dragObj = nil -- 当前拖放的物体
local dragStartPos = nil -- 当前拖放开始的位置
local dragTargetPos = nil -- 当前拖放目标位置
local isDrag = false
local isHeXie = false -- 和谐了
local clickCounts = {} -- actions 某段点击次数
local inter = 0.5
local timer = 0

--不同
function Awake()
    spineTools = SpineTools.New()
end

function Init(_playCB, _endCB, _needClick)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    isInit = true
end

function Refresh(_modelId, _posType, _callBack,_needClick)
    if (not isInit or _modelId == nil) then
        return
    end
    modelId = _modelId
    posType = _posType
    callBack = _callBack
    if(_needClick~=nil)then 
        needClick = _needClick
    end 
    -- 重置点击记录
    if (oldModelId and oldModelId == _modelId) then
        if (callBack) then
            callBack()
        end
        return -- 相同的话不往下
    end
    oldModelId = _modelId
    records = {}
    if (dragObj) then
        CSAPI.RemoveGO(dragObj)
    end
    dragObj = nil

    cfg = Cfgs.CfgSpineMultiImageAction:GetByID(modelId)

    SetImg()

    -- SetTouch()
end

--不同
function SetImg()
    -- 多人插图立绘是会根据异形屏幕做适配的，所以l2d也要按照适配的比例做大小调整，但不是作用在sizeDetail上而是作用在scale上，因为子点击位置是固定的
    rate = 1--UIUtil:GetSceneRate({2240, 1080})

    local pos, scale, img, l2dName = RoleTool.GetMulImgPosScale(modelId, posType, true)

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
            local l2d = ComUtil.GetCom(l2dGo, "CSpine")
            graphic = ComUtil.GetComInChildren(l2dGo, "SkeletonGraphic")
            if(l2d) then 
                spineTools:Init(l2d)
            end 
            isHeXie = false 
            if (not l2d or not l2d.animationState) then
                isHeXie = true
            end
            SetBlack()
            SetTouch()

            if (callBack) then
                callBack()
            end
        end)
    end

    imgScale = scale
end


-- 位置触摸
function SetTouch()
    touchItems = touchItems or {}
    touchDatas = {}
    if (needClick) then
        if (cfg and #cfg.item > 0) then
            for k, v in ipairs(cfg.item) do
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
    if (Time.time < timer) then
        return
    end
    timer = Time.time + inter

    if (isHeXie or isIn or isDrag) then -- or RoleAudioPlayMgr:GetIsPlaying()) then
        return
    end
    local content = cfgChild.content or {}

    local sName, timeScale, progress,isClicksLast = cfgChild.sName, 1, 1,false
    -- content内容
    if (cfgChild.content) then
        sName, timeScale, progress,isClicksLast = SetContent(cfgChild)
    end
    if (not sName) then
        return
    end
    -- 轨道
    local trackIndex = GetTrackIndex(cfgChild)
    local isCan = false
    if (trackIndex == 1) then
        -- 1轨道需要在idle状态下才能点击 或 前后都是同一多动作，并且不是最后一个动作
        if (IsIdle() or content.actions ~= nil) then
            isCan = true
        end
    else
        isCan = true
    end
    if (isCan) then
        local b = false
        if (trackIndex ~= 1 and content.clicks ~= nil) then
            b = spineTools:PlayByMulClick(sName, trackIndex, timeScale, progress, isClicksLast)
        elseif (content.actions ~= nil) then
            -- 首次播放或者再次点击
            local _sName = spineTools:GetNameByTrackIndex(trackIndex)
            if (sName == _sName) then
                spineTools:ResetActionsClick(trackIndex, content.actions.stopPerc, content.actions.stopLimit)
            elseif (not _sName) then
                b = spineTools:PlayByActionsClick(sName, trackIndex, true, true, nil, content.actions.stopPerc,
                    content.actions.stopTime, content.actions.stopCount)
            end
        else
            b = spineTools:PlayByClick(sName, trackIndex, true, true, nil)
        end
        if (b) then
            PlayAudio(cfgChild)
            MissionMgr:DoClickBoard()
        end
    end
end

--当前是否在使用第二套角色
function GetCurRoleNum()
    return 1
end

-- 拖拽开始
function ItemDragBeginCB(cfgChild, x, y)
    if (isHeXie or isIn or isDrag or not IsIdle()) then
        return
    end
    local content = cfgChild.content or {}
    if (CheckIsDrag(cfgChild)) then
        dragObj = l2dGo.transform:Find("pos/" .. content.drag.targetObjName).gameObject
        dragStartPos = CSAPI.csGetAnchor(dragObj)
        CSAPI.SetGOActive(dragObj, true)
        for k, v in pairs(content.drag.slots) do
            local slot = graphic.Skeleton:FindSlot(v)
            if (slot) then
                slot.A = 0
            end
        end
    end
    PlayAudio(cfgChild)
    isDrag = true
end
-- 拖拽中
function ItemDragCB(cfgChild, x, y)
    if (isDrag == nil or not isDrag) then
        return
    end
    if (CheckIsDrag(cfgChild)) then
        -- 在 CardTouchItem中设置dragGO
        -- if (dragObj) then
        --     CSAPI.SetAnchor(dragObj, x, y, 0)
        -- end
    else
        local content = cfgChild.content or {}
        if (content.gestureDatas) then
            local limit = content.gestureDatas.limitPerc or 1
            spineTools:PlayByDrag(cfgChild.sName, GetTrackIndex(cfgChild), cfgChild.gesture, x, y, limit,
                content.gestureDatas.speed * 0.001)
        end
    end
end
-- 拖拽结束
function ItemDragEndCB(cfgChild, x, y)
    if (isDrag == nil or not isDrag) then
        return
    end
    isDrag = nil
    local content = cfgChild.content or {}
    if (CheckIsDrag(cfgChild)) then
        if (dragObj) then
            local _dragStartPos = CSAPI.csGetPos(dragObj)
            local startPos = UnityEngine.Vector3(_dragStartPos[0], _dragStartPos[1], 0)
            local targetObj = l2dGo.transform:Find("pos/" .. content.drag.targetPosObjName).gameObject
            local dragTargetPos = CSAPI.csGetPos(targetObj)
            local targetPos = UnityEngine.Vector3(dragTargetPos[0], dragTargetPos[1], 0)
            local dis = UnityEngine.Vector3.Distance(startPos, targetPos)
            if (dis < 10) then
                spineTools:PlayByClick(cfgChild.sName, GetTrackIndex(cfgChild), true, true)
                PlayAudio(cfgChild)
                -- spineTools:ClickRecover(cfgChild.sName, GetTrackIndex(cfgChild), content.drag.stopTime or 0)
            end
            CSAPI.SetAnchor(dragObj, dragStartPos[0], dragStartPos[1], 0)
            CSAPI.SetGOActive(dragObj, false)
            for k, v in pairs(content.drag.slots) do
                local slot = graphic.Skeleton:FindSlot(v)
                if (slot) then
                    slot.A = 1
                end
            end
        end
    else
        if (content.gestureDatas and content.gestureDatas.stopTime >= 0) then
            local forward = false
            local limit = content.gestureDatas.splitPerc or 1
            if (limit ~= 1) then
                local trackIndex = GetTrackIndex(cfgChild)
                local cur = spineTools:GetTrackTimePercent(trackIndex)
                if (limit - cur < 0.01) then
                    forward = true
                end
            end
            spineTools:Recover(cfgChild.sName, GetTrackIndex(cfgChild), content.gestureDatas.stopTime, forward)
        end
    end
end
function PlayAudio(cfgChild)
    if (RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:StopSound()
        -- return
    end

    hideTxt = false
    if (cfgChild.hideTxt and cfgChild.hideTxt == 1) then
        hideTxt = true
    end
    local audioId = nil
    local audioIds = cfgChild.audioId
    local content = cfgChild.content or {}
    if (audioIds and #audioIds > 0) then
        local index = 1
        if (#audioIds > 1) then
            if (content.actions or content.clicks or content.randomActions or content.orderActions) then
                -- 顺序
                if (records[cfgChild.index]) then
                    index = records[cfgChild.index]
                end
            else
                -- 随机 
                local len = #audioIds
                index = CSAPI.RandomInt(1, len)
            end
        end
        audioId = audioIds[index]
    end
    if (audioId) then
        RoleAudioPlayMgr:PlayById(modelId, audioId, PlayCB, EndCB)
    end
end


function IsIdle()
    if (spineTools) then
        return spineTools:IsIdle()
    end
    return false
end

-- 能否点击 不同
function SetClickActive(b)
    isActive = b
    CSAPI.SetGOActive(mask,b)
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

-- 点击 rui240710 不会进入这里，点击无动作区域会触发OnClickMask
function OnClick()
    -- if (not needClick) then
    --     return
    -- end
    -- PlayVoice()
end

-- 类型
function PlayVoice(type)
    type = type == nil and RoleAudioType.touch or type
    if (type == RoleAudioType.touch) then
        local cfg = Cfgs.character:GetByID(modelId)
        if (cfg and cfg.base_voiceID ~= nil) then
            return -- 如果是商城皮肤并且填了保底台词，则不需要普通触摸语音
        end
    end
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:PlayByType(modelId, type, nil, PlayCB, EndCB)
    end
end

function GetImgScale()
    return imgScale or 1
end

function SetBlack(isBlack)
    if l2dGo then
        UIUtil:SetLiveBroadcast(l2dGo,isBlack)
    end
end
-------------进场------------------------

function CheckIn()
    if (not isHeXie and spineTools~=nil and spineTools:CheckAnimExist("in")) then
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
    spineTools:PlayIn(InExit)
    -- audio 
    for k, v in ipairs(cfg.item) do
        if (v.sName == "in") then
            PlayAudio(v)
            break
        end
    end
    HideBtns()
    PlayInEffect(cfg)
end

-- 特效1 
function InExit()
    isIn = false
    ResUtil:CreateEffect("pifuzhuanshi/fc_pifu_ToWhite", 0, 0, 0, gameObject, function(go)
        effect1 = go
        FuncUtil:Call(function()
            spineTools:ClearTrack(1)
        end, nil, 100)
        FuncUtil:Call(PlayInCB, nil, 350)
    end)
end

-- 播完时进场动画时回调，或者切换动画时立即回调
function PlayInCB()
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
    RemoveInEffect()
end

function Update()
    -- 中断进场动画 
    if (isIn and CS.UnityEngine.Input.GetMouseButton(0)) then
        isIn = false
        spineTools:SetTrackEntryComplte(1)
    end

    if (spineTools ~= nil) then
        spineTools:Update()
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

-- 入场特效（下次改版得删）
function PlayInEffect(cfg)
    for k, v in ipairs(cfg.item) do
        if (v.sName == "in") then
            if (v.effect) then
                local parent = l2dGo.transform:Find("pos").gameObject
                local low = CSAPI.GetGameLv() <= 2
                CSAPI.CreateGOAsync("Spine/" .. v.effect, 0, 0, 0, parent, function(go)
                    inEffectGo = go
                end, low)
            end
            break
        end
    end
end

function RemoveInEffect()
    if (inEffectGo) then
        CSAPI.RemoveGO(inEffectGo)
    end
end
------------------进场end----------------------------

------------------------------新内容-----------------------------



-- 点击 content内容
function SetContent(cfgChild)
    local content = cfgChild.content
    local sName, timeScale, progress, isClicksLast = cfgChild.sName, 1, 1, false
    -- 激活与隐藏
    if (content.activation) then
        for k, v in pairs(touchItems) do
            local num = content.activation[v:GetIndex() .. ""]
            if (num) then
                CSAPI.SetGOActive(v.gameObject, num == 1)
            end
        end
    end
    -- 随机动作
    if (content.randomActions) then
        local num = CSAPI.RandomInt(0, 100)
        local _k = 1
        local count = 0
        for k, v in ipairs(content.randomActions) do
            count = count + v[2] * 100
            if (num <= count) then
                sName = v[1]
                _k = k
                break
            end
        end
        records[cfgChild.index] = _k
    end
    -- 顺序动作
    if (content.orderActions) then
        local index = records[cfgChild.index] or 0
        index = (index + 1) > #content.orderActions and 1 or  (index + 1)
        sName = content.orderActions[index]
        records[cfgChild.index] = index
    end
    -- 播放到指定百分比 
    if (content.clicks) then
        if (spineTools:CheckMulClickIsPlay(GetTrackIndex(cfgChild))) then
            sName = nil
        else
            local num = 1
            if (records[cfgChild.index] and records[cfgChild.index] < #content.clicks) then
                num = records[cfgChild.index] + 1
            end
            records[cfgChild.index] = num
            progress = content.clicks[num]
            timeScale = progress == 0 and -1 or 1
            isClicksLast = num >= #content.clicks
        end
    end

    return sName, timeScale, progress, isClicksLast
end

-- 轨道
function GetTrackIndex(cfgChild)
    if (cfgChild.sType < 6) then
        return 1
    end
    return cfgChild.index
end

-- 拖放
function CheckIsDrag(cfgChild)
    if (cfgChild.sType == SpineActionType.RoleDrag or cfgChild.sType == SpineActionType.ElseDrag) then
        return true
    end
    return false
end

--------------------------------------

function Reset()
    oldModelId = nil
    clickRecords = {}
end

-- 是否有开场动画语音
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


function ClearCache()
    if (l2dGo) then
        CSAPI.RemoveGO(l2dGo)
    end
    l2dGo = nil
    if (dragObj) then
        CSAPI.RemoveGO(dragObj)
    end
    dragObj = nil
    oldModelId = nil
    records = {}
end

-------------------------------------不同

function GetImgSize()
    local x = 2240 * rate
    local y = 1080 * rate
    return {
        [0] = x,
        [1] = y
    }
end

function GetIconName()
    local _cfg = Cfgs.CfgArchiveMultiPicture:GetByID(modelId)
    return _cfg.icon
end

function OnClickMask()
    MissionMgr:DoClickBoard()
end