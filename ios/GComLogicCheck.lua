GLogicCheck = {}

--判断名字长度
function GLogicCheck:PlrNameLen(name)
    if not name then
        return false
    end

    -- local len, _ = self:GetStringLen(name)
    local len = name:len()
    -- LogDebug("GetStringLen len: %d, g_PlayerNameLenMax: %d", len, g_PlayerNameLenMax)
    if len > g_PlayerNameLenMax or len < 1 then
        return false
    end

    return true
end

--获取字符串长度和字符数组
function GLogicCheck:GetStringLen(inputStr)
    if not inputStr or type(inputStr) ~= 'string' or #inputStr <= 0 then
        return 0, ''
    end

    local length = 0
    local i = 1
    local chars = {}
    while (true) do
        local curByte = string.byte(inputStr, i)
        local byteCount = 1
        if (curByte > 239) then
            byteCount = 4
        elseif (curByte > 223) then
            byteCount = 3
        elseif (curByte > 128) then
            byteCount = 2
        else
            byteCount = 1
        end
        local char = string.sub(inputStr, i, i + byteCount - 1)
        table.insert(chars, char)
        i = i + byteCount
        length = length + 1
        if i > #inputStr then
            break
        end
    end
    return length, chars
end

-------------------------------------------------------------------------------------------------------------------
--

function GLogicCheck:InsertItem(sItem, ret, selectIndex, deep)
    if sItem.type == RandRewardType.TEMPLATE then
        for i = 1, sItem.count do
            if deep == 1 then
                local tmp = {}
                self:GetRewardListMaxItem(sItem.id, tmp, selectIndex, deep + 1)
                table.insert(ret, tmp)
            else
                self:GetRewardListMaxItem(sItem.id, ret, selectIndex, deep + 1)
            end
        end
    else
        if deep == 1 then
            local tmp = {}
            table.insert(tmp, {id = sItem.id, type = sItem.type, num = sItem.count, costs = sItem.costs})
            table.insert(ret, tmp)
        else
            table.insert(ret, {id = sItem.id, type = sItem.type, num = sItem.count, costs = sItem.costs})
        end
    end
end

function GLogicCheck:GetRewardListMaxItem(rewardID, ret, selectIndex, deep)
    deep = deep or 1
    selectIndex = selectIndex or 1

    -- LogDebugEx("GLogicCheck:GetRewardListMaxItem", rewardID)

    local ret = ret or {}
    local config = RewardInfo[rewardID]
    -- DT(config)
    if not config then
        LogDebugEx('not reward config', rewardID)
        return ret
    end

    if config.type == RewardRandomType.SINGLE_SELECT then
        local sItem = config.item[selectIndex]
        if not sItem then
            LogError('select reward use index %d not find', selectIndex)
            return
        end

        self:InsertItem(sItem, ret, selectIndex, deep)
    else
        if config.type == RewardRandomType.FIXED then
            if deep == 1 then
                local tmp = {}
                for _, v in ipairs(config.item) do
                    self:InsertItem(v, tmp, selectIndex, deep + 1)
                end
                table.insert(ret, tmp)
            else
                for _, v in ipairs(config.item) do
                    self:InsertItem(v, ret, selectIndex, deep + 1)
                end
            end
        else
            for _, v in ipairs(config.item) do
                self:InsertItem(v, ret, selectIndex, deep)
            end
        end
    end

    return ret
end

----------------------------------------------------------------------------------------------------
-- 检查礼包是否够空间, 使用
-- checkType: 检查的类型，如下类型
-- -- RandRewardType.CARD = 3 --：卡牌
-- -- RandRewardType.EQUIP = 4 --：装备
-- leftSapce: 可用空间
-- rewardId: rewardId, 掉落的id
-- count : 掉落的次数

--
-- return
-- true ：表示空间足够
-- false : 空间不足
function GLogicCheck:CheckRewardCapacity(checkType, leftSapce, rewardId, count, selectIndex)
    if checkType ~= RandRewardType.CARD and checkType ~= RandRewardType.EQUIP then
        LogError('not support type')
        return false
    end

    if not count or count < 1 then
        LogError('count: %d error', count)
        return false
    end

    local ret = {}
    for i = 1, count, 1 do
        if i == 1 then
            self:GetRewardListMaxItem(rewardId, ret, selectIndex)
        else
            local curRet = self:GetRewardListMaxItem(rewardId, nil, selectIndex)
            for _, val in ipairs(curRet) do
                table.insert(ret, val)
            end
        end
    end

    local getLen = #ret
    -- LogDebug("GetRewardListMaxItem(reward id:%d) return item len: %d", rewardId, getLen)
    -- LogTable(ret)

    for _, items in ipairs(ret) do
        local hadCnt = 0
        for _, item in ipairs(items) do
            if item.type == checkType then
                hadCnt = hadCnt + 1
                if hadCnt > leftSapce then
                    return false
                end
            else
                if checkType == RandRewardType.CARD and item.type == RandRewardType.ITEM then
                    -- 检查是不是卡牌物品
                    local itemCfg = ItemInfo[item.id]
                    if itemCfg.type == ITEM_TYPE.CARD then
                        hadCnt = hadCnt + 1
                        if hadCnt > leftSapce then
                            return false
                        end
                    end
                end
            end
        end
    end

    return true
end

----------------------------------------------------------------------------------------------------
-- 统计掉落的列表，里面各项物品的数量
--
function GLogicCheck:CountRewardCnt(rewardList)
    local ret = {
        [RandRewardType.ITEM] = 0,
        [RandRewardType.CARD] = 0,
        [RandRewardType.EQUIP] = 0
    }

    -- LogTable(ret, "GLogicCheck:CountRewardCnt ret")
    -- LogTable(rewardList, "GLogicCheck:CountRewardCnt rewardList")

    for _, v in ipairs(rewardList) do
        if not v.type or v.type == RandRewardType.ITEM then
            v.type = RandRewardType.ITEM
            local config = ItemInfo[v.id]
            if not config then
                LogError('GLogicCheck:CountRewardCnt() not find item id: %d', v.id)
            else
                if config.type == ITEM_TYPE.CARD then
                    ret[RandRewardType.CARD] = ret[RandRewardType.CARD] + 1
                else
                    ret[RandRewardType.ITEM] = ret[RandRewardType.ITEM] + 1
                end
            end
        else
            ret[v.type] = ret[v.type] + 1
        end
    end

    return ret
end

----------------------------------------------------------------------------------------------------
-- 检查两个建筑是否有交集
-- rhsPos ： 左上起点坐标
-- rhsArea ： 建筑区域
-- rhsSapce ： 建筑覆盖区域大小，包含建筑区域
-- lhsPos ： 被检测建筑的左下起点坐标
-- lhsArea ： 被检测建筑的建筑区域
function GLogicCheck:RectInCross(rhsPos, rhsArea, rhsSapce, lhsPos, lhsArea)
    -- LogTable(rhsPos, "rhsPos:")
    -- LogTable(rhsArea, "rhsArea:")
    -- LogTable(rhsSapce, "rhsSapce:")
    -- LogTable(lhsPos, "lhsPos:")
    -- LogTable(lhsArea, "lhsArea:")

    local dotAX = rhsPos[1] + rhsArea[1] / 2
    local dotAY = rhsPos[2] + rhsArea[2] / 2

    local dotBX = lhsPos[1] + lhsArea[1] / 2
    local dotBY = lhsPos[2] + lhsArea[2] / 2
    -- LogDebug("dotAX:%s, dotAY:%s, dotBX:%s, dotBY:%s.", dotAX, dotAY, dotBX, dotBY)

    local diffX = math.abs(dotAX - dotBX)
    local spaceX = (rhsSapce[1] / 2 + lhsArea[1] / 2)

    local diffY = math.abs(dotAY - dotBY)
    local spaceY = (rhsSapce[2] / 2 + lhsArea[2] / 2)
    -- LogDebug("diffX:%s, spaceX:%s, diffY:%s, spaceY:%s.", diffX, spaceX, diffY, spaceY)

    if diffX < spaceX and diffY < spaceY then
        return true
    end

    return false
end

----------------------------------------------------------------------------------------------------
-- [升级经验，强化经验]
function GLogicCheck:GetItemExp(itemId)
    local ret = {0, 0}
    local cfg = ItemInfo[itemId]
    if not cfg then
        return ret
    end

    if cfg.type ~= ITEM_TYPE.PROP then
        return ret
    end

    if cfg.dy_value1 ~= ITEM_TYPE.ExpMaterial then
        return ret
    end

    ret[1] = cfg.dy_tb[1] or 0
    ret[2] = cfg.dy_tb[2] or 0
    return ret
end

----------------------------------------------------------------------------------
-- 判断是否再范围内 min <= val <= max
-- zeroIsEmpty: val 为 0 时候，表示不判断
function GLogicCheck:IsInRange(min, max, val, zeroIsEmpty)
    local isUse = true

    if zeroIsEmpty then
        if min and min > 0 then
            if val < min then
                isUse = false
            end
        end

        if max and max > 0 then
            if val > max then
                isUse = false
            end
        end
    else
        if min then
            if val < min then
                isUse = false
            end
        end

        if max then
            if val > max then
                isUse = false
            end
        end
    end
    -- LogDebug("min:%s max:%s val:%s, isUse:%s", min, max, val, isUse)
    return isUse
end

----------------------------------------------------------------------------------
-- 任务是否还在有效期
function GLogicCheck:TaskIsPassTimeLimit(cfg)
    if cfg.nOpenTime == 0 then
        return true
    elseif cfg.nCloseTime == 0 then
        if CURRENT_TIME >= cfg.nOpenTime then
            return true
        end
    end

    local isOk = self:IsInRange(cfg.nOpenTime, cfg.nCloseTime, CURRENT_TIME)
    return isOk
end

----------------------------------------------------------------------------------
-- [[9,9], [11, 12]]
function GLogicCheck:TeamBossIsInOpenHour(cfg)
    if IS_CLIENT then
        return false
    end

    -- 开启时间检查
    local curWeek = CommDataMgr:GetCurWeek()
    local openId = cfg.timeArr[curWeek]
    if not openId then
        return false
    end

    local openHoursCfg = CfgTeamBossTimePool[openId]
    if not openHoursCfg then
        return false
    end

    local curHour = CommDataMgr:GetCurHour()

    return self:IsInOpenHour(openHoursCfg.timeArr, curHour)
end

----------------------------------------------------------------------------------
-- [[9,9], [11, 12]]
function GLogicCheck:IsInOpenHour(openHours, curHour)
    -- LogTable(openHours, "GLogicCheck:IsInOpenHour: " .. curHour .. ":")

    if not openHours then
        return false
    end

    for _, timeArr in ipairs(openHours) do
        if GLogicCheck:IsInRange(timeArr[1], timeArr[2], curHour) then
            return true
        end
    end

    return false
end

----------------------------------------------------------------------------------
-- 测量装备随机属性是否合格，不合格会改变里面的值
function GLogicCheck:EquipRandTypeVal(euipCfgId, infos)
    if not infos or table.empty(infos) then
        infos.rand_skill_type = nil
        infos.rand_skill_value = nil
        return
    end

    if not infos.rand_skill_type then
        infos.rand_skill_type = nil
        infos.rand_skill_value = nil
        return
    end

    if not CfgEquipSkillTypeEnum[infos.rand_skill_type] then
        LogError(
            'GLogicCheck:EquipRandTypeVal(cfgid:%s, type:%s), 使用的属性类型在 CfgEquipSkillTypeEnum 中获取不到',
            euipCfgId,
            infos.rand_skill_type
        )

        infos.rand_skill_type = nil
        infos.rand_skill_value = nil
        return
    end

    local equipCfg = CfgEquip[euipCfgId]

    local randValueCfg = CfgEquipRandTypeVal[equipCfg.nStart]
    if randValueCfg then
        if infos.rand_skill_value < randValueCfg.nMin then
            infos.rand_skill_value = randValueCfg.nMin
        end

        if infos.rand_skill_value > randValueCfg.nMax then
            infos.rand_skill_value = randValueCfg.nMax
        end
    else
        infos.rand_skill_value = 0
        LogError(
            'GLogicCheck:EquipRandTypeVal(cfgid:%s, start:%s) can not find cfg by id:%d from CfgEquipRandTypeVal',
            euipCfgId,
            equipCfg.nStart
        )
    end
end

--
-- 剧情是否通过
function GLogicCheck:StoryIsOpen(storyCfg, roleData)
    if not storyCfg.unlock_id then
        return true
    end

    local unLockCfg = CfgCardRoleUnlock[storyCfg.unlock_id]
    if not unLockCfg then
        return false
    end

    if roleData.lv < unLockCfg.value then
        return false
    end

    return true
end

-- args:
---- cfgId:
---- expiryIx:（物品的过期值，物品信息有返回)
---- curTime: 当前时间戳（秒）

-- return:
---- 过期返回 true
function GLogicCheck:CheckItemExpiry(cfgId, expiryIx, curTime)
    if not expiryIx then
        return false
    end

    local cfg = ItemInfo[cfgId]
    return self:CheckItemExpiryByCfg(cfg, expiryIx, curTime)
end

function GLogicCheck:CheckItemExpiryByCfg(cfg, expiryIx, curTime)
    if not expiryIx or not cfg.expiryIx then
        return false
    end

    if expiryIx < cfg.expiryIx then
        return true
    end

    if curTime >= cfg.nExpiry then
        return true
    end
end

--------------------------------------------------------------------------------------------------------------------------------------------
--
function GLogicCheck:CheckArmyAddJoinCnt(info)
    -- 遍历要更新的时间
    local isChagne = false
    -- local curHour = 0
    local curHour = CommDataMgr:GetCurHour()
    local curYDay = CommDataMgr:GetCurYDay()
    LogDebug('')
    LogDebug('CheckArmyAddJoinCnt() curHour:%s, curYDay:%s', curHour, curYDay)

    local nextFlushHour = nil

    -- LogTable(g_ArmyPracticeJoinCntFlushTime, 'CPracticeMgr:CheckArmyAddJoinCnt() g_ArmyPracticeJoinCntFlushTime:')
    -- LogTable(info.can_join_cnt_flush_log, "CPracticeMgr:CheckArmyAddJoinCnt() info.can_join_cnt_flush_log:")
    for index, hour in ipairs(g_ArmyPracticeJoinCntFlushTime) do
        local preYDay = info.can_join_cnt_flush_log[index]

        LogDebug(
            'CheckArmyAddJoinCnt() index:%s, preYDay:%s, hour:%s g_ArmyPracticeJoinCntFlushCnt:%s',
            index,
            preYDay,
            hour,
            g_ArmyPracticeJoinCntFlushCnt
        )

        local addCnt = 0
        if not preYDay then
            addCnt = 1

            if curHour >= hour then
                info.can_join_cnt_flush_log[index] = curYDay
            else
                info.can_join_cnt_flush_log[index] = curYDay - 1
            end
        elseif curYDay > preYDay then
            -- 天数
            local difDay = curYDay - preYDay
            if difDay > 1 then
                addCnt = difDay - 1
                info.can_join_cnt_flush_log[index] = curYDay - 1
            end

            -- LogDebug('CheckArmyAddJoinCnt() preYDay:%s, difDay:%s, addCnt:%s', preYDay, difDay, addCnt)
            if curHour >= hour then
                -- LogDebug('CheckArmyAddJoinCnt() A curHour:%s, hour:%s, addCnt:%s', curHour, hour, addCnt)
                addCnt = addCnt + 1
                info.can_join_cnt_flush_log[index] = curYDay
            else
                -- 下次刷新时间就是这个了
                nextFlushHour = hour
            end
        end

        -- LogDebug('CheckArmyAddJoinCnt() B curHour:%s, hour:%s, addCnt:%s', curHour, hour, addCnt)

        -- 查看玩家是是否更新过了，没有就更新下
        if addCnt > 0 then
            isChagne = true
            info.can_join_cnt = info.can_join_cnt + addCnt * g_ArmyPracticeJoinCntFlushCnt

            LogDebug(
                'GLogicCheck:CheckArmyAddJoinCnt add addCnt:%s * g_ArmyPracticeJoinCntFlushCnt:%s=%s',
                addCnt,
                g_ArmyPracticeJoinCntFlushCnt,
                addCnt * g_ArmyPracticeJoinCntFlushCnt
            )
        end
    end

    if not nextFlushHour then
        nextFlushHour = g_ArmyPracticeJoinCntFlushTime[1]
    end

    info.t_join_cnt = CommDataMgr:CalNextResetTime(nextFlushHour)

    if info.can_join_cnt > g_ArmyPracticeJoinCnt then
        info.can_join_cnt = g_ArmyPracticeJoinCnt
    end

    return isChagne
end

--------------------------------------------------------------------------------------------------------------------------------------------
--
function GLogicCheck:FlushArmy(info)
    local isChagne = false
    local tNextFlush = GCalHelp:CheckGetVal(info.can_join_cnt_flush_log, 0, 'tFlush')
    if CURRENT_TIME > tNextFlush then
        info.flush_cnt = 0 -- 重置对手刷新次数
        info.can_join_buy_cnt = 0
        isChagne = true

        info.can_join_cnt_flush_log.tFlush = CommDataMgr:GetActiveZeroTime()
    end

    if self:CheckArmyAddJoinCnt(info) then
        isChagne = true
    end

    -- LogTrace("Set rank")
    -- info.rank_level = 6999987
    -- LogDebug("Set rank lv:%s", info.rank_level)

    -- LogTable(info, 'GLogicCheck:FlushArmy() info:')

    return isChagne
end

--------------------------------------------------------------------------------------------------------------------------------------------
--
function GLogicCheck:CalRankLevel(info)
    assert(info.rank_level > 0)

    local lcnt = 0
    local coin = 0

    if info.rank_level < 1 or not CfgPracticeRankLevel[info.rank_level] then
        LogError('Not find cfg in CfgPracticeRankLevel lv is:%s', info.rank_level)
        return
    end

    if info.rank_level >= #CfgPracticeRankLevel then
        LogTable(info, 'CalRankLevel()', 'had get max rank lv!')
        return
    end

    -- 计算段位
    local upCfg = CfgPracticeRankLevel[info.rank_level]
    while (upCfg and upCfg.nScore and upCfg.nScore > 0 and info.score >= upCfg.nScore) do
        -- 奖励代币
        upCfg = CfgPracticeRankLevel[info.rank_level + 1]
        if upCfg then
            coin = coin + upCfg.nGetCoin
            -- LogDebug(
            --     'info.score:%s, info.rank_level:%s, upCfg.nGetCoin:%s',
            --     info.score,
            --     info.rank_level,
            --     upCfg.nGetCoin
            -- )

            info.rank_level = info.rank_level + 1
            if info.rank_level > info.max_rank_level then
                info.max_rank_level = info.rank_level
            end
        end

        lcnt = lcnt + 1
        if lcnt > 100 then
            LogError('CPracticeMgr:CalRankLevel() loop more than 100')
            break
        end
    end

    return coin
end

--------------------------------------------------------------------------------------------------------------------------------------------
--
function GLogicCheck:CalArmyFinish(info, dfInfo, isWiner, ret)
    ret = ret or {}

    local rankLevelCfg = CfgPracticeRankLevel[info.rank_level]
    if not rankLevelCfg then
        LogWarning('CfgPracticeRankLevel[info.rank_level] err:%s', info.rank_level)
        return
    end

    local defendRankLevelCfg = CfgPracticeRankLevel[dfInfo.rank_level]
    if not defendRankLevelCfg then
        LogWarning('CfgPracticeRankLevel[dfInfo.rank_level] err:%s', dfInfo.rank_level)
        return
    end

    ret.addExp = 0
    ret.chageScore = 0
    ret.addArmyIcon = 0

    if isWiner then
        ret.chageScore = GCalHelp:GetArmyAddScore(info.score, dfInfo.score)

        info.score = info.score + ret.chageScore

        -- 计算段位
        local addCoin = GLogicCheck:CalRankLevel(info)

        if addCoin then
            ret.addArmyIcon = ret.addArmyIcon + addCoin
        end

        ret.addArmyIcon = ret.addArmyIcon + rankLevelCfg.nWinGetCoin
    else
        ret.addArmyIcon = ret.addArmyIcon + rankLevelCfg.nLostGetCoin
    end

    if isWiner then
        ret.addExp = defendRankLevelCfg.nWinGetExp
    else
        ret.addExp = defendRankLevelCfg.nLostGetExp
    end

    return ret
end


function GLogicCheck:IsPassRule(ruleId, plr, itemId)
    if not ruleId or ruleId == 0 then
        return true
    end

    local cfg = CfgOpenRules[ruleId]
    if not cfg then
        return false, cfg
    end

    -- OpenRuleType = {}
    -- OpenRuleType.Lv = 1 -- 1：等级
    -- OpenRuleType.DupId = 2 -- 2：关卡
    -- OpenRuleType.NewPlrSetp = 3 -- 3：新手步骤( 基地开启不支持这个类型)
    -- OpenRuleType.Add = 4 -- 4：购买等其他外部添加

    if cfg.type == OpenRuleType.Lv then
        return plr:Get('level') >= cfg.val, cfg
    end

    if cfg.type == OpenRuleType.DupId then
        return plr:IsPassDup(cfg.val), cfg
    end

    if cfg.type == OpenRuleType.Add then
        return itemId == cfg.val, cfg
    end

    return false, cfg
end



