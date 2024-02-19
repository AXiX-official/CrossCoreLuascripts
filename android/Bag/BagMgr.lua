-- 背包管理
local this = MgrRegister("BagMgr")

-- 设置数据
function this:SetData(bagData)
    self.datas = nil;
    self.arr = nil;
    if (bagData and bagData.item) then
        for index, data in ipairs(bagData.item) do
            self:UpdateGoodsData(data);
        end
        EventMgr.Dispatch(EventType.Bag_Update)
    end
    self:CheckBagRedInfo();
end
-- 更新数据
function this:UpdateData(newData)
    self.arr = nil;

    if (newData and newData.data) then
        for _, data in ipairs(newData.data) do
            self:UpdateGoodsData(data, true);
        end
        EventMgr.Dispatch(EventType.Bag_Update)
    end
    self:CheckBagRedInfo();
end

-- 更新物品数据
function this:UpdateGoodsData(data, setNew)
    self.datas = self.datas or {}
    if (self:UpdateCoin(data) == false) then
        local goodsData = self:GetData(data.id);
        if (goodsData) then
            if (data.num and data.num <= 0) then
                -- 移除                
                self:RemoveGoods(data.id);
            else
                -- 更新
                for k, v in pairs(data) do
                    goodsData:GetData()[k] = v; -- mo 
                end
            end
        else
            -- 新增物品
            goodsData = GoodsData(data);
            self.datas[data.id] = goodsData;
            if (setNew) then
                self:SetNewState(data.id, true);
            end
        end
    end
end

-- 更新货币类
function this:UpdateCoin(data)
    -- 角色存储经验
    if (data.id == ITEM_ID.CARD_STORE_EXP) then
        RoleMgr:UpdateStoreExp(data.num)
        return true
    elseif (data.id == g_ArmyCoinId) then
        PlayerClient:UpdateCoin(data.id, data.num)
        return true
    elseif (data.id == g_AbilityCoinId) then      
        PlayerClient:UpdateCoin(data.id, data.num)
		PlayerAbilityMgr:CheckRedPointData()
        return true
    else
        for i, v in pairs(ITEM_ID) do
            if (data.id == v) then
                PlayerClient:UpdateCoin(data.id, data.num)
                return true
            end
        end
    end
    return false
end

-- 是否新物品
function this:IsNew(id)
    return self.news and self.news[id] or false;
end
function this:SetNewState(id, state)
    self.news = self.news or {};
    self.news[id] = state;
end

-- 移除物品
function this:RemoveGoods(id)
    if (self.datas) then
        self.datas[id] = nil;
    end
end

-- 获取数据
function this:GetData(_id)
    if (_id == nil) then
        LogError("获取物品失败！！id无效" .. tostring(_id));
    end
    local _b, _num = self:IsCoin(_id)
    if (_b) then
        local data = {
            id = _id,
            num = _num
        }
        local goodsData = GoodsData(data)
        return goodsData
    elseif (self.datas) then
        return self.datas[_id];
    end
    return nil;
end

--检查是否显示背包红点
function this:CheckBagRedInfo()
	local tagValue=nil;
    if self.datas then
        for k, v in pairs(self.datas) do
            if v:GetCfgTag()==5 then --5是消耗品,将需要显示红点的tag值加入数组
                tagValue=tagValue or {};
                table.insert(tagValue,v:GetCfgTag());
                break;
            end
        end
    end
	local data=tagValue~=nil and {tagList=tagValue} or nil
    RedPointMgr:UpdateData(RedPointType.MaterialBag,data);
end

-- ==============================--
-- desc:是否是货币类型，数量
-- time:2019-09-17 10:54:01
-- @id:
-- @return 
-- ==============================--
function this:IsCoin(id)
    for i, v in pairs(ITEM_ID) do
        if (v == id) then
            return true, PlayerClient:GetCoin(id)
        end
    end
    if id == g_AbilityCoinId or id == g_ArmyCoinId then
        return true, PlayerClient:GetCoin(id);
    end
    return false, 0
end

-- 通过类型获取数据
function this:GetDataByType(type)
    local newArr = {}
    if (self.datas) then
        for _, v in pairs(self.datas) do
            if (v:GetType() == type) then
                table.insert(newArr, v)
            end
        end
    end
    return newArr
end

-- 通过类型获取数据 字典
function this:GetDataByTypeDic(type)
    local newDic = {}
    if (self.datas) then
        for _, v in pairs(self.datas) do
            if (v:GetType() == type) then
                newDic[v:GetID()] = v
            end
        end
    end
    return newDic
end

-- 获取数据,字典型
function this:GetDatas()
    return self.datas;
end
-- 获取数据，数组型
function this:GetArr()
    if (self.arr == nil) then
        if (self.datas) then
            self.arr = {};
            for _, data in pairs(self.datas) do
                if (data) then
                    table.insert(self.arr, data);
                end
            end
        end
    end

    return self.arr;
end

-- 数量
function this:Count()
    return self.arr and #self.arr or 0;
end

-- 设置选中的标签索引
function this:SetSelTabIndex(index)
    self.tabIndex = index;
end
-- 获取选中的标签索引
function this:GetSelTabIndex()
    return self.tabIndex or 1;
end

-- 设置选中的子标签索引
function this:SetSelChildTabIndex(index)
    self.childTabIndex = index;
end

-- 返回选中的子标签索引
function this:GetSelChildTabIndex()
    return self.childTabIndex or 1;
end

function this:SetEquipSelectCond(cond)
    self.selectEquipCond = cond;
end

function this:GetEquipSelectCond()
    return self.selectEquipCond or nil;
end

-- 设置一个假数据
function this:GetFakeData(cfgId, _num)
    _num = _num==nil and self:GetCount(cfgId) or _num
    return GoodsData({id = cfgId, num = _num});
end

-- -- 设置一个假数据
-- function this:GetFakeData(cfgId, _num)
--     local _data = self:GetData(cfgId)
--     _num = _num or 0
--     if (_data) then
--         return _data
--     else
--         local data = {
--             id = cfgId,
--             num = _num
--         }
--         local goodsData = GoodsData(data)
--         return goodsData
--     end
-- end
-- 获取物品数量
function this:GetCount(id)
    if (id == nil) then
        LogError("获取物品失败！！id无效");
        return 0
    end
    local _b, _num = self.IsCoin(id)
    if (_b) then
        return _num
    else
        return BagMgr:GetData(id) and BagMgr:GetData(id):GetCount() or 0
    end
end

function this:SetOrderType(order)
    self.orderType = order
end

function this:GetOrderType()
    return self.orderType == nil and 2 or self.orderType;
end

-- type:BagScreenDataType
function this:SetScreenData(condition)
    self.conditions = condition;
end

-- 返回物品列表缓存的筛选数据 type:BagScreenDataType
function this:GetScreenData()
    if self.conditions == nil then
        self.conditions = {
            Sort = {1},
            Type = {0}
        };
    end
    return self.conditions;
end

-- 通过物品表id获取数据
function this:GetDataByCfgID(cfgId)
    if (self.datas) then
        for _, v in pairs(self.datas) do
            if (v:GetCfgID() == cfgId) then
                return v;
            end
        end
    end
    return nil
end

-- 执行筛选
function this:DoScreen(dataList, condition)
    local arr = {};
    if (dataList) then
        for _, tag in ipairs(condition.Type) do
            for _, data in pairs(dataList) do
                if (data) then
                    local cfgGoods = data:GetCfg();
                    if cfgGoods and cfgGoods.hide == nil then
                        if (tag ~= 0 and cfgGoods.tag == tag) or (tag == 0 and cfgGoods.tag ~= 0) then
                            table.insert(arr, data);
                        end
                    end
                end
            end
        end
        table.sort(arr, function(a, b)
            if a:GetQuality() == b:GetQuality() then
                return a:GetID() < b:GetID();
            else
                return a:GetQuality() > b:GetQuality()
            end
        end);
    end
    return arr;
end

-- 返回卡牌素材 isCountNum:是否减去升级所需
function this:GetCardElems(isCountNum)
    local list = self:GetDataByType(ITEM_TYPE.CARD_CORE_ELEM);
    if list and isCountNum then
        local l = {};
        for k, v in ipairs(list) do
            local info = self:GetCardCore(v:GetID(), isCountNum)
            if info and v:GetCfg().dy_arr and info:GetCount() > 0 then -- v:GetCfg().dy_arr用于判断是通用星源还是角色星源
                table.insert(l, info);
            end
        end
        return l;
    else
        return list;
    end
end

function this:GetCardCore(goodsId, isCountNum)
    if goodsId == nil then
        return nil;
    end
    local v = self:GetData(goodsId);
    if v == nil then
        return nil;
    elseif isCountNum then
        local cids = v:GetCfg().dy_arr;
        if cids ~= nil then
            local n = v:GetCount();
            for _, val in ipairs(cids) do
                local cards = RoleMgr:GetCardsByCfgID(val);
                if cards and #cards >= 1 then
                    for _, card in ipairs(cards) do
                        local num = GCalHelp:GetCardNeedCoreItemCnt(card:GetCfgID(), card:GetCoreLv(),
                            card:GetData().skills);
                        if num then
                            n = n - num;
                        end
                    end
                end
            end
            if n > 0 then
                return GoodsData({
                    id = v:GetCfgID(),
                    num = n
                });
            else
                return GoodsData({
                    id = v:GetCfgID(),
                    num = 0
                });
            end
        else
            return v;
        end
    else
        return v;
    end
end

function this:Clear()
    self.datas = nil;
    self.arr = nil;
    self.news = nil;
    self.selectEquipCond = nil;
    self.tabIndex = nil;
    self.conditions = nil;
end

return this;
