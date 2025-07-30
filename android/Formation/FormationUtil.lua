local this = {}

this.gridSize = {230, 230}; -- 格子大小2D
this.grid3DSize = {1.88, 1.88}; -- 格子大小3D
this.gridPadding = 5; -- 格子间隔
this.grid3DPadding = 0.02; -- 格子间隔3D
this.bgIcons = {"white", "green", "blue", "purple", "yellow"}

-- 卡牌类型站位点,一个类型的卡牌所有能用的格子坐标
this.CardPos = {};
-- 占用单个格子
this.CardPos[FormationType.Single] = {{1, 1}, {1, 2}, {1, 3}, {2, 1}, {2, 2}, {2, 3}, {3, 1}, {3, 2}, {3, 3}};
-- 横向占用两个格子，父物体为右上角的格子的对齐坐标
this.CardPos[FormationType.VDouble] = {{1, 1}, {1, 2}, {2, 1}, {2, 2}, {3, 1}, {3, 2}};
-- 纵向占用两个格子，父物体为右上角的格子的对齐坐标
this.CardPos[FormationType.HDouble] = {{1, 1}, {1, 2}, {1, 3}, {2, 1}, {2, 2}, {2, 3}};
-- 占用四格
this.CardPos[FormationType.Square] = {{1, 1}, {1, 2}, {2, 1}, {2, 2}};
-- 占用三格
this.CardPos[FormationType.VThree] = {{1, 1}, {2, 1}, {3, 1}};
-- 占用三格
this.CardPos[FormationType.HThree] = {{1, 1}, {1, 2}, {1, 3}};
-- 占用2*3
this.CardPos[FormationType.VDThree] = {{1, 1}, {2, 1}}
-- 占用9
this.CardPos[FormationType.Nine] = {{1, 1}}

-- FormationType排序索引
this.FormationTypeSort = {}
this.FormationTypeSort[FormationType.Single] = 0;
this.FormationTypeSort[FormationType.HDouble] = 1;
this.FormationTypeSort[FormationType.VDouble] = 2;
this.FormationTypeSort[FormationType.Square] = 3;
this.FormationTypeSort[FormationType.HThree] = 4;
this.FormationTypeSort[FormationType.VThree] = 5;
this.FormationTypeSort[FormationType.VDThree] = 6;
this.FormationTypeSort[FormationType.Nine] = 7;

this.SkillModuleKey = "PlayerAbility";
this.AIModuleKey = "special7";

this.orderList = { -- 编队类型对应的配置下标
    [eTeamType.DungeonFight] = 1, -- 副本队伍列表,队伍ID是1-8
    [eTeamType.Assistance] = 1, -- 助战队伍信息，自己分享的助战卡牌列表
    [eTeamType.PracticeAttack] = 2, -- 军演练习攻击队伍
    [eTeamType.PracticeDefine] = 3, -- 军演练习防御队伍
    [eTeamType.RealPracticeAttack] = 2, -- 实时军演攻击队伍
    [eTeamType.GuildFight] = 4, -- 公会战队伍
    [eTeamType.TeamBoss] = 5, -- 组队boss队伍
    [eTeamType.Preset] = 1, -- 队伍预设索引起始值，从30开始到36
    [eTeamType.ForceFight] = 1, -- 强制上阵索引起始值
    [eTeamType.Tower]=6,
    [eTeamType.TowerDifficulty]=6,
    [eTeamType.Rogue]=6,
    [eTeamType.TotalBattle]=6,
}

-- 返回占用类型
function this.GetFormationType(gridId)
    local type = FormationType.Single;
    for k, v in pairs(FormationType) do
        if gridId == v then
            type = v;
            break
        end
    end
    return type;
end

function this.GetGridWH(type)
    local size = {0, 0};
    if type == nil or type == FormationType.Single then
        size = {1, 1}
    elseif type == FormationType.VDouble then
        size = {1, 2}
    elseif type == FormationType.HDouble then
        size = {2, 1}
    elseif type == FormationType.Square then
        size = {2, 2}
    elseif type == FormationType.HThree then
        size = {3, 1}
    elseif type == FormationType.VThree or type == FormationType.Summon then
        size = {1, 3}
    elseif type == FormationType.Nine then
        size = {3, 3}
    elseif type == FormationType.VDThree then
        size = {2, 3}
    end
    return size;
end

-- 返回格子
function this.GetGridSize(type, is3D)
    local size = {0, 0};
    local wh = this.GetGridWH(type);
    if is3D then
        size[1] = wh[1] * this.grid3DSize[1] + this.grid3DPadding * (wh[1] - 1)
        size[2] = wh[2] * this.grid3DSize[2] + this.grid3DPadding * (wh[2] - 1)
    else
        size[1] = wh[1] * this.gridSize[1] + this.gridPadding * (wh[1] - 1)
        size[2] = wh[2] * this.gridSize[2] + this.gridPadding * (wh[2] - 1)
    end
    return size;
end

function this.GetBgSize(type)
    local size = {0, 0};
    local wh = this.GetGridWH(type);
    size[1] = wh[1] * 220 + 10 * (wh[1] - 1)
    size[2] = wh[2] * 220 + 10 * (wh[2] - 1)
    return size;
end

-- 返回当前类型的格子所有占位的点
function this.GetCardCanMovePos(type)
    return this.CardPos[type] or nil;
end

-- TeamData根据FormationType进行排序
function this.SortInfoByType(a, b)
    if a.grids and b.grids then
        return this.FormationTypeSort[a.grids] > this.FormationTypeSort[b.grids];
    else
        return a.grids == nil;
    end
end

function this.LoadTipsIcon(icon, type)
    if type == 1 then -- 队长
        CSAPI.LoadImg(icon, "UIs/Formation/img_02_01.png", true, nil, true);
    elseif type == 3 then -- npc
        CSAPI.LoadImg(icon, "UIs/Formation/img_02_02.png", true, nil, true);
    elseif type == 2 then -- 支援
        CSAPI.LoadImg(icon, "UIs/Formation/img_02_02.png", true, nil, true);
    end
end

-- 格式化助战ID
function this.FormatAssitID(fuid, cid)
    if fuid and cid then
        return string.format("%s_%s", fuid, cid);
    end
end

function this.IsFirendCardID(cid)
    local strs = StringUtil:split(cid, "_");
    if strs ~= nil and tonumber(strs[1])~=nil and #strs > 1 then
        return true
    end
    return false;
end

-- 格式化NPCID
function this.FormatNPCID(cid)
    return "npc_" .. cid;
end

-- 返回助战卡牌的CID
function this.GetAssitCID(id)
    if id then
        local strs = StringUtil:split(id, "_");
        return strs[2];
    end
    return nil;
end

-- 读取2D的头像
function this.Load2DImg(go, cfg, gridType)
    if go and cfg then
        local type = FormationUtil.GetFormationType(gridType);
        local iconName = cfg.formation_icon;
        if type == nil or type == FormationType.Single then
            ResUtil.FormationIcon:Load(go, iconName .. "_N");
        else
            if cfg.ai_icon then
                ResUtil.RoleCardCustom:Load(go, cfg.ai_icon);
            else
                if type == FormationType.VDouble then
                    ResUtil.FormationIconV:Load(go, iconName .. "_V");
                elseif type == FormationType.HDouble then
                    ResUtil.FormationIconH:Load(go, iconName .. "_H");
                elseif type == FormationType.Square then
                    ResUtil.FormationIcon:Load(go, "Horizontal_10/" .. iconName .. "_H10");
                elseif type == FormationType.Nine then
                    ResUtil.RoleCardCustom:Load(go, "Horizontal_12/" .. iconName .. "_H12");
                elseif type == FormationType.HThree then
                    ResUtil.RoleCardCustom:Load(go, "Horizontal_9/" .. iconName .. "_H9");
                elseif type == FormationType.Summon or type == FormationType.VThree then
                    ResUtil.RoleCardCustom:Load(go, "Vertical_6/" .. iconName .. "_V6");
                elseif type == FormationType.VDThree then
                    ResUtil.RoleCardCustom:Load(go, "Vertical_13/" .. iconName .. "_V13");
                end
            end
        end
    end
end

---判断当前卡牌是否是NPC,并返回对应的key和id
---@param cid any
function this.CheckNPCID(cid)
    if cid then
        local strs = StringUtil:split(cid, "_");
        if strs and #strs>1 then
            if (tonumber(strs[1])~=nil) then
                return false,strs[1],strs[2];
            else
                return true,strs[1],strs[2];
            end
        end
    end
    return false,cid;
end

-- 查找队伍中的卡牌数据
function this.FindTeamCard(cid)
    if cid then
        local strs = StringUtil:split(cid, "_");
        if strs ~= nil and #strs > 1 then
            if strs[1] == "npc" then -- npc卡牌
                return this.FindNPC(tonumber(strs[2]));
            else
                local sectionId=TowerMgr:GetSectionId();
                -- 助战卡牌id
                return FriendMgr:GetAssistCardData(cid,sectionId);
            end
        else
            -- 正常的卡牌id
            return RoleMgr:GetData(cid);
        end
    end
    return nil;
end

function this.FindNPC(cid)
    if cid then
        local cardCfg = Cfgs.MonsterData:GetByID(cid)
        if cardCfg == nil then--or (cardCfg and cardCfg.numerical == nil) then
            return nil;
        end
        local newSkillDatas = {}
        local curSkillsID = cardCfg.jcSkills
        for i, v in ipairs(curSkillsID) do
            local cfg = Cfgs.skill:GetByID(v)
            table.insert(newSkillDatas, {
                id = curSkillsID[i],
                exp = 0,
                type = SkillMainType.CardNormal
            })
        end
        -- 被动技能
        local sSkillID = cardCfg.tfSkills and cardCfg.tfSkills[1] or nil
        table.insert(newSkillDatas, {
            id = sSkillID,
            exp = 0,
            type = SkillMainType.CardTalent
        })
        --特殊技能
        local tSkillID = cardCfg.tcSkills and cardCfg.tcSkills[1] or nil
        if(tSkillID)then 
            table.insert(newSkillDatas, {
                id = tSkillID,
                exp = 0,
                type = SkillMainType.CardSpecial
            })
        end 
        local newInfo = {};
        newInfo.cid = this.FormatNPCID(cid) -- 自定义NPC的id
        newInfo.cfgid = cid
        newInfo.break_level = cardCfg.break_level or 1
        newInfo.intensify_level = 1
        newInfo.level = cardCfg.level or 1;
        newInfo.skills = newSkillDatas;

        local monsterCardsData = require "MonsterCardsData"
        newData = MonsterCardsData(newInfo)
        return newData;
    end
    return nil;
end

function this.GetPlaceHolderInfo(grids)
    local placeHolderInfo = nil;
    if grids ~= nil then
        local cfgFormation = Cfgs.MonsterFormation:GetByID(grids);
        if (cfgFormation) then
            placeHolderInfo = {};
            for _, v in ipairs(cfgFormation.coordinate) do
                table.insert(placeHolderInfo, {v[1] + 1, v[2] + 1});
            end
        else
            LogError("MonsterFormation找不到占位数据" .. grids);
        end
    else
        placeHolderInfo = {{1, 1}};
    end
    return placeHolderInfo;
end

-- 读取卡牌加成的光环数值
function this.CountHaloAdd(cfgId)
    local infos = {};
    if cfgId then
        local haloCfg = Cfgs.cfgHalo:GetByID(cfgId);
        if haloCfg then
            for k, v in ipairs(haloCfg.use_types) do
                local attrCfg = Cfgs.CfgCardPropertyEnum:GetByID(v);
                if attrCfg then
                    local num = haloCfg[attrCfg.sFieldName] or 0;
                    infos[v] = infos[v] or {
                        val1 = 0
                    };
                    infos[v].id = v;
                    infos[v].val1 = infos[v].val1 + num;
                end
            end
        end
    end
    local adds = {};
    for k, v in pairs(infos) do
        table.insert(adds, v);
    end
    table.sort(adds, function(a, b)
        return a.id < b.id;
    end);
    return adds;
end

-- 计算卡牌受到的光环加成,teamData:TeamData,item:TeamItemData,队员数据,row,col:阵型坐标，不传的话读取item中的row和col
function this.CountHaloGet(teamData, item, row, col)
    -- 遍历当前队伍中的所有卡牌光环坐标，记录其中包含该坐标的信息
    local infos = {};
    if item then
        row = row == nil and item.row or row;
        col = col == nil and item.col or col;
        local coord = FormationUtil.GetPlaceHolderInfo(item:GetGrids());
        for k, v in ipairs(teamData.data) do
            if v.cfg and v.cfg.halo then
                local haloCfg = Cfgs.cfgHalo:GetByID(v.cfg.halo[1]);
                if haloCfg and v.cid ~= item:GetID() then
                    local node = haloCfg.coordinate[1];
                    for i = 2, #haloCfg.coordinate do
                        local r = haloCfg.coordinate[i][1] - node[1] + v.row;
                        local c = haloCfg.coordinate[i][2] - node[2] + v.col;
                        -- 屏蔽自身的光环效果
                        local isAdd = false;
                        for key, val in ipairs(coord) do
                            local isAddClass = false; -- 是否是生效的小队
                            for _, val1 in ipairs(haloCfg.nClass) do
                                if val1 == 0 or val1 == item:GetCfg().nClass then
                                    isAddClass = true;
                                    break
                                end
                            end
                            if r == row + val[1] - 1 and c == col + val[2] - 1 and isAddClass then
                                -- 受到加成
                                for k1, v1 in ipairs(haloCfg.use_types) do
                                    local attrCfg = Cfgs.CfgCardPropertyEnum:GetByID(v1);
                                    if attrCfg then
                                        local num = haloCfg[attrCfg.sFieldName] or 0;
                                        infos[v1] = infos[v1] or {
                                            val1 = 0
                                        };
                                        infos[v1].id = v1; -- 属性类型
                                        infos[v1].val1 = infos[v1].val1 + num;
                                    end
                                end
                                isAdd = true;
                                break
                            end
                        end
                        if isAdd then
                            break
                        end
                    end
                end
            end
        end
    end
    local gets = {};
    for k, v in pairs(infos) do
        table.insert(gets, v);
    end
    table.sort(gets, function(a, b)
        return a.id < b.id;
    end);
    return gets;
end

function this.GetHaloGridColor(type)
    -- 设置当前格子颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,5：可以放置,6:无法放置，7：当前选中角色
    local color = {255, 255, 255, 0};
    if type == 1 or type == nil then
    elseif type == 2 or type == 4 then
        color = {255, 255, 255, 51};
    elseif type == 3 then
        color = {255, 170, 0, 51};
    elseif type == 5 then
        color = {19, 255, 46, 51}
    elseif type == 6 then
        color = {255, 20, 20, 51}
    elseif type == 7 then
        color = {255, 255, 255, 51}
    end
    return color;
end

function this.GetHalo2DGridColor(type)
    -- 设置当前格子颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,可以放置,6:无法放置7：当前选中角色
    local color = {255, 255, 255, 255};
    if type == 1 or type == nil then
    elseif type == 2 or type == 4 then
        color = {255, 255, 255, 255};
    elseif type == 3 then
        color = {255, 170, 0, 255};
    elseif type == 5 then
        color = {96, 255, 103, 255}
    elseif type == 6 then
        color = {255, 50, 50, 255}
    elseif type == 7 then
        color = {255, 255, 255, 255}
    end
    return color;
end

function this.GetHalo2DBorderColor(type)
    -- 设置当前格子边框颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,可以放置,6:无法放置7：当前选中角色
    local color = {255, 255, 255, 255};
    if type == 1 or type == nil then
    elseif type == 2 or type == 4 then
        color = {255, 255, 255, 0};
    elseif type == 3 then
        color = {255, 193, 70, 76};
    elseif type == 5 then
        color = {96, 255, 103, 76}
    elseif type == 6 then
        color = {255, 11, 11, 76}
    elseif type == 7 then
        color = {255, 255, 255, 0}
    end
    return color;
end

function this.GetHaloNumColor(type)
    -- 设置当前上的数字颜色，1：空置，2：被占用，3：buff效果,4:非点击物效果,5：位置上已存在卡牌,6:无法放置
    local color = {255, 255, 255, 0};
    if type == 1 or type == nil then
        color = {255, 255, 255, 128};
    elseif type == 2 or type == 4 or type == 6 then
        color = {0, 0, 0, 204};
    elseif type == 3 or type == 5 then
        color = {255, 255, 255, 204};
    end
    return color;
end

function this.LookCard(cid)
    if cid == nil then
        LogError("查看卡牌信息时传入的卡牌id为nil！");
        return
    end
    local cardData = this.FindTeamCard(cid);
    if cardData == nil then
        LogError("找不到对应的卡牌数据！");
        return
    end
    local assistInfo = cardData.data and cardData.data.assist or nil;
    if assistInfo then
        if assistInfo.isFull then -- 已经获取了card数据
            CSAPI.OpenView("RoleInfo", cardData)
        else
            local curId = cardData:GetID()
            local strs = StringUtil:split(curId, "_");
            if strs then
                FriendMgr:SetAssistInfos(tonumber(strs[1]), {tonumber(strs[2])}, function()
                    cardData = this.FindTeamCard(curId);
                    assistInfo.isFull = true;
                    CSAPI.OpenView("RoleInfo", cardData)
                end);
            end
        end
    else
        -- local openType=RoleInfoOpenType.Normal;
        -- if this.CheckNPCID(cid) then
        -- 	openType=RoleInfoOpenType.LookOther
        -- end
        -- CSAPI.OpenView("RoleInfo", cardData,openType)
        CSAPI.OpenView("RoleInfo", cardData)
    end
end

-- 创建属性的方法 list:数据,itemList:存储对象的数组,parent：父节点
function this.CreateAttrs(list, itemList, parent, showName)
    local num = 1;
    for k, v in ipairs(list) do
        local tab = nil;
        local data = {};
        data.id = v.id;
        if v.id ~= 4 then -- 除速度外所有加成以百分比显示
            data.val = string.match(v.val1 * 100, "%d+") .. "%";
        else
            data.val = v.val1;
        end
        data.hideName = not showName;
        if num > #itemList then
            -- 创建item
            ResUtil:CreateUIGOAsync("AttributeNew2/AttributeItemMini", parent, function(go)
                tab = ComUtil.GetLuaTable(go);
                tab.Refresh(data);
                table.insert(itemList, tab);
            end);
        else
            tab = itemList[num];
            CSAPI.SetGOActive(tab.gameObject, true);
            tab.Refresh(data);
        end
        num = num + 1;
    end
    for i = num, #itemList do
        CSAPI.SetGOActive(itemList[i].gameObject, false);
    end
end

-- 计算两个矩形相交形成的新矩形的宽，高，不相交则返回0 minOffset:矩形左下角的点坐标，maxOffset:矩形右上角的点坐标
function this.CountInterSize(minOffsetA, maxOffsetA, minOffsetB, maxOffsetB)
    -- 相交区域的宽高
    local minOffsetC = {math.max(minOffsetA[1], minOffsetB[1]), math.max(minOffsetA[2], minOffsetB[2])};
    local maxOffsetC = {math.min(maxOffsetA[1], maxOffsetB[1]), math.min(maxOffsetA[2], maxOffsetB[2])};
    if minOffsetC[1] > maxOffsetC[1] or minOffsetC[2] > maxOffsetC[2] then
        return 0, 0;
    else
        local width = maxOffsetC[1] - minOffsetC[1];
        local height = maxOffsetC[2] - minOffsetC[2];
        -- Log(minOffsetC[1].."\t"..minOffsetC[2].."\t"..maxOffsetC[1].."\t"..maxOffsetC[2]);
        -- Log(width.."\t"..height);
        return width, height;
    end
end

-- Debug查看判定范围
function this.DrawMatix2D(min, max, gameObject)
    local a = gameObject.transform:TransformPoint(UnityEngine.Vector3(min[1], max[2], 0));
    local b = gameObject.transform:TransformPoint(UnityEngine.Vector3(min[1], min[2], 0));
    local c = gameObject.transform:TransformPoint(UnityEngine.Vector3(max[1], max[2], 0));
    local d = gameObject.transform:TransformPoint(UnityEngine.Vector3(max[1], min[2], 0));
    DrawLine(a, b);
    DrawLine(a, c);
    DrawLine(b, d);
    DrawLine(c, d);
end

--- func 根据队伍ID返回配置方案下标
---@param index 队伍索引
function this.GetOrderByTeamIndex(index)
    local type = TeamMgr:GetTeamType(index)
    if this.orderList[type]~=nil then
        return this.orderList[type];
    elseif index==61 then
        return nil;
    else
        return 6;
    end
end

function this.GetTowerCardInfo(cid,uid,teamIndex)
    local sId=7001
    if teamIndex==eTeamType.TowerDifficulty then
        sId=7002;
    end
    return TowerMgr:GetCardInfo(cid,uid,sId);
end

-- 删除耐久度为0的队员（爬塔用）
function this.CleanDeathTowerMember(teamData,sectionID)
    if teamData ~= nil then
        local removeIDs = {}
        for i = 1, 6 do
            local item = teamData:GetItemByIndex(i);
            if item ~= nil then
                local cardInfo = nil;
                local cardData = item:GetCard();
                if item:IsAssist() then
                    local assistData = cardData:GetAssistData()
                    cardInfo = this.GetTowerCardInfo(cardData:GetData().old_cid, assistData.uid,teamData:GetIndex());
                else
                    cardInfo = this.GetTowerCardInfo(cardData:GetID(),nil,teamData:GetIndex());
                end
                if cardInfo ~= nil and cardInfo.tower_hp <= 0 then
                    table.insert(removeIDs, item:GetID())
                end
            end
        end
        if removeIDs and #removeIDs > 0 then
            for k, v in ipairs(removeIDs) do
                teamData:RemoveCard(v);
            end
        end
    end
end

--删除无法使用的队员
function this.CleanTotalBattleMember(teamData)
    if teamData ~= nil then
        local removeIDs = {}
        for i = 1, 6 do
            local item = teamData:GetItemByIndex(i);
            if item ~= nil then
                local isRemove=TotalBattleMgr:IsShowCard(item:GetID());
                if isRemove~=true then
                    table.insert(removeIDs, item:GetID())
                end
            end
        end
        if removeIDs and #removeIDs > 0 then
            for k, v in ipairs(removeIDs) do
                teamData:RemoveCard(v);
            end
        end
    end
end

function this.GetDefaultName(teamIndex,name)
    local teamName = name;
    local teamType = TeamMgr:GetTeamType(teamIndex);
    if teamType == eTeamType.Rogue then
        teamName = LanguageMgr:GetByID(50028);
    elseif teamType==eTeamType.TotalBattle then
        teamName = LanguageMgr:GetByID(51007);
    elseif teamType == eTeamType.Tower or teamType==eTeamType.TowerDifficulty then
        teamName = LanguageMgr:GetByID(49021);
    elseif teamType==eTeamType.Colosseum or teamType==(eTeamType.Colosseum+1) then
        teamName = LanguageMgr:GetByID(64047)
    elseif teamType==eTeamType.RogueT then
        teamName = LanguageMgr:GetByID(54053)
    elseif teamType==eTeamType.MultBattle then
        teamName = LanguageMgr:GetByID(77038)
    elseif teamName==nil or teamName=="" then
        teamName = string.format(LanguageMgr:GetTips(14017), teamIndex)
    end
    return teamName;
end

--返回强制上阵卡牌配置ID
function this.GetNForceID(forceCfg)
    local nForceID=nil;
    if forceCfg==nil then
        return nForceID;
    end
    local cfg=Cfgs.CardData:GetByID(forceCfg.nForceID);
	if cfg and cfg.role_tag=="lead" and forceCfg.bIsNpc~=true then --队长需要另外判断
		local nForceID=forceCfg.nForceID;
		if RoleMgr:IsSexInitCardIDs(nForceID) then--判断当前卡牌是否是主角卡，是的话替换为当前性别的对应卡牌ID
			nForceID=RoleMgr:GetCurrSexCardCfgId();
		end
    elseif forceCfg.bIsNpc==true then
        if #forceCfg.nForceID==1 then
            nForceID=forceCfg.nForceID[1]
        else
            local idx=PlayerClient:GetSex();
            nForceID=forceCfg.nForceID[idx];
        end
    end
    return nForceID;
end

return this;
