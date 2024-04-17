local this = {};

--获取当前的数据
function this.GetCurrNum(type, target, num)
	local count = num;
	if type == DungeonStarType.MoveNum and(num > target or num < 0) then --未达成时直接读取步数
		count = BattleMgr:GetStepNum();
	elseif type == DungeonStarType.BoxNum and(num < 0 or num < target) then
		count = BattleMgr:GetBoxNum();	
	elseif type == DungeonStarType.KillMonsterNum and(num < 0 or num < target) then
		count = BattleMgr:GetKillCount();
	end
	return count;
end

function this.GetInfo(type, target, num, isEnterFight)
	local info = {};
	if isEnterFight then
		local starTips = {15056, 15063, 15083, 15084}
		if type == FightStarType.Pass then
			info = {
				tips = LanguageMgr:GetByID(starTips[type], num, target),
				isComplete = num >= target,
			};
		elseif type == FightStarType.DeathNum then
			info = {
				tips = target > 0 and LanguageMgr:GetByID(starTips[type], target) or LanguageMgr:GetByID(25039),
				isComplete = num >= 0 and num <= target or false,
			};
		else
			info = {
				tips = LanguageMgr:GetByID(starTips[type], target),
				isComplete = num >= 0 and num <= target or false,
			};
		end
	else
		local starTips = {15056, 15057, 15058, 15059, 15060, 15061, 15062, 15063, 15064, 15065}
		if type == DungeonStarType.MoveNum or type == DungeonStarType.DeathNum or type == DungeonStarType.TeamNum then --条件类型为5
			info = {
				tips = LanguageMgr:GetByID(starTips[type], target),
				isComplete = num >= 0 and num <= target or false,
			};
		else
			info = {
				tips = LanguageMgr:GetByID(starTips[type], num, target),
				isComplete = num >= target,
			};
		end
	end	
	return info;
end

--返回星级信息（已达成的） 需要计算 isLocal:是否查询本地数据
function this.GetStarInfo(dungeonID, completeNums, isLocal)
	local infos = {};
	completeNums = completeNums or {};
	if dungeonID then
		local cfg = Cfgs.MainLine:GetByID(dungeonID);
		local isEnterFight = false --直接战斗
		if cfg then
			isEnterFight = cfg.nGroupID ~= nil and cfg.nGroupID ~= ""
			for i = 1, 3 do
				local star = cfg["star" .. i];
				if star then
					local num = completeNums[i] or -1;
				if isLocal == true then
					num = this.GetCurrNum(star[1], star[2], num);
				end
				local info = nil
				if i == 1 then
					local winCons = {15073, 15050, 15051, 15052, 15053, 15054}
					info = {
						tips = LanguageMgr:GetByID(15056, LanguageMgr:GetByID(winCons[star[1]])),
						isComplete = num >= star[2],
					};
				else
					info = this.GetInfo(star[1], star[2], num, isEnterFight);
				end
				table.insert(infos, info);
				end				
			end
		end
	end
	return infos;
end

function this.GetInfo2(type, target, num, isEnterFight)
	local info = {};
	if isEnterFight then
		local starTips = {15056, 15063, 15083, 15084, 15110}
		if type == FightStarType.Pass then
			info = {
				tips = LanguageMgr:GetByID(starTips[type], num, target),
				isComplete = num > 0
			};
		elseif type == FightStarType.DeathNum then
			info = {
				tips = target > 0 and LanguageMgr:GetByID(starTips[type], target) or LanguageMgr:GetByID(25039),
				isComplete = num > 0
			};
		else
			info = {
				tips = LanguageMgr:GetByID(starTips[type], target),
				isComplete = num > 0
			};
		end
	else
		local starTips = {15056, 15057, 15058, 15059, 15060, 15061, 15062, 15063, 15064, 15065}
		if type == DungeonStarType.MoveNum or type == DungeonStarType.DeathNum or type == DungeonStarType.TeamNum then --条件类型为5
			info = {
				tips = LanguageMgr:GetByID(starTips[type], target),
				isComplete = num > 0
			};
		else
			info = {
				tips = LanguageMgr:GetByID(starTips[type], num, target),
				isComplete = num > 0
			};
		end
	end	
	return info;
end

--返回星级信息（已达成的） 大于0时默认完成
function this.GetStarInfo2(dungeonID, completeNums)
	local infos = {};
	completeNums = completeNums or {};
	if dungeonID then
		local cfg = Cfgs.MainLine:GetByID(dungeonID);
		local isEnterFight = false --直接战斗
		if cfg then
			isEnterFight = cfg.nGroupID ~= nil and cfg.nGroupID ~= ""
			for i = 1, 3 do
				local star = cfg["star" .. i];
				local num  = completeNums[i] or 0
				local info = nil
				if i == 1 then
					local winCons = {15073, 15050, 15051, 15052, 15053, 15054}
					info = {
						tips = LanguageMgr:GetByID(15056, LanguageMgr:GetByID(winCons[star[1]])),
						isComplete = num > 0
					};
				else
					info = this.GetInfo2(star[1], star[2], num, isEnterFight);
				end
				table.insert(infos, info);		
			end
		end
	end
	return infos;
end

--返回章节当前多倍掉落描述
function this.GetMultiDesc(id)
	local str = "";
	local cfg = this.GetMultiCfg(id)
	if cfg then
		local list = {};
		local infoNum = DungeonMgr:GetSectionMultiNum(id);
		if cfg.plrExpAdd then
			local num = cfg.plrExpAdd[2] - infoNum
			local str = LanguageMgr:GetByID(15066, LanguageMgr:GetByID(15070, cfg.plrExpAdd[1]), num, cfg.plrExpAdd[2])
			table.insert(list, str);
		end
		if cfg.cardExpAdd then
			local num = cfg.cardExpAdd[2] - infoNum;
			local str = LanguageMgr:GetByID(15067, LanguageMgr:GetByID(15070, cfg.cardExpAdd[1]), num, cfg.cardExpAdd[2])
			table.insert(list, str);
		end
		if cfg.moneyAdd then
			local num = cfg.moneyAdd[2] - infoNum;
			local str = LanguageMgr:GetByID(15068, LanguageMgr:GetByID(15070, cfg.moneyAdd[1]), num, cfg.moneyAdd[2])
			table.insert(list, str);
		end
		if cfg.dropAdd then
			local num = cfg.dropAdd[2] - infoNum;
			local str = LanguageMgr:GetByID(15069, LanguageMgr:GetByID(15070, cfg.dropAdd[1]), num, cfg.dropAdd[2])
			table.insert(list, str);
		end
		for k, v in ipairs(list) do
			if k == 1 then
				str = str .. v;
			else
				str = str .. " " .. v;
			end
		end
	end
	return str;
end

function this.GetMultiDesc2(id)
	local str = "";
	local cfg = this.GetMultiCfg(id)
	if cfg then
		local list = {};
		local infoNum = DungeonMgr:GetSectionMultiNum(id);
		if cfg.plrExpAdd then
			local num = cfg.plrExpAdd[2] - infoNum
			local str = StringUtil:SetByColor(num, num > 0 and"FFC146" or "FF7781") .. "/" .. cfg.plrExpAdd[2]
			table.insert(list, str);
		end
		if cfg.cardExpAdd then
			local num = cfg.cardExpAdd[2] - infoNum;
			local str = StringUtil:SetByColor(num, num > 0 and"FFC146" or "FF7781") .. "/" .. cfg.cardExpAdd[2]			
			table.insert(list, str);
		end
		if cfg.moneyAdd then
			local num = cfg.moneyAdd[2] - infoNum;
			local str = StringUtil:SetByColor(num, num > 0 and"FFC146" or "FF7781") .. "/" .. cfg.moneyAdd[2]
			table.insert(list, str);
		end
		if cfg.dropAdd then
			local num = cfg.dropAdd[2] - infoNum;
			local str = StringUtil:SetByColor(num, num > 0 and"FFC146" or "FF7781") .. "/" .. cfg.dropAdd[2]
			table.insert(list, str);
		end
		for k, v in ipairs(list) do
			if k == 1 then
				str = str .. v;
			else
				str = str .. " " .. v;
			end
		end
	end
	return str;
end

--判断该章节是否有多倍掉落信息
function this.HasMultiDesc(id)
	local cfg = this.GetMultiCfg(id)
	if cfg and(cfg.plrExpAdd or cfg.cardExpAdd or cfg.moneyAdd or cfg.dropAdd) then
		return true;
	end
	return false;
end

--返回章节还剩余多少次多倍掉落
function this.GetMultiNum(id)
	local cfg = this.GetMultiCfg(id)
	local cur,max = 0,0
	local infoNum = DungeonMgr:GetSectionMultiNum(id);
	if(cfg and this.HasMultiDesc(id)) then
		if cfg.plrExpAdd then
			cur = cfg.plrExpAdd[2] - infoNum
			max = cfg.plrExpAdd[2]
		elseif cfg.cardExpAdd then
			cur = cfg.cardExpAdd[2] - infoNum
			max = cfg.cardExpAdd[2]
		elseif cfg.moneyAdd then
			cur = cfg.moneyAdd[2] - infoNum
			max = cfg.moneyAdd[2]
		elseif cfg.dropAdd then
			cur = cfg.dropAdd[2] - infoNum
			max = cfg.dropAdd[2]
		end
	end
	return cur,max
end

function this.GetMultiCfg(sectionID)
	local cfg = nil
	local cfgSection = Cfgs.Section:GetByID(sectionID);
	if cfgSection and cfgSection.multiId then
		cfg = Cfgs.CfgDupDropMulti:GetByID(cfgSection.multiId)
	end
	return cfg
end

function this.GetViewPath(sectionID)
	local sectionData = DungeonMgr:GetSectionData(sectionID)
	if sectionData and sectionData:GetPath() then
		local strs = StringUtil:split(sectionData:GetPath(),"/")
		if strs[1] == "DungeonActivity1" then
			return "DungeonActivity1","DungeonPlot"
		elseif strs[1] == "DungeonActivity3" then
			return "DungeonActivity3","DungeonRole"
		elseif strs[1] == "DungeonActivity4" then
			return "DungeonActivity4","DungeonShadowSpider"
		end
	end
	return "",""
end

function this.GetCost(cfg)
	local enterCost = cfg.cost and cfg.cost[1] or nil
    local winCost = cfg.winCost and cfg.winCost[1] or nil
    local cost = nil
    if enterCost then
        cost = enterCost
    end
    if winCost then
		if cost~=nil and cost[1] == winCost[1] then
			cost[2] = cost[2] + winCost[2]
		elseif cost == nil then
			cost = winCost
		end
    end
    return cost
end

return this; 