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
			local extreAdd = this.GetExtreMultiNum() --额外增加的次数
			local num = cfg.dropAdd[2] - infoNum + extreAdd;
			local str = LanguageMgr:GetByID(15069, LanguageMgr:GetByID(15070, cfg.dropAdd[1] + extreAdd), num, cfg.dropAdd[2] + extreAdd)
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
			local num = cfg.cardExpAdd[2] - infoNum
			local str = StringUtil:SetByColor(num, num > 0 and"FFC146" or "FF7781") .. "/" .. cfg.cardExpAdd[2]			
			table.insert(list, str);
		end
		if cfg.moneyAdd then
			local num = cfg.moneyAdd[2] - infoNum
			local str = StringUtil:SetByColor(num, num > 0 and"FFC146" or "FF7781") .. "/" .. cfg.moneyAdd[2]
			table.insert(list, str);
		end
		if cfg.dropAdd then
			local extreAdd = this.GetExtreMultiNum() --额外增加的次数
			local num = cfg.dropAdd[2] - infoNum + extreAdd;
			local str = StringUtil:SetByColor(num, num > 0 and"FFC146" or "FF7781") .. "/" .. (cfg.dropAdd[2] + extreAdd)
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

--活动增加的额外掉落次数 只针对dropAdd这个字段
function this.GetExtreMultiNum()
	local add,regresAdd = 0,0
	local cfgs = Cfgs.CfgDupDropCntAdd:GetAll()
	local isRegres = RegressionMgr:IsHuiGui()
	if cfgs then
		for _, cfg in pairs(cfgs) do
			if cfg.startTime and cfg.endTime then
				local startTime = TimeUtil:GetTimeStampBySplit(cfg.startTime)
				local endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
				if TimeUtil:GetTime() >= startTime and TimeUtil:GetTime() < endTime then
					add = add + cfg.dropAddCnt
				end
			elseif cfg.regressionType ~= nil then
				if isRegres then
					local arr = RegressionMgr:GetArr()
					if #arr > 0 then
						for k, m in ipairs(arr) do
							if m.type == RegressionActiveType.DropAdd and m.activityId == cfg.id then
								add = add + cfg.dropAddCnt
								regresAdd = regresAdd + cfg.dropAddCnt
							end
						end
					end
				end	
			end			
		end
	end
	return add,regresAdd
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
	local extreAdd = this.GetExtreMultiNum()
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
			cur = cfg.dropAdd[2] - infoNum + extreAdd
			max = cfg.dropAdd[2] + extreAdd
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

--查询剩余的多倍数量
function this.HasMultiNum(cfgId)
	local datas = DungeonMgr:GetAllSectionDatas()
	if datas and #datas > 0 then
		for i, v in pairs(datas) do
			if v:GetMultiID() and v:GetMultiID() == cfgId then
				local num = DungeonUtil.GetMultiNum(v:GetID())
				return num > 0
			end
		end
	end
	return false
end

function this.GetViewPath(sectionID)
	local sectionData = DungeonMgr:GetSectionData(sectionID)
	if sectionData and sectionData:GetInfo() then
		local info = sectionData:GetInfo()
		return info.view or "",info.childView or ""
	end
	return "",""
end

function this.GetCost(cfg)
	local enterCost = cfg.cost and cfg.cost[1] or nil
    local winCost = cfg.winCost and cfg.winCost[1] or nil
    local cost = nil
    if enterCost then
        cost = {enterCost[1],enterCost[2]}
    end
    if winCost then
		if cost~=nil and cost[1] == winCost[1] then
			cost[2] = cost[2] + winCost[2]
		elseif cost == nil then
			cost = {winCost[1], winCost[2]}
		end
    end
    return cost
end

--获取实际消耗体力
function this.GetHot(cfg)
	local costNum = cfg.enterCostHot and cfg.enterCostHot or 0
	costNum = cfg.winCostHot and costNum + cfg.winCostHot or costNum
	if DungeonUtil.GetExtreHotNum() > 0 then
		local num = DungeonUtil.GetExtreHotNum() < 100 and DungeonUtil.GetExtreHotNum() or 100
		costNum = costNum * (100 - DungeonUtil.GetExtreHotNum()) / 100 
	end
	return math.ceil(costNum),costNum --因为是负数，所以向上取整
end

--体力消耗减少
function this.GetExtreHotNum()
	local add,regresAdd = 0,0
	local cfgs = Cfgs.CfgDupConsumeReduce:GetAll()
	local isRegres = RegressionMgr:IsHuiGui()
	if cfgs then
		for _, cfg in pairs(cfgs) do
			if cfg.startTime and cfg.endTime then
				local startTime = TimeUtil:GetTimeStampBySplit(cfg.startTime)
				local endTime = TimeUtil:GetTimeStampBySplit(cfg.endTime)
				if TimeUtil:GetTime() >= startTime and TimeUtil:GetTime() < endTime then
					add = add + cfg.consumeReduce
				end
			elseif cfg.regressionType ~= nil then
				if isRegres then
					local arr = RegressionMgr:GetArr()
					if #arr > 0 then
						for k, m in ipairs(arr) do
							if m.type == RegressionActiveType.ConsumeReduce and m.activityId == cfg.id then
								add = add + cfg.consumeReduce
								regresAdd = regresAdd + cfg.consumeReduce			
							end
						end
					end
				end	
			end			
		end
	end
	return add,regresAdd
end

function this.IsEnough(cfg)
	local isEnough,str = false,""
	if cfg then
		local cost = DungeonUtil.GetCost(cfg)
		if cost then
			local cur = BagMgr:GetCount(cost[1])
			local need = cost[2]
			isEnough = cur >= need
			if not isEnough then
				local _cfg = Cfgs.ItemInfo:GetByID(cost[1])
				if _cfg and _cfg.name then
					str = LanguageMgr:GetTips(15000,_cfg.name)
				end
			end
		else
			local cur = PlayerClient:Hot()
			local need = math.abs(DungeonUtil.GetHot(cfg))
			isEnough = cur >= need
			if not isEnough then
				str = LanguageMgr:GetTips(8013)
			end
		end
	end
	return isEnough,str
end

return this; 