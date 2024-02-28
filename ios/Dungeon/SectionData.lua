--章节数据
local this = {};

function this.New()
	this.__index = this.__index or this;
	local ins = {};
	setmetatable(ins, this);		
	return ins;
end

--设置配置
function this:Init(targetCfg)
	self.cfg = targetCfg;
end
--获取配置
function this:GetCfg()
	return self.cfg;
end

--获取ID
function this:GetID()
	return self.cfg.id;
end
--获取名称
function this:GetName()
	return self.cfg.name;
end

function this:GetMapName()
	return self.cfg.mName
end

--章节分类
function this:GetGroup()
	return self.cfg and self.cfg.group;
end

--返回章节索引
function this:GetIndex()
	return self.cfg.index;
end

function this:GetChaperName()
	return self.cfg.chapter;
end

function this:GetOName()
	return self.cfg.oName;
end

function this:GetEName()
	return self.cfg.eName;
end

function this:GetNameImg()
	return self.cfg.nameImg;
end

function this:GetIcon()
	return self.cfg.icon;
end

function this:GetSectionBG()
	return self.cfg.sBg;
end

--获取状态
function this:GetState(type)
	local id = self:GetID();
	local isOpen = false;
	local isComplete = true;
	type = type == nil and 1 or type;
	local state = 0;
	local cfgs = Cfgs.MainLine:GetGroup(id);--cfgMainLine.type为1表示普通难度副本
	if(cfgs) then
		for _, cfgMainLine in ipairs(cfgs) do
			if(cfgMainLine.type == type) then --筛选难度
				local dungeonData = DungeonMgr:GetDungeonData(cfgMainLine.id);
				if(isOpen == false) then
					if(DungeonMgr:IsDungeonOpen(cfgMainLine.id)) then
						isOpen = true;				
					end
				end
				
				if(dungeonData == nil or dungeonData:IsOpen() == false or dungeonData:IsPass() == false) then
					isComplete = false;				
				end
				if(isOpen and isComplete == false) then
					break;
				end
			end
		end
	else
		isOpen = false;
		isComplete = false;
	end
	if(isOpen and isComplete) then
		state = 2;
	elseif(isOpen) then
		state = 1;
	else
		state = 0;
	end
	
	return state;
end

--获取副本配置
function this:GetDungeonCfgs(hardLv)
	if(self:GetSectionType() == SectionType.MainLine) then
		--获取主线副本
		local allDungeonCfgs = self:GetAllDungeonCfgs();
		if(allDungeonCfgs) then
			return allDungeonCfgs[hardLv];
		end
	else
		--获取每日副本
		return Cfgs.MainLine:GetGroup(self:GetID());
	end
	
	return nil;
end

--获取副本配置
function this:GetAllDungeonCfgs()
	if(self.dungeonCfgs == nil) then
		self.dungeonCfgs = {};
		local cfgGroup = Cfgs.MainLine:GetGroup(self:GetID());
		if(cfgGroup) then
			for _, tmpCfg in ipairs(cfgGroup) do
				if tmpCfg.type == eDuplicateType.SubLine or tmpCfg.type == eDuplicateType.Teaching then --支线或教程,判断前置关卡是困难还是简单，并添加到对应数组
				-- if tmpCfg.type == eDuplicateType.SubLine then
					local cfg = Cfgs.MainLine:GetByID(tmpCfg.preChapterID[1]);
					if cfg then
						table.insert(self.dungeonCfgs[cfg.type], tmpCfg);
					end
				else
					self.dungeonCfgs[tmpCfg.type] = self.dungeonCfgs[tmpCfg.type] or {};
					-- self.dungeonCfgs[tmpCfg.type][tmpCfg.id] = tmpCfg; 
					table.insert(self.dungeonCfgs[tmpCfg.type], tmpCfg);
				end
			end
		end
	end
	
	return self.dungeonCfgs;
end

--返回最后一个开启的关卡配置信息
function this:GetLastOpenDungeon()
	local dungeonCfg = nil;
	local cfgGroup = Cfgs.MainLine:GetGroup(self:GetID());
	if(cfgGroup) then
		for _, tmpCfg in ipairs(cfgGroup) do
			if tmpCfg.type == eDuplicateType.MainNormal then --只判断普通难度的主线本
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
						break;
					end
				end
			end
		end
	end
	return dungeonCfg;
end

--返回完成百分比 只有普通难道
function this:GetCompletePercent()
	local count = 0;
	local total = 0;
	local cfgGroup = Cfgs.MainLine:GetGroup(self:GetID());
	if(cfgGroup) then
		for _, tmpCfg in ipairs(cfgGroup) do
			if tmpCfg.type == eDuplicateType.MainNormal then --支线,判断前置关卡是困难还是简单，并添加到对应数组
				total = total + 1;
				local dungeonData = DungeonMgr:GetDungeonData(tmpCfg.id);
				if(dungeonData ~= nil and dungeonData:IsOpen() == true and dungeonData:IsPass() == true) then
					count = count + 1;
				end
			end
		end
	end
	return math.floor((count / total) * 100);
end

--返回完成百分比 包含教程 支线
function this:GetCompletePercentByAll(type)
	type = type or 1
	local count = 0;
	local total = 0;
	local cfgGroup= Cfgs.DungeonGroup:GetGroup(self:GetID());
	if(cfgGroup) then
		for _, tmpCfg in ipairs(cfgGroup) do
			local cfgIDs = type == eDuplicateType.MainNormal and tmpCfg.dungeonGroups or tmpCfg.hDungeonGroups
			if cfgIDs then
				for _, cfgID in ipairs(cfgIDs) do
					total = total + 1
					local dungeonData = DungeonMgr:GetDungeonData(cfgID);
					if(dungeonData ~= nil and dungeonData:IsOpen() == true and dungeonData:IsPass() == true) then
						count = count + 1;
					end
				end
			end			
		end
	end
	return math.floor((count / total) * 100);
end

--获取章节类型
function this:GetSectionType()
	return self.cfg.group;
end

--获取具体类型
function this:GetType()
	return self.cfg.type;
end

--返回星级奖励信息,没有则返回空, type:当前关卡的难度类型
function this:GetStarRewards()
	local type = DungeonMgr:GetDungeonHardLv(self:GetID())
	local cfg = nil;
	if self.cfg.starRewardID and self.cfg.starRewardID[type] then
		cfg = Cfgs.CfgSectionStarReward:GetByID(self.cfg.starRewardID[type]);
	end
	return cfg;
end

--返回星级奖励id
function this:GetStarRewardID()
	local type = DungeonMgr:GetDungeonHardLv(self:GetID())
	if self.cfg.starRewardID then
		return self.cfg.starRewardID[type]
	end
end

--返回背景图片
function this:GetBG()
	return self.cfg and self.cfg.bg or nil;
end

function this:GetBGPosZ()
	return self.cfg and self.cfg.bgPosZ or 15.2
end

function this:GetLockDesc()
	return self.cfg and self.cfg.lock_desc or "";
end
function this:GetHardLockDesc()
	return self.cfg and self.cfg.hardLock_desc or "";
end

function this:GetOpenTime()
	return self.cfg and self.cfg.openTime or nil;
end

function this:GetPassDesc()
	local type = DungeonMgr:GetDungeonHardLv(self:GetID())
	if type == 1 then
		return self.cfg and self.cfg.passDesc
	else
		return self.cfg and self.cfg.diffPassDesc
	end
	
end

function this:GetNextOpenDesc()
	return self.cfg and self.cfg.nextOpenDesc
end

--副本开启
function this:GetOpen()
	local _state,_str = self:GetOpenState()
	local _isOpen = _state > 0
	return _isOpen, _str, _state
end

--副本开启状态 0：未通关某个关卡 -1：日常本未到开启时间 -2：活动未到开启时间
function this:GetOpenState()
	local openState = 1
	local lockStr = ""
	if self.cfg then
		if self.cfg.conditions then
			local isOpen = true
			isOpen, lockStr = MenuMgr:CheckModelOpen(OpenViewType.section, self.cfg.id)
			if not isOpen then
				openState = 0
			end
		end
		if self:GetSectionType() == SectionType.Daily and openState > 0 then
			local isOpen,isNextOpen = DungeonMgr:IsDailyOpenTime(self.cfg.openTime)
			openState = isOpen and 1 or -1
			if not isOpen then --下一天开启
				openState = isNextOpen and -1.5 or -1
			end
			lockStr = self.cfg.lock_desc
		elseif self:GetSectionType() == SectionType.Activity then --活动没有未开启显示
			if self:GetType() ~= SectionActivityType.Tower then
				if openState > 0 then
					openState = DungeonMgr:IsActiveOpen(self.cfg.activeId) and 1 or -2
					lockStr = LanguageMgr:GetTips(24001)
				else
					openState = DungeonMgr:IsActiveOpen(self.cfg.activeId) and openState or -2
					lockStr = DungeonMgr:IsActiveOpen(self.cfg.activeId) and lockStr or LanguageMgr:GetTips(24001)
				end
			end
		end
	end
	return openState, lockStr
end

--掉落奖励
function this:GetFallRewards()
	return self.cfg and self.cfg.fallRewards
end

function this:GetBGM()
	return self.cfg and self.cfg.bgm
end

--获取不开启是否隐藏
function this:GetLockShow()
	return self.cfg and self.cfg.fade
end

function this:GetDailyType()
	return self.cfg and self.cfg.dailyEnumID
end

function this:GetActiveOpenID()
	return self.cfg and self.cfg.activeId
end

function this:GetMultiID()
	return self.cfg and self.cfg.multiId
end

--角色活动轮盘区域数
function this:GetTurnNum()
	return self.cfg and self.cfg.turnNum
end

--进入选关时播放的剧情id
function this:GetStoryID()
	return self.cfg and self.cfg.story
end

function this:GetPath()
	return self.cfg and self.cfg.path
end

return this; 