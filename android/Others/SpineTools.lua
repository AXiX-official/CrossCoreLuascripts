-- spine执行工具，每个spine文件播放时都有一个
--[[
//1、固定
//1.1 必定有idle，idle在0轨道循环播放，不会停止，其余动作都是非0轨道的叠加动作
//1.2 主体播放动作时不能再触发高轨道叠加动作，因为会存在位置不对、音效或文本冲突的问题，但是不限制播放高轨道动作时触发主体动作（该高轨道动作需无语音和文本）
//1.2 （改）播放高轨道动作时可切换到另外的高轨道（主体多段点击）
//1.3 除idle外主体所有动作都用1轨道播放

//2、其余动作分类：单次播放、多段点击、拖拽
//2.1 单次播放：入场、点击
//2.2 多段点击：点破衣服，主体多段
//2.3 拖拽：拉丝袜、拿桶（2段，在拖到一定位置后不能再拖，放手后根据所在位置决定向前播放还是向后播放）

//3、新需求
//3.1 人物拖拽（卡缇娜拖尾巴）
//3.2 多段点击间的过渡改成平滑
//3.3 淡入淡出（入场动画不用，独立物件动作不用，主体的点击和拖拽需要）
//3.4 拖拽动作可不恢复（再次拖拽时在当前位置开始拖动）
//3.5 随机播放（点击同一个点击框，触发特定的几个动作中的其中一个点击动作）
//3.6 开灯关灯效果(开灯关灯各对应一套动作)
//3.7 穿鞋效果
//3.8 主体多段点击（随想曲皮肤新功能）

//4、额外
4.1 动作完成可以立即进入下一动作而不用等待语音完成
]] -- spien动作类型
SpineActionType = {}
SpineActionType.In = 1 -- 入场
SpineActionType.RoleClick = 2 -- 角色点击  {activation,randomActions,isHide}
SpineActionType.RoleActions = 3 -- 角色顺序多动作 {actions}
SpineActionType.RoleGesture = 4 -- 角色手势 {gestureDatas}
SpineActionType.RoleDrag = 5 -- 角色相关物品拖放 {drag}
SpineActionType.ElseClick = 6 -- 非角色点击  {activation,randomActions}
SpineActionType.ElseMulClick = 7 -- 非角色多段点击  {clicks}
SpineActionType.ElseActions = 8 -- 非角色顺序多动作 {actions}
SpineActionType.ElseGesture = 9 -- 非角色手势 {gestureDatas}
SpineActionType.ElseDrag = 10 -- 非角色相关物品拖放 {drag}

SpineTools = {}
local this = SpineTools

this.fadeInTime = 0.2 -- 淡入时间
this.fadeOutTime = 0.5 -- 淡出时间

function this.New()
    this.__index = this.__index or this
    local ins = {}
    setmetatable(ins, this)
    return ins
end

function this:Clear()
    self.anim = nil
end

function this:Init(l2d)
    self.l2d = l2d
    self.l2d:SetComplete(function(trackIndex)
        self:Complete(trackIndex)
    end)
    self.anim = l2d.animationState

    self.teFadeInClickDic = {} -- 淡入
    self.teClickCompleteDic = {} -- 动作回调

    self.mulClickDic = {} -- 物件多段点击-- {[trackIndex]={te =,progress =,},}

    self.dragDic = {}
    self.revoverDragDic = {}

    self.teFadeInBaclClickDic = {} -- 淡入反向

    self.clickRevoverDic = {} -- 拖放

    -- self.actionsDic = {} -- 角色多段 
    self.stopDic = {}
end

function this:Update()
    -- 淡入,逐渐增加动画的权重
    if (self.teFadeInClickDic) then
        for k, v in pairs(self.teFadeInClickDic) do
            if (v ~= nil and v.Animation ~= nil and v.Alpha <= 1) then
                v.Alpha = v.Alpha + Time.deltaTime / self.fadeInTime
                if (v.Alpha >= 1) then
                    self.teFadeInClickDic[k] = nil
                    break
                end
            end
        end
    end

    -- 淡入反向,逐渐降低动画的权重
    if (self.teFadeInBaclClickDic) then
        for k, v in pairs(self.teFadeInBaclClickDic) do
            if (v ~= nil and v.Animation ~= nil and v.Alpha >= 0) then
                v.Alpha = v.Alpha - Time.deltaTime / self.fadeInTime
                if (v.Alpha <= 0) then
                    self.teFadeInBaclClickDic[k] = nil
                    break
                end
            end
        end
    end

    -- 物件多段点击间的过渡
    if (self.mulClickDic) then
        for k, v in pairs(self.mulClickDic) do
            --if (v.te.TimeScale~=0) then --v.te.TrackTime ~= v.progress) then
                -- if (v.te.TimeScale ~= 1 or v.te.TimeScale ~= -1) then
                --     v.te.TimeScale = v.progress > v.te.TrackTime and 1 or -1
                -- end
                if ((v.te.TimeScale == 1 and v.te.TrackTime >= v.progress) or (v.te.TimeScale == -1 and v.te.TrackTime <= v.progress)) then
                    v.te.TimeScale = 0
                    v.te.TrackTime = v.progress
                end
            --end
        end
    end
    -- 拖拽恢复 
    if (self.revoverDragDic) then
        for k, v in pairs(self.revoverDragDic) do
            if (Time.time > v.stay) then
                if (v.te.TimeScale ~= 1 or v.te.TimeScale ~= -1) then
                    v.te.TimeScale = v.forward and 1 or -1
                end
                if (v.te.Animation == nil or v.te.TrackTime >= v.te.Animation.Duration or v.te.TrackTime <= 0) then
                    v.te.TimeScale = 0
                    v.te.TrackTime = 0
                    if (v.complete ~= nil) then
                        v.complete()
                    end
                    -- 主体的话，要移除让其回归idle
                    if (v.te.TrackIndex == 1) then
                        self:ClearTrack(1)
                        self.dragDic[1] = nil
                    end
                    self.revoverDragDic[k] = nil
                    break
                end
            end
        end
    end
    -- 拖放恢复 
    if (self.clickRevoverDic) then
        for k, v in pairs(self.clickRevoverDic) do
            if (Time.time > v.stay) then
                v.te.TimeScale = 0
                v.te.TrackTime = 0
                if (v.complete ~= nil) then
                    v.complete()
                end
                self.clickRevoverDic[k] = nil
                break
            end
        end
    end
    -- -- 多动作恢复
    -- if (self.actionsDic) then
    --     for k, v in pairs(self.actionsDic) do
    --         -- 最后一段
    --         if (v.te.Animation == nil) then
    --             self.actionsDic[k] = nil
    --             self:ClearTrack(1)
    --             break
    --         end
    --         -- 非最后一段
    --         if (v.te.TrackTime >= v.progress) then
    --             if (v.te.TimeScale ~= 0) then
    --                 v.te.TimeScale = 0
    --             end
    --             v.waitTime = v.waitTime - Time.deltaTime
    --             if (v.waitTime <= 0) then
    --                 self.actionsDic[k] = nil
    --                 self:ClearTrack(1)
    --                 -- 主体反向减轻权重
    --                 -- self.teFadeInBaclClickDic[1] = v.te
    --                 break
    --             end
    --         end
    --     end
    -- end
    if (self.stopDic) then
        for k, v in pairs(self.stopDic) do
            if (v.te.Animation == nil) then
                self.stopDic[k] = nil
                break
            end
            if (v.stopPerc and v.te.TrackTime >= v.stopPerc and v.te.TimeScale ~= 0) then
                v.te.TimeScale = 0
                v.stopPerc = nil
            end
            if (v.te.TimeScale == 0) then
                v.timer = v.timer + Time.deltaTime
                if (v.timer > v.stopTime) then
                    v.te.TimeScale = 1
                end
            end
        end
    end
end

-- 轨道播完回调（0轨道已剔除）
function this:Complete(trackIndex)
    if (trackIndex ~= 1) then
        return
    end
    -- self.anim:ClearTrack(trackIndex) -- 移除轨道的Animation动画
    -- self.l2d.sg.Skeleton:SetToSetupPose()
    if (self.teClickCompleteDic[trackIndex] ~= nil) then
        self.teClickCompleteDic[trackIndex]()
    end
    self.teClickCompleteDic[trackIndex] = nil
end

-- 入场
function this:PlayIn(complete)
    return self:PlayByClick("in", 1, false, false, complete)
end

-- 点击
function this:PlayByClick(animName, trackIndex, fadeIn, fadeOut, complete)
    trackIndex = trackIndex or 1
    -- if (self:CheckIsPlaying(trackIndex)) then
    --     return false
    -- end
    if (trackIndex == 1) then
        return self:PlayByClick1(animName, trackIndex, fadeIn, fadeOut, complete)
    else
        return self:PlayByClick2(animName, trackIndex)
    end
end

-- 主体的点击（渐入渐出）
function this:PlayByClick1(animName, trackIndex, fadeIn, fadeOut, complete)
    fadeIn = fadeIn == nil and true or fadeIn
    fadeOut = fadeOut == nil and true or fadeOut
    local te = self.anim:SetAnimation(trackIndex, animName, false)
    te.MixDuration = self.fadeInTime
    te.Alpha = fadeIn and 0 or 1
    te.TrackTime = 0
    te.Loop = false
    te.TimeScale = 1
    self.teClickCompleteDic[trackIndex] = complete
    if (fadeIn) then
        self.teFadeInClickDic[trackIndex] = te
    end
    if (fadeOut) then
        self.anim:AddEmptyAnimation(trackIndex, self.fadeOutTime, 0)
    end
    return true
end

-- 物件的点击（无渐入渐出）
function this:PlayByClick2(animName, trackIndex)
    local te = self.anim:SetAnimation(trackIndex, animName, false)
    te.Loop = false
    te.TrackTime = 0
    te.TimeScale = 1
    return true
end

-- 多段点击（物件）（非1轨道）
function this:PlayByMulClick(animName, trackIndex, timeScale, progress)
    local data = self.mulClickDic[trackIndex]
    if (data == nil) then
        local te = self.anim:SetAnimation(trackIndex, animName, false)
        te.Loop = false
        te.TimeScale = timeScale
        data = {}
        data.te = te
        data.duration = te.Animation.Duration
        data.progress = progress * data.duration
        self.mulClickDic[trackIndex] = data
        return true
    else
        if (data.te.TimeScale == 0) then
            data.progress = progress * data.duration
            data.te.TimeScale = timeScale
            return true
        end
    end
    return false
end
--多段点击是否进行中
function this:CheckMulClickIsPlay(trackIndex)
    local data = self.mulClickDic[trackIndex]
    if (data~=nil and data.te.TimeScale ~= 0) then
        return true
    end
    return false 
end

-- 主体的多段点击（渐入渐出）
function this:PlayByActionsClick(animName, trackIndex, fadeIn, fadeOut, complete, stopPerc, stopTime)
    fadeIn = fadeIn == nil and true or fadeIn
    fadeOut = fadeOut == nil and true or fadeOut
    local te = self.anim:SetAnimation(trackIndex, animName, false)
    te.MixDuration = self.fadeInTime
    te.Alpha = fadeIn and 0 or 1
    te.TrackTime = 0
    te.Loop = false
    te.TimeScale = 1
    self.teClickCompleteDic[trackIndex] = complete
    if (fadeIn) then
        self.teFadeInClickDic[trackIndex] = te
    end
    if (fadeOut) then
        self.anim:AddEmptyAnimation(trackIndex, self.fadeOutTime, 0)
    end
    if (stopTime) then
        local data = {}
        data.te = te
        data.stopPerc = stopPerc * te.Animation.Duration
        data.stopTime = stopTime
        data.timer = 0
        self.stopDic[trackIndex] = data
    end
    return true
end

-- 动作回到某一点后继续执行
function this:ResetActionsClick(trackIndex, stopPerc, stopLimit)
    local data = self.stopDic[trackIndex]
    if (data) then
        local time1 = stopPerc * data.te.Animation.Duration
        local time2 = stopLimit * data.te.Animation.Duration
        if (data.te.TrackTime >= time1 and data.te.TrackTime <= time2) then
            data.te.TrackTime = time1
            data.te.TimeScale = 1
            -- return true 
        end
    end
    -- return false
end

-- -- 多段点击（角色）（1轨道）
-- function this:PlayByActionsClick(animName, trackIndex, timeScale, progress, startProgress, waitTime)
--     local data = self.actionsDic[trackIndex]
--     if (data == nil) then
--         local te = self.anim:SetAnimation(trackIndex, animName, false)
--         te.Loop = false
--         te.TimeScale = timeScale
--         data = {}
--         data.te = te
--         data.duration = te.Animation.Duration
--         data.progress = progress * data.duration
--         data.waitTime = waitTime
--         self.actionsDic[trackIndex] = data
--         if (true) then
--             self.anim:AddEmptyAnimation(trackIndex, self.fadeOutTime, 0)
--         end
--     else
--         data.te.TrackTime = startProgress * data.duration
--         data.waitTime = waitTime
--         data.progress = progress * data.duration
--         data.te.TimeScale = timeScale
--     end
--     return true
-- end
-- -- 是否正在反向恢复，是否暂停中
-- function this:CheckActionsCanClick(trackIndex)
--     local isPlay = false
--     local data = self.actionsDic[trackIndex]
--     if (data and data.te.TimeScale ~= 0) then
--         isPlay = true
--     end
--     return self.teFadeInBaclClickDic[trackIndex] ~= nil, isPlay
-- end

-- 拖拽
function this:PlayByDrag(animName, trackIndex, gesture, x, y, limit, speed)
    if (self.revoverDragDic[animName]) then
        return -- 恢复中
    end
    if (trackIndex == 1 and self:CheckIsPlaying(trackIndex)) then
        return -- 主体正在播放
    end
    limit = limit ~= nil and limit or 1
    speed = speed ~= nil and speed or 0.002
    local te = self.dragDic[trackIndex]
    if (te == nil or te.Animation == nil) then
        te = self.anim:SetAnimation(trackIndex, animName, false)
        te.MixDuration = self.fadeInTime
        te.TrackTime = 0
        te.Loop = false
        te.TimeScale = 0
        te.Alpha = 1
        self.dragDic[trackIndex] = te
    end
    local num = 0
    if (gesture <= 2) then
        num = gesture == 1 and -x or x
    else
        num = gesture == 3 and y or -y
    end
    local cur = te.TrackTime / te.Animation.Duration
    cur = cur + num * speed
    cur = cur < 0 and 0 or cur
    cur = cur > limit and limit or cur
    te.TrackTime = cur * te.Animation.Duration
end

-- 拖拽恢复 
function this:Recover(animName, trackIndex, stay, forward, complete)
    if (self.revoverDragDic[animName]) then
        return -- 恢复中
    end
    local _data = {}
    _data.te = self.dragDic[trackIndex]
    _data.stay = Time.time + stay
    _data.forward = forward
    _data.complete = complete
    if (trackIndex == 1) then
        self.anim:AddEmptyAnimation(trackIndex, self.fadeOutTime, 0) -- 主体添加淡出（即平滑回归idle）
    end
    self.revoverDragDic[animName] = _data

    -- 主体反向减轻权重
    if (trackIndex == 1 and not _data.forward) then
        self.teFadeInBaclClickDic[trackIndex] = _data.te
    end
end

-- 休闲中
function this:IsIdle()
    return not self:CheckIsPlaying(1)
end

-- 某轨道是否在播放中(必定是在播放中)
function this:CheckIsPlaying(trackIndex)
    local te = self.anim:GetCurrent(trackIndex)
    if (te ~= nil and te.Animation ~= nil and (te.TimeScale == 1 or te.TimeScale == -1)) then
        return true
    end
    return false
end

-- 某轨道是否实装中（可能暂停、可能播放）
function this:CheckIsExist(trackIndex)
    local te = self.anim:GetCurrent(trackIndex or 1)
    if (te ~= nil and te.Animation ~= nil) then
        return true
    end
    return false
end

-- 是否存在该角色
function this:CheckAnimExist(animName)
    if (self.anim) then
        local anim = self.anim.Data.SkeletonData:FindAnimation(animName)
        return anim ~= nil
    end
    return false
end

-- 立即完成某轨道
function this:SetTrackEntryComplte(trackIndex)
    local te = self.anim:GetCurrent(trackIndex)
    if (te) then
        te.TrackTime = te.Animation.Duration
    end
end

-- 播放进度
function this:GetTrackTimePercent(trackIndex)
    local te = self.anim:GetCurrent(trackIndex)
    if (te) then
        return te.TrackTime / te.Animation.Duration
    end
    return 1
end

function this:ClearTrack(trackIndex)
    self.anim:ClearTrack(1)
    self.l2d.sg.Skeleton:SetToSetupPose()
end

-- 拖放还原
function this:ClickRecover(animName, trackIndex, stay, complete)
    if (self.clickRevoverDic[animName]) then
        return -- 恢复中
    end
    local _data = {}
    _data.te = self.anim:GetCurrent(trackIndex)
    _data.stay = Time.time + stay
    _data.complete = complete
    self.clickRevoverDic[animName] = _data
end
function this:CheckIsClickRecover(animName)
    if (self.clickRevoverDic[animName]) then
        return true
    end
    return false
end

-- 某轨道正在播放的动画名称
function this:GetNameByTrackIndex(trackIndex)
    local te = self.anim:GetCurrent(trackIndex)
    if (te ~= nil and te.Animation ~= nil) then
        return te.Animation.Name
    end
    return nil
end

return this
