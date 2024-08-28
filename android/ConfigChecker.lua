-- 配置容错检测及特殊处理
-- 此函数会在每个配置表的设置为只读表前调用, 在此可以修改配置表
-- ConfigChecker:[表名(同配置一致)](cfg)
-- OPENDEBUG()
ConfigChecker = {}

if not CURRENT_TIME then
    CURRENT_TIME = os.time()
end

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
        LogInfo('配置表:' .. checkCfg.cfgName .. '.' .. checkCfg.cfgFieldKey .. '.' .. checkCfg.cfgFieldKey2)
    else
        LogInfo('配置表:' .. checkCfg.cfgName .. '.' .. checkCfg.cfgFieldKey)
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
    ---------------------------------------------------------------------
    -- 遍历所有卡牌
    g_fightCardCnt = 0

    for k, v in pairs(cfgs) do
        if v.get_from_gm then
            if CARD_TYPE.FIGHT == v.card_type then
                g_fightCardCnt = g_fightCardCnt + 1
            end
        end

        -- 检查天赋技能
        if v.tfSkills then
            for _, talentId in ipairs(v.tfSkills) do
                local skilCfg = _G['skill'][talentId]
                if not skilCfg then
                    LogInfo(
                            string.format(
                                    'Error Card id: %d, talent skill id: %d in tfSkills not find skill info from skill cfg!',
                                    v.id,
                                    talentId
                            )
                    )
                elseif skilCfg.main_type ~= SkillMainType.CardTalent then
                    LogInfo(
                            string.format(
                                    'Error Card id: %d, talent skill id: %d type is: %d, not：%d error!',
                                    v.id,
                                    talentId,
                                    skilCfg.main_type,
                                    SkillMainType.CardTalent
                            )
                    )
                end
            end
        end

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

        v.skills = skills

        -- 检测转换形态转换相关
        v.notBuyChangeCardIds = {}
        v.changeCardIds = v.changeCardIds or {}
        for _, arr in ipairs(v.changeCardIds) do
            local cfgId = arr[1]
            local openId = arr[2]

            local cfg = cfgs[cfgId]
            if not cfg then
                assert(false, string.format('卡牌id %s 的 changeCardIds 中的卡牌ID %s, 找不到配置', k, cfgId))
            end

            if openId and openId ~= 0 then
                local openCfg = CfgOpenRules[openId]
                if not openCfg then
                    assert(false, string.format('卡牌id %s 的 changeCardIds 中的 openId %s, 找不到配置', k, openId))
                end
            end

            local cpNumArr = {'jcSkills', 'tfSkills', 'tcSkills'}
            for _, f in ipairs(cpNumArr) do
                local lhs = v[f] or {}
                local rhs = cfg[f] or {}
                if #lhs ~= #rhs then
                    assert(false, string.format('卡牌id %s 与 %s 的 %s 字段，长度不相等，转换角色技能需要一样长度', k, cfgId, f))
                end
            end

            if not openId or openId ~= OpenRuleType.Add then
                table.insert(v.notBuyChangeCardIds, arr)
            end
        end

        v.notBuyAllTcSkills = {}
        v.allTcSkills = v.allTcSkills or {}
        for _, arr in ipairs(v.allTcSkills) do
            local skillId = arr[1]
            local openId = arr[2]

            local cfg = skill[skillId]
            if not cfg then
                assert(false, string.format('卡牌id %s 的 allTcSkills 中的技能ID %s, 技能表中找不到配置', k, skillId))
            end

            if openId and openId ~= 0 then
                local openCfg = CfgOpenRules[openId]
                if not openCfg then
                    assert(false, string.format('卡牌id %s 的 allTcSkills 中的 openId %s, 找不到配置', k, openId))
                end
            end

            if not openId or openId ~= OpenRuleType.Add then
                table.insert(v.notBuyAllTcSkills, arr)
            end
        end

        if v.fit_result then
            assert(cfgs[v.fit_result], '卡牌id:' .. v.id .. ' 的 v.fit_result 值：' .. v.fit_result .. ' 在卡牌表找不到对应配置')
        end

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
    g_CardRoleShowCnt = 0

    for id, cfg in pairs(cfgs) do
        ASSERT(cfg.aModels, 'CfgCardRole id：' .. id .. '没填 aModels')

        if character then
            -- 服务器没这个表
            ASSERT(character[cfg.aModels], 'CfgCardRole id：' .. id .. ', 的aModels:' .. '在角色模型表 character 找不到数据。')
        end

        if cfg.bShowInAltas then
            g_CardRoleShowCnt = g_CardRoleShowCnt + 1
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
function ConfigChecker:MainLine(cfgs)
    -- LogDebug("IS_CLIENT:" .. IS_CLIENT)
    g_CalMainLineStarIxs = {}
    g_CalMainLineCount = {}

    for k, v in pairs(cfgs) do
        if v.starIx then
            local arr = GCalHelp:GetTb(g_CalMainLineStarIxs, v.starIx, {})
            table.insert(arr, k)
        end
        if v.group and v.type then
            -- 1剧情副本不算星
            if not v.sub_type or v.sub_type ~= 1 then
                local groupArr = GCalHelp:GetTb(g_CalMainLineCount, v.group, {})
                local typeArr = GCalHelp:GetTb(groupArr, v.type, {})
                table.insert(typeArr, k)
            end
        end

        if v.forceSkill then
            table.sort(v.forceSkill)
        end

        if v.nGroupID then
            -- 直接进入战斗
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

        if v.nBegTime then
            -- 期效副本开始结束时间
            v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
            v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        end

        v.enterLimitHot = (v.enterCostHot or 0) + (v.winCostHot or 0)

        if v.chapterLevel and v.dungeonGroup then
            --乱序演习关卡难度
            local ccc = DungeonGroup[v.dungeonGroup]
            if ccc then
                if not ccc.randomChapters then
                    ccc.randomChapters = {}
                end

                local arr = GCalHelp:GetTb(ccc.randomChapters, v.chapterLevel, {})
                table.insert(arr, v.id)
            else
                ASSERT(false, string.format('没有该关卡组 关卡id：%s 对应的关卡组ID:%s', v.id, v.dungeonGroup))
            end
        end
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
            if monster.grids then
                -- 占多格
                local cfgGrids = MonsterFormation[monster.grids]
                ASSERT(cfgGrids, '没有配置阵型' .. monster.grids)
                -- if cfgGrids.relative == 0 then ASSERT(nil, "怪物占格阵型应该用相对坐标"..formation) end
                for i, coor in ipairs(cfgGrids.coordinate) do
                    local row = coor[1] + v[1]
                    local col = coor[2] + v[2]
                    -- LogDebugEx(string.format("coordinate%s, %s, %s", monsterID, row, col))
                    if cfgGrids.relative == 0 then
                        -- 绝对坐标
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
    g_BuildCenterCfgId = nil

    for _, cfg in pairs(cfgs) do
        if not cfg.needAbilitys then
            cfg.needAbilitys = {}
        end
        buildByType[cfg.type] = cfg

        if cfg.type == BuildsType.ControlTower then
            g_BuildCenterCfgId = cfg.id
        end
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

function ConfigChecker:CfgBControlTowerLvl(cfgs)
    if not IS_SERVER then
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.buildNumLimit = GCalHelp:ArrToMap(cfg.buildNumLimit, 1)
        -- LogTable(cfg, "cfg:")
    end
end

function ConfigChecker:CfgBProductLvl(cfgs)
    if not IS_SERVER then
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.rewardLimits = GCalHelp:ArrToMap(cfg.rewardLimits, 1)
        -- LogTable(cfg, "cfg:")
    end
end

function ConfigChecker:CfgBCompoundLvl(cfgs)
    if not IS_SERVER then
        return
    end

    for _, cfg in pairs(cfgs) do
        if cfg.rewardTimes then
            table.sort(cfg.rewardTimes)
        end
    end
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
    g_EquipBySuit = {}

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

        if cfg.suitId then
            local bySuitId = GCalHelp:GetTb(g_EquipBySuit, cfg.suitId, {})
            local byQuality = GCalHelp:GetTb(bySuitId, cfg.nQuality, {})
            table.insert(byQuality, cfg)
        end
    end

    -- 按照位置排序一下
    for suitId, infoA in pairs(g_EquipBySuit) do
        for quality, equipArr in pairs(infoA) do
            -- 按位置从小到大排序
            table.sort(
                    equipArr,
                    function(lhs, rhs)
                        return lhs.nSlot < rhs.nSlot
                    end
            )

            -- LogTable(equipArr, "equipArr:")
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
    g_CalExcludeSkillIds = {}

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
        if cfg.nExcludeId and cfg.nType == EquipSkillType.Fight and cfg.nGetSkillId then
            g_CalExcludeSkillIds[id] = {nExcludeId = cfg.nExcludeId, nEquipSkillId = id, nSkillId = cfg.nGetSkillId}
        end
    end
end

function CalCardPoolIdByCnt(jCfg)
    local ret = {}
    if jCfg then
        -- LogTable(jCfg, "GobalCfg:CalIdByCnt:")
        for _, v in pairs(jCfg) do
            local cnt, rewardId = v[1], v[2]
            -- 操作次数, 使用id
            if 0 == cnt then
                ret.default = rewardId
            elseif -1 == cnt then
                ret.first10 = rewardId
            else
                ret[cnt] = rewardId
            end
        end
    end

    return ret
end

function ConfigChecker:CfgCardPool(cfgs)
    g_defSelCardPoolIdArr = {}
    g_gobalOpenCardPoolIdArr = {}
    g_fixTimeOpenCardPoolIdArr = {}

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
            -- LogTable(cfg, "ConfigChecker:CfgCardPool cfg:")
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

        if IS_SERVER then
            -- 额外卡池奖励模板
            cfg.rewardIdInfos = CalCardPoolIdByCnt(cfg.jCardsId)

            -- 额外奖励
            cfg.exRewardIdInfos = CalCardPoolIdByCnt(cfg.jReward)

            -- 设置父卡池id
            if cfg.childIds then
                for ix, arr in ipairs(cfg.childIds) do
                    local cId = arr[2]
                    local cCfg = CfgCardPool[cId]
                    cCfg.parentId = id
                end
                table.insert(g_gobalOpenCardPoolIdArr, id)
            end

            if cfg.def_sel_card_ix and cfg.sel_quality and cfg.sel_card_ids then
                if not table.empty(cfg.sel_card_ids) and cfg.def_sel_card_ix <= #cfg.sel_card_ids then
                    if not cfg.nEnd or cfg.nEnd == 0 or cfg.nEnd > CURRENT_TIME then
                        table.insert(g_defSelCardPoolIdArr, id)
                        LogDebug(
                                string.format(
                                        'CardGetLog:CheckInitData() cfg.nStart:%s, cfg.nEnd:%s add to defSelCardPoolIdArr',
                                        cfg.nStart,
                                        cfg.nEnd
                                )
                        )
                    end
                end
            end

            if cfg.nType == CardPoolType.FixTimeFirstLogin then
                table.insert(g_fixTimeOpenCardPoolIdArr, id)
            end
        end
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

function ConfigChecker:CfgExploration(cfgs)
    -- LogTable(cfgs, "ConfigChecker:CfgExploration:")
    for id, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

function ConfigChecker:ItemInfo(cfgs)
    GCfgEquipItemId = {}

    for id, cfg in pairs(cfgs) do
        if cfg.to_item_id then
            ASSERT(cfgs[cfg.to_item_id], string.format('物品id:%s, 的 to_item_id:%s 找不到物品配置信息', id, cfg.to_item_id))
        else
            -- 填了 to_item_id 可以只填 sExpiry 不填 expiryIx
            if cfg.sExpiry then
                cfg.nExpiry = GCalHelp:GetTimeStampBySplit(cfg.sExpiry, cfg)
                ASSERT(cfg.expiryIx, string.format('物品id:%s, 的 sExpiry 与 expiryIx, 必须都填', id))
            end

            if cfg.expiryIx then
                ASSERT(cfg.sExpiry, string.format('物品id:%s, 的 sExpiry 与 expiryIx, 必须都填', id))
            end
        end

        if cfg.exipiry_type then
            if cfg.exipiry_type[1] < 1 or cfg.exipiry_type[1] > 3 then
                ASSERT(false, string.format('物品id:%s, 的 exipiry_type 类型错误', id, cfg.to_item_id))
            end
        end

        if cfg.type == ITEM_TYPE.ICON_FRAME then
            local frameCfg = AvatarFrame[cfg.dy_value2]
            if frameCfg then
                ASSERT(not frameCfg.item_id, string.format('该头像框id=%s已有对应的物品id=%s,头像框配置冲突', cfg.dy_value2, id))
                frameCfg.item_id = id
            else
                ASSERT(false, string.format('头像框表里找不到该物品id:%s对应的头像框id：%s', id, cfg.dy_value2))
            end
        elseif cfg.type == ITEM_TYPE.ICON then
            local avatarCfg = CfgAvatar[cfg.dy_value2]
            if avatarCfg then
                ASSERT(not avatarCfg.item_id, string.format('该头像id=%s已有对应的物品id=%s,头像表配置冲突', cfg.dy_value2, id))
                avatarCfg.item_id = id
            else
                ASSERT(false, string.format('头像表里找不到该物品id:%s对应的头像框id：%s', id, cfg.dy_value2))
            end
        elseif cfg.type == ITEM_TYPE.BG_ITEM then
            local menuBgCfg = CfgMenuBg[cfg.dy_value1]
            if menuBgCfg then
                ASSERT(not menuBgCfg.item_id, string.format('该主界面背景id=%s已有对应的物品id=%s,主界面背景表配置冲突', cfg.dy_value1, id))
                menuBgCfg.item_id = id
            else
                ASSERT(false, string.format('主界面背景表里找不到该物品id:%s对应的主界面背景id：%s', id, cfg.dy_value1))
            end
        elseif cfg.type == ITEM_TYPE.EQUIP then
            if cfg.dy_value1 then
                GCfgEquipItemId[cfg.dy_value1] = id
            end
        elseif cfg.type == ITEM_TYPE.PROP then
            if cfg.dy_value1 == PROP_TYPE.IconFrame then
                local item_id = cfg.dy_arr[1]
                local iconFrameItem = cfgs[item_id]
                ASSERT(
                        iconFrameItem.dy_value2 == cfg.dy_value2,
                        string.format(
                                '头像框道具id:%s的对应的头像框id:%s 与 使用后获得的头像框物品id:%s对应的头像框id：%s 不符',
                                id,
                                cfg.dy_value2,
                                item_id,
                                iconFrameItem.dy_value2
                        )
                )
                ASSERT(
                        iconFrameItem.type == ITEM_TYPE.ICON_FRAME,
                        string.format('道具id:%s的物品对应的头像框物品:%s，类型不对', id, item_id)
                )
            elseif cfg.dy_value1 == PROP_TYPE.Icon then
                local item_id = cfg.dy_arr[1]
                local iconItem = cfgs[item_id]
                ASSERT(
                        iconItem.dy_value2 == cfg.dy_value2,
                        string.format(
                                '头像道具id:%s的对应的头像id:%s 与 使用后获得的头像物品id:%s对应的头像id：%s 不符',
                                id,
                                cfg.dy_value2,
                                item_id,
                                iconItem.dy_value2
                        )
                )
                ASSERT(iconItem.type == ITEM_TYPE.ICON, string.format('道具id:%s的物品对应的头像物品:%s，类型不对', id, item_id))
            -- elseif cfg.dy_value1 == PROP_TYPE.Pet then
            --     ASSERT(CfgPet[cfg.dy_value2], string.format("宠物道具id：%s使用后获得的宠物在宠物表没有对应的id：%s", id, cfg.dy_value2))
            -- elseif cfg.dy_value1 == PROP_TYPE.PetItem then
            --     ASSERT(CfgPetItem[cfg.dy_value2], string.format("宠物道具id：%s使用后获得的宠物物品在宠物物品表没有对应的id：%s", id, cfg.dy_value2))
            -- elseif cfg.dy_value1 == PROP_TYPE.PetArchive then
            --     ASSERT(CfgPetArchive[cfg.dy_value2], string.format("宠物道具id：%s使用后获得的宠物图鉴在宠物图鉴表没有对应的id：%s", id, cfg.dy_value2))
            end
        elseif cfg.type == ITEM_TYPE.VOUCHER then
            if cfg.dy_value1 then
                if not CfgVoucher[cfg.dy_value1] then
                    ASSERT(false, string.format('物品%s 的 dy_value1 配置的抵扣券id, 在 CfgVoucher 表中找不到配置', cfg.id, cfg.dy_value1))
                end
            else
                ASSERT(false, string.format('物品%s的 dy_value1 为抵扣券id，没有填写', cfg.id))
            end
        end

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

function ConfigChecker:AvatarFrame(cfgs)
    for id, cfg in pairs(cfgs) do
        -- id ==1 默认头像框，无对应物品id
        if id ~= 1 then
            ASSERT(cfg.item_id, string.format('头像框id:%s无对应的的物品id,配置不对', id))
        end
    end
end

function ConfigChecker:CfgAvatar(cfgs)
    for id, cfg in pairs(cfgs) do
        -- 道具头像要有对应的物品id
        ASSERT(cfg.item_id, string.format('头像id:%s无对应的的物品id,配置不对', id))
    end
end

function ConfigChecker:CfgMenuBg(cfgs)
    g_MenuBGDefault = {}
    for id, cfg in pairs(cfgs) do
        -- 主界面背景要有对应的物品id
        ASSERT(cfg.item_id, string.format('主界面背景id:%s无对应的的物品id,配置不对', id))
        if cfg.is_Open == 1 then
            table.insert(g_MenuBGDefault, cfg.item_id)
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

function ConfigChecker:CfgDySetOpenCfgs(cfgs)
    for _, cfg in pairs(cfgs) do
        local cfgName = cfg.id
        local cfgStructInfo = ConfigParser.m_mapTableInfo[cfgName]

        cfg.key = nil
        cfg.sheetName = cfgStructInfo.sheetname

        -- 这个控制的字段，后端不一定有，但是前端一定需要有的，因为是更新给前端用的
        if IS_SERVER then
            if cfg.show_ids then
                table.sort(cfg.show_ids)
            end
        else
            -- IS_CLIENT
            -- IS_SERVER
            local fields = cfg.fields
            local checkCfgs = _G[cfgName]

            local _, checkCfg = next(checkCfgs)

            for _, info in pairs(fields) do
                if info.sub_tb then
                    local _, subCheckCfg = next(checkCfg[info.sub_tb])
                    ASSERT(
                            subCheckCfg,
                            string.format('CfgDySetOpenCfgs 配置的表格 %s 的 %s 中的字段 %s 找不到', cfgName, info.sub_tb, info.field)
                    )

                    if not GCalHelp:FindArrByFor(cfgStructInfo.names, info.sub_tb) then
                        ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 找不到', cfgName, info.sub_tb))
                    end

                    if info.sub_index_type then
                        if info.sub_index_type ~= 'number' and info.sub_index_type ~= 'string' then
                            ASSERT(
                                    false,
                                    string.format(
                                            'CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s, sub_index_type 只能是 string or number',
                                            cfgName,
                                            info.field
                                    )
                            )
                        end
                    else
                        ASSERT(
                                false,
                                string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 没有配置 sub_index_type', cfgName, info.sub_tb)
                        )
                    end
                end

                if not info.field_type then
                    ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 field_type 没有配置', cfgName))
                else
                    if
                    info.field_type ~= 'date' and info.field_type ~= 'json' and info.field_type ~= 'number' and
                            info.field_type ~= 'string' and
                            info.field_type ~= 'bool'
                    then
                        ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 不正确', cfgName, info.field_type))
                    end
                end

                if not GCalHelp:FindArrByFor(cfgStructInfo.names, info.field) then
                    ASSERT(false, string.format('CfgDySetOpenCfgs 配置的表格 %s 中的字段 %s 找不到', cfgName, info.field))
                end
            end
        end
    end
end

function ConfigChecker:CfgActiveList(cfgs)
    g_ActiveSign = {}
    g_OpenConditionRecordTime = {}
    for _, fCfg in pairs(cfgs) do
        if fCfg.sTime then
            fCfg.nStartTime = GCalHelp:GetTimeStampBySplit(fCfg.sTime, fCfg)
        end
        if fCfg.eTime then
            fCfg.nEndTime = GCalHelp:GetTimeStampBySplit(fCfg.eTime, fCfg)
        end
        if fCfg.info and fCfg.info.signInId then
            g_ActiveSign[fCfg.info.signInId] = fCfg.id
        end
        if fCfg.time and not table.empty(fCfg.time) then
            table.insert(g_OpenConditionRecordTime, fCfg.id)
        end
    end
end

function ConfigChecker:CfgSpecialDrops(cfgs)
    for _, fCfg in pairs(cfgs) do
        if fCfg.DropsStartTime then
            fCfg.nStartTime = GCalHelp:GetTimeStampBySplit(fCfg.DropsStartTime, fCfg)
        end
        if fCfg.DropsEndTime then
            fCfg.nEndTime = GCalHelp:GetTimeStampBySplit(fCfg.DropsEndTime, fCfg)
        end
    end
end

function ConfigChecker:CfgThemeLayout(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.mFurniture = {}
        for _, info in pairs(cfg.infos) do
            local cfgId = info.cfgID
            local val = cfg.mFurniture[cfgId] or 0
            cfg.mFurniture[cfgId] = val + 1
        end
    end
end

function ConfigChecker:CfgCommodity(cfgs)
    g_CanByShop = {shop = {}, tab = {}}
    g_CheckTimeShop = {shop = {}, tab = {}}

    -- 记录所有需要支付的商品id
    g_ShopIsPayIds = {}

    -- 计算操作
    for id, v in pairs(cfgs) do
        if v.jCosts and v.jCosts[1] and v.jCosts[1][1] and v.jCosts[1][1] == -1 then
            table.insert(g_ShopIsPayIds, id)
        end

        v.limitedTimes = {}
        v.limitedWeek = {}
        v.nDiscountStart = GCalHelp:GetTimeStampBySplit(v.sDiscountStart, v)
        v.nDiscountEnd = GCalHelp:GetTimeStampBySplit(v.sDiscountEnd, v)

        v.nBuyStart = GCalHelp:GetTimeStampBySplit(v.sBuyStart, v)
        v.nBuyEnd = GCalHelp:GetTimeStampBySplit(v.sBuyEnd, v)
        if v.limitedTimeID then
            if v.nBuyStart > 0 or v.nBuyEnd > 0 then
                LogE('CfgCommodity 的 v.id = %s，配置了limitedTimeID，不需要配v.sBuyStart和v.sBuyEnd', v.id)
                break
            end

            local limitedTimes = SplitString(v.limitedTimeID, ',')
            if limitedTimes and #limitedTimes > 0 then
                v.limitedTimes = limitedTimes
                for _, limitedTime in pairs(limitedTimes) do
                    local tarLimit = CfgLimitedTime[tonumber(limitedTime)]
                    if tarLimit then
                        if not v.limitedWeek[tarLimit.week] then
                            v.limitedWeek[tarLimit.week] = {}
                        end
                        v.limitedWeek[tarLimit.week][tarLimit.id] = tarLimit
                    end
                end
            end
            if v.group then
                if v.tabID then
                    if not g_CheckTimeShop.tab[v.group] then
                        g_CheckTimeShop.tab[v.group] = {}
                    end
                    if not g_CheckTimeShop.tab[v.group][v.tabID] then
                        g_CheckTimeShop.tab[v.group][v.tabID] = {}
                    end
                    table.insert(g_CheckTimeShop.tab[v.group][v.tabID], v.id)
                else
                    if not g_CheckTimeShop.shop[v.group] then
                        g_CheckTimeShop.shop[v.group] = {}
                    end
                    table.insert(g_CheckTimeShop.shop[v.group], v.id)
                end
            end
        else
            if v.nBuyEnd == 0 or CURRENT_TIME < v.nBuyEnd then
                if v.group then
                    if v.tabID then
                        if not g_CanByShop.tab[v.group] then
                            g_CanByShop.tab[v.group] = {}
                        end
                        if not g_CanByShop.tab[v.group][v.tabID] then
                            g_CanByShop.tab[v.group][v.tabID] = {}
                        end
                        table.insert(g_CanByShop.tab[v.group][v.tabID], v.id)
                    else
                        if not g_CanByShop.shop[v.group] then
                            g_CanByShop.shop[v.group] = {}
                        end
                        table.insert(g_CanByShop.shop[v.group], v.id)
                    end
                end
            end
        end
    end
end

function ConfigChecker:CfgShopTab(cfgs)
    g_CfgShopTabOpenTime = {}
    for _, v in pairs(cfgs) do
        if not g_CfgShopTabOpenTime[v.group] then
            g_CfgShopTabOpenTime[v.group] = {}
        end
        local pageStartTime = GCalHelp:GetTimeStampBySplit(v.startTime, v)
        local pageEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
        table.insert(g_CfgShopTabOpenTime[v.group], {id = v.id, open_time = pageStartTime, close_time = pageEndTime})
    end
end

function ConfigChecker:CfgShopPage(cfgs)
    g_CfgShopPageOpenTime = {}
    g_CfgShopPageStoreVer = {}

    for _, v in pairs(cfgs) do
        local pageStartTime = GCalHelp:GetTimeStampBySplit(v.openTime, v)
        local pageEndTime = GCalHelp:GetTimeStampBySplit(v.closeTime, v)
        table.insert(
                g_CfgShopPageOpenTime,
                {shop_id = v.id, group_id = nil, open_time = pageStartTime, close_time = pageEndTime}
        )

        v.tabPage = {}

        if v.topGroup then
            if g_CfgShopTabOpenTime[v.topGroup] then
                for _, tabOpenTime in pairs(g_CfgShopTabOpenTime[v.topGroup]) do
                    table.insert(v.tabPage, v.id)
                    table.insert(
                            g_CfgShopPageOpenTime,
                            {
                                shop_id = v.id,
                                group_id = tabOpenTime.id,
                                open_time = tabOpenTime.open_time,
                                close_time = tabOpenTime.close_time
                            }
                    )
                end
            end
        end

        if v.storeVer then
            g_CfgShopPageStoreVer[v.id] = v.storeVer
        end
    end
end

function ConfigChecker:CfgMail(cfgs)
    if IS_CLIENT then
        return
    end

    for _, v in pairs(cfgs) do
        v.start_time = GCalHelp:GetTimeStampBySplit(v.start_time, v)
    end
end

function ConfigChecker:CfgRoleDormitoryEvents(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    GCalHelp:CalArrWeight(cfgs, 'weight', 'sumWeight')

    g_DormNotStoryEvents = {}
    for id, cfg in ipairs(cfgs) do
        if not cfg.story then
            table.insert(g_DormNotStoryEvents, cfg)
        end
    end
    -- LogTable(cfgs, 'CfgRoleDormitoryEvents:')
end

function ConfigChecker:CfgLifeBuffer(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.sFieldName = CfgCardPropertyEnum[cfg.nType].sFieldName
        if cfg.jVal then
            if cfg.sFieldName == 'add_get_item_num' or cfg.sFieldName == 'add_get_item_pct' then
                cfg.jValMap = {}

                -- 这两个是根据掉落id来的，所以弄称map
                for _, arr in ipairs(cfg.jVal) do
                    cfg.jValMap[arr[1]] = table.copy(arr)
                end
            else
                cfg.jValMap = cfg.jVal
            end
        end

        ASSERT(cfg.sFieldName, 'Type id: ' .. cfg.nType .. ' not find sFieldName in CfgCardPropertyEnum')
    end
end

function ConfigChecker:CfgBAssault(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    for i, cfg in pairs(cfgs) do
        GCalHelp:CalArrWeight(cfg.teamInfos, 'weight', 'sumWeight')

        -- 计算好突袭的时间点
        cfg.openTimeStamps = {}
        if cfg.openTimes then
            for _, arr in ipairs(cfg.openTimes) do
                local begHour = arr[1]
                local endHour = arr[2]
                local joinDiff = arr[3]

                local begTime = TimerHelper:CalTimeStamp(nil, nil, nil, begHour, 0, 0)
                local endTime = TimerHelper:CalTimeStamp(nil, nil, nil, endHour, 0, 0)
                local joinDiffTime = endTime - joinDiff

                table.insert(cfg.openTimeStamps, {begTime, endTime, joinDiffTime})
            end
        end
    end
end

function ConfigChecker:CfgActiveRankReward(cfgs)
    for _, cfg in pairs(cfgs) do
        cfg.ranks = {}
        local curRank = 1
        for _, info in ipairs(cfg.infos) do
            for randIndex = curRank, info.maxRank, 1 do
                cfg.ranks[randIndex] = info.rewards
                curRank = randIndex
            end
        end
    end
end

function ConfigChecker:CfgSignReward(cfgs)
    for id, info in pairs(cfgs) do
        info.nBegTime = GCalHelp:GetTimeStampBySplit(info.begTime, info)
        info.nEndTime = GCalHelp:GetTimeStampBySplit(info.endTime, info)
        info.nSendTime = GCalHelp:GetTimeStampBySplit(info.sendTime, info)
    end
end

function ConfigChecker:CfgCardPropertyEnum(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    g_cardFieldToIndex = {}

    for _, cfg in ipairs(cfgs) do
        g_cardFieldToIndex[cfg.sFieldName] = cfg.id
    end
end

function CommSetTaskFirstIdByList(tasks, cfgs)
    --给所有任务赋值任务链的第一个任务id（从第一个任务递归下去）
    for _, cfg in pairs(tasks) do
        --给第一个任务赋值
        local taskCfg = cfgs[cfg.id]
        taskCfg.nFirstTaskId = cfg.id
        --后置任务
        CommSetTaskFirstId(cfg.aNexTasks, cfgs, cfg.id)
    end
end

--给所有任务赋值任务链的第一个任务id（递归设置）
function CommSetTaskFirstId(nextTasks, cfgs, firstId)
    if nextTasks and table.size(nextTasks) > 0 then
        for _, nextTask in pairs(nextTasks) do
            local nextCfg = cfgs[nextTask.id]
            nextCfg.nFirstTaskId = firstId
            CommSetTaskFirstId(nextCfg.aNexTasks, cfgs, firstId)
        end
    end
end

function CommCalCfgTasks(cfgs, t)
    local firstTasks = {}
    local stageFirstTasks = {}
    local stageTasks = {}
    --LogI("eStageTaskType:%s", t)
    local resetTypeTasks = {}

    for _, cfg in pairs(cfgs) do
        if eStageTask[t] then
            if cfg.nStage then
                local old = stageTasks[cfg.nStage] or 0
                stageTasks[cfg.nStage] = old + 1
            end
        end

        if t == eTaskType.RegressionBind then
            local resetType = cfg.type
            if resetType == PeriodType.Day or resetType == PeriodType.Week then
                -- 只有每日或每周刷新的任务才插入
                if not resetTypeTasks[resetType] then
                    resetTypeTasks[resetType] = {}
                end
                table.insert(resetTypeTasks[resetType], cfg)
            end
        end

        if not cfg.nPreTaskId or cfg.nPreTaskId == 0 then
            if eStageTask[t] then
                --LogTable(cfg, "cfg")
                if cfg.nStage then
                    if not stageFirstTasks[cfg.nStage] then
                        stageFirstTasks[cfg.nStage] = {}
                    end
                    table.insert(stageFirstTasks[cfg.nStage], cfg)
                else
                    LogW('阶段类型任务%s：%s 缺少nStage的配置', t, cfg.id)
                end
            else
                -- 设置初始任务id
                table.insert(firstTasks, cfg)
            end
        else
            local preTask = cfgs[cfg.nPreTaskId]
            if preTask then
                if not preTask.aNexTasks then
                    preTask.aNexTasks = {}
                end
                -- 设置后置任务id
                table.insert(preTask.aNexTasks, cfg)
            end
        end
        cfg.nOpenTime = GCalHelp:GetTimeStampBySplit(cfg.sOpenTime, cfg)
        cfg.nCloseTime = GCalHelp:GetTimeStampBySplit(cfg.sCloseTime, cfg)
    end

    if eStageTask[t] then
        --LogTable(stageFirstTasks, "stageFirstTasks")
        cfgs.stageFirstTasks = stageFirstTasks
        cfgs.stageTasks = stageTasks
        for _, v in ipairs(stageFirstTasks) do
            CommSetTaskFirstIdByList(v, cfgs)
        end
    else
        cfgs.aFirstTasks = firstTasks
        CommSetTaskFirstIdByList(firstTasks, cfgs)
    end
    if t == eTaskType.RegressionBind then
        cfgs.resetTypeTasks = resetTypeTasks
    end
end

function ConfigChecker:CfgTaskMain(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Main)
end

function ConfigChecker:CfgTaskSub(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Sub)
end

function ConfigChecker:CfgTaskDaily(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Daily)
end

function ConfigChecker:CfgTaskWeekly(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Weekly)
end

function ConfigChecker:CfgTaskActivity(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Activity)
end

function ConfigChecker:CfgDupTower(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DupTower)
end

function ConfigChecker:CfgTmpDupTower(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.TmpDupTower)
end

function ConfigChecker:CfgDupTaoFa(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DupTaoFa)
end

function ConfigChecker:CfgDupStory(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Story)
end

function ConfigChecker:CfgDupFight(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DupFight)
end

function ConfigChecker:CfgSevenDayTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Seven)
end

function ConfigChecker:CfgSevenDayFinish(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.SevenStage)
end

function ConfigChecker:CfgTaskDayExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.DayExplore)
end

function ConfigChecker:CfgTaskWeekExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.WeekExplore)
end

function ConfigChecker:CfgTaskExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Explore)
end

function ConfigChecker:CfgGuideTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Guide)
end

function ConfigChecker:CfgGuideFinish(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.GuideStage)
end

function ConfigChecker:CfgNewYearFinish(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.NewYearFinish)
end

function ConfigChecker:CfgRegressionTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.RegressionTask)
end

function ConfigChecker:CfgNewYearTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.NewYear)
end

function ConfigChecker:CfgRegressionFundTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Regression)
end

function ConfigChecker:CfgRogueTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Rogue)
end

-- function ConfigChecker:CfgRegressionBind(cfgs)
--     if IS_CLIENT then
--         -- IS_SERVER
--         return
--     end

--     CommCalCfgTasks(cfgs, eTaskType.RegressionBind)
-- end

-- function ConfigChecker:CfgRegressionBindStage(cfgs)
--     if IS_CLIENT then
--         -- IS_SERVER
--         return
--     end

--     CommCalCfgTasks(cfgs, eTaskType.RegressionBindStage)
-- end

function ConfigChecker:CfgTotalBattleTask(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.StarPalace)
end

function ConfigChecker:CfgPetArchive(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    CommCalCfgTasks(cfgs, eTaskType.Pet)
end

function ConfigChecker:CfgExtraExploration(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)
    end
end

function ConfigChecker:CfgTaskFinishVal(cfgs)
    local sN = 2
    local eN = 10
    for _, fCfg in pairs(cfgs) do
        for n = sN, eN, 1 do
            local sField = 'aVal' .. n
            local cfgArr = fCfg[sField]
            if cfgArr then
                table.sort(cfgArr)
            end
        end
    end
end

function ConfigChecker:CfgFurniture(cfgs)
    -- for k, cfg in pairs(cfgs) do
    -- end
end

-- 计算主题表的舒适度和价格
function ConfigChecker:CfgFurnitureTheme(cfgs)
    for k, cfg in pairs(cfgs) do
        local comfort, price_1, price_2 = 0, 0, 0
        local id1, id2 = nil, nil
        local layoutCfg = CfgThemeLayout[cfg.layoutId]
        if (layoutCfg) then
            for n, m in ipairs(layoutCfg.infos) do
                local furCfg = CfgFurniture[m.cfgID]
                if (not furCfg.special) then
                    comfort = comfort + furCfg.comfort
                    price_1 = price_1 + furCfg.price_1[1][2]
                    price_2 = price_2 + furCfg.price_2[1][2]
                    if (id1 == nil) then
                        id1, id2 = furCfg.price_1[1][1], furCfg.price_2[1][1]
                    end
                end
            end
        end

        cfg.comfort = comfort
        cfg.price_1 = {{id1, price_1}}
        cfg.price_2 = {{id2, price_2}}
    end
end

-- 家具类型表重新排序
function ConfigChecker:CfgFurnitureEnum(cfgs)
    table.sort(
            cfgs,
            function(a, b)
                return a.index < b.index
            end
    )
end

function ConfigChecker:CardExpAddRand(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    -- 卡牌经验暴击表特殊处理
    GCalHelp:CalArrWeight(cfgs, 'weight', 'sumWeight')
end

function ConfigChecker:CfgEquipExpRand(cfgs)
    if IS_CLIENT then
        -- IS_SERVER
        return
    end

    -- 装备经验暴击表特殊处理
    GCalHelp:CalArrWeight(cfgs, 'nWeight', 'sumWeight')
end

function ConfigChecker:CfgDupDropCntAdd(cfgs)
    -- 累计总共添加的次数
    g_AddDupMultiCnt = 0
    g_ReCalAddDupMultiTime = nil

    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)

        local isInRange = GLogicCheck:IsInRange(cfg.nStart, cfg.nEnd, CURRENT_TIME, true)
        if isInRange and cfg.dropAddCnt and not cfg.regressionType then
            g_AddDupMultiCnt = g_AddDupMultiCnt + cfg.dropAddCnt
            if cfg.nEnd ~= 0 then
                -- 开启的判断结束时间，保存最小的需要计算时间
                if not g_ReCalAddDupMultiTime or cfg.nEnd < g_ReCalAddDupMultiTime then
                    g_ReCalAddDupMultiTime = cfg.nEnd
                end
            end
        else
            -- 只需要查看还没开启的
            if cfg.nStart > CURRENT_TIME then
                if not g_ReCalAddDupMultiTime or cfg.nStart < g_ReCalAddDupMultiTime then
                    g_ReCalAddDupMultiTime = cfg.nStart
                end
            end
        end
    end

    LogDebug(
            'ConfigChecker:CfgDupDropCntAdd() g_AddDupMultiCnt:%s, g_ReCalAddDupMultiTime:%s',
            g_AddDupMultiCnt,
            g_ReCalAddDupMultiTime
    )
end

function ConfigChecker:CfgDupConsumeReduce(cfgs)
    -- 累计减少体力消耗百分比
    g_DupConsumeReduce = 0
    g_ReCalDupConRedTime = nil

    for _, cfg in pairs(cfgs) do
        cfg.nStart = GCalHelp:GetTimeStampBySplit(cfg.startTime, cfg)
        cfg.nEnd = GCalHelp:GetTimeStampBySplit(cfg.endTime, cfg)

        local isInRange = GLogicCheck:IsInRange(cfg.nStart, cfg.nEnd, CURRENT_TIME, true)
        if isInRange and not cfg.regressionType then
            g_DupConsumeReduce = g_DupConsumeReduce + cfg.consumeReduce
            if cfg.nEnd ~= 0 then
                -- 开启的判断结束时间，保存最小的需要计算时间
                if not g_ReCalDupConRedTime or cfg.nEnd < g_ReCalDupConRedTime then
                    g_ReCalDupConRedTime = cfg.nEnd
                end
            end
        else
            -- 只需要查看还没开启的
            if cfg.nStart > CURRENT_TIME then
                if not g_ReCalDupConRedTime or cfg.nStart < g_ReCalDupConRedTime then
                    g_ReCalDupConRedTime = cfg.nStart
                end
            end
        end
    end

    LogDebug(
            'ConfigChecker:CfgDupConsumeReduce() g_DupConsumeReduce:%s, g_ReCalDupConRedTime:%s',
            g_DupConsumeReduce,
            g_ReCalDupConRedTime
    )
end

function ConfigChecker:global_setting(cfgs)
    LogDebugEx('load global_setting:')
    for k, v in pairs(cfgs) do
        if v.key ~= '' then
            LogDebugEx('load global_setting:' .. v.key)
            local val = ConfigParser:FormatValue(v.value, v.type)

            -- print(IS_CLIENT, v.user, v.user == 1)
            if IS_CLIENT and (v.user == 1 or not v.user) then
                _G[v.key] = val
            elseif IS_SERVER and (v.user == 2 or not v.user) then
                _G[v.key] = val
                Loader:AddReplaceFile(v.key)
            end
        end
    end
    -- LogDebug("global_setting: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
    table.sort(g_BuildTradeFlushTimes)
    -- LogTable(g_BuildTradeFlushTimes, "g_BuildTradeFlushTimes:")

    table.sort(g_WeekHoliday)
    -- LogTable(g_WeekHoliday, "g_WeekHoliday:")

    table.sort(g_ArmyFightListScoreRange)

end

function ConfigChecker:CfgAchieve(cfgs)
    local achievementFinishIds = {}
    for cfgid, cfg in pairs(cfgs) do
        local aFinishIds = cfg.aFinishIds
        if not aFinishIds then
            LogError('CfgAchieve id:%s 的aFinishIds不允许为空', cfgid)
        end

        local aFinishId = aFinishIds[1]
        local finishCount = aFinishIds[2]
        if not aFinishId then
            LogError('CfgAchieve id:%s 的条件Id不允许为空', cfgid)
        end
        if not finishCount then
            LogError('CfgAchieve id:%s 的完成次数不允许为空', cfgid)
        end

        if not achievementFinishIds[aFinishId] then
            achievementFinishIds[aFinishId] = {}
        end
        cfg.aFinishId = aFinishId
        cfg.finishCount = finishCount
        table.insert(achievementFinishIds[aFinishId], cfgid)
    end
    cfgs.achievementFinishIds = achievementFinishIds
end

function ConfigChecker:CfgAchieveFinishVal(cfgs)
    local achieveGroup = {}
    for cfgid, cfg in pairs(cfgs) do
        local nType = cfg.nType
        if not nType then
            LogError('CfgAchieveFinishVal id:%s 的nType不允许为空', cfgid)
        end
        if cfg.aVal2 then
            table.sort(cfg.aVal2)
        end

        local group = eAchieveFinishType.GetTypeById(nType)

        if not achieveGroup[group] then
            achieveGroup[group] = {}
        end
        table.insert(achieveGroup[group], cfgid)
    end
    cfgs.achieveGroup = achieveGroup
end

function ConfigChecker:CfgBadge(cfgs)
    local badgedFinishIds = {}
    for cfgid, cfg in pairs(cfgs) do
        local aFinishIds = cfg.aFinishIds
        if not aFinishIds then
            LogError('CfgBadge id:%s 的aFinishIds不允许为空', cfgid)
        end

        local aFinishId = aFinishIds[1]
        local finishCount = aFinishIds[2]
        if not aFinishId then
            LogError('CfgBadge id:%s 的条件Id不允许为空', cfgid)
        end
        if not finishCount then
            LogError('CfgBadge id:%s 的完成次数不允许为空', cfgid)
        end

        if not badgedFinishIds[aFinishId] then
            badgedFinishIds[aFinishId] = {}
        end
        cfg.aFinishId = aFinishId
        cfg.finishCount = finishCount
        table.insert(badgedFinishIds[aFinishId], cfgid)
    end
    cfgs.badgedFinishIds = badgedFinishIds
end

function ConfigChecker:CfgBadgeFinishVal(cfgs)
    local badgedGroup = {}
    for cfgid, cfg in pairs(cfgs) do
        local nType = cfg.nType
        if not nType then
            LogError('CfgBadgeFinishVal id:%s 的nType不允许为空', cfgid)
        end
        if cfg.aVal2 then
            table.sort(cfg.aVal2)
        end
        local group = eBadgedFinishType.GetTypeById(nType)

        --LogI("group:%s", group)

        if not badgedGroup[group] then
            badgedGroup[group] = {}
        end
        table.insert(badgedGroup[group], cfgid)
    end
    cfgs.badgedGroup = badgedGroup
end

function ConfigChecker:CfgReturningActivity(cfgs)
    for returnType, cfg in pairs(cfgs) do
        for idx, ccc in pairs(cfg.infos) do
            if ccc.activityId then
                if ccc.type == RegressionActiveType.DropAdd then
                    ASSERT(
                            CfgDupDropCntAdd[ccc.activityId],
                            string.format(
                                    'CfgReturningActivity id:%s, sub index:%s 填写的活动关联ID(%s)在掉落次数加成表CfgDupDropCntAdd里找不到',
                                    returnType,
                                    idx,
                                    ccc.activityId
                            )
                    )
                    ccc.relateCfg = CfgDupDropCntAdd[ccc.activityId]
                elseif ccc.type == RegressionActiveType.ConsumeReduce then
                    ASSERT(
                            CfgDupConsumeReduce[ccc.activityId],
                            string.format(
                                    'CfgReturningActivity id:%s, sub index:%s 填写的活动关联ID(%s)在体力消耗减少表CfgDupConsumeReduce里找不到',
                                    returnType,
                                    idx,
                                    ccc.activityId
                            )
                    )
                    ccc.relateCfg = CfgDupConsumeReduce[ccc.activityId]
                elseif ccc.type == RegressionActiveType.Banner then
                    -- 回归卡池
                    local cardPoolCfg = CfgCardPool[ccc.activityId]
                    if not cardPoolCfg or cardPoolCfg.nType ~= CardPoolType.Regression then
                        ASSERT(
                                false,
                                string.format(
                                        'CfgReturningActivity id:%s, sub index:%s 填写的对应的卡池id：%s找不到配置或者卡池类型不是%s[CardPoolType.Regression].',
                                        returnType,
                                        idx,
                                        ccc.activityId,
                                        CardPoolType.Regression
                                )
                        )
                    end
                end
            end
        end
    end
end

function ConfigChecker:CfgItemPoolReward(cfgs)
    for id, cfg in pairs(cfgs) do
        cfg.roundPool = {}
        local roundPool = cfg.roundPool
        for idx, v in pairs(cfg.pool) do
            for _, round in ipairs(v.rounds) do
                if not roundPool[round] then
                    roundPool[round] = {}
                end
                roundPool[round][idx] = v
            end
        end
    end
end

function ConfigChecker:CfgItemPool(cfgs)
    for id, cfg in pairs(cfgs) do
        if cfg.Proptype == 1 then
            ASSERT(cfg.starttime, string.format('道具池活动表 CfgItemPool, id %s 没有配置 starttime', id))
            ASSERT(cfg.endtime, string.format('道具池活动表 CfgItemPool, id:%s 没有配置 endTime', id))

            cfg.nStartTime = GCalHelp:GetTimeStampBySplit(cfg.starttime, cfg)
            cfg.nEndTime = GCalHelp:GetTimeStampBySplit(cfg.endtime, cfg)
        end
    end
end
function ConfigChecker:DungeonGroup(cfgs)
    for id, cfg in pairs(cfgs) do
        if cfg.group == 11001 then
            -- 乱序演习词条数量检查
            local buffnum = cfg.buffNum
            if buffnum ~= #cfg.Num then
                ASSERT(false, string.format('乱序演习关卡组表，词条池数量buffNum(%s)与选择数量Num长度(%s)对不上 ', buffnum, #cfg.Num))
            end

            for i = 1, buffnum do
                local buffPond = cfg['buffPond' .. i]
                if not buffPond then
                    ASSERT(false, string.format('乱序演习关卡组表，词条池数量buffNum为(%s)，但没有配置第%s词条池 ', buffnum, i))
                end

                if cfg.Num[i] > #buffPond then
                    ASSERT(
                            false,
                            string.format('乱序演习关卡组表，第%s词条池词条数量（%s）不足以随机词条，至少需要的词条数量：%s ', i, #buffPond, cfg.Num[i])
                    )
                end
            end
        end
    end
end

function ConfigChecker:CfgTotalBattle(cfgs)
    for _, cfg in pairs(cfgs) do
        if cfg.infos then
            for _, v in pairs(cfg.infos) do
                if v.begTime then
                    v.nBegTime = GCalHelp:GetTimeStampBySplit(v.begTime, v)
                end
                if v.endTime then
                    v.nEndTime = GCalHelp:GetTimeStampBySplit(v.endTime, v)
                end
            end
        end
    end
end

function ConfigChecker:CfgRogueBuff(cfgs)
    for _, cfg in pairs(cfgs) do
        if not cfg.skillId and not cfg.buffId then
            assert(false, string.format("词条表，CfgRogueBuff id:%s 没有配对应的技能或BUFF", cfg.id))
        end

        if cfg.lifeType == 2 then
            assert(cfg.lifeValue, string.format("词条表，CfgRogueBuff id:%s 没有配对应的词条生命参数", cfg.id))
        end

        if cfg.target == 3 or cfg.target == 4 then
            -- 我方随机或敌方随机，需要配对应的随机个数
            assert(cfg.targetValue, string.format("词条表，CfgRogueBuff id:%s 没有配对应的对象参数", cfg.id))
        end

        if cfg.preConditions then
            assert(cfg.preConditionsValue, string.format("词条表，CfgRogueBuff id:%s 没有配对应的前置条件参数", cfg.id))
        end

        if not cfg.probability then
            assert(false, string.format("词条表，CfgRogueBuff id:%s 没有配出现概率", cfg.id))
        end

    end
end
