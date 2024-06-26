--编成数据管理
local this=MgrRegister("TeamMgr")
this.currentIndex = 1;--当前选中的队伍下标
this.fightingID = {};--战斗中的队伍ID列表[index]=IDArray,index：副本类型
this.presetNum = g_FormationDefaultNum;--预设队伍数量
this.fightingTeam = nil;--战斗中的队伍列表缓存
this.assistTeamIndex={};--用于存储助战卡牌上阵对应的队伍id

function this:Init()
	local options=FileUtil.LoadByPath("TeamViewSelected.txt")
	if options==nil then
		self.is3D=true;
	else
		self.is3D=options.is3D;
	end
end

--设置数据
function this:SetData(teamData)
	self.datas = {}; -- 单个数据字段[index]={teamName,leader,data},这是副本队伍数据队列
	self.forceDatas = {};--强制上阵数据
	-- self.cardIndex = nil;--队伍卡牌索引，包含了当前所有队伍中的卡牌[cid]=teamIndex
	if(teamData and teamData.data) then
		self.presetNum = teamData.count;
		for k, v in ipairs(teamData.data) do
			self:UpdateDataByIndex(v.index, v);
		end
	end

    EventMgr.Dispatch(EventType.Team_Data_Setted)--编队数据设置完成
end

--根据队伍索引和刷新数据 data:proto:TeamItemData
function this:UpdateDataByIndex(index, data)
	if(index and data) then
		local teamData = TeamData.New();
		--剔除不存在的卡牌
		for k,v in ipairs(data.data) do
			local card=FormationUtil.FindTeamCard(v.cid);
			if card==nil then
				data.data[k]=nil;
			end
		end
		teamData:SetData(data);
		self:SaveDataByIndex(index, teamData);
	end
end

--根据队伍索引和队伍数据进行更新 teamData:TeamData
function this:UpdateDataByTeamData(index, teamData)
	if(index and teamData) then
		self:SaveDataByIndex(index, teamData)
	end
end

function this:SaveDataByIndex(index, teamData)
	self.datas = self.datas or {};
	self.forceDatas = self.forceDatas or {};
	if(index >= eTeamType.ForceFight) then--强制上阵
		self.forceDatas[index] = teamData;
	else
		self.datas[index] = teamData;
	end
end

--改变缓存数据中对应队伍队员的AI策略下标 
function this:SaveItemStrategyIndex(teamIndex,cid,aIdx)
	if teamIndex and cid and aIdx then
		local teamData=nil;
		if(teamIndex >= eTeamType.ForceFight) then--强制上阵
			teamData=self.forceDatas[teamIndex];
		else
			teamData=self.datas[teamIndex];
		end
		if teamData and teamData:GetItem(cid) then
			teamData:GetItem(cid):SetStrategyIndex(aIdx);
		end
	end
end

--返回数据，字典型，[队伍索引]=队伍数据，不存在会返回一个空白站位的队伍数据 hasEditTeam:是否包含正在编辑中的队伍数据
function this:GetTeamData(index,hasEditTeam)
	if index == nil then
		index = self.currentIndex;
	elseif index < 0 then
		return nil;
	end
	if self.datas == nil then
		self.datas = {};
	end
	local team=nil;
	if hasEditTeam and self.editTeams and self.editTeams[index] then
		team=self.editTeams[index]
	elseif(index >= eTeamType.ForceFight) then
		team=self:GetForceTeam(index);
	else
		if self.datas[index]==nil then
			local tab = {};
			tab.teamName = FormationUtil.GetDefaultName(index);
			tab.leader = nil;
			tab.index = index;
			tab.data = {};
			tab.nReserveNP=0;
			tab.bIsReserveSP=false;
			tab.performance=0;
			self:UpdateDataByIndex(index, tab);
		end
		team=self.datas[index];
	end
	return team;
end

--根据队伍类型返回队伍集合
function this:GetTeamDatasByType(_eTeamType)
	if _eTeamType<eTeamType.ForceFight and self.datas then
		local teams={};
		for k,v in pairs(self.datas) do
			if _eTeamType==eTeamType.DungeonFight and k>=eTeamType.DungeonFight and k<=g_TeamMaxNum then
				table.insert(teams,v);
			elseif _eTeamType==eTeamType.Preset and k>=eTeamType.Preset then
				table.insert(teams,v);
			elseif _eTeamType==eTeamType.Tower and k==eTeamType.Tower then
				table.insert(teams,v);
			elseif _eTeamType==eTeamType.TowerDifficulty and k==eTeamType.TowerDifficulty then
				table.insert(teams,v);
			end
		end
		return teams;
	elseif _eTeamType>= eTeamType.ForceFight then
		return self.forceDatas;
	end
end

--是否在队伍里(不包括强制上阵和预设队伍) cid:要查找的卡牌id type:队伍类型，参考eTeamType
function this:CheckIsInTeam(cid,type)
	if self.datas then
		for k,v in pairs(self.datas) do
			if type then
				if v:GetItem(cid)~=nil and self:IsTeamType(type,v:GetIndex()) then
					return true;
				end
			elseif not self:IsTeamType(eTeamType.Preset,v:GetIndex()) then --剔除预设队伍的查询
				if v:GetItem(cid)~=nil then
					return true;
				end
			end
		end
	end
	return false
end

--判断队伍的类型
function this:IsTeamType(_eTeamType,_index)
	local isTrue=false;
	local index=_index or TeamMgr.currentIndex;
	local type=self:GetTeamType(index);
	return _eTeamType==type;
end

--- func 根据队伍索引返回队伍类型
---@param index int 队伍索引
function this:GetTeamType(index)
	local type=eTeamType.DungeonFight;
    if index >= eTeamType.DungeonFight and index <= g_FormationMaxNum then
		type=eTeamType.DungeonFight;
	elseif index == eTeamType.Assistance then
		type=eTeamType.Assistance;
	elseif index ==eTeamType.PracticeAttack then
		type=eTeamType.PracticeAttack;
	elseif index==eTeamType.PracticeDefine then
		type=eTeamType.PracticeDefine;
	elseif index==eTeamType.RealPracticeAttack then
		type=eTeamType.RealPracticeAttack;
	elseif index==eTeamType.GuildFight then
		type=eTeamType.GuildFight;
	elseif index >= eTeamType.Preset and index < 40 then
		type=eTeamType.Preset;
	elseif index==eTeamType.Tower then
		type=eTeamType.Tower;
	elseif index==eTeamType.TowerDifficulty then
		type=eTeamType.TowerDifficulty;
	elseif(index >= eTeamType.ForceFight) then--强制上阵
		type=eTeamType.ForceFight;
	end
	return type;
end

--返回队长数据
function this:GetLeader(index)
	if index == nil then
		index = self.currentIndex;
	end
	local teamData = self:GetTeamData(index);
	if teamData ~= nil then
		return teamData:GetLeader();
	end
	return nil;
end

--返回主线队伍的冷却状态
function this:GetDuplicateTeamCoolState()
	local dic={};
	local teams=self:GetTeamDatasByType(eTeamType.DungeonFight);
	if teams then
		for k,v in ipairs(teams) do
			dic[v:GetIndex()]=v:GetCoolState();
		end
	end
	return dic;
end

--判断是否是第一队的队长
function this:IsFirstTeamLeader(cid)
	if cid then
		local firstTeam=self:GetTeamData(1,true);
		return firstTeam:IsLeader(cid);
	end
end

--返回当前已解锁的预设队伍数量
function this:GetPresetNum()
	if self.datas == nil or self.presetNum == nil then
		return g_FormationDefaultNum;
	end
	return self.presetNum;
end

--返回队列中单个卡牌的数据 (只对常规副本队伍查询)
function this:GetTeamItemData(cid)
	local teams=self:GetTeamDatasByType(eTeamType.DungeonFight);
	if cid and teams then
		for k, v in ipairs(teams) do
			local card = v:GetItem(cid);
			if card then
				return card;
			end
		end
	end
	return nil;
end

--根据卡牌ID返回队列数据(只对常规副本队伍查询)
function this:GetTeamDataByCid(cid)
	local teams=self:GetTeamDatasByType(eTeamType.DungeonFight);
	if cid and teams then
		for k, v in ipairs(teams) do
			local card = v:GetItem(cid);
			if card then
				return v;
			end
		end
	end
	return nil;
end

--返回卡牌所属队伍索引(只对常规副本队伍查询)
function this:GetCardTeamIndex(cid,hasEdit)
	local teams=self:GetTeamDatasByType(eTeamType.DungeonFight);
	if cid and teams then
		for k, v in ipairs(teams) do
			if hasEdit then
				local card=nil;
				if self.editTeams and self.editTeams[v:GetIndex()] then
					card = self.editTeams[v:GetIndex()]:GetItem(cid);
				else
					card = v:GetItem(cid);
				end
				if card then
					return v:GetIndex();
				end
			else
				local card = v:GetItem(cid);
				if card then
					return v:GetIndex();
				end
			end
		end
	end
	return - 1;
end

--返回卡牌所属队伍索引（只对常规副本队伍和编辑中的队伍进行查询）
function this:GetCardTeamTempIndex(cid)
	local teams=self:GetTeamDatasByType(eTeamType.DungeonFight);
	if cid and teams then
		for k, v in ipairs(teams) do
			local card=nil;
			if self.editTeams and self.editTeams[v:GetIndex()] then
				card = self.editTeams[v:GetIndex()]:GetItem(cid);
			else
				card = v:GetItem(cid);
			end
			if card then
				return v:GetIndex();
			end
		end
	end
	return - 1;
end

--返回卡牌所属强制上阵队伍索引（只对强制上阵队伍查询）
function this:GetCardForceIndex(dungeonId,cid)
	if dungeonId and cid and self.forceDatas  then
		for i=1,2 do
			local teamID=tonumber((tostring(dungeonId)..i));
			local team=self:GetForceTeam(teamID);
			if team then
				local item=team:GetItem(cid);
				if item~=nil then
					return teamID;
				end
			end
		end
	end
	return -1;
end

--保存队伍内容
function this:SaveData(index, callBack)
	if index == nil then
		index = self.currentIndex;
	end
	--保存到本地
	local teamData = self:GetTeamData(index);
	if teamData ~= nil then
		PlayerProto:SaveTeam(teamData, callBack);
	end
end

-------------------------------------------------------强制上阵的队伍数据(保存在本地)
--获取强制上阵队伍数据
function this:GetForceTeam(index)
	self.forceDatas = self.forceDatas or {};
	if index ~= nil then
		if self.forceDatas[index] ~= nil then
			return self.forceDatas[index];
		else
			self.forceDatas = self.forceDatas or {};
			local data = FileUtil.LoadByPath(index .. ".txt");
			if data ~= nil then
				if data.data then
					for k,v in ipairs(data.data) do
						local card=FormationUtil.FindTeamCard(v.cid);
						if card==nil then
							LogError("读取强制上阵数据出错，已自动重置队伍数据");
							return nil
						end
					end
					local teamData = TeamData.New();
					teamData:SetData(data)
					self:SaveDataByIndex(index, teamData);
					return self.forceDatas[index];
				end
			end
		end
	end
	return nil;
end

--保存强制上阵的队伍数据
function this:SaveForceTeam(key)
	if key ~= nil and self.forceDatas and self.forceDatas[key] ~= nil then
		local teamData=self.forceDatas[key];
		if teamData:GetCount()>0 and teamData:HasLeader() then
			FileUtil.SaveToFile(key .. ".txt", self.forceDatas[key]:GetData());
		end
	end
end

-------------------------------------------------------end

--返回修改中的队伍数据(当前所选的队伍)
function this:GetEditTeam()
	local index=self.currentIndex;
	self.editTeams=self.editTeams or {}
	if index~=nil and index~=-1 and self.editTeams[index]==nil then
		local teamData=self:GetTeamData(index);
		if teamData then
			local editTeamsData=TeamData.New();
			local tempData = {};
			for k, v in ipairs(teamData.data) do
				local json=v:GetFormatData()
				--检查AI策略是否正确，不正确则修正
				local realAIIndex=FormationUtil.GetOrderByTeamIndex(index);--获取对应的AI预设ID
				if realAIIndex~=json.nStrategyIndex then
					json.nStrategyIndex=realAIIndex;
				end
				table.insert(tempData, json);
			end
			local data = {
				index = teamData.index,
				leader = teamData.leader,
				name = teamData.teamName,
				bIsReserveSP=teamData:GetIsReserveSP(),
				nReserveNP=teamData:GetReserveNP(),
				performance=teamData:GetPreformance(),
				skill_group_id=teamData.skillGroupID,
				data = tempData,
			};
			editTeamsData:SetData(data);
			self.editTeams[index]=editTeamsData;--设置一个编辑副本
		end
	end
	return self.editTeams[index] or nil;
end

--保存修改的队伍数据（副本队伍会同时修改影响到的队伍数据）,修改的队伍根据currentIndex获得
function this:SaveEditTeam(callBack)
	local index=self.currentIndex;
	if self.editTeams and self.editTeams[index] then
		saveIndex=nil;
		if (index >= eTeamType.DungeonFight and index <= g_FormationMaxNum) or (index >= eTeamType.ForceFight)then
			--剧情队伍/强制上阵队伍
			--判断当前队伍中的卡牌是否包含其他队伍的，有的话就将影响到的卡牌一起保存
			saveIndex=saveIndex or {};
			for key,val in ipairs(self.editTeams[index].data) do
				--检查AI策略是否正确，不正确则修正
				local realAIIndex=FormationUtil.GetOrderByTeamIndex(index);--获取对应的AI预设ID
				if realAIIndex~=val:GetStrategyIndex() then
					local teamItem=self.editTeams[index]:GetItem(val.cid);
					teamItem:SetStrategyIndex(realAIIndex);
				end
				local oldIndex=-1
				if index>= eTeamType.DungeonFight and index <= g_FormationMaxNum then --普通队伍
				 	oldIndex=self:GetCardTeamIndex(val.cid);
				elseif index >= eTeamType.ForceFight then --强制上阵队伍
					local dungeonId=tostring(index);
					dungeonId=tostring(string.sub(dungeonId,1,string.len(dungeonId)-1));
					oldIndex=self:GetCardForceIndex(dungeonId,val.cid);
				end
				--从旧队伍中移除卡牌
				if oldIndex~=-1 and oldIndex~=index then
					local teamData=self:GetTeamData(oldIndex);
					if teamData~=nil then
						local isLeader=teamData:IsLeader(val.cid);
						teamData:RemoveCard(val.cid);
						if isLeader==true and teamData:GetCount()>=1 then --涉及队长的话会默认设置第一的队员为新的队长
							teamData:SetLeader(teamData.data[1].cid);
						end
					else
						LogError("未找到旧队伍数据！！！");
					end
					local hasId=false;
					for k,v in ipairs(saveIndex) do --去除重复的队伍id
						if v==oldIndex then
							hasId=true;
							break;
						end
					end
					if hasId~=true then
						table.insert(saveIndex,oldIndex);
					end
				end
				if val:GetID()==0 then
					LogError("编队中存在卡牌ID为0的队员！")
					LogError(val);
				end
			end
			table.insert(saveIndex,index);
		else
			--其他队伍
			saveIndex={};
			for key,val in ipairs(self.editTeams[index].data) do
				--检查AI策略是否正确，不正确则修正
				local realAIIndex=FormationUtil.GetOrderByTeamIndex(index);--获取对应的AI预设ID
				if realAIIndex~=val:GetStrategyIndex() then
					local teamItem=self.editTeams[index]:GetItem(val.cid);
					teamItem:SetStrategyIndex(realAIIndex);
				end
			end
			table.insert(saveIndex,index);
		end
		--本地保存修改数据
		local assistCid=self.editTeams[index]:GetAssistID();
		if assistCid==nil then --不存在助战卡牌
			self:SaveDataByIndex(index, self.editTeams[index])
		else--有助战卡牌则去除助战卡牌
			self.editTeams[index]:RemoveCard(assistCid);
			self:SaveDataByIndex(index, self.editTeams[index])
		end
		self:DelEditTeam(index);
		if saveIndex then
			local teams={};
			for k,v in ipairs(saveIndex) do
				local func=k==#saveIndex and callBack or nil;
				if v == eTeamType.Assistance then
					self:SaveData(v,func);
				elseif(v >= eTeamType.ForceFight) then
					self:SaveForceTeam(v);
					if func~=nil then
						func();
					end
				else
					table.insert(teams,self:GetTeamData(v));
				end
			end
			if #teams>0 then
				PlayerProto:SaveTeamList(teams,callBack);
			end
			saveIndex=nil;
		end
	elseif callBack then
		callBack();
	end
end

--删除修改的队伍数据
function this:DelEditTeam(index)
	if index and self.editTeams then
		self.editTeams[index]=nil;
	else
		self.editTeams=nil;
	end
end

--------------------------------战斗中的队伍相关
--==============================--
--desc:更新战斗中的队伍ID
--time:2019-04-28 06:13:12
--@index:战斗类型
--@array:队伍ID列表
--@return 
--==============================--
function this:UpdateFightID(index, array)
	if index and array then
		self.fightingID[index] = array;
	end
end

--清空战斗ID
function this:ClearFightID()
	self.fightingID = {};
end

--判断卡牌是否在副本战斗中
function this:GetCardIsDuplicate(cid)
	local isFight = false;
	if cid then
		if self.fightingTeam then
			for k, v in ipairs(self.fightingTeam) do
				local item = v:GetItem(cid);
				if item ~= nil then
					isFight = true;
					break;
				end
			end
		elseif self.fightingID and self.fightingID[1] then
			for k,v in ipairs(self.fightingID[1]) do
				local teamData=self:GetTeamData(v);
				if teamData and teamData:GetItem(cid) then
					isFight=true;
					break;
				end
			end
		end
	end
	return isFight;
end

--判断队伍是否在副本战斗中
function this:GetTeamIsFight(index)
	local isFight = false;
	if index and self.fightingID and self.fightingID[1] then
		for _, v in ipairs(self.fightingID[1]) do
			if v == index then
				isFight = true;
				break;
			end
		end
	end
	return isFight;
end


--返回参战中的队伍列表
function this:GetFightTeam()
	return self.fightingTeam;
end

--返回缓存中的队伍数据
function this:GetFightTeamData(index)
	-- Log( "战斗中的队伍id:" .. tostring(index));
	if self.fightingTeam then
		for k, v in ipairs(self.fightingTeam) do
			if v.index == index then
				return v;
			end
		end
	end
	return nil;
end

--更新战斗中的队伍数据
function this:UpdateFightTeamData(sDuplicateCharData)
	if sDuplicateCharData then
		local posData = {};
		local fuid = nil;
		local leaderID = nil;
		-- Log( "战斗中的队伍数据：");
		-- LogError(sDuplicateCharData.team)
		for k, v in ipairs(sDuplicateCharData.team) do
			local item = {
				cid = v.cid,
				row = v.row,
				col = v.col,
				fuid = v.fuid,
				index = v.index,
				isLeader=v.isLeader,
				nStrategyIndex=v.nStrategyIndex,
			};
			if v.fuid then
				item.cid = FormationUtil.FormatAssitID(v.fuid, v.cid);
				fuid = v.fuid;
			elseif v.npcid then
				item.bIsNpc = true;
				item.cid=FormationUtil.FormatNPCID(v.cid);
			end
			if v.aiSetting then --只有NPC或者助战卡才会返回AI预设
				AIStrategyMgr:SetAssistAIPrefs(item.cid,sDuplicateCharData.nTeamID,v.aiSetting);
			end
			if v.isLeader or v.index==1 then
				leaderID = v.npcid~=nil and FormationUtil.FormatNPCID(v.cid) or v.cid;
			end
			table.insert(posData, item);
		end
		local currTeam = self:GetTeamData(sDuplicateCharData.nTeamID);
		local teamData = {
			index = sDuplicateCharData.nTeamID,
			leader = leaderID,
			name = currTeam == nil and FormationUtil.GetDefaultName(sDuplicateCharData.nTeamID) or currTeam.teamName,
			data = posData,
			nReserveNP=sDuplicateCharData.nReserveNP == nil and 0 or sDuplicateCharData.nReserveNP,
			bIsReserveSP=sDuplicateCharData.bIsReserveSP == nil and false or sDuplicateCharData.bIsReserveSP,
			performance=currTeam == nil and 0 or currTeam:GetPreformance(),
		};
		local team = TeamData.New();
		team:SetData(teamData);
		if sDuplicateCharData.friend then
			local assistData = {
				uid = fuid,
				teamIndex = team:GetIndex(),
				card = sDuplicateCharData.friend,
				index=1,
			};
			FriendMgr:AddAssistData(assistData);
		end
		self:AddFightTeamData(team);
		UIUtil:AddFightTeamState(1,"TeamMgr:UpdateFightTeamData()")
	end
end

--返回战斗协议所需要的队伍数据格式
function this:DuplicateTeamData(index,teamData)
	local list = {}
    if index==nil or teamData==nil or teamData:GetRealCount()==0 then
        return nil;
    end
    local assistID=teamData:GetAssistID();
	local assistCard=nil;
	if assistID then
		assistCard=FormationUtil.FindTeamCard(assistID);
	end
    for k, v in ipairs(teamData.data) do
        local item = {cid = v.cid, row = v.row, col = v.col}
        if assistID~=nil and v.cid == assistID then
            local ids=StringUtil:split(v.cid, "_");
            item.cid = tonumber(ids[2])
            if v.bIsNpc then
                item.id=v:GetCfgID();
                item.npcid=v.bIsNpc and v:GetCfgID() or nil;
                item.bIsNpc=true;
                item.index=6;
			elseif assistCard then
                item.fuid =tonumber(ids[1])
                item.id=assistCard:GetCfgID();
                item.index=6;
            end
			--助战卡需要带上AI数据
			local aiPrefs=AIStrategyMgr:GetAssistAIPrefs(v.cid,teamData:GetIndex(),1);
			if aiPrefs then
				item.aiSetting=aiPrefs:GetStrategyData();
			end
        else
            local cardData=FormationUtil.FindTeamCard(v.cid);
            item.id=cardData:GetCfgID();
            item.index=v.index;
        end
		item.nStrategyIndex=v:GetStrategyIndex();
        table.insert(list, item)
    end
    if list and #list>6 then
        LogError("队伍数据有误！");
        LogError(teamData:GetData());
        return
    end
	-- local config=self:LoadStrategyConfig();
	local bIsReserveSP=teamData:GetIsReserveSP();
	local nReserveNP=teamData:GetReserveNP();
	-- local target=nil;
	-- if config then
	-- 	bIsReserveSP=config[string.format("team%sSP",index)]
	-- 	nReserveNP=config[string.format("team%sNP",index)]
	-- 	-- target=config.target;
	-- end
    local duplicateTeamData = {nTeamIndex = teamData.index, team = list,nSkillGroup=teamData.skillGroupID,bIsReserveSP=bIsReserveSP,nReserveNP=nReserveNP}
    return duplicateTeamData;
end

--返回自动战斗再次出击时所需的队伍信息
function this:GetAutoDuplicateTeamData()
    local duplicateTeamData = {}
	if self.fightingTeam then
		for k,v in ipairs(self.fightingTeam) do
			local assistID=v:GetAssistID(); --再次出击移除助战卡
			if assistID then
				v:RemoveCard(assistID);
			end
			table.insert(duplicateTeamData,self:DuplicateTeamData(k,v));
		end
	end
    return duplicateTeamData;
end

--重连的时候根据战斗数据重新缓存战斗队伍数据
function this:ResetFightTeam(data)
	--获取助战卡牌数据
	local currTeam=self:GetTeamData(data.nTeamIndex);
	local fuid=nil;
	local assistCid=nil;
	local assistItem=nil;
	for k,val in ipairs(data.data.data) do
		if currTeam:GetItem(val.data.cuid)==nil and val.data.npcid~=nil then--当前队伍未找到的NPC卡暂时判定为助战NPC卡
			assistItem={
				cid=FormationUtil.FormatNPCID(val.data.cuid),
				row=val.data.row,
				col=val.data.col,
				fuid=fuid,
				index=6,
				bIsNpc=true,
				isForce=false,
			}
			break;
		elseif val.data.fuid~=nil then --获取助战卡牌数据
			fuid=val.data.fuid;
			assistCid=val.data.cuid;
			assistItem={
				cid=FormationUtil.FormatAssitID(fuid,assistCid),
				row=val.data.row,
				col=val.data.col,
				fuid=fuid,
				index=6,
				bIsNpc=false,
				isForce=false,
			}
			break;
		end
	end
	local tempData = {};
	for k, v in ipairs(currTeam.data) do
		table.insert(tempData, v:GetFormatData());
	end
	if assistItem~=nil then
		table.insert(tempData,assistItem);
	end
	if fuid~=nil and assistCid~=nil then
		--获取助战卡牌数据
		FriendMgr:SetAssistInfos(fuid,{assistCid},function(proto)
			if proto and proto.cards then
				local assistData = {
					uid = fuid,
					teamIndex = currTeam:GetIndex(),
					card = proto.cards[1],
					index=1,
				};
				-- LogError(proto.cards[1])
				FriendMgr:AddAssistData(assistData);
			end
			local data = {
				index = currTeam.index,
				leader = currTeam.leader,
				name = currTeam.teamName,
				skill_group_id=currTeam.skillGroupID,
				data = tempData,
				nReserveNP=currTeam:GetReserveNP(),
				bIsReserveSP=currTeam:GetIsReserveSP(),
				performance=currTeam:GetPreformance(),
			};
			local fightTeam=TeamData.New();
			fightTeam:SetData(data);
			self:AddFightTeamData(fightTeam);
			UIUtil:AddFightTeamState(1,"TeamMgr:ResetFightTeam()  Step1")
		end);
		-- FriendProto:GetAssitInfo(fuid,function(proto)
		-- 		for k,v in ipairs(proto.assits) do
		-- 			for _,card in ipairs(v.cards) do
		-- 				local cardData = Cfgs.CardData:GetByID(card.cfgid)
		-- 				if cardData ~= nil then
		-- 					FriendMgr:AddAssistData(
		-- 					{
		-- 						uid = v.uid,
		-- 						name = v.name,
		-- 						alias = v.alias,
		-- 						modelId = v.icon_id,
		-- 						lv = v.level,
		-- 						index=1,
		-- 						card = card,
		-- 						teamIndex = v.cid==assistCid and currTeam:GetIndex() or nil,
		-- 					});
		-- 				end
		-- 			end
		-- 		end
		-- end);
	else
		local data = {
			index = currTeam.index,
			leader = currTeam.leader,
			name = currTeam.teamName,
			skill_group_id=currTeam.skillGroupID,
			data = tempData,
			nReserveNP=currTeam:GetReserveNP(),
			bIsReserveSP=currTeam:GetIsReserveSP(),
			performance=currTeam:GetPreformance(),
		};
		local fightTeam=TeamData.New();
		fightTeam:SetData(data);
		self:AddFightTeamData(fightTeam);
		UIUtil:AddFightTeamState(1,"TeamMgr:ResetFightTeam()  Step2")
	end
end

--添加战斗中的队伍数据
function this:AddFightTeamData(teamData)
	if self.fightingTeam == nil then
		self.fightingTeam = {};
	else
		self:RemoveFightTeamData(teamData.index);
	end
	table.insert(self.fightingTeam, teamData);
end

function this:ClearFightTeamData()
	self.fightingTeam = nil;
end

--删除战斗中的队伍数据
function this:RemoveFightTeamData(index)
	if self.fightingTeam then
		local idx = 0;
		for k, v in ipairs(self.fightingTeam) do
			if v.index == index then
				idx = k;
				break;
			end
		end
		if idx ~= 0 then
			table.remove(self.fightingTeam, idx);
		end
	end
end

--队伍卡牌
function this:GetTeamCardDatas(index)
	local teamDatas = self:GetTeamData(index)
	local list = teamDatas and teamDatas.data or {}
	local cards = {}
	for i,v in ipairs(list) do
	   table.insert(cards, v:GetCard())
	end
	return cards 
end

-------------------------------------------------------end
-------------------------------------------------------助战卡牌对应队伍数据-----------------
function this:AddAssistTeamIndex(cid, index)
	if cid and self.assistTeamIndex then
		-- local key=nil;
		-- for k,v in pairs(self.assistTeamIndex) do--删除重复的助战卡
		-- 	if v==index then
		-- 		key=k;
		-- 		break;
		-- 	end
		-- end
		-- self.assistTeamIndex[key]=nil;
		self.assistTeamIndex[cid] = index
	end
end

function this:RemoveAssistTeamIndex(cid)
	if cid and self.assistTeamIndex and self.assistTeamIndex[cid] then
		self.assistTeamIndex[cid] = nil
	end
end

function this:GetAssistCID(index)
	if index and self.assistTeamIndex then
		for k,v in pairs(self.assistTeamIndex) do
			if v==index then
				return k;
			end
		end
	end
end

function this:GetAssistTeamIndex(cid)
	if cid and self.assistTeamIndex and self.assistTeamIndex[cid] then
		return self.assistTeamIndex[cid];
	end
end

function this:GetAssistCids()
	local list=nil;
	if self.assistTeamIndex then
		list={}
		for k,v in pairs(self.assistTeamIndex) do--删除重复的助战卡
			table.insert(list,k);
		end
	end
	return list;
end

function this:ClearAssistTeamIndex()
	self.assistTeamIndex={};
end
-------------------------------------------------------end

function this:SaveStrategyConfig(tab)
	if tab then
		FileUtil.SaveToFile("Strategy.txt", tab);
	end
end

function this:LoadStrategyConfig()
	local tab=FileUtil.LoadByPath("Strategy.txt");
	if tab==nil then
		tab={
			team1NP=0,
			team2NP=0,
			target=1,
			team1SP=false,
			team2SP=false;
		}
	end
	return tab
end

--设置编队界面的选项缓存
function this:SetTeamViewOptions(_isAddtive1,_isAddtive2)
	self.isAddtive1 = _isAddtive1==true and 1 or 0
	self.isAddtive2=_isAddtive2==true and 1 or 0
	FileUtil.SaveToFile("TeamViewCheckBox.txt", {isAddtive1 = self.isAddtive1,isAddtive2=self.isAddtive2})
end

--返回编队界面的选项缓存
function this:GetTeamViewOptions()
	if self.isAddtive1~=nil or self.isAddtive2~=nil then
		return self.isAddtive1==1,self.isAddtive2==1;
	else
		local tab=FileUtil.LoadByPath("TeamViewCheckBox.txt");
		if tab then
			self.isAddtive1 =tab.isAddtive1;
			self.isAddtive2=tab.isAddtive2;
		else
			self.isAddtive1 =0;
			self.isAddtive2=0;
		end
		return self.isAddtive1==1,self.isAddtive2==1;
	end
end

--编队视图缓存
function this:SetViewerOption(is3D)
	self.is3D=is3D;
end

function this:GetViewerOption()
	return self.is3D;
end

function this:SaveViewerOption(is3D)
	self:SetViewerOption(is3D)
	FileUtil.SaveToFile("TeamViewSelected.txt",{is3D=self:GetViewerOption()})
end

function this:Clear()
	self.isAddtive1 = nil
	self.isAddtive2=nil
	self.editTeams=nil;
	self.currentIndex = 1;--当前选中的队伍下标
	self.fightingID = {};--战斗中的队伍ID列表[index]=IDArray,index：副本类型
	self.presetNum = g_FormationDefaultNum;--预设队伍数量
	self.fightingTeam = nil;--战斗中的队伍列表缓存
	self.forceDatas = {};
	self.datas =  {};
	self.assistTeamIndex={};
	self.assistDatas=nil;
	self.is3D=false;
end

return this; 