-- 配置容错检测及特殊处理
-- 此函数会在每个配置表的设置为只读表前调用, 在此可以修改配置表
-- ConfigChecker:[表名(同配置一致)](cfg)
-- OPENDEBUG()
ConfigChecker = {}

-- 检查副本数据
function ConfigChecker:CheckDungeon()
    -- for duplicateID,v in pairs(MainLine) do
    --     function FunCheckDungeon(duplicateID,v)
    --         LogDebugEx("检查副本数据:"..duplicateID)
    --         -- LogTable(v)
    --         local dungeonData = Loader:Require("Dungeon.Dungeon_" .. duplicateID)
    --         ASSERT(dungeonData.born, "没有配置出生点")
    --         ASSERT(dungeonData.groups[dungeonData.born], "没有配置出生点坐标组")
    --         for i,v in ipairs(dungeonData.monsters) do
    --             ASSERT(v.born, "没有配置怪物出生点")
    --             ASSERT(dungeonData.groups[v.born], "没有配置怪物出生点坐标组")
    --         end
    --         ASSERT(dungeonData.mapid, "没有配置地图id")
    --         local mapData = Loader:Require("Map.Map_" .. dungeonData.mapid)
    --         LogDebugEx("检查地图数据:".. dungeonData.mapid)
    --         for i,v in ipairs(dungeonData.groups) do
    --             for i2,gid in ipairs(v) do
    --                 ASSERT(mapData[gid], "地图不包含坐标id为"..gid.."的格子")
    --             end
    --         end
    --     end
    --     local ok,err = pcall(FunCheckDungeon, duplicateID,v)
    --     if not ok then
    --         print("err msg ",err)
    --     end
    -- end
end

function ConfigChecker:ShowCheckPrimaryKeyErr(checkCfg, errCfg, findKey)
    LogTable(errCfg, '报错的哪一行数据为:')
    if checkCfg.cfgFieldKey2 then
        LogInfo('配日志表:' .. checkCfg.cfgName .. '.' .. checkCfg.cfgFieldKey .. '.' .. checkCfg.cfgFieldKey2)
    else
        LogInfo('配日志的:' .. checkCfg.cfgName .. '.' .. checkCfg.cfgFieldKey)
    end

    LogInfo('在表[' .. checkCfg.relevance .. ']中找不到主键为' .. findKey .. '的配置')
    ASSERT()
end

-- 主键关联有效性检测
function ConfigChecker:CheckPrimaryKey()
    for k, checkCfg in pairs(ConfigPrimaryKey) do
        -- 要检查的表格
        LogInfo('CheckPrimaryKey() 开始检查表格 ' .. checkCfg.cfgName .. ' 与关联表格 ' .. checkCfg.relevance)

        -- 关联表A
        local cfgA = _G[checkCfg.cfgName]

        -- 关联表B
        local cfgB = _G[checkCfg.relevance]

        -- 检查字段名称
        local strCheckField = checkCfg.cfgFieldKey
        if checkCfg.cfgFieldKey2 then
            strCheckField = strCheckField .. ' -> ' .. checkCfg.cfgFieldKey2
        end

        -- 遍历表A的每一行
        for k, cfga in pairs(cfgA) do
            local f1 = cfga[checkCfg.cfgFieldKey]
            if f1 ~= nil then
                if type(f1) == 'table' then
                    for _, f1v in pairs(f1) do
                        if checkCfg.cfgFieldKey2 then
                            local f2 = f1v[checkCfg.cfgFieldKey2]
                            if f2 ~= nil then
                                if type(f2) == 'table' then
                                    for _, f2v in pairs(f2) do
                                        if not cfgB[f2v] then
                                            self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f2v)
                                        end
                                    end
                                else
                                    if not cfgB[f2] then
                                        self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f2)
                                    end
                                end
                            end
                        else
                            if not cfgB[f1v] then
                                self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f1v)
                            end
                        end
                    end
                else
                    if not cfgB[f1] then
                        self:ShowCheckPrimaryKeyErr(checkCfg, cfga, f1)
                    end
                end
            end
        end
    end
end

-- 奖励表
function ConfigChecker:RewardInfo(cfg)
    -- LogTable(cfg)
    for k, v in pairs(cfg) do
        if not v.item[1] then
            ASSERT(false, '掉落表id:' .. k .. '，为空，或者 item 数组的下标不是从1开始！')
        end

        for i, item in ipairs(v.item) do
            if item.level or item.dupID then
                v.bIsLimit = true
            end

            if item.type == RandRewardType.ITEM then
                ASSERT(
                    ItemInfo[item.id],
                    '掉落表id:' .. k .. ',index:' .. i .. ', item.id为:' .. item.id .. ', 表 ItemInfo 找不到配置！'
                )
            elseif item.type == RandRewardType.CARD then
                ASSERT(
                    CardData[item.id],
                    '掉落表id:' .. k .. ',index:' .. i .. ', item.id为:' .. item.id .. ', 表 CardData 找不到配置！'
                )
            elseif item.type == RandRewardType.EQUIP then
                ASSERT(
                    CfgEquip[item.id],
                    '掉落表id:' .. k .. ',index:' .. i .. ', item.id为:' .. item.id .. ', 表 CfgEquip 找不到配置！'
                )
            elseif item.type == RandRewardType.TEMPLATE then
                ASSERT(
                    cfg[item.id],
                    '掉落表id:' .. k .. ',index:' .. i .. ', item.id为:' .. item.id .. ', 表 RewardInfo 找不到配置！'
                )
            end
        end
    end
end

-- 卡牌表
function ConfigChecker:CardData(cfgs)
    for k, v in pairs(cfgs) do
        local skills = {}
        if v.jcSkills then
            for i, skillID in ipairs(v.jcSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tfSkills then
            for i, skillID in ipairs(v.tfSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tcSkills then
            for i, skillID in ipairs(v.tcSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.fit_result then
            assert(cfgs[v.fit_result], '卡牌id:' .. v.id .. ' 的 v.fit_result 值：' .. v.fit_result .. ' 在卡牌表找不到对应配置')
        end

        v.skills = skills

        if v.skin then
            table.sort(v.skin)
        end

        ASSERT(v.nJump, '没有配置跳跃步数' .. v.id)
        ASSERT(v.nStep, '没有配置移动步数' .. v.id)
        ASSERT(v.break_id, '没有配置突破模板 break_id' .. v.id)

        for i = 0, 3, 1 do
            local useId = v.break_id + i
            if not CardBreakMaterial[useId] then
                ASSERT(
                    false,
                    '卡牌cfgId:' ..
                        v.id ..
                            ', break_id:' ..
                                v.break_id .. '的第[ ' .. i + 1 .. ' ]级id:' .. useId .. '在CardBreakMaterial找不到配置'
                )
            end
        end

        -- 记录所有皮肤可使用的最小突破等级，以内会出现重复，所以不能使用排序加二分查找法
        local skinMinBreakLv = {}
        if v.breakModels then
            table.sort(v.breakModels)

            for ix, skinId in ipairs(v.breakModels) do
                local ov = skinMinBreakLv[skinId]
                if not ov or ix < ov then
                    skinMinBreakLv[skinId] = ix
                end
            end
        end

        for _, tCId in ipairs(v.tTransfo or {}) do
            local tCfg = CardData[tCId]
            -- LogTable(tCfg.breakModels, "cid:" .. tCId)
            for ix, skinId in ipairs(tCfg.breakModels or {}) do
                local ov = skinMinBreakLv[skinId]
                if not ov or ix < ov then
                    skinMinBreakLv[skinId] = ix
                end
            end
        end

        v.skinMinBreakLv = skinMinBreakLv
        -- LogTable(v.skinMinBreakLv, "v.skinMinBreakLv:")
        if v.coreItemId then
            local itemCfg = ItemInfo[v.coreItemId]
            ASSERT(itemCfg, 'ItemInfo没有id=' .. v.coreItemId)

            local isFind = false
            for _, val in ipairs(itemCfg.dy_arr) do
                local isOk = (val == v.id)
                if isOk then
                    isFind = true
                    break
                end
            end

            ASSERT(
                isFind,
                string.format(
                    '卡牌 %s 的 coreItemId [%s] 对应物品的 itemCfg.dy_arr 里面需要包含卡牌id:%s.',
                    v.id,
                    v.coreItemId,
                    table.tostring(itemCfg.dy_arr)
                )
            )
        end

        if (v.uniteLabel) then
            local removeIDs = {}
            local uniteIDs = {}
            for _, _cfg in pairs(CardData) do
                --需要剔除的id
                if (_cfg.fit_result) then --合体id
                    removeIDs[_cfg.fit_result] = _cfg.fit_result
                end
                if (_cfg.tTransfo) then --变身id
                    for _, _id in ipairs(_cfg.tTransfo) do
                        removeIDs[_id] = _id
                    end
                end

                local count = 0
                for _, _info in ipairs(v.uniteLabel) do
                    local cfgLabel = CfgUniteLabel[_info[1]]
                    local cfg1 = nil
                    if (_cfg.role_id and cfgLabel.cfgType == 1) then
                        cfg1 = CfgCardRole[_cfg.role_id]
                    else
                        cfg1 = _cfg
                    end
                    if (cfg1) then
                        --判断条件
                        local num = 0
                        if (cfgLabel.key) then
                            for _, content in ipairs(_info[2]) do
                                if (cfgLabel.type ~= 2) then
                                    if (cfg1[cfgLabel.key] == content) then
                                        num = num + 1
                                    end
                                else --区间类型
                                    if
                                        (content[1] < 0 and content[2] < 0) or
                                            (content[1] < 0 and cfg1[cfgLabel.key] < content[2]) or
                                            (content[2] < 0 and cfg1[cfgLabel.key] > content[1]) or
                                            (cfg1[cfgLabel.key] > content[1] and cfg1[cfgLabel.key] < content[2])
                                     then
                                        num = num + 1
                                    end
                                end
                            end
                        end
                        if (num > 0) then
                            if (_info[3] == 1) then --或条件
                                count = count + 1
                            else --与条件
                                if (num >= #_info[2]) then
                                    count = count + 1
                                end
                            end
                        end
                    end
                end
                if (count >= #v.uniteLabel and _cfg.get_from_gm) then
                    table.insert(uniteIDs, _cfg.id)
                end
            end
            if (#uniteIDs > 0) then
                table.sort(
                    uniteIDs,
                    function(a, b)
                        return a < b
                    end
                )
                local lastID = 0
                local ids = {}
                for _, uniteID in ipairs(uniteIDs) do --剔除不需要和相同的id
                    if (not (removeIDs[uniteID]) and not (uniteID == v.id) and not (uniteID == lastID)) then
                        table.insert(ids, uniteID)
                    end
                    lastID = uniteID
                end
                v.unite = ids
            end
        end

        -- if v.id == 50010 then
        -- 	LogTable(v)
        -- 	ASSERT()
        -- end

        if v.summon then
            ASSERT(v.add_role_id, '填了, summon 必须要填 add_role_id 字段')
        end

        if v.role_id then
            ASSERT(
                CfgCardRole[v.role_id],
                '卡牌配置表的id:' .. v.id .. ', 的 role_id:' .. v.role_id .. ', 在 CfgCardRole 表格找不到数据'
            )
        end

        if v.add_role_id then
            ASSERT(
                CfgCardRole[v.add_role_id],
                '卡牌配置表的id:' .. v.id .. ', 的 add_role_id:' .. v.add_role_id .. ', 在 CfgCardRole 表格找不到数据'
            )
        end
    end
end

function ConfigChecker:CfgCardRole(cfgs)
    for id, cfg in pairs(cfgs) do
        ASSERT(cfg.aModels, 'CfgCardRole id：' .. id .. '没填 aModels')

        if character then
            -- 服务器没这个表
            ASSERT(character[cfg.aModels], 'CfgCardRole id：' .. id .. ', 的aModels:' .. '在角色模型表 character 找不到数据。')
        end
    end
end

-- 怪物表
function ConfigChecker:MonsterData(cfg)
    for k, v in pairs(cfg) do
        local skills = {}
        if v.jcSkills then
            for i, skillID in ipairs(v.jcSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tfSkills then
            for i, skillID in ipairs(v.tfSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.subTfSkills then
            for i, skillID in ipairs(v.subTfSkills) do
                table.insert(skills, skillID)
            end
        end

        if v.tcSkills then
            for i, skillID in ipairs(v.tcSkills) do
                table.insert(skills, skillID)
            end
        end
        v.skills = skills
    end
end

function ConfigChecker:skill(cfg)
    for k, v in pairs(cfg) do
        v.skillGroup = math.floor(v.id / 100)

        -- 暂时可以重复，取消检测
        -- local equipSkillInfo = CfgEquipSkill[k]
        -- if equipSkillInfo then
        --     ASSERT(false, "技能表id, 与装备技能id重复，值为：" .. k)
        -- end
        -- 核心技能、对饮 ovload 技能检测
        -- Tips: +1000 是策划约定的，如果修改这个值，需要同步修改卡牌技能升级Card:AddSkillLv()里的 +1000
        if false and v.upgrade_type == CardSkillUpType.C then
            local ovloadId = v.id + 1000
            local ovloadCfg = cfg[ovloadId]
            if not ovloadCfg then
                ASSERT(false, '技能id:' .. v.id .. '没有找到对应的overload技能id:' .. ovloadId)
            end

            if ovloadCfg.type ~= 9 then
                ASSERT(
                    false,
                    '技能id:' ..
                        v.id .. '没有找到对应的overload技能id:' .. ovloadId .. ', 的技能类型为：' .. ovloadCfg.type .. ', 约定类型应该为：9.'
                )
            end
        end
    end
end

-- 关卡表
function ConfigChecker:MainLine(cfg)
    -- LogDebug("IS_CLIENT:" .. IS_CLIENT)
    for k, v in pairs(cfg) do
        if v.forceSkill then
            table.sort(v.forceSkill)
        end

        if v.nGroupID then -- 直接进入战斗
        else
            v.star = {}
            v.mapStar = {}
            for i = 1, 3 do
                local config = v['star' .. i]
                table.insert(v.star, config[1])

                v.mapStar[config[1]] = i
            end
        end
        v.skillGroup = math.floor(v.id / 100)

        if v.arrForceTeam then
            local arrForceTeam = {}
            for i, v in ipairs(v.arrForceTeam) do
                ASSERT(ForceTeam[v], '没有配置强制队伍' .. v)
                arrForceTeam[i] = ForceTeam[v].arrForceTeam
            end
            v.arrForceTeam = arrForceTeam
        end

        if v.encounterReward then
            ASSERT(v.encounterRate, '没有配置随机遇怪概率')
            ASSERT(v.encounterMonster, '没有配置随机遇怪')

            local encounterMonster = {total = 0, data = {}}
            for i, v2 in ipairs(v.encounterMonster) do
                encounterMonster.total = encounterMonster.total + v2[2]
                v2[2] = encounterMonster.total
                table.insert(encounterMonster.data, v2)
            end

            v.encounterMonster = encounterMonster
        end

        if v.nBegTime then -- 期效副本开始结束时间
            v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
            v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        end

        v.enterLimitHot = (v.enterCostHot or 0) + (v.winCostHot or 0)
    end
end

function CheckFormation(formation, list)
    local map = {}
    for i = 1, 4 do
        map[i] = {}
        for j = 1, 4 do
            map[i][j] = 0
        end
    end
    -- [row][col]
    -- MonsterData.grids
    -- MonsterFormation
    local cfgFormation = MonsterFormation[formation]
    ASSERT(cfgFormation, '没有配置阵型' .. formation)
    if cfgFormation.relative == 1 then
        ASSERT(nil, '周目怪物阵型应该用绝对坐标' .. formation)
    end
    for i, v in ipairs(cfgFormation.coordinate) do
        local monsterID = list[i]
        -- ASSERT(monsterID, "阵型与怪物列表数量不一致")
        if monsterID and monsterID ~= 0 then
            local monster = MonsterData[monsterID]
            ASSERT(monster, '怪物配置不存在' .. monsterID)
            if monster.grids then -- 占多格
                local cfgGrids = MonsterFormation[monster.grids]
                ASSERT(cfgGrids, '没有配置阵型' .. monster.grids)
                -- if cfgGrids.relative == 0 then ASSERT(nil, "怪物占格阵型应该用相对坐标"..formation) end
                for i, coor in ipairs(cfgGrids.coordinate) do
                    local row = coor[1] + v[1]
                    local col = coor[2] + v[2]
                    -- LogDebugEx(string.format("coordinate%s, %s, %s", monsterID, row, col))
                    if cfgGrids.relative == 0 then -- 绝对坐标
                        row = coor[1]
                        col = coor[2]
                    end
                    if row > 4 or col > 4 then
                        LogTable(cfgFormation)
                        LogTable(v)
                        LogTable(cfgGrids)
                        ASSERT(nil, '超出格子monsterID=' .. monsterID)
                    end
                    if map[row][col] == 1 then
                        ASSERT(nil, '格子被占用monsterID=' .. monsterID)
                    end
                    map[row][col] = 1
                end
            else
                if map[v[1]][v[2]] == 1 then
                    ASSERT(nil, '格子被占用monsterID=' .. monsterID)
                end
                map[v[1]][v[2]] = 1
            end
        end
    end
end

function ConfigChecker:MonsterGroup(cfg)
    for k, v in pairs(cfg) do
        ASSERT(v.nJump, '没有配置跳跃步数' .. v.id)
        ASSERT(v.nStep, '没有配置移动步数' .. v.id)
        for i, stage in ipairs(v.stage) do
            -- CheckFormation(stage.formation, stage.monsters)
            local ret, err = pcall(CheckFormation, stage.formation, stage.monsters)
            if err then
                LogDebugEx(string.format('MonsterGroup id[%s] 周目[%s]', v.id, i))
                LogError(err)
                ASSERT()
            end
        end

        -- 怪物等级用显示怪的等级(用数值模板的等级跟玩家一样)
        local id = v.monster
        -- LogTable(v)
        local mcfg = MonsterData[id]
        ASSERT(mcfg, '没有显示怪物的配置' .. id .. '/' .. v.id)
        v.level = mcfg.level
    end
    -- LogTable(cfg)
end

-- 光环表
function ConfigChecker:cfgHalo(cfg)
    local attr = {'attack', 'maxhp', 'defense', 'speed', 'crit_rate', 'crit', 'hit', 'resist'}
    for k, v in pairs(cfg) do
        local coorHalo = {}
        local coordinate = v.coordinate
        for i = 2, #coordinate do
            -- local item = {coordinate[i][1] - coordinate[1][1],  coordinate[i][2] - coordinate[1][2]}
            table.insert(coorHalo, {coordinate[i][1] - coordinate[1][1], coordinate[i][2] - coordinate[1][2]})
        end
        v.coorHalo = coorHalo
        v.percents = {}
        for i, attrname in ipairs(attr) do
            if v[attrname] then
                v.percents[attrname] = v[attrname]
            end
        end
    end
end

-- 世界boss
function ConfigChecker:cfgWorldBoss(cfgs)
    if IS_CLIENT then
        return
    end

    for k, v in pairs(cfgs) do
        v.nBeginTime = GCalHelp:GetTimeStampBySplit(v.nBeginTime)
        v.nEndTime = GCalHelp:GetTimeStampBySplit(v.nEndTime)
        v.nDailyBeginTime = GCalHelp:GetTimeStampBySplit(v.nDailyBeginTime)
        v.nDailyEndTime = GCalHelp:GetTimeStampBySplit(v.nDailyEndTime)
    end
end

function ConfigChecker:CfgGuildFightSchedule(cfgs)
    if IS_CLIENT then
        return
    end

    local curTime = os.time()
    for k, oneCfg in pairs(cfgs) do
        oneCfg.nOpenTime = GCalHelp:CalTimeByArr(oneCfg.openTime, curTime)
        oneCfg.nCloseTime = GCalHelp:CalTimeByArr(oneCfg.closeTime, curTime)

        for _, v in pairs(oneCfg.infos) do
            v.nStartTime = GCalHelp:CalTimeByArr(v.startTime, curTime)
            v.nEndTime = GCalHelp:CalTimeByArr(v.endTime, curTime)
            v.nRangRewardTime = GCalHelp:CalTimeByArr(v.rangRewardTime, curTime)
            v.nFightResultRewardTime = GCalHelp:CalTimeByArr(v.fightResultRewardTime, curTime)
        end
    end

    -- LogTable(cfgs, "ConfigChecker:CfgGuildFightSchedule:")
end

function ConfigChecker:CfgBCompoundOrder(cfgs)
    for k, v in pairs(CfgBCompoundLvl) do
        v.orderIds = {}
    end

    for k, v in pairs(cfgs) do
        local cfg = CfgBCompoundLvl[v.buildLv]
        table.insert(cfg.orderIds, v.id)
    end

    local len = #CfgBCompoundLvl
    for i = 1, len, 1 do
        local curCfg = CfgBCompoundLvl[i]
        table.sort(curCfg.orderIds)

        local nextCfg = CfgBCompoundLvl[i + 1]

        if nextCfg then
            for _, val in ipairs(curCfg.orderIds) do
                table.insert(nextCfg.orderIds, val)
            end

            table.sort(nextCfg.orderIds)
        end
    end

    -- LogTable(CfgBCompoundLvl, "CfgBCompoundLvl:")
end

function ConfigChecker:CfgExpeditionTask(cfgs)
    if IS_CLIENT then
        return
    end

    for _, lvCfg in ipairs(CfgExpeditionLvl) do
        lvCfg.taskIds = {}
        lvCfg.flushDupIds = {}
    end

    -- 把需要等级的插入到等级配置里面
    for taskType, cfg in pairs(cfgs) do
        for _, subId in ipairs(cfg.subs or {}) do
            local subCfg = CfgExpeditionTaskSub[subId]
            if subCfg then
                for index, task in pairs(subCfg.tasks) do
                    local lvCfg = nil

                    if task.eventId then
                        table.sort(task.eventId)
                    end

                    if task.tFlush then
                        table.sort(task.tFlush)
                    end

                    if task.buildLv then
                        lvCfg = CfgExpeditionLvl[task.buildLv]
                    else
                        -- 不需要等级的，都放到1级去
                        lvCfg = CfgExpeditionLvl[1]
                    end

                    if task.flushDupId then
                        -- 记录关卡开通的任务，通关的时候判断用
                        for _, dupId in ipairs(task.flushDupId) do
                            local byDubIdTb = GCalHelp:GetTb(lvCfg.flushDupIds, dupId)
                            local byTypeTb = GCalHelp:GetTb(byDubIdTb, taskType)
                            local BySubIdTb = GCalHelp:GetTb(byTypeTb, subId)
                            table.insert(BySubIdTb, index)
                        end
                    else
                        -- 记录该等级下所有的任务
                        local byTypeTb = GCalHelp:GetTb(lvCfg.taskIds, taskType)
                        local byTypeSubIdTb = GCalHelp:GetTb(byTypeTb, subId)
                        table.insert(byTypeSubIdTb, index)
                    end
                end
            end
        end
    end

    local sortTasks = function(taskIds)
        for typeId, byTypes in pairs(taskIds) do
            for subId, bySubs in pairs(byTypes) do
                table.sort(bySubs)
            end
        end
    end

    -- 把不需要等级的，全部等级都放入一遍
    local arrLen = #CfgExpeditionLvl
    for i = 1, arrLen, 1 do
        local curCfg = CfgExpeditionLvl[i]

        sortTasks(curCfg.taskIds)

        local nextCfg = CfgExpeditionLvl[i + 1]

        -- 把当前的 taskIds 拷贝到下一等级去
        if nextCfg then
            for taskType, byTypes in pairs(curCfg.taskIds) do
                local nextType = GCalHelp:GetTb(nextCfg.taskIds, taskType)
                for taskSubId, subs in pairs(byTypes) do
                    local nextSubArr = GCalHelp:GetTb(nextType, taskSubId)
                    for _, val in ipairs(subs) do
                        table.insert(nextSubArr, val)
                    end
                    table.sort(nextSubArr)
                end
            end
        end
    end

    -- LogTrace("CfgExpeditionTask:")
    -- LogTable(CfgExpeditionLvl, "CfgExpeditionLvl:")
end

local checkAbilityPercent = function(cfg, abCfg, per)
    if per >= -100 and per <= 100 then
        return
    end

    LogDebug('per:%s error, must >= -100 and = 100', per)
    LogTable(cfg, 'checkAbilityPercent cfg')
    ASSERT(false)
end

local checkAbilityArrLen = function(cfg, abCfg, field, len)
    if #abCfg[field] < len then
        LogDebug('%s len less than %s', field, len)
        LogTable(cfg, 'checkAbilityArrLen cfg')
        ASSERT(false)
    end
end
local checkAbilityItem = function(cfg, abCfg, itemId)
    if not ItemInfo[itemId] then
        LogDebug('Not find item id: %s', itemId)
        LogTable(cfg, 'checkAbilityArrLen cfg')
        ASSERT(false)
    end
end

local checkOneArr = function(cfg, abCfg, field)
    local arrs = abCfg[field]
    if not arrs or type(arrs) ~= 'table' then
        LogTable(cfg, 'checkOneArr cfg ' .. field .. ' error!')
        ASSERT(false)
    end

    for _, v in ipairs(abCfg[field]) do
        if type(v) == 'table' then
            LogDebug('must one array: %s', field)
            LogTable(cfg, 'checkOneArr cfg')
            ASSERT(false)
        end
    end
end

local checkMultiArr = function(cfg, abCfg, field)
    local arrs = abCfg[field]
    if not arrs or type(arrs) ~= 'table' then
        LogTable(abCfg, 'checkMultiArr cfg ' .. field .. ' error!')
        ASSERT(false)
    end

    for _, v in ipairs(arrs) do
        if type(v) ~= 'table' then
            LogDebug('must multi array: %s', field)
            LogTable(cfg, 'checkMultiArr cfg')
            ASSERT(false)
        end
    end
end

function ConfigChecker:CfgCardRoleAbilityPool(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.needBuildTypes then
            table.sort(cfg.needBuildTypes)
        else
            cfg.needBuildTypes = {}
        end

        for _, abCfg in ipairs(cfg.arr) do
            if cfg.type == RoleAbilityType.Controler then
                -- RoleAbilityType.Controler = 1 -- 指挥者
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkOneArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Leaderer then
                -- RoleAbilityType.Leaderer = 2 -- 领导者
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Labor then
                -- RoleAbilityType.Labor = 3 -- 专员
                checkAbilityArrLen(cfg, abCfg, 'vals', 4)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                ASSERT(abCfg.vals[4] == 1 or abCfg.vals[4] == 2 or abCfg.vals[4] == 0)
            elseif cfg.type == RoleAbilityType.Quality then
                -- RoleAbilityType.Quality = 4 -- 质检员
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityItem(cfg, abCfg, abCfg.vals[2])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[3])
            elseif cfg.type == RoleAbilityType.Cost then
                -- RoleAbilityType.Cost = 5 -- 成本
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Explorer then
                -- RoleAbilityType.Explorer = 6 -- 探索员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.Scientist then
                -- RoleAbilityType.Scientist = 7 -- 科学家 --not use
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.Fighter then
                -- RoleAbilityType.Fighter = 8 -- 战斗员
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Engineer then
                -- RoleAbilityType.Engineer = 9 -- 工程师
                checkAbilityArrLen(cfg, abCfg, 'vals', 3)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.Artisan then
                -- RoleAbilityType.Artisan = 10 -- 技术员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.Traders then
                -- RoleAbilityType.Traders = 11 -- 交易员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.OptimizeTraders then
                -- RoleAbilityType.OptimizeTraders = 12 -- 优化专员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Seller then
                -- RoleAbilityType.Seller = 13 -- Seller
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
            elseif cfg.type == RoleAbilityType.PowerOpt then
                -- RoleAbilityType.PowerOpt = 14 -- 能源优化师
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.CombineWorker then
                -- RoleAbilityType.CombineWorker = 15 -- 合成工人
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.DeepExplorer then
                -- RoleAbilityType.DeepExplorer = 16 -- 深度探索员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.ExplorLeader then
                -- RoleAbilityType.ExplorLeader = 17 -- 探索队长
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
            elseif cfg.type == RoleAbilityType.Adventurer then
                -- RoleAbilityType.Adventurer = 18 -- 冒险家
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.SpacePirate then
                -- RoleAbilityType.SpacePirate = 19 -- 宇宙海盗
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.ActiveSeller then
                -- RoleAbilityType.ActiveSeller = 20 -- 积极销售员，除自身外，根据入驻人员增加订单数，但是其他角色能力不生效，也不扣除疲劳
            elseif cfg.type == RoleAbilityType.AloneSeller then
                -- RoleAbilityType.AloneSeller = 21 -- 独行销售员， 增加入驻上限 - 入驻人员数量 的订单数，不包括自己
            elseif cfg.type == RoleAbilityType.BuySeller then
                -- RoleAbilityType.BuySeller = 22 -- 采购员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.SupperItemer then
                -- RoleAbilityType.SupperItemer = 23 -- 高级物料员
                checkMultiArr(cfg, abCfg, 'valArrs')
                for _, lvInfo in ipairs(cfg.arr) do
                    for _, arr in ipairs(lvInfo.valArrs) do
                        table.sort(arr[3])
                    end
                end
            elseif cfg.type == RoleAbilityType.Pacifyer then
                -- RoleAbilityType.Pacifyer = 24 -- 安抚精英
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
            elseif cfg.type == RoleAbilityType.Eluder then
                -- RoleAbilityType.Eluder = 25 -- 避难专员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.PartDev then
                -- RoleAbilityType.PartDev = 26 -- 研发专注
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
            elseif cfg.type == RoleAbilityType.OptimizeDev then
                -- RoleAbilityType.OptimizeDev = 27 -- 研发提升
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.FightCmder then
                -- RoleAbilityType.FightCmder = 28 -- 战斗指挥员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.ProductAdder then
                -- RoleAbilityType.ProductAdder = 29 -- 产能增长
                checkAbilityArrLen(cfg, abCfg, 'vals', 4)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
                checkOneArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Storer then
                -- RoleAbilityType.Storer = 30 -- 仓管员
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Troubler then
                -- RoleAbilityType.Troubler = 31 -- 麻烦制造者
                checkMultiArr(cfg, abCfg, 'valArrs')
            elseif cfg.type == RoleAbilityType.Unityer then
                -- RoleAbilityType.Unityer = 32 -- 团结员
                checkAbilityArrLen(cfg, abCfg, 'vals', 1)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
            elseif cfg.type == RoleAbilityType.UpQuality then
                -- RoleAbilityType.UpQuality = 33 -- 质检专家
                checkAbilityArrLen(cfg, abCfg, 'vals', 2)
                checkAbilityPercent(cfg, abCfg, abCfg.vals[1])
                checkAbilityPercent(cfg, abCfg, abCfg.vals[2])
            elseif cfg.type == RoleAbilityType.CombineGift then
                -- RoleAbilityType.CombineGift = 34 -- 合成额外奖励能力
                checkMultiArr(cfg, abCfg, 'valArrs')
            end
        end
    end

    -- LogTable(CfgCardRoleAbilityPool, "CfgCardRoleAbilityPool:")
    -- LogTable(CfgCardRoleAbilityPool[1001], "CfgCardRoleAbilityPool 1001")
    -- LogTable(CfgCardRoleAbilityPool[1002], "CfgCardRoleAbilityPool 1002")
end

function ConfigChecker:CfgBuidingBase(cfgs)
    local buildByType = {}
    for _, cfg in pairs(cfgs) do
        if not cfg.needAbilitys then
            cfg.needAbilitys = {}
        end
        buildByType[cfg.type] = cfg
    end

    for id, cfg in pairs(CfgCardRoleAbilityPool) do
        for _, nt in ipairs(cfg.needBuildTypes) do
            local arr = buildByType[nt]
            if arr then
                table.insert(buildByType[nt].needAbilitys, id)
            else
                LogWarning('CfgCardRoleAbilityPool 所配置的能力卡池id:' .. id .. '存在无效的建筑类型:' .. nt)
            end
        end
    end

    for _, cfg in pairs(cfgs) do
        table.sort(cfg.needAbilitys)
    end

    -- LogTable(CfgBuidingBase, "CfgBuidingBase:")
end

-- 操作日志
function ConfigChecker:LogMap(cfgs)
    LogItem = {}
    for _, cfg in pairs(cfgs) do
        LogItem[cfg.key] = cfg.id
        cfg.srcText = cfg.text
        for i = 1, 10 do
            cfg.text = string.gsub(cfg.text, 'char' .. i, '%%s', 1)
            -- print(cfg.text)
        end
    end

    -- LogTable(LogItem, "LogItem")
    -- LogTable(cfgs, "LogMap")
    -- ASSERT()
end

function ConfigChecker:CfgFriendConst(cfgs)
    for _, cfg in pairs(cfgs) do
        eFriendConst[cfg.sEnum] = cfg.id
    end
end

function ConfigChecker:CfgClothes(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.canUses then
            table.sort(cfg.canUses)
        end

        if cfg.notUses then
            table.sort(cfg.notUses)
        end
    end
end

function ConfigChecker:CfgEquip(cfgs)
    for _, cfg in pairs(cfgs) do
        -- 检查随机技能
        if cfg.randSkills then
            for _, randId in ipairs(cfg.randSkills) do
                local randCfg = CfgEquipRandSkill[randId]
                if not randCfg then
                    ASSERT(false, 'CfgEquip not find cfg id: ' .. randId .. ', in CfgEquipRandSkill from randSkills!')
                end

                if not next(randCfg.infos) then
                    ASSERT(false, 'CfgEquipRandSkill cfg id：' .. randId .. ' field infos is empty!')
                end
            end
        end
    end
end

function ConfigChecker:CfgEquipRandSkill(cfgs)
    if IS_CLIENT then
        return
    end

    for _, cfg in pairs(cfgs) do
        GCalHelp:CalArrWeight(cfg.infos, 'weight', 'sumWeight')

        for _, info in ipairs(cfg.infos) do
            if not info.lvCfgId then
                ASSERT(false, 'CfgEquipRandSkill cfg id: ' .. info.id .. ', lvCfgId is empty')
            end

            local lvCfg = CfgEquipRandSkillLv[info.lvCfgId]
            if not lvCfg then
                ASSERT(false, 'CfgEquipRandSkill cfg id: ' .. cfg.id .. ', lvCfgId: ' .. info.lvCfgId .. ' error')
            end
        end
    end
end

function ConfigChecker:CfgEquipRandSkillLv(cfgs)
    if IS_CLIENT then
        return
    end

    for _, cfg in pairs(cfgs) do
        GCalHelp:CalArrWeight(cfg.infos, 'weight', 'sumWeight')

        if not next(cfg.infos) then
            ASSERT(false, 'CfgEquipRandSkillLv cfg id:' .. cfg.id .. ', infos is empty')
        end
    end
end

function ConfigChecker:CfgEquipSkill(cfgs)
    for id, cfg in pairs(cfgs) do
        local baseId, lv = GCalHelp:GetEquipBaseIdAndLv(cfg.id)

        -- 将等级上限保存在一级技能id后边
        local baseCfg = cfgs[baseId]
        if not baseCfg.maxLv or lv > baseCfg.maxLv then
            baseCfg.maxLv = lv
        end

        -- 暂时可以重复，取消检测
        -- local skilInfo = skill[id]
        -- if skilInfo then
        --     ASSERT(false, "装备技能id, 与技能表id重复，值为：" .. id)
        -- end
    end
end

function ConfigChecker:CfgCardPool(cfgs)
    for id, cfg in pairs(cfgs) do
        if cfg.childIds then
            for _, arr in ipairs(cfg.childIds) do
                local cnt, cid = arr[1], arr[2]
                if not cfgs[cid] then
                    ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 childIds 字段的子id:%s 在配置表中找不到', id, cid))
                end
            end

            if cfg.nType ~= CardPoolType.GobalCreateCnt then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 的卡池类型应该为3', id))
            end
        end

        if cfg.nType == CardPoolType.JustFinish and not cfg.nSort then
            ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 nSort 为空', id))
        end

        if cfg.nType == CardPoolType.FixTimeFirstLogin then
            if not cfg.duration or cfg.duration < 1 then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 duration 不允许为 %s', id, cfg.duration))
            end

            if not cfg.plrCreateTime then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中的 plrCreateTime 为空', id))
            end

            cfg.nPlrCreateTime = GCalHelp:GetTimeStampBySplit(cfg.plrCreateTime, cfg)
        end

        -- 查看奖励
        local hadFirstReward = false
        for _, arr in ipairs(cfg.jCardsId) do
            local cnt, rewardId = arr[1], arr[2]
            if not RewardInfo[rewardId] then
                ASSERT(
                    false,
                    string.format('CfgCardPool 配置表 id :%s 中 jCardsId 的 rewardId:%s 在奖励表 RewardInfo 中找不到', id, rewardId)
                )
            end

            if cnt == -1 then
                hadFirstReward = true
            end
        end

        if cfg.nFirstTryCnt then
            if not cfg.nFirstLogCnt or cfg.nFirstLogCnt < 1 then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中配置了 nFirstLogCnt 那么 nFirstLogCnt 不能为0，且需要配置', id))
            end
        end

        if hadFirstReward then
            if not cfg.nFirstTryCnt then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中没有配置 nFirstLogCnt, 但是配置了新手10首抽奖励', id))
            end
        else
            if cfg.nFirstTryCnt then
                ASSERT(false, string.format('CfgCardPool 配置表 id :%s 中配置了 nFirstLogCnt, 但是没有配置了新手10首抽奖励', id))
            end
        end

        if cfg.sel_card_ids then
            table.sort(cfg.sel_card_ids)
        end

        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.sStart, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.sEnd, cfg)
    end
end

function ConfigChecker:CfgDorm(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.id < 1 or cfg.id >= 100 then
            ASSERT(false, string.format('CfgDorm 配置表 id 为:%s, id允许范围为 0 < id < 100', cfg.id))
        end

        for _, info in pairs(cfg.infos) do
            if info.index < 1 or info.index >= 100 then
                ASSERT(
                    false,
                    string.format('CfgDorm 配置表 id 为:%s index 为: %s, index 允许范围为 0 < index < 100', cfg.id, info.index)
                )
            end
        end
    end
end

function ConfigChecker:global_setting(cfgs)
    -- LogDebug("global_setting: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    table.sort(g_BuildTradeFlushTimes)
    -- LogTable(g_BuildTradeFlushTimes, "g_BuildTradeFlushTimes:")

    table.sort(g_WeekHoliday)
    -- LogTable(g_WeekHoliday, "g_WeekHoliday:")

    table.sort(g_ArmyFightListScoreRange)
end

function ConfigChecker:CfgExploration(cfgs)
    -- LogTable(cfgs, "ConfigChecker:CfgExploration:")
    for id, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

function ConfigChecker:ItemInfo(cfgs)
    for id, cfg in pairs(cfgs) do
        if cfg.sExpiry then
            cfg.nExpiry = GCalHelp:GetTimeStampBySplit(cfg.sExpiry, cfg)
        end

        --if cfg.type == ITEM_TYPE.ICON_FRAME then
        --    local frameCfg = AvatarFrame[cfg.dy_value2]
        --    frameCfg.item_id = id
        --elseif cfg.type == ITEM_TYPE.PROP then
        --    if cfg.dy_value1 == PROP_TYPE.IconFrame then
        --        local item_id = cfg.dy_arr[1]
        --        local iconFrameItem = cfgs[item_id]
        --        ASSERT(
        --            iconFrameItem.type == ITEM_TYPE.ICON_FRAME,
        --            string.format('道具id:%s的物品对应的头像框物品:%s，类型不对', id, item_id)
        --        )
        --    end
        --end

        -- cfg.hide : 只导出了客户端
        if IS_CLIENT and not cfg.hide then
            if cfg.type == ITEM_TYPE.CARD then
                ASSERT(
                    CardData[cfg.dy_value1],
                    '物品表的: dy_value1:' .. (cfg.dy_value1 or 'empty') .. ', item.id为:' .. id .. ', 表 CardData 找不到配置！'
                )
            elseif cfg.type == ITEM_TYPE.EQUIP then
                ASSERT(
                    CfgEquip[cfg.dy_value1],
                    '物品表的: dy_value1:' .. (cfg.dy_value1 or 'empty') .. ', item.id为:' .. id .. ', 表 CfgEquip 找不到配置！'
                )
            elseif cfg.type == ITEM_TYPE.SKIN then
            end
        end
    end
end

function ConfigChecker:CfgActive(cfgs)
    for k, v in pairs(cfgs) do
        if v.begTime then
            v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
        end
        if v.endTime then
            v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        end
    end
end

function ConfigChecker:CfgActiveEntry(cfgs)
    local battleEndTimeTable = {}
    for _, v in pairs(cfgs) do
        if v.begTime then
            v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
        end
        if v.endTime then
            v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        end
        if v.hardBegTime then
            v.nHardBegTime = GCalHelp:GetTimeStampBySplit(v.hardBegTime, v)
        end
        if v.exBegTime then
            v.nExBegTime = GCalHelp:GetTimeStampBySplit(v.exBegTime, v)
        end
        if v.battleendTime then
            v.nBattleendTime = GCalHelp:GetTimeStampBySplit(v.battleendTime, v)
            if v.config and v.nConfigID then
                local config_table = _G[v.config]
                if config_table and config_table[v.nConfigID] then
                    local tar_config = config_table[v.nConfigID]
                    if tar_config.sectionID then
                        if not battleEndTimeTable[tar_config.sectionID] then
                            battleEndTimeTable[tar_config.sectionID] = v.nBattleendTime
                        else
                            LogWarning('CfgActiveEntry sectionID出现重复%s:%s', v.config, v.nConfigID)
                        end
                    end
                end
            end
        end
        _G['DupActiveBattleEndTime'] = battleEndTimeTable
    end
end

function ConfigChecker:CfgCardElem(cfgs)
    for k, cfg in pairs(cfgs) do
        for groupId, info in pairs(cfg.infos) do
            local gCfg = CfgCardElemGroup[groupId]
            info.minGetCnt = gCfg.MinTimes or 0
            info.maxGetCnt = gCfg.MaxTimes or MAX_UNSIGNED_INT
        end
    end
end

function ConfigChecker:CfgCardRoleUpgrade(cfgs)
    if IS_CLIENT then
        local sumNeedExp = 0
        for i, cfg in ipairs(cfgs) do
            if sumNeedExp ~= cfg.mExp then
                local msg =
                    string.format('CfgCardRoleUpgrade, id:%s, mExp:%s is wrong, will be %s', i, cfg.mExp, sumNeedExp)
                assert(fasle, msg)
            end

            if cfg.nExp then
                sumNeedExp = sumNeedExp + cfg.nExp
            end
        end
    end
end

function ConfigChecker:CfgLimitedTime(cfgs)
    -- 计算操作
    for _, v in pairs(cfgs) do
        if v.times then
            local times = SplitString(v.times, '-')
            if times then
                local start_time = times[1]
                if start_time then
                    local start_times = SplitString(start_time, ':')
                    if start_times and #start_times == 3 then
                        local s_time = {}
                        s_time.time = start_time
                        s_time.time_h = start_times[1]
                        s_time.time_m = start_times[2]
                        s_time.time_s = start_times[3]
                        v.s_time = s_time
                    end
                end

                local end_time = times[2]
                if end_time then
                    local end_times = SplitString(end_time, ':')
                    if end_times and #end_times == 3 then
                        local e_time = {}
                        e_time.time = end_time
                        e_time.time_h = end_times[1]
                        e_time.time_m = end_times[2]
                        e_time.time_s = end_times[3]
                        v.e_time = e_time
                    end
                end
            end
        end
    end
end
