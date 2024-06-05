-- 副本管理
-- DungeonMgr = {};
-- local this = DungeonMgr;
DungeonMgr = MgrRegister("DungeonMgr")
local this = DungeonMgr;

-- 副本标志类型
DungeonFlagType = {
    Story = 1 -- 剧情关卡
}

-- 章节类型
SectionType = {
    -- 主线
    MainLine = 1,
    -- 每日
    Daily = 2,
    -- 活动
    Activity = 3,
    -- 教程
    Course = 4
};

--章节活动类型
SectionActivityType = {
    Tower = 101,
    BattleField = 102,
    Plot = 103,
    TaoFa = 104,
    NewTower = 105, -- 新爬塔
    Trials = 106 --试炼
}

--章节活动开启类型
SectionActivityOpenType = {
    BattleField = 1,
    Plot = 2,
    TaoFa = 3
}

-- 打开副本时状态
DungeonOpenType = {
    Normal = 1, -- 正常
    Finish = 2, -- 完成关卡
    Retreat = 3, -- 撤退
    Jump = 4 -- 跳转
}

-- 设置数据
function this:Set(proto)
    if (proto == nil) then
        return;
    end
    self.dungeonDatas = self.dungeonDatas or {};
    if (proto.mainLine) then
        for _, mainLineData in ipairs(proto.mainLine) do
            self:AddDungeonData(mainLineData);
        end
    end

    if (proto.is_finish) then
        EventMgr.Dispatch(EventType.Dungeon_Data_Setted) -- 副本数据设置完成
        self:CheckRedPointData()
    end
end

-- 设置每日副本数据
function this:SetDailyData(proto)
    self.dailyData = proto;
end

-- 更新每日副本次数
function this:UpdateDailyData(proto)
    self.dailyData = self.dailyData or {};
    if (proto) then
        for k, v in pairs(proto) do
            self.dailyData[k] = v;
        end
        EventMgr.Dispatch(EventType.Dungeon_DailyData_Update)
    end
end

-- 判断是否开启时间内，副本刷新时间为g_ActivityDiffDayTime
function this:IsDailyOpenTime(openTime)
    local isTime = false;
    local isNextDayOpen = false --下一天是否开启
    if openTime then
        local weekIndex = CSAPI.GetWeekIndex();
        local hmsTime = TimeUtil:GetTimeHMS(CSAPI.GetServerTime())
        if hmsTime.hour < g_ActivityDiffDayTime then -- 没到刷新时间开启前一天的副本
            weekIndex = weekIndex - 1 <= 0 and 7 or weekIndex - 1;
        end
        isTime = openTime[weekIndex] == 1;

        local nextWeekIndex= weekIndex + 1 > 7 and 1 or (weekIndex + 1)
        isNextDayOpen = openTime[nextWeekIndex] == 1
    end
    return isTime,isNextDayOpen;
end

-- 设置多倍掉落开关
function this:SetMultiReward(b)
    self.isMultiReward = b
end

-- 更新副本中的多倍掉落使用信息
function this:UpdateSectionMultiInfo(proto)
    self.multiInfo = self.multiInfo or {};
    if proto then
        for k, v in ipairs(proto) do
            self.multiInfo[v.id] = v.cnt;
            self.multiUpdateTime = v.pt
        end
    end
    EventMgr.Dispatch(EventType.Dungeon_DailyData_Update)
end

-- 返回副本中的多倍掉落信息
function this:GetSectionMultiNum(_id)
    local num = 0;
    local id = self.sectionDatas[_id] and self.sectionDatas[_id]:GetMultiID() or 0
    if self.multiInfo and self.multiInfo[id] then
        num = self.multiInfo[id]
    end
    return num;
end

function this:GetMultiUpdateTime()
    return self.multiUpdateTime
end

--获取日常变量
function this:GetDailyData()
    return self.dailyData
end

-- 获取副本类型
function this:GetDungeonSectionType(id)
    local cfgDungeon = Cfgs.MainLine:GetByID(id);
    if (cfgDungeon) then
        local sectionData = self:GetSectionData(cfgDungeon.group);
        return sectionData:GetSectionType();
    end
    return nil;
end

-- 返回当前开启的最后一个章节
function this:GetLastMainLineSection()
    local allSectionDatas = DungeonMgr:GetAllSectionDatas();
    local currSection = nil;
    local currIndex = 0;
    if allSectionDatas then
        for id, sectionData in pairs(allSectionDatas) do
            local state = sectionData:GetState();
            if (state == 1 or state == 2) and sectionData:GetSectionType() == SectionType.MainLine and
                sectionData:GetIndex() > currIndex then
                currSection = sectionData;
            end
        end
    end
    return currSection;
end

-- 添加副本数据
function this:AddDungeonData(data)
    local dungeonData = DungeonData.New();
    if data and data.star and data.star > 0 then
        data.isPass = true;
    else
        data.isPass = false;
    end
    dungeonData:SetData(data);
    self.dungeonDatas[data.id] = dungeonData;
    self.maxDungeonID = self.maxDungeonID or 0
    if data.id and data.id > self.maxDungeonID then
        local cfg = Cfgs.MainLine:GetByID(data.id)
        if cfg and cfg.type == eDuplicateType.MainNormal then
            self.maxDungeonID = data.id
        end
    end
end

function this:GetMaxDungeonID()
    return self.maxDungeonID or 0
end

-- 初始化章节
function this:InitSectionDatas()
    self.sectionDatas = {};
    -- 初始化主线章节
    local cfgs = Cfgs.Section:GetAll();
    for _, cfg in pairs(cfgs) do
        local sectionData = SectionData.New();
        sectionData:Init(cfg);
        self.sectionDatas[cfg.id] = sectionData;
    end
end

-- 获取章节数据
function this:GetSectionData(id)
    return self.sectionDatas and self.sectionDatas[id];
end
-- 获取全部章节数据
function this:GetAllSectionDatas()
    return self.sectionDatas;
end
-- 获取指定章节数据 sectionType
function this:GetScetionDatas(_group)
    if (self.sectionDatas) then
        local _datas = {}
        for i, v in pairs(self.sectionDatas) do
            if (v:GetGroup() == _group) then
                table.insert(_datas,v)
            end
        end
        if #_datas>0 then
            table.sort(_datas,function (a,b)
                return a:GetID() < b:GetID()
            end)
        end
        return _datas
    end
end

-- 获取指定章节数据 --SectionActivityType
function this:GetActivitySectionDatas(_type, isOpen)
    if (self.sectionDatas) then
        local _datas = {}
        for i, v in pairs(self.sectionDatas) do
            if (v:GetType() == _type and (not isOpen or v:GetOpen())) then
                table.insert(_datas,v)
            end
        end
        if #_datas>0 then
            table.sort(_datas,function (a,b)
                return a:GetID() < b:GetID()
            end)
        end
        return _datas
    end
end

-- 获取当前章节
function this:GetCurrSectionData()
    local allSectionDatas = DungeonMgr:GetAllSectionDatas();
    local currSection = nil;
    local currSectionID = nil;
    if self.currId then
        local cfg = Cfgs.MainLine:GetByID(self.currId);
        if self.isFirst and cfg.lasChapterID ~= nil then -- 第一次通关且有下一章ID
            local nextCfg = Cfgs.MainLine:GetByID(cfg.lasChapterID[1]);
            currSectionID = nextCfg.group;
        else
            currSectionID = cfg.group;
        end
    end
    if allSectionDatas then
        for id, sectionData in pairs(allSectionDatas) do
            if sectionData:GetSectionType() == SectionType.MainLine then
                local state = sectionData:GetState();
                if (state == 1 or state == 2) and sectionData:GetID() == currSectionID and sectionData:GetSectionType() ==
                    SectionType.MainLine then
                    currSection = sectionData;
                    break
                end
            else
                if sectionData:GetID() == currSectionID then
                    currSection = sectionData;
                    break
                end
            end
            
            -- if(state == 1) then --开启的
            -- 	currSection = sectionData;
            -- 	break;
            -- elseif(state == 2) then --完成的
            -- 	if(currSection == nil or(sectionData:GetID() == currSectionID and sectionData:GetSectionType() == SectionType.MainLine)) then
            -- 		currSection = sectionData;
            -- 		break;
            -- 	end
            -- end
        end
    end

    return currSection;
end

-- 获取指定类型的最后开启关卡 _type:eDuplicateType
function this:GetLastOpenDungeon(_type)
    local dungeonCfg = nil;
	local cfgs = Cfgs.MainLine:GetAll();
	if(cfgs) then
		for _, tmpCfg in pairs(cfgs) do
            if tmpCfg.type == _type then
                if (dungeonCfg == nil) or (dungeonCfg and dungeonCfg.id < tmpCfg.id) then
                    local dungeonData = DungeonMgr:GetDungeonData(tmpCfg.id);
                    if(dungeonData ~= nil and dungeonData:IsOpen() == true) then
                        if dungeonData:IsPass() and tmpCfg.lasChapterID then
                            dungeonCfg = Cfgs.MainLine:GetByID(tmpCfg.lasChapterID[1]);
                        else
                            dungeonCfg = tmpCfg
                        end
                    elseif tmpCfg.preChapterID then
                        local preData = DungeonMgr:GetDungeonData(tmpCfg.preChapterID[1]);
                        if preData ~= nil and preData:IsPass() == true then
                            dungeonCfg = tmpCfg;
                        end
                    end
                end
            end
		end
	end
	return dungeonCfg;
end

--主线进度
function this:GetMainLineOpenDungeon()
    local mainLineCfg = self:GetLastOpenDungeon(eDuplicateType.MainNormal)
    local teachCfg = self:GetLastOpenDungeon(eDuplicateType.Teaching)
    if mainLineCfg and teachCfg then --判断教程关和主线哪个是最新
        if teachCfg.preChapterID and teachCfg.preChapterID[1] >= mainLineCfg.id then
            return teachCfg
        end
    end
    return mainLineCfg
end

-- 获取副本数据
function this:GetDungeonData(id)
    return self.dungeonDatas and self.dungeonDatas[id];
end
-- 关卡是否已通关
function this:CheckDungeonPass(id)
    --    LogError("id" .. id);
    --    LogError(_data);
    local _data = self:GetDungeonData(id)
    return _data and _data:IsPass() or false
end

-- 章节是否开启
function this:CheckSectionOpen(id)
    local sectionData = self:GetSectionData(id);
    return sectionData and sectionData:GetType() or false;
end

-- 获取全部副本数据
function this:GetAlDungeonDatas()
    return self.dungeonDatas;
end

-- 更新副本条件数据
function this:UpdateDupGrade(id, star, nDupGrade)
    if self.dungeonDatas[id] then
        self.dungeonDatas[id].data.star = star;
        self.dungeonDatas[id].data.data = nDupGrade;
    elseif star and nDupGrade then
        self:AddDungeonData({
            id = id,
            star = star,
            data = nDupGrade
        });
    end

    -- EventMgr.Dispatch(EventType.Update_Dungeon_Data)
end

-- 副本是否开启
function this:IsDungeonOpen(id)
    if (id == nil) then
        LogError("检测副本开启状态失败！id无效");
    end

    --	local dungeonData = self:GetDungeonData(id);
    --	if(dungeonData and dungeonData:GetStar() > 0) then
    --		--存在副本数据，表示已经通关，自然就是开启了的
    --		return true;
    --	end
    local cfgDungeon = Cfgs.MainLine:GetByID(id);
    if (cfgDungeon) then
        if (cfgDungeon.LockLevel and PlayerClient:GetLv() < cfgDungeon.LockLevel) then
            -- 等级不满足
            local str = LanguageMgr:GetByID(15048, cfgDungeon.LockLevel)
            return false, str;
        end
        if cfgDungeon.LockMission then
            local finishNum = 0
            local str = ""
            for i, v in ipairs(cfgDungeon.LockMission) do
                if v[1] == eTaskType.GuideStage and v[2] < MissionMgr:GetGuideIndex() then
                    finishNum = finishNum + 1
                    str = str .. " " ..LanguageMgr:GetByID(15107, v[2] + 1, cfgDungeon.chapterID .. " " .. cfgDungeon.name)
                end
            end
            if finishNum < #cfgDungeon.LockMission then
                return false, str
            end
        end
        if (cfgDungeon.preChapterID == nil) then
            -- 无前置关卡
            return true;
        else
            for _, preChapterId in ipairs(cfgDungeon.preChapterID) do
                local preDungeonData = self:GetDungeonData(preChapterId);
                if (preDungeonData == nil or preDungeonData:IsPass() == false) then
                    local dungeonName = "";
                    local cfg2 = Cfgs.MainLine:GetByID(preChapterId);
                    if not cfg2 then
                        LogError("当前关卡id："..id.."，前置节点id中："..preChapterId .."找不到对应关卡表数据！")
                    else
                        local sectionType = self:GetDungeonSectionType(preChapterId)
                        if sectionType == SectionType.MainLine then
                            local exStr = cfg2.type == 2 and string.format("(%s)", LanguageMgr:GetByID(15016)) or ""
                            dungeonName = cfg2.chapterID .. " " .. cfg2.name .. exStr;
                        elseif cfg2.diff then
                            dungeonName = cfg2.diff == 2 and LanguageMgr:GetByID(15016) .. "-" .. cfg2.name or cfg2.name
                        else
                            dungeonName = cfg2.name;
                        end
                    end
                    local str = LanguageMgr:GetTips(1010, dungeonName)
                    return false, str;
                end
            end
        end
    else
        LogError("找不到副本配置" .. id);
        return false;
    end

    return true;
end

--初始化关卡组
function this:InitDungeonGroupDatas()
    local cfgs = Cfgs.DungeonGroup:GetAll()
    if cfgs then
        self.dungeonGroupDatas = self.dungeonGroupDatas or {}
        for _, cfg in pairs(cfgs) do           
            local data = DungeonGroupData.New()
            data:Init(cfg)
            self.dungeonGroupDatas[cfg.id] = data
        end
    end
end

--获取关卡祖
function this:GetDungeonGroupData(id)
    return self.dungeonGroupDatas and self.dungeonGroupDatas[id]
end

--获取同一章节的关卡祖
function this:GetDungeonGroupDatas(group, ishard)
    local datas = {}
    if self.dungeonGroupDatas then
        for _, data in pairs(self.dungeonGroupDatas) do
            if data:GetGroup() == group then
                data:SetHard(ishard)
                table.insert(datas,data)
            end
        end
    end
    if #datas > 0 then
        table.sort(datas,function (a,b)
            return a:GetID() < b:GetID()
        end)
    end
    return datas
end

-- 获取指定id的关卡组信息
function this:GetDungeonGroupCfg(gid)
    if self.dungeonGroupCfgs and #self.dungeonGroupCfgs > 0 then
        for k, v in ipairs(self.dungeonGroupCfgs) do
            if v.id == gid then
                return v
            end
        end
    end
end

function this:GetMainSectionStar(id,hardLv)
    local sectionData = self.sectionDatas[id]
    local starNums = 0
    hardLv = hardLv or 1
    if sectionData then
        local _cfgs = sectionData:GetDungeonCfgs(hardLv)
        if _cfgs and #_cfgs > 0 then
            for _, _cfg in pairs(_cfgs) do
                if _cfg.sub_type ~= 1 then
                    local dungeonData = DungeonMgr:GetDungeonData(_cfg.id)
                    starNums = dungeonData == nil and starNums or starNums + dungeonData:GetStar()
                end
            end
        end
    end
    return starNums
end

------------------------------------爬塔------------------------------------
-- 每周关卡开启状态
function this:IsTowerOpen(id)
    local cfg = Cfgs.MainLine:GetByID(id)
    if(cfg and cfg.nStartTime and cfg.nEndTime)then
        local _startTime = GCalHelp:GetTimeStampBySplit(cfg.nStartTime)
        local _endTime = GCalHelp:GetTimeStampBySplit(cfg.nEndTime)
        if(TimeUtil:GetTime()>= _startTime and TimeUtil:GetTime()< _endTime)then
            return true
        end
    else
        return true
    end
	return false
end

--更新塔数据
function this:UpdateTowerData(proto)
    local data = nil
    if proto then
        data ={}
        data.resetTime = proto.nTowerResetTime or -1
        data.max = proto.nTowerCeiling or 0
        data.cur = proto.nTowerCurrent or 0
    end
    self.towerRewardData = data
    EventMgr.Dispatch(EventType.Tower_Update_Data, data)
end

--获取塔数据
function this:GetTowerData()
    return self.towerRewardData
end

--变更塔数据
function this:AddTowerCur(num)
    if self.towerRewardData then
        self.towerRewardData.cur = self.towerRewardData.cur + num < self.towerRewardData.max and self.towerRewardData.cur + num or self.towerRewardData.max
    end
    return self.towerRewardData
end

-- 当前副本是否为爬塔关卡
function this:IsCurrTower()
    local targetId = self:GetCurrId();
    local cfgDungeon = targetId and Cfgs.MainLine:GetByID(targetId);
    return cfgDungeon and cfgDungeon.type == eDuplicateType.Tower;
end
------------------------------------活动------------------------------------
--添加活动开启信息 1-战场 2-剧情活动 3-讨伐活动
function this:AddActivityOpenInfo(proto)
    self.ActiveOpenInfos = self.ActiveOpenInfos or {}
    if proto and proto.id then
        local data = {
            id = proto.id,
            type = proto.type,
            nBegTime = proto.nBegTime,
            nEndTime = proto.nEndTime,
            nHardBegTime = proto.nHardBegTime,
            nExBegTime = proto.nExBegTime,
            nBattleendTime = proto.nBattleendTime
        }
        local activeOpenInfo = self.ActiveOpenInfos[data.id]
        if activeOpenInfo == nil then
            activeOpenInfo = DungeonOpenInfo.New()
        end
        activeOpenInfo:Init(data)
        self.ActiveOpenInfos[data.id] = activeOpenInfo
    end
end

--获取所有活动开启信息
function this:GetActiveOpenInfos()
    return self.ActiveOpenInfos
end

--获取活动开启信息
function this:GetActiveOpenInfo(_id)
    return self.ActiveOpenInfos and self.ActiveOpenInfos[_id]
end

--获取活动开启信息 --章节id
function this:GetActiveOpenInfo2(_id)
    if self.ActiveOpenInfos then
        for k, v in pairs(self.ActiveOpenInfos) do
            if v:GetSectionID() and v:GetSectionID() == _id then
                return v
            end
        end
    end
end

--活动开启
function this:IsActiveOpen(_id)
    local openInfo = self:GetActiveOpenInfo(_id)
    return openInfo and openInfo:IsOpen()
end

--活动开启 --章节id
function this:IsActiveOpen2(_id)
    local openInfo = self:GetActiveOpenInfo2(_id)
    return openInfo and openInfo:IsOpen()
end

--活动副本开启
function this:IsActiveDungeonOpen(_id)
    local openInfo = self:GetActiveOpenInfo(_id)
    return openInfo and openInfo:IsDungeonOpen()
end
-----------------------------------------------战斗中-----------------------------------------------
-- 使用默认队伍进入指定副本 默认为主线队伍1
function this:ApplyEnterByDefault(id)
    local defaultTeamID = 1;
    local list = {};
    local teamData = TeamMgr:GetTeamData(defaultTeamID);
    for k, v in ipairs(teamData.data) do
        local item = {
            cid = v.cid,
            row = v.row,
            col = v.col
        }
        local cardData = FormationUtil.FindTeamCard(v.cid);
        item.id = cardData:GetCfgID();
        item.index = v.index;
        item.nStrategyIndex = v:GetStrategyIndex();
        table.insert(list, item)
    end
    if list and #list > 6 then
        LogError("队伍数据有误！");
        LogError(teamData:GetData());
        return
    end
    TeamMgr:AddFightTeamData(teamData);
    UIUtil:AddFightTeamState(1, "DungeonMgr:ApplyEnterByDefault()")
    local duplicateTeamData = {
        nTeamIndex = teamData.index,
        team = list,
        nSkillGroup = teamData.skillGroupID
    }
    self:ApplyEnter(id, {defaultTeamID}, {duplicateTeamData});
end

function this:SetToCheckBattleFight()
    self.checkBattleFight = 1;
end

-- 进入副本
function this:ApplyEnter(id, indexList, duplicateTeamDatas)
    -- self.isContinueFightDungeon = self:GetCurrFightId() == id;
    indexList = indexList or {};
    duplicateTeamDatas = duplicateTeamDatas or {};
    -- 发送协议, 请求进入副本
    local data = {
        index = 1, -- 副本类型
        nDuplicateID = id, -- 副本id
        data = indexList, -- 队伍id
        list = duplicateTeamDatas -- 编队信息
    }
    local dungeonCfg = Cfgs.MainLine:GetByID(id);
    -- LogError(data.list)
    if dungeonCfg and dungeonCfg.nGroupID ~= nil and dungeonCfg.nGroupID ~= "" then -- 直接进入战斗的副本
        self:SetFightTeamId(indexList[1]); -- 设置正在战斗中的队伍id

        self:SetCurrId(id)
        local groupCfg = Cfgs.MonsterGroup:GetByID(dungeonCfg.nGroupID);
        self:SetFightMonsterGroup(groupCfg);
        data.isMultiReward = self.isMultiReward -- 每日副本多倍奖励
        FightProto:EnterFightDuplicate(data)
    else
        FightProto:EnterDuplicate(data)
    end

    --副本消息超时提示
    EventMgr.Dispatch(EventType.Net_Msg_Wait,{msg="fight",time=5000,
    timeOutCallBack=function()
        local retryTime = DungeonMgr.retryTime or 0;
        local time = CSAPI.GetTime();
        if(time < retryTime + 10)then
            return;
        end
        DungeonMgr.retryTime = time;
        --Tips.ShowTips("network delay!");      
        LogError(string.format("请求进入副本失败,id=%s,indexList=%s,duplicateTeamDatas=%s",id, table.tostring(indexList,true),table.tostring(duplicateTeamDatas,true)));       
        DungeonMgr:ApplyEnter(id, indexList, duplicateTeamDatas);
    end});
end

function this:ApplyDungeonFight(myOID, monsterOID)
    FightClient:Clean();

    local index = BattleMgr:GetDungeonIndex();
    local proto = {
        index = index,
        myOID = myOID,
        monsterOID = monsterOID,
        isMultiReward = self.isMultiReward
    };
    -- local proto = {index = index, myOID = myOID, monsterOID = monsterOID};
    FightProto:EnterFight(proto);
end

function this:EnterDungeon(proto)
    -- 不进副本，只是获取副本数据    
    if (self.gettingBattleData) then
        self.gettingBattleData = nil;
        BattleMgr:SetBattleData(proto)
        return;
    end

    self.currCompleteState = nil;
    for k, v in ipairs(proto.arrChar) do
        if v.type == 1 then -- 我方队伍
            TeamMgr:UpdateFightTeamData(v);
        end
    end
    -- LogError(proto);
    self.currId = proto.nDuplicateID;
    if (self.currId) then
        -- LogError("cc"..tostring(self.checkBattleFight));	
        if (self.checkBattleFight and self:TryEnterFighting(proto.arrChar)) then
            -- 有战斗进行中，直接进战斗
            BattleMgr:SetBattleData(proto)
        else
            if (not SceneMgr:IsBattleDungeon() or (proto and proto.nStep and proto.nStep == 0) ) then
                BattleMgr:Reset();
                EventMgr.Dispatch(EventType.Scene_Load, "Battle");
                BattleMgr:PushData(proto, BattleMgr.Init);
            end
        end
    end

    self.checkBattleFight = nil;
end
-- 是否有战斗进行中
function this:TryEnterFighting(arr)
    if (not arr) then
        return;
    end

    --    local cacheBattleDatas = BattleMgr:GetDatas();
    --    if(cacheBattleDatas and #cacheBattleDatas > 0)then       
    --        return;
    --    end
    local playerTeamData = nil;
    local monsterTeamData = nil;

    for k, v in ipairs(arr) do
        if (v.state == eDungeonCharState.Fighting) then
            if v.type == 1 then -- 我方队伍
                if (monsterTeamData == nil or monsterTeamData.pos == v.pos) then
                    playerTeamData = v;
                    -- LogError("playerTeamData" .. table.tostring(playerTeamData));
                end
            else
                if (playerTeamData == nil or playerTeamData.pos == v.pos) then
                    monsterTeamData = v;
                    -- LogError("monsterTeamData" .. table.tostring(monsterTeamData));
                end
            end
        end
    end

    if (playerTeamData and monsterTeamData) then
        self:SetFightTeamId(playerTeamData.nTeamID); -- 设置正在战斗中的队伍id
        local groupCfg = Cfgs.MonsterGroup:GetByID(monsterTeamData.nMonsterGroupID);
        self:SetFightMonsterGroup(groupCfg);

        self:ApplyDungeonFight(playerTeamData.oid, monsterTeamData.oid);
        return true;
    end
end

-- 是否有战斗进行中
function this:HasFighting()
    local battleData = BattleMgr:GetBattleData()
    local arr = battleData and battleData.arrChar;

    if (not arr) then
        return false;
    end

    local playerTeamData = nil;
    local monsterTeamData = nil;

    for k, v in ipairs(arr) do
        if (v.state == eDungeonCharState.Fighting) then
            if v.type == 1 then -- 我方队伍
                if (monsterTeamData == nil or monsterTeamData.pos == v.pos) then
                    playerTeamData = v;
                    -- LogError("playerTeamData" .. table.tostring(playerTeamData));
                end
            else
                if (playerTeamData == nil or playerTeamData.pos == v.pos) then
                    monsterTeamData = v;
                    -- LogError("monsterTeamData" .. table.tostring(monsterTeamData));
                end
            end
        end
    end

    if (playerTeamData and monsterTeamData) then
        return true;
    end

    return false;
end

-- 战斗中的副本是否继续进行的（该副本进行中）
-- function this:IsContinueFightDungeon()
--    return self.isContinueFightDungeon;
-- end
function this:SetFightTeamId(fightTeamId)
    self.fightTeamId = fightTeamId;
end
function this:GetFightTeamId()
    return self.fightTeamId;
end

-- 缓存结算队伍信息
-- function this:SetRewardTeam(data)
-- 	if data then
-- 		local posData = {};
-- 		local fuid = nil;
-- 		local leaderID = nil;
-- 		for k,val in ipairs(data.data.data) do
-- 			local v=val.data
-- 			local item = {
-- 				cid = v.cuid,
-- 				row = v.row,
-- 				col = v.col,
-- 				fuid = v.fuid,
-- 				index = v.index,
-- 			};
-- 			if v.fuid then
-- 				item.cid = FormationUtil.FormatAssitID(v.fuid, v.cuid);
-- 				fuid = v.fuid;
-- 			elseif v.npcid then
-- 				item.bIsNpc = true;
-- 			end
-- 			if v.isLeader or v.index==1 then
-- 				leaderID = v.cuid;
-- 			end
-- 			table.insert(posData, item);
-- 		end
-- 		local currTeam = TeamMgr:GetTeamData(data.teamID);
-- 		local teamData = {
-- 			index = data.teamID,
-- 			leader = leaderID,
-- 			name = currTeam == nil and "" or currTeam.teamName,
-- 			data = posData,
-- 		};
-- 		self.rewardTeam = TeamData.New();
-- 		self.rewardTeam:SetData(teamData);
-- 		Log("RewardTeam");
-- 		Log(self.rewardTeam:GetData());
-- 	end
-- end
-- function this:GetRewardTeam()
-- 	return self.rewardTeam or nil;
-- end
-- 当前战斗的副本ID
function this:SetCurrFightId(id)
    self.currFightId = id;
end

-- 返回当前战斗的副本ID
function this:GetCurrFightId()
    return self.currFightId;
end

-- 返回当前战斗中的章节ID
function this:GetCurrFightSectionId()
    if self.currFightId then
        local cfgDungeon = Cfgs.MainLine:GetByID(self.currFightId);
        if cfgDungeon then
            return cfgDungeon.group;
        end
    end
    return nil;
end

--获取当前进行中的副本的配置
function this:GetCurrDungeonCfg()
    return Cfgs.MainLine:GetByID(self:GetCurrId());
end
--是否教程副本
function this:IsTutorialDungeon()
    local cfg = self:GetCurrDungeonCfg();
    return cfg and cfg.type == 4;--教程类型
end

-- 获取当前副本ID
function this:GetCurrId()
    return self.currId;
end

-- 获取当前副本ID
function this:SetCurrId(id)
    self.currId = id;

    if (id) then
        local dungeonCfg = Cfgs.MainLine:GetByID(id);
        if dungeonCfg.nGroupID ~= nil and dungeonCfg.nGroupID ~= "" then -- 直接进入战斗的副本
            return;
        end

        local battleData = BattleMgr:GetBattleData();
        if (not battleData and not self.gettingBattleData) then
            self:QueryDungeonData();
        end
    else
        BattleMgr:SetBattleData();
    end
end

-- 用于选关界面的寻路设置
function this:SetCurrId1(_id)
    self.currId = _id
end

function this:QueryDungeonData()
    if (self.currId) then
        self.gettingBattleData = 1;
        DungeonMgr:ApplyEnter(self.currId);
    end
end

-- 获取战棋副本数据
function this:GetBattleDungeonData(dungeonId)
    self.battleDungeonDatas = self.battleDungeonDatas or {};
    if (self.battleDungeonDatas[dungeonId] == nil) then
        self.battleDungeonDatas[dungeonId] = require("Dungeon_" .. dungeonId);
    end

    return self.battleDungeonDatas[dungeonId];
end

-- 当前副本是否为剧情关卡
function this:IsCurrStory()
    local targetId = self:GetCurrId();
    local cfgDungeon = targetId and Cfgs.MainLine:GetByID(targetId);
    return cfgDungeon and cfgDungeon.sub_type == DungeonFlagType.Story;
end

----------------------------------------战斗后返回--------------------------------------------------
-- 副本结束
function this:SetDungeonOver(dungeonOverData)
    if dungeonOverData and dungeonOverData.bIsWin then
        self.isFirst = true;
        self.isWin = true
        local dungeonData = self.dungeonDatas[self:GetCurrId()]
        if dungeonData ~= nil and dungeonData.data ~= nil and dungeonData.data.star ~= nil then
            self.isFirst = dungeonData.data.star == 0;
        elseif not dungeonOverData.fisrtPassReward then
            self.isFirst = false
        end
        local data = {
            id = self:GetCurrId(),
            star = dungeonOverData.star,
            data = dungeonOverData.data --通关条件
        }
        --星数覆盖
        local star = data.star
        if dungeonData and dungeonData:GetStar() then
            star = star < dungeonData:GetStar() and dungeonData:GetStar() or star
        end
        data.star = star

        self:AddDungeonData(data);

        PlayerProto:DuplicateModUpData(self:GetCurrId()) --获取扫荡数据
        DungeonBoxMgr:CheckRedPointData() --关卡结束红点刷新
        MenuMgr:UpdateDatas() --刷新关卡解锁状态
        EventMgr.Dispatch(EventType.Update_Dungeon_Data)
        if self.isFirst then --只在第一次通关时刷新
            -- ArchiveMgr:CheckRedPoint(ArchiveType.Enemy) --解锁敌人图鉴刷新
        end
    end
    self.currCompleteState = 1;
    -- FriendMgr:ClearAssistData(); --清空助战缓存
    -- TeamMgr:ClearFightTeamData();--清空战斗中的队伍数据
    DungeonMgr:ClearDragList();

    BattleMgr:Clear();

    EventMgr.Dispatch(EventType.RedPoint_Refresh)
end

-- 当前副本是否结束
function this:IsCurrDungeonComplete()
    return self.currCompleteState;
end

-- 当前副本是否第一次通关
function this:GetCurrDungeonIsFirst()
    return self.isFirst;
end

-- 更改当前副本第一次通关状态
function this:SetCurrDungeonNoFirst()
    self.isFirst = false
end

-- 当前副本是否是通关返回
function this:GetCurrDungeonIsWin()
    if self.isWin then
        self.isWin = false
        return true
    end
    return false;
end

-- 回到主场并打开副本界面
function this:Quit(isExit, jumpType)
    DebugLog("副本结束退出，回到副本选择界面");
    SceneLoader:Load("MajorCity", function()
        -- MenuMgr:UpdateData()
        -- if(not MenuMgr:CheckOpenList()) then --如果存在功能解锁则不跳转
        self:OnQuit(isExit, jumpType);
        -- end
    end)
    -- EventMgr.Dispatch(EventType.Scene_Load,"MajorCity");
end
function this:OnQuit(isExit, jumpType)
    -- 引导忽略自动打开逻辑
    if (GuideMgr:HasMenuGuide()) then
        return;
    end

    if jumpType then --优先跳转
        Log(jumpType);
        if jumpType == 1 then
            JumpMgr:Jump(40001);
        elseif jumpType == 2 then
            JumpMgr:Jump(40001);
        elseif jumpType == 3 then
            JumpMgr:Jump(40001);
        elseif jumpType == 4 then
            JumpMgr:Jump(80002);
        end
        return
    end

    isExit = isExit ~= nil and isExit or false;
    if DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Daily then
        -- 活动副本
        local cfgDungeon = Cfgs.MainLine:GetByID(self.currId);
        CSAPI.OpenView("Section", {type = 2,group = cfgDungeon.group, id = cfgDungeon.id});
    elseif DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Activity then
        CSAPI.OpenView("Section",{type = 4});
        local cfg = Cfgs.MainLine:GetByID(self.currId)
        if cfg then
            if cfg.type == eDuplicateType.Tower then --爬塔
                CSAPI.OpenView("DungeonTower",{id = cfg.group,itemId = cfg.id})
            elseif cfg.type == eDuplicateType.BattleField then --战场
                CSAPI.OpenView("BattleField", {id = cfg.group})
            elseif cfg.type == eDuplicateType.StoryActive then --剧情
                local path1,paht2 = DungeonUtil.GetViewPath(cfg.group)
                if path1~="" then
                    CSAPI.OpenView(path1, {id = cfg.group},{isDungeonOver = true})
                end
                if paht2~=""  then
                    CSAPI.OpenView(paht2, {id = cfg.group, itemId = cfg.id},{isDungeonOver = true})
                end
            elseif cfg.type == eDuplicateType.TaoFa then --讨伐
                CSAPI.OpenView("DungeonActivity2",{id = cfg.group, itemId = cfg.id})           
            end
        end
    elseif  DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.Course then
        CSAPI.OpenView("CourseView",1)
    else  -- 主线章节
        if isExit and self.currFightId then
            -- 回到战斗中的章节
            local id = self:GetCurrFightSectionId();
            if id then
                CSAPI.OpenView("Section",{type = 1})
                CSAPI.OpenView("Dungeon", {
                    id = id
                });
            end
        else
            local currSection = self:GetCurrSectionData();
            if currSection then
                -- 设置打开界面后的状态
                local _state = self:GetCurrDungeonIsWin() and DungeonOpenType.Finish or DungeonOpenType.Retreat
                if _state == DungeonOpenType.Finish then
                    _state = self:GetCurrDungeonIsFirst() and DungeonOpenType.Normal or DungeonOpenType.Finish
                end
                CSAPI.OpenView("Section",{type = 1})
                CSAPI.OpenView("Dungeon", {
                    id = currSection:GetID(),
                    state = _state
                });
            end
        end
    end
    self:SetCurrId()
end

-- 申请退出副本
function this:SendToQuit()
    local currId = self:GetCurrId();
    if (currId) then
        FightProto:QuitDuplicate({
            index = 1,
            nDuplicateID = currId
        });
    end
    self:SetCurrId()
end

-- 战斗结束数据
function this:FightOver(proto)
    if (FightActionUtil:HangupFightResult(proto)) then
        return;
    end
    local isSurrender = FightClient:IsSurrender();
    FightOverTool.OnDuplicate(proto, isSurrender);
    self:SetCurrFightId();--清除正在战斗中的副本
    -- self:UpdateDupGrade(proto.id, proto.star, proto.nDupGrade);
end
-- 获取战斗结束
-- function this:GetFightOverData(proto)
--	return self.fightOverData;
-- end
-- 设置战斗的怪物组配置数据
function this:SetFightMonsterGroup(cfgFightMonsterGroup)
    self.cfgFightMonsterGroup = cfgFightMonsterGroup;
end
-- 获取战斗的怪物组配置数据
function this:GetFightMonsterGroup()
    return self.cfgFightMonsterGroup;
end

function this:Init()
    self:InitSectionDatas();
    FileUtil.SaveToFile("CurrID.txt", {
        id = 0
    }) -- 初始化本地缓存
    self:InitDungeonGroupDatas()
end

-- 获取界面打开设置
function this:GetViewOpenSetting()
    self.viewOpenSetting = self.viewOpenSetting or {};
    return self.viewOpenSetting;
end

-- 缓存章节界面的滑动进度，重新进入之后会消失
function this:SetDungeonViewOffset(offset)
    self.dungeonOffset = offset or 0;
end

-- 返回章节界面的滑动进度
function this:GetDungeonViewOffset()
    return self.dungeonOffset or 0;
end

function this:GetHardPath()
    return "Dungeon_HardInfo_" .. PlayerClient:GetUid() ..".txt"
end

--设置章节难度 id:sectionId
function this:SetDungeonHardLv(id, hardlv)
    if not id then
        return
    end
    if self.hardInfo == nil then
        self.hardInfo = FileUtil.LoadByPath(self:GetHardPath()) or {}
    end
    self.hardInfo[id] = hardlv
    FileUtil.SaveToFile(self:GetHardPath(id), self.hardInfo)
end

function this:GetDungeonHardLv(id)
    if self.hardInfo == nil then
        self.hardInfo = FileUtil.LoadByPath(self:GetHardPath()) or {}
    end
    return self.hardInfo[id] or 1
end

-- 返回当前关卡的特殊通关条件描述
function this:GetPassDesc(id)
    local str = ""
    local currId = id or self:GetCurrId()
    if currId then
        local dungeonCfg = Cfgs.MainLine:GetByID(currId);
        if dungeonCfg and dungeonCfg.jWinCon then
            local type = dungeonCfg.jWinCon[1];
            local paramStr = "";
            if type == 3 or type == 5 then
                paramStr = dungeonCfg.jWinCon[2];
            elseif type == 4 then
                for k, v in ipairs(dungeonCfg.jWinCon[2]) do
                    local cardInfo = Cfgs.CardData:GetByID(v);
                    if cardInfo then
                        local num = dungeonCfg.jWinCon[3] == nil and 1 or dungeonCfg.jWinCon[3];
                        paramStr =
                            k > 1 and paramStr .. "X" .. num .. "、" .. cardInfo.name or paramStr .. "X" .. num ..
                                cardInfo.name;
                    end
                end
            end
            local winCons = {27029, 15050, 15051, 15052, 15053, 15054}
            str = LanguageMgr:GetByID(winCons[type], paramStr)
        end
    end
    return str;
end

-- 战斗界面中改变站位的列表
function this:SetDragList(dragList)
    self.dragList = dragList;
end

function this:GetDragList()
    return self.dragList;
end

function this:ClearDragList()
    self.dragList = nil;
end

function this:ClearGettingBattleData()
    self.gettingBattleData = nil;
end

-- 记录AI战斗
function this:AddAIFightRewards(rewards)
    self.AIRewards = self.AIRewards or {};
    if rewards~=nil then
        for key, val in ipairs(rewards) do
            if val.type == RandRewardType.ITEM or val.type == null then
                local info = self.AIRewards[val.id];
                if info == nil then
                    self.AIRewards[val.id] = val;
                else
                    info.num = info.num + val.num;
                end
            else
                self.AIRewards[val.c_id] = val;
            end
        end
    end
end

function this:GetAIFightRewards()
    local list = nil;
    if self.AIRewards then
        list = {};
        for key, val in pairs(self.AIRewards) do
            table.insert(list, val);
        end
    end
    return list;
end

function this:ClearAIFightInfo()
    self.AIRewards = nil;
    self.AIDungeonInfo = nil;
end

function this:AddAutoDungeonInfo(dungeonId, teams)
    self.AIDungeonInfo = {};
    self.AIDungeonInfo.id = dungeonId;
    self.AIDungeonInfo.teams = teams;
end

-- 当前战斗的副本是否是主线
function this:CurrSectionIsMainLine()
    local sectionData = self:GetCurrSectionData();
    if self.currId and DungeonMgr:GetDungeonSectionType(self.currId) == SectionType.MainLine then
        return true;
    end
    return false;
end

--获取当前副本类型
function this:GetCurrDungeonType()
    if self.currId then
        local cfgDungeon = Cfgs.MainLine:GetByID(self.currId)
        return cfgDungeon and cfgDungeon.type
    end
    return nil
end

function this:GetAutoDungeonInfo()
    return self.AIDungeonInfo;
end

function this:LoadNaviConfig()
    return FileUtil.LoadByPath("NaviConfig.txt");
end

function this:SaveNaviConfig(tab)
    if tab then
        FileUtil.SaveToFile("NaviConfig.txt", tab);
    end
end

function this:ShowAIMoveBtn(isShow)
    PlayerPrefs.SetInt("AIMove_ShowBtn", isShow and 1 or 0)
end

function this:AIMoveBtnShow()
    return PlayerPrefs.GetInt("AIMove_ShowBtn") > 0
end

--第一次提示双倍开启
function this:GetFisrtOpenDouble()
    return self.firstOpenDouble
end

function this:SetFisrtOpenDouble(b)
    self.firstOpenDouble = b
end

---------------------------------------------red---------------------------------------------
function this:CheckRedPointData()
    local redData = {}
    redData.isMain = DungeonBoxMgr:CheckRed()
    redData.isActivity = MissionMgr:CheckRed({eTaskType.TmpDupTower,eTaskType.DupTower,eTaskType.Story,eTaskType.DupTaoFa})
    if not redData.isMain and not redData.isActivity then
        redData = nil
    end
    RedPointMgr:UpdateData(RedPointType.Attack, redData)
end

---------------------------------------------new---------------------------------------------
-- 获取new 
function this:GetIsNew(id)
    if  not self:IsDungeonOpen(id) then
        return false
    end
    local newInfo = FileUtil.LoadByPath("Dungeon_new_Info" .. PlayerClient:GetUid() .. ".txt") or {}
    if not newInfo[id] then
        return true
    end
    return newInfo[id] == 1
end

--设置new
function this:SetIsNew(id, b)
    if id == nil then
        return
    end
    local newInfo = FileUtil.LoadByPath("Dungeon_new_Info" .. PlayerClient:GetUid() .. ".txt") or {}
    newInfo[id] = b and 1 or 0
    FileUtil.SaveToFile("Dungeon_new_Info" .. PlayerClient:GetUid() .. ".txt",newInfo)
end

---------------------------------------------活动门票---------------------------------------------

function this:SetArachnidCount(proto)
    if proto and proto.can_buy_cnt then
        self.ArachnidCount = proto.can_buy_cnt or 0
    end
    EventMgr.Dispatch(EventType.Arachnid_Count_Refresh)
end

function this:GetArachnidCount()
    return self.ArachnidCount or 0
end

function this:Clear()
    self.dragList = nil;
    self.dungeonHardLv = 1;
    self.dungeonOffset = 0;
    self.viewOpenSetting = {};
    self.cfgFightMonsterGroup = {};
    self.multiInfo = nil;
    self.dungeonDatas = nil;
    self.dailyData = nil;
    self.multiUpdateTime = nil
    self.sectionDatas = nil;
    self.currCompleteState = nil;
    self.isFirst = false;
    self.isWin = false;
    self.currId = nil;
    self.fightTeamId = nil;
    self.currFightId = nil;
    self.battleDungeonDatas = nil;
    self.rewardTeam = nil;
    self.isMultiReward = false;
    self.isApplyEnter = false
    self.dungeonGroupDatas = nil
    self.ActivityPlotDatas = nil
    self.hardInfo = nil
end

this:Init();

return this;
