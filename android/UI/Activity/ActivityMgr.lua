-- 活动管理
local ActivityInfo = require "ActivityInfo"
local this = MgrRegister("ActivityMgr")

--function this:Init()
    --     self.listDatas = {}
    --     self.listView = nil
    --     self.nextViewTypes = {}
    --     self.savePanel = {}
    --     self.isFirst = false
    --     -- self.redInfos = self:GetRedInfo()
--end

function this:GetBaseUrl()
    return self.url .. "/php"
end

-- 基础下载地址
function this:GetBaseDownAddress()
    local curServer = GetCurrentServer()
    return self.url .. "/php/res/" .. curServer.resDir .. "/"
    -- return "https://cdn.megagamelog.com/cross/release/web/";--改CDN
end

-- 活动、广告文件下载地址
function this:GetActivityDownAddress(type)
    -- local curServer = GetCurrentServer()
    local currPlatform = CSAPI.GetPlatform()
    local str1 = "pc"
    if(currPlatform == 8) then 
        str1 = "ios"
    elseif(currPlatform == 11) then 
        str1 = "android"
    end 
    local str2 = "text"
    if (CSAPI.GetChannelType() == ChannelType.BliBli) then
        str2 = "bilibili"
    elseif (CSAPI.GetChannelType() == ChannelType.Normal or CSAPI.GetChannelType() == ChannelType.TapTap) then
        str2 = "official"
    elseif (CSAPI.GetChannelType() == ChannelType.QOO) then
        str2 = "qoo"
    elseif (CSAPI.GetChannelType() == ChannelType.ZiLong) then
        str2 = "zilong"
    end
    local fileName = ""
    if (type == BackstageFlushType.Board) then
        fileName = string.format("boardNotice/%s/%s/boardNotice", str1, str2)
    else
        fileName = "activitySkip" -- string.format("activitySkip/%s/%s/activitySkip", str1, str2)
    end
    return self:GetBaseDownAddress() .. fileName
end

-- 宿舍图片下载地址
function this:GetDormDownAddress()
    return self:GetBaseDownAddress() .. "dorm/"
end

-- 宿舍图片上传地址
function this:GetDormUploadAddress()
    -- local curServer = GetCurrentServer()
    return self.url .. "/php/OpFile.php"
end

function this:Clear()
    -- self.isOpen = false
    self.datas = {}
    self.listDatas = {}
    self.listView = nil
    self.nextViewTypes = {}
    self.savePanel = {}
    self.isFirst = nil
    -- self.redInfos = nil
    self.operateList = {}
end

function this:Init1(webIp, webPort, time)
    self:Clear()
    self.url = string.format("%s", webIp)
    self.isIn = 0
    self.datas = {}
    -- for i, v in pairs(BackstageFlushType) do
    --     self:InitData(v)
    -- end
    self:InitData(BackstageFlushType.Board, time)
    self:InitData(BackstageFlushType.ActiveSkip, time)
end

function this:InitData(type, time)
    if (type ~= nil) then
        local _url = self:GetActivityDownAddress(type)
        local url = _url .. ".json"
        self:RequestData(type, url, time)
    end
end

-- 请求数据
function this:RequestData(key, url, time)
    self.datas[key] = {}
    CSAPI.GetServerInfo(url, function(str)
        if str then
            local count = 0
            local json = Json.decode(str)
            if (json) then
                if (key == BackstageFlushType.Board) then
                    for i, v in ipairs(json.arr) do
                        if (type(v) == "table") then
                            if (tonumber(v["id"]) ~= 0) then
                                local activityInfo = ActivityInfo.New()
                                activityInfo:InitData(v, key)
                                if (activityInfo:CheckIsInTime(time)) then
                                    table.insert(self.datas[key], activityInfo)
                                    count = count + 1
                                end
                            end
                        end
                    end
                else
                    for i, v in pairs(json) do
                        if (type(v) == "table") then
                            if (tonumber(json[i]["id"]) ~= 0) then
                                local activityInfo = ActivityInfo.New()
                                activityInfo:InitData(json[i], key)
                                if (activityInfo:CheckIsInTime(time)) then
                                    -- 玩家已完成则会隐藏
                                    -- if(json[i]["panel_id"] and self:CheckIsOpen(tonumber(json[i]["panel_id"]))) then 
                                    table.insert(self.datas[key], activityInfo)
                                    -- end 
                                end
                            end
                        end
                    end
                    self:CheckOpenDatas()
                end
                if (key == BackstageFlushType.Board) then
                    if (self.isIn == 0) then
                        -- 第1次获取到数据
                        -- self.isIn = 1
                        self.isIn = count > 0 and 2 or 1 -- 2 需要弹出面板
                    else
                        -- 第x+1次获取到数据
                        -- if(self.isIn == 1) then
                        self.isIn = count > 0 and 3 or 1 -- 3 需要强制弹出面板
                        -- end
                    end
                end
                EventMgr.Dispatch(EventType.Main_Activity, key)
            end
        end
    end)
end

-- 获取活动数据(活动时间内有效的数据)
function this:GetDatasByType(type, time, page)
    type = type == nil and BackstageFlushType.Board or type
    local datas = self.datas and self.datas[type] or nil
    if (datas) then
        local curDatas = {}
        local nextTime = nil
        local curTime = time or TimeUtil:GetTime()
        for i, v in ipairs(datas) do
            local beginTime = v:GetBeginTime()
            local endTime = v:GetEndTime()
            if (beginTime == nil or curTime > beginTime) then
                if (endTime == nil or endTime > curTime) then
                    if (endTime and (nextTime == nil or nextTime > endTime)) then
                        nextTime = endTime
                    end
                    if (page == nil or (page == v:GetPage())) then
                        table.insert(curDatas, v)
                    end
                end
            end
        end
        if (curDatas and #curDatas > 1) then
            table.sort(curDatas, function(a, b)
                return tonumber(a:GetSortID()) > tonumber(b:GetSortID())
            end)
        end
        return curDatas, nextTime
    else
        return nil, nil
    end
end

-- 弹出活动公告
function this:ToShowAD()
    if (self:CheckIsNeedShow()) then
        self.isIn = 1
        return true
    end
    return false
end

-- 需要弹出活动公告
function this:CheckIsNeedShow()
    if (self.isIn == 3 or (not self:IsSetToSkip() and self.isIn == 2)) then
        return true
    end
    return false
end

-- 当天是否已设置跳过
function this:IsSetToSkip()
    local day = TimeUtil:GetTime3("day")
    local dayRecord = PlayerPrefs.GetString(PlayerClient:GetUid() .. "ActivityTips_Day", "0")
    if (dayRecord ~= "0" and dayRecord == tostring(day)) then
        return true
    end
    return false
end

----------------------------------------活动列表---------------------------------------
function this:RefreshOpenState()
    self.isFirst = false
    self:InitListOpenState()
end

function this:InitListOpenState()
    if self.isFirst then -- 只执行一次
        return
    end
    self.isFirst = true

    local cfgs = Cfgs.CfgActiveList:GetAll()
    self.activityListDatas = {}
    if cfgs then
        for i, v in pairs(cfgs) do
            self.activityListDatas[v.id] = {
                cfg = v
            }
            local isOpen = true

            if v.id == ActivityListType.SignInContinue then
                isOpen = false
                if (SignInMgr:SignInIsOpen()) then
                    local signData = SignInMgr:GetSignInContinueData()
                    if signData and (not signData:CheckIsDone() or signData:GetRealDay() < 7) then
                        isOpen = true
                    end
                end
            elseif v.id == ActivityListType.MissionContinue then
                local info = v.info
                if info and info[1] and info[1].taskType and info[1].taskType == 2 then
                    isOpen = not MissionMgr:IsAllGuideMissionGet()
                else
                    isOpen = not MissionMgr:IsAllSevenMissionGet()
                end
            elseif v.id == ActivityListType.Investment then
                local targetTime = PlayerMgr:GetOpenTime(ActivityListType.Investment) + (g_InvestmentTimes * 86400)
                isOpen = targetTime > TimeUtil:GetTime()
            end

            if v.type == ALType.Pay then
                isOpen = false
            end

            if isOpen and v.sTime and v.eTime then -- 时间限制
                local curTime = TimeUtil:GetTime()
                local sTime = TimeUtil:GetTimeStampBySplit(v.sTime)
                local eTime = TimeUtil:GetTimeStampBySplit(v.eTime)
                isOpen = curTime > sTime and curTime <= eTime
            end

            self.activityListDatas[v.id].isOpen = isOpen
        end
    end

    self:CheckOpenDatas()
    self:CheakPopInfos()
end

function this:CheckOpenDatas()
    if (self.isFirst and self.datas) then
        local datas = self.datas[BackstageFlushType.ActiveSkip]
        if (datas) then
            local len = #datas
            for i = len, 1, -1 do
                if (datas[i]:PanelId() and not self:CheckIsOpen(tonumber(datas[i]:PanelId()))) then
                    table.remove(datas, i)
                end
            end
        end
    end
    EventMgr.Dispatch(EventType.Main_Activity, BackstageFlushType.ActiveSkip)
end

function this:CheakPopInfos()
    self.popInfos = FileUtil.LoadByPath("Activity_Pop_Infos.txt") or {}
end

function this:GetALData(aType)
    return self.activityListDatas[aType]
end

function this:GetArr(group)
    local datas = {}
    if self.activityListDatas then
        for i, v in pairs(self.activityListDatas) do
            if v.isOpen then
                if not group or (group and group == v.cfg.group) then
                    table.insert(datas, v.cfg)
                end
            end
        end

        table.sort(datas, function(a, b)
            return a.index < b.index
        end)
    end
    return datas
end

-- 活动开启
function this:CheckIsOpen(_type)
    if self.activityListDatas and self.activityListDatas[_type] then
        return self.activityListDatas[_type].isOpen
    end
    return false
end


-- 检测红点
function this:CheckRedPointData(type)
    if type then
        local cfg = Cfgs.CfgActiveList:GetByID(type)
        if cfg and cfg.group then
            local redData = RedPointMgr:GetData(RedPointType["ActivityList" .. cfg.group])
            local isRed1 = redData ~= nil
            local isRed2 = self:CheckRed(type)
            if isRed1 ~= isRed2 then
                redData = isRed2 and 1 or nil
                RedPointMgr:UpdateData(RedPointType["ActivityList" .. cfg.group], redData) 
            end
            return
        end
    end
    local redData1 = RedPointMgr:GetData(RedPointType.ActivityList1)
    local redData2 = RedPointMgr:GetData(RedPointType.ActivityList2)
    local redData3 = RedPointMgr:GetData(RedPointType.ActivityList3)
    local isRed1 = redData1 ~= nil
    local isRed2 = redData2 ~= nil
    local isRed3 = redData3 ~= nil
    if ActivityListType then
        for k, v in pairs(ActivityListType) do
            local cfg = Cfgs.CfgActiveList:GetByID(v)
            if cfg then
                if cfg.group then
                    if self:CheckRed(v) then
                        if cfg.group == 2 and redData2 == nil then
                            redData2 = 1
                        elseif cfg.group == 3 and redData3 == nil then
                            redData3 = 1
                        elseif cfg.group == 1 and redData1 == nil then
                            redData1 = 1
                        end
                    end
                end
            end
        end
    end
    if isRed1 ~= (redData1 ~= nil) then
        RedPointMgr:UpdateData(RedPointType.ActivityList1, redData1)
    end
    if isRed2 ~= (redData2 ~= nil) then
        RedPointMgr:UpdateData(RedPointType.ActivityList2, redData2)
    end
    if isRed3 ~= (redData3 ~= nil) then
        RedPointMgr:UpdateData(RedPointType.ActivityList3, redData3)
    end
end

-- type:ActivityListType
function this:CheckRed(type)
    if not self.activityListDatas or not self.activityListDatas[type] or (not self.activityListDatas[type].isOpen) then
        return false
    end
    if type == ActivityListType.MissionContinue then
        return MissionMgr:CheckGuideRed()
    elseif type == ActivityListType.NewYearContinue then
        return MissionMgr:CheckNewYearRed()
    elseif type == ActivityListType.SignIn or self:IsSignInContinue(type) then
        local signData = SignInMgr:GetDataByALType(type)
        if signData and not signData:CheckIsDone() then
            return true
        end
        return false
    elseif type == ActivityListType.Investment then
        local pageData = ShopMgr:GetPageByID(1001)
        if pageData == nil then
            LogError("找不到对应商店页的商品数据！1001")
            return false
        end

        local comms = pageData:GetCommodityInfos(true)
        if comms and #comms < 1 then
            return false
        end

        local commodity = comms[1]
        if commodity:GetPrice() and #commodity:GetPrice() > 0 then
            local costCount = commodity:GetPrice()[1].num
            return BagMgr:GetCount(ITEM_ID.DIAMOND) >= costCount
        end
        return false
    elseif type == ActivityListType.Exchange then
        local cfg = Cfgs.CfgActiveList:GetByID(ActivityListType.Exchange)
        if cfg and cfg.info and cfg.info[1] and cfg.info[1].shopId then
            local page = ShopMgr:GetPageByID(cfg.info[1].shopId)
            if page then
                local datas = page:GetCommodityInfos(true)
                if datas and #datas > 0 then
                    local infos = FileUtil.LoadByPath("Activity_ExChange_Tip") or {}
                    for i, v in ipairs(datas) do
                        if infos[v:GetID()] and infos[v:GetID()] == 1 and v:GetNum() > 0 and ShopCommFunc.CheckCanPay(v,1) then
                            return true
                        end
                    end
                end
            end
        end
        return false
    elseif type == ActivityListType.AccuCharge then
        local num = RedPointMgr:GetData(RedPointType.AccuCharge)
        if(num and num==1) then 
            return true
        end 
        return false          
    else
        local isRed = PlayerPrefs.GetInt(PlayerClient:GetUid() .."_Activity_Red_" .. type) == 0
        return isRed
    end
end

-- 活动内容为空
function this:IsActivityListNull(viewName, group)
    local isOpen = MenuMgr:CheckModelOpen(OpenViewType.main, viewName)
    if isOpen and self.activityListDatas then
        for i, v in pairs(self.activityListDatas) do
            if v.cfg and v.cfg.group == group and v.isOpen then
                return false
            end
        end
    end
    return true
end

function this:IsSignInContinue(type)
    local cfg = Cfgs.CfgActiveList:GetByID(type)
    if cfg and cfg.type == ALType.SignInContinue then
        return true
    elseif type == ActivityListType.SignInGift then
        return true
    end
    return false
end

function this:SetOperateActive(aType,info)
    if self.activityListDatas[aType] then
        if aType ==ActivityListType.SignInGift and info.payRate then
            if info.openTime <= TimeUtil:GetTime() and info.closeTime > TimeUtil:GetTime() then
                self.activityListDatas[aType].isOpen = true
                self.activityListDatas[aType].sTime = info.openTime
                self.activityListDatas[aType].eTime = info.closeTime
            end
        end
    end
end

----------------------------------------界面弹出---------------------------------------
function this:CheckPopView()
    if SignInMgr:CheckAll() then
        CSAPI.OpenView("ActivityListView")
        return true
    end
    return false
end

-- 获取活动列表数据
function this:TryGetData(_type)
    self.listDatas = self.listDatas or {}
    if (self.listDatas[_type] == nil) then
        if (_type == ActivityListType.SignIn) then -- 每日签到
            local _key = SignInMgr:GetDataKeyByType(RewardActivityType.DateDay)
            self.listDatas[_type] = {
                key = _key
            }
        elseif self:IsSignInContinue(_type) then -- 连续签到
            local keys = SignInMgr:GetDataKeysByType(RewardActivityType.Continuous)
            self.listDatas[_type] = {
                key = keys[_type]
            }
        end
    end
    return self.listDatas[_type]
end

function this:SetListData(_type, _data)
    self.listDatas = self.listDatas or {}
    self.listDatas[_type] = _data
end

-- 添加下一个将要打开的界面
function this:AddNextOpen(_type, _data)
    if not self:PanelCanJump(_type) then
        return false
    end
    self.popInfos[_type] = self.popInfos[_type] or {}
    self.popInfos[_type].recordTime = TimeUtil:GetTime()
    self:AddNextOpen2(_type, _data)
    return true
end

-- 不记录界面信息的添加
function this:AddNextOpen2(_type, _data)
    if (tonumber(_type) > 0) then
        if (_data) then
            self:SetListData(_type, _data)
        end
        table.insert(self.nextViewTypes, _type)
    end
end

-- 获取弹出id
function this:TryGetNextType(_group)
    if self.nextViewTypes and #self.nextViewTypes > 0 then
        for i, v in ipairs(self.nextViewTypes) do
            local _data = self.activityListDatas[v]
            if _data and _data.cfg and _data.cfg.group == tonumber(_group) then
                return table.remove(self.nextViewTypes, i)
            end
        end
    end
    return nil
end

-- 获取界面可否弹出
function this:PanelCanJump(_type)
    if not self.popInfos[_type] or not self.popInfos[_type].recordTime or self.popInfos[_type].recordTime <= 0 then
        return true
    end
    local tab1 = TimeUtil:GetTimeHMS(self.popInfos[_type].recordTime)
    local tab2 = TimeUtil.GetTimeHMS(TimeUtil:GetTime())
    if tab2.day - tab1.day > 1 then --超过一天
        return true
    elseif tab2.day - tab1.day > 0 then --在前后一天
        if tab1.hour < g_ActivityDiffDayTime then --前一次记录在每日刷新前
            return true
        elseif tab2.hour >= g_ActivityDiffDayTime then --当前在每日刷新后
            return true
        end
    elseif tab1.hour < g_ActivityDiffDayTime and tab2.hour >= g_ActivityDiffDayTime then --在同一天但在每日刷新前后
        return true
    end
    return false
end


return this
