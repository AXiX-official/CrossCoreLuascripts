-- 立绘拖动
function Awake()
    slider_AdjustSlider = ComUtil.GetCom(AdjustSlider, "Slider")
    slider_AdjustSlider.minValue = g_MutiLookScale[1]
    slider_AdjustSlider.maxValue = g_MutiLookScale[2]
end

function OnDestroy()
    CSAPI.RemoveSliderCallBack(AdjustSlider, SliderCB)
end

function OnOpen()
    mulIconItem = data[1]
    iconParent = data[2]
    cb = data[3]
    cache = data[4]

    InitBG()
    InitSlider()
    InitPos()

    if (not isSet) then
        isSet = 1
        CSAPI.AddSliderCallBack(AdjustSlider, SliderCB)
    end

    SetAmplification(true)
    --InitImgRT()
end

function InitBG()
    local curBGID = PlayerClient:GetBG()
    local cfg = Cfgs.CfgMenuBg:GetByID(curBGID)
    if (cfg and cfg.name) then
        ResUtil:LoadMenuBg(showBg, "UIs/" .. cfg.name, false)
    end
end

function InitSlider()
    local scale = CSAPI.GetScale(iconParent)
    slider_AdjustSlider.value = scale
end

function InitPos()
    CSAPI.SetParent(iconParent, iconPoint2)
    if (cache) then
        CSAPI.SetAnchor(iconParent, cache.x, cache.y, 0)
        CSAPI.SetScale(iconParent, cache.scale, cache.scale, 1)
    end
end

--导览窗口
-- function InitImgRT()
--     local imgName = mulIconItem.GetIconName()
--     ResUtil.MultiIcon:Load(imgRT2, imgName, false)

--     local imgScale = mulIconItem.GetImgSize()
--     local canvasScale = CSAPI.GetMainCanvasSize()
--     rate = 215 / imgScale[1]
--     CSAPI.SetRTSize(imgRT3, math.floor(canvasScale[0] * rate), math.floor(canvasScale[1] * rate))

--     OnUIHandleDrag()
-- end

-- function OnUIHandleDrag()
--     local x, y = CSAPI.GetAnchor(iconParent)
--     CSAPI.SetAnchor(imgRT3, -x*rate, -y*rate, 0)
-- end


-- 设置放大
function SetAmplification(_show)
    if (showIng and showIng == _show) then
        return
    end
    showIng = _show
    if (_show) then
        local imgScale = 1--mulIconItem.GetCfgScale()
        mulIconItem.SetClickActive(false)
        if (not uiHandle) then
            uiHandle = ComUtil.GetCom(handleMask, "UIHandle")
            uiHandle.isMoveLimit = false 
        end
        uiHandle:InitParm(1, 1, g_MutiLookScale[1] / imgScale, g_MutiLookScale[2] / imgScale) -- 对应的是父类不是role
        uiHandle:Init(iconParent)--, nil, true, false)
        --uiHandle:SetMoveInside(math.ceil(imgScale[0]), math.ceil(imgScale[1]), true)
        uiHandle:SetSliderCB(SetSliderValue)
    else
        uiHandle:Init(nil)
        mulIconItem.SetClickActive(true)
    end
end

-- g_MutiLookScale: 0.8 - 1.3 
-- 滑动回调，调整图片大小
function SliderCB(num)
    CSAPI.SetScale(iconParent, num, num, 1)
end

-- C#调整图片大小回调，这里设置滑动条位置
function SetSliderValue()
    local scale = CSAPI.GetScale(iconParent)
    slider_AdjustSlider.value = scale
end

-- 重置
function OnClickAdjustReset()
    CSAPI.SetAnchor(iconParent, 0, 0, 0)
    CSAPI.SetScale(iconParent, 1, 1, 1)
    slider_AdjustSlider.value = 1
end

-- 保存（返回主界面）
function OnClickAdjustSave()
    cb("save")
    view:Close()
end

-- 取消
function OnClickAdjustCancel()
    cb("cancel")
    view:Close()
end
