local isInit = false
local isActive = true
local imgScale = 1
local oldModelId = nil
local clickRecords = {}

function Awake()
    img_imgObj = ComUtil.GetCom(imgObj, "Image")
end

-- ==============================--
-- desc:
-- time:2020-11-10 02:12:43
-- @_playCB:
-- @_endCB:
-- @_needClick:是否可点触发语音，固定播放的情景（出击时、胜利时等是不需要的）
-- @return 
-- ==============================--
function Init(_playCB, _endCB, _needClick)
    playCallBack = _playCB
    endCallBack = _endCB
    needClick = (_needClick ~= nil) and _needClick or false
    isInit = true

    SetClickActive(needClick)
end

-- ==============================--
-- desc:
-- time:2020-11-10 11:07:47
-- @_modelId:
-- @_posType:
-- @_callBack:
-- @_needFace:
-- @return 
-- ==============================--
function Refresh(_modelId, _posType, _callBack)
    if (not isInit and _modelId == nil) then
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

    SetTouch()

    SetImg()
end

function SetImg()
    -- 多人插图立绘是会根据异形屏幕做适配的，所以l2d也要按照适配的比例做大小调整，但不是作用在sizeDetail上而是作用在scale上，因为子点击位置是固定的
    rate = UIUtil:GetSceneRate({2240, 1080})
    local pos, scale, img, l2dName = RoleTool.GetMulImgPosScale(cfgID, posType)

    scale = scale * rate

    cfg = Cfgs.CfgArchiveMultiPicture:GetByID(cfgID)
    ResUtil.MultiImg:Load(imgObj, cfg.img, nil, true)
    CSAPI.SetAnchor(imgObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(imgObj, scale, scale, 1)
    if (callBack) then
        callBack()
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
    local cfg = Cfgs.CfgMultiImageAction:GetByID(cfgID)
    if (cfg and #cfg.item > 0) then
        touchDatas = cfg.item
    end
    ItemUtil.AddItems("Common/CardTouchItem", touchItems, touchDatas, imgObj, PlayAudio, 1, this)
end

function PlayAudio(cfgChild)
    if (RoleAudioPlayMgr:GetIsPlaying()) then
        return
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

        RoleAudioPlayMgr:PlayById(nil, audioId, PlayCB, EndCB)
    end
end

function SetClickActive(b)
    isActive = b
    img_imgObj.raycastTarget = b
end

-- 点击
function OnClick()

end

-- 类型
function PlayVoice(type)

end

-- 声音id
function PlayVoiceByID(id)
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:PlayById(nil, id, PlayCB, EndCB)
    end
end

function PlayCB(curCfg)
    if (playCallBack) then
        playCallBack(curCfg)
    end
end

function EndCB()
    if (endCallBack) then
        endCallBack()
    end
end

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

-- function GetImgSize()
--     return CSAPI.GetRTSize(imgObj)
-- end

-- 拉扯
function PlayLC()

end

function SetBlack(isBlack)

end

function GetIconName()
    return cfg.icon
end
