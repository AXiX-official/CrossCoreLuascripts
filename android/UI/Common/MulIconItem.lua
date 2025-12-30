isLive2D = true

function Awake()
    local arr = CSAPI.GetScreenSize()
    CSAPI.SetRTSize(gameObject, arr[0], arr[1])
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
end

-- _force 强制l2d显示或者隐藏
function Refresh(_modelId, _posType, _callBack, _force,_isUseShopImg,_needClick)
    if (not isInit and _modelId == nil) then
        return
    end

    modelId = _modelId
    posType = _posType
    callBack = _callBack
    cfg = Cfgs.CfgArchiveMultiPicture:GetByID(modelId)
    isUseShopImg=_isUseShopImg
    if(_needClick~=nil)then 
        needClick = _needClick
    end 
    if (not cfg.l2dName) then
        isLive2D = false
    else
        if (_force ~= nil) then
            -- 强制处理，不记录
            isLive2D = _force
        else
            isLive2D = true -- 默认查看
        end
    end

    if (cfg) then
        if (isLive2D) then
            AddImgItem(false)
            AddLive2DItem(true)
        else
            AddLive2DItem(false)
            AddImgItem(true)
        end
    else
        AddLive2DItem(false)
        AddImgItem(false)
    end
end

-- 立绘
function AddImgItem(isAdd)
    if (not isAdd) then
        if (imgItemLua) then
            CSAPI.SetGOActive(imgItemLua.gameObject, false)
        end
        return
    end
    if (imgItemLua == nil) then
        local go = ResUtil:CreateUIGO("Common/MulImgItem", transform)
        imgItemLua = ComUtil.GetLuaTable(go)
        imgItemLua.Init(playCallBack, endCallBack, needClick)
    else
        CSAPI.SetGOActive(imgItemLua.gameObject, true)
    end
    imgItemLua.Refresh(modelId, posType, callBack,isUseShopImg,needClick)
end

-- live2d
function AddLive2DItem(isAdd)
    if (not isAdd) then
        if (live2DItemLua) then
            live2DItemLua.Reset()
            CSAPI.SetGOActive(live2DItemLua.gameObject, false)
        end
        return
    end
    if (live2DItemLua == nil) then
        local go = ResUtil:CreateUIGO("Common/MulLive2DItem", transform)
        live2DItemLua = ComUtil.GetLuaTable(go)
        live2DItemLua.Init(playCallBack, endCallBack, needClick)
    else
        CSAPI.SetGOActive(live2DItemLua.gameObject, true)
    end
    live2DItemLua.Refresh(modelId, posType, callBack,needClick)
end

function SetClickActive(b)
    if (isLive2D) then
        if (live2DItemLua) then
            live2DItemLua.SetClickActive(b)
        end
    else
        if (imgItemLua) then
            imgItemLua.SetClickActive(b)
        end
    end
end

function PlayVoice(_type)
    if (isLive2D) then
        if (live2DItemLua) then
            live2DItemLua.PlayVoice(_type)
        end
    else
        if (imgItemLua) then
            imgItemLua.PlayVoice(_type)
        end
    end
end

function PlayVoiceByID(id)
    if (isLive2D) then
        if (live2DItemLua) then
            live2DItemLua.PlayVoiceByID(id)
        end
    else
        if (imgItemLua) then
            imgItemLua.PlayVoiceByID(id)
        end
    end
end

-- 模型表上设置的大小（已加上偏移）
function GetCfgScale()
    local scale = 1
    if (isLive2D) then
        if (live2DItemLua) then
            scale = live2DItemLua.GetImgScale()
        end
    else
        if (imgItemLua) then
            scale = imgItemLua.GetImgScale()
        end
    end
    return scale
end

function IsLive2D()
    return isLive2D
end

-- 拉扯
function PlayLC()

end

-- 是否有进场动画 
function CheckIn()
    if (cfg.l2dName and live2DItemLua) then
        return live2DItemLua.CheckIn()
    end
    return false
end

-- 播放入场动画
function PlayIn(cb, movePoint)
    if (live2DItemLua) then
        live2DItemLua.PlayIn(cb, movePoint)
    end
end

-- 大小
function GetImgSize()
    if (isLive2D) then
        return live2DItemLua.GetImgSize()
    else
        return imgItemLua.GetImgSize()
    end
end

function GetIconName()
    if (isLive2D) then
        return live2DItemLua.GetIconName()
    else
        return imgItemLua.GetIconName()
    end
end

--是否有开场动画语音
function HadInAudio()
   return false 
end


function EnNeedClick(b)
    needClick = b 
    if (isLive2D) then
        if (live2DItemLua) then
            live2DItemLua.needClick = needClick
        end
    else
        if (imgItemLua) then
            imgItemLua.needClick = needClick
        end
    end
end

function ClearCache()
    if (isLive2D and live2DItemLua and live2DItemLua.ClearCache~=nil) then
        live2DItemLua.ClearCache()
    end 
end

function SetLiveBroadcast()
    if (isLive2D) then
        if (live2DItemLua) then
            live2DItemLua.SetBlack()
        end
    else
        if (imgItemLua) then
            imgItemLua.SetBlack()
        end
    end
end