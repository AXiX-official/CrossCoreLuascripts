-- OPENDEBUG()
-- 单机战斗
------------------------------------------------------------------
-- 单机服务端功能
SingleFightMgrServer = oo.class(FightMgrServer)
function SingleFightMgrServer:Init(...)
	FightMgrServer.Init(self, ...)
	self.nKillMonster = 0
	self.isServerMgr = true
end

-- 广播消息
function SingleFightMgrServer:Broadcast(cmd, msg)
	-- 模拟客户端收到信息
	CallRecv(cmd, msg);
end

function SingleFightMgrServer:Send(uid, cmd, msg)
	CallRecv(cmd, msg);
end

function SingleFightMgrServer:OnDeath(card, killer)
	FightMgrBase.OnDeath(self, card, killer)

	if card:GetTeamID() == 2 then
		self.nKillMonster = self.nKillMonster + 1
		-- self.oDuplicate.oPlayer:UpdateTask(eTaskFinishType.Fight, eTaskEventType.KillMonster, self.oDuplicate)
		-- self.oDuplicate.oPlayer.oDuplicateDBMgr:UpdateStat(self.nDuplicateID, eDuplicateStarType.Monster, 1)
	end
end

-- 结束
function SingleFightMgrServer:Over(stage, winer)
	LogDebugEx("SingleFightMgrServer:Over", self.type, self.nDuplicateID, winer)
	self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})

	PVEFightMgrServer.Over(self, stage, winer)
	local data = {}
	local deathcount = 0
	local grade = {0, 0, 0} -- 评级
	local nMinHpPercent = 1
	local cardCnt = self.arrTeam[1].nCardCount

	if winer == 1 then
		grade[1] = 1
		for i, v in ipairs(self.arrCard) do
			-- 合体, 召唤
				--print("card", v.oid, v.name, v.hp, v.fuid, v.cuid ,v.npcid)
			if v:GetTeamID() == 1 and v:IsCard() then
				if v.fuid then
					data[0] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
				elseif v.npcid then
					data[v.npcid] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
				else
					data[v.cuid] = {hp = math.floor(v.hp), maxhp = v.maxhp, sp = v.sp}
				end

				if nMinHpPercent > v.hp/v.maxhp then 
					nMinHpPercent = v.hp/v.maxhp
				end

				if math.floor(v.hp) <= 0 then
					deathcount = deathcount + 1
					nMinHpPercent = 0
				end
			end
		end

		if deathcount == 0 then
			grade[2] = 1
		end

		if self.nStep <= g_FightGradeStep then
			grade[3] = 1
		end
	else
		nMinHpPercent = 0
	end

	-- 发送给服务器记录
	local sendData = {
		winer         = winer, 
		data          = data, 
		myOID         = self.myOID, 
		monsterOID    = self.monsterOID, 
		nGrade        = grade,
		exdata        = {
			turnNum       = self.nStepPVE or self.nStep,
			deathCnt      = deathcount,
			cardCnt       = cardCnt,
			nMinHpPercent = math.floor(nMinHpPercent*100),			
		}
	}
	LogTable(sendData, "sendData = ")

	local nKillMonster = self.nKillMonster
	if nKillMonster > 0 then
		sendData.nKillMonster = self.nKillMonster
	end

	if self.tSetSkillAI then
		-- 切换过的技能
		local tSetSkillAI = {}
		for k,v in pairs(self.tSetSkillAI) do
			table.insert(tSetSkillAI, v)
		end
		sendData.tSetSkillAI = tSetSkillAI
	end

	LogTable(sendData,"FightProtocol:OnFightOver")
	-- ASSERT()
	local proto = {"FightProtocol:OnFightOver", sendData}
	local curNet = ExerciseMgr:GetCurNet()
	if not curNet then ASSERT() end
	curNet:Send(proto)
	-- self.oDuplicate:OnFightOver()
end

function SingleFightMgrServer:Destroy()
	LogDebug("SingleFightMgrServer:Destroy")
	g_FightMgrServer = nil
end

function SingleFightMgrServer:OnStart(data)
	if self.isStart then return end
	self:AddCmd(CMD_TYPE.Start, {})
	FightMgrBase.OnStart(self, data)
end

-- 设置使用技能AI策略
-- function SingleFightMgrServer:SetSkillAI(uid, data)
-- 	FightMgrBase.SetSkillAI(self, uid, data)
-- 	self.tSetSkillAI = self.tSetSkillAI or {}

-- 	local old = self.tSetSkillAI[data.id]
-- 	if old then
-- 		-- 已有记录, 就是要还原到原来的样子, 所以不存
-- 		self.tSetSkillAI[data.id] = nil
-- 	else

-- 		local card = self:GetCardByOID(data.id)

-- 		self.tSetSkillAI[data.id] = 
-- 			{
-- 				cuid  = card.cuid,
-- 				fuid  = card.fuid,
-- 				npcid = card.npcid,
-- 				myOID = self.myOID,
-- 				isUseCommon = data.isUseCommon
-- 			}
-- 	end

-- 	if table.empty(self.tSetSkillAI) then
-- 		self.tSetSkillAI = nil
-- 	end
-- end

-- 加载怪物组(我方阵型)
function SingleFightMgrServer:MakeFightDataFromGroup(groupID, cid, model)
-- ["data"]:
-- {
--     ["data"]:
--     {
--         [1]:
--         {
--             ["cid"]:70130,
--             ["uid"]:1,
--             ["col"]:1,
--             ["row"]:1
--             ["data"]:
--             {
--                 ["skills"]:
--                 {
--                     [1]:4701301,
--                     [2]:701300101,
--                     [3]:701300201,
--                     [4]:701300301
--                 },
--                 ["cuid"]:12,
--                 ["attack"]:155,
--                 ["col"]:1,
--                 ["crit_rate"]:0.0108,
--                 ["np"]:0,
--                 ["resist"]:0.0,
--                 ["crit"]:1.5,
--                 ["id"]:70130,
--                 ["hit"]:0.0,
--                 ["row"]:1,
--                 ["maxhp"]:1753,
--                 ["hp"]:1753,
--                 ["model"]:7013001,
--                 ["speed"]:114,
--                 ["defense"]:101,
--                 ["sp_race2"]:10.0,
--                 ["sp"]:10,
--                 ["sp_race"]:5.0,
--                 ["level"]:1,
--                 ["name"]:"赫拉",
--                 ["break_level"]:1,
--                 ["intensify_level"]:1
--             },
--         },
--     }
-- },

	local data = {}
	local config = MonsterGroup[groupID]
	ASSERT(config)
	-- DT(config, "Team:LoadConfig")
	local stageconfig = config.stage[1]
	ASSERT(stageconfig)

	local formation = MonsterFormation[stageconfig.formation]
	ASSERT(formation)

	for i, pos in ipairs(formation.coordinate) do
		local monsterID = stageconfig.monsters[i]
		if monsterID and monsterID ~= 0 then
			-- self:AddCard(pos[1], pos[2], monsterID)
			local carddata = {cid = monsterID, uid = PlayerClient:GetID(), row = pos[1], col = pos[2]}
			carddata.data = {}
			local monsterconfig = MonsterData[monsterID]
			ASSERT(monsterconfig)

			for k,v in pairs(AttrTable) do
				carddata.data[v] = monsterconfig[v]
			end
			carddata.data.hp              = monsterconfig.maxhp
			carddata.data.skills          = monsterconfig.skills
			carddata.data.cuid            = -i
			carddata.data.row             = pos[1]
			carddata.data.col             = pos[2]
			carddata.data.np              = monsterconfig.np
			carddata.data.id              = monsterID
			carddata.data.model           = monsterconfig.model
			carddata.data.name            = monsterconfig.name
			carddata.data.break_level     = 1
			carddata.data.intensify_level = 1

			-- 修改试玩模型
			if monsterID == cid and model then
				carddata.data.model = model
			end

			table.insert(data, carddata)
		end
	end

	return {data = data}
end

------------------------------------------------------------------
-- 单机客户端功能
SingleFightMgrClient = oo.class(FightMgrClient)
function SingleFightMgrClient:Init(...)
	FightMgrClient.Init(self, ...)
	self.name = "SingleFightMgrClient"
	self.uid = PlayerClient:GetID()
end

function SingleFightMgrClient:SendCmd(cmd, data)
	if not g_FightMgrServer then return end
	LogTable(data, "cmd"..cmd)
	local index = #self.cmds + 1
	local cmddata = {}
	cmddata["data" .. cmd] = data
	local proto = {"FightProtocol:RecvCmd", {index, cmd, cmddata}}
	DebugLog("发送命令：", "ff9977")
	LogTable(proto, "SendCmd")

	local d = {index, cmd, data}
	d.uid = self.uid
	data.uid = self.uid
	LogTable(d, "FightMgrServer RecvCmd=")
	ret = g_FightMgrServer:RecvCmd(d)
end

function SingleFightMgrClient:SendAuto()
	if not g_FightMgrServer then return end
	if not self.currTurn or self.currTurn.uid ~= self.uid then
		return
	end

	-- local proto = {"FightProtocol:AutoFight", {id = self.currTurn.oid}}
	g_FightMgrServer:AutoFight(self.uid, {id = self.currTurn.oid})
end

function SingleFightMgrClient:SetFocusFire(id)
	if not g_FightMgrServer then return end
	-- local proto = {"FightProtocol:SetFocusFire", {nFocusFireID = id}}
	g_FightMgrServer:SetFocusFire(self.uid, {nFocusFireID = id})
end

-- function SingleFightMgrClient:SetSkillAI(id, isUseCommon)
-- 	if not g_FightMgrServer then return end
-- 	-- local proto = {"FightProtocol:SetSkillAI", {id = id, isUseCommon = isUseCommon}}
-- 	g_FightMgrServer:SetSkillAI(self.uid, {id = id, isUseCommon = isUseCommon})
-- end

function SingleFightMgrClient:Quit()
	if not g_FightMgrServer then return end
	local proto = {"FightProtocol:Quit", {}}
	g_FightMgrServer:Quit(self.uid)
end

function SingleFightMgrClient:ForceQuit()
	if not g_FightMgrServer then return end
	g_FightMgrServer:Over(self.stage, 2)
end

------------------------------------------------------------------
-- 创建一个副本单机战斗
function CreateDuplicateSingleFight(proto)

	local groupID, nDuplicateID, tData, exData = proto.groupID, proto.nDuplicateID, proto.data, proto.exData

	CURRENT_TIME=TimeUtil:GetTime()

	local fid = UID(10)
	local seed = math.random(os.time())
	local mgr = SingleFightMgrServer(fid, groupID, SceneType.SinglePVE, seed, nDuplicateID)
	g_FightMgrServer = mgr

	mgr.myOID      = proto.myOID
	mgr.monsterOID = proto.monsterOID

	LogTable(tData)
	mgr:AddPlayer(PlayerClient:GetID(), 1)
	mgr:LoadConfig(groupID, 1)
	mgr:LoadData(1, tData.data, nil, tData.tCommanderSkill)
	mgr:AfterLoadData(exData)
	if table.empty(exData) then
		exData = nil
	end

	mgr:AddCmd(
		CMD_TYPE.InitData,
		{
			seed = seed,
			stype = SceneType.SinglePVE,
			groupID = groupID,
			teamID = 1,
			data = tData,
			exData = exData,
			nTeamIndex = proto.nTeamIndex
		}
	)
end
-- ------------------------------------------------------------------
-- -- 创建一个单机纯战斗
-- function CreateSingleFight(id, groupID, nDuplicateID, tData, exData)

-- 	local fid = UID(10)
-- 	local seed = math.random(os.time())
-- 	local mgr = SingleFightMgrServer(fid, groupID, SceneType.SinglePVE, seed, nDuplicateID)
-- 	g_FightMgrServer = mgr

-- 	-- mgr.nTeamIndex = nTeamIndex
-- 	-- mgr.oDuplicate = oDuplicate

-- 	mgr:AddPlayer(PlayerClient:GetID(), 1)
-- 	mgr:LoadConfig(groupID, 1)
-- 	mgr:LoadData(1, data.data, nil, data.tCommanderSkill)
-- 	mgr:AfterLoadData(exData)
-- 	if table.empty(exData) then
-- 		exData = nil
-- 	end

-- 	mgr:AddCmd(
-- 		CMD_TYPE.InitData,
-- 		{
-- 			seed = seed,
-- 			stype = SceneType.SinglePVE,
-- 			groupID = groupID,
-- 			teamID = 1,
-- 			data = data,
-- 			exData = exData
-- 		}
-- 	)
-- end

------------------------------------------------------------------
-- 创建一个单机模拟战斗(开场用)
function CreateSimulateFight(groupID, groupID2, cbOver, seed, cid, model)

	LogDebugEx("CreateSimulateFight",groupID, groupID2, seed)
	local fid = UID(10)
	local seed = seed or 1 -- 结果必然确定
	local mgr = SingleFightMgrServer(fid, groupID2, SceneType.SinglePVE, seed, 0)
	g_FightMgrServer = mgr

	local data = mgr:MakeFightDataFromGroup(groupID, cid, model)
	LogTable(data, "MakeFightDataFromGroup")

	mgr:AddPlayer(PlayerClient:GetID(), 1)
	mgr:LoadConfig(groupID2, 1)
	mgr:LoadData(1, data.data, nil, nil)
	mgr:AfterLoadData({})

	mgr.Over = function(self, stage, winer)
		LogDebugEx("CreateSimulateFight:Over", self.type, self.nDuplicateID, winer)
		self:AddCmd(CMD_TYPE.End, {stage = stage, winer = winer})
		if cbOver then
			cbOver(stage, winer)
		end
		-- g_FightMgrServer = nil
		FightMgrBase.Over(self, stage, winer)
	end

	mgr:AddCmd(
		CMD_TYPE.InitData,
		{
			seed = seed,
			stype = SceneType.SinglePVE,
			groupID = groupID2,
			teamID = 1,
			data = data,
			exData = {}
		}
	)
	-- ASSERT()
	return mgr
end

-- 训练(试玩)  可选参数[cid, model] 需要修改模型的角色id和模型
function CreateDirllFight(groupID, groupID2, cbOver, cid, model)
	-- LogDebugEx("CreateDirllFight",groupID, groupID2, os.time())
	return CreateSimulateFight(groupID, groupID2, cbOver, os.time(), cid, model)
end


-- ------------------------------------------------------------------
-- -- 创建一个世界boss战斗
-- function CreateBossFight(proto)

-- 	local groupID, nDuplicateID, tData, exData = proto.groupID, proto.nDuplicateID, proto.data, proto.exData

-- 	CURRENT_TIME=TimeUtil:GetTime()

-- 	local fid = UID(10)
-- 	local seed = math.random(os.time())
-- 	local mgr = SingleFightMgrServer(fid, groupID, SceneType.BOSS, seed, nDuplicateID)
-- 	g_FightMgrServer = mgr

-- 	-- LogTable(tData)
-- 	mgr:AddPlayer(PlayerClient:GetID(), 1)
-- 	mgr:LoadConfig(groupID, 1)
-- 	mgr:LoadData(1, tData.data, nil, tData.tCommanderSkill)
-- 	mgr:AfterLoadData(exData)
-- 	if table.empty(exData) then
-- 		exData = nil
-- 	end

-- 	mgr:AddCmd(
-- 		CMD_TYPE.InitData,
-- 		{
-- 			seed = seed,
-- 			stype = SceneType.BOSS,
-- 			groupID = groupID,
-- 			teamID = 1,
-- 			data = tData,
-- 			exData = exData
-- 		}
-- 	)
-- end
------------------------------------------------------------------
local cbFightMgrTimer = 
function ( msg, ... )
	LogInfo("----------------------------------------")
	LogInfo("LUA ERROR: " .. tostring(msg) .. "\n")
	LogInfo(debug.traceback())
	LogInfo("----------------------------------------")
	ASSERT()
end

function FightMgrTimer()
--	-- LogDebug("FightMgrTimeout")
--	FuncUtil:Call(FightMgrTimeout,nil,1000);

	CURRENT_TIME=TimeUtil:GetTime()

	if g_FightMgrServer then
		-- local ret, err = pcall(g_FightMgrServer.OnTimer, g_FightMgrServer)
		-- -- g_FightMgrServer:OnTimer()
		-- if err then
		-- 	LogError(err)
		-- 	ASSERT()
		-- end
		xpcall(g_FightMgrServer.OnTimer, cbFightMgrTimer, g_FightMgrServer)
	end
end

--FightMgrTimeout()
-- function SingleFightMgrClient:RestoreFight()
-- 	local proto = {"FightProtocol:RestoreFight", {nCmdIndex = #self.cmds}}
-- end

-- -- 接收命令
-- function SingleFightMgrClient:RecvCmd(cmd)
-- 	DebugLog("收到命令：", "ff9977")
-- 	LogDebug(cmd, "ff9977 cmd =")
-- 	local ret = FightMgrBase.RecvCmd(self, cmd)
-- 	if not ret then
-- 		LogDebugEx("FightMgrClient:RecvCmd", cmd[1])
-- 		ASSERT()
-- 		return
-- 	end

-- 	-- local ty = cmd[2]
-- 	-- local data = cmd[3]
-- 	-- self:AddCmd(ty, data)
-- 	return true
-- end

-- -- 执行角色切换
-- function FightMgrClient:DoTurn(data)
-- 	LogDebug("CMD_TYPE.Turn ---------" .. data.id)
-- 	FightActionMgr:PushSkill(self.log:GetAndClean())

-- 	self:OnRoundOver()

-- 	local card = self:GetCardByOID(data.id)
-- 	local t, card2 = self:CalcNext()
-- 	LogDebugEx(card.name .. "\t" .. card2.name)
-- 	LogDebugEx(card.oid .. "\t" .. card2.oid)

-- 	if card == card2 then
-- 		self:AddAllTime(t, card)
-- 		self.turnNum = self.turnNum + 1
-- 		self.currTurn = card
-- 		self.waitForDoSkill = card.oid

-- 		local str = "第" .. self.turnNum .. "回合\n"
-- 		self:PrintCardInfo(str)
		
-- 		card.tmpPrintLog = {}
-- 		table.insert(card.tmpPrintLog, "第" .. self.turnNum .. "回合")
-- 		LogTable(card.tmpPrintLog)

-- 		LogDebug("##############玩家行动#################" .. card.name)
-- 		-- 处理buffer行动前
-- 		-- local log = {api="OnRoundBegin"}
-- 		-- self.log:Add(log)
-- 		-- self.log:StartSub("datas")
-- 		self:DoEventWithLog("OnRoundBegin", card)
-- 		-- self.log:EndSub("datas")
-- 		FightActionMgr:PushSkill(self.log:GetAndClean())
-- 		if not card:IsLive() then
-- 			-- 已经死亡
-- 			LogDebugEx("card is death", card.name)
-- 			self:UpdateProgress(nil, card, false)
-- 			return
-- 		end

-- 		-- 控制类buffer处理
-- 		local isMotionless = card.bufferMgr:IsMotionless()
-- 		if isMotionless then
-- 			LogDebug("-------此处无法行动-------" .. card.name)
-- 		end

-- 		local log = {api = "OnTurn", isMotionless = isMotionless}
-- 		self.log:Add(log)
-- 		self.log:StartSub("datas")
-- 		card:OnTurn(isMotionless)
-- 		self:UpdateProgress(nil, card, false)
-- 		self.log:EndSub("datas")

-- 		-- 显示
-- 		log.id = card.oid
-- 		local ty = card:GetType()
-- 		if ty ~= CardType.Monster and ty ~= CardType.Boss and ty ~= CardType.Mirror then
-- 			log.skillDatas = card.skillMgr:GetClientSkillInfo()
-- 			log.canOverLoad = card.skillMgr:CanOverLoad()

-- 			-- 指挥官技能
-- 			log.tCommanderSkill = self:GetCommanderSkill(card)
-- 		end
-- 		FightActionMgr:PushSkill(self.log:GetAndClean())
-- 	else
-- 		LogError("数据不一致")
-- 		LogDebug("card ~= card2")
-- 		LogDebugEx(card.name .. "\t" .. card2.name)
-- 		ASSERT("card ~= card2")
-- 	end
-- end

-- function FightMgrBase:RecvCmd(cmd)

-- 	if ty == CMD_TYPE.Turn then
-- 		self:DoTurn(data)
-- 	elseif ty == CMD_TYPE.Skill then
-- 		self:DoSkill(data)
-- 	elseif ty == CMD_TYPE.OverLoad then
-- 		self:OverLoad(data)
-- 	elseif ty == CMD_TYPE.Commander then
-- 		self:DoCommanderSkill(data)
-- 	elseif ty == CMD_TYPE.End then
-- 		self:DoEnd(data)
-- 	elseif ty == CMD_TYPE.ChangeStage then
-- 		self:ChangeStage(data.stage)
-- 	end

-- end