-- 角色立绘大图 （管理点击音效）
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
-- @_isUseShopImg:是否使用特殊宣传图
-- @return 
-- ==============================--
function Refresh(_modelId, _posType, _callBack,_isUseShopImg)

    if (not isInit and _modelId == nil or _posType == nil) then
        return
    end

    modelId = _modelId
    posType = _posType
    callBack = _callBack
    isUseShopImg=_isUseShopImg;
    -- 重置点击记录
    if (oldModelId ~= nil) then
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
    
    SetFaceItem()
end

function SetFaceItem()
    if(not faceLua) then 
        ResUtil:CreateUIGOAsync("Common/CharacterImgItem", faceNode, function(go)
            faceLua = ComUtil.GetLuaTable(go)
            faceLua.Init(modelId, CreateFaceCB,isUseShopImg)
        end)
    else 
        faceLua.Init(modelId, CreateFaceCB,isUseShopImg)
    end 
end

-- function SetFaceItem()
--     -- 表情预制物(同步的)
--     if (not faceLua) then
--         CSAPI.SetGOActive(faceNode, false)
--         faceLua = ResUtil:CreateCharacterImg(faceNode, modelId, CreateFaceCB)
--         faceLua.SetMask(false)
--     else
--         faceLua.Init(modelId, CreateFaceCB)
--     end
--     if (faceLua.canvasGroup) then
--         faceLua.canvasGroup.alpha = 1
--     end
-- end

-- 加载立绘后回调
function CreateFaceCB(_img)
    local pos, scale, img, l2dName = RoleTool.GetImgPosScale(modelId, posType)
    CSAPI.SetGOActive(faceNode, true)
    CSAPI.SetAnchor(imgObj, pos.x, pos.y, pos.z)
    CSAPI.SetScale(imgObj, scale, scale, 1)
    local size = CSAPI.GetRTSize(_img)
    CSAPI.SetRTSize(imgObj, size[0], size[1])  --设置碰撞体的大小
    if (callBack) then
        callBack()
    end
    imgScale = scale * posType[3]
end

-- 位置触摸
function SetTouch()
    if (not needClick) then
        return
    end
    touchItems = touchItems or {}
    touchDatas = {}
    local cfg = Cfgs.CfgImageAction:GetByID(modelId)
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

function SetClickActive(b)
    isActive = b
    img_imgObj.raycastTarget = b
end

-- 点击
function OnClick()
    PlayVoice()
end

-- 类型
function PlayVoice(type)
    type = type == nil and RoleAudioType.touch or type
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:PlayByType(modelId, type, nil, PlayCB, EndCB)
    end
end

-- 声音id
function PlayVoiceByID(id)
    if (not RoleAudioPlayMgr:GetIsPlaying()) then
        RoleAudioPlayMgr:PlayById(modelId, id, PlayCB, EndCB)
    end
end

function PlayCB(curCfg)
    faceLua.SetFaceByIndex(curCfg.faceIndex)
    if (playCallBack) then
        playCallBack(curCfg)
    end
end

function EndCB()
    faceLua.HideFace()
    if (endCallBack) then
        endCallBack()
    end
end

function GetImgScale()
    return imgScale or 1
end

-- 拉扯
function PlayLC()
    faceLua.PlayLC()
end

function SetBlack(isBlack)
    faceLua.SetBlack(isBlack)
end
