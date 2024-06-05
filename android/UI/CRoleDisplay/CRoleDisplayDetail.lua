-- 立绘拖动
function Awake()
    slider_AdjustSlider = ComUtil.GetCom(AdjustSlider, "Slider")
    slider_AdjustSlider.minValue = g_CardLookScale[1]
    slider_AdjustSlider.maxValue = g_CardLookScale[2]
end

function OnDestroy()
    CSAPI.RemoveSliderCallBack(AdjustSlider, SliderCB)
end

function OnOpen()
    cardIconItem = data[1]
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
end

function InitBG()
    local curBGID = PlayerClient:GetBG()
    local cfg = Cfgs.CfgMenuBg:GetByID(curBGID)
    if (cfg and cfg.name) then
        ResUtil:LoadBigImg2(showBg, "UIs/BGs/" .. cfg.name .. "/bg", false)
    end
end

function InitSlider()
    local scale = CSAPI.GetScale(iconParent)
    slider_AdjustSlider.value = scale
end

function InitPos()
    CSAPI.SetParent(iconParent, iconPoint2)
    if(cache) then 
        CSAPI.SetAnchor(iconParent, cache.x, cache.y, 0)
        CSAPI.SetScale(iconParent, cache.scale, cache.scale, 1)
    end 
end

-- function ImgShow(b)
--     SetAmplification(b)
--     SetIconParentPos()
-- end

-- 设置放大
function SetAmplification(_show)
    if (showIng and showIng == _show) then
        return
    end
    showIng = _show
    if (_show) then
        local imgScale = 1--cardIconItem.GetCfgScale()
        cardIconItem.SetClickActive(false)
        --CSAPI.SetParent(iconParent, iconPoint2)
        if (not uiHandle) then
            uiHandle = ComUtil.GetCom(handleMask, "UIHandle")
        end
        uiHandle:InitParm(1, 1, g_CardLookScale[1] / imgScale, g_CardLookScale[2] / imgScale) -- 对应的是父类不是role
        uiHandle:Init(iconParent)
        uiHandle:SetSliderCB(SetSliderValue)
    else
        uiHandle:Init(nil)
        --CSAPI.SetParent(iconParent, movePoint)
        cardIconItem.SetClickActive(true)
    end
end

-- -- 设置立绘自定义后的位置
-- function SetIconParentPos(isReset)
--     local r = isReset and {0, 0, 1} or cardIconItem.GetLocalPos()
--     CSAPI.SetAnchor(iconParent, r[1], r[2])
--     CSAPI.SetScale(iconParent, r[3], r[3], 1)
--     SetSliderValue()
-- end

-- g_CardLookScale: 0.4 - 1.3 
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


---返回虚拟键公共接口  函数名一样，调用该页面的关闭接口
function OnClickVirtualkeysClose()
    ---填写退出代码逻辑/接口
    if  OnClickAdjustCancel then
        OnClickAdjustCancel()
    end
end